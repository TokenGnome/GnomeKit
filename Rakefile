namespace :test do
	desc "Run tests in the 'Tests' scheme"
	task :run do
		$test_success = system("xctool -workspace GnomeKit.xcworkspace -scheme 'Tests' test -test-sdk iphonesimulator")
	end
end

desc "Run all of the GnomeKit tests"
task :test => ['test:run'] do
	puts "\033[0;31m!! unit tests failed" unless $test_success
	if $test_success
		puts "\033[0;31m!! All tests completed"
	else
		exit(-1)
	end
end

task :default => 'test'