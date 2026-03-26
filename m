Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E05332EBB
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506876; cv=none; b=Fqa9S5knbiL/9SMYJ8rIFfl2XgtE7GeUXyOHNbtt3S0wXCIPdVopVLdy0wt0IOQa6xeZJT8O8CZ2whqQOHmmZPRNRCscTSGgdrMVKlBvp+dKG6Nrnm75Sg64pYePWx45aOanKEPMdPWzrnb5O5KRG/TAXOoxSjMmI9ahz4HrqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506876; c=relaxed/simple;
	bh=XFDXtWSHE+HHzmtIR656SbE7ejTtQE91iCLWuVd62Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9JbsqfH6vgR3KF557shF1xVQFD27Pa/gJe3iw1tQO2mEIP+SbAETyJ8o7/p2fk3sRgEVq/FjrnZ+g9fyK9ky3/qK07xGcM5TTAujIk3cjWMLW7rLe7/pBbsLCMPEKEuf1Zo50hgzZVF/Hg3srX9aXRmAFQyyMj7RYPSl9lq1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.94])
	by mtasvr (Coremail) with SMTP id _____wCH_hBb08RpBuEEAA--.12404S3;
	Thu, 26 Mar 2026 14:34:03 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [115.236.2.94])
	by mail-app2 (Coremail) with SMTP id zC_KCgA3qc5Z08RpmnkqAA--.50664S2;
	Thu, 26 Mar 2026 14:34:02 +0800 (CST)
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
	ziye@zju.edu.cn,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v4 2/3] selftests/bpf: Add test for large offset bpf-to-bpf call
Date: Thu, 26 Mar 2026 14:33:28 +0800
Message-ID: <20260326063329.10031-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
References: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgA3qc5Z08RpmnkqAA--.50664S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg0CCmnEOosdWgAAsc
X-CM-DELIVERINFO: =?B?ehkOpgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9B7VUHZ/jH0WVNiQoVfoxX4M4RZ0Ydu8g4tpY8OIyrNI9PfrHhwS/bnik+lClHIteUhW
	8AA4XAHWyKkzau0NG7ZX+Get5UJN7Hf2TlSPTDxMIFV0yeo1GXOqEXFvdxnw6A==
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1fXFWxJF13Gw1UZw1xtFc_yoW7Gw4rpa
	4kWFy5KF1fGay7Kw13CFZrZF45GF4kZFWjyrWIqr90yr45Ar97Grs7KrWjqFy3CrZ5ZwnY
	vFZIya93Wr48JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TUDJUUUUU==

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

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/call_large_imm.c | 54 +++++++++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 46 ++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
new file mode 100644
index 000000000000..8968b3c3263f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
@@ -0,0 +1,54 @@
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

