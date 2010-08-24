use Module::Build;

Module::Build -> new
(
	module_name	=> 'Set::Array',
	license		=> 'artistic',
	dist_author	=> 'Ron Savage <ron@savage.net.au>',
	build_requires	=>
	{
		Test::Deep	=> 0,
		Test::More	=> 0,
		Test::Pod	=> 0,
	},
	requires	=>
	{
		Carp	=> 0,
		Want	=> 0,
	},
) -> create_build_script();
