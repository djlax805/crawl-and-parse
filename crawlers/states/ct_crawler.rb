# frozen_string_literal: true

class CtCrawler < BaseCrawler
  protected

  def _set_up_page
    @s = @driver.find_elements(class: 'callout--secondary')[0].text.gsub(',','')
    # "CT COVID-19 Data Tracker\nView additional graphs and tables containing data on cases in Connecticut\nDaily overview\nPositive Cases: 44179 (+87)\nTotal Deaths: 4097 (+13)\nHospitalized: 293 (-31)\nTests Reported: 310654 (+4658)"
    #url = @driver.find_element(class: 'button--auth').find_element(xpath: ".//a").attribute('href')
    #pdf_timestamp = Time.now.strftime('%Y%m%d%H%M')
    #`curl #{url} -o data/#{@st}/#{pdf_timestamp}.pdf`
    #@reader = PDF::Reader.new("data/#{@st}/#{pdf_timestamp}.pdf")
  end

  def _find_hospitalized
    @results[:hospitalized] = /\nHospitalized: (\d+)/.match(@s)[1]&.to_i
  end

  def _find_positive
    @results[:positive] = /\nPositive Cases: (\d+)/.match(@s)[1]&.to_i
  end

  def _find_deaths
    @results[:deaths] = /\nTotal Deaths: (\d+)/.match(@s)[1]&.to_i
  end

  def _find_tested
    @results[:tested] = /\nTests Reported: (\d+)/.match(@s)[1]&.to_i
  end

  def _find_counties
    return
    page_one.scan(/(\w* \w+ County \d+ \d+)/).flatten.each do |county_data|
      match_data = /\A(.* County) (\d+) (\d+)/.match(county_data)
      @results[:counties] << {
        name: match_data[1]&.strip,
        positive: match_data[2].to_i,
        deaths: match_data[3].to_i,
      }
    end
  end

  def _find_towns
    return
    @results[:towns] = []
    page_five = @reader.page(5).text.gsub(/\s+/,' ').tr(',','')
    page_five.scan(/(Cases)?(\w* ?\w+ \d+)/).each do |_,town|
      if town.include?('not include') || town.include?('Updated')
        next
      end
      town_match = /(.+) (\d+)/.match(town)

      @results[:towns] << {
        name: town_match[1]&.strip,
        positive: town_match[2].to_i,
      }
    end
  end

  def page_one
    return ''
    @page_one ||= @reader.page(1).text.gsub(/\s+/,' ').tr(',','')
  end
end
