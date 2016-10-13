defmodule TelegramBot.PageControllerTest do
  use TelegramBot.ConnCase

  setup do
    import TelegramBot.Router.Helpers
    token = Application.fetch_env!(:nadia, :token)
    url = page_path(TelegramBot.Endpoint, :reply, token)
    %{url: url}
  end

  test "voice message", %{conn: conn, url: url} do
    message =
      %{"message" =>
         %{"chat" =>
            %{"first_name" => "Test Firstname", "id" => 1111111,
              "last_name" => "Test Lastname", "type" => "private",
              "username" => "Testusername"},
           "date" => 1441645532, "from" =>
             %{"first_name" => "Test Firstname", "id" => 1111111,
               "last_name" => "Test Lastname", "username" => "Testusername"},
           "message_id" => 1365, "voice" =>
             %{"duration" => 5, "file_id" => "AwADBAADbXXXXXXXXXXXGBdhD2l6_XX",
               "file_size" => 23000, "mime_type" => "audio/ogg"}},
        "update_id" => 10000}
    conn = post conn, url, message
    body = json_response(conn, 200)
    assert body == %{"success" => true}
  end

  test "start message", %{conn: conn, url: url} do
    message =
      %{"message" =>
         %{"chat" =>
            %{"first_name" => "Test", "id" => 1111111,
              "last_name" => "Test Lastname", "username" => "Test"},
           "date" => 1441645532, "from" =>
             %{"first_name" => "Test", "id" => 1111111,
               "last_name" => "Test Lastname", "username" => "Test"},
           "message_id" => 1365, "text" => "/start"},
        "update_id" => 10000}
    conn = post conn, url, message
    body = json_response(conn, 200)
    assert body == %{"chat_id" => 1111111, "method" => "sendMessage",
                     "text" => "Дратути"}
  end
end
