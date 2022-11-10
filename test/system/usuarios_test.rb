require "application_system_test_case"

class UsuariosTest < ApplicationSystemTestCase
  setup do
    @usuario = usuarios(:one)
  end

  test "visiting the index" do
    visit usuarios_url
    assert_selector "h1", text: "Usuarios"
  end

  test "should create usuario" do
    visit usuarios_url
    click_on "New usuario"

    fill_in "Birthdate", with: @usuario.birthdate
    fill_in "Contact", with: @usuario.contact
    fill_in "Date licence", with: @usuario.date_licence
    check "Deleted" if @usuario.deleted
    fill_in "Dni", with: @usuario.dni
    check "Enable" if @usuario.enable
    fill_in "Id wallet", with: @usuario.id_wallet
    fill_in "Image data", with: @usuario.image_data
    fill_in "Lastname", with: @usuario.lastname
    fill_in "Lat", with: @usuario.lat
    fill_in "Lon", with: @usuario.lon
    fill_in "Name", with: @usuario.name
    click_on "Create Usuario"

    assert_text "Usuario was successfully created"
    click_on "Back"
  end

  test "should update Usuario" do
    visit usuario_url(@usuario)
    click_on "Edit this usuario", match: :first

    fill_in "Birthdate", with: @usuario.birthdate
    fill_in "Contact", with: @usuario.contact
    fill_in "Date licence", with: @usuario.date_licence
    check "Deleted" if @usuario.deleted
    fill_in "Dni", with: @usuario.dni
    check "Enable" if @usuario.enable
    fill_in "Id wallet", with: @usuario.id_wallet
    fill_in "Image data", with: @usuario.image_data
    fill_in "Lastname", with: @usuario.lastname
    fill_in "Lat", with: @usuario.lat
    fill_in "Lon", with: @usuario.lon
    fill_in "Name", with: @usuario.name
    click_on "Update Usuario"

    assert_text "Usuario was successfully updated"
    click_on "Back"
  end

  test "should destroy Usuario" do
    visit usuario_url(@usuario)
    click_on "Destroy this usuario", match: :first

    assert_text "Usuario was successfully destroyed"
  end
end
