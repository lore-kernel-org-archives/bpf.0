Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724C13C82E
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468590; cv=none; b=Fa7vUO/+vG2I9tEO2enOGaGFgPRw08uwsVBVvJSxnhy0rUOXbl6ZixwujE+ehj0ukuUYbSOVqcrj9RxgAswEbLZcnmX7VBBxHwtu7BV0xfVMRkTenzzUgYTxN+Mw0b0rBzOQtu3XKXLwU+1598+EG7dl2pyj8uaG3aNgN/IO4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468590; c=relaxed/simple;
	bh=SFVYgiAhN5n6ZboWPwZfMLTQxgSPFPXa88h8H3kQ6e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seUdTQj+hzg0hsabrcJbmYb1fz2l6BkfmD1WIiULFK6UMGfn6qTBcFuuyjboblGt9PMcRSMZFWfIGhzfOJTluMH4O/sMaM+NMbjOFDok7zE5beUZYhLfdwiN6V3VQAd4Yo5FD+plc0SVNzL0Qh5g1ZuAHh5ZGBGCsaeOLUedurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3vYF28PLz4f3jdT
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 23:56:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CE9A1A0199
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 23:56:23 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgBnu20k8AJmr1UrIQ--.65159S2;
	Tue, 26 Mar 2024 23:56:21 +0800 (CST)
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
Subject: [PATCH bpf-next v2] selftests/bpf: Enable cross platform testing for local vmtest
Date: Tue, 26 Mar 2024 15:57:36 +0000
Message-Id: <20240326155736.3480081-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnu20k8AJmr1UrIQ--.65159S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1kKrW3uw45Ww48ArykGrg_yoWrur15pw
	48Zr4ay3WrWF1Sgwn7ZF409FWfGrs5ZrW7CryUXry5Zw1xKF97ArySyayqqrnxW3s5Arsx
	ZF9agF98Cw17Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
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
v2:
- Specifies the -cpu for the ARM64.
- Completely renamed ARCH to PLATFORM.

 tools/testing/selftests/bpf/vmtest.sh | 40 +++++++++++++++++++--------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 65d14f3bbe30..825149a905e5 100755
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
+	CROSS_FLAGS=(-M virt,gic-version=3 -cpu cortex-a76 -smp 8)
 	BZIMAGE="arch/arm64/boot/Image"
+	ARCH="arm64"
 	;;
 *)
 	echo "Unsupported architecture"
@@ -38,7 +44,7 @@ ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
-	"tools/testing/selftests/bpf/config.${ARCH}")
+	"tools/testing/selftests/bpf/config.${PLATFORM}")
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
@@ -58,6 +64,10 @@ tools/testing/selftests/bpf. e.g:
 If no command is specified and a debug shell (-s) is not requested,
 "${DEFAULT_COMMAND}" will be run by default.
 
+Using PLATFORM= and CROSS_COMPILE= options will enable cross platform testing:
+
+  PLATFORM=<platform> CROSS_COMPILE=<toolchain> $0 -- ./test_progs -t test_lsm
+
 If you build your kernel using KBUILD_OUTPUT= or O= options, these
 can be passed as environment variables to the script:
 
@@ -109,7 +119,7 @@ newest_rootfs_version()
 {
 	{
 	for file in "${!URLS[@]}"; do
-		if [[ $file =~ ^"${ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
+		if [[ $file =~ ^"${PLATFORM}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
 			echo "${BASH_REMATCH[1]}"
 		fi
 	done
@@ -126,7 +136,7 @@ download_rootfs()
 		exit 1
 	fi
 
-	download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
+	download "${PLATFORM}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
 		zstd -d | sudo tar -C "$dir" -x
 }
 
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

