require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let(:valid_user) { create(:attendee, email: "test@example.com", password: "password") }

    context "with valid credentials" do
      it "logs in the user and redirects to root_url" do
        post :create, params: { email_address: valid_user.email, password: "password" }
        expect(session[:user_id]).to eq(valid_user.id)
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid credentials" do
      it "renders the new template with an error message" do
        post :create, params: { email_address: "invalid@example.com", password: "wrongpassword" }
        expect(session[:user_id]).to be_nil
        expect(flash.now[:alert]).to be_present
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "logs out the user and redirects to root_url" do
      session[:user_id] = 1 # Assuming a user is logged in
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_url)
    end
  end
end
