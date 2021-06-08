import React from 'react';
import { useState, useEffect } from 'react';
import axios from 'axios';
import { Container, Button, Row, Col, Card, Table } from 'react-bootstrap';
import { useHistory } from 'react-router-dom';

const Users = (props) => {
  const [user, setUser] = useState([]);
  const [userVideogames, setUserVideogames] = useState([]);
  const [loaded, setLoaded] = useState(false);

  const id = props.match.params.id;
  const url = loaded && user.attributes.steam_url;

  const authAxios = axios.create({
    headers: {
      Authorization: `Bearer ${localStorage.getItem('JWT')}`,
    },
  });

  useEffect(() => {
    authAxios
      .get(`/api/v1/users/${id}.json`, {})
      .then((resp) => {
        setUser(resp.data.data);
        setUserVideogames(resp.data.included);
        setLoaded(true);
      })
      .catch((resp) => console.log(resp));
  }, [id]);

  const loggedIn = () => {
    const user = JSON.parse(localStorage.getItem('USER'));
    const history = useHistory();
    if (user === null) {
      return history.push('/');
    }
  };

  return (
    <div className='bg-secondary vh-100'>
      {loggedIn()}
      <Container className='vh-100'>
        <Row className='justify-content-center'>
          <Col className=' col-auto text-center border border-dark rounded bg-light mt-5 text-secondary mb-5'>
            {loaded && (
              <h1> Welcome to {user.attributes.username}'s profile</h1>
            )}
          </Col>
        </Row>
        <Row>
          <Col className='col-3'>
            <Card className='bg-light border-black '>
              <Card.Title className='text-center text-secondary'>
                Contact Info:
              </Card.Title>
              <Card.Body>
                <h6>Username: {loaded && user.attributes.username}</h6>
                {/* <a href={`#/systemlist?projId=${project.id}`}>{project.name}</a> */}
                <h6>Steam Profile: </h6>
                {loaded && (
                  <a href={`${user.attributes.steam_url}`} target='blank'>
                    View my Steam Profile
                  </a>
                )}
                <h6>Email: {loaded && user.attributes.email}</h6>
              </Card.Body>
            </Card>
          </Col>
          <Col>
            <Table className='text-light'>
              <thead>
                <tr>
                  <th>Game Name</th>
                  <th>Number of Players</th>
                  <th>Developer</th>
                </tr>
              </thead>
              <tbody>
                {loaded &&
                  userVideogames.map((game) => {
                    const { game_name, number_of_players, developer } =
                      game.attributes;
                    return (
                      <tr key={game.id}>
                        <td> {game_name}</td>
                        <td> {number_of_players}</td>
                        <td> {developer}</td>
                      </tr>
                    );
                  })}
              </tbody>
            </Table>
          </Col>
        </Row>
      </Container>
    </div>
  );
};

export default Users;

{
  /* <div class="container pb-5">  
  <div class="row justify-content-center">
    <% if @looking_at_self %>
        <div class="col-auto"
        <button type="button"> <%= link_to "Edit User", edit_user_path(@user),class: "btn btn-sm btn-secondary"%>  </button>
        </div>
        <div class="col-auto">
          <button type="button"
            <%= link_to "Delete User", user_path(@user), class: "btn btn-sm btn-danger",
                            method: :delete,
                            data: { confirm: "Are you sure?" } %>
          </button>
        </div>
      <% end %>

  </div>
</div>

    

        <div class="card-body">
        <p <a class="font-weight-bold"> Email Address: </a> <a class = "font-weight-normal"> <%= @user.email%> </a> </p>

        <p <a class="font-weight-bold" > Steam Profile: </a>  <%= link_to @user.steam_id, @user.steam_url, class: 'font-weight-normal' %> </p>

        <p class="font-weight-bold tp-2"> Steam Vanity: </p> <%=  @user.steam_vanity %> 

        </div> 

    </div>
  
    <div class="col-8 justify-content-center">
        <table class="table table-light ">
        <thead class="thead-dark"
        <tr>
        <th scope="col"> Game Name</th>
        <th>Developer </th>
        <th>Number of Players</th>
        <% if @looking_at_self %>
        <th> <button type="btn "> <%= link_to "Add Game to Library", user_add_game_path(@user), class: "btn btn-sm bt-dark" %> </button> </th>
        <% else %>
        <th></th>
        <% end %>
        </tr>
        </thead>
        <% @user.videogames.each do |game| %>
            <tr>
            <td><%= link_to "#{game.game_name}", videogame_path(game) %></td>
            <td><%= game.developer %></td>
            <td><%= game.number_of_players %></td>
            <% if @looking_at_self %>
                <td> <%= button_to "Remove from library", user_remove_game_path(@user), params: {game_id: game.id}, data: {confirm: "Are you sure?"} %></td>
            <% end %>
                </tr>
        <%end%>
    </table>
    </div>
    
  </div>
</div> */
}
