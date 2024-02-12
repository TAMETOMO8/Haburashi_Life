module ToothbrushesHelper
  def end_use_at_text(toothbrush)
    toothbrush.end_use_at ? '現在の使用終了日' : '使用終了日(目安として一ヶ月後の日付を表示しています)'
  end

  def brush_material_text
    Toothbrush.brush_materials_i18n.invert.map { |key, value| [key, value] }
  end

  def hardness_text
    Toothbrush.hardnesses_i18n.invert.map { |key, value| [key, value] }
  end

  def display_end_use_at(toothbrush)
    if toothbrush.end_use_at
      toothbrush.end_use_at.strftime('%Y-%m-%d')
    else
      toothbrush.created_at.since(1.month).strftime('%Y-%m-%d')
    end
  end

  def using_3days(toothbrush)
    (Time.current - 3.days > toothbrush.created_at && toothbrush.state != toothbrush.not_started?) ||
      (toothbrush.end_used? || toothbrush.cleaning? || toothbrush.recycling?)
  end
end
