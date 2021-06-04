Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'home', to: 'authentication_user#login'
  #address routes
  post 'addAddress', to: 'address#create'
  get 'address', to: 'address#all'
  get 'findAddress/:id', to: 'address#find'
  put 'updateAddress/:id', to: 'address#update'
  get 'deleteAddress/:id', to: 'address#delete'

  #role_type routes
  post 'addRole', to: 'role_type#create'
  get 'roles', to: 'role_type#all'
  get 'findRole/:id', to: 'role_type#find'
  put 'updateRole/:id', to: 'role_type#update'
  get 'deleteRole/:id', to: 'role_type#delete'

  #user routes
  post 'addUser', to: 'user#create'
  get 'users', to: 'user#all'
  get 'findUser/:id', to: 'user#find'
  put 'updateUser/:id', to: 'user#update'
  get 'deleteUser/:id', to: 'user#delete'

  #energy_meter routes
  post 'addEnergyMeter', to: 'energy_meter#create'
  get 'energyMeters', to: 'energy_meter#all'
  get 'findEnergyMeter/:id', to: 'energy_meter#find'
  put 'updateEnergyMeter/:id', to: 'energy_meter#update'
  get 'deleteEnergyMeter/:id', to: 'energy_meter#delete'

  #due_balance routes
  post 'addDueBalance', to: 'due_balance#create'
  get 'dueBalances', to: 'due_balance#all'
  get 'findDueBalance/:id', to: 'due_balance#find'
  put 'updateDueBalance/:id', to: 'due_balance#update'
  get 'deleteDueBalance/:id', to: 'due_balance#delete'
end
