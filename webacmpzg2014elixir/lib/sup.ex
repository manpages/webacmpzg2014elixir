import WebCamp.Macros.Sup
defsup WebCamp.Sup, [name: __MODULE__] do
  children = [
    WebCamp.Persist |> worker([]),
    WebCamp.Emitter |> worker([]),
    WebCamp.Counter |> worker([]),
  ]
  supervise(children, strategy: :one_for_one)
end
