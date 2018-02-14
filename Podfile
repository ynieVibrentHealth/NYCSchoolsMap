# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def shared_pods
	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'Alamofire'
	pod 'PhoneNumberKit'
	pod 'SnapKit'
    pod 'ObjectMapper'
end

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'NYCSchools' do
	shared_pods
end

target 'NYCSchoolsTests' do
	shared_pods
	testing_pods
end

target 'NYCSchoolsUITests' do
	shared_pods
	testing_pods
end
