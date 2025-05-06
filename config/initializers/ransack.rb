Rails.application.config.to_prepare do
  # Patch ActiveStorage::Attachment for Ransack
  ActiveStorage::Attachment.class_eval do
    class << self
      def ransackable_attributes(auth_object = nil)
        ["id", "name", "record_type", "record_id", "blob_id", "created_at"]
      end

      def ransackable_associations(auth_object = nil)
        ["blob", "record"]
      end
    end
  end

  # Patch ActiveStorage::Blob for Ransack
  ActiveStorage::Blob.class_eval do
    class << self
      def ransackable_attributes(auth_object = nil)
        ["id", "key", "filename", "content_type", "byte_size", "created_at"]
      end
    end
  end
end
