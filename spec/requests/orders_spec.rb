require 'spec_helper'

# Pruebas para la creación y gestión de órdenes de compra.
describe "Órdenes" do
  before do
    # Preparamos un usuario y dos productos para las pruebas de órdenes.
    @user = User.create(email: "user@mail.com", password: "123456", password_confirmation: "123456")
    @product1 = Product.create(name: "Prod1", price: 10)
    @product2 = Product.create(name: "Prod2", price: 20)
    post "/login", email: @user.email, password: "123456"
    @token = JSON.parse(response.body)["token"]
    @headers = { "Authorization" => "Bearer #{@token}" }
  end

  it "realiza una orden de compra válida" do
    # Debe permitir crear una orden con productos válidos.
    post "/orders/checkout", { products: [@product1.id, @product2.id] }, @headers
    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)["products"].length).to eq(2)
  end

  it "no permite checkout con producto inexistente" do
    # No debe permitir crear una orden con un producto que no existe.
    post "/orders/checkout", { products: [999] }, @headers
    expect(response.status).to eq(422)
  end

  it "lista órdenes del usuario" do
    # Debe devolver al menos una orden después de crearla.
    post "/orders/checkout", { products: [@product1.id] }, @headers
    get "/orders", {}, @headers
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).length).to be >= 1
  end

  it "requiere autenticación para crear orden" do
    # No debe permitir crear órdenes sin autenticación.
    post "/orders/checkout", { products: [@product1.id] }
    expect(response.status).to eq(401)
  end
end
