require_relative "../test_helper"

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_it_returns_all_tasks
    create_tasks(3)

    all = task_manager.all
    assert_equal Array, all.class
    assert_equal 3, all.length
    assert_equal Task, all[0].class
    assert_equal "Task Title 1", all[0].title
    assert_equal "Task Title 2", all[1].title
    assert_equal "Task Title 3", all[2].title
  end

  def test_it_can_find_a_specific_task
    create_tasks(2)

    task = task_manager.find(2)
    assert_equal 2, task.id
    assert_equal "Task Title 2", task.title
    assert_equal "Task Description 2", task.description
  end

  def test_task_manager_can_update_a_task
   task_manager.create({
     :title => "Task Title",
     :description => "Task Description"
     })

   updated_task_details = {
     :title => "Updated Task Title",
     :description => "Updated Task Description"
     }

   task = task_manager.find(1)

   assert_equal "Task Title", task.title
   assert_equal "Task Description", task.description
   assert_equal 1, task.id

   task_manager.update(1, updated_task_details)

   task = task_manager.find(1)

   assert_equal "Updated Task Title", task.title
   assert_equal "Updated Task Description", task.description
   assert_equal 1, task.id
 end


end
