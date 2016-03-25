require_relative "../test_helper"

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_task
    task_manager.create({
      :title       => "Task Title",
      :description => "Task Description"
    })

    task = task_manager.all.last

    assert_equal "Task Title", task.title
    assert_equal "Task Description", task.description
  end

  def test_it_can_find_all_tasks
    create_tasks(3)

    all_tasks = task_manager.all

    assert_equal Array, all_tasks.class
    assert_equal 3, all_tasks.size
    assert_equal "Task Title 1", all_tasks.first.title
    assert_equal "Task Title 3", all_tasks.last.title
  end

  def test_it_can_find_a_specific_task
    create_tasks(5)

    id1, id2, id3, id4, id5 = task_manager.all.map { |task| task.id }

    task1 = task_manager.find(id1)

    assert_equal "Task Title 1", task1.title
    assert_equal "Task Description 1", task1.description

    task3 = task_manager.find(id3)

    assert_equal "Task Title 3", task3.title
    assert_equal "Task Description 3", task3.description
  end

  def test_it_can_update_an_existing_task
    create_tasks(1)

    task = task_manager.all.last

    assert_equal "Task Title 1", task.title
    assert_equal "Task Description 1", task.description

    updated_task_info = {title: "New Task Title",
                        description: "New Task Description"}

    task_manager.update(task.id, updated_task_info)

    task = task_manager.all.last

    assert_equal "New Task Title", task.title
    assert_equal "New Task Description", task.description
  end

  def test_it_can_destroy_a_task
    create_tasks(1)

    all_tasks = task_manager.all

    assert_equal 1, all_tasks.size
    assert all_tasks.any? { |task| task.title == "Task Title 1" }

    task_manager.destroy(all_tasks.last.id)

    all_tasks = task_manager.all

    assert_equal 0, all_tasks.size
    refute all_tasks.any? { |task| task.title == "Task Title 1" }
  end
end
