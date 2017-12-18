defmodule EventScoring.Producer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:producer, :queue.new}
  end

  def handle_cast({:event, event}, queue) do
    {:noreply, [event], queue}
  end

  def handle_demand(demand, queue) when demand > 0 do
    with {{:value, val}, new_q} <- :queue.out(queue)
    do
      {:noreply, [val], new_q}
    else
      {:empty, _} ->
        {:noreply, [], :queue.new}
    end
  end
end
