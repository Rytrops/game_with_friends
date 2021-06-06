import React from 'react';
import {
  Navbar,
  Nav,
  Form,
  Link,
  Button,
  NavDropdown,
  Fragment,
} from 'react-bootstrap';

const Navibar = () => {
  const user = JSON.parse(localStorage.getItem('USER'));

  const handleSubmit = (e) => {
    e.preventdefault;
    localStorage.clear();
  };
  return (
    <Navbar bg='dark' expand='md'>
      <Navbar.Brand href='/'>Game With Friends</Navbar.Brand>
      <Navbar.Toggle aria-controls='basic-navbar-nav' />
      <Navbar.Collapse id='basic-navbar-nav'>
        {user && (
          <>
            <div className='ml-auto'>
              <NavDropdown
                title={user.username}
                id='basic-nav-dropdown'
                variant='secondary'
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
              </NavDropdown>
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
        )}
      </Navbar.Collapse>
    </Navbar>
  );
};

export default Navibar;
