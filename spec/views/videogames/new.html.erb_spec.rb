require 'rails_helper'

RSpec.describe "videogames/new", type: :view do
  before(:each) do
    assign(:videogame, Videogame.new(
      game_name: "MyString",
      developer: "MyString",
      number_of_players: 1
    ))
  end

  it "renders new videogame form" do
    render

    assert_select "form[action=?][method=?]", videogames_path, "post" do

      assert_select "input[name=?]", "videogame[game_name]"

      assert_select "input[name=?]", "videogame[developer]"

      assert_select "input[name=?]", "videogame[number_of_players]"
    end
  end
end
