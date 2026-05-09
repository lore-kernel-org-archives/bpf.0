Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4C246BC0
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288263; cv=none; b=Svr59j84TF6kR/xmYqYiRJA6TQkqcAmivqBoOtq0uNbiLDYJCsIbldrxP/TrkLRp6RsPzIs4oAmGMy20CG7FmVf9DWAfFwbApNL2B4qRM6zxkcdlUg/g6Zit8zoDeQE8GV4tDga+Jk8QjYpFHc/g2JPy+/DrdtfYaRpKbfoSDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288263; c=relaxed/simple;
	bh=OTeFCk920OiWmXAFGTyMwS7Yyiv3aDVCqtVqRs5s55U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlNE5DeE0Vpk8Vw4AMVufbxAEPNGJbovSDfjdEvwkoY4OcAQc2+3lyg1e5P/vqyLEP9ZoIDRVO5evcyfXh0Xn1J5T9Sl+wEEBA1U5SbIgZwdJgw5RVIomAmU2oJt+oXdz/dxRsFGMqlqaZoG9dqsbEDbEyRrXzqlEIQ8ENwS9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mq7Ocq9r; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mq7Ocq9r"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778288259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PkGLwvyM0d+IYKkhoPjrDeI5P2WDVvEb9Q031e7l8hg=;
	b=Mq7Ocq9rlxGaUd8sgnh1tW2hS6Pa5NQYp5w5ajn1TS1HgnROjnSK1RIZuJNGa0jIKIU5Rh
	N+5e/wnqj3vRS26SgSs+0t6szDGcG39p7a1gDJqOQBlNtO7AWJt6t1QLKsHdpV1Gi2Y9Vy
	cLJ4DUvz7BhyIK+a93IaHk+L4Nw3BQE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Use both hrtimer enqueue helpers in vmlinux test
Date: Fri,  8 May 2026 17:57:30 -0700
Message-ID: <20260509005730.250956-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The vmlinux selftest triggers nanosleep and checks that both kprobe
and fentry programs observe the hrtimer enqueue path.

After the hrtimer_start_expires_user() conversion [1], nanosleep
reaches hrtimer_start_range_ns_user() instead of
hrtimer_start_range_ns(). Hard-coding either symbol makes the test
fail either on bpf tree or on linux-next [2].

Update the test to resolve the target symbol at runtime via
libbpf_find_vmlinux_btf_id(). This is a nice example of how to modify
a BPF program to work on both older and newer kernel revision.

[1] https://lore.kernel.org/all/20260408114952.062400833@kernel.org/
[2] https://github.com/kernel-patches/bpf/actions/runs/25485909958/job/74782902203

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

v1->v2:
  * Use bpf_program__set_attach_target() and bpf_program__attach_kprobe()
    to avoid duplicating BPF programs (Amery)
v1: https://lore.kernel.org/all/20260507113915.24988-1-ihor.solodrai@linux.dev/

---
 .../selftests/bpf/prog_tests/vmlinux.c        | 45 ++++++++++++++++++-
 .../selftests/bpf/progs/test_vmlinux.c        |  4 +-
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
index 6fb2217d940b..b5fdd593910d 100644
--- a/tools/testing/selftests/bpf/prog_tests/vmlinux.c
+++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
@@ -14,21 +14,61 @@ static void nsleep()
 	(void)syscall(__NR_nanosleep, &ts, NULL);
 }
 
+static const char *hrtimer_func = "hrtimer_start_range_ns";
+
+static int setup_hrtimer_progs(struct test_vmlinux *skel)
+{
+	int err;
+
+	if (libbpf_find_vmlinux_btf_id("hrtimer_start_range_ns_user", BPF_TRACE_FENTRY) > 0)
+		hrtimer_func = "hrtimer_start_range_ns_user";
+
+	err = bpf_program__set_attach_target(skel->progs.handle__fentry, 0, hrtimer_func);
+	if (err)
+		return err;
+
+	/*
+	 * Bare SEC("kprobe") has no target function, so attach it manually
+	 * later after selecting the hrtimer function to probe.
+	 */
+	bpf_program__set_autoattach(skel->progs.handle__kprobe, false);
+
+	return 0;
+}
+
 void test_vmlinux(void)
 {
 	int err;
 	struct test_vmlinux* skel;
 	struct test_vmlinux__bss *bss;
+	struct bpf_link *kprobe_link = NULL;
 
-	skel = test_vmlinux__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open_and_load"))
+	skel = test_vmlinux__open();
+	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open"))
 		return;
+
+	err = setup_hrtimer_progs(skel);
+	if (!ASSERT_OK(err, "setup_hrtimer_progs"))
+		goto cleanup;
+
+	err = test_vmlinux__load(skel);
+	if (!ASSERT_OK(err, "test_vmlinux__load"))
+		goto cleanup;
+
 	bss = skel->bss;
 
 	err = test_vmlinux__attach(skel);
 	if (!ASSERT_OK(err, "test_vmlinux__attach"))
 		goto cleanup;
 
+	/* manually attach kprobe with the selected function */
+	if (hrtimer_func) {
+		kprobe_link = bpf_program__attach_kprobe(skel->progs.handle__kprobe,
+							 false /* retprobe */, hrtimer_func);
+		if (!ASSERT_OK_PTR(kprobe_link, "bpf_program__attach_kprobe"))
+			goto cleanup;
+	}
+
 	/* trigger everything */
 	nsleep();
 
@@ -39,5 +79,6 @@ void test_vmlinux(void)
 	ASSERT_TRUE(bss->fentry_called, "fentry");
 
 cleanup:
+	bpf_link__destroy(kprobe_link);
 	test_vmlinux__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index 78b23934d9f8..eea556940df6 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -69,7 +69,7 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
 	return 0;
 }
 
-SEC("kprobe/hrtimer_start_range_ns")
+SEC("kprobe")
 int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	       const enum hrtimer_mode mode)
 {
@@ -78,7 +78,7 @@ int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	return 0;
 }
 
-SEC("fentry/hrtimer_start_range_ns")
+SEC("fentry")
 int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	     const enum hrtimer_mode mode)
 {
-- 
2.54.0

