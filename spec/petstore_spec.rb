require 'spec_helper'
require 'rest-client'
require 'json'

RSpec.describe 'API request' do     
    base_uri = 'https://petstore.swagger.io/v2'
    
    describe 'GET /store/inventory' do 
        describe 'returns inventory' do 
            it 'contains available pets' do 
                response = RestClient.get(base_uri + '/store/inventory')
                status_code = response.code
                response_body = JSON.parse(response.body)
                expect(status_code).to eq(200)
                expect(response_body['available']).not_to eq(0)
                #puts "response status code: " + status_code.to_s
                #puts "response body: \n" + response
            end
        end
    end

    describe 'POST /pet' do 
        describe 'add pet to the store' do 
            it 'adds a record of a pet' do
                json_file = File.read('./data/payload.json')
                payload = JSON.parse(json_file)
                # puts "Request body: \n" + json_file

                response = RestClient.post(base_uri + '/pet', 
                            payload.to_json, 
                            {content_type: :json, 
                            accept: :json})
                status_code = response.code
                response_body = JSON.parse(response.body)
                expect(response.code).to eq(200)
                expect(response_body['id']).to eq(999)
                expect(response_body['name']).to eq('ninety k-nine') 
                # puts "response status code: " + status_code.to_s
                # puts "response body: \n" + response
            end
        end
    end

    describe 'GET /pet/{id}' do
        describe 'gets pet information using id' do
            it 'contains pet id and name' do
                id = 999
                response = RestClient.get(base_uri + "/pet/#{id}")
                status_code = response.code
                response_body = JSON.parse(response.body)
                expect(status_code).to eq(200)
                expect(response_body['id']).to eq(id)
                expect(response_body['name']).to eq('ninety k-nine') 
                # puts "response status code: " + status_code.to_s
                # puts "response body: \n" + response
            end
        end
    end
    
    describe 'DELETE /pet/{id}' do 
        describe 'deletes a pet from records' do
            it 'contains id deleted' do
                id = 999
                response = RestClient.delete(base_uri + "/pet/#{id}")
                status_code = response.code
                response_body = JSON.parse(response.body)
                expect(status_code).to eq(200)
                expect(response_body['message']).to eq(id.to_s)
                # puts "response status code: " + status_code.to_s
                # puts "response body: \n" + response                
            end
        end
    end
end
