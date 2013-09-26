class CanvasHook
  include Singleton

  def self.instance
    return @@instance ||= new
  end

  def register_callback( hook_method, callback )
    registrations[hook_method] << callback
  end

  def after_create_user user
    registrations[:before_create_user].each do |c|
      job = CanvasHookJob.new(c,user)
      Delayed::Job.enqueue job
    end
  end

  def before_save_course course
    registrations[:before_save_course].each do |c|
      job = CanvasHookJob.new(c,course)
      Delayed::Job.enqueue job
    end
  end

  def after_course_activation course
    registrations[:after_course_activation].each do |c|
      job = CanvasHookJob.new(c,course)
      Delayed::Job.enqueue job
    end
  end

  def before_save_enrollment enrollment
    registrations[:before_save_enrollment].each do |c|
      job = CanvasHookJob.new(c,enrollment)
      Delayed::Job.enqueue job
    end
  end

  def after_quiz_snapshot submission
    registrations[:after_quiz_snapshot].each do |c|
      job = CanvasHookJob.new(c,submission)
      Delayed::Job.enqueue job
    end
  end

  def after_save_quiz_submission submission
    registrations[:after_save_quiz_submission].each do |c|
      job = CanvasHookJob.new(c,submission)
      Delayed::Job.enqueue job
    end
  end


  def registrations
    return @@registrations ||= Hash.new { |h,k| h[k] = [] }
  end

end
