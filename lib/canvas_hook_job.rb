class CanvasHookJob < Struct.new( :job, :params )
  def perform
    eval "#{job} params"
  end
end
