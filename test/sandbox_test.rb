require File.dirname(__FILE__) + '/test_helper'

class SandboxTest < ActiveSupport::TestCase

    context 'scopes' do
        should 'be defined' do
            assert Some.respond_to? :live_environment_scoped
            assert Some.respond_to? :sandbox_environment_scoped
            assert Some.respond_to? :live_environment
            assert Some.respond_to? :sandbox_environment
            assert Some.respond_to? :desandbox
        end
    end

    context 'sandbox' do
        setup do
            Sandboxy.environment = 'live'
            @post = FactoryGirl.create :post
            @purchase = FactoryGirl.create :purchase
            Sandboxy.environment = 'sandbox'
            @book = FactoryGirl.create :book
            @receipt = FactoryGirl.create :receipt
        end

        context '#desandbox' do
            should 'return all records' do
                assert_equal Some.unscope(:joins, :where).all, Some.desandbox
            end
        end

        context '#{}_environment' do
            should 'return all live records' do
                Sandboxy.environment = 'live'
                assert_equal Some.all, Some.live_environment
                Sandboxy.environment = 'sandbox'
                assert_equal Some.all, Some.sandbox_environment
            end
        end
    end

end
