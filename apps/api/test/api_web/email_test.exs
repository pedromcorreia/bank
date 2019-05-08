defmodule ApiWeb.EmailTest do
  use ApiWeb.ConnCase, async: true

  alias ApiWeb.Email

  describe "welcome_email" do
    test "pass user and cashout then return an email" do
      user = %{name: "some name", email: "some@mail.com"}
      assert %Bamboo.Email{} = email = Email.welcome_email(%{private: %{guardian_default_resource: user}}, 10)
      assert email.assigns == %{}
      assert email.attachments == []
      assert email.bcc == nil
      assert email.cc == nil
      assert email.from == "bank@mail.com"
      assert email.headers == %{}
      assert email.html_body == "<strong>Hi mr(s). some name you got 10 reais</strong>"
      assert email.private == %{}
      assert email.subject == "Cashout"
      assert email.text_body == "Hi mr(s). some name you got 10 reais"
      assert email.to == "some@mail.com"
    end
  end
end
