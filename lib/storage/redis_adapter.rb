class Storage::RedisAdapter < SimpleDelegator
  def initialize
    __setobj__(REDIS)
  end

  def get key
    REDIS.get [Storage::PREFIX, key].join
  end

  def set url, id=nil
    _id = ((id.present? and !(used=used?(id)) and id) || generate_id).tap do |id|
      REDIS.set [Storage::PREFIX, id].join, url
    end
    [_id, used]
  end

  private
  def generate_id
    count = 2
    begin
      @hex = SecureRandom.hex[0..(rand(count.to_i))]
      count += 0.3
    end while used?(@hex)
    @hex
  end

  def used? id
    !(hex=get(id)).nil? || hex && !hex.empty?
  end
end
