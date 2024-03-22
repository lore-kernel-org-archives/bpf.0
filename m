Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C83C38
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065671; cv=none; b=iNVepfMj9Xdrofx0mckeLmhiW+qHYnl+08SUtKhRCsMxQvJoEkD6AAIjnYZXeVUdBCiOTFIa8fzIEHTRpAc862acTrMw08IZwzvKo5XCXUfh2Ztk/DlsBhJQ/ZEFU/7oBezsKfsFw3GHilM5J84dITtLP6IiM0kNdH0ZNG8T/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065671; c=relaxed/simple;
	bh=wdvQRy4wOgdYyfXL64ZdYS6o5z9qVPOWHI30GDYsYQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N537YNIteCZbegmvitvuxkaxapiJcPDaipDVGeYzWBKnrmxmJzcaPwGdk15/sQmeEee1D2u0Bsh4aeUnMIk0U83szDjWb2Nt3Z78O6NjP6femv0iEzu8qtbQNGlu3MueLnFhI01UXUlQXYpO1jFvNGsRB7aXjVhyy0voIcMaLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ9EdDZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ9EdDZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A66C433C7;
	Fri, 22 Mar 2024 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065669;
	bh=wdvQRy4wOgdYyfXL64ZdYS6o5z9qVPOWHI30GDYsYQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQ9EdDZoORxYgJ3zegG1gU4SxHC+Snd/gAkpTg8nZ4n0YL8sa0btYZiWvl69St1Fh
	 tlw1ZEL7IlaabU9Y2e/U6JxAKwHtz6pktROAkUvbgt/86w4aXW3lw+8RZ/TAcjntFL
	 3awDl/95Irg1MjRKxQSyqM60PiZrxLAFfwHabupqZbDxLBJokN+AsKCcNejJLsPhpY
	 kZeirNJaW+kXW4ScLd118z6tSC4RCSWY0ZYwo7w4i58RLCm/TFP4TkOEMdD8KyLMxe
	 UQ/Ou96DWtdd4gzuGBJDWKOxE81qDv7fy1c5EIz8lofQoH6nVfMW0ysBArN4QzIOWA
	 OfXqVYtXYjFjA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 6/6] selftests/bpf: add batched tp/raw_tp/fmodret tests
Date: Thu, 21 Mar 2024 17:00:41 -0700
Message-ID: <20240322000041.2919948-7-andrii@kernel.org>
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

Utilize bpf_test_tp() kfunc to have a fast way to trigger
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
index e454d7de2252..5c4b8987ccbd 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -228,6 +228,42 @@ static void trigger_fexit_setup(void)
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
@@ -390,6 +426,9 @@ BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
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
index 07587cb3c9f5..914ed625441a 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -56,6 +56,19 @@ int trigger_driver(void *ctx)
 	return 0;
 }
 
+extern int bpf_test_tp(int nonce) __ksym __weak;
+
+SEC("?raw_tp")
+int trigger_driver_kfunc(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < batch_iters; i++)
+		(void)bpf_test_tp(0); /* attach point for benchmarking */
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
+SEC("?fmod_ret/bpf_test_tp")
+int bench_trigger_fmodret(void *ctx)
+{
+	inc_counter();
+	return -22;
+}
+
+SEC("?tp/bpf_test/bpf_test")
+int bench_trigger_tp(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
+SEC("?raw_tp/bpf_test")
+int bench_trigger_rawtp(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
-- 
2.43.0

