class Application
  @@item = []

  def intialize
    @@all.each do |item|
      @@item << item
    end
  end

  def self.items=(item)
    @@item << item
  end

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      # binding.pry
      item_name = req.path.split("/items/").last #turn /songs/Sorry into Sorry
      item = @@item.find{|i| i.name == item_name}
      # binding.pry
      if item == nil
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write item.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

  # def item_not_found(resp, req)
  #   resp.status = 400
  #   resp.write "Item not found"
  #   # binding.pry
  # end
end
