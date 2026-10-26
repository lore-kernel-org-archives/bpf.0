Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984050;
	b=3BQby12f0JzscmnhKj0YbZL+zx5nmRR+EYmXp72ugXXefD6VKcF0kPMA2d6eWHvN2fFS
	 FpRIsAY2cX6e7ZXWvQ7wZRdsMPSY2miubOKqxWTaPdcpXQAlGImK2VVms00hZCyvYSsMm
	 UwyZKaBLPtw3SgUtJKPBRQmoTKaZ3Y/W81S19CxrtTyYNk6BqOH+s5Xc9rUk+f7u6deCi
	 kxGYm9OtezMUdVUPj2tkZqTXAqw26EKbt2VSRlC3IVTHSzhBr5EclVrqc2xt/cmap64BO
	 GpWtMqUeVZPq7BIOLH7lywQD5g4ldmN5cA6lfFNB7AWUQ6hMMSTb+E8XIr19CqcPMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qsC0DuFRnuraMHvV6Q7XicnMlWza0labjwOiOvC6Nqc=;
	b=nzbSCgO8TTjVRDQNRdWSOyVWFCMi5yHm/Y70hTwtn8/r2RcpYk0q6qVTrryhKc8+Red/
	 sPktKjvjYYFAhv2XIexSNCI64Na31mjYb6ox7JofWS28F1gUinbcuOdrapWQfMvPLKgaP
	 6SlxTeaE0cz0R9wBWQ2OWQ/u3kbT0ci+nD2ZA4jiGlCL2Naju+L0WBzPBiUaXHuTuOVaF
	 UYJOJSlAZ/p+Nzdk91tpVe8jUZqhOkkX7+jJvNNe+SJtSBQmLbAXPoKdaCK30cmc/sAAX
	 HPiDnJ20KCmI9XeAiMbhSvztFfksUE+zzDOChOxmcopo/0simJSOlgT8Yf/BREj6WoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P2ixWmRm;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BB606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P2ixWmRm
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae25008e2aso104627a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984050; x=1793588850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsC0DuFRnuraMHvV6Q7XicnMlWza0labjwOiOvC6Nqc=;
        b=P2ixWmRmJtKH05wiDNRXk2haAyvhDwrGu99iMfpYGBuxY8AFFqox6JU4BvE8HfKXZN
         AxFFtOjH2mgQsvJucHSJE39P2xlSBm3xyqZyAOx+/IZNlWNbUECl9WEzYpTWU9LOcyHF
         Dqkyn0aqC3T5pzWiG4WvgsgmZjx+nHzgyrPP8FMx/F2yFTRUAKdOfGWlKCsoOB9L7Xxf
         /hmEPZriTCXDALguUTAcJO2EdaQTBMczvVcbU2Wyw2TvamAAeYABgFjDNZoBE2wX65P2
         Kb+FnpgNr7u3A3ySLCdQdoZ+pli3kGvlBYez3VyTPButATEzPMIEZSUw/yEiA/WBJqKg
         QRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984050; x=1793588850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qsC0DuFRnuraMHvV6Q7XicnMlWza0labjwOiOvC6Nqc=;
        b=NfXsJ+Ss4WDYQAtXch6USqxm9w4ME6MCa37Cpsmn0t/aC1hfJR6WAs6crxraCcVbkA
         6bcQXmhLM8rVAH7wo5lxzEtwuSx2K8GO5ZyOUzIJeocHhz88dICsTinwTsGdWuFAw3t0
         mGfLzOx8pRv1RbOwXfQ66iQ2zC0PntXchQAaibXVD9oDigAFyGRlBD6oZLTQLWxHBigI
         YIlKecfQ/JpZLDsZMilnEMXthLzy6nUVrffMpMqF/0u/wwG/mQARUXnwHRJzdd3H2n3v
         IdwtzUP89mKZEVV3fngXKoXlKs2VmyuU468oawfgJGn3fwM88GNxkjqa+oyquVzsp4sW
         oNdQ==
X-Gm-Message-State: AFq9FYIhV1R4v8+Ab/ruxiF8/9cmq+8jmHrZdQ1j52JND2zmVb+xkQTY
	xyuDxCucbb74SuZx1rPPEYgo5nMnmOIRFvphQwtTuG4t76Xa1B7GlVfk3oK09g==
X-Gm-Gg: AYBFou0GTpX8vJJ94WXCG9rBnVR9mq7n32RD7lLVsPUlkvPyi4B5O/8UMU2XqxB/nWM
	Og0V68sCn6k5lC39iSUdkzRyh1Wk/vBw6Mdnd8nImX3g3TalCkUI1S4/PJgwPafDfWxsgKGb/Ai
	ejv7oD7QiAZyE7jfXVavJsrFeGs+OmvdaEWhxm9Wf+GOsBQDNsQb1eA6+BxIuge3yrTGlm4/vR6
	1VqJY2y93oCaJKdTDMG1sJ1wFJysrE2qfVDFUTJ3wOcQhC19Mt3rEJjlByVCaqP4phSg90Uwu9B
	dz0ly7ziFkrjXqBLSaN5hPg0nGTsDtoW8VbFyNHxzQTSmXzIJ/NxvbyI4QOX9gvlPhMxPDW7urc
	PnX2AzwqDCL7sAOqPXnn7i9kRWR+WtDrdXS5uLjQQt7pTrUQ5ZnRGEMQEQ5H6HdNOCeekFyOd0E
	CuFlw2+ZFQcMvvpZ3ODAZDkek+aJqLqijievLYqdoebnzmBa8k4JgvKYCAOTsY6WRcfLZgWUoy1
	UBjVVLSzokusTPd/WYLRhuXocd8/J4FBsYiOqrsELmMiYEJbXpEGfVKwOUHczMzV/d58No7uMMm
	8t+fgDbJaq15AYbZRY/AU1VTbiT9A9x/OnyuDpdyebv1xlg6zTYJ3rwpVPIPA8uchKqIEy4m+g7
	75yb+Tp40Ixqiv1s87CL23qx57Q==
X-Received: by 2002:a17:90b:2745:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3adeafaeb42mr4763764a91.60.1792984049380;
        Sun, 25 Oct 2026 20:07:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebad6306sm5194055a91.2.2026.10.25.20.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:29 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 79/81] selftests/bpf: Test 'unwound' in bpf_prog_info
Date: Mon, 26 Oct 2026 02:59:40 +0000
Message-ID: <20261026025943.404450-80-alexei.starovoitov@gmail.com>
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

The kernel sets the 'unwound' bit in bpf_prog_info when a run of the prog
does not end in the usual way. It prints the reason to stderr of the prog,
the BPF_STDERR stream. Run four progs one time each. The bit is 0 before
each run. 'call f; unwind_goto pad' continues at pad, the landing pad, when
f exits with unwind_exit.

  prog        what occurs                                retval  unwound
  ----------  -----------------------------------------  ------  -------
  caught      a landing pad catches unwind_exit              42        0
  not_caught  the main prog exits with unwind_exit            7        1
  spins       may_goto that the verifier adds times out       0        1
  too_deep    a subprog calls itself without end              3        1

stderr of caught is empty. The other progs print:

  not_caught
    ERROR: The program was unwound
  spins
    ERROR: Timeout detected for may_goto instruction
  too_deep
    ERROR: No room in the stack for a call of a recursive function

not_caught has 7 in r0 at unwind_exit. The call that reports the event must
not change r0.

The test also attaches to the recursive subprog. fentry loads. The verifier
rejects fexit with
"Only fentry can attach to calls_itself, which is recursive". The
trampoline of fexit stays on the stack at each level of the recursion, and
the check of the stack does not count it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwound.c        |  96 +++++++++++++++
 tools/testing/selftests/bpf/progs/unwound.c   | 113 ++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwound.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwound.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unwound.c b/tools/testing/selftests/bpf/prog_tests/unwound.c
new file mode 100644
index 000000000000..d5b4454ae011
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwound.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "unwound.skel.h"
+
+/* Run the prog once. What it returns, what bpf_prog_info says and what is in its stderr. */
+static void run(struct bpf_program *prog, int retval, bool unwound, const char *msg)
+{
+	char pkt[64] = {}, buf[4096] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = pkt, .data_size_in = sizeof(pkt), .repeat = 1);
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	int fd = bpf_program__fd(prog);
+
+	if (!test__start_subtest(bpf_program__name(prog)))
+		return;
+
+	ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &len), "info_before");
+	ASSERT_EQ((int)info.unwound, 0, "unwound_before");
+
+	ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), "test_run");
+	ASSERT_EQ(opts.retval, retval, "retval");
+
+	memset(&info, 0, sizeof(info));
+	len = sizeof(info);
+	ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &len), "info_after");
+	ASSERT_EQ((int)info.unwound, (int)unwound, "unwound_after");
+
+	bpf_prog_stream_read(fd, BPF_STREAM_STDERR, buf, sizeof(buf) - 1, NULL);
+	if (msg)
+		ASSERT_HAS_SUBSTR(buf, msg, "stderr");
+	else
+		ASSERT_STREQ(buf, "", "stderr");
+}
+
+/*
+ * The trampoline of fexit calls the target and stays on the stack at every level of a recursion.
+ * The check of the stack in the target knows nothing about it.
+ */
+static void attach(struct unwound *tgt, const char *name, const char *msg)
+{
+	static char log_buf[4096];
+	struct bpf_program *prog, *p;
+	struct unwound *skel;
+	int err;
+
+	if (!test__start_subtest(name))
+		return;
+	skel = unwound__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	prog = bpf_object__find_program_by_name(skel->obj, name);
+	if (!ASSERT_OK_PTR(prog, name))
+		goto out;
+	bpf_object__for_each_program(p, skel->obj)
+		bpf_program__set_autoload(p, p == prog);
+	log_buf[0] = 0;
+	bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
+	err = bpf_program__set_attach_target(prog, bpf_program__fd(tgt->progs.too_deep),
+					     "calls_itself");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+	err = unwound__load(skel);
+	if (msg) {
+		ASSERT_ERR(err, name);
+		ASSERT_HAS_SUBSTR(log_buf, msg, name);
+	} else {
+		ASSERT_OK(err, name);
+	}
+out:
+	unwound__destroy(skel);
+}
+
+void test_unwound(void)
+{
+	struct unwound *skel;
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	/* unwinding, per-cpu insns and timed may_goto in JIT */
+	test__skip();
+	return;
+#endif
+	skel = unwound__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	run(skel->progs.caught, 42, false, NULL);
+	run(skel->progs.not_caught, 7, true, "ERROR: The program was unwound");
+	run(skel->progs.spins, 0, true, "ERROR: Timeout detected for may_goto instruction");
+	run(skel->progs.too_deep, 3, true,
+	    "ERROR: No room in the stack for a call of a recursive function");
+
+	attach(skel, "on_entry", NULL);
+	attach(skel, "on_exit", "Only fentry can attach to calls_itself, which is recursive");
+
+	unwound__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/unwound.c b/tools/testing/selftests/bpf/progs/unwound.c
new file mode 100644
index 000000000000..66ec90908838
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwound.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+#define unwind_goto(off) ".8byte %[insn_unwind_goto_" #off "];"
+#define unwind_exit ".8byte %[insn_unwind_exit];"
+
+#define __imm_unwind_goto(off) \
+	__imm_insn(insn_unwind_goto_##off, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, off, 0))
+#define __imm_unwind_exit \
+	__imm_insn(insn_unwind_exit, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+
+unsigned long one = 1;
+
+__naked __noinline __used
+static unsigned long unwinds(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+SEC("socket")
+__naked void caught(void)
+{
+	asm volatile (
+		"call unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__naked void not_caught(void)
+{
+	asm volatile (
+		"call unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 7;"
+		unwind_exit
+		:
+		: __imm_unwind_goto(1),
+		  __imm_unwind_exit
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__naked void spins(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long calls_itself(void)
+{
+	asm volatile (
+		"r1 += 1;"
+		"call calls_itself;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("socket")
+__naked void too_deep(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"call calls_itself;"
+		"r0 = 3;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* the test attaches them to calls_itself() */
+SEC("?fentry")
+int on_entry(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fexit")
+int on_exit(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

