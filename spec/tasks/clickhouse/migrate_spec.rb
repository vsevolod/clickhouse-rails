require_relative '../../rails_helper'

describe 'clickhouse:db:migrate' do
  include_context 'rake'

  it 'run migrations' do
    subject.invoke
  end
end
