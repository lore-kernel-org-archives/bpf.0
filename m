Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76D4AB1D1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269098; cv=none; b=p30ATFCE/E9YCt449i1yjAsGnuBR1UeIvny23bbHsBHaQTIbujgfpTG0W4uqkKfSa2b6hK7vNq/d9VUdHC855cNwiv/ZNAAxzXOPx/pUKTDssoZRzYswW7SnTmvisixk9MbY3HcrA09XGg2Ro/wPWwy30X4sSdCT2U1nRaHDFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269098; c=relaxed/simple;
	bh=X2jGvxIvlUlyZ2kUdVwv/N/jlGh/vMEBIBtik1zg3bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhXPJHX9kMvj1fBZz1z8lqvXQaT1BKNsU6mDmNdWGH9FSIIXHFQIoZGQ5oQE1jHLkklTZV7teX49kTxlS73nSDL8MYkmWKr9NOunTM6/E0noqWc/amAkPo2UD6kMN3DH+M/7I3wCpd6lbefglGxQx7f6NcY0TBPQhUvkdURiEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYyUQ5fY; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYyUQ5fY"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so95725e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269094; x=1790873894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfhdMHVsjnHJb14XDfjsoN3d7Vs6y5gghlHf2ItMVUA=;
        b=hYyUQ5fYb7oSvQWJfArrGEbciYz8aEjatmwVCD17FqI5LJu7IbCY6R6GLlRNbejxGQ
         ORO4gD8Jxy9nxOaEvA9OvUkaHgClwFlOOEQq6cl3mUhYfvZpnfLgEJG63Rshi7Pic5JW
         VCF8nubPuUKfrFGiHviDss/xSUDkL/AlSPxYfoS+Dn5h8Mj+vJrj7m89FE/JoE2bkaCr
         ARLKQFucR2xUOYZMND9OL5qun3av8l61wx0dyWyzJiaeT8KTAqt7iVm2pjexmFV0hhBM
         hqedS+Q4mm57NfDSi2BLQckSfeqDM2LQ1++NcOZzeXybnC2CkA5fH1P1ahu9aLD/S1te
         89ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269094; x=1790873894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfhdMHVsjnHJb14XDfjsoN3d7Vs6y5gghlHf2ItMVUA=;
        b=Hk2uBNMZuGjq1yfs11nK6+DJ+14ZbL5PoFhu4M00qgRdwQCrz16KwpOqtREXfOaVbM
         tNiFIgOskVaVvhaukbkZd0v7zFn1kQig30/iGunMLoqP8K16yQXtZ3/oDG75TfptiVFV
         Hp039K6TDPIWzqOsLdojWb1SWmGCr1FN6vSHgN54+BKPcBzNHdXBLx8mK5CNr3sLGcHK
         husJcJr6xXyookB7lhHziI7UgAEpVLxgdnsvYpIP6UnKBmhcYUoPq/UYXnMJiZunujVt
         YGYye5uYqQAeRnNroKjcVpyqOR9JbWERMmetrxV0ALEen4VfcCYH9ItgTLc6UK6PxRvZ
         EXmQ==
X-Gm-Message-State: AFuF++mmS3fP3fPNXkrqqLCNioPQruLnh9jhaLGWHx9Bl3r5Mmno0My/
	nYsoR9l962PfrvduZ7rig1kkP/AK6972Maxi/cQqCOTfVgk9Z4DB2UBrJzfUOEiX
X-Gm-Gg: AYBFou1N6JwiN8GDBopnpBAl1AtBb9euzGHiXHimZwSB/Hcl6yiyLQuDdx12Pme/3Tw
	C6BgaozHC6FiR0FuGoc1h4bhduAJ3PMSarsTC0B2wdp39Cvmx28s23/vtEOsIsp2+rxFPgQKFTz
	pwLjIAKxRS/YG05kNSF4MQAg5Uv0qmF2UvD4MUXe/rXnzbJ9Gp8gzsck5foa5dHWsDjD41GfIJ4
	PU3ImnCOLc8zJ2ggiAQOghmDOzB3j+UHeYfzh2ohLB5p+YRe1q2ihCV6G1ZMimiM7Ndey/awsdF
	KhLWG+4Q9A7w2ODzxHphitfTOv0pAuMFaxJuLaYiNwFpjacAfXMQVJCflQ0AG/trQsWUelSUSd7
	J6B5s4zZsqjVwpjeA1SsHsAQQjJb7t27HN2LbtTVTQwmlEWlTGmW3lz8Aw3LvH0QRgmvWjGiLRw
	l1AwLBkYNkYv5XJWYKyLWZ3RmYVB6M3p9OQrMNu5n1pfE38kDMmhZqeJZH1FymIrdGvMFPKxcTq
	rpx+TgCgk5Z8/f2ksnarnGJr9xZ6oYiV6Vbu35zKme2vCQ68XOWQqfsSzPbyx8ynBdjgdqBv/ry
	0rqENe4mvQZPgtyM8LSkTG8rJw1AT4oibSUUsg==
X-Received: by 2002:a05:600c:4e8b:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49fe66ff000mr55412505e9.27.1790269094277;
        Thu, 24 Sep 2026 09:58:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm119101795e9.3.2026.09.24.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 18/18] selftests/bpf: Test the 2 KiB stack budget
Date: Thu, 24 Sep 2026 18:57:19 +0200
Message-ID: <20260924165740.2146806-19-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22043; i=memxor@gmail.com; h=from:subject; bh=X2jGvxIvlUlyZ2kUdVwv/N/jlGh/vMEBIBtik1zg3bU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraMlmmctK3S26vaxzLQMfGIT9uD2x4biG29+/vcrnB C9L+vF3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ7LjMyrGG7I6OkOZG39vL8 nMnreDO++Mp8ZW2tt1Z/qcXCfPLeKYb/qW4X7Pd3nRQvu+gryfHwzP+frRyZPU8WbEn49CrCxTS JDQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add tests for the stack budget of JITs with large stack support: a
single 2 KiB frame, with and without may_goto, four 512-byte frames
that fit the budget and five that do not, a 512-byte frame calling a
1536-byte static subprog, global subprog or bpf_loop() callback and the
same with eight bytes too many, variable offset writes reaching exactly
the budget and past it, a tail call made from a 1 KiB frame, and two
2 KiB frames on a private stack, where each frame gets the whole budget.
A program with a 2 KiB frame is checked to be rejected wherever the
budget is 512 bytes, and a 1 KiB frame is rejected in a program calling
bpf_clone_redirect() but accepted in one calling bpf_redirect().

Two tests run such programs: a tail call made from a subprog with a
1536-byte frame under a 240-byte caller into a program with a 2 KiB
frame, and a struct_ops program on a private stack calling a subprog
when both frames are 2 KiB.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/struct_ops_private_stack.c |  31 ++
 .../selftests/bpf/prog_tests/tailcalls.c      |  42 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/struct_ops_private_stack_large.c    |  51 +++
 .../bpf/progs/tailcall_large_stack.c          |  62 +++
 .../bpf/progs/verifier_large_stack.c          | 425 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c |  23 +
 7 files changed, 636 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_large_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_large_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 98db9bafa44b..2b3ec2b79091 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -4,6 +4,7 @@
 #include "struct_ops_private_stack.skel.h"
 #include "struct_ops_private_stack_fail.skel.h"
 #include "struct_ops_private_stack_recur.skel.h"
+#include "struct_ops_private_stack_large.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
 static void test_private_stack(void)
@@ -78,6 +79,34 @@ static void test_private_stack_recur(void)
 	struct_ops_private_stack_recur__destroy(skel);
 }
 
+/* Two frames of 2 KiB each on the private stack */
+static void test_private_stack_large(void)
+{
+	struct struct_ops_private_stack_large *skel;
+	struct bpf_link *link;
+
+	if (!is_large_stack_supported()) {
+		test__skip();
+		return;
+	}
+
+	skel = struct_ops_private_stack_large__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_large__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->val, 100 + 30 + 12, "val");
+
+	bpf_link__destroy(link);
+cleanup:
+	struct_ops_private_stack_large__destroy(skel);
+}
+
 static void __test_struct_ops_private_stack(void)
 {
 	if (test__start_subtest("private_stack"))
@@ -86,6 +115,8 @@ static void __test_struct_ops_private_stack(void)
 		test_private_stack_fail();
 	if (test__start_subtest("private_stack_recur"))
 		test_private_stack_recur();
+	if (test__start_subtest("private_stack_large"))
+		test_private_stack_large();
 }
 #else
 static void __test_struct_ops_private_stack(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index aefb46778307..88d223110ecd 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -10,6 +10,7 @@
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
 #include "tailcall_cgrp_storage_owner.skel.h"
+#include "tailcall_large_stack.skel.h"
 #include "tailcall_cgrp_storage_no_storage.skel.h"
 #include "tailcall_cgrp_storage.skel.h"
 #include "tailcall_sleepable.skel.h"
@@ -2025,6 +2026,45 @@ static void test_tailcall_bpf2bpf_fexit_links(void)
 	tailcall_bpf2bpf2__destroy(skel_tc);
 }
 
+/*
+ * test_tailcall_large_stack runs a tail call made from a subprog with a 1536
+ * byte frame, under a 240-byte caller, into a program with a 2 KiB frame:
+ *
+ * entry (240) --call-> subprog_tail (1536) --tailcall-> classifier_0 (2048)
+ */
+static void test_tailcall_large_stack(void)
+{
+	struct tailcall_large_stack *skel;
+	int err, prog_fd, map_fd, key = 0;
+	char buff[128] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	if (!is_large_stack_supported()) {
+		test__skip();
+		return;
+	}
+
+	skel = tailcall_large_stack__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tailcall_large_stack__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.classifier_0);
+	map_fd = bpf_map__fd(skel->maps.jmp_table);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.entry), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 42 + 7, "retval");
+out:
+	tailcall_large_stack__destroy(skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -2096,4 +2136,6 @@ void test_tailcalls(void)
 	test_tailcall_callback();
 	if (test__start_subtest("tailcall_bpf2bpf_fexit_links"))
 		test_tailcall_bpf2bpf_fexit_links();
+	if (test__start_subtest("tailcall_large_stack"))
+		test_tailcall_large_stack();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index dc2c4180ee80..8a6d341b754a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -64,6 +64,7 @@
 #include "verifier_kfunc_uninit_multi.skel.h"
 #include "verifier_kfunc_perfmon.skel.h"
 #include "verifier_ld_ind.skel.h"
+#include "verifier_large_stack.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_linked_scalars.skel.h"
@@ -248,6 +249,7 @@ void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_
 void test_verifier_kfunc_perfmon(void)        { RUN(verifier_kfunc_perfmon); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
+void test_verifier_large_stack(void)          { RUN(verifier_large_stack); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
new file mode 100644
index 000000000000..94a25a2cff6e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+long val;
+
+/* On a private stack every frame gets the whole 2 KiB budget. */
+__used __naked
+static long frame_2048_leaf(void)
+{
+	asm volatile ("					\
+	r1 = 30;					\
+	*(u64 *)(r10 - 2048) = r1;			\
+	r1 = 12;					\
+	*(u64 *)(r10 - 8) = r1;				\
+	r0 = *(u64 *)(r10 - 2048);			\
+	r1 = *(u64 *)(r10 - 8);				\
+	r0 += r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* test_1 is the member bpf_testmod requests a private stack for */
+SEC("struct_ops")
+__naked int test_1(void)
+{
+	asm volatile ("					\
+	r1 = 100;					\
+	*(u64 *)(r10 - 2048) = r1;			\
+	call frame_2048_leaf;				\
+	r1 = *(u64 *)(r10 - 2048);			\
+	r0 += r1;					\
+	r1 = %[val] ll;					\
+	*(u64 *)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(val)
+	: __clobber_all);
+}
+
+SEC(".struct_ops")
+struct bpf_testmod_ops3 testmod_1 = {
+	.test_1 = (void *)test_1,
+};
diff --git a/tools/testing/selftests/bpf/progs/tailcall_large_stack.c b/tools/testing/selftests/bpf/progs/tailcall_large_stack.c
new file mode 100644
index 000000000000..977197dac5d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_large_stack.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/* The tail call target sets up a 2 KiB frame of its own and uses both of its ends. */
+SEC("tc")
+__naked int classifier_0(void)
+{
+	asm volatile ("					\
+	r1 = 42;					\
+	*(u64 *)(r10 - 2048) = r1;			\
+	r1 = 7;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r0 = *(u64 *)(r10 - 2048);			\
+	r1 = *(u64 *)(r10 - 8);				\
+	r0 += r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * The frame of the subprog doing the tail call is unwound by it, so it may be
+ * large; only the frames of its callers stay behind and are limited to 256
+ * bytes in total. Returns 1 when the tail call falls through.
+ */
+__used __naked
+static int subprog_tail(void)
+{
+	asm volatile ("					\
+	r2 = 1;						\
+	*(u64 *)(r10 - 1536) = r2;			\
+	r2 = %[jmp_table] ll;				\
+	r3 = 0;						\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+SEC("tc")
+__naked int entry(void)
+{
+	asm volatile ("					\
+	r2 = 2;						\
+	*(u64 *)(r10 - 240) = r2;			\
+	call subprog_tail;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
new file mode 100644
index 000000000000..c2a3ddf5ac91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Programs may use MAX_BPF_STACK_JIT (2 KiB) of stack on JITs that support
+ * large stacks, combined over a call chain, with no separate limit on a
+ * single frame. Interpreted programs and other JITs keep 512 bytes.
+ */
+
+SEC("socket")
+__description("single frame of 2048 bytes")
+__load_if_large_stack()
+__success __success_unpriv __retval(42)
+__naked void single_frame_2048(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2048;					\
+	r0 = 42;					\
+	*(u64*)(r1 + 0) = r0;				\
+	r0 = *(u64*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("single frame of 2048 bytes without large stack support")
+__load_if_no_large_stack()
+__failure __msg("invalid write to stack R1 off=-2048 size=8")
+__naked void single_frame_2048_no_large_stack(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2048;					\
+	r0 = 42;					\
+	*(u64*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_leaf(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_depth_2(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_leaf;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_depth_3(void)
+{
+	asm volatile ("					\
+	r1 = 3;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_depth_2;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_depth_4(void)
+{
+	asm volatile ("					\
+	r1 = 4;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_depth_3;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("four frames of 512 bytes fit the 2 KiB budget")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void four_frames_of_512(void)
+{
+	asm volatile ("					\
+	call frame_512_depth_4;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("five frames of 512 bytes exceed the 2 KiB budget")
+__load_if_large_stack()
+__failure __msg("combined stack size of 5 calls is 2560. Too large")
+__naked void five_frames_of_512(void)
+{
+	asm volatile ("					\
+	r1 = 5;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_depth_4;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_1536_leaf(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 1536) = r1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("512-byte frame calling a 1536-byte frame")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void uneven_frames_fit(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_1536_leaf;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("520-byte frame calling a 1536-byte frame")
+__load_if_large_stack()
+__failure __msg("combined stack size of 2 calls is 2064. Too large")
+__naked void uneven_frames_exceed(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 520) = r1;			\
+	call frame_1536_leaf;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_MAY_GOTO
+/* may_goto adds its counter below the frame; a JIT does not hold that against the budget */
+SEC("socket")
+__description("frame of 2048 bytes with may_goto")
+__load_if_large_stack()
+__success __retval(42)
+__naked void frame_2048_with_may_goto(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2048;					\
+	r0 = 42;					\
+	*(u32*)(r1 + 0) = r0;				\
+	may_goto l0_%=;					\
+	r2 = 100;					\
+	l0_%=:						\
+	exit;						\
+"	::: __clobber_all);
+}
+#endif
+
+SEC("socket")
+__description("variable offset write reaching 2048 bytes deep")
+__load_if_large_stack()
+__success
+__naked void var_off_write_to_2048(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 8;					\
+	r2 = r10;					\
+	r2 += -2048;					\
+	r2 += r0;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("variable offset write reaching 2056 bytes deep")
+__load_if_large_stack()
+__failure __msg("invalid variable-offset write to stack R2")
+__naked void var_off_write_to_2056(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 8;					\
+	r2 = r10;					\
+	r2 += -2056;					\
+	r2 += r0;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Each frame of a private stack gets the whole budget. */
+__used __naked
+static void priv_stack_frame_2048(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 2048) = r1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("kprobe")
+__description("private stack: two frames of 2048 bytes")
+__load_if_large_stack()
+__arch_x86_64
+__arch_arm64
+__success __log_level(4)
+__msg("stack depth max 2048")
+__msg("subprog 0 (private_stack_two_frames) main {{.*}} stack 2048")
+__msg("subprog 1 (priv_stack_frame_2048) static {{.*}} stack 2048")
+__naked void private_stack_two_frames(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 2048) = r1;			\
+	call priv_stack_frame_2048;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/*
+ * A tail call unwinds the frame of the program doing it, so a large main
+ * frame is fine; the 256-byte rule only concerns the frames of callers of a
+ * subprog that tail calls.
+ */
+SEC("tc")
+__description("tail call from a 1 KiB frame")
+__load_if_large_stack()
+__success
+__naked void tail_call_from_large_frame(void)
+{
+	asm volatile ("					\
+	r2 = 42;					\
+	*(u64 *)(r10 - 1024) = r2;			\
+	r2 = %[jmp_table] ll;				\
+	r3 = 0;						\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+/*
+ * bpf_clone_redirect() can run the program again on top of its own frame,
+ * ten frames deep, so a program calling it keeps the 512-byte budget. The
+ * redirect that happens after the program returns does not.
+ */
+SEC("tc")
+__description("1 KiB frame with bpf_clone_redirect keeps the 512-byte budget")
+__load_if_large_stack()
+__failure __msg("invalid write to stack R1 off=-1024 size=8")
+__naked void clone_redirect_keeps_512(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = r10;					\
+	r1 += -1024;					\
+	r0 = 42;					\
+	*(u64 *)(r1 + 0) = r0;				\
+	r1 = r6;					\
+	r2 = 1;						\
+	r3 = 0;						\
+	call %[bpf_clone_redirect];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_clone_redirect)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("1 KiB frame with bpf_redirect keeps the 2 KiB budget")
+__load_if_large_stack()
+__success
+__naked void redirect_keeps_2048(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -1024;					\
+	r0 = 42;					\
+	*(u64 *)(r1 + 0) = r0;				\
+	r1 = 1;						\
+	r2 = 0;						\
+	call %[bpf_redirect];				\
+	exit;						\
+"	:
+	: __imm(bpf_redirect)
+	: __clobber_all);
+}
+
+/* Global subprogs are verified on their own but share the call chain budget. */
+__used __naked int global_frame_1536(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 1536) = r1;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("512-byte frame calling a 1536-byte global subprog")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void global_subprog_fits(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call global_frame_1536;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("520-byte frame calling a 1536-byte global subprog")
+__load_if_large_stack()
+__failure __msg("combined stack size of 2 calls is 2064. Too large")
+__naked void global_subprog_exceeds(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 520) = r1;			\
+	call global_frame_1536;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Callback frames are part of the chain of the helper that calls them. */
+static __naked int loop_cb_1536(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 1536) = r1;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("512-byte frame with a 1536-byte bpf_loop callback")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void loop_callback_fits(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	r1 = 1;						\
+	r2 = %[loop_cb_1536];				\
+	r3 = 0;						\
+	r4 = 0;						\
+	call %[bpf_loop];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_ptr(loop_cb_1536),
+	  __imm(bpf_loop)
+	: __clobber_common);
+}
+
+SEC("socket")
+__description("520-byte frame with a 1536-byte bpf_loop callback")
+__load_if_large_stack()
+__failure __msg("combined stack size of 2 calls is 2064. Too large")
+__naked void loop_callback_exceeds(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 520) = r1;			\
+	r1 = 1;						\
+	r2 = %[loop_cb_1536];				\
+	r3 = 0;						\
+	r4 = 0;						\
+	call %[bpf_loop];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_ptr(loop_cb_1536),
+	  __imm(bpf_loop)
+	: __clobber_common);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index a832df0b5bd2..16b2b1e57534 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2912,3 +2912,26 @@ static __used __naked void merge_read_all_callee(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+/*
+ * A frame pointer spilled below fp-512 is a spill like any other: the fill
+ * restores its identity, and a load through it reads only the slot it names
+ * instead of the whole frame.
+ */
+SEC("socket")
+__log_level(2)
+__load_if_large_stack()
+__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8{{$}}")
+__naked void spill_below_512_stays_precise(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 520) = r1;"
+	"r1 = *(u64 *)(r10 - 520);"
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
-- 
2.53.0

