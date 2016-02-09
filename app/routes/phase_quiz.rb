class Flippd < Sinatra::Application

  attr_accessor :results
  attr_accessor :correct_num
  attr_accessor :submission_error

  post '/phases/:title/:slug' do

    must_be_a :quiz

    @results = []
    @correct_num = 0
    @submission_error = nil

    @item["questions"].each_with_index do | question, index |

      ans = params[ ( "q" + index.to_s ).to_sym ]

      if ans.nil?
        @submission_error = "Please answer all questions"

        @results[ index ] = {
          no_answer: true
        }
      else
        ans = ans.to_i

        @results[ index ] = {
          correct: ans == question[ "correct_answer" ],
          selected: ans,
          answer: question[ "correct_answer" ]
        }
      end

      @correct_num += 1 if ans == question[ "correct_answer" ]

    end

    if @submission_error.nil?
      erb :quiz_complete
    else
      erb :quiz
    end

  end

end
