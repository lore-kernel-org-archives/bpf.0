Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB813C9DF
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470136; cv=none; b=UbXCs5/VSNL9exiRnRUmgpZR5pf4Eyu10oT6YqirD8LVwnUEZj0ZE1FS56YLUwu9v8CJybtn2xPbRIx43s8FPEoXNvfDQQ5Uc/w2W/rQmpioxgBK8fZMt9YVqWQWFSwVk3/kuRTFqBnHRaXc5kW5/gAU9H/ulPhKlKLLjMDn1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470136; c=relaxed/simple;
	bh=t61VyhBQy668DN9CUuo3t/duCOYg1KMBy2ezf2LPEa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmkhLrZ/CbmKA6OsZt8++5cLjxZhaDR7xa0de5cCKrvYfS/nC+Bqpplfs6E81XBy+R9q+qd9WsCnFdGWzTqsgnPbsUMCS3TAJ09cSFhLc2JL7I/2g6fB96OZB5dOhBEiEWvLU7C8+mjJgriJOX4KtjTjgJOApxRGwUSLTkbTC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps5JQEEq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps5JQEEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE7FC43390;
	Tue, 26 Mar 2024 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470136;
	bh=t61VyhBQy668DN9CUuo3t/duCOYg1KMBy2ezf2LPEa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ps5JQEEqgSNvp3SIGiQiPqAjJwhLXYBZaBiCnRYRT3YgRc4Qz8xBR2OuijK5nqE4I
	 PtVg7ipYU8HISKM9EpCBMoVH9BqChQygje6Ge2YAK+28t00Qf0uAHcH7/3pTZBnO12
	 KREpyPdVIu03v19tHZRCBb/ybGh5zMgHlqvJopB6WfNuKJ6iNGibQIbsB4hxEjSfWZ
	 QWsmDL+JFGuel5lEEFf180HEkkaMztlmeW0X1wkyJPna72wmTadW98eOqb6A4mumFC
	 TjfvxHFrReDGleYC9A+R8Hesio3VWsoCD7AB/8fA4KPVoGy796j8vYOzFdVXeZjHPb
	 N+B/oa7LU+jFg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: add batched tp/raw_tp/fmodret tests
Date: Tue, 26 Mar 2024 09:21:51 -0700
Message-ID: <20240326162151.3981687-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162151.3981687-1-andrii@kernel.org>
References: <20240326162151.3981687-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize bpf_modify_return_test_tp() kfunc to have a fast way to trigger
tp/raw_tp/fmodret programs from another BPF program, which gives us
comparable batched benchmarks to (batched) kprobe/fentry benchmarks.

We don't switch kprobe/fentry batched benchmarks to this kfunc to make
bench tool usable on older kernels as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |  6 +++
 .../selftests/bpf/benchs/bench_trigger.c      | 39 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  3 +-
 .../selftests/bpf/progs/trigger_bench.c       | 34 ++++++++++++++++
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 8b16841a3dec..82de56c8162e 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -506,6 +506,9 @@ extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fexit;
+extern const struct bench bench_trig_fmodret;
+extern const struct bench bench_trig_tp;
+extern const struct bench bench_trig_rawtp;
 
 /* uprobe/uretprobe benchmarks */
 extern const struct bench bench_trig_uprobe_nop;
@@ -556,6 +559,9 @@ static const struct bench *benchs[] = {
 	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
 	&bench_trig_fexit,
+	&bench_trig_fmodret,
+	&bench_trig_tp,
+	&bench_trig_rawtp,
 	/* uprobes */
 	&bench_trig_uprobe_nop,
 	&bench_trig_uretprobe_nop,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 2c477808a6f0..4b05539f167d 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -233,6 +233,42 @@ static void trigger_fexit_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fexit);
 }
 
+static void trigger_fmodret_setup(void)
+{
+	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver_kfunc, true);
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_fmodret, true);
+	load_ctx();
+	/* override driver program */
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_driver_kfunc);
+	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
+}
+
+static void trigger_tp_setup(void)
+{
+	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver_kfunc, true);
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_tp, true);
+	load_ctx();
+	/* override driver program */
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_driver_kfunc);
+	attach_bpf(ctx.skel->progs.bench_trigger_tp);
+}
+
+static void trigger_rawtp_setup(void)
+{
+	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver_kfunc, true);
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_rawtp, true);
+	load_ctx();
+	/* override driver program */
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_driver_kfunc);
+	attach_bpf(ctx.skel->progs.bench_trigger_rawtp);
+}
+
 /* make sure call is not inlined and not avoided by compiler, so __weak and
  * inline asm volatile in the body of the function
  *
@@ -395,6 +431,9 @@ BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
 BENCH_TRIG_KERNEL(kretprobe_multi, "kretprobe-multi");
 BENCH_TRIG_KERNEL(fentry, "fentry");
 BENCH_TRIG_KERNEL(fexit, "fexit");
+BENCH_TRIG_KERNEL(fmodret, "fmodret");
+BENCH_TRIG_KERNEL(tp, "tp");
+BENCH_TRIG_KERNEL(rawtp, "rawtp");
 
 /* uprobe benchmarks */
 #define BENCH_TRIG_USERMODE(KIND, PRODUCER, NAME)			\
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index 6e790e294260..a690f5a68b6b 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -4,7 +4,8 @@ set -eufo pipefail
 
 def_tests=( \
 	usermode-count kernel-count syscall-count \
-	fentry fexit \
+	fentry fexit fmodret \
+	rawtp tp \
 	kprobe kprobe-multi \
 	kretprobe kretprobe-multi \
 )
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 07587cb3c9f5..2619ed193c65 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -56,6 +56,19 @@ int trigger_driver(void *ctx)
 	return 0;
 }
 
+extern int bpf_modify_return_test_tp(int nonce) __ksym __weak;
+
+SEC("?raw_tp")
+int trigger_driver_kfunc(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < batch_iters; i++)
+		(void)bpf_modify_return_test_tp(0); /* attach point for benchmarking */
+
+	return 0;
+}
+
 SEC("?kprobe/bpf_get_numa_node_id")
 int bench_trigger_kprobe(void *ctx)
 {
@@ -97,3 +110,24 @@ int bench_trigger_fexit(void *ctx)
 	inc_counter();
 	return 0;
 }
+
+SEC("?fmod_ret/bpf_modify_return_test_tp")
+int bench_trigger_fmodret(void *ctx)
+{
+	inc_counter();
+	return -22;
+}
+
+SEC("?tp/bpf_test_run/bpf_trigger_tp")
+int bench_trigger_tp(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("?raw_tp/bpf_trigger_tp")
+int bench_trigger_rawtp(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.43.0

