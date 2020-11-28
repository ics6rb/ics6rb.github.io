# frozen_string_literal: true

# Что за expect().to receive - см в link_request_spec.

RSpec.describe CorrectUriValidator do
  let(:validator) { CorrectUriValidator.new }

  describe 'validate_each' do
    # record - это по идее запись из БД. Но в данном случае на:
    # 1) не важно, что за модель - должно работать с любой.
    # 2) не хочется подтягивать реальную модель.
    # Именно поэтому в RSpec есть mock, который умеет делать тупой пустой объект, в который можно
    # динамически надобавлять методов с тестовыми целями.
    let :record do
      record = mock('model')
      # У модели должно быть поле (для Ruby - метод) errors с ошибками и возможность туда что-то добавлять,
      # Учим модель иметь ошибки, and_return - начальное значение.
      record.stub(:errors).and_return([])
      # Оборачиваем метод add массива (причем конкретного - строчкой выше).
      record.errors.stub('[]').and_return({})
      record.errors[].stub(:add)
      record
    end

    it 'should add error if unless value present' do
      record.errors[].should_receive :add
      validator.validate_each(record, :email, nil)
      expect(validator).not_to receive(:uri_correct?)
    end

    it 'should add error if uri is incorrect' do
      incorrect_uri = Faker::Lorem.word

      allow(validator).to receive(:uri_correct?) { false }.with(incorrect_uri)
      record.errors[].should_receive :add

      validator.validate_each(record, :email, incorrect_uri)
    end

    it 'should validate correct uri' do
      correct_uri = Faker::Internet.uri

      allow(validator).to receive(:uri_correct?) { true }.with(correct_uri)
      record.should_not_receive :errors

      validator.validate_each(record, :email, correct_uri)
    end
  end

  describe 'private uri_correct?' do
    # Т.к. метод приватный, чтобы достучаться, надо делать send.
    it 'should return false on empty string' do
      expect(validator.send(:uri_correct?, '')).to be(false)
    end

    it 'should return false on incorrect URI' do
      expect(validator.send(:uri_correct?, Faker::Kpop.solo)).to be(false)
    end

    it 'should return true on correct URI' do
      expect(validator.send(:uri_correct?, Faker::Internet.url)).to be(true)
    end
  end
end
