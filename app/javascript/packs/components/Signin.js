import React, { useState } from 'react';
import { Container, Button, Row, Col, Card, Form } from 'react-bootstrap';
import axios from 'axios';

// import './Login.css';

// const axios = axios.create({
//   baseURL: 'http://localhost:3000/api/v1',
// });

export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  console.log(axios.defaults.headers.common['Authorization']);
  console.log(localStorage.getItem('JWT'));

  function validateForm() {
    return email.length > 0 && password.length > 0;
  }

  function handleSubmit(event) {
    event.preventDefault();
    axios
      .post('/api/v1/users/sign-in', { user: { email, password } })
      .then((resp) => {
        localStorage.setItem('JWT', resp.data.token);
        localStorage.setItem('USER', JSON.stringify(resp.data.user));
      })
      .catch((resp) => {
        console.log(resp);
      });
    if (JSON.parse(localStorage.getItem('USER')) !== null) {
      setAuth();
    }
  }

  return (
    <Container className='border-light'>
      <Row className='mx-auto'>
        <Col className='col-4 mx-auto mt-5 h-100'>
          <Card className='bg-light '>
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
  );
}
