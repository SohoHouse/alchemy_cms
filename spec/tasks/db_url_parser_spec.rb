require 'alchemy/tasks/db_url_parser'

describe ::Alchemy::Tasks::DbUrlParser do
  let(:adapter) { "postgres" }
  let(:user) { "SomeUser" }
  let(:password) { "some_password" }
  let(:database) { "some_db_name" }
  let(:host) { "some_host" }
  let(:port) { 1234 }
  let(:url) { "#{adapter}://#{user}:#{password}@#{host}:#{port}/#{database}" }

  let(:subject) { described_class.new(url) }

  it "parses the password" do
    expect(subject.password).to eq password
  end

  describe "#adapter" do
    context "with postgres as the schema" do
      let(:adapter) { "postgres" }

      it "returns the correct adapter" do
        expect(subject.adapter).to eq "postgresql"
      end
    end

    context "with mysql as the schema" do
      let(:adapter) { "MySQL" }

      it "returns the correct adapter" do
        expect(subject.adapter).to eq "mysql"
      end
    end

    context "with an unsupported db as the schema" do
      let(:adapter) { "neo4j" }

      it "raises an ArgumentError" do
        expect(->{subject.adapter}).to raise_error ArgumentError
      end
    end
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
      adapter: "postgresql",
      host: host, username: user, password: password, database: database
    })
  end
end


