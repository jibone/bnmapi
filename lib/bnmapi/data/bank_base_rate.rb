module BnmAPI::Data
  # not sure what is the difference between landing rate and financing rate
  # the API response some returns landing rate and some returns financing rate
  # including both in the data.
  BankBaseRate = Struct.new(
    :bank_code,
    :bank_name,
    :base_rate,
    :base_lending_rate,
    :base_financing_rate,
    :indicative_eff_lending_rate,
    :last_updated,
    :effective_date
  ) do

  end
end
