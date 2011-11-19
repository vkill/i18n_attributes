module I18nAttributes
  Configuration = Struct.new(
    :locales,
    :enums_attributes
  ).new(
    [:en],
    {
      "gender" => {"male" => "Male", "female" => "Female"},
      "state" => {"pending" => "Pending", "processing" => "Processing", "processed" => "Processed"},
      "category" => {"a" => "A", "b" => "B"}
    }
  )
end

