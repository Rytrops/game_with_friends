import React from 'react';
import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import Profile from './Users/Profile';
import Home from './Home';
import Signin from './Signin';
import Navibar from './Navbar';
import Axios from 'axios';
// const authAxios = axiosApi.create({
//   baseURL: 'http://localhost:3000/api/v1',
// });

const App = () => {
  return (
      <Router>
        <Navibar />
          <div className='bg-secondary vh-100'></div>
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
