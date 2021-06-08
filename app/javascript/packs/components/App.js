import React from 'react';
import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import Profile from './Users/Profile';
import Home from './Home';
import SignIn from './Signin';
import Navibar from './Navbar';
import SignUp from './Signup';
import ManageAccount from './Users/ManageAccount';

// const authAxios = axiosApi.create({
//   baseURL: 'http://localhost:3000/api/v1',
// });

const App = () => {
  return (
    <div className='bg-secondary vh-100'>
      <Router>
        <Navibar />
        <Switch>
          <Route exact path='/' component={Home} />
          <Route path='/sign-in' component={SignIn} />
          <Route path='/sign-up' component={SignUp} />
          <Route path='/:id/profile' component={Profile} />
          <Route path='/:id/settings' component={ManageAccount} />
        </Switch>
      </Router>
    </div>
  );
};
export default App;
