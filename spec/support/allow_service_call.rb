# frozen_string_literal: true

def allow_service_call(service_klass, with: nil, to_return: nil, to_raise: nil)
  stub = allow(service_klass).to receive(:new)

  stub.with(*with) if with
  stub.and_return(instance_double = double)
  instance_stub = allow(instance_double).to receive(:call)
  instance_stub.and_return(to_return) if to_return
  instance_stub.and_raise(to_raise) if to_raise
  instance_stub
end
