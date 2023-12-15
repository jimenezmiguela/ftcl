class  ChatgptController < ApplicationController
  
  def  index
      require 'nokogiri'
      require 'uri'
      require 'net/http'

      name = params[:name]
      @name = name 

      question = params[:question]
      @question = question 

      uri = URI("https://leginfo.legislature.ca.gov/faces/billTextClient.xhtml?bill_id=202320240#{@name}")
     
      response = Net::HTTP.get_response(uri)
  
      document = Nokogiri::HTML4(response.body)
      text = []
      digest = ""
      vote = ""
      appropriation = ""
      fiscalcommittee = ""
      localprogram = ""
   
      digest_text = document.search('span#digesttext//text()')
      vote = document.search('span#vote//text()')
      appropriation = document.search('span#appropriation//text()')
      fiscalcommittee = document.search('span#fiscalcommittee//text()')
      localprogram = document.search('span#localprogram//text()')

      digest << digest_text.to_s
      text << digest.to_s
      text << vote.to_s
      text << appropriation.to_s
      text << fiscalcommittee.to_s
      text << localprogram.to_s
      
      text.each do |i|
        i.gsub!("\n", "")
        i.gsub!("\t", "")
      end

      @text = text
    
      if question.nil? == false
        openai_client = OpenAI::Client.new

        prompt = "You are a highly experienced california legislator who writes concise and readable 8th grade level text without stop words, filler words or jargon. #{question} Please analyze this text: '#{@text[0]}'
        "
        response = openai_client.chat(
          parameters: {
            model:  "gpt-3.5-turbo",
            messages: [{ role:  "user", content:  prompt}],
            temperature:  0.7,
        }
        )

        # Extract the generated text from the response
        @generated_text = response.dig("choices", 0, "message", "content")

        # Return the generated text
        @generated_text
      end

  end

end