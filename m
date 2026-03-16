Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EC34C806
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687794; cv=none; b=Jllr46pFXO7JsHZFROQ/y4IdqRm3kBvRd9WYW0Vowx54GZsXcYNo8tdRoPFsAXU4llz7yFzdGqOpqh+u7SRprsOP9m7Zw8eIqpIzvIZgp4dHtjqzj/JdEeABBFv8KS8y9i6ypDl+pfOS3Uyc60/ARNsTHiV+cmu4r0u4UCPMbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687794; c=relaxed/simple;
	bh=arL+w32Z0q6sRaADnkBmFJXxdf+3gzfZIZZZRcz2uwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJzHMlJRbrgYXZKXafxTbTSEeB4smdwTGFfNldNgTA0zV8OdBV/HWNXYhL2OvNXLS9pXfNsnf4DBvitdgGlFRGQzE1+QUhm15EwUJtbE+FUavA7rILpzD48Bz+BhCAlGtbHuZoYqzdQjCB99ANBIAqSBjI1AiPpI5IEB0jwhGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.192.132])
	by mtasvr (Coremail) with SMTP id _____wD3SMjNU7hpVtgfAA--.11797S3;
	Tue, 17 Mar 2026 03:02:37 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.192.132])
	by mail-app3 (Coremail) with SMTP id zS_KCgAnKWzNU7hpgfq4Bg--.6004S2;
	Tue, 17 Mar 2026 03:02:37 +0800 (CST)
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
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for large offset bpf-to-bpf call
Date: Tue, 17 Mar 2026 03:02:20 +0800
Message-ID: <20260316190220.113417-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAnKWzNU7hpgfq4Bg--.6004S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhILCmm1ugoVzwAEsn
X-CM-DELIVERINFO: =?B?8SNMEQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ed38ain3iGL/cGOK3OqJ6bCKPGG2cR0q5WwyLJmE3hYK+MybqO+91RHEunANJutaert
	C7p+Up2gyoS0Qq6VEVqOomPs4B6JxQySlHQ7zQs9q90M3g4RtDlplVgBbNM3NQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxZFyrGrW8XFWxWry3tw45CFX_yoWrWFWrpa
	4kGFy5KF4fGay7Kw47AFW7ZF15KF4kZFyjyrWIqr90vr15Ar97Grs7Kr4UtFy3CrZ3Awn5
	ZFZIyan3Wr48JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07URlksUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

The test utilizes an inline assembly block with `.rept 200000` to generate
a massive dummy subprogram. By placing this padding between the main program
and the target subprogram, it forces the verifier to process a bpf-to-bpf call
with the `imm` field exceeding the s16 range.

The user-space test driver dynamically adapts to the host's JIT configuration:
- When JIT is enabled, it asserts that the program is successfully loaded,
  JIT-compiled, and executes correctly (returning the expected value).
- When JIT is disabled, it asserts that the program is cleanly rejected by
  the verifier with -EINVAL (or -ENOSPC if the verifier log buffer is truncated),
  and strictly matches the expected error log.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 .../selftests/bpf/prog_tests/call_large_imm.c | 49 +++++++++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 38 ++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
new file mode 100644
index 000000000000..ba4a2e27fa5d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "call_large_imm.skel.h"
+
+void test_call_large_imm(void)
+{
+	struct call_large_imm *skel;
+	int err, prog_fd;
+	char log_buf[4096] = {};
+	char dummy_data[64] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = dummy_data,
+		.data_size_in = sizeof(dummy_data),
+	);
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
index 000000000000..d0057f88b48b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct __sk_buff;
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
+static __attribute__((noinline)) int target_subprog(struct __sk_buff *ctx)
+{
+	volatile int magic_ret = 3;
+	return magic_ret;
+}
+
+SEC("socket")
+int call_large_imm_test(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	if (ctx == (void *)0)
+		padding_subprog();
+
+	ret = target_subprog(ctx);
+
+	bpf_printk("Target subprog returned: %d\n", ret);
+
+	return ret;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.53.0

