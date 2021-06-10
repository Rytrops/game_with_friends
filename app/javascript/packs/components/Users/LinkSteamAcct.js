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

const LinkSteamAcct = (props) => {
  const [steamUrl, setSteamUrl] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const user = JSON.parse(localStorage.getItem('USER'));
  const userPage = props.match.params.id;
  const history = useHistory();

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
    }
  };

  useEffect(() => {
    isAllowedUser();
  }, []);

  function validateForm() {
    return steamUrl.length > 0;
  }
  const authAxios = axios.create({
    headers: {
      Authorization: `Bearer ${localStorage.getItem('JWT')}`,
    },
  });

  function handleSubmit(e) {
    e.preventDefault();
    authAxios
      .post(`/api/v1/users/${user.id}/connect_steam_account`, {
        user: { steamUrl },
      })
      .then((resp) => {
        history.push(`/${user.id}/profile`, {
          state: {
            successNotification: 'Account Succesfully Updated!',
          },
        });
        window.location.reload();
      })
      .catch((error) => {
        console.log(error.response.data.error);
        setErrorMessage(error.response.data.error);
      });
  }
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
        {Object.values(errorMessage)}
      </Alert>
    );
  };
  return (
    <>
      <div>{errorMessage !== '' && alertError()} </div>
      <Container className='border-light'>
        <Row className='mx-auto'>
          <Col className='col-5 mx-auto mt-5 h-100'>
            <Card className='bg-light '>
              <Card.Title className='text-center'>
                Link Steam Account
              </Card.Title>
              <Form onSubmit={handleSubmit} className='text-center bd-danger'>
                <Form.Group className='px-3' size='lg' controlId='steamurl'>
                  <Form.Label>Steam Profile URL</Form.Label>
                  <Form.Control
                    autoFocus
                    type='text'
                    value={steamUrl}
                    placeholder='https://steamcommunity.com/profiles/123456789'
                    onChange={(e) => setSteamUrl(e.target.value)}
                  />
                </Form.Group>

                <Button
                  variant='dark'
                  size='lg'
                  type='submit'
                  disabled={!validateForm()}
                >
                  Link Steam Account
                </Button>
              </Form>
            </Card>
          </Col>
        </Row>
      </Container>
    </>
  );
};

export default LinkSteamAcct;
