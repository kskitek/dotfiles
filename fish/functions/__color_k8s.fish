function __color_k8s
  set normal (set_color normal)
  set red (set_color red)
  set yellow (set_color yellow)
  set green (set_color green)
  set blue (set_color blue)

   sed "s/Running/$green Running$normal/g" \
  | sed "s/Bound/$green Bound$normal/g" \
  | sed "s/Pending/$yellow Pending$normal/g" \
  | sed "s/Completed/$blue Completed$normal/g" \
  | sed "s/Error/$red Error$normal/g" \
  | sed "s/ImagePullBackOff/$red ImagePullBackOff$normal/g" \
  | sed "s/CrashLoopBackOff/$red CrashLoopBackOff$normal/g"
  # TODO container config error
end
