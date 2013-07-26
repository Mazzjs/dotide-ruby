require 'net/http'
require 'json'
require 'uri'

module Dotide
  class Client

    attr_accessor :api_key

    def  self.user_agent
      "dotide-ruby/v1"
    end

    def initialize(key)
      #key[:user]
      @api_key = key[:api_key]
      @user = key[:user]
      @pass = key[:pass]
      @token = key[:token]
    end

    def get(url,options={})
      uri=URI.parse(url)
      req = Net::HTTP::Get.new(url)
      req.basic_auth @user,@pass
      res = Net::HTTP.start(uri.host, uri.port) { |http|
          http.request(req)
      }
      # url_parse(url)
      # response = @http.request_get(@requri,{'Content-Type'=>'application/json','Accept'=>'application/json','auth'=>('mazzjs','123456')})
      # json_parse(response.body)
      return res.body
      #p response['content-type']
      #puts response.body
    end

    def post(url,data,options={})
      uri=URI.parse(url)
      req = Net::HTTP::Post.new(url,@headers)
      req.basic_auth @user,@pass
      res = Net::HTTP.start(uri.host, uri.port) { |http|
          http.request(req)
      }
      return res.body
    end

    def put(url,data,options={})
      uri=URI.parse(url)
      req = Net::HTTP::Put.new(url,@headers)
      req.basic_auth @user,@pass
      res = Net::HTTP.start(uri.host, uri.port) { |http|
          http.request(req)
      }
      return res.body
    end

    def delete(url,options={})
      url_parse(url)
      response = @http.delete(@requri,@headers)
      return response.body
    end

    private

    def json_parse(response_body)
      JSON.parse(response_body)   if response_body
    end

    def url_parse(url)
      uri = URI.parse(url)
      @http = Net::HTTP.new(uri.host, uri.port)
      @requri = uri.request_uri
      return
    end
    def header
      @headers={}
      @headers['Content-Type']='application/json'
      @headers['Accept']='application/json'
      @headers['ApiKey']=@api_key if @api_key
      @headers['AUTHORIZATION']=@token if @token
      @headers
    end

  end
end
