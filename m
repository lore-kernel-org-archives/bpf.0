Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882061C69D;
	Fri, 28 Aug 2026 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891251; cv=none; b=EtP+CLEJFyTNjq4O/BHKJqJdQmGl9vuJVqFH6iWZdGnI4AuVZbSssTy72b0bkSlHDuehilohznRh2YEMWT/2+iVxnglgx80pvdMVbj6MUBvEyB5TgKitVpKo5vPaa5Oz+nU8lYun91abqFn2zD42hHCbfStPYDdtLBwWPL7vWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891251; c=relaxed/simple;
	bh=ack64tm/a65e5S9d7si+oM3iJIytD5JYoRJG2M1VUnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9VhssaWnZuxkiYfOJm4VhrHNCuPEmOlVZrNkQHmxfjQu9ukP7Hrn+13uPENVZVm9E7yYJfK2Qm6TPBKbGxJYXRPuPcVIwntt1dlKYMCVwnD3tOWI+VSLNLXskYFNSyzRSFeOnHEUf3xOa3v6qw1j0aGVIM/eyBAoQzDBi5Nc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cxf9MoDpFqLPoFAA--.16790S3;
	Fri, 28 Aug 2026 12:27:20 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxTs8kDpFq2hgVAA--.42199S2;
	Fri, 28 Aug 2026 12:27:17 +0800 (CST)
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
Subject: [PATCH bpf-next v1] selftests/bpf: Add test for indirect struct_ops trampoline
Date: Fri, 28 Aug 2026 12:27:15 +0800
Message-ID: <20260828042715.16546-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTs8kDpFq2hgVAA--.42199S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw43Ww43XFy8uFW5tF4kKrX_yoWxWryfpa
	y8Aw1YyF48JrWDWFyxXa1UZF4Sgws3Z3yUGFWDG3s5ua4fX34DJF18tFySyr95W39Yvr13
	A3ZYkr98ua1xZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

Add a test case to verify that arguments passed on the stack are correctly
read by indirect struct_ops trampoline. This test ensures the correctness
of stack offsets on architectures like LoongArch and RISC-V.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
This is to test the following two patches:

bpf, riscv: Fix stack-passed arguments for indirect trampolines
https://lore.kernel.org/bpf/20260821233516.3426127-3-memxor@gmail.com/

bpf, loongarch: Fix stack arguments for indirect trampolines
https://lore.kernel.org/bpf/20260821233516.3426127-8-memxor@gmail.com/

 .../prog_tests/test_struct_ops_trampoline.c   | 41 +++++++++++++++++++
 .../bpf/progs/struct_ops_trampoline.c         | 24 +++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 18 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  5 +++
 4 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_trampoline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
new file mode 100644
index 000000000000..5a21aedd02fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "struct_ops_trampoline.skel.h"
+
+#if defined(__loongarch__) || defined(__riscv)
+static void run_struct_ops_trampoline(void)
+{
+	struct struct_ops_trampoline *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_trampoline__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_trampoline__open"))
+		return;
+
+	err = struct_ops_trampoline__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_trampoline__load"))
+		goto cleanup;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_trampoline);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->got_arg9, 9999, "check_stack_passed_arg9");
+
+	bpf_link__destroy(link);
+cleanup:
+	struct_ops_trampoline__destroy(skel);
+}
+#endif
+
+void test_struct_ops_trampoline(void)
+{
+#if defined(__loongarch__) || defined(__riscv)
+	run_struct_ops_trampoline();
+#else
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_trampoline.c b/tools/testing/selftests/bpf/progs/struct_ops_trampoline.c
new file mode 100644
index 000000000000..b0fc19a2a0c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_trampoline.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u64 got_arg9 = 0;
+
+SEC("struct_ops/test_trampoline")
+int BPF_PROG(test_trampoline, int arg1, int arg2, int arg3,
+			      int arg4, int arg5, int arg6,
+			      int arg7, int arg8, int arg9)
+{
+	got_arg9 = arg9;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_trampoline = {
+	.test_trampoline = (void *)test_trampoline,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 850cf4f830c4..be96bbc1b7c0 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -589,6 +589,9 @@ noinline int bpf_testmod_trampoline_count_test(void)
 	return 0;
 }
 
+struct bpf_testmod_ops;
+static struct bpf_testmod_ops *st_ops_trampoline;
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -637,6 +640,9 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	bpf_testmod_test_struct_ops3();
 
+	if (st_ops_trampoline && st_ops_trampoline->test_trampoline)
+		st_ops_trampoline->test_trampoline(1, 2, 3, 4, 5, 6, 7, 8, 9999);
+
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
 	if (struct_arg3 != NULL) {
@@ -1619,6 +1625,10 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
 		return 1;
 	}
+
+	if (member->offset == offsetof(struct bpf_testmod_ops, test_trampoline) * 8)
+		st_ops_trampoline = (struct bpf_testmod_ops *)kdata;
+
 	return 0;
 }
 
@@ -1694,6 +1704,13 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
 	return NULL;
 }
 
+static int bpf_testmod_ops__test_trampoline(int arg1, int arg2, int arg3,
+					    int arg4, int arg5, int arg6,
+					    int arg7, int arg8, int arg9)
+{
+	return arg9;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
@@ -1701,6 +1718,7 @@ static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
 	.test_refcounted_multi = bpf_testmod_ops__test_refcounted_multi,
 	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
+	.test_trampoline = bpf_testmod_ops__test_trampoline,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 210b919290cc..a5349d09ce55 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -46,6 +46,11 @@ struct bpf_testmod_ops {
 	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
 						    struct cgroup *cgrp);
 
+	/* Used to test indirect struct_ops trampolines stack-passed arguments (>8 args). */
+	int (*test_trampoline)(int arg1, int arg2, int arg3,
+			       int arg4, int arg5, int arg6,
+			       int arg7, int arg8, int arg9);
+
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
 	struct {
-- 
2.42.0

