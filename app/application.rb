require_relative "../app/item.rb"
class Application
    @@items = []
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last #strip path info to capture just the item
            item = @@items.find { |i| i.name == item_name}
            if item
                resp.write  item.price
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end
      
        resp.finish
    end
end