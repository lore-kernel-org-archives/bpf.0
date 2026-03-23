Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E636E497
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253915; cv=none; b=sibCefPvoizBFjSD0qORDzKYIgJDQ+53pknrXM5TfYimHuhkECKCsnRVUxVnG5gFRMGUy3MeXhF7G21ppeyxX5zxtHdYpAldnXFnmPwqVW0j0/nhgaDss1X2kTEgspIc2IG4xwzgSePjlY1bpnmQpPwLBIhno2KBLEmezs7c/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253915; c=relaxed/simple;
	bh=cROYIo3PsyT2VgE9b1MzGFQPMTkqvi7XZH4JIzGyj5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYd0wy7py0BMbmGwihpIavr0nNbUZI0pqMgHf1Fox4TU1pn+gnCYDhVeavKgsAqoAKDIl37zv3jTG/gzaxdJPbnLlrxzk4FMmEX0fMDjWCL6oYEmJjDDosl87uXCmP2EqS0zD5ge1UP6q4St9Weryn/Br7p/eOWBOcSDR/RTsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wDX36c498Bpps1GAA--.946S3;
	Mon, 23 Mar 2026 16:18:00 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app4 (Coremail) with SMTP id zi_KCgCnizQ498BpMUUMAA--.2618S2;
	Mon, 23 Mar 2026 16:18:00 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf v2 2/3] selftests/bpf: Add test for large offset bpf-to-bpf call
Date: Mon, 23 Mar 2026 16:17:47 +0800
Message-ID: <20260323081748.106603-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
References: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCnizQ498BpMUUMAA--.2618S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMQCmm8UYsYPgADs1
X-CM-DELIVERINFO: =?B?seWN/QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BZfZ83D7fDWWCSgyGjOU49RJ9A9vLhKHwKiK/4QwaVPdboBcs27S1YYv96N4TzZ3WOW
	xN7G7TBP04KFoWpJYZDNoiV2c1qWeEQqk/rcmsNpmELmaliZ3sufLgrMGjFZ2g==
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1fXFWxJF13XrWkGF43XFc_yoW7Aw1xpa
	4kWFyrKF1xGay7Kr17Aa9rZF45GF4kZFWjyr4Iqry5Awn8Ar97Grs7Kr4YqFy3CrZ5ZwnY
	vFZIya93Gr48JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2Ta0DUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

Add a selftest to verify the verifier and JIT behavior when handling
bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.

The test utilizes an inline assembly block with ".rept 200000" to generate
a massive dummy subprogram. By placing this padding between the main program
and the target subprogram, it forces the verifier to process a bpf-to-bpf call
with the imm field exceeding the s16 range.

The user-space test driver dynamically adapts to the host's configuration:
- When JIT is enabled, it asserts that the program is successfully loaded,
  JIT-compiled, and executes correctly to return the expected value.
- When JIT is disabled, it asserts that the verifier cleanly rejects the
  program with -EINVAL (or -ENOSPC if the log buffer is truncated), matching
  the expected "offset out of range" error log.

Note: To ensure the test is both effective at load time and efficient at
runtime, two specific tricks are employed:
1. Prevent Compiler Optimization: A volatile variable (magic_ret) is used
   inside target_subprog(). This prevents the compiler from optimizing
   the function away or aggressively inlining it, ensuring the subprogram
   and the call instruction are strictly retained in the final BPF bytecode.
2. Prevent Execution Degradation: The massive padding subprogram is
   conditionally called using a global volatile variable ("int zero", whose
   value is actually 0). This forces the verifier to statically analyze the
   branch and calculate the giant jump offset, but allows the runtime to
   completely bypass the 200,000 dummy instructions, preventing performance
   degradation during test execution.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 .../selftests/bpf/prog_tests/call_large_imm.c | 53 +++++++++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 37 +++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
new file mode 100644
index 000000000000..95d51b3cc6b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "call_large_imm.skel.h"
+
+/*
+ * This test dynamically adapts to the current environment, and will succeed
+ * whether JIT is enabled or not.
+ * 1. If JIT is enabled: The test case will successfully load and return
+ *    the expected value.
+ * 2. If JIT is disabled: It asserts that the verifier cleanly rejects the
+ *    program with -EINVAL (or -ENOSPC) and outputs the expected error log.
+ */
+
+void test_call_large_imm(void)
+{
+	struct call_large_imm *skel;
+	int err, prog_fd;
+	char log_buf[4096];
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	skel = call_large_imm__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!env.jit_enabled)
+		bpf_program__set_log_buf(skel->progs.call_large_imm_test,
+					 log_buf, sizeof(log_buf));
+
+	err = call_large_imm__load(skel);
+
+	if (env.jit_enabled) {
+		if (!ASSERT_OK(err, "load_should_succeed_with_jit"))
+			goto cleanup;
+
+		prog_fd = bpf_program__fd(skel->progs.call_large_imm_test);
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+
+		if (ASSERT_OK(err, "prog_run_success"))
+			ASSERT_EQ(opts.retval, 3, "prog_retval");
+
+	} else {
+		ASSERT_ERR(err, "load_should_fail_in_interpreter");
+		ASSERT_TRUE(err == -EINVAL || err == -ENOSPC, "err_should_be_einval_or_enospc");
+
+		if (!ASSERT_OK_PTR(strstr(log_buf, "bpf-to-bpf call offset out of range for interpreter"),
+				   "check_verifier_log_msg")) {
+			printf("Actual verifier log:\n%s\n", log_buf);
+		}
+	}
+
+cleanup:
+	call_large_imm__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/call_large_imm.c b/tools/testing/selftests/bpf/progs/call_large_imm.c
new file mode 100644
index 000000000000..ba6cd40738b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
@@ -0,0 +1,37 @@
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
+static __attribute__((noinline)) void padding_subprog(void)
+{
+	asm volatile ("					\
+		r0 = 0;					\
+		.rept 200000;				\
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

