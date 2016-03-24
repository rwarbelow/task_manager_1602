require 'yaml/store'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    # database.from(:tasks).insert(:title => task[:title], :description => task[:description])
    database.from(:tasks).insert(task)
    # database.transaction do
    #   database['tasks'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['tasks'] << { "id" => database['total'], "title" => task[:title], "description" => task[:description] }
    # end
  end

  def raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def update(id, task)
    database.transaction do
      target = database['tasks'].find { |data| data["id"] == id }
      target["title"] = task[:title]
      target["description"] = task[:description]
    end
  end

  def destroy(id)
    database.transaction do
      database['tasks'].delete_if { |task| task["id"] == id }
    end
  end

  def delete_all
    database.from(:tasks).delete
  end

  def all
    raw_tasks.map { |data| Task.new(data) }
  end

  # def raw_task(id)
  #   raw_tasks.find { |task| task["id"] == id }
  # end

  def find(id)
    raw_task = database.from(:tasks).where(:id => id).to_a.first
    Task.new(raw_task)
  end
end
