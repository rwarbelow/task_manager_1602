require_relative "../test_helper"

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_task
    task_manager.create({
      :title       => "Task Title",
      :description => "Task Description"
      })

    task = task_manager.find(1)

    assert_equal "Task Title", task.title
    assert_equal "Task Description", task.description
    assert_equal 1, task.id
  end

  def test_it_can_find_all_tasks
    create_tasks(4)

    all_tasks = task_manager.all

    assert_equal Array, all_tasks.class
    assert_equal 4, all_tasks.size
    assert_equal "Task Title 1", all_tasks.first.title
    assert_equal "Task Title 4", all_tasks.last.title
  end

  def test_it_can_find_a_specific_task
    create_tasks(5)

    task1 = task_manager.find(1)

    assert_equal "Task Title 1", task1.title
    assert_equal "Task Description 1", task1.description

    task3 = task_manager.find(3)

    assert_equal "Task Title 3", task3.title
    assert_equal "Task Description 3", task3.description
  end

  def test_it_can_update_an_existing_task
    create_tasks

    task = task_manager.find(1)

    assert_equal "Task Title 1", task.title
    assert_equal "Task Description 1", task.description

    updated_task_info = {title: "New Task Title",
                        description: "New Task Description"}

    task_manager.update(1, updated_task_info)

    task = task_manager.find(1)

    assert_equal "New Task Title", task.title
    assert_equal "New Task Description", task.description
  end

  def test_it_can_destroy_a_task
    create_tasks

    all_tasks = task_manager.all

    assert_equal 2, all_tasks.size
    assert all_tasks.any? { |task| task.title == "Task Title 1" }

    task_manager.destroy(1)

    assert_equal 1, all_tasks.size
    refute all_tasks.any? { |task| task.title == "Task Title 1" }
  end
end
