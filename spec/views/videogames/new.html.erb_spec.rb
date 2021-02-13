require 'rails_helper'

RSpec.describe "videogames/new", type: :view do
  before(:each) do
    assign(:videogame, Videogame.new(
      game_: "MyString",
      name: "MyString",
      developer: "MyString",
      game_type: "MyString",
      number_of_players: ""
    ))
  end

  it "renders new videogame form" do
    render

    assert_select "form[action=?][method=?]", videogames_path, "post" do

      assert_select "input[name=?]", "videogame[game_]"

      assert_select "input[name=?]", "videogame[name]"

      assert_select "input[name=?]", "videogame[developer]"

      assert_select "input[name=?]", "videogame[game_type]"

      assert_select "input[name=?]", "videogame[number_of_players]"
    end
  end
end
