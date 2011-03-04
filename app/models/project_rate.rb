class ProjectRate < Rate
  referenced_in :project
  referenced_in :user
end