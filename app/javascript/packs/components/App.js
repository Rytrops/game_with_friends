import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import Profile from './Users/Profile';
import Home from './Home';
import SignIn from './Signin';
import Navibar from './Navbar';
import SignUp from './Signup';
import ManageAccount from './Users/ManageAccount';
import LinkSteamAcct from './Users/LinkSteamAcct';
import ImportSteamLibrary from './Users/ImportSteamLibrary';

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
          <Route path='/:id/link-steam-account' component={LinkSteamAcct} />
          <Route
            path='/:id/import-steam-library'
            component={ImportSteamLibrary}
          />
        </Switch>
      </Router>
    </div>
  );
};
export default App;
