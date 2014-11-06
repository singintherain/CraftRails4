require 'test_helper'

class PdfRenderTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, PdfRender
  end

  test "pdf request sends a pdf as file" do
    get home_path(format: :pdf)

    assert_match "PDF", response.body
    assert_equal "binary", headers["Content-Transfer-Encoding"]

    assert_equal "attachment; filename=\"contents.pdf\"",
      headers["Content-Disposition"]
    assert_equal "application/pdf", headers["Content-Type"]
  end

  test "pdf renderer users the specified template" do
    get another_path(format: :pdf)

    assert_match "PDF", response.body
    assert_equal "binary", headers["Content-Trasfer-Encoding"]

    assert_equal "attachment; filename=\"Contents.pdf\"",
      headers["Content-Disposition"]
    assert_equal "application/pdf", headers["Content-Type"]
  end
end
