#
#  Created by Boyd Multerer on November 29, 2017.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#
#  You can absolutely run the Scenic.Cache genserver directly from your own
#  supervisor and skip this one if you want. However, if you want to hook in
#  to callbacks on put/claim/release, then you need to start up this
#  supervisor, which manages both the cache and the callback registry.
#
#  The various Scenic rendering engines do use the callbacks for texture
#  and font management, so you are probably best off using this supervisor...

defmodule Scenic.Cache.Supervisor do
  @moduledoc false
  use Supervisor
  alias Scenic.Cache

  #  import IEx

  #  @name       :scenic_cache_supervisor

  @cache_registry :scenic_cache_registry

  # ============================================================================
  # setup the viewport supervisor

  def start_link() do
    #    Supervisor.start_link(__MODULE__, :ok, name: @name)
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    [
      {Cache, []},
      Supervisor.child_spec({Registry, keys: :duplicate, name: @cache_registry},
        id: @cache_registry
      )
    ]
    |> Supervisor.init(strategy: :one_for_one)
  end
end
