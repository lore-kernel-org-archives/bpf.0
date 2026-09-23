Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB757535FD0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172143; cv=none; b=pPv3d5VsZKIvGb8lMcOlCBPrTLVF0zfqJZOkMXVk1UumG+URHD+70IJVtumQOJbzNSfh9ozhcHzub+tzhf0I++inFk8v7Q2M8MNq2y4PspHrQDmQXe74mkYlBOBH7HuwSC3jhsuDxPJ8eaFlxNGYwqdbuc4JdiZivVoFnjj94MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172143; c=relaxed/simple;
	bh=DdSpORdAm2Up9OROt9ZDxetj1OlbN9o7iu6RF3psrBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvOSeapp7KcyOtxwBrGQvyU7yy4yGGFWE/RcDVrhxIsfoP6RfHr3rwxxcOJ4ci0mEMMMWjt09sTe+TDrtvYBke8AS7GO2l59Ws+aaznpR9qxUn1OfOWXmjzxudc04QjT2JijUoN2KZ6EDzYSNz6eAKEJbyZmegNmOCu+/XGiIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDgMIfNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDgMIfNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414DE1F000FF;
	Wed, 23 Sep 2026 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790172141;
	bh=Rm8lnHJhtTX9YGl9WQhg2aG//XzOc+O/zGHPeiTR8OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDgMIfNiHKss30MrzvEmnWOqm3CLI9Oxdwi7sCPpuxMURGuqRiYQ9mA0qLYMXHl0g
	 K1Yrqd2NW2U6dnNHS7zUn4KNdCN8abmhETAfclfSwCjQg390Zr5NOLjXHxhy9/q7zj
	 1PeMa/1CZjyNjvAsnAobVVw3tFNoA/W9tYPGpIsCBjEzKFl5ljJgc6UDmaz6gaxDv4
	 J7nHD3bZHY8uogs/1dBLmk6KSEdSduJkBurHb3WxmFvDmMiQJ1l7aKT3HVEY9jTpGu
	 cv3W6BEBJHFOq9aI3BGw1QbvxdVgxPFSj3/0LK0PmNlfrjERLiO04UQugR29vfg2yR
	 aVgptfnYMO+Ww==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add timer tests for a re-arming callback with a loop
Date: Wed, 23 Sep 2026 07:01:50 -0700
Message-ID: <20260923140152.4005097-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923140152.4005097-1-puranjay@kernel.org>
References: <20260923140152.4005097-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing timer callbacks either do not re-arm through
bpf_timer_set_callback(), which is what starts another async callback
entry, or do not reach a loop once they do. Cover that: loop_cb() re-arms
itself and reaches a bounded loop through sum_to(), which is static and
not inlined, so the loop is walked in a frame below the callback's rather
than in a separately verified global subprog. Without the preceding fix
the program is rejected with "infinite loop detected".

Telling async callback entries apart must not stop the verifier catching
a real loop in a callback, and no existing test covers that either, so
also check that a callback which never returns is still rejected.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/timer.c  | 33 ++++++++++++
 tools/testing/selftests/bpf/progs/timer.c     | 50 ++++++++++++++++++-
 .../selftests/bpf/progs/timer_failure.c       | 29 +++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 09ff21e1ad2f0..178223190b8b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -262,6 +262,34 @@ static int timer_cancel_async(struct timer *timer_skel)
 	return 0;
 }
 
+/*
+ * A timer callback which re-arms itself and reaches a loop through a call:
+ * the two entries into the callback meet at the loop, in a frame of its own.
+ */
+static int timer_loop_rearm(struct timer *timer_skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd, i;
+
+	err = timer__attach(timer_skel);
+	if (!ASSERT_OK(err, "timer_attach"))
+		return err;
+
+	timer_skel->bss->loop_rearm = 1;
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test_loop_rearm);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		return err;
+
+	for (i = 0; i < 100 && timer_skel->bss->loop_sum < 120 * 2; i++)
+		usleep(1000);
+
+	timer__detach(timer_skel);
+	ASSERT_EQ(timer_skel->bss->loop_sum, 120 * 2, "loop_sum");
+	return 0;
+}
+
 static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
@@ -287,6 +315,11 @@ void serial_test_timer(void)
 	RUN_TESTS(timer_failure);
 }
 
+void serial_test_timer_loop_rearm(void)
+{
+	test_timer(timer_loop_rearm);
+}
+
 void serial_test_timer_stress(void)
 {
 	test_timer(timer_stress);
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index d6d5fefcd9b13..832b94b8e8dff 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
 
 #define CLOCK_MONOTONIC 1
 #define CLOCK_BOOTTIME 7
@@ -57,9 +58,12 @@ struct {
 	__type(key, int);
 	__type(value, struct elem);
 } abs_timer SEC(".maps"), soft_timer_pinned SEC(".maps"), abs_timer_pinned SEC(".maps"),
-	race_array SEC(".maps");
+	race_array SEC(".maps"), loop_array SEC(".maps");
 
 __u64 bss_data;
+__u64 loop_sum;
+int loop_rearm;		/* number of times loop_cb() re-arms itself */
+__u64 zero;
 __u64 abs_data;
 __u64 err;
 __u64 ok;
@@ -139,6 +143,50 @@ static int timer_cb1(void *map, int *key, struct bpf_timer *timer)
 	return 0;
 }
 
+/*
+ * Static and not inlined, so the loop is walked in a frame below the
+ * callback's rather than in a separately verified global subprog.
+ */
+static __noinline int sum_to(__u64 n)
+{
+	__u64 i, sum = 0;
+
+	for (i = zero; i < n && can_loop; i++)
+		sum += i;
+
+	return sum;
+}
+
+/* Re-arms itself and reaches a bounded loop through a call. */
+static int loop_cb(void *map, int *key, struct elem *val)
+{
+	loop_sum += sum_to(16);
+
+	if (loop_rearm > 0) {
+		loop_rearm--;
+		/* set_callback is what starts another async callback entry */
+		bpf_timer_set_callback(&val->t, loop_cb);
+		bpf_timer_start(&val->t, 0, 0);
+	}
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG2(test_loop_rearm, int, a)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&loop_array, &key);
+	if (!timer)
+		return 0;
+
+	bpf_timer_init(timer, &loop_array, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, loop_cb);
+	bpf_timer_start(timer, 0, 0);
+	return 0;
+}
+
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG2(test1, int, a)
 {
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/testing/selftests/bpf/progs/timer_failure.c
index 5a2e9dabf1c6c..0538269101cac 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -66,3 +66,32 @@ long BPF_PROG2(test_bad_ret, int, a)
 
 	return 0;
 }
+
+/*
+ * A real loop inside an async callback must still be rejected: both entries
+ * into the callback have the same async_entry_cnt, so telling entries apart
+ * does not apply here.
+ */
+static int timer_cb_infinite_loop(void *map, int *key, struct elem *val)
+{
+	for (;;) {}
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("infinite loop detected")
+long BPF_PROG2(test_infinite_loop_cb, int, a)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb_infinite_loop);
+		bpf_timer_start(timer, 1000, 0);
+	}
+
+	return 0;
+}
-- 
2.53.0-Meta

