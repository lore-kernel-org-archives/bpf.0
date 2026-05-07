Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A693C872E
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153980; cv=none; b=sNiv0AfpBgkRXx7EvbVqVx7P3nxm7bWNKrHmwTosX6O+yXAB4MbG2ed5G8jHsVbet/+1foqlDs57x62YyfbdFVnTu7gELijRMkuV90MvdJ9S1JA4CV3sSi7pJ3YFNgTs51qMYpI5Slv7g/ODKr54REsM7TmgfTqN6cEc8UDBXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153980; c=relaxed/simple;
	bh=swSS9v3v3p8QKj7drLz8cjLKnnGpO5q/W1ZUbRKMjPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TR95QB8vAS+jaN1pHoPFP0tHoBteRHiJUbvI/FAUbtvgBbkTIrdMkoSkoLoF0S0mJF4bK2Z9ASJQGMBrvB3zlodE0MgPL9IFYlCpgHMrhXtUO6ZPRY76FGsVR6q0Mpj0JM3+xQ75VtT5ulOu7f5anUQzTS0L/0cMwveI/cz1ErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbaCU7bH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbaCU7bH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778153976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omKTkFdfT8UuMr5M8sNpbUoIKUaZpVe4MtuB1A7IN9E=;
	b=WbaCU7bHAns8PYTjbxJNA8HGlzyuPg1C94Iq2CqXDZNHsZkK05CqAjvwpgVzTenuUHlxRG
	K5lTS0UAHQjnMb1GUC8elihw/oIbgiEBeLmxIPF3skGmR4CmXLhxSx2uqyGWxb0ffLu8Eq
	oC4NTwHH/9LKTjxcLHkJT5ysNsBE2DY=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Use both hrtimer enqueue helpers in vmlinux test
Date: Thu,  7 May 2026 13:39:15 +0200
Message-ID: <20260507113915.24988-1-ihor.solodrai@linux.dev>
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

Keep both hook variants as optional BPF programs and enable the pair
matching the running kernel before loading the object. This is also a
nice example of how to modify a BPF program to work on both older and
newer kernel revision.

[1] https://lore.kernel.org/all/20260408114952.062400833@kernel.org/
[2] https://github.com/kernel-patches/bpf/actions/runs/25485909958/job/74782902203

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/vmlinux.c        | 26 +++++++++++++++++--
 .../selftests/bpf/progs/test_vmlinux.c        | 22 ++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
index 6fb2217d940b..286feff31488 100644
--- a/tools/testing/selftests/bpf/prog_tests/vmlinux.c
+++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
@@ -14,15 +14,37 @@ static void nsleep()
 	(void)syscall(__NR_nanosleep, &ts, NULL);
 }
 
+static void enable_hrtimer_progs(struct test_vmlinux *skel)
+{
+	bool has_user_helper;
+
+	has_user_helper = libbpf_find_vmlinux_btf_id("hrtimer_start_range_ns_user",
+						    BPF_TRACE_FENTRY) > 0;
+	if (has_user_helper) {
+		bpf_program__set_autoload(skel->progs.handle__kprobe_user, true);
+		bpf_program__set_autoload(skel->progs.handle__fentry_user, true);
+	} else {
+		bpf_program__set_autoload(skel->progs.handle__kprobe, true);
+		bpf_program__set_autoload(skel->progs.handle__fentry, true);
+	}
+}
+
 void test_vmlinux(void)
 {
 	int err;
 	struct test_vmlinux* skel;
 	struct test_vmlinux__bss *bss;
 
-	skel = test_vmlinux__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open_and_load"))
+	skel = test_vmlinux__open();
+	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open"))
 		return;
+
+	enable_hrtimer_progs(skel);
+
+	err = test_vmlinux__load(skel);
+	if (!ASSERT_OK(err, "test_vmlinux__load"))
+		goto cleanup;
+
 	bss = skel->bss;
 
 	err = test_vmlinux__attach(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index 78b23934d9f8..c90f7ac63f91 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -69,7 +69,7 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
 	return 0;
 }
 
-SEC("kprobe/hrtimer_start_range_ns")
+SEC("?kprobe/hrtimer_start_range_ns")
 int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	       const enum hrtimer_mode mode)
 {
@@ -78,7 +78,7 @@ int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	return 0;
 }
 
-SEC("fentry/hrtimer_start_range_ns")
+SEC("?fentry/hrtimer_start_range_ns")
 int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	     const enum hrtimer_mode mode)
 {
@@ -87,4 +87,22 @@ int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
 	return 0;
 }
 
+SEC("?kprobe/hrtimer_start_range_ns_user")
+int BPF_KPROBE(handle__kprobe_user, struct hrtimer *timer, ktime_t tim,
+	       u64 delta_ns, const enum hrtimer_mode mode)
+{
+	if (tim == MY_TV_NSEC)
+		kprobe_called = true;
+	return 0;
+}
+
+SEC("?fentry/hrtimer_start_range_ns_user")
+int BPF_PROG(handle__fentry_user, struct hrtimer *timer, ktime_t tim,
+	     u64 delta_ns, const enum hrtimer_mode mode)
+{
+	if (tim == MY_TV_NSEC)
+		fentry_called = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

