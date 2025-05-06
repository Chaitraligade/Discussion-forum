Rails.application.config.to_prepare do
  # Ensure ActiveStorage::Attachment allows Ransack filtering
  if defined?(ActiveStorage::Attachment)
    ActiveStorage::Attachment.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        ["id", "name", "record_type", "record_id", "blob_id", "created_at"]
      end

      def self.ransackable_associations(auth_object = nil)
        ["blob", "record"]
      end
    end
  end

  # Ensure ActiveStorage::Blob allows Ransack filtering
  if defined?(ActiveStorage::Blob)
    ActiveStorage::Blob.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        ["id", "key", "filename", "content_type", "byte_size", "created_at"]
      end
    end
  end
end
