import React from 'react';
import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import Profile from './Users/Profile';
import Home from './Home';
import Signin from './Signin';

const App = () => {
  return (
    <div className='bg bg-dark vh-100'>
      <Router>
        <Switch>
          <Route exact path='/' component={Home} />
          <Route path='/sign-in'>
            <Signin />
          </Route>
          <Route path='/:id/profile' component={Profile}></Route>
        </Switch>
      </Router>
    </div>
  );
};
export default App;
