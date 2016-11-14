module DeptsHelper
  def dept_status(project)
     if project
      return "プロジェクト"
     else
      return "部署"
     end
  end
end
