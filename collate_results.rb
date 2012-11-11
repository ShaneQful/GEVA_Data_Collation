#!/usr/bin/ruby

# Copyright (c) 2012 Shane Quigley
# 
# This software is MIT licensed see link for details
# http://www.opensource.org/licenses/MIT

class Array
	def sum
		inject(0.0) { |result, el| result + el }
	end
	
	def mean 
		sum / size
	end
	
	def pop_standard_deviation
		m = self.mean
		sum = self.inject(0){|result, el| result +(el-m)**2 }
		Math.sqrt(sum/(self.length).to_f)
	end
	
	def sample_standard_deviation
		m = self.mean
		sum = self.inject(0){|result, el| result +(el-m)**2 }
		Math.sqrt(sum/(self.length-1).to_f)
	end
end

class Parser
	def get_file_table file_name
		file = File.open(file_name, "rb")
		lines = file.readlines
		@firstline = lines[0]
		table = Array.new
		lines.each do |line|
			if(@firstline != line)
				cells = line.split
				row = Array.new
				cells.each do |c|
					row.push c.to_f
				end
				table.push row
			end
		end
		return table
	end
	
	def combine_all_generations runs
		data_to_collate = Array.new
		runs[0].size.times do |i|
			gen = combine_generation i, runs
			data_to_collate.push gen
		end
		return data_to_collate
	end
	
	def print_output_data type, data_to_collate
		output = @firstline.gsub(/\s/,",")[0 .. -2]+"\n"
		data_to_collate.each do |gen|
			gen.each do |cell|
				if(type == "-sd")
					output += "#{cell.pop_standard_deviation},"
				elsif(type == "-m")
					output += "#{cell.mean},"
				end
			end
		output = output[0 .. -2]
		output += "\n"
		end
		puts output
	end
	
	def print_table table
		table.each do |row|
			puts row.inspect
		end
	end
	
	private
	def combine_generation i, runs
		gen = Array.new
		runs[0][0].size.times do |j|
			gen.push Array.new
		end
		runs.each do |table|
			j = 0
			table[i].each do |cell|
				gen[j].push cell
				j+=1
			end
		end
		return gen
	end
end

parser = Parser.new
runs = Array.new
input_flag = ARGV.shift
if(input_flag == "--help" || (input_flag != "-m" && input_flag != "-sd"))
	puts "Usage: \nruby collate_results.rb -m *.dat"
	puts "\tTo get the mean of each cell in the file in csv format\n"
	puts "ruby collate_results.rb -sd *.dat"
	puts "\tTo get the standard deviation of each cell in the file in csv format\n"
	exit
end
ARGV.each do |fname|
	table = parser.get_file_table fname
	runs.push table
end
data_to_collate = parser.combine_all_generations runs
parser.print_output_data input_flag, data_to_collate