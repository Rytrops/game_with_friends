require 'rails_helper'

RSpec.describe "videogames/edit", type: :view do
  before(:each) do
    @videogame = assign(:videogame, Videogame.create!(
      game_name: "MyString",
      developer: "MyString",
      number_of_players: 1
    ))
  end

  it "renders the edit videogame form" do
    render

    assert_select "form[action=?][method=?]", videogame_path(@videogame), "post" do

      assert_select "input[name=?]", "videogame[game_name]"

      assert_select "input[name=?]", "videogame[developer]"

      assert_select "input[name=?]", "videogame[number_of_players]"
    end
  end
end
