Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52D4CDA3F;
	Tue, 29 Sep 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671856; cv=none; b=EJ2Sw2QyyIALPZjbpNDhQdSgNNKjacMBk+ywtwRsIvfvesvM6jpFc2XkUAUYc4Elgb+728/VyyUcdEXzmXoCxeR/tYdEgeWXnefXvp9la2quBvG073pv9rbLHt4LTF6VdGc2n4fpqzeHnGGq87wFPO9wEq/lk7hA3N0VMM9QDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671856; c=relaxed/simple;
	bh=8C9okB4Ewf5oYij9Ct6wykXJweNVq01Rh78cipkEWck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVM/82VdPt9VIxgD4B8BaiiW8kQEgjn8qoNxVNMNlp/WVLK4kMkcE1daB48Uy3GWNAJZVZRAbRYoqPh/1zRhyZF7CoX7BnJqnsDUJhG4Q4RJzgFgU8ZaUrmo7dPIBWkowwBSlphonpZlKwBQSOyamGyqy0zZ9cplnSfq7cnBH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvBhH4wR3zKHMdj;
	Tue, 29 Sep 2026 16:50:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 170B040931;
	Tue, 29 Sep 2026 16:50:43 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDn_iHie7tqgXJpCA--.48809S4;
	Tue, 29 Sep 2026 16:50:42 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable callx related testcases for RV64
Date: Tue, 29 Sep 2026 08:54:50 +0000
Message-Id: <20260929085450.1852617-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929085450.1852617-1-pulehui@huaweicloud.com>
References: <20260929085450.1852617-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDn_iHie7tqgXJpCA--.48809S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15Cw4kJF18uFWxCFykKrg_yoW5uw4xpa
	1kZ34vyw1SkF1akF1xJF4jvrZ3GF4kZryUAFW8ZrW5uFnrJrWxXrs3KFZ8Jrn0g39Yvr4r
	Zw1xt3s3ur48Aw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRREfO5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Enable callx bpf selftests for RV64 now that the RV64 JIT supports
indirect calls to subprogs.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c | 3 ++-
 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_callx.c          | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
index 42b33d5876b1..cc63b84e4d94 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
@@ -8,7 +8,8 @@
 #include <linux/filter.h>
 #include <bpf/btf.h>
 
-#if defined(__x86_64__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__aarch64__) || \
+    (defined(__riscv) && __riscv_xlen == 64)
 
 #define CALLEE_INSN	6
 #define DATA		0x1234
diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
index fc5181c5b5ba..f6ef67c3141e 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -3,7 +3,8 @@
 
 #include "callx_rodata.lskel.h"
 
-#if defined(__x86_64__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__aarch64__) || \
+    (defined(__riscv) && __riscv_xlen == 64)
 
 static void run(int prog_fd, int expected, const char *name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index bc31d0221f6a..7e59188d9fca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -7,7 +7,8 @@
 #include "../../../include/linux/filter.h"
 
 /* gcc doesn't support indirect calls */
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)
+#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
 
 #define CALLX_INSN(DST, SRC, OFF, IMM) \
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index db3169a1ddf6..3ebd50f9c4b6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -7,7 +7,8 @@
 #include "../../../include/linux/filter.h"
 
 /* gcc doesn't support indirect calls */
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)
+#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
 
 /*
  * Read-only data with pointers to functions, where the compiler puts tables
-- 
2.34.1

