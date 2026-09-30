Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE803F107E;
	Wed, 30 Sep 2026 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750530; cv=none; b=sr4X4E3nLAxPg9ifBvbgCE6D8LTK4bBjc3poWjRugErPG4Za7ZDW9PEqfkIvx0r4v6aXAb07QRi20WoqAXWukPhw4oABlfkplVtt6A7rTTa1YoGAxS4Dqehl7SWR0NiWPCnZATBTZUiRkRSWSn5qaCzB+PzWqC1O8gAQxyiDocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750530; c=relaxed/simple;
	bh=UgWqlogYKJeREX090vaMsHdWFYgaUReUhANyBQGEuOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFKoc8ym7lIoafRezjzaeBd3YJrLY02szFerQTGwUjWeBFj1jlrhzHPHKKyGsZZoHWfVH6Aa9VZCGu5rScfZdylCFV1oTvn/2pXTwjAhEe/gzS2k0ZXlY3hqhttFtcwGxUH2SGm/FFabVHObx1osRcA/y5gLPoCNU/ByfgigfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvlnM0jrlzKHMVQ;
	Wed, 30 Sep 2026 14:41:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 06AFF40573;
	Wed, 30 Sep 2026 14:42:04 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgD3xSg2r7xqwDvcCA--.7693S5;
	Wed, 30 Sep 2026 14:42:01 +0800 (CST)
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
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Update qemu config for riscv64 in vmtest.sh
Date: Wed, 30 Sep 2026 06:46:06 +0000
Message-Id: <20260930064607.1908864-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930064607.1908864-1-pulehui@huaweicloud.com>
References: <20260930064607.1908864-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3xSg2r7xqwDvcCA--.7693S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UAF43WF47KrykZF4Dtwb_yoW8Zr1Up3
	ykAryFkFyFg3WfWF1kZrWj9r4rGFsaqrW8Cw48Jw13Zw1IyFykXrn7Kw4Ut3Z3WFZYgrZ8
	C34SgFyY93WkJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRiuWl3UUUUU==
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

