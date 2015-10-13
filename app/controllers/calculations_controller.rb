class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split.count

    @dctext=@text.downcase
    @dctext=@dctext.gsub(/[^a-z0-9\s]/i, '')
    @dcspecial_word=@special_word.downcase
    @dcspecial_word=@dcspecial_word.gsub(/[^a-z0-9\s]/i, '')


    @occurrences = @dctext.split.count(@dcspecial_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @apr_percent_mon=@apr/100/12
    @monthly_payment = @principal * (@apr_percent_mon * (1 + @apr_percent_mon)**(@years * 12)) /((1 + @apr_percent_mon)**(@years * 12) - 1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    #need to figure out how to calc years
    @years = @days / 365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    #if @numbers.count.even?
     #   @median = (@sorted_numbers[((@sorted_numbers.count-1)/2).floor] + @sorted_numbers[((@sorted_numbers.count-1)/2).ceil]) / 2.0
    #else
     #   @median = @sorted_numbers[(@sorted_numbers.count-1)/2]
    #end

def median (list_of_numbers)
    median=nil
    num_items=list_of_numbers.count.to_f
    if num_items.to_i.even?
        median = ((list_of_numbers[((num_items-1)/2).floor] + list_of_numbers[((num_items-1)/2).ceil]) / 2.0)
    else
        median = list_of_numbers[(num_items-1)/2]
    end
    return median
end
@median=median(@sorted_numbers)

def sum(list_of_numbers)
  running_total = 0.0
  list_of_numbers.each do |number|
    running_total = running_total + number
  end
  return running_total
end

    @sum = sum(@numbers)

def mean(list_of_numbers)
  mean = 0.0
  mean = (sum(list_of_numbers)/(list_of_numbers.count)).to_f
  return mean.to_f
end

    @mean = mean(@numbers)

def variance(list_of_numbers)
  mean=mean(list_of_numbers)
  variances=[]
  list_of_numbers.each do |number|
    variances.push((mean-number)**2)
  end
return mean(variances)
end

    @variance = variance(@numbers)

def standard_deviation(list_of_numbers)
  var=variance(list_of_numbers)
return (Math.sqrt(var))
end

    @standard_deviation = standard_deviation(@numbers)

def mode (list_of_numbers)
    modehash={}
    mode=nil
    mode_occurrances=0
    list_of_numbers.each do |number|
        modehash[number]=list_of_numbers.count(number)
    end
    modehash.each do |key, array|
        if modehash[key] > mode_occurrances
            mode_occurrances=modehash[key]
            mode=key
        end
    end
return mode
end

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
