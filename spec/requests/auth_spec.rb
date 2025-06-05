require 'spec_helper'

# Pruebas para la autenticación de usuarios y acceso a recursos protegidos.
describe "Autenticación" do
  it "permite login con credenciales válidas" do
    # Se crea un usuario y se prueba el login.
    user = User.create(email: "test@mail.com", password: "123456")
    post "/login", email: user.email, password: "123456"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to have_key("token")
  end

  it "rechaza login con credenciales inválidas" do
    # Se intenta login con datos incorrectos.
    post "/login", email: "fail@mail.com", password: "wrong"
    expect(response.status).to eq(401)
  end

  it "requiere autenticación para acceder a productos" do
    # Se intenta acceder a productos sin token.
    get "/products"
    expect(response.status).to eq(401)
  end
end
