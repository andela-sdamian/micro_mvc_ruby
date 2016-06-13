module MicroMvcRuby
  class Notfound
    def self.html
      <<-HTML
<html>
  <head>
    <title>Notfound </title>
  </head>
  <body>
  <h1>Ooops! page not found - 404</h1>

  <h3>&#9786; <a href="/">Go Home</a></h3>
  </body>
      </html>
HTML
    end
  end
end
