import React from 'react';
import { Container, Button, Row, Col, Card } from 'react-bootstrap';
import axios from 'axios';

const Settings = (props) => {
  const user = JSON.parse(localStorage.getItem('USER'));

  return (
    <Container className='vh-100'>
      {props.isAuthorizedUser && (
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

                <Button
                  href={`/${user.id}/link-steam-account`}
                  variant='secondary'
                  size='sm'
                  block
                >
                  Link Steam Account
                </Button>
                <Button
                  variant='secondary'
                  size='sm'
                  block
                  href={`/${user.id}/import-steam-library`}
                >
                  Import Steam Library
                </Button>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      )}
    </Container>
  );
};

export default Settings;
