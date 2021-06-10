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

const ImportSteamLibrary = () => {
  const [errorMessage, setErrorMessage] = useState('');

  const user = JSON.parse(localStorage.getItem('USER'));

  const authAxios = axios.create({
    headers: {
      Authorization: `Bearer ${localStorage.getItem('JWT')}`,
    },
  });

  function handleSubmitImportSteamLibary(e) {
    e.preventDefault();
    authAxios
      .post(`/api/v1/users/${user.id}/import_steam_library`)
      .then((resp) => {
        history.push(`/`, {
          state: {
            successNotification:
              'Importing Steam library. This may take a few moments.',
          },
        });
        window.location.reload();
      })
      .catch((error) => {
        setErrorMessage(error.response.data.error);
      });
  }
  console.log(user);
  return (
    <>
      {/* <div>{errorMessage !== '' && alertError()} </div> */}
      <Container className='border-light'>
        <Row className='mx-auto'>
          <Col className='col-5 mx-auto mt-5 h-100'>
            <Card className='bg-light '>
              <Card.Title className='text-center'>
                Import Steam Library
              </Card.Title>
              <Form className='text-center bd-danger'>
                <Form.Group className='px-3' size='lg' controlId='steamurl'>
                  Make sure you Steam profile is set to public. This process may
                  take a few moments
                </Form.Group>

                <Button
                  variant='dark'
                  size='lg'
                  type='submit'
                  onClick={handleSubmitImportSteamLibary}
                >
                  Import Steam Library
                </Button>
              </Form>
            </Card>
          </Col>
        </Row>
      </Container>
      ;
    </>
  );
};

export default ImportSteamLibrary;
