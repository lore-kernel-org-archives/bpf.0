Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794425993;
	b=tZsQH83TciTffkU6sALC9ljov20LcgBEjgRE/n2lU4BSV/ii138XS8SA2fIjcsDIi0/h
	 I7F8al8USQYF6fewwMdULDKWZltiOCn5T3iHRfj7KqHmrohZqC1uDitKg2pUUAazGhYUr
	 GVsD3yjFjpo1Ac6NFcpA2Nd0rU84fakwBvKjDW9Wg/0dfL6LaOZ91gSZKz6kiwYI5mv5e
	 pgz7VYxrQRH0vJ9pFF4wTOWojUbslpYbG/VotG4AwkfIrEx04GMZD1nyZllX3cqMsvTZf
	 pRNgdqa90A8il5QPspv6BtrO1OOWfbm/4m7lix61wuBQ/SXWGKIGaL4BliMOmiJXl4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425993;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ijzHD4xJZ8Z5LuWRGTJbu77iH/ZNmgkdR3asZcVvThY=;
	b=GAWkfgaV0/Pd2NJK4Qbb20EIsg06mxdIQp8vMkrQagO4+TjxK2QcG8C4DCeVSfvn2mfu
	 SbDPAEjGkFz287uox4Rq/NlljFoq5dUgO65GJK2yMAW0P8htzrTx8cX1HSQQEPiZcKc7B
	 tWpuJQJyhDfjDEbZ2yeovRhk2KWbnTpWjgZKjn1nGveX4KDUNq4EDCaaklxakfQiDt7Q/
	 LTYO4ZAzYSzf4BsgOuhW05zbuoNl0gNz2/O1TOA6KUFlsZYigb+PDVMkN5wzhhHb0DqyI
	 sfhk1MM1v8zIoRprrHiEDGo+YVWuIyqsfIToRKZ/2Llo7PmnP1Wb6g/JEGPUB0PKz4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8mPTulY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A692606A885;
	Wed, 11 Nov 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8mPTulY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794425993;
	b=WQRSDCINIcHrBJCVJzwiCHuavJES61kP8KgY6sz2Mmk4GrTaATsvzqymleByS/GmfQjC
	 Z8sr+UDMQx5z2Gd1Yao55UXUajHJK9NsHbadM4ll+MZMk4TSL2wqAfZ5p2VpINGdYMsZp
	 dMxz7wFiwLroc5Y9vUMKwgKwuRbyKMGayOyCibTStWik8dMScz6MLutPunWkj1set+0u6
	 mg7YBE5RGDoIV3IkgK1Wt0DyC5txf+UuP4wwH9u2scTUamoEN3yzhhx8rY/HWXrObSn1Q
	 J9GCoOtvnyNsVyi4PBlvycGpxEQ+CMArjPpPPOWPQeuhcEvW8UGWfBXvaw84Pp3aKyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794425993;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ijzHD4xJZ8Z5LuWRGTJbu77iH/ZNmgkdR3asZcVvThY=;
	b=gVClTJIs0TVLG+pfAcPRGUxIvbKCO7FyyFAjRvb570gxStvWQt/Cz3TKZuQ3Da+/ZfA9
	 /aejbp9pSyLVOX/tdwT3WmQxrf9cIDSce2RI/95UPZnCM5qSrH/axU3iuoF8hzLiG4m/8
	 N8UdsiWYF7WDDRKVqPk9PREl/xm7hGSBL0MlIEWmEyu0Pb42MmmlJt3MaeCGQMounMYWW
	 TZLuXleoLkQkibnWPJbGzztoVI5c/896M7HgHEERfk4tLgHCo6I6lOKyU5ZPSt/IRotzX
	 wEpF5xauBjgbAzFjSxbo6tkKmufVDclhFd5p1yuOYVQ5LnZHH4yUCdiTc479RpEjmqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 202281F00A10;
	Wed, 11 Nov 2026 19:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425993;
	bh=ijzHD4xJZ8Z5LuWRGTJbu77iH/ZNmgkdR3asZcVvThY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=V8mPTulYcrFaKklCLqx7I23cE/Qmr8dxUGmqGpSTKUrZf1D13vu6GarIzV37VQGwb
	 PVJHQUXGgL+6X9hYKWyXLHUutKoQs3S1uZaETwUgJKrT22mt5UQ230FRVthAgsOUWu
	 5NoqzLG89blG5ltfxrKJ93O9C+Ik3Z5avqr8NQfjgYPlHNOm6XEOm8xN8RbcopTT/t
	 +uxPNPZ/UKrM3s1Pl/oewOPP6/RwjwEJSQZ7kI9gSSdOekDEwGbH/GVXsQPP+/VpLj
	 hIjl9e/axV2JFoPbn7T+nItQViqY7QLEHw4D1g+BAgmqZYhzx08DWKQuqWFr3xzwtY
	 aDbHp3ykSm50A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00DF5490CA;
	Wed, 11 Nov 2026 19:39:51 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org>
Date: Wed, 11 Nov 2026 21:39:51 +0200
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Test syscall tracepoint
 programs under preemption
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-bpf-preempt-v2-r2-v2-5-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mike Bazov <mikeba@sentinelone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794425986; l=5984;
 i=mikeba@sentinelone.com; s=20261022; h=from:subject:message-id;
 bh=tZ3h3zlk5gZewJOcwTZGC4amQ/qD5S2tjhbroNJXdXY=;
 b=HN1crOzSpxHdzxcK5fDb6DdVngujp0zKQb13Vx/Ms1+8BGezDElI2FaTiIHp2RSDzM+iowa0y
 kcOR0NlmXZ7Cj/JPKgkSJkYeT0id2Msa8Cn7VdaS97m4Hvx2fPlzN9f
X-Developer-Key: i=mikeba@sentinelone.com; a=ed25519;
 pk=DBXcQ0qoCkgacRsRwT1JU7oOWpWSYuTyLiXMfNLcP+A=
X-Endpoint-Received: by B4 Relay for mikeba@sentinelone.com/20261022 with
 auth_id=1284
X-Original-From: Mike Bazov <mikeba@sentinelone.com>
Reply-To: mikeba@sentinelone.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mikeba@sentinelone.com>

Add subtests for classic tracepoint programs on sys_enter_prctl, which
run preemptibly:

- tp_syscall: the same two-thread scenario as the other subtests.
- tailcall_tp: a tracepoint dispatcher tail-calls a large-stack handler.
- tp_dual: one program attached to sys_enter_prctl and to the regular
  task_rename tracepoint, told apart by their attach cookies. A enters
  it through the syscall tracepoint, B through task_rename.

Without the per-task check, every subtest counts recursion misses:
tp_syscall and tailcall_tp drop B's run, and tp_dual drops B's run
through sys_enter_prctl. Without the private-stack change, tailcall_tp
and tp_dual corrupt A's stack.

Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
---
 .../selftests/bpf/prog_tests/trampoline_preempt.c  | 43 ++++++++++++++++++++--
 .../selftests/bpf/progs/trampoline_preempt.c       | 37 +++++++++++++++++++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c b/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c
index e01a2ba8916a..a8109290e88d 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c
@@ -25,8 +25,11 @@ enum subtest_kind {
 	SUBTEST_RAW_TP_S,
 	SUBTEST_TP_BTF,
 	SUBTEST_FSESSION,
+	SUBTEST_TP_SYSCALL,
 	SUBTEST_TAILCALL_RAW_TP,
+	SUBTEST_TAILCALL_TP,
 	SUBTEST_TWO_DISPATCHERS,
+	SUBTEST_TP_DUAL,
 	SUBTEST_NESTED_PROG,
 };
 
@@ -158,7 +161,7 @@ static void run_subtest(enum subtest_kind kind)
 	sigset_t oldset;
 	pthread_t ta, tb;
 	bool ta_started = false, tb_started = false, sigmask_set = false;
-	bool via_map;
+	bool via_map, dual = false;
 	__u32 zero = 0;
 	int tail_fd;
 	char ch;
@@ -193,17 +196,29 @@ static void run_subtest(enum subtest_kind kind)
 	case SUBTEST_FSESSION:
 		prog = c.skel->progs.on_fsession;
 		break;
+	case SUBTEST_TP_SYSCALL:
+		prog = c.skel->progs.on_tp_syscall;
+		break;
 	case SUBTEST_TAILCALL_RAW_TP:
 		prog = c.skel->progs.dispatcher_raw_tp;
 		tail = c.skel->progs.handler_raw_tp;
 		jmp = c.skel->maps.jmp_raw_tp;
 		break;
+	case SUBTEST_TAILCALL_TP:
+		prog = c.skel->progs.dispatcher_tp;
+		tail = c.skel->progs.handler_tp;
+		jmp = c.skel->maps.jmp_tp;
+		break;
 	case SUBTEST_TWO_DISPATCHERS:
 		prog = c.skel->progs.dispatcher_a;
 		extra = c.skel->progs.dispatcher_b;
 		tail = c.skel->progs.handler_raw_tp;
 		jmp = c.skel->maps.jmp_raw_tp;
 		break;
+	case SUBTEST_TP_DUAL:
+		prog = c.skel->progs.on_tp_dual;
+		dual = true;
+		break;
 	case SUBTEST_NESTED_PROG:
 		prog = c.skel->progs.on_raw_tp_nested;
 		break;
@@ -242,9 +257,23 @@ static void run_subtest(enum subtest_kind kind)
 		if (!ASSERT_OK_PTR(wakeup_link, "attach_wakeup"))
 			goto out;
 	}
-	link = bpf_program__attach(prog);
-	if (!ASSERT_OK_PTR(link, "attach"))
-		goto out;
+	if (dual) {
+		LIBBPF_OPTS(bpf_tracepoint_opts, topts, .bpf_cookie = 1);
+
+		link = bpf_program__attach_tracepoint_opts(prog, "syscalls",
+							   "sys_enter_prctl", &topts);
+		if (!ASSERT_OK_PTR(link, "attach_sys_enter"))
+			goto out;
+		topts.bpf_cookie = 2;
+		link2 = bpf_program__attach_tracepoint_opts(prog, "task",
+							    "task_rename", &topts);
+		if (!ASSERT_OK_PTR(link2, "attach_task_rename"))
+			goto out;
+	} else {
+		link = bpf_program__attach(prog);
+		if (!ASSERT_OK_PTR(link, "attach"))
+			goto out;
+	}
 	if (extra) {
 		link2 = bpf_program__attach(extra);
 		if (!ASSERT_OK_PTR(link2, "attach_extra"))
@@ -412,10 +441,16 @@ void test_trampoline_preempt(void)
 		run_subtest(SUBTEST_TP_BTF);
 	if (test__start_subtest("fsession"))
 		run_subtest(SUBTEST_FSESSION);
+	if (test__start_subtest("tp_syscall"))
+		run_subtest(SUBTEST_TP_SYSCALL);
 	if (test__start_subtest("tailcall_raw_tp"))
 		run_subtest(SUBTEST_TAILCALL_RAW_TP);
+	if (test__start_subtest("tailcall_tp"))
+		run_subtest(SUBTEST_TAILCALL_TP);
 	if (test__start_subtest("two_dispatchers"))
 		run_subtest(SUBTEST_TWO_DISPATCHERS);
+	if (test__start_subtest("tp_dual"))
+		run_subtest(SUBTEST_TP_DUAL);
 	if (test__start_subtest("nested_prog"))
 		run_subtest(SUBTEST_NESTED_PROG);
 	if (test__start_subtest("recursion_raw_tp"))
diff --git a/tools/testing/selftests/bpf/progs/trampoline_preempt.c b/tools/testing/selftests/bpf/progs/trampoline_preempt.c
index 78ed74627a79..e8e610fc885e 100644
--- a/tools/testing/selftests/bpf/progs/trampoline_preempt.c
+++ b/tools/testing/selftests/bpf/progs/trampoline_preempt.c
@@ -27,6 +27,13 @@ struct {
 	__type(value, __u32);
 } jmp_raw_tp SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} jmp_tp SEC(".maps");
+
 int tid_a;
 int tid_b;
 int sig;
@@ -184,6 +191,12 @@ int BPF_PROG(on_fsession)
 	return handle_comm(false);
 }
 
+SEC("tp/syscalls/sys_enter_prctl")
+int on_tp_syscall(void *ctx)
+{
+	return handle_comm(false);
+}
+
 SEC("raw_tp/task_rename")
 int dispatcher_raw_tp(void *ctx)
 {
@@ -197,6 +210,19 @@ int handler_raw_tp(void *ctx)
 	return handle_comm(false);
 }
 
+SEC("tp/syscalls/sys_enter_prctl")
+int dispatcher_tp(void *ctx)
+{
+	bpf_tail_call(ctx, &jmp_tp, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_prctl")
+int handler_tp(void *ctx)
+{
+	return handle_comm(false);
+}
+
 SEC("raw_tp/task_rename")
 int dispatcher_a(void *ctx)
 {
@@ -213,6 +239,17 @@ int BPF_PROG(dispatcher_b, struct pt_regs *regs, long id)
 	return 0;
 }
 
+SEC("tp/syscalls/sys_enter_prctl")
+int on_tp_dual(void *ctx)
+{
+	__u32 tid = (__u32)bpf_get_current_pid_tgid();
+	__u64 cookie = bpf_get_attach_cookie(ctx);
+
+	if ((tid == tid_a && cookie != 1) || (tid == tid_b && cookie != 2))
+		return 0;
+	return handle_comm(false);
+}
+
 SEC("raw_tp/bpf_trace_printk")
 int recur_raw_tp(void *ctx)
 {

-- 
2.43.0


