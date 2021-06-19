import React, { useState, useEffect } from 'react';
import { Container, Button, Row, Col, Card, Alert } from 'react-bootstrap';
import { BrowserRouter as Router, Link } from 'react-router-dom';

const Home = (props) => {
  const [errorMessage, setErrorMessage] = useState('');

  const checkErrorMessage = () => {
    if (props.location.state) {
      setErrorMessage(Object.values(props.location.state.state));
    }
  };

  useEffect(() => {
    checkErrorMessage();
  }, []);

  const alertError = () => {
    return (
      <Alert
        variant='danger'
        className='text-center'
        onClose={() => setErrorMessage('')}
        dismissible
      >
        {errorMessage}
      </Alert>
    );
  };

  return (
    <div className='bg-secondary vh-100'>
      <div>{errorMessage !== '' && alertError()} </div>
      <Container className='text-center  d-flex mt-5'>
        <Row className='mt-5 mx-auto w-100'>
          <Col>
            <Card>
              <Card.Body className='bg-light'>
                <Card.Title className='text-secondary'>
                  <h1 className=' font-weight-bold p'>Game With Friends</h1>
                </Card.Title>

                <Card.Subtitle>
                  <p className='text-muted '>Helping Gamers Stay Organized.</p>
                </Card.Subtitle>
                <Link to='/sign-in'>
                  <Button
                    type='button'
                    className='mr-2'
                    variant='secondary'
                    size='sm'
                  >
                    Sign in
                  </Button>
                </Link>
                <Link to='/sign-up'>
                  <Button
                    type='button'
                    className='ml-2'
                    variant='secondary'
                    size='sm'
                  >
                    Sign Up
                  </Button>
                </Link>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Container>
    </div>
  );
};
export default Home;
