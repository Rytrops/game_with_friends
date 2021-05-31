import React from 'react';
import { Container, Button, Row, Col, Card } from 'react-bootstrap';

const Home = () => {
  return (
    <div className='bg bg-dark vh-100'>
      <Container className='text-center bg bg-dark d-flex h-100 '>
        <Row className='my-auto mx-auto w-100'>
          <Col>
            <Card>
              <Card.Body className='bg-dark'>
                <Card.Title className='text-secondary'>
                  <h1 className=' font-weight-bold p'>Game With Friends</h1>
                </Card.Title>

                <Card.Subtitle>
                  <p className='text-muted '>Helping Gamers Play Together.</p>
                </Card.Subtitle>
                <Button
                  type='button'
                  className='mr-2'
                  variant='secondary'
                  size='sm'
                >
                  Sign in
                </Button>
                <Button
                  type='button'
                  className='ml-2'
                  variant='secondary'
                  size='sm'
                >
                  Sign Up
                </Button>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Container>
    </div>
  );

  // <div class='container text-center border border-dark bg-light'>
  //   <div class='row '>
  //     <div class='col mx-auto'>
  //       <div class='card-body'>
  //         <h1 class=' font-weight-bold '>Game With Friends</h1>

  //         <p class='text-muted '>Helping Gamers Play Together.</p>

  //         <button type='button' class='btn btn-outline-secondary btn-sm'>
  //           {' '}
  //           link_to 'Sign In', new_user_session_path, class: 'btn'{' '}
  //         </button>
  //         <button type='button' class='btn btn-outline-secondary btn-sm'>
  //           {' '}
  //           link_to 'Sign Up', new_user_registration_path, class: 'btn'{' '}
  //         </button>
  //       </div>
  //     </div>
  //   </div>
  // </div>;
};
export default Home;
