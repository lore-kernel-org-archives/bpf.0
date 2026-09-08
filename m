Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51123976A4;
	Tue,  8 Sep 2026 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852917; cv=none; b=k45oBgLqFfFTFtro4LesrB6QjeK2SCrvYN1eoO30ieRcsqrlQ7ld69hMsombruZCsAuDeDHJrWhWOhCqB45HggH6HMtKMoY9w3eFxsbv/Ij927ti6YfOoUiRIO4dNU9oFHTISZ/qy3p/iwI3JehKWXFa393H+OArClf+J9K8jWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852917; c=relaxed/simple;
	bh=OukSDEUVKjZ7tLp5WM5ACCwFRh0Lpjk4JkKl/ZZoIOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prMyvnX0JMWTJ3PecLA5bjkB4F24eWOXRMcQdzuzQ02qhAE4GvdoQFCVA88jt6A8oJmZH6/L0lLYchHpDgu2cxlEPtic8o70JxDE31WILEXrpTwpaFUit89un3f/xtMl+R+JZsD83/ORmxp3rBRhJ4SdZJXhYMyyrxBCbep81gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxS_Cwup9qx7cJAA--.28150S3;
	Tue, 08 Sep 2026 15:35:12 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx1cyrup9qnQ0dAA--.34416S2;
	Tue, 08 Sep 2026 15:35:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] selftests/bpf: Add test for indirect struct_ops trampoline
Date: Tue,  8 Sep 2026 15:35:06 +0800
Message-ID: <20260908073506.29734-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1cyrup9qnQ0dAA--.34416S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw4kXr4UJFy3CFyfGFW3urX_yoW3GF4xpF
	ykJw1YyFnYv39rWF18XF4UZF4Sgrs5Zw15CFWkJ3sayr93X347JF18tFyIyFn8JrZYvw43
	A34q9rW5CayUXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

Add a test case to verify that arguments passed on the stack are
correctly read by an indirect struct_ops trampoline.

This test ensures the correctness of stack offsets across various
architectures. It is particularly critical for architectures like
LoongArch, RISC-V, ARM64, and PowerPC where arguments beyond the
first 8 registers are passed on the stack, as well as x86_64 and
s390x which have lower register argument limits.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v3:
  -- Use bpf_program__set_log_buf() to capture and verify the log
  -- Drop global state and mutex, just use kdata in bpf_dummy_reg()

Test results for reference:

(1) Before JIT fixes:
    $ sudo ./test_progs -t struct_ops_multi_args
    #487/1   struct_ops_multi_args/test_refcounted_multi:OK
    ...
    test_trampoline_stack_args:FAIL:check_stack_passed_arg9 unexpected check_stack_passed_arg9: actual 1286686720 != expected 9999
    #487/2   struct_ops_multi_args/test_trampoline_stack_args:FAIL
    #487     struct_ops_multi_args:FAIL
    Summary: 0/1 PASSED, 0 SKIPPED, 1/1 FAILED

(2) After JIT fixes:
    $ sudo ./test_progs -t struct_ops_multi_args
    #487/1   struct_ops_multi_args/test_refcounted_multi:OK
    #487/2   struct_ops_multi_args/test_trampoline_stack_args:OK
    #487     struct_ops_multi_args:OK
    Summary: 1/2 PASSED, 0 SKIPPED, 0/0 FAILED

 .../prog_tests/test_struct_ops_multi_args.c   | 57 ++++++++++++++++++-
 .../bpf/progs/struct_ops_multi_args.c         | 14 ++++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 10 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  5 ++
 4 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
index 0f321e889862..8767e5f8bcc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
@@ -3,7 +3,62 @@
 #include <test_progs.h>
 #include "struct_ops_multi_args.skel.h"
 
+static void test_refcounted_multi(void)
+{
+	struct struct_ops_multi_args *skel;
+	char log_buf[4096] = {};
+	int err;
+
+	skel = struct_ops_multi_args__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_multi_args__open"))
+		return;
+
+	bpf_program__set_log_buf(skel->progs.test_refcounted_multi, log_buf, sizeof(log_buf));
+
+	err = struct_ops_multi_args__load(skel);
+	if (!ASSERT_EQ(err, -EINVAL, "struct_ops_multi_args__load"))
+		goto out;
+
+	ASSERT_HAS_SUBSTR(log_buf, "program with __ref argument cannot tail call",
+			  "check_verifier_log_message");
+
+out:
+	struct_ops_multi_args__destroy(skel);
+}
+
+static void test_trampoline_stack_args(void)
+{
+	struct struct_ops_multi_args *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_multi_args__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_multi_args__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_refcounted_multi, false);
+	skel->struct_ops.testmod_ref_acquire->test_refcounted_multi = NULL;
+
+	err = struct_ops_multi_args__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_multi_args__load"))
+		goto out;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_ref_acquire);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->trampoline_stack_arg9, 9999, "check_stack_passed_arg9");
+
+out:
+	bpf_link__destroy(link);
+	struct_ops_multi_args__destroy(skel);
+}
+
 void test_struct_ops_multi_args(void)
 {
-	RUN_TESTS(struct_ops_multi_args);
+	if (test__start_subtest("test_refcounted_multi"))
+		test_refcounted_multi();
+
+	if (test__start_subtest("test_trampoline_stack_args"))
+		test_trampoline_stack_args();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
index c62be15757f0..9d290f22b492 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
@@ -17,7 +17,6 @@ struct {
 } prog_array SEC(".maps");
 
 SEC("struct_ops/test_refcounted_multi")
-__failure __msg("program with __ref argument cannot tail call")
 int test_refcounted_multi(unsigned long long *ctx)
 {
 	/* ctx[2] is used because the refcounted variable is the third argument */
@@ -29,7 +28,20 @@ int test_refcounted_multi(unsigned long long *ctx)
 	return 0;
 }
 
+__u64 trampoline_stack_arg9 = 0;
+
+SEC("struct_ops/test_trampoline_stack_args")
+int BPF_PROG(test_trampoline_stack_args, int arg1, int arg2, int arg3,
+					 int arg4, int arg5, int arg6,
+					 int arg7, int arg8, int arg9)
+{
+	trampoline_stack_arg9 = arg9;
+
+	return 0;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_ref_acquire = {
 	.test_refcounted_multi = (void *)test_refcounted_multi,
+	.test_trampoline_stack_args = (void *)test_trampoline_stack_args,
 };
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f798bbbb4d13..df50b408972a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1774,6 +1774,8 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 	 */
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
+	if (ops->test_trampoline_stack_args)
+		ops->test_trampoline_stack_args(1, 2, 3, 4, 5, 6, 7, 8, 9999);
 
 	return 0;
 }
@@ -1821,6 +1823,13 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
 	return NULL;
 }
 
+static int bpf_testmod_ops__test_trampoline_stack_args(int arg1, int arg2, int arg3,
+						       int arg4, int arg5, int arg6,
+						       int arg7, int arg8, int arg9)
+{
+	return arg9;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
@@ -1828,6 +1837,7 @@ static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
 	.test_refcounted_multi = bpf_testmod_ops__test_refcounted_multi,
 	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
+	.test_trampoline_stack_args = bpf_testmod_ops__test_trampoline_stack_args,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 210b919290cc..505cd6779ff7 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -46,6 +46,11 @@ struct bpf_testmod_ops {
 	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
 						    struct cgroup *cgrp);
 
+	/* Used to test indirect struct_ops trampoline with stack-passed arguments. */
+	int (*test_trampoline_stack_args)(int arg1, int arg2, int arg3,
+					  int arg4, int arg5, int arg6,
+					  int arg7, int arg8, int arg9);
+
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
 	struct {
-- 
2.42.0

