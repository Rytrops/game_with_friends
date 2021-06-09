import React, { useState, useEffect } from 'react';
import { useHistory } from 'react-router-dom';
import axios from 'axios';
import {
  Container,
  Button,
  Row,
  Col,
  Card,
  Form,
  Alert,
} from 'react-bootstrap';

const ManageAccount = (props) => {
  const user = JSON.parse(localStorage.getItem('USER'));
  const userPage = props.match.params.id;
  const history = useHistory();
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const [loaded, setLoaded] = useState(false);

  function validateForm() {
    return email.length > 0 && password.length > 0 && username.length > 0;
  }

  const authAxios = axios.create({
    headers: {
      Authorization: `Bearer ${localStorage.getItem('JWT')}`,
    },
  });

  function handleSubmit(e) {
    e.preventDefault();
    authAxios
      .patch(`/api/v1/users/${user.id}`, {
        user: { email, username, password },
      })
      .then((resp) => {
        return authAxios
          .post('/api/v1/users/sign-in', { user: { email, password } })
          .then((resp) => {
            localStorage.setItem('JWT', resp.data.token);
            localStorage.setItem('USER', JSON.stringify(resp.data.user));

            history.push(`/${user.id}/profile`, {
              state: {
                errorNotification: 'Account Succesfully Updated!',
              },
            });
            window.location.reload();
          });
      })
      .catch((error) => {
        setErrorMessage(error.response.data.error);
      });
  }

  const isAllowedUser = () => {
    if (user == null) {
      return history.push('/sign-in', {
        state: {
          errorNotification: 'You must be logged in to access this page.',
        },
      });
    } else if (user.id != userPage) {
      return history.push('/', {
        state: {
          errorNotification: 'You not authorized to edit this page.',
        },
      });
    } else {
      setUsername(user.username);
      setEmail(user.email);
      setLoaded(true);
    }
  };

  useEffect(() => {
    isAllowedUser();
  }, []);

  const alertError = () => {
    return (
      <Alert
        variant='danger'
        className='text-center'
        onClose={() => setErrorMessage('')}
        dismissible
      >
        {Object.keys(errorMessage).map((key) => {
          return (
            <dl key={key}>
              <dt> {key}</dt>
              <dd> {errorMessage[key]} </dd>
            </dl>
          );
        })}
      </Alert>
    );
  };

  return (
    <div className='bg-secondary vh-100'>
      <div>{errorMessage !== '' && alertError()} </div>
      {loaded && (
        <Container className='border-light'>
          <Row className='mx-auto'>
            <Col className='col-4 mx-auto mt-5 h-100'>
              <Card className='bg-light '>
                <Card.Title className='text-center'>
                  Update Account Information:
                </Card.Title>
                <Form onSubmit={handleSubmit} className='text-center bd-danger'>
                  <Form.Group className='px-3' size='lg' controlId='email'>
                    <Form.Label>Email</Form.Label>
                    <Form.Control
                      autoFocus
                      type='email'
                      defaultValue={email}
                      onChange={(e) => setEmail(e.target.value)}
                    />
                  </Form.Group>

                  <Form.Group className='px-3' size='lg' controlId='password'>
                    <Form.Label>Password</Form.Label>
                    <Form.Control
                      type='password'
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                    />
                  </Form.Group>

                  <Form.Group className='px-3' size='lg' controlId='username'>
                    <Form.Label>Username</Form.Label>
                    <Form.Control
                      type='username'
                      defaultValue={username}
                      onChange={(e) => setUsername(e.target.value)}
                    />
                  </Form.Group>

                  <Button
                    variant='dark'
                    size='lg'
                    type='submit'
                    disabled={!validateForm()}
                  >
                    Update Information
                  </Button>
                </Form>
              </Card>
            </Col>
          </Row>
        </Container>
      )}
    </div>
  );
};

export default ManageAccount;
