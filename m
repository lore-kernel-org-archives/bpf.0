Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95C42CAEB;
	Tue, 29 Sep 2026 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670925; cv=none; b=DlqCpyrPdtTdXuU7CWOQ8Nl3p6Q49ceTR2fV8ovMFOMPtYDvzV9NjYiSup+zvxdX/kU2F10U3eZfcjgWGFPD1bMG7tMwEBcED3iN0wzPEbAidlA4e5pJ0Kik0niPZu+4mHBi4dWeeC1D8ceHkt5bhX63ODC6OvZDTNIHUjI2t+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670925; c=relaxed/simple;
	bh=UgWqlogYKJeREX090vaMsHdWFYgaUReUhANyBQGEuOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eyu1BXv2oAnOARAWwY/qrV0Kany7oA5UcF9us90tMIUgZcLMXMKDt6331CSufiWRHnFQJtfi/1vQEAqQklH6MSNp5hRrVNZrY0d8HEogZ1AABcv7biHo82gf5VkVQWfc/h3r1JDMkWYcn/w5ZbHNCX8VvSUrngVJD+S7ipUorcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvBLV0W9szKHMcv;
	Tue, 29 Sep 2026 16:34:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 78CBA40572;
	Tue, 29 Sep 2026 16:35:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBXdShEeLtqhxloCA--.42471S6;
	Tue, 29 Sep 2026 16:35:17 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Update qemu config for riscv64 in vmtest.sh
Date: Tue, 29 Sep 2026 08:39:23 +0000
Message-Id: <20260929083924.1851840-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929083924.1851840-1-pulehui@huaweicloud.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXdShEeLtqhxloCA--.42471S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UAF43WF47KrykZF4Dtwb_yoW8Zr1Up3
	ykAryFkFyFg3WfWF1kZrWj9r4rGFsaqrW8Cw48Jw13Zw1IyFykXrn7Kw4Ut3Z3WFZYgrZ8
	C34SgFyY93WkJ37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0189tUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When running vmtest.sh on riscv64, the kernel panic at boot due to an
illegal instruction. This is because '-cpu rv64' only enables a baseline
set of riscv extensions, whereas the kernel or toolchain requires newer
extensions. Switch to '-cpu max' so qemu enables all supported
extensions.

Additionally, qemu's pmu emulation for riscv64 currently has issues,
causing perf_event_open-related tests to fail. Temporarily disable the
sscofpmf extension to bypass these failures for now, and will try to
investigate and address it later.

While at it, update the libbpf/ci branch in INDEX_URL from 'master' to
'main'.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index e7e0b419a0b8..7f294794de67 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -39,7 +39,7 @@ riscv64)
 	QEMU_BINARY=qemu-system-riscv64
 	QEMU_CONSOLE="ttyS0,115200"
 	HOST_FLAGS=(-M virt -cpu host -enable-kvm -smp 8)
-	CROSS_FLAGS=(-M virt -cpu rv64,sscofpmf=true -smp 8)
+	CROSS_FLAGS=(-M virt -cpu max,sscofpmf=false -smp 8)
 	BZIMAGE="arch/riscv/boot/Image"
 	ARCH="riscv"
 	;;
@@ -65,7 +65,7 @@ OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
 	"tools/testing/selftests/bpf/config.${PLATFORM}")
-INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
+INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/main/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
-- 
2.34.1

