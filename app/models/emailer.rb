class Emailer < ActionMailer::Base
  def request_to_review(review)
    recipients review.reviewer.email
    bcc        ["mfrosengarten@gmail.com"]
    from       "mfrosengarten@gmail.com"
    subject    "#{Course.last.title} Request for Peer Review of #{review.student.name}"
    body       :review => review
  end
  
  def review_submitted(review)
    recipients "mfrosengarten@gmail.com"
    from       "mfrosengarten@gmail.com"
    subject    "Review for #{review.student.name} submitted by #{review.reviewer.name}"
    body       :review => review
  end
  

end
