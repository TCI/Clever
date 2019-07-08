# frozen_string_literal: true

RSpec.shared_context 'api responses' do
  let(:vendor_key) { 'vendor_key' }
  let(:vendor_secret) { 'vendor_secret' }
  let(:app_token) { '0ed35a0de3005aa1c77df310ac0375a6158881c4' }
  let(:app_id) { '5800e1c5e16c4230146fce0' }
  let(:status) { 200 }
  let(:username_source) { nil }

  let(:client) do
    Clever::Client.configure do |config|
      config.app_id          = app_id
      config.vendor_key      = vendor_key
      config.vendor_secret   = vendor_secret
      config.username_source = username_source
    end
  end

  ##################################### TOKENS RESPONSE #####################################
  let(:tokens_body) do
    {
      'data' => [{
        'id' => '58939ac0a206f40316fe8a1c',
        'created' => '2017-02-02T20:46:56.435Z',
        'owner' => { 'type' => 'district', 'id' => app_id },
        'access_token' => app_token,
        'scopes' => ['read:district_admins']
      }]
    }
  end
  let(:tokens_response) { Clever::Response.new(stub(body: tokens_body, status: status)) }

  #################################### STUDENTS RESPONSE ####################################
  # username is sis_id
  let(:student_1) do
    {
      'data' => {
        'id' => '17b6cc35f',
        'name' => { 'first' => 'jane', 'last' => 'doe' },
        'credentials' => { 'district_username' => '' },
        'grade' => '1',
        'sis_id' => '121314',
        'email' => ''
      }
    }
  end
  # username is email
  let(:student_2) do
    {
      'data' => {
        'id' => '5b1f7442',
        'name' => { 'first' => 'johnny', 'last' => 'appleseed' },
        'credentials' => { 'district_username' => '' },
        'grade' => '6',
        'sis_id' => '213154',
        'email' => 'jseed@school.com'
      }
    }
  end
  # username is district_username
  let(:student_3) do
    {
      'data' => {
        'id' => '4521ffc9',
        'name' => { 'first' => 'thomas', 'last' => 'tank' },
        'credentials' => { 'district_username' => 'tomtank' },
        'grade' => '5',
        'sis_id' => '',
        'email' => 'choochoo@school.com'
      }
    }
  end
  let(:students_body) { { 'data' => [student_1, student_2, student_3] } }
  let(:students_response) { Clever::Response.new(stub(body: students_body, status: status)) }

  #################################### COURSES RESPONSE #####################################
  let(:course_1) do
    {
      'data' => {
        'id' => '1',
        'district' => '12345',
        'name' => 'The Best Course',
        'number' => '555'
      }
    }
  end
  let(:course_2) do
    {
      'data' => {
        'id' => '100',
        'district' => '12345',
        'name' => 'The Worst Course',
        'number' => '000'
      }
    }
  end
  let(:courses_body) { { 'data' => [course_1, course_2] } }
  let(:courses_response) { Clever::Response.new(stub(body: courses_body, status: status)) }

  #################################### TEACHERS RESPONSE ####################################
  let(:teacher_1) do
    {
      'data' => {
        'id' => '1',
        'email' => '12345',
        'name' => { 'first' => 'jill', 'last' => 'epstein' }
      }
    }
  end
  let(:teacher_2) do
    {
      'data' => {
        'id' => '9',
        'email' => '12345',
        'name' => { 'first' => 'darren', 'last' => 'piper' }
      }
    }
  end
  let(:teachers_body) { { 'data' => [teacher_1, teacher_2] } }
  let(:teachers_response) { Clever::Response.new(stub(body: teachers_body, status: status)) }

  #################################### SECTIONS RESPONSE ####################################
  let(:section_1) do
    {
      'data' => {
        'id' => '5',
        'name' => 'Social Studies Grade Five',
        'period' => '01',
        'grade' => '5',
        'course' => '1',
        'teachers' => %w(5 2),
        'students' => %w(6 7 8)
      }
    }
  end
  let(:section_2) do
    {
      'data' => {
        'id' => '20',
        'name' => 'Science Grade 1',
        'period' => '06',
        'grade' => '1',
        'course' => '1000',
        'teachers' => ['6'],
        'students' => %w(1 2 3)
      }
    }
  end
  let(:section_3) do
    {
      'data' => {
        'id' => '20',
        'name' => 'Programming',
        'period' => '06',
        'grade' => '1',
        'course' => '1000',
        'teachers' => ['6'],
        'students' => %w(1 2 3)
      }
    }
  end

  let(:sections_body) { { 'data' => [section_1, section_2] } }
  let(:sections_response) { Clever::Response.new(stub(body: sections_body, status: status)) }

  ################################### PAGINATION RESPONSE ###################################
  let(:page_2_uri) { 'sections/page_2' }
  let(:page_3_uri) { 'sections/page_3' }

  let(:page_1_response) do
    Clever::Response.new(
      stub(
        status: 200,
        body: {
          'data' => [section_1],
          'links' => ['rel' => 'next', 'uri' => page_2_uri]
        }
      )
    )
  end
  let(:page_2_response) do
    Clever::Response.new(
      stub(
        status: 200,
        body: {
          'data' => [section_2],
          'links' => ['rel' => 'next', 'uri' => page_3_uri]
        }
      )
    )
  end
  let(:page_3_response) do
    Clever::Response.new(
      stub(
        status: 200,
        body: {
          'data' => [section_3],
          'links' => []
        }
      )
    )
  end

  ##################################### EVENTS RESPONSE #####################################
  let(:event_1) do
    {
      'data' => {
        'id' => 'e2e314',
        'type' => 'students.created',
        'data' => { 'object' => student_1['data'] }
      }
    }
  end
  let(:event_2) do
    {
      'data' => {
        'id' => '134ffd',
        'type' => 'teachers.updated',
        'data' => { 'object' => teacher_1['data'] }
      }
    }
  end
  let(:event_3) do
    {
      'data' => {
        'id' => '87abcc',
        'type' => 'sections.deleted',
        'data' => { 'object' => section_1['data'] }
      }
    }
  end
  let(:event_4) do
    {
      'data' => {
        'id' => 'e12316',
        'type' => 'schooladmins.created',
        'data' => { 'object' => teacher_2['data'] }
      }
    }
  end
  let(:event_5) do
    {
      'data' => {
        'id' => 'aab341',
        'type' => 'districts.updated',
        'data' => {
          'object' => {
            'id' => app_id,
            'name' => 'some fake district'
          }
        }
      }
    }
  end
  let(:event_6) do
    {
      'data' => {
        'id' => 'fafc31',
        'type' => 'schools.deleted',
        'data' => {
          'object' => {
            'id' => 'ef6013e',
            'district' => app_id,
            'name' => 'some fake school',
            'sis_id' => 'f4k3s1s1d'
          }
        }
      }
    }
  end
  let(:event_7) do
    {
      'data' => {
        'id' => 'abee32',
        'type' => 'studentcontacts.created',
        'data' => {
          'object' => {
            'id' => 'e133ee6',
            'student' => student_1['data']['id'],
            'district' => app_id
          }
        }
      }
    }
  end

  let(:events_body) { { 'data' => [event_1, event_2, event_3, event_4, event_5, event_6, event_7] } }
  let(:most_recent_event_body) { { 'data' => [event_1] } }
  let(:events_response) { Clever::Response.new(stub(body: events_body, status: status)) }
  let(:most_recent_event_response) { Clever::Response.new(stub(body: most_recent_event_body, status: status)) }
end
