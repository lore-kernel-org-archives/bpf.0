Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B52C0F7F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783472; cv=none; b=EYQ49OmZvlc3UnNcpMbV7S1roJokiDOu7F4BijqXAkztANKy8kam0uh80KTi6vGdyUwxHg3lJnRYbSkzT/95nlAI6G42au1JtG9ov6YeJaL7e+i1lcknT5fx+Rp6uY/VPsRhzpS+3c9yCb1rzHlWYA1KcI/5Knp6S6nVXzIjZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783472; c=relaxed/simple;
	bh=EAnLkUzD/jak0hj55ek8FaJpcs1PSsPCAlouMNxHBzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ixMg71K1b6l3gtyClP0LIu3aZmv+RvjDSfYPVWsfP3EVlRPX6li2oawFvxWVLedPiLKAtavj0D+B8v/8XudfCorYZYJHRLrptdaGWDJWNi70pDwylgHAJfSXJ4E94508xssTOSApjuDiZHWW+Y5pgCF3poStS+h/djxqUGqK6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=iT0mmCuX; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="iT0mmCuX"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb545db3afso2487977a34.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785783468; x=1786388268;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcHoPJWnPgEgMutYYZSf0CmDCVCUMwS4dztIBV+3zoI=;
        b=RYNREedk63bziSuadNCo+Pw0nmO0ffxgTFHVzazqO+18gX2gXVErmimzSsiX4JS6Ki
         TARZ4T/KsJydLdOM5IzoYUNMqZAEFkX+oG3meprcKKgwa9GtcLD1kaOyYXYoPriw2I4T
         anI3nAvES9UkX1hdKszOCDC8zzJaN3AyjhUQ2rnmGg7XVfasYShodNhoAdaSG9Fp2qcW
         wjR8BXQA6SylGzGFNToL268JDqL4oWByq2FoMkSWDYkZlRG/XPFwFRkd3dQyusiOiCgs
         oSqnWWwex23U9daVGs/VkvPLfdR0ADsYbJ3RMLIm/zI1zgypQS+NabTi7Dcb23/XMsR0
         PhpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYTz3IeyaaZ3gtIZQxaxPC56V7FN1Ae1zyJTB4lX5yG8lmmEek1Zti64JTlP3wdasTpgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7CbmC8r+9STuUtoe4VBLeHDib6CbDvdR29wJ+UlUNTobT5WQ
	d03xd9aq0bOAbnjcghuPO0YaKTe4sirJWgQVoTVlo+Gq6ax2ilBiTELJ
X-Gm-Gg: AR+sD108Pw7mLR9kVMXuwZMnQ+I4OaLJSx3vEcmXsfJ2ljWRAHB+k9Op+SgdsRXpI7a
	gC5YDvrMhNCehvNsaR8BzqWq+DdTwqLyT2OMZc0aalbvGLqiLBVp8GKg+PeFe+eoH8ZUa7sHecL
	c79r1X7RfOUBFiKShTZ/xV7YTag+VGGK637hZe1G8/ykrySswfR0XUsUR8rR6RhLfPCUT2vLS/h
	UT8aQZQ3u3lVRMUYLFse3QDMrYAQcKRcDj8FvbmO5z4WGBoxZ2wYMWmmpOp7rFmycQJlANT//jH
	C772tp403DFQqDM9bVHHIBcvQt8bqurqJ8PkYTWpr+YLFhtD6NswvVFHrNAfwSdj5eRPOMN8wz+
	3xsGsL9aXzZrkyTIa79DbM1PUwGPIn7Tjip8i7VhzOOuqtpKvZ04VWeJI68SsBg+PDqUqMWFWp+
	OVNGZSl9PIU3Yyi6IXxg2OuXCuVTvXpGMcJIAVKOQnazGSqMCoXqYiZFvVwFHAtAIc20EswzNii
	xP0XujUtOX7MRxxDCkVPsoyIAaS85+HW5M7ifW3A4uv5zXeqOPfJUMUo2vXb5b0Hw==
X-Received: by 2002:a05:6830:700c:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f196b97f19mr19782181a34.1.1785783468210;
        Mon, 03 Aug 2026 11:57:48 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f0da951sm7885452a34.24.2026.08.03.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:57:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7274160CD1;
	Mon,  3 Aug 2026 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1785783465;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lcHoPJWnPgEgMutYYZSf0CmDCVCUMwS4dztIBV+3zoI=;
	b=iT0mmCuXCnmL8iTlj47goISnaeeghCP8cxhqJnfAmdE2z/81u6/B/W4GIS9qaJvYZexYV0
	XkE4UDmFyG4FMtiAIJCGQtfE3pVjhuLUrFEexs2vZIkGGGrUZBQoRrRkPk1pPRxadY1+C8
	UxLmEcK0AUdPxiP8byNydgI8u6QWtn7qPB/MOA8jIrewb1Tm/xLz0AUIsUUXedTfZxZnMO
	Tb8EXT/2Qn88VPWOXmKh9PIrb3Tcs5EYncztyLRG6DdBRdXuBk9S5TjE/aqhAsk05UiZpr
	nzwixPqTLsZiA22GHvZEdjNaRBjl47mieFibuuIWWQK0jd0lC9CHz8s1TyfbEQ==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Mon, 03 Aug 2026 15:57:32 -0300
Subject: [PATCH 7.1.y] selftests/bpf: Add tests for sleepable tracepoint
 programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-selftests-bpf-sleepable-v1-1-dc4cb88374e9@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJvkcGoC/yWMWw7CIBREt9Lcb2kAk/rYivED6GAxBAkXjabp3
 gX9PCczZyVGCWA6DysVvAKHR2qgdgO5xaQbRJgbk5Z6kke5F4zoK7iysNkLjkA2NkIA1uv5NGk
 tFbV3LvDh/Stf6DCq8UPXv+anvcPVXu1DaxjCFpPc0hXXnqNt+wKn6H/JmwAAAA==
X-Change-ID: 20260803-selftests-bpf-sleepable-eebf2d962201
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1785783453; l=10993;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=nYxKjXWof+q7Tycv1IRGu/Vn8ITWdIxa0qhQDccaG+w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPvYdeSRW8R5oNioGDKpEYp67s5aOfQ3kh85ecMqEKbN9smSR/O+KIzIda/xGvSYkM9C3OGT1de
 wUD1YcI/Esgc=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Mykyta Yatsenko <yatsenko@meta.com>

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 8a20655749c625dcc4debdfdeeaa0cf8bb85c203 ]

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on getcwd. Verify alias and bare SEC variants,
bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
attach-time rejection on non-faultable tracepoints, and load-time
rejection for sleepable tp_btf on non-faultable tracepoints.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 142 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 112 ++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..19500b785ee3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <unistd.h>
+#include "test_sleepable_tracepoints.skel.h"
+#include "test_sleepable_tracepoints_fail.skel.h"
+
+static void run_test(struct test_sleepable_tracepoints *skel)
+{
+	char buf[PATH_MAX] = "/";
+
+	skel->bss->target_pid = getpid();
+	skel->bss->prog_triggered = 0;
+	skel->bss->err = 0;
+	skel->bss->copied_byte = 0;
+
+	syscall(__NR_getcwd, buf, sizeof(buf));
+
+	ASSERT_EQ(skel->bss->prog_triggered, 1, "prog_triggered");
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->copied_byte, '/', "copied_byte");
+}
+
+static void run_auto_attach_test(struct bpf_program *prog,
+				 struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		return;
+
+	run_test(skel);
+	bpf_link__destroy(link);
+}
+
+static void test_attach_only(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_attach_reject(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_ERR_PTR(link, "attach_should_fail"))
+		bpf_link__destroy(link);
+}
+
+static void test_raw_tp_bare(struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach_raw_tracepoint(skel->progs.handle_raw_tp_bare,
+						  "sys_enter");
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_tp_bare(struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach_tracepoint(skel->progs.handle_tp_bare,
+					      "syscalls", "sys_enter_getcwd");
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_test_run(struct test_sleepable_tracepoints *skel)
+{
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	int fd, err;
+
+	fd = bpf_program__fd(skel->progs.handle_test_run);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, args[0] + args[1], "test_run_retval");
+}
+
+static void test_test_run_on_cpu_reject(struct test_sleepable_tracepoints *skel)
+{
+	__u64 args[2] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+		.flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+	int fd, err;
+
+	fd = bpf_program__fd(skel->progs.handle_test_run);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_ERR(err, "test_run_on_cpu_reject");
+}
+
+void test_sleepable_tracepoints(void)
+{
+	struct test_sleepable_tracepoints *skel;
+
+	skel = test_sleepable_tracepoints__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (test__start_subtest("tp_btf"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
+	if (test__start_subtest("raw_tp"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
+	if (test__start_subtest("tracepoint"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
+	if (test__start_subtest("sys_exit"))
+		run_auto_attach_test(skel->progs.handle_sys_exit_tp, skel);
+	if (test__start_subtest("tracepoint_alias"))
+		test_attach_only(skel->progs.handle_sys_enter_tp_alias);
+	if (test__start_subtest("raw_tracepoint_alias"))
+		test_attach_only(skel->progs.handle_sys_enter_raw_tp_alias);
+	if (test__start_subtest("raw_tp_bare"))
+		test_raw_tp_bare(skel);
+	if (test__start_subtest("tp_bare"))
+		test_tp_bare(skel);
+	if (test__start_subtest("test_run"))
+		test_test_run(skel);
+	if (test__start_subtest("test_run_on_cpu_reject"))
+		test_test_run_on_cpu_reject(skel);
+	if (test__start_subtest("raw_tp_non_faultable"))
+		test_attach_reject(skel->progs.handle_raw_tp_non_faultable);
+	if (test__start_subtest("tp_non_syscall"))
+		test_attach_reject(skel->progs.handle_tp_non_syscall);
+	if (test__start_subtest("tp_btf_non_faultable_reject"))
+		RUN_TESTS(test_sleepable_tracepoints_fail);
+
+	test_sleepable_tracepoints__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
new file mode 100644
index 000000000000..254f7fd895d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <asm/unistd.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid;
+int prog_triggered;
+long err;
+char copied_byte;
+
+static int copy_getcwd_arg(char *ubuf)
+{
+	err = bpf_copy_from_user(&copied_byte, sizeof(copied_byte), ubuf);
+	if (err)
+		return err;
+
+	prog_triggered = 1;
+	return 0;
+}
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_getcwd)
+		return 0;
+
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_getcwd)
+		return 0;
+
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
+}
+
+SEC("tp.s/syscalls/sys_enter_getcwd")
+int handle_sys_enter_tp(struct syscall_trace_enter *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	return copy_getcwd_arg((void *)args->args[0]);
+}
+
+SEC("tp.s/syscalls/sys_exit_getcwd")
+int handle_sys_exit_tp(struct syscall_trace_exit *args)
+{
+	struct pt_regs *regs;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	regs = (struct pt_regs *)bpf_task_pt_regs(bpf_get_current_task_btf());
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
+}
+
+SEC("raw_tp.s")
+int BPF_PROG(handle_raw_tp_bare, struct pt_regs *regs, long id)
+{
+	return 0;
+}
+
+SEC("tp.s")
+int handle_tp_bare(void *ctx)
+{
+	return 0;
+}
+
+SEC("tracepoint.s/syscalls/sys_enter_getcwd")
+int handle_sys_enter_tp_alias(struct syscall_trace_enter *args)
+{
+	return 0;
+}
+
+SEC("raw_tracepoint.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp_alias, struct pt_regs *regs, long id)
+{
+	return 0;
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_test_run, struct pt_regs *regs, long id)
+{
+	if ((__u64)regs == 0x1234ULL && (__u64)id == 0x5678ULL)
+		return (__u64)regs + (__u64)id;
+
+	return 0;
+}
+
+SEC("raw_tp.s/sched_switch")
+int BPF_PROG(handle_raw_tp_non_faultable, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
+
+SEC("tp.s/sched/sched_switch")
+int handle_tp_non_syscall(void *ctx)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
new file mode 100644
index 000000000000..1a0748a9520b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Sleepable program on a non-faultable tracepoint should fail to load */
+SEC("tp_btf.s/sched_switch")
+__failure __msg("Sleepable program cannot attach to non-faultable tracepoint")
+int BPF_PROG(handle_sched_switch, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index c2b7f5ebf168..6dabc5522945 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -76,7 +76,20 @@
 	.runs = -1,
 },
 {
-	"sleepable raw tracepoint reject",
+	"sleepable raw tracepoint accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_RAW_TP,
+	.kfunc = "sys_enter",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable raw tracepoint reject non-faultable",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -85,7 +98,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

---
base-commit: c7d419828268d5f3e52b74506d074955ad8c01d1
change-id: 20260803-selftests-bpf-sleepable-eebf2d962201

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

