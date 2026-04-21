Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45363D9034
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782759; cv=none; b=CnLHY6JW7w4EWaoG6+1eAavTuJ0doMhxT+B1mW79xoftGLmi0M5fNTOv77JAQUrxqndRNaqkIVRoLAMOknYw7SQVmMiqmPIK5ixxxMRxvkmlRWx5KbMhUZLVxF5nR1NosWWA2lxkeIIA8egEgXAK/F/JFxpHZLa5HiBl9xJt2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782759; c=relaxed/simple;
	bh=sLPQeyR8mVxW4XpIOs1mOCDzO5p0hOUyZuf6j8UwJhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeFYY6Cxu2RLPh7noILFWBf4N9SNylSs1sIleStlPE69QFKZXDHtmV3mZDWSEDYnlEYuL5dHpN95cWiB4U6eO0gt53JfgI2RWt73EWSBYoI+UrxV4I7g9t86Gyun57k8jxpHBJdJ0ZupsDnh0YEwQ8x5FUn5D7CtV6zlDFGIWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.235.246])
	by mtasvr (Coremail) with SMTP id _____wAn4jyFjedpQH+cAA--.6769S3;
	Tue, 21 Apr 2026 22:45:25 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.235.246])
	by mail-app3 (Coremail) with SMTP id zS_KCgAHHnCFjedp+e2dAA--.2077S2;
	Tue, 21 Apr 2026 22:45:25 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
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
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v7 3/3] selftests/bpf: Add test for large offset bpf-to-bpf call
Date: Tue, 21 Apr 2026 22:45:04 +0800
Message-ID: <20260421144504.823756-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421144504.823756-1-tangyazhou@zju.edu.cn>
References: <20260421144504.823756-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAHHnCFjedp+e2dAA--.2077S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhIICmnmgY0zEgAAs0
X-CM-DELIVERINFO: =?B?QonJYwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9C2Mn7PIMrYmq+8/sRTXnbCu76sCQ1Mehv6mm443d5yPeUHXiAw1CiKL1UNVIRI6I36g
	Cqn61CfZYIGtYP8WwM2DVkx95UVDIGEfQxdS3vT46505eYBpe0Jd1XER3FgfsA==
X-Coremail-Antispam: 1Uk129KBj93XoWxZFyrGrykCF4fWF4kAFW8GrX_yoWrZFyrpa
	4kGFy5KF93Gay7Kr1xAFsrZF4YkFs7ZrWjyrWIqr90yw45J3s7Grs7KrWjqFy3ArZ5CwsY
	vFZFvas3Gr48JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnJ5rUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

Add a selftest to verify the verifier and JIT behavior when handling
bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.

The test utilizes an inline assembly block with ".rept 32765" to generate
a massive dummy subprogram. By placing this padding between the main program
and the target subprogram, it forces the verifier to process a bpf-to-bpf call
where the imm field exceeds the s16 range.

- When JIT is enabled, it asserts that the program is successfully loaded and
  executes correctly to return the expected value. Since patch 1/2 does not change
  the JIT behavior, the test passes whether the fix is applied or not.
- When JIT is disabled, it also asserts that the program is successfully loaded
  and executes correctly to return the expected value.
  - Before the fix, the verifier rewrites the call instruction with a truncated
    offset (here 32768 -> -32768) and lets it pass. When the program is executed,
    the call instruction causes a kernel panic due to an invalid jump target.
  - After the fix, the verifier correctly handles the large offset and allows
    it to pass. The program then executes correctly to return the expected value.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 .../selftests/bpf/prog_tests/call_large_imm.c | 29 ++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 46 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
new file mode 100644
index 000000000000..3ed61a8ca08c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "call_large_imm.skel.h"
+
+void test_call_large_imm(void)
+{
+	struct call_large_imm *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	skel = call_large_imm__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = call_large_imm__load(skel);
+
+	if (!ASSERT_OK(err, "load_should_succeed"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.call_large_imm_test);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+
+	if (ASSERT_OK(err, "prog_run_success"))
+		ASSERT_EQ(opts.retval, 3, "prog_retval");
+
+cleanup:
+	call_large_imm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/call_large_imm.c b/tools/testing/selftests/bpf/progs/call_large_imm.c
new file mode 100644
index 000000000000..7cdf1e6d80d8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/*
+ * A volatile global variable is used here, so that padding_subprog()
+ * will not be optimized, and it will not be really executed even if
+ * it is successfully loaded (when JIT is enabled).
+ */
+volatile int zero = 0;
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
+	asm volatile ("					\
+		r0 = 0;					\
+		.rept 32765;				\
+		r0 += 0;				\
+		.endr;					\
+	" ::: "r0");
+}
+
+static __attribute__((noinline)) int target_subprog(void)
+{
+	/* A volatile variable is used here to prevent optimization. */
+	volatile int magic_ret = 3;
+	return magic_ret;
+}
+
+SEC("syscall")
+int call_large_imm_test(void *ctx)
+{
+	if (zero)
+		padding_subprog();
+	return target_subprog();
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.53.0

