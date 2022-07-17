local ok, startup = pcall(require, "dashboard")
if not ok then
  vim.notify "Cannot find dashboard"
  return
end

startup.custom_center = {
  {
    icon = "  ",
    desc = "Projects                            ",
    action = "Telescope projects",
  },
}

startup.custom_header = {
  [[        ▄▄▄▄▄███████████████████▄▄▄▄▄      ]],
  [[      ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄    ]],
  [[     █▀████████▄             ▀▀████ ▀██▄   ]],
  [[    █▄▄██████████████████▄▄▄         ▄██▀  ]],
  [[     ▀█████████████████████████▄    ▄██▀   ]],
  [[       ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀     ]],
  [[         ▀███▄              ▀██████▀       ]],
  [[           ▀██████▄        ▄████▀          ]],
  [[              ▀█████▄▄▄▄▄▄▄███▀            ]],
  [[                ▀████▀▀▀████▀              ]],
  [[                  ▀███▄███▀                ]],
  [[                     ▀█▀                   ]],
  [[]],
}
