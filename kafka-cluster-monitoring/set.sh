#!/bin/bash

# echo "파라미터 개수 : $#"
# echo "첫 번째 파라미터: $1"
# echo "모든 파라미터 내용 : $@"

if [ "$EUID" -ne 0 ]; then 
  echo "root 권한으로 실행하세요."
# 파라미터 1개만 허용
elif [ "$EUID" -eq 0 ] && [ $# -ne 1 ] ; then
  echo "1개의 파라미터를 입력하세요. ex) ip"
else 
  HOST_IP=$1
  found=$(grep -r "HOST_IP" /etc/bash.bashrc)
  if [[ $found ]]; then  # 부정문은 ! 를 사용한다 (**! 이후 공백 필수)
    # 파일에서 정규식에 일치하는 값을 가진 로우 제거
    sed -i '/export HOST_IP=/d' /etc/bash.bashrc
  fi

  # 파일 수정
  echo export HOST_IP=$HOST_IP >> /etc/bash.bashrc
  # 수정한 환경 변수 설정 파일 시스템에 적용
  source /etc/bash.bashrc
  echo ">>> env 설정 완료"
  echo ">>> 결과: $(env | grep HOST_IP)"
  echo ">>> root 계정 out"
  sleep 1s
  exit 0
fi

### **실행시 주의 ###
# 위의 source /etc/bash.bashrc 명령은 해당 스크립트를 어떤 명령으로 실행했는지에 따라 env에 등록이 될 수도 있고 안될 수도 있다.  
# => bash로 스크립트를 실행하는 경우 적용되지 않는다. ex) "$ bash start.sh"
# => . 또는 source으로 스크립트를 실행해야한다.     ex) "$ . start.sh" || "$ source start.sh"

