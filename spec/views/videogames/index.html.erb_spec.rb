require 'rails_helper'

RSpec.describe "videogames/index", type: :view do
  before(:each) do
    assign(:videogames, [
      Videogame.create!(
        game_: "Game ",
        name: "Name",
        developer: "Developer",
        game_type: "Game Type",
        number_of_players: ""
      ),
      Videogame.create!(
        game_: "Game ",
        name: "Name",
        developer: "Developer",
        game_type: "Game Type",
        number_of_players: ""
      )
    ])
  end

  it "renders a list of videogames" do
    render
    assert_select "tr>td", text: "Game ".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Developer".to_s, count: 2
    assert_select "tr>td", text: "Game Type".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
