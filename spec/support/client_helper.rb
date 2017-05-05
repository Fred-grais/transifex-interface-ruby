module ClientHelper
  def reset_transifex_configuration
    Transifex.configure do |c|
      c.client_login = ''
      c.client_secret = ''
    end
  end
end
