log_error_exit()
{
  echo $@
  exit 1
}

if [ -z "$LAB_REGISTRY_HOST" ]; then
  log_error_exit "No registry host specified"
fi

if [ -z "$LAB_REGISTRY_USER" ]; then
  log_error_exit "No registry user specified"
fi

if [ -z "$LAB_REGISTRY_PASSWORD" ]; then
  log_error_exit "No registry password specified"
fi

docker login -u $LAB_REGISTRY_USER -p $LAB_REGISTRY_PASSWORD $LAB_REGISTRY_HOST

