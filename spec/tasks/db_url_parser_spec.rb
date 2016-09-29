require 'alchemy/tasks/db_url_parser'

describe ::Alchemy::Tasks::DbUrlParser do
  let(:database) { "some_db_name" }
  let(:host) { "some_host" }
  let(:user) { "SomeUser" }
  let(:password) { "some_password" }
  let(:port) { 1234 }
  let(:url) { "postgres://#{user}:#{password}@#{host}:#{port}/#{database}" }

  let(:subject) { described_class.new(url) }

  it "parses the password" do
    expect(subject.password).to eq password
  end

  it "parses the user" do
    expect(subject.user).to eq user
  end

  it "parses the host" do
    expect(subject.host).to eq host
  end

  it "parses the db name" do
    expect(subject.database).to eq database
  end

  it "generates config" do
    expect(subject.to_config).to eq({
      host: host, username: user, password: password, database: database
    })
  end
end


