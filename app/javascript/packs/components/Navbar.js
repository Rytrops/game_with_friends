import React from 'react';
import {
  Navbar,
  Nav,
  Form,
  Link,
  Button,
  NavDropdown,
  Fragment,
  DropdownButton,
} from 'react-bootstrap';
import { useHistory } from 'react-router-dom';

const Navibar = () => {
  const user = JSON.parse(localStorage.getItem('USER'));
  const history = useHistory();

  const handleSubmit = (e) => {
    e.preventdefault;
    localStorage.clear();
    history.push('/');
    window.location.reload(false);
  };
  return (
    <Navbar bg='dark' expand='md'>
      <Navbar.Brand className='text-light' href='/'>
        Game With Friends
      </Navbar.Brand>
      <Navbar.Toggle aria-controls='basic-navbar-nav' />
      <Navbar.Collapse id='basic-navbar-nav'>
        {user ? (
          <>
            <div className='ml-auto pr-2'>
              <DropdownButton
                title={user.username}
                id='basic-nav-dropdown'
                variant='secondary'
                size='sm'
                className='text-secondary'
              >
                <NavDropdown.Item href={`/${user.id}/profile`}>
                  My Profile
                </NavDropdown.Item>
                <NavDropdown.Item href='#action/3.2'>
                  Another action
                </NavDropdown.Item>
                <NavDropdown.Item href='#action/3.3'>
                  Something
                </NavDropdown.Item>
                <NavDropdown.Divider />
                <NavDropdown.Item href='#action/3.4'>
                  Separated link
                </NavDropdown.Item>
              </DropdownButton>
            </div>

            <Button
              size='sm'
              variant='secondary'
              type='submit'
              onClick={handleSubmit}
            >
              Sign Out
            </Button>
          </>
        ) : (
          <>
            <Nav.Link href='/sign-in' className='ml-auto'>
              <Button
                type='button'
                className='mr-2'
                variant='secondary'
                size='sm'
              >
                Sign in
              </Button>
            </Nav.Link>
            <Nav.Link href='/sign-up'>
              <Button
                type='button'
                className='ml-2'
                variant='secondary'
                size='sm'
              >
                Sign Up
              </Button>
            </Nav.Link>
          </>
        )}
      </Navbar.Collapse>
    </Navbar>
  );
};

export default Navibar;
