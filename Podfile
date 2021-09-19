
use_frameworks!

workspace 'GoliathCurrencyChanger'

def shared_pods
    pod 'Swinject', '~> 2.7.1'
end

# Common module
def common_pods
end

target 'Common' do
  project 'Common/Common.project'
  shared_pods
  common_pods
end

# Presentation module
def presentation_pods
end

target 'Presentation' do
  project 'Presentation/Presentation.project'
  shared_pods
  presentation_pods
end

# Domain module
def domain_pods
end

target 'Domain' do
  project 'Domain/Domain.project'
  shared_pods
  domain_pods
  
  target 'DomainTests' do
      inherit! :search_paths
      domain_pods
    end
end

# Data module
def data_pods
  pod 'Moya', '~> 15.0'
end

target 'Data' do
  project 'Data/Data.project'
  shared_pods
  data_pods
end

# GoliathCurrencyChanger
def goliathCurrencyChanger_pods
  shared_pods
  presentation_pods
  domain_pods
  data_pods
  common_pods
end

target 'GoliathCurrencyChanger' do
  project 'GoliathCurrencyChanger.project'
  goliathCurrencyChanger_pods
end

