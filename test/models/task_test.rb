require_relative '../test_helper'

class TaskTest < Minitest::Test
  def test_assigns_attributes_correctly
    task = Task.new({ "title" => "Task Title",
                      "description" => "Task Description",
                      "id" => 1 })

    assert_equal "Task Title", task.title
    assert_equal "Task Description", task.description
    assert_equal 1, task.id
  end
end
