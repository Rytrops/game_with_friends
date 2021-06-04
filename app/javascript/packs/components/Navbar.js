import React from 'react';
import { Navbar, Nav, Form, Link, Button } from 'react-bootstrap';

const Navibar = () => {
  return (
    <Navbar bg='light'>
      <Button className='border'>
        <Navbar.Brand href='/'>Game With Friends</Navbar.Brand>
      </Button>
      <Navbar.Toggle aria-controls='basic-navbar-nav' />
    </Navbar>
  );
};

export default Navibar;
