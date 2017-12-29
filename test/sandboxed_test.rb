require File.dirname(__FILE__) + '/test_helper'

class SandboxedTest < ActiveSupport::TestCase

    context 'instance methods' do
        setup do
            @post = FactoryGirl.create :post
        end

        should 'be defined' do
            assert @post.respond_to? :move_environment_sandbox
            assert @post.respond_to? :move_environment_live
            assert @post.respond_to? :sandbox_environment?
            assert @post.respond_to? :live_environment?
        end
    end

    context 'sandboxed' do
        setup do
            Sandboxy.environment = 'live'
            @post = FactoryGirl.create :post
            @purchase = FactoryGirl.create :purchase
            Sandboxy.environment = 'sandbox'
            @book = FactoryGirl.create :book
            @receipt = FactoryGirl.create :receipt
        end

        context '#{}_environment?' do
            should 'be true for @book & @receipt' do
                assert_equal false, @post.sandbox_environment?
                assert_equal false, @purchase.sandbox_environment?
                assert_equal true, @book.sandbox_environment?
                assert_equal true, @receipt.sandbox_environment?
                assert_equal true, @post.live_environment?
                assert_equal true, @purchase.live_environment?
                assert_equal false, @book.live_environment?
                assert_equal false, @receipt.live_environment?
            end
        end

        context '#move_environment_{}' do
            should 'move record to sandboxed environment' do
                assert_equal true, @purchase.live_environment?
                @purchase.move_environment_sandbox
                assert_equal true, @purchase.sandbox_environment?
                @purchase.move_environment_sandboxy
                assert_equal true, @purchase.sandboxy_environment?
                @purchase.move_environment_live
                assert_equal true, @purchase.live_environment?
            end
        end
    end

end
