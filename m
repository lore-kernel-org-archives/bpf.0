Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF93D4127;
	Mon, 31 Aug 2026 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166638; cv=none; b=CVGXXeT8E9ihMttQ1woL6aUClT11BAoStNmNnC+RxrNkK4dyyfLHVlOggkvt12aEZKRxSjs5FxgngJh3bBopD822nqfPWn4f1naIsJuFWY5AP3oU4fkPqCEiI6ScpDYSXlyjKlUK6fSlYbNTWDRzeq/llwHU5+6WnSQyXZNvELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166638; c=relaxed/simple;
	bh=DSj3s4wELAzEUrJo4A5JdVkD8AM004a/Xh1kam1XWwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAbThOx46iPBjIXTq1BKlbJP6yFyzGb3mcvu1bSkjByaXRpOg7ti5oatwEDsG5Q/XTk9hW1qm6tS4yii7p/RAUwRb7JIZozJQQH+YSkSVFqdy8sqSciXxVbDfnl0Z8AOnhxAkqVkFvYh6KrE+Z9gJ0qlg9x4Ue870km2/XYJdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxPNLpQZVqzNgGAA--.18957S3;
	Mon, 31 Aug 2026 16:57:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxTs_iQZVq3SoYAA--.50979S2;
	Mon, 31 Aug 2026 16:57:07 +0800 (CST)
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
Subject: [PATCH bpf-next v2] selftests/bpf: Add test for indirect struct_ops trampoline
Date: Mon, 31 Aug 2026 16:57:05 +0800
Message-ID: <20260831085705.13747-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTs_iQZVq3SoYAA--.50979S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw4kXr15JFWftw1fCFyxtFc_yoW3Ww4rpF
	W8Jw1YyFnYvrWDXF18Xa1UZF4Sgrs3Z3yUCFWkG3s5uF93X34DJF18tFyIyr95GrZ5Zw13
	A3ZY9r98uayUZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qXdUUUUUU==

Add a test case to verify that arguments passed on the stack are correctly
read by an indirect struct_ops trampoline.

This test ensures the correctness of stack offsets on architectures like
LoongArch and RISC-V where arguments beyond the first 8 slots are passed
via the stack.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
This is to test the following two patches:

bpf, riscv: Fix stack-passed arguments for indirect trampolines
https://lore.kernel.org/bpf/20260821233516.3426127-3-memxor@gmail.com/

bpf, loongarch: Fix stack arguments for indirect trampolines
https://lore.kernel.org/bpf/20260821233516.3426127-8-memxor@gmail.com/

v2:
  -- Fix use-after-free and race conditions
  -- Modify current files to avoid new binary

 .../prog_tests/test_struct_ops_multi_args.c   | 49 ++++++++++++++++++-
 .../bpf/progs/struct_ops_multi_args.c         | 13 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 ++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  5 ++
 4 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
index 0f321e889862..7f6f9d61c9e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
@@ -3,7 +3,54 @@
 #include <test_progs.h>
 #include "struct_ops_multi_args.skel.h"
 
+static void test_refcounted_multi(void)
+{
+	struct struct_ops_multi_args *skel;
+	int err;
+
+	skel = struct_ops_multi_args__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_multi_args__open"))
+		return;
+
+	err = struct_ops_multi_args__load(skel);
+	ASSERT_EQ(err, -EINVAL, "struct_ops_multi_args__load");
+
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
+	ASSERT_EQ(skel->bss->got_arg9, 9999, "check_stack_passed_arg9");
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
index c62be15757f0..f0f47676b099 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
@@ -29,7 +29,20 @@ int test_refcounted_multi(unsigned long long *ctx)
 	return 0;
 }
 
+__u64 got_arg9 = 0;
+
+SEC("struct_ops/test_trampoline_stack_args")
+int BPF_PROG(test_trampoline_stack_args, int arg1, int arg2, int arg3,
+					 int arg4, int arg5, int arg6,
+					 int arg7, int arg8, int arg9)
+{
+	got_arg9 = arg9;
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
index 2380b6cbdead..8f0744e6075b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1678,6 +1678,9 @@ static bool bpf_testmod_ops_is_valid_access(int off, int size,
 	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
 }
 
+static DEFINE_MUTEX(st_ops_trampoline_mutex);
+static struct bpf_testmod_ops *st_ops_trampoline;
+
 static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
@@ -1691,6 +1694,18 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
 		return 1;
 	}
+
+	if (member->offset == offsetof(struct bpf_testmod_ops, test_trampoline_stack_args) * 8) {
+		mutex_lock(&st_ops_trampoline_mutex);
+		if (st_ops_trampoline) {
+			pr_err("st_ops_trampoline has already been registered\n");
+			mutex_unlock(&st_ops_trampoline_mutex);
+			return -EEXIST;
+		}
+		st_ops_trampoline = (struct bpf_testmod_ops *)kdata;
+		mutex_unlock(&st_ops_trampoline_mutex);
+	}
+
 	return 0;
 }
 
@@ -1720,11 +1735,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
 
+	mutex_lock(&st_ops_trampoline_mutex);
+	if (st_ops_trampoline && st_ops_trampoline->test_trampoline_stack_args)
+		st_ops_trampoline->test_trampoline_stack_args(1, 2, 3, 4, 5, 6, 7, 8, 9999);
+	mutex_unlock(&st_ops_trampoline_mutex);
+
 	return 0;
 }
 
 static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
+	mutex_lock(&st_ops_trampoline_mutex);
+	if (st_ops_trampoline == (struct bpf_testmod_ops *)kdata)
+		st_ops_trampoline = NULL;
+	mutex_unlock(&st_ops_trampoline_mutex);
 }
 
 static int bpf_testmod_test_1(void)
@@ -1766,6 +1790,13 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
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
@@ -1773,6 +1804,7 @@ static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
 	.test_refcounted_multi = bpf_testmod_ops__test_refcounted_multi,
 	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
+	.test_trampoline_stack_args = bpf_testmod_ops__test_trampoline_stack_args,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 210b919290cc..42257ae89fd5 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -46,6 +46,11 @@ struct bpf_testmod_ops {
 	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
 						    struct cgroup *cgrp);
 
+	/* Used to test indirect struct_ops trampolines stack-passed arguments (>8 args). */
+	int (*test_trampoline_stack_args)(int arg1, int arg2, int arg3,
+					  int arg4, int arg5, int arg6,
+					  int arg7, int arg8, int arg9);
+
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
 	struct {
-- 
2.42.0

