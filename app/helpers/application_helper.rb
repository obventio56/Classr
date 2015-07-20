module ApplicationHelper

  def destroy_field(f)
    f.hidden_field(:_destroy, :class => 'cloneable')
  end

  def cloneable_fields(f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association.to_s.singularize}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, :clone => true)
    end
    fields
  end
end
