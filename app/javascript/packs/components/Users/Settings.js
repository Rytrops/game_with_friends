import React from 'react';
import {
  Container,
  Button,
  Row,
  Col,
  Card,
  Table,
  Alert,
} from 'react-bootstrap';

const Settings = () => {
  const user = JSON.parse(localStorage.getItem('USER'));

  return (
    <Container className='vh-100'>
      <Row>
        <Col className='col-12 align-item-right'>
          <Card className='bg-light border-black '>
            <Card.Title className='text-center text-secondary'>
              Account Management:
            </Card.Title>
            <Card.Body>
              <Button
                href={`/${user.id}/settings`}
                variant='secondary'
                size='sm'
                block
              >
                Account Settings
              </Button>
              <Button variant='secondary' size='sm' block>
                Add Game to Library
              </Button>
              <Button variant='secondary' size='sm' block>
                Link Steam Account
              </Button>
              <Button variant='secondary' size='sm' block>
                Import Steam Library
              </Button>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default Settings;
