defmodule LunarCruiser do

# x, y e N para direção
  defstruct posição: {0, 0, "N"}, instruções:

  @direções [:Norte, :Leste, :Sul, :Oeste]


# girando o veículo e retornando a posição
def rodar(posição, direção) do
  {x, y, orientação} = posição
  {x, y, @direções[(Enum.find(@direções, &(&1 == orientação)).[1] + direção) % 4]}
end
  # movendo o veículo com base na nova posição
  def mover(posição) do
    {x, y, orientação} = posição
    nova_posição =
      case orientação do
        :Norte -> {x, y + 1}
        :Leste -> {x + 1, y}
        :Sul -> {x, y - 1}
        :Oeste -> {x - 1, y}
      end
    nova_posição
  end

  # aplicando as instruções no veículo
  def aplicar_instruções(veículo, instruções) do
    for instrução <- instruções do
      veículo =
        case instrução do
          "E" -> rodar(veículo, 1)
          "D" -> rodar(veículo, -1)
          "M" -> mover(veículo)
          _ -> veículo
        end
    veículo
  end

 # retornando a posição dos veículos ou coordenadas
  def saída(posição) do
    {x, y} = posição.posição
    "(#{x}, #{y})"
  end

#definindo a entrada
defmodule Main do
  def main do
    input = "5 5
    \n1 2 N\nEMEMEMEMM\n3 3 L\nMMDMMDMDDM"

    # listando os veículos
    veículos =
      input
      |> String.split("\n")
      |> Enum.map(fn linha ->
        [x, y, orientação] = String.split(linha)
        %LunarCruiser{posição: {String.to_integer(x), String.to_integer(y), orientação}, instruções: ""}
      end)

    # aplicando as intruções
    veículos_atualizados =
      veículos
      |> Enum.map(fn veículo ->
        LunarCruiser.aplicar_instruções(veículo, "EMEMEMEMM")
      end)

    # mapeando e imprimindo a posição de cada veículo
    veículos_atualizados
      |> Enum.map(&LunarCruiser.saída/1)
      |> IO.puts
  end
