Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983635;
	b=CuDGEdzQeppZa8ovwWRiWR2yxFmfQmoJgpkwGZ2z22QCgHdpZcpESojZ+KjqA7ifhZJj
	 tEUhc8dCuVxaNmXg2DEWo0kvse+Nm0W1Itxrxhq35enkJnClBJ3k+BykvsEDzKJ/5sOYj
	 Geefha+bOoRG/eYuo7j4mztBfxxtRbOyr3RKvchlFElPf8ixAOZjNmiflY8pYuVAn84op
	 Wl/gq75w2hvLcfTG3FF5h3s1Us0SjEuVOZvC1tOwCC4hpDXtJQrt9Bp3W5pYjeMS1HOkR
	 SkSMFYqggEd+XAAoCv02sP/TiGXNxHH0SCyr6T4Oajg5h/fbtsrwSDOv2Taz7I0opqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ou/DiD4lAWxTWCPntCX/b1Trz4whJL6qgW+/hm7jWM=;
	b=hbgDJFzPs0KMlAZoJny2EsKvyC50QvBzBpAhzidQH5Wqj0f9uJ7qYEfZtNMTAzOGewDj
	 b2s/nhficdl+TY0aWeaz9ZXy+Kzen2w2pM34A1iNq7Ddcv76i/1jznhpoLhyAEec3LYNx
	 BrTuSqgrOTikLxx2eDP3wU+V+m2kOjYMScwp4XO/VJ/XkC7odlP/f78aHxHvoMiZRlapD
	 AXrCp0z6HpY7wtVJkDCopZuQB3oSQ1jlCsyw6U99tis8SmgRA6SQWAmfnvfiLfjoIE/6s
	 afz/Kqt9uTGw9MlhOoegTSEdNvyJFYceqC67jIzGErZghqlgTpjElKhojhq/VkiWIwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AK+ZrOAS;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D3606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4D3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AK+ZrOAS
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so1062174a91.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983634; x=1793588434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ou/DiD4lAWxTWCPntCX/b1Trz4whJL6qgW+/hm7jWM=;
        b=AK+ZrOAS1/SFNgJ545AUoDAH37Tfi0KkLkzWsHO7wWRqagNoBeL2dc3dqzed/pmeoj
         qFwHNmHx9A3P7AI81ctzkRkGE6lVGChqFXqgVgEsCwCuF+63e5Oa4Uqk0vhsUI+YUwVP
         cS/RM1D7OsmU+HC5XyHve5CKTMvk7Mx610v+tfH8ne92mifmuK/okzrsMcukCEFeUvzh
         WuvPU7VjHqxVlJKkeHs+eFph5P2J85eyX0W5RZpUI+VVExtQsOdeGLJJ42WSIoobHE0R
         YbXpIue92RxNfk2zcz0eFw5QoRBCj6jJR69G+2N/TaHU6F4oaZAVtwwwRkx+ldrZHx5U
         HCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983634; x=1793588434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ou/DiD4lAWxTWCPntCX/b1Trz4whJL6qgW+/hm7jWM=;
        b=rN8vR4hyDtoLe9uZwBlR1VTTe2XN+Ptu88Z5Sr5zoVDacIWe1/rUXop3rZNi8o/foj
         2pxFlpiBJYmo+EdhssRkHBn1VhVAlO22sg4ycd+iP5vw3jAfjbAZYZwqQYn5PQ0nzgXh
         pPDmEz4ALJ40h8JFKR4uAgb0olWpGYhjqmHDydo9SlN44pMZNKyjEKWKo1pngNJ+qvF8
         J3vwO5CPZyUAsvn63S3LhXhgqUlhulXj+FfatpHgi0wY0hlKcFzNbZQF+8ufIYkdTYmB
         hB8TebW2anbw/oiJR261S+dmkUju/rm001IxvKlj/vttCRej/9QctGVia9BPSl2LeEGd
         0cCw==
X-Gm-Message-State: AFq9FYLrQuEvGIwpsDZHr2fYnnZ4GdeNDY9Zh2ISX/mmfUHILx7nEsuM
	01VIiosoTnP9g7eqNB1ZN46fDda5iuSkltGF1XNzmmZ+JQdKK8mXFwDqrXPHcw==
X-Gm-Gg: AYBFou1sdM6o0oMdv2aUVfRS5iTRN6pP5U8OlkHD7nHnOtRGoCludx99UMo77183c15
	8dNVi0NoSZkG66akvQpTzs/1RGO0j6T7YJb3RZAk1YOkzc3ahLMJ5y7h8MjpVuGepHb5Fmhr4Qm
	nNjaRB2Fspg0VtG6nhqslJETiRULWFPMy3FKJ3WNqUH1yb9VM05Xp0jaUg6FzMVQoRYKRXhKU2a
	CbTvInUIuTQiXgntxWN9hb0Bg4rN3ov2AvB9Ni9Et6q1Pu5JaLfRtoAHW5hN4c2zCQFpem9YQmB
	B+s6uUUpJa/qUx56RhfKoVhepkV4ZBGaQ/dNFEM9uj/h/jomlYLTtapUw+klW2KBhqTcC1ZddXQ
	6XC2MOgmt1AlyZSC1inzVbo5NlFrGRM+rpg6MXG23tp3nEXfUrupplofH1RXxoBgMgG73Jr7BQx
	Tdx5GZyvOuT3KOMB698Xr9HxrClq8Bp3oHdhtEJQwIcUYjFJVlj1W+9qPebcnfG5ekeGIe2AqKh
	uE2+pj4i8kxLck4cFxZaCaim76Tgrlek17jIX+aHRqj8VITOAaKw2Z8+oYgnzOgRtQIccYsCako
	NIabkxxECsSWFqvUW4Q5hTDnNUMuSorHSSIcWrqDygJiDKZpD0k0zXJT6fBS2a9S2q8YnOrQJNj
	kbKM0N9/6auWCEvgTN/HjsKdI
X-Received: by 2002:a17:90b:564d:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3adeafb0449mr4120090a91.35.1792983633857;
        Sun, 25 Oct 2026 20:00:33 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm4751667a91.0.2026.10.25.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 08/81] selftests/bpf: Test may_goto in a loop that calls a subprog that spins
Date: Mon, 26 Oct 2026 02:58:29 +0000
Message-ID: <20261026025943.404450-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

verifier_may_goto_1 gets the two cases of
"bpf: One time slice of may_goto for a run of a prog":
 - A loop calls a subprog that spins.
 - Three levels of loops. The subprogs make 60000 iterations in each call.
   Thus they never read the clock.

Without the fix the two tests lock up a cpu. The fix has no effect on s390,
riscv, loongarch and x86-64 without ORC. Enable the tests on x86-64 and
arm64 only.

may_goto_budget makes sure that an async callback is a new run. The prog
uses its full time slice and starts a timer. The timer callback calls a
subprog, and this subprog must loop.

cond_break5 expected that a subprog loops after the main prog used the full
time slice. The fix changes that. Call the subprog first.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/may_goto_budget.c          | 31 ++++++
 .../selftests/bpf/progs/may_goto_budget.c     | 73 ++++++++++++++
 .../bpf/progs/verifier_iterating_callbacks.c  |  8 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c | 97 +++++++++++++++++++
 4 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/may_goto_budget.c

diff --git a/tools/testing/selftests/bpf/prog_tests/may_goto_budget.c b/tools/testing/selftests/bpf/prog_tests/may_goto_budget.c
new file mode 100644
index 000000000000..c69af272644f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/may_goto_budget.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "may_goto_budget.skel.h"
+
+void test_may_goto_budget(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct may_goto_budget *skel;
+	int i;
+
+	skel = may_goto_budget__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.timer_after_timeout), &opts),
+		  "test_run");
+	ASSERT_EQ(opts.retval, 0, "retval");
+	ASSERT_GT(skel->bss->spun, 1, "spun");
+
+	for (i = 0; i < 100 && !skel->bss->cb_done; i++)
+		usleep(10000);
+	ASSERT_EQ(skel->bss->cb_done, 1, "cb_done");
+	ASSERT_EQ(skel->bss->cb_cnt, 1000, "cb_cnt");
+
+	may_goto_budget__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/may_goto_budget.c b/tools/testing/selftests/bpf/progs/may_goto_budget.c
new file mode 100644
index 000000000000..28960aeb5c05
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/may_goto_budget.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define CLOCK_MONOTONIC 1
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timers SEC(".maps");
+
+int zero, spun, cb_cnt, cb_done;
+
+static __noinline int spins(void)
+{
+	int cnt = zero;
+
+	for (;;) {
+		cond_break;
+		cnt++;
+	}
+	return cnt;
+}
+
+static __noinline int counts_to_1000(void)
+{
+	int i, cnt = zero;
+
+	for (i = zero; i < 1000; i++) {
+		cond_break;
+		cnt++;
+	}
+	return cnt;
+}
+
+static int timer_cb(void *map, int *key, struct elem *e)
+{
+	cb_cnt = counts_to_1000();
+	cb_done = 1;
+	return 0;
+}
+
+/*
+ * The time slice of this run is used up when the timer is started. The callback is another
+ * run on the same cpu, with a time slice of its own.
+ */
+SEC("tc")
+int timer_after_timeout(void *ctx)
+{
+	struct elem *e;
+	int key = 0;
+
+	e = bpf_map_lookup_elem(&timers, &key);
+	if (!e)
+		return 1;
+	if (bpf_timer_init(&e->t, &timers, CLOCK_MONOTONIC))
+		return 2;
+	if (bpf_timer_set_callback(&e->t, timer_cb))
+		return 3;
+	spun = spins();
+	if (bpf_timer_start(&e->t, 0, BPF_F_TIMER_CPU_PIN))
+		return 4;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 1fbcc5228306..a76bce7278e7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -553,13 +553,17 @@ int cond_break5(const void *ctx)
 {
 	int cnt1 = zero, cnt2;
 
+	/*
+	 * The subprog first. There is one time slice for a run of the prog: a subprog that
+	 * is called when it's used up doesn't loop at all.
+	 */
+	cnt2 = static_subprog();
+
 	for (;;) {
 		cond_break;
 		cnt1++;
 	}
 
-	cnt2 = static_subprog();
-
 	/* main and subprog have to loop a bit */
 	return cnt1 > 1 && cnt2 > 1 ? 1 : 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index faf9eec0a63e..6fe602c8c7f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -294,4 +294,101 @@ __naked void may_goto_subprog_func_first(void)
 	: __clobber_all);
 }
 
+/*
+ * There is one time slice for a run of the prog, not one for every call of a subprog.
+ * The subprog uses it up and returns. Its caller calls it again, BPF_MAX_TIMED_LOOPS times
+ * before it looks at the clock.
+ */
+__naked __noinline __used
+static unsigned long spins_on_may_goto(void)
+{
+	asm volatile (
+	"1:"
+		".8byte %[may_goto_1];"
+		"goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_insn(may_goto_1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0))
+	);
+}
+
+SEC("socket")
+__description("may_goto in a loop that calls a subprog that spins on may_goto")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loop_calls_subprog_with_may_goto(void)
+{
+	asm volatile (
+	"1:"
+		"call spins_on_may_goto;"
+		".8byte %[may_goto_1];"
+		"goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_insn(may_goto_1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0))
+		: __clobber_all
+	);
+}
+
+/*
+ * The count is shared too. These subprogs make 60000 iterations per call, fewer than
+ * BPF_MAX_TIMED_LOOPS: with a count of its own for every call none of them looks at the clock,
+ * and their caller does after 65535 * 60000 * 60000 iterations.
+ */
+__naked __noinline __used
+static unsigned long loops_60000(void)
+{
+	asm volatile (
+		"r1 = 60000;"
+	"1:"
+		".8byte %[may_goto_2];"
+		"r1 += -1;"
+		"if r1 != 0 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_insn(may_goto_2, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2, 0))
+	);
+}
+
+__naked __noinline __used
+static unsigned long calls_60000_times(void)
+{
+	asm volatile (
+		"r6 = 60000;"
+	"1:"
+		"call loops_60000;"
+		".8byte %[may_goto_2];"
+		"r6 += -1;"
+		"if r6 != 0 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_insn(may_goto_2, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2, 0))
+	);
+}
+
+SEC("socket")
+__description("may_goto in three levels of loops that end before they look at the clock")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void three_levels_of_short_loops(void)
+{
+	asm volatile (
+	"1:"
+		"call calls_60000_times;"
+		".8byte %[may_goto_1];"
+		"goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_insn(may_goto_1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0))
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

