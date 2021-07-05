Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root "home#index"

	resources :users do
	  collection do
	    get 'fetch'
	  end
	end

	resources :loans do
		collection do
			get 'loan_recommendation'
		end
	end

end
