require File.dirname(__FILE__) + '/test_helper'

class SandboxTest < ActiveSupport::TestCase

    context '#sandbox' do
        setup do
            @post = FactoryGirl.create :post
            @purchase = FactoryGirl.create :purchase
            $sandbox = true
            @book = FactoryGirl.create :book
            @receipt = FactoryGirl.create :receipt
        end

        context 'desandbox' do
            should 'return all records' do
                assert_equal Some.unscope(:joins, :where).all, Some.desandbox
            end
        end

        context '#live' do
            setup do
                $sandbox = false
            end

            should 'return all live records' do
                assert_equal Some.all, Some.live
            end
        end

        context '#sandboxed' do
            setup do
                $sandbox = true
            end

            should 'return all sandboxed records' do
                assert_equal Some.all, Some.sandboxed
            end
        end
    end

end
