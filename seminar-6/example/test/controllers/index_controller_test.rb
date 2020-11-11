require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get index_input_url
    assert_response :success
  end

  test 'should return error if params are empty' do
    get index_output_url
    assert_response :success
    assert_not_nil assigns[:error]
    assert_nil assigns[:result]
  end

  test 'should return result if params are numbers' do
    get index_output_url, params: { a: '1 2 3 4' }
    assert_response :success
    assert_nil assigns[:error]
    assert_equal [2, 4], assigns[:result]
  end

  test 'should return error if has not number' do
    get index_output_url, params: { a: '1 ksnv 3 4' }
    assert_response :success
    assert_not_nil assigns[:error]
    assert_nil assigns[:result]
  end
end
