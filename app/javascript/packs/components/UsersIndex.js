import React from 'react';
import { useState, useEffect } from 'react';
import axios from 'axios';

const Users = () => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    axios
      .get('/api/v1/users.json')
      .then((resp) => {
        setUsers(resp.data.data);
      })
      .catch((resp) => console.log(resp));
  }, [users.length]);

  const userList = users.map((user) => {
    return <li key={user.attributes.id}>{user.attributes.username}</li>;
  });
  return <ul>{userList}</ul>;
};

export default Users;
