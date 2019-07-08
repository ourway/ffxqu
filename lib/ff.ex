defmodule Ff do
  @moduledoc """
  Documentation for Ff.
  """

  def get_friends_from_file(file) do
    f = File.read!(file)
    friends = f |> Floki.find(".friendName")
    friends |> Enum.map(fn x -> x |> Floki.attribute("title") |> List.last() end)
  end

  def add_friend(friend_name) do
    url = "https://www.mql5.com/en/users/elyadhakimi/friends"

    cookies =
      "uniq=BFC2B2E3-6EEC-S-190706; lang=en; _fz_fvdt=1562386327; _fz_uniq=BFC2B2E3-6EEC-S-190706; auth=652EDF1B697EDDCD5CD98DB8488A2FC6FD9A5683FFFE7DD7531D7A4919BFBB635F01B3D1CB165579B302BF4079906727F3C8A9AEAC1C1DDFD23E22F5BCB4AA2417B5A05FA3B4391A401825485D279F344AB27F73EDD9C912096CF97AB9A98A3346A2AD96; sid=eagvlrbnly2glcnbpa1ovb55; _fz_ssn=1562558219207271603"
      |> String.split(",")

    headers = [
      "content-type": "application/x-www-form-urlencoded",
      referer: "https://www.mql5.com/en/users/#{friend_name}"
    ]

    data = "__signature=0063210356d054cac10160cd94043809&user=#{friend_name}&action=add"

    HTTPoison.post(url, data, headers, hackney: [cookie: cookies])
  end

  def add_all(file) do
    file |> get_friends_from_file |> Enum.map(
      fn x ->
       x |> add_friend |> IO.inspect
      
      Process.sleep(5000)
     end)
  end
end
