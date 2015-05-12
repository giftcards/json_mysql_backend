class Hiera
  module Backend
    class Json_mysql_backend

      def initialize
        Hiera.debug("json_mysql initialize")
        begin
          require 'mysql'
          require 'json'
        rescue LoadError
          require 'rubygems'
          require 'mysql'
          require 'json'
        end
      end

      def lookup(key, scope, order_override, resolution_type)
        Hiera.debug("json_mysql lookup")
        answer = nil

        Hiera.debug("key #{key}")
        Hiera.debug("scope #{scope}")
        Hiera.debug("order_override #{order_override}")
        if order_override != nil
          Hiera.debug("Warning: json_mysql ignores order_override")
        end
        Hiera.debug("resolution_type #{resolution_type}")
        if resolution_type != :priority
          Hiera.debug("Warning: json_mysql only supports resolution_type priority")
        end

        mysql_host=Config[:mysql][:host]
        mysql_user=Config[:mysql][:user]
        # Not presented through debug
        mysql_pass=Config[:mysql][:pass]
        mysql_database=Config[:mysql][:database]
        mysql_queries=[Config[:mysql][:query]].flatten
        mysql_queries.map! { |q| Backend.parse_string(q, scope, {"key" => key}) }

        Hiera.debug("Connecting to mysql://#{mysql_user}@#{mysql_host}/#{mysql_database}")
        mysql_conn = Mysql.new(mysql_host, mysql_user, mysql_pass, mysql_database)
        mysql_conn.reconnect = true

        Hiera.debug("Looking up #{key} in json_mysql backend")
        mysql_queries.each do |query|
          Hiera.debug("query #{query}")
          results=mysql_conn.query(query)
          unless results.num_rows == 0
            results.each do |result_row|
              result_string=result_row[0]
              Hiera.debug("result_string #{result_string}")
              begin
                answer = JSON.parse(result_string)
              rescue JSON::ParserError
                answer = result_string
              end
              Hiera.debug("answer.class #{answer.class}")
              return answer
            end
            #return answer
          end 
          Hiera.debug("result empty")
        end
        Hiera.debug("no results found")
        return answer
      end
    end
  end
end
