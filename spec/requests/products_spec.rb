require 'spec_helper'

# Pruebas para las operaciones CRUD de productos.
describe "Productos" do
  before do
    # Creamos un usuario y un producto para las pruebas.
    @user = User.create(email: "user@mail.com", password: "123456", password_confirmation: "123456")
    post "/login", email: @user.email, password: "123456"
    @token = JSON.parse(response.body)["token"]
    @headers = { "Authorization" => "Bearer #{@token}" }
    @product = Product.create(name: "Prod", price: 10)
  end

  it "crea un producto con datos válidos" do
    # Debe permitir crear un producto si los datos son correctos.
    post "/products", { product: { name: "Nuevo", price: 20 } }, @headers
    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)["name"]).to eq("Nuevo")
  end

  it "no crea producto con nombre repetido" do
    # No debe permitir productos con el mismo nombre.
    post "/products", { product: { name: "Prod", price: 20 } }, @headers
    expect(response.status).to eq(422)
  end

  it "lista productos" do
    # Debe devolver al menos un producto.
    get "/products", {}, @headers
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).length).to be >= 1
  end

  it "muestra un producto existente" do
    # Debe mostrar los datos del producto solicitado.
    get "/products/#{@product.id}", {}, @headers
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)["name"]).to eq("Prod")
  end

  it "actualiza un producto" do
    # Permite modificar el precio de un producto.
    put "/products/#{@product.id}", { product: { price: 99 } }, @headers
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)["price"]).to eq("99.0")
  end

  it "elimina un producto" do
    # Permite eliminar un producto existente.
    delete "/products/#{@product.id}", {}, @headers
    expect(response.status).to eq(204)
  end

  it "requiere autenticación para crear producto" do
    # No debe permitir crear productos sin autenticación.
    post "/products", { product: { name: "SinAuth", price: 10 } }
    expect(response.status).to eq(401)
  end
end
