class MetaController < ApplicationController

  # called in the event the study needs to be halted for ethical or
  # logistical reasons
  # Params:
  #   token  => the halting token assigned to this experiment
  #   reason => the reason (if any) given to participants for the
  #             study's untimely conclusion.
  def halt
    if params[:id] == Study.singleton.halting_param
      Study.halt!(params[:reason])
      render text: "Halted"
    else
      render text: "No"
    end
  end

end
