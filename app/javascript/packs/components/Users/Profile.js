import React from 'react';
import { useState, useEffect } from 'react';
import axios from 'axios';
import {
  Container,
  Row,
  Col,
  Card,
  Table,
  Alert,
  Overflow,
} from 'react-bootstrap';
import { useHistory, Redirect } from 'react-router-dom';
import Settings from './Settings';
const Users = (props) => {
  const [user, setUser] = useState([]);
  const [userVideogames, setUserVideogames] = useState([]);
  const [loaded, setLoaded] = useState(false);
  const [successMessage, setSuccessMessage] = useState('');
  const history = useHistory();

  const id = props.match.params.id;

  const authAxios = axios.create({
    headers: {
      Authorization: `Bearer ${localStorage.getItem('JWT')}`,
    },
  });

  useEffect(() => {
    authAxios
      .get(`/api/v1/users/${id}.json`, {})
      .then((resp) => {
        setUser(resp.data.data);
        setUserVideogames(resp.data.included);
        setLoaded(true);
      })
      .catch((error) => {
        return <Redirect to='/' />;
      });
  }, [id]);

  const loggedIn = () => {
    const user = JSON.parse(localStorage.getItem('USER'));
    if (user === null) {
      return history.push('/sign-in', {
        state: {
          errorNotification: 'You must be logged in to access this page',
        },
      });
    }
  };

  const checkSuccessMessage = () => {
    if (props.location.state) {
      setSuccessMessage(Object.values(props.location.state.state));
    }
  };

  useEffect(() => {
    checkSuccessMessage();
  }, []);

  const alertSuccess = () => {
    return (
      <Alert
        variant='success'
        className='text-center'
        onClose={() => setSuccessMessage('')}
        dismissible
      >
        {successMessage}
      </Alert>
    );
  };

  return (
    <div className='bg-secondary vh-100'>
      {loggedIn()}
      <div>{successMessage && alertSuccess()}</div>
      {loaded && (
        <Container className='vh-100'>
          <Row className='justify-content-center'>
            <Col className=' col-auto text-center border border-dark rounded bg-light mt-5 text-secondary mb-5'>
              <h1> Welcome to {user.attributes.username}'s profile</h1>
            </Col>
          </Row>
          <Row>
            <Col className='col-3'>
              <Card className='bg-light border-black '>
                <Card.Title className='text-center text-secondary'>
                  Contact Info:
                </Card.Title>
                <Card.Body>
                  <h6>Username: {user.attributes.username}</h6>
                  {user.attributes.steam_url && (
                    <div>
                      <h6>Steam Profile: </h6>
                      <a href={`${user.attributes.steam_url}`} target='blank'>
                        View my Steam Profile
                      </a>
                    </div>
                  )}

                  <h6>Email: {user.attributes.email}</h6>
                </Card.Body>
              </Card>
            </Col>
            <Col className='col-6' style={{ height: 400 }}>
              <div style={{ height: 400, overflow: scroll }}>
                help
                <Table
                  scrollable='true'
                  className='text-light scrollable'
                  bordered='true'
                  style={{ color: 'red' }}
                >
                  <thead>
                    <tr>
                      <th>Game Name</th>
                      {/* <th>Number of Players</th> */}
                      <th>Developer</th>
                    </tr>
                  </thead>
                  <tbody style={{ height: 400 }}>
                    {loaded &&
                      userVideogames.map((game) => {
                        const { game_name, number_of_players, developer } =
                          game.attributes;
                        return (
                          <tr key={game.id}>
                            <td> {game_name}</td>
                            {/* <td> {number_of_players}</td> */}
                            <td> {developer}</td>
                          </tr>
                        );
                      })}
                  </tbody>
                </Table>
              </div>
            </Col>
            <Col>
              <Settings />
            </Col>
          </Row>
        </Container>
      )}
    </div>
  );
};

export default Users;
