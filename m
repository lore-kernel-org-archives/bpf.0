Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659E287503
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060879; cv=none; b=UJgf7ny5KOG+zE3tSQSoK+TNFRpT7lUIE3qcT2S7DN4/ez+bDr1vCqtxJFP7dYEGLtryzHRk9qZ5atmPXhQP9g2Ujzy7EzBDDDvUE5o/REqbbBgmoSBWWuqwBokbUy1gbvpa/T+4KPY+LyGCuC+IH8Id1n8cI8T23xpoauXahbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060879; c=relaxed/simple;
	bh=M5U8GwXSAxqmTVk8bfDwve0rCZURnzE5TlsmVhdIELA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQYRvkBSsWGT2aGbAbYxD1gmVwn7P9i01ZCRHPpyKt/FetLWF8CnSn/YT90RnSCXCObd2BZeknck+Vs1MnAC48mCDSDgS2paUpu5QMS50A73dLcTL8TJ2Y1FmrKzaExoY9SeWemfTbYA7wAVPrxkrpi+QCyzoCqT2bpe2gkNJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDXGKU6DvtpI+EWAQ--.1121S3;
	Wed, 06 May 2026 17:47:38 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgBXWaM6DvtppWffAA--.1669S2;
	Wed, 06 May 2026 17:47:38 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	qmo@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v10 3/3] selftests/bpf: Add test for large offset bpf-to-bpf call
Date: Wed,  6 May 2026 17:47:14 +0800
Message-ID: <20260506094714.419842-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
References: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBXWaM6DvtppWffAA--.1669S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg8DCmn6SA9FuwAAsu
X-CM-DELIVERINFO: =?B?rcmdYAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9CYam54vqqrnYVSZ+mCkolghrQp69TZP43K7czEB3csDCwkO8Vm+9s76UWOeHaN9NSx4
	x45IgsJbPuFGH39LXgNi6p+eM8o89b6ojwFjsG+ayF8VeQRRp4TLMKEIHSCpjA==
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1fGF43Cw48JFW7Gr1UXFc_yoW7GF4rpF
	1vgF9xKF97Ca47KFy7AFsrZFyrKFs3Z3yUtr48Ar98AF1UJr97JrZ7KrWUXFyfCanavw1F
	vrW2v343Gr18ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07je-eOUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

Add a selftest to verify the verifier and JIT behavior when handling
bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.

The test utilizes an inline assembly block with ".rept 32765" to generate
a massive dummy subprogram. By placing this padding between the main
program and the target subprogram, it forces the verifier to process a
bpf-to-bpf call where the imm field exceeds the s16 range.

- When JIT is enabled, it asserts that the program is successfully loaded
  and executes correctly to return the expected value. Since the fix
  does not change the JIT behavior, the test passes whether the fix is
  applied or not.
- When JIT is disabled, it also asserts that the program is successfully
  loaded and executes correctly to return the expected value 3.
  - Before the fix, the verifier rewrites the call instruction with a
    truncated offset (here 32768 -> -32768) and lets it pass. When the
    program is executed, the call instruction will go to a wrong target
    (the landing pad) instead of the intended subprogram, then return -1
    and fail.
  - After the fix, the verifier correctly handles the large offset and
    allows it to pass. The program then executes correctly to return the
    expected value 3.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_call_large_imm.c       | 66 +++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_imm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a96b25ebff23..06cd24e37b3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -22,6 +22,7 @@
 #include "verifier_bswap.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
+#include "verifier_call_large_imm.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -170,6 +171,7 @@ void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
+void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
new file mode 100644
index 000000000000..7998df07f6a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int call_happened = 0;
+
+/*
+ * 32765 is the exact minimum number of padding instructions needed to
+ * trigger the verifier failure, because:
+ * 1. Counting the wrapper instructions around the padding block (one
+ *    "r0=0" and two "exit" instructions), the actual jump distance
+ *    evaluates to N + 3.
+ * 2. To overflow the s16 max bound (32767), we need N + 3 > 32767.
+ * Thus, N = 32765 is the exact minimum padding size required.
+ */
+static __attribute__((noinline)) void padding_subprog(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	".rept 32765;"
+	"r0 += 0;"
+	".endr;"
+	::: __clobber_all);
+}
+
+static __attribute__((noinline)) int target_subprog(void)
+{
+	/* Use volatile variable here to prevent optimization. */
+	volatile int magic_ret = 3;
+	return magic_ret;
+}
+
+SEC("syscall")
+__success __retval(3)
+int call_large_imm_test(void *ctx)
+{
+	/*
+	 * Landing pad to handle call error on kernel without the fix,
+	 * preventing kernel panic.
+	 */
+	asm volatile (
+	"r0 = 0;"
+	".rept 32768;"
+	"r0 += 0;"
+	".endr;"
+	::: __clobber_all);
+
+	/*
+	 * The call_happened variable is 1 only when the call insn wrongly
+	 * go back to the landing pad above.
+	 */
+	if (call_happened == 1) {
+		/* Use volatile variable here to prevent optimization. */
+		volatile int flag = -1;
+		return flag;
+	}
+
+	call_happened = 1;
+
+	padding_subprog();
+
+	return target_subprog();
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.54.0

