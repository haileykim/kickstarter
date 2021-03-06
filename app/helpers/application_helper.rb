module ApplicationHelper

def image_for(project)
  if project.image.exists?
    image_tag(project.image.url, class: 'main-image')
  else
    image_tag('placeholder.png')
  end
end

def page_title
  if content_for?(:title)
  	"Kickstarter - #{content_for(:title)}"
  else
  	"Kickstarter"
  end

end

end
