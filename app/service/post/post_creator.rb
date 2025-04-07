# frozen_string_literal: true

class Post::PostCreator < ApplicationService
  param :post_params
  option :post, default: -> { Post.new }

  def call
    case publish_type
    when "Article" then post_builder article_builder
    when "Report" then post_builder report_builder
    when "Chapter" then post_builder chapter_builder
    end
  end

  private

  def publish_type
    @publish_type ||= post_params.fetch(:publishable_type, 'Article')
  end

  def article_builder
    Article.new(doi: post_params[:doi], journal_id: post_params[:journal_id])
  end

  def chapter_builder
    Chapter.new(page_count: post_params[:page_count], isbn: post_params[:isbn], publisher: post_params[:publisher])
  end

  def report_builder
    Report.new(conference_name: post_params[:conference_name], conference_place: post_params[:conference_place], reporter_id: post_params[:reporter_id])
  end

  def post_builder(type)
    type.save! unless type.persisted?
    post.publishable = type
    post.author_ids = post_params[:author_ids].reject(&:blank?).map(&:to_i)
    post.title, post.original_title = post_params[:title], post_params[:original_title]
    post.date_publishing = post_params[:date_publishing]
    post.save!
    post
  end
end