module ToothbrushesHelper
  def end_use_at_text(toothbrush)
    if toothbrush.using?
      '現在の使用終了日'
    elsif toothbrush.not_started?
      '使用終了日(目安として一ヶ月後の日付を表示しています)'
    else
      '使い終わった日'
    end
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

  def only_not_end_used(toothbrush)
    if toothbrush.not_started? || toothbrush.using?
      false
    else
      true
    end
  end
end
