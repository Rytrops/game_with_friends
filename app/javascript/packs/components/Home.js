import React, { useState } from 'react';
import { Container, Button, Row, Col, Card } from 'react-bootstrap';
import { BrowserRouter as Router, Link } from 'react-router-dom';

const Home = (props) => {
  const [errorMessage, setErrorMessage] = useState('');

  return (
    <div className='bg-secondary vh-100'>
      <Container className='text-center  d-flex mt-5'>
        <Row className='mt-5 mx-auto w-100'>
          <Col>
            <Card>
              <Card.Body className='bg-light'>
                <Card.Title className='text-secondary'>
                  <h1 className=' font-weight-bold p'>Game With Friends</h1>
                </Card.Title>

                <Card.Subtitle>
                  <p className='text-muted '>Helping Gamers Play Together.</p>
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
