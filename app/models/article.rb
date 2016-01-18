class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
	before_save :set_visits_count #loinicializa en 0 visitas
	after_create :save_categories
	#entra a trabajar magic, y automaticamente las imagenes son editadas a X tamano
	has_attached_file :cover, styles: { medium: "1200x720", thumb:"800x600" }
	#para seguridad, tipo definido de archivos, expresion regular: puede subir distintas variaciones
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	#custom setter
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		self.save if self.visits_count.nil?
		self.update(visits_count: self.visits_count + 1)
	end
	private

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id,article_id: self.id)
		end
	end

	def set_visits_count
		#si es nulo le asigna 0, de lo contrario,nada
		self.visits_count ||= 0
	end

end
