class ClientsController < ApplicationController
  # Define un callback que se ejecutará antes de las acciones show, update y destroy
  before_action :set_client, only: %i[ show update destroy ]

  # GET /clients
  def index
    # Si el parámetro 'name' está presente, filtra los clientes cuyo nombre contenga el valor del parámetro
    if params[:name].present?
      @clients = Client.where("name LIKE ?", "%#{params[:name]}%")
    else
      # Si no hay parámetro 'name', obtiene todos los clientes
      @clients = Client.all
    end

    # Devuelve los clientes en formato JSON
    render json: @clients
  end

  # GET /clients/1
  def show
    # Devuelve el cliente encontrado por el método set_client en formato JSON
    render json: @client
  end

  # POST /clients
  def create
    # Crea un nuevo cliente con los parámetros permitidos
    @client = Client.new(client_params)

    # Si el cliente se guarda correctamente, devuelve el cliente creado con un estado HTTP 201 (Created)
    if @client.save
      render json: @client, status: :created, location: @client
    else
      # Si hay errores al guardar, devuelve los errores con un estado HTTP 422 (Unprocessable Entity)
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    # Si el cliente se actualiza correctamente, devuelve el cliente actualizado en formato JSON
    if @client.update(client_params)
      render json: @client
    else
      # Si hay errores al actualizar, devuelve los errores con un estado HTTP 422 (Unprocessable Entity)
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    # Elimina el cliente encontrado por el método set_client
    @client.destroy!
  end

  private
    # Define un método privado para encontrar un cliente por su ID
    def set_client
      # Busca el cliente por el parámetro 'id' y lo asigna a la variable @client
      @client = Client.find(params.expect(:id))
    end

    # Define un método privado para permitir solo ciertos parámetros
    def client_params
      # Permite los parámetros 'name', 'age', 'birthdate' y 'verified' dentro del objeto 'client'
      params.expect(client: [ :name, :age, :birthdate, :verified ])
    end

    # Define un método privado para realizar búsquedas personalizadas de clientes
    def search
      # Busca clientes cuyo nombre o correo electrónico coincidan parcialmente con el parámetro 'query'
      @clients = Client.where("name LIKE ? OR email LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
      # Devuelve los clientes encontrados en formato JSON
      render json: @clients
    end
end
