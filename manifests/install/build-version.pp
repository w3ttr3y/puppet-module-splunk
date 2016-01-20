
class splunk::install::version (
  $user_versions = {}
){
  $known_versions = {
    '6.3.2'  => 'aaff59bb082c',
    '6.3.1'  => 'f3e41e4b37b2',
    '6.3.0'  => 'aa7d4b1ccb80',
    '6.2.8'  => '275559',
    '6.2.7'  => '275064',
    '6.2.6'  => '274160',
    '6.2.5'  => '272645',
    '6.2.4'  => '271043',
    '6.2.3'  => '264376',
    '6.2.2'  => '255606',
    '6.2.1'  => '245427',
    '6.2.0'  => '237341',
    '6.1.6'  => '249101',
    '6.1.5'  => '239630',
    '6.1.4'  => '233537',
    '6.1.3'  => '220630',
    '6.1.2'  => '213098',
    '6.1.1'  => '207789',
    '6.1.0'  => '206881',
    '6.0.7'  => '241889',
    '6.0.6'  => '228831',
    '6.0.5'  => '214064',
    '6.0.4'  => '207768',
    '6.0.3'  => '204106',
    '6.0.2'  => '196940',
    '6.0.1'  => '189883',
    '6.0'    => '182037',
    '5.0.11' => '241655',
    '5.0.10' => '233077',
    '5.0.9'  => '213964',
    '5.0.8'  => '201809',
    '5.0.7'  => '192438',
    '5.0.6'  => '185560',
    '5.0.5'  => '179365',
    '5.0.4'  => '172409',
    '5.0.3'  => '163460',
    '5.0.2'  => '149561',
    '5.0.1'  => '143156',
    '5.0'    => '140868',
    '4.3.7'  => '181874',
    '4.3.6'  => '153775',
    '4.3.5'  => '140437',
    '4.3.4'  => '136012',
    '4.3.3'  => '128297',
    '4.3.2'  => '123586',
    '4.3.1'  => '119532',
    '4.3'    => '115073',
    '4.2.5'  => '113996',
    '4.2.4'  => '110225',
    '4.2.3'  => '105575',
    '4.2.2'  => '96430',
    '4.1.8'  => '97242',
    '4.1.7'  => '95063',
    '4.1.6'  => '89596',
    '4.1.5'  => '85156',
    '4.1.4'  => '82143',
    '4.1.3'  => '80534',
    '4.1.2'  => '79191',
    '4.1.1'  => '78281',
    '4.1'    => '77833',
    '4.0.11' => '79031',
    '4.0.10' => '77146',
    '4.0.9'  => '74233',
    '4.0.8'  => '73243',
    '4.0.7'  => '72459',
    '4.0.6'  => '70313',
    '4.0.5'  => '69401',
    '4.0.4'  => '67724',
    '4.0.3'  => '65638',
    '4.0.2'  => '64889',
    '4.0.1'  => '64658',
    '3.4.14' => '79166',
    '3.4.13' => '75215',
    '3.4.12' => '69236',
    '3.4.11' => '65313',
    '3.4.10' => '60883',
    '3.4.9'  => '57762',
    '3.4.8'  => '54309',
    '3.4.6'  => '51113',
    '3.4.5'  => '47883',
    '3.4.3'  => '46779',
    '3.4.2'  => '46047',
    '3.4.1'  => '45588',
    '3.4'    => '44873',
  }
  $version = merge($known_versions, $user_versions)
}
