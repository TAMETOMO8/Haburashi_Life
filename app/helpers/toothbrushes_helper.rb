module ToothbrushesHelper
  def end_use_at_text(toothbrush)
    if toothbrush.not_started?
      '使用終了日(目安として一ヶ月後の日付を表示しています)'
    elsif toothbrush.electric? && toothbrush.using?
      '電動歯ブラシの交換日'
    elsif toothbrush.using?
      '現在の使用終了日'
    else
      '使用終了日'
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

  def not_end_used_only(toothbrush)
    if toothbrush.not_started? || toothbrush.using?
      false
    else
      true
    end
  end

  def border_color(toothbrush)
    if toothbrush.recycling?
      "recycling-border"
    elsif toothbrush.cleaning?
      "cleaning-border"
    elsif toothbrush.using?
      "using-border"
    elsif toothbrush.end_used?
      "end_used-border"
    end
  end

  def improvement_comment(improvement) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    if improvement < 30
      'まだまだ改善が必要ですね・・・みんなで力を合わせて綺麗にしましょう!'
    elsif improvement >= 30 && improvement < 50
      '少し綺麗になってきましたね。でも、もっと綺麗にできそうですね?'
    elsif improvement >= 50 && improvement < 70
      'どんどん綺麗になってきています!この調子で綺麗にしていきましょう!'
    elsif improvement >= 70 && improvement < 100
      'かなり綺麗になりました!あと一息、みんなで力を合わせましょう!'
    elsif improvement <= 100
      'みなさんのおかげで環境が整いました!おめでとうございます!'
    end
  end
end
