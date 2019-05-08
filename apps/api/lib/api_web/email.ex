defmodule ApiWeb.Email do
  import Bamboo.Email

  def welcome_email(%{private: %{guardian_default_resource: user}}, cashout) do
    new_email(
      to: user.email,
      from: "bank@mail.com",
      subject: "Cashout",
      html_body: "<strong>Hi mr(s). #{user.name} you got #{cashout} reais</strong>",
      text_body: "Hi mr(s). #{user.name} you got #{cashout} reais"
    )
  end
end
