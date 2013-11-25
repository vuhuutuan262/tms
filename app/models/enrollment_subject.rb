class EnrollmentSubject < ActiveRecord::Base
	DONE = "done"

	belongs_to :enrollment
	belongs_to :subject
	has_many :enrollment_tasks
  has_many :activities, foreign_key: "subject_id", class_name: Activity.name

  accepts_nested_attributes_for :enrollment_tasks
 
  scope :finished_subject, ->{where status: DONE}
  scope :current_enrollment_subject, ->subject_id{where subject_id: subject_id}
 
	def finish_subject!
		self.update_attributes! status: DONE
	end

	def done?
		self.status == DONE
	end

	def end_date
		self.start_date + self.subject.duration.day
	end
end