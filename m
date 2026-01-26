Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70C227E82;
	Mon, 26 Jan 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462397; cv=none; b=FsIcpr3LDWa44FFK0DkNXdkRBSHwZQ8QHJdTtQUqMpuGg3kKf2wcnjEUdFCYXOfQ6U+TUDetl1xe7dbHXUpCpJAJ3UFIgm5Qn9VOybJpkoRTpbnFFBq62CEwln+yEIWbXVs+oLlWH/HETHSkrHjnARjQDP/2XB0dgXzP3eXPLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462397; c=relaxed/simple;
	bh=YQhRzOV7c1wRHiNiPtmxZTKFFqOs7pLcjfW0hENyymk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrQavqCNBIa5S+6/hqe8tNL4KTLbjXIq5WAHCetWNbHwQ4EBQezbPoZlYBO3/OWZAnVkeoChUDs1vjfC58fHYtp6qs7I2pK/VeJvsQ4jK87S32XWCGLRwLmHtkI9oRyDY0CUoi6t28Ta92/H1rT/V/jXM1WFablpWXyOjGmDvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muLhZdgt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muLhZdgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56E6C116C6;
	Mon, 26 Jan 2026 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462397;
	bh=YQhRzOV7c1wRHiNiPtmxZTKFFqOs7pLcjfW0hENyymk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muLhZdgtvIjB/kOCShvwP+p5ZPJQV+xvRf55y4dxX+QquWvtR1ofCjs/98RtnGvxA
	 RZAfrTyN0Fk4oDIAyyoxE6FN5uvoHf1gWbYwiP/VhKfWu5/OywKdl7iIepBXZQf4uz
	 ug5GZlhsajUYkC4L+m58hpxFrOPTWolMAeEf9QzuR+ZfCjlOwKTlW5xFm5kuZPGorM
	 Wbj4BtPD5b64G0OnpyqLXaUxkCm8thxLufMQtqyCVrt3pJTWC7+XxMI5zfkFbzOgYa
	 lJz++HiYT0AuO7zhNvANi7Pcop7TTmkrw3vJCIII6tje2LBOJZ1M8cVY/vzt4GRPKQ
	 W8zJAezGBy0fA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCHv2 bpf-next 6/6] selftests/bpf: Allow to benchmark trigger with stacktrace
Date: Mon, 26 Jan 2026 22:18:37 +0100
Message-ID: <20260126211837.472802-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126211837.472802-1-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to call bpf_get_stackid helper from trigger programs,
so far added for kprobe multi.

Adding the --stacktrace/-g option to enable it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  4 ++
 tools/testing/selftests/bpf/bench.h           |  1 +
 .../selftests/bpf/benchs/bench_trigger.c      |  1 +
 .../selftests/bpf/progs/trigger_bench.c       | 46 +++++++++++++++----
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index bd29bb2e6cb5..8368bd3a0665 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -265,6 +265,7 @@ static const struct argp_option opts[] = {
 	{ "verbose", 'v', NULL, 0, "Verbose debug output"},
 	{ "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
 	{ "quiet", 'q', NULL, 0, "Be more quiet"},
+	{ "stacktrace", 's', NULL, 0, "Get stack trace"},
 	{ "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
 	  "Set of CPUs for producer threads; implies --affinity"},
 	{ "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
@@ -350,6 +351,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'q':
 		env.quiet = true;
 		break;
+	case 's':
+		env.stacktrace = true;
+		break;
 	case ARG_PROD_AFFINITY_SET:
 		env.affinity = true;
 		if (parse_num_list(arg, &env.prod_cpus.cpus,
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index bea323820ffb..7cf21936e7ed 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -26,6 +26,7 @@ struct env {
 	bool list;
 	bool affinity;
 	bool quiet;
+	bool stacktrace;
 	int consumer_cnt;
 	int producer_cnt;
 	int nr_cpus;
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 34018fc3927f..aeec9edd3851 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -146,6 +146,7 @@ static void setup_ctx(void)
 	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true);
 
 	ctx.skel->rodata->batch_iters = args.batch_iters;
+	ctx.skel->rodata->stacktrace = env.stacktrace;
 }
 
 static void load_ctx(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 2898b3749d07..4ea0422d1042 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -25,6 +25,34 @@ static __always_inline void inc_counter(void)
 	__sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
 }
 
+volatile const int stacktrace;
+
+typedef __u64 stack_trace_t[128];
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	 __uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, stack_trace_t);
+} stack_heap SEC(".maps");
+
+static __always_inline void do_stacktrace(void *ctx)
+{
+	if (!stacktrace)
+		return;
+
+	__u64 *ptr = bpf_map_lookup_elem(&stack_heap, &(__u32){0});
+
+	if (ptr)
+		bpf_get_stack(ctx, ptr, sizeof(stack_trace_t), 0);
+}
+
+static __always_inline void handle(void *ctx)
+{
+	inc_counter();
+	do_stacktrace(ctx);
+}
+
 SEC("?uprobe")
 int bench_trigger_uprobe(void *ctx)
 {
@@ -81,21 +109,21 @@ int trigger_driver_kfunc(void *ctx)
 SEC("?kprobe/bpf_get_numa_node_id")
 int bench_trigger_kprobe(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
 SEC("?kretprobe/bpf_get_numa_node_id")
 int bench_trigger_kretprobe(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
 SEC("?kprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kprobe_multi(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
@@ -108,7 +136,7 @@ int bench_kprobe_multi_empty(void *ctx)
 SEC("?kretprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kretprobe_multi(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
@@ -121,34 +149,34 @@ int bench_kretprobe_multi_empty(void *ctx)
 SEC("?fentry/bpf_get_numa_node_id")
 int bench_trigger_fentry(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
 SEC("?fexit/bpf_get_numa_node_id")
 int bench_trigger_fexit(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
 SEC("?fmod_ret/bpf_modify_return_test_tp")
 int bench_trigger_fmodret(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return -22;
 }
 
 SEC("?tp/bpf_test_run/bpf_trigger_tp")
 int bench_trigger_tp(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
 
 SEC("?raw_tp/bpf_trigger_tp")
 int bench_trigger_rawtp(void *ctx)
 {
-	inc_counter();
+	handle(ctx);
 	return 0;
 }
-- 
2.52.0

