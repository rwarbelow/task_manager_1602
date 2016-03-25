require 'yaml/store'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.from(:tasks).insert(task)
  end

  def update(id, task)
    database.from(:tasks).where(id: id).update(task)
  end

  def destroy(id)
    database.from(:tasks).where(id: id).delete
  end

  def delete_all
    database.from(:tasks).delete
  end

  def all
    database.from(:tasks).map { |data| Task.new(data) }
  end

  def find(id)
    raw_task = database.from(:tasks).where(:id => id).to_a.first
    Task.new(raw_task)
  end
end
