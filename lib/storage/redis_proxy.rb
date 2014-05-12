class Storage::RedisProxy
  def get key
    REDIS.get [Storage::PREFIX, key].join
  end

  def set url
    generate_id.tap do |id|
      REDIS.set [Storage::PREFIX, id].join, url
    end
  end

  private
  def generate_id
    count = 2
    begin
      @hex = SecureRandom.hex[0..(rand(count.to_i))]
      count += 0.3
    end while !(hex=get(@hex)).nil? || hex && hex.empty?
    @hex
  end
end