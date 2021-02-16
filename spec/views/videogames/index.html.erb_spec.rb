require 'rails_helper'

RSpec.describe "videogames/index", type: :view do
  before(:each) do
    assign(:videogames, [
      Videogame.create!(
        game_name: "Game Name",
        developer: "Developer",
        number_of_players: 2
      ),
      Videogame.create!(
        game_name: "Game Name",
        developer: "Developer",
        number_of_players: 2
      )
    ])
  end

  it "renders a list of videogames" do
    render
    assert_select "tr>td", text: "Game Name".to_s, count: 2
    assert_select "tr>td", text: "Developer".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
