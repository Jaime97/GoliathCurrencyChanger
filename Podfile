
use_frameworks!

workspace 'GoliathCurrencyChanger'

# Presentation module
def presentation_pods
  pod 'Swinject', '~> 2.7.1'
end

target 'Presentation' do
  project 'Presentation/Presentation.project'
  presentation_pods
end

# Domain module
def domain_pods
  pod 'Swinject', '~> 2.7.1'
end

target 'Domain' do
  project 'Domain/Domain.project'
  domain_pods
end

# Data module
def data_pods
  pod 'Swinject', '~> 2.7.1'
  pod 'Moya', '~> 15.0'
end

target 'Data' do
  project 'Data/Data.project'
  data_pods
end

# GoliathCurrencyChanger
def goliathCurrencyChanger_pods
  pod 'Swinject', '~> 2.7.1'
  presentation_pods
  domain_pods
  data_pods
end

target 'GoliathCurrencyChanger' do
  project 'GoliathCurrencyChanger.project'
  goliathCurrencyChanger_pods
end

