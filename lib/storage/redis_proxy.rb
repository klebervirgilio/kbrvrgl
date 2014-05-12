class Storage::RedisProxy
  def redis
    @redis ||= Redis.new
  end

  def get key
    redis.get [Storage::PREFIX, key].join
  end

  def set url
    generate_id.tap do |id|
      redis.set [Storage::PREFIX, id].join, url
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