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
  Button,
} from 'react-bootstrap';
import { useHistory, Redirect } from 'react-router-dom';
import Settings from './Settings';
import TableScrollbar from 'react-table-scrollbar';

const Users = (props) => {
  const [user, setUser] = useState([]);
  const [userVideogames, setUserVideogames] = useState([]);
  const [loaded, setLoaded] = useState(false);
  const [successMessage, setSuccessMessage] = useState('');
  const [isAuthorizedUser, setIsAuthorizedUser] = useState(false);

  const history = useHistory();
  const loggedInUser = JSON.parse(localStorage.getItem('USER'));
  const id = props.match.params.id;
  const gamesArray = [];

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
        buildGamesArray();
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
  const buildGamesArray = () => {
    userVideogames.map((game) => {
      const { game_name, number_of_players, developer } = game.attributes;
      return gamesArray.push(game_name);
    });
  };

  useEffect(() => {
    buildGamesArray();
  }, []);

  const authorizedUser = () => {
    if (loggedInUser.id == id && !isAuthorizedUser) {
      setIsAuthorizedUser(true);
    }
  };

  return (
    <>
      <div className='bg-secondary vh-100'>
        {loggedIn()}
        {loaded && authorizedUser()}
        {loaded && buildGamesArray()}

        <div>{successMessage && alertSuccess()}</div>
        {loaded && (
          <Container>
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
              <Col className='col-6'>
                <TableScrollbar rows={7}>
                  <Table
                    className='text-light text-center '
                    bordered='true'
                    variant='dark'
                  >
                    <thead>
                      <tr>
                        <th>Game Name</th>
                      </tr>
                    </thead>
                    <tbody>
                      {gamesArray.sort().map((game_name) => {
                        return (
                          <tr key={game_name}>
                            <td> {game_name}</td>
                          </tr>
                        );
                      })}
                    </tbody>
                  </Table>
                </TableScrollbar>
              </Col>
              <Col>
                <Settings isAuthorizedUser={isAuthorizedUser} />
              </Col>
            </Row>
          </Container>
        )}
      </div>
      <div className='bg-secondary' style={{ height: 200 }}></div>
    </>
  );
};

export default Users;
