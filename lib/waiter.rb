require 'pry'

class Waiter

  attr_accessor :name, :yrs_experience
 
  @@all = []
 
  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    @@all << self
  end
 
  def self.all
    @@all
  end
 
 def new_meal(customer, total, tip=0)
   Meal.new(self, customer, total, tip)
 end
 
  def meals
    Meal.all.select do |meal|
      meal.waiter == self
    end
  end
  
  def best_tipper
    best_tipped_meal = meals.max do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
    best_tipped_meal.customer
  end
  
  def frequent_customer
    customer_list = self.meals.collect {|meal| meal.customer}
    customer_list.max_by {|i| customer_list.count(i)}
  end
  
  def worst_tipped_meal
      worst_tipped_meal = meals.min do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
    worst_tipped_meal
  end
  
  def self.most_experienced_avg_tips
    most_experienced = self.all.max_by {|waiter| waiter.yrs_experience}
    meal_tips = self.meals.collect {|meal| meal.tip}
    meal_tips.inject {|sum, el| sum + el} / meal_tips.size
    
  end
  
  def self.least_experienced_avg_tips
    least_experienced = self.all.min_by {|waiter| waiter.yrs_experience}
    meal_tips = self.meals.collect {|meal| meal.tip}
    meal_tips.inject {|sum, el| sum + el} / meal_tips.size
  end
end