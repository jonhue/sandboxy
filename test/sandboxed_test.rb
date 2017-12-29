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
            @post = FactoryGirl.create :post
            @purchase = FactoryGirl.create :purchase
            Sandboxy.environment = 'sandbox'
            @book = FactoryGirl.create :book
            @receipt = FactoryGirl.create :receipt
        end

        context '#sandbox_environment?' do
            should 'be true for @book & @receipt' do
                # @book.move_environment_sandbox ##### SHOULD NOT BE NECESSARY #####
                # @receipt.move_environment_live ##### SHOULD NOT BE NECESSARY #####
                assert_equal true, @book.sandbox_environment?
                assert_equal true, @receipt.sandbox_environment?
            end
        end

        context '#live_environment?' do
            should 'be true for @post & @purchase' do
                assert_equal true, @post.live_environment?
                assert_equal true, @purchase.live_environment?
            end
        end

        context '#move_environment_sandbox' do
            should 'move record to sandboxed environment' do
                @purchase.move_environment_sandbox
                assert_equal true, @purchase.sandbox_environment?
            end
        end

        context '#move_environment_live' do
            should 'move record to live environment' do
                @receipt.move_environment_live
                assert_equal true, @receipt.live_environment?
            end
        end
    end

end
