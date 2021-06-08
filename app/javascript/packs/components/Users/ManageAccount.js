import React, { useState } from 'react';
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

const ManageAccount = () => {
  const user = JSON.parse(localStorage.getItem('USER'));
  const [username, setUsername] = useState(user.username);
  const [email, setEmail] = useState(user.email);
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  function validateForm() {
    return email.length > 0 && password.length > 0 && username.length > 0;
  }

  function handleSubmit(e) {
    e.preventDefault();
    axios
      .post('/api/v1/users', { user: { email, password, username } })
      .then((resp) => {
        return axios
          .post('/api/v1/users/sign-in', { user: { email, password } })
          .then((resp) => {
            localStorage.setItem('JWT', resp.data.token);
            localStorage.setItem('USER', JSON.stringify(resp.data.user));
            history.push('/');
            window.location.reload();
          });
      })
      .catch((error) => {
        setErrorMessage(error.response.data.error);
      });
  }

  const isCorrectUser = () => {};
  return (
    <div className='bg-secondary vh-100'>
      <div>{errorMessage !== '' && alertError()}` </div>
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
                    value={email}
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
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                  />
                </Form.Group>

                <Button
                  variant='dark'
                  size='lg'
                  type='submit'
                  disabled={!validateForm()}
                >
                  Login
                </Button>
              </Form>
            </Card>
          </Col>
        </Row>
      </Container>
    </div>
  );
};

export default ManageAccount;
