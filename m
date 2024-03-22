Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328162F30
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065663; cv=none; b=jUlAb0+df0ykViqqK1RMgPlMr/VV/R9U6CqWrumuVkt1lXmgShKXoXBbOJPdCxNtzIGkETCfjvinmRaVP+hZYhd41Jl/ZJDwtmv7XysUkB4UzUqzyrC9ekOLbeixqoCwdMjQ32tq4DKF6b8DcySE7gfWY/dFBcoSa1raDpov7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065663; c=relaxed/simple;
	bh=FfoAZ0Wl0rvhW1Qg/x8M4XrMSTRiLcIbAoP//uN5TUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+VI2w0V4S9mxt0Ct79WN83CxPIQbfb/XfeB3ESOYORTPSE9sinbAvi7EmZWrGOAncwxjQTQFV5RD8/XqBR/D8AtY5MzmgzqC7QVOiiaQ0lQgDTwZkrG1jRuhvOZDAn4+R94zEavHtpnwF/2KShhkjV2yidTsmHyG6D7S7mTfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBjB+l/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBjB+l/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3D4C433F1;
	Fri, 22 Mar 2024 00:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065663;
	bh=FfoAZ0Wl0rvhW1Qg/x8M4XrMSTRiLcIbAoP//uN5TUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBjB+l/fM36z5pD2zuIpVqCArLKY9FxaQIQaz9o7LdnhJIfei5O2E9RfTNG2XbGOU
	 s/hwK5rf8CxRs1ZawM2grE9NT7CnnxNw7NKHs3TK6JJuotYajyF3aaB3S8jRWiSoJe
	 eAbmeURpcGYRKJrcevrNvitLA5Dv89P6amjPNmnTtn2iwBp94RLgg2uRO+68mWs9UO
	 dRF8Yt2DnozClYRetSvGb9GoINMLs0c706KcCLm9FOClmmKlUqK7Cy9lCMKq5di7O3
	 7UW698KnMcApynxmwPkH7CpVfxmoSHUqMO6CAGLbVc/IZu8fWa11SUllfOToe7/HGa
	 MgX8FjLzPCbig==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/6] selftests/bpf: lazy-load trigger bench BPF programs
Date: Thu, 21 Mar 2024 17:00:39 -0700
Message-ID: <20240322000041.2919948-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322000041.2919948-1-andrii@kernel.org>
References: <20240322000041.2919948-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of front-loading all possible benchmarking BPF programs for
trigger benchmarks, explicitly specify which BPF programs are used by
specific benchmark and load only it.

This allows to be more flexible in supporting older kernels, where some
program types might not be possible to load (e.g., those that rely on
newly added kfunc).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/benchs/bench_trigger.c      | 36 +++++++++++++++++--
 .../selftests/bpf/progs/trigger_bench.c       | 18 +++++-----
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 567aad2d6f09..e454d7de2252 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -128,8 +128,6 @@ static void trigger_measure(struct bench_res *res)
 
 static void setup_ctx(void)
 {
-	int err;
-
 	setup_libbpf();
 
 	ctx.skel = trigger_bench__open();
@@ -138,7 +136,15 @@ static void setup_ctx(void)
 		exit(1);
 	}
 
+	/* default "driver" BPF program */
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true);
+
 	ctx.skel->rodata->batch_iters = args.batch_iters;
+}
+
+static void load_ctx(void)
+{
+	int err;
 
 	err = trigger_bench__load(ctx.skel);
 	if (err) {
@@ -167,6 +173,9 @@ static void trigger_syscall_count_setup(void)
 static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
+	load_ctx();
 	/* override driver program */
 	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
 }
@@ -174,36 +183,48 @@ static void trigger_kernel_count_setup(void)
 static void trigger_kprobe_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_kprobe, true);
+	load_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_kprobe);
 }
 
 static void trigger_kretprobe_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_kretprobe, true);
+	load_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe);
 }
 
 static void trigger_kprobe_multi_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_kprobe_multi, true);
+	load_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_multi);
 }
 
 static void trigger_kretprobe_multi_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_kretprobe_multi, true);
+	load_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_multi);
 }
 
 static void trigger_fentry_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_fentry, true);
+	load_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
 static void trigger_fexit_setup(void)
 {
 	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_fexit, true);
+	load_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_fexit);
 }
 
@@ -274,15 +295,24 @@ static void usetup(bool use_retprobe, void *target_addr)
 {
 	size_t uprobe_offset;
 	struct bpf_link *link;
+	int err;
 
 	setup_libbpf();
 
-	ctx.skel = trigger_bench__open_and_load();
+	ctx.skel = trigger_bench__open();
 	if (!ctx.skel) {
 		fprintf(stderr, "failed to open skeleton\n");
 		exit(1);
 	}
 
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_uprobe, true);
+
+	err = trigger_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
 	uprobe_offset = get_uprobe_offset(target_addr);
 	link = bpf_program__attach_uprobe(ctx.skel->progs.bench_trigger_uprobe,
 					  use_retprobe,
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 81990e45b547..07587cb3c9f5 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -25,7 +25,7 @@ static __always_inline void inc_counter(void)
 	__sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
 }
 
-SEC("uprobe")
+SEC("?uprobe")
 int bench_trigger_uprobe(void *ctx)
 {
 	inc_counter();
@@ -34,7 +34,7 @@ int bench_trigger_uprobe(void *ctx)
 
 const volatile int batch_iters = 0;
 
-SEC("raw_tp")
+SEC("?raw_tp")
 int trigger_count(void *ctx)
 {
 	int i;
@@ -45,7 +45,7 @@ int trigger_count(void *ctx)
 	return 0;
 }
 
-SEC("raw_tp")
+SEC("?raw_tp")
 int trigger_driver(void *ctx)
 {
 	int i;
@@ -56,42 +56,42 @@ int trigger_driver(void *ctx)
 	return 0;
 }
 
-SEC("kprobe/bpf_get_numa_node_id")
+SEC("?kprobe/bpf_get_numa_node_id")
 int bench_trigger_kprobe(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
-SEC("kretprobe/bpf_get_numa_node_id")
+SEC("?kretprobe/bpf_get_numa_node_id")
 int bench_trigger_kretprobe(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
-SEC("kprobe.multi/bpf_get_numa_node_id")
+SEC("?kprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kprobe_multi(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
-SEC("kretprobe.multi/bpf_get_numa_node_id")
+SEC("?kretprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kretprobe_multi(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
-SEC("fentry/bpf_get_numa_node_id")
+SEC("?fentry/bpf_get_numa_node_id")
 int bench_trigger_fentry(void *ctx)
 {
 	inc_counter();
 	return 0;
 }
 
-SEC("fexit/bpf_get_numa_node_id")
+SEC("?fexit/bpf_get_numa_node_id")
 int bench_trigger_fexit(void *ctx)
 {
 	inc_counter();
-- 
2.43.0

