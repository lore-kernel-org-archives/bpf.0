Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D961763E6
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463802; cv=none; b=R2YCKE9W7YjLC9iZ/tMsxmgNauYMNsGCAVOPWvLShd3usAzzPSGEsqmh0/SI9S6wJ9wwWR3xndEhXI2Fla49cpQ7SB0rl0H+AI4lf/2vsF8+Hk2otuEO5XBDHyFXC92CQlCir1kTaMdsTr5WLOgqVrFZPPD4/DkDPTfB4Xq3qL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463802; c=relaxed/simple;
	bh=BnnobBd+nr5OHqVJN5LxehhCkRKzOcKDzEnKk6VcuBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3anWe4cjY5VNjnGzD/E5cQMVo7NU3lDxF0SY6off2AtrgOeg1BLoK0QMclpW/eHhHty4l5VPiorURFugicNoefRBGgx7ZfHdUE6ehr9pk98f6s+Fm5gK8KAKksXpJ/mc6Zc+gHegssV8RsbMfgomLs+WgES8eu+F0onyi6QOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3sn54wb1z4f3l1m
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 22:36:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C7CB01A0172
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 22:36:33 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ew1w3QJmjdyVIA--.25246S2;
	Tue, 26 Mar 2024 22:36:33 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next] selftests/bpf: Enable cross platform testing for local vmtest
Date: Tue, 26 Mar 2024 14:37:48 +0000
Message-Id: <20240326143748.3338473-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3Ew1w3QJmjdyVIA--.25246S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr48uFWDCFWkAw17XFyfCrg_yoW5uw1rpw
	s5Zw4aya4ruF1Sgwn7AF409FWfGwn5ZrW7Gry7X343XwnaqFn2yryftayqqrnxWryftrsx
	ZF92gF90k3WUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UdHUDUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The variable $ARCH in the current script is platform semantics, not
kernel semantics. Rename it to $PLATFORM so that we can easily use $ARCH
in cross-compilation. For now, Using PLATFORM= and CROSS_COMPILE=
options will enable cross platform testing:

  PLATFORM=<platform> CROSS_COMPILE=<toolchain> vmtest.sh -- ./test_progs

Meanwhile, some descriptions have been corrected.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 34 ++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 65d14f3bbe30..10e24f25cd40 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -4,28 +4,34 @@
 set -u
 set -e
 
-# This script currently only works for x86_64 and s390x, as
-# it is based on the VM image used by the BPF CI, which is
+# This script currently only works for the following platforms,
+# as it is based on the VM image used by the BPF CI, which is
 # available only for these architectures.
-ARCH="$(uname -m)"
-case "${ARCH}" in
+PLATFORM="${PLATFORM:-$(uname -m)}"
+case "${PLATFORM}" in
 s390x)
 	QEMU_BINARY=qemu-system-s390x
 	QEMU_CONSOLE="ttyS1"
-	QEMU_FLAGS=(-smp 2)
+	HOST_FLAGS=(-smp 2 -enable-kvm)
+	CROSS_FLAGS=(-smp 2)
 	BZIMAGE="arch/s390/boot/vmlinux"
+	ARCH="s390"
 	;;
 x86_64)
 	QEMU_BINARY=qemu-system-x86_64
 	QEMU_CONSOLE="ttyS0,115200"
-	QEMU_FLAGS=(-cpu host -smp 8)
+	HOST_FLAGS=(-cpu host -enable-kvm -smp 8)
+	CROSS_FLAGS=(-smp 8)
 	BZIMAGE="arch/x86/boot/bzImage"
+	ARCH="x86"
 	;;
 aarch64)
 	QEMU_BINARY=qemu-system-aarch64
 	QEMU_CONSOLE="ttyAMA0,115200"
-	QEMU_FLAGS=(-M virt,gic-version=3 -cpu host -smp 8)
+	HOST_FLAGS=(-M virt,gic-version=3 -cpu host -enable-kvm -smp 8)
+	CROSS_FLAGS=(-M virt,gic-version=3 -smp 8)
 	BZIMAGE="arch/arm64/boot/Image"
+	ARCH="arm64"
 	;;
 *)
 	echo "Unsupported architecture"
@@ -58,6 +64,10 @@ tools/testing/selftests/bpf. e.g:
 If no command is specified and a debug shell (-s) is not requested,
 "${DEFAULT_COMMAND}" will be run by default.
 
+Using PLATFORM= and CROSS_COMPILE= options will enable cross platform testing:
+
+  PLATFORM=<platform> CROSS_COMPILE=<toolchain> $0 -- ./test_progs -t test_lsm
+
 If you build your kernel using KBUILD_OUTPUT= or O= options, these
 can be passed as environment variables to the script:
 
@@ -244,12 +254,17 @@ EOF
 		exit 1
 	fi
 
+	if [[ "${CROSS_COMPILE}" != "" ]]; then
+		QEMU_FLAGS=("${CROSS_FLAGS[@]}")
+	else
+		QEMU_FLAGS=("${HOST_FLAGS[@]}")
+	fi
+
 	${QEMU_BINARY} \
 		-nodefaults \
 		-display none \
 		-serial mon:stdio \
 		"${QEMU_FLAGS[@]}" \
-		-enable-kvm \
 		-m 4G \
 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
 		-kernel "${kernel_bzimage}" \
@@ -384,7 +399,8 @@ main()
 	fi
 
 	local kconfig_file="${OUTPUT_DIR}/latest.config"
-	local make_command="make -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
+	local make_command="make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \
+			    -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
 
 	# Figure out where the kernel is being built.
 	# O takes precedence over KBUILD_OUTPUT.
-- 
2.34.1

