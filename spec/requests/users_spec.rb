require 'spec_helper'

describe "Usuarios" do
  before do
    # Creamos dos usuarios para probar autorización y autenticación.
    @user = User.create(email: "user1@mail.com", password: "123456", password_confirmation: "123456")
    @user2 = User.create(email: "user2@mail.com", password: "abcdef", password_confirmation: "abcdef")
    post "/login", email: @user.email, password: "123456"
    @token = JSON.parse(response.body)["token"]
  end

  it "crea un usuario con datos válidos" do
    # Debe permitir crear un usuario nuevo si los datos son correctos.
    post "/users", user: { email: "nuevo@mail.com", password: "pass123", password_confirmation: "pass123" }
    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)["email"]).to eq("nuevo@mail.com")
  end

  it "no crea usuario con email repetido" do
    # No debe permitir emails duplicados.
    post "/users", user: { email: "user1@mail.com", password: "pass123", password_confirmation: "pass123" }
    expect(response.status).to eq(422)
  end

  it "muestra un usuario existente solo si es el propio" do
    # Solo el usuario autenticado puede ver su propio perfil.
    get "/users/#{@user.id}", {}, { "Authorization" => "Bearer #{@token}" }
    expect(response.status).to eq(200)
    get "/users/#{@user2.id}", {}, { "Authorization" => "Bearer #{@token}" }
    expect(response.status).to eq(401)
  end

  it "actualiza su propio usuario" do
    # El usuario puede actualizar su email.
    put "/users/#{@user.id}", { user: { email: "nuevo2@mail.com" } }, { "Authorization" => "Bearer #{@token}" }
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)["email"]).to eq("nuevo2@mail.com")
  end

  it "no permite que un usuario actualice a otro" do
    # No debe permitir modificar datos de otro usuario.
    put "/users/#{@user2.id}", { user: { email: "hack@mail.com" } }, { "Authorization" => "Bearer #{@token}" }
    expect(response.status).to eq(401)
  end

  it "elimina su propio usuario" do
    # El usuario puede eliminar su cuenta.
    delete "/users/#{@user.id}", {}, { "Authorization" => "Bearer #{@token}" }
    expect(response.status).to eq(204)
  end

  it "no permite que un usuario elimine a otro" do
    # No debe permitir eliminar cuentas ajenas.
    delete "/users/#{@user2.id}", {}, { "Authorization" => "Bearer #{@token}" }
    expect(response.status).to eq(401)
  end
end
