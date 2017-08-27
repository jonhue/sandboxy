require File.dirname(__FILE__) + '/test_helper'

class SandboxedTest < ActiveSupport::TestCase

    context 'instance methods' do
        setup do
            @post = FactoryGirl.create :post
        end

        should 'be defined' do
            assert @post.respond_to? :make_sandboxed
            assert @post.respond_to? :make_live
            assert @post.respond_to? :sandboxed?
            assert @post.respond_to? :live?
        end
    end

    context 'sandboxed' do
        setup do
            @post = FactoryGirl.create :post
            @purchase = FactoryGirl.create :purchase
            $sandbox = true
            @book = FactoryGirl.create :book
            @receipt = FactoryGirl.create :receipt
        end

        context '#sandboxed?' do
            should 'be true for @book & @receipt' do
                @book.make_sandboxed ##### SHOULD NOT BE NECESSARY #####
                @receipt.make_sandboxed ##### SHOULD NOT BE NECESSARY #####
                assert_equal true, @book.sandboxed?
                assert_equal true, @receipt.sandboxed?
            end
        end

        context '#live?' do
            should 'be true for @post & @purchase' do
                assert_equal true, @post.live?
                assert_equal true, @purchase.live?
            end
        end

        context '#make_sandboxed' do
            should 'move record to sandboxed environment' do
                @purchase.make_sandboxed
                assert_equal true, @purchase.sandboxed?
            end
        end

        context '#make_live' do
            should 'move record to live environment' do
                @receipt.make_live
                assert_equal true, @receipt.live?
            end
        end
    end

end
