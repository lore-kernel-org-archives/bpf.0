Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470829;
	b=ldEdhw7SE0EUCsBNORodXpQXHkIfZQKVhjpYdaYleP21aIRiRDX4x6NCzL+Bp7p4n8KJ
	 L6iF6Q4u5nMy3LlXVxxCkgRovvLZJEhFEpiUffcKZve+68USbv3zHTP2xd71f8V6zlkUF
	 aORvgLhAkLA8k9FOj2eHknCv45JJH79CkKJp1FXhsc7oU2NbM8Vg2yawv60wwuK36qofw
	 CUMMW+NKy26j4bOGf0hzXNC2HuAknIdiLD9PVrJuM68ln/R0RgI9Rp2+9PSGcxZYzAeqV
	 3nmvgP/eTwOO2LrZ/D1IkV92NAN3bDkoCbaEHP060osJKe6DvxeeRCXICzVVNSQJRVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=INhBvwgYYMYOboSZED5Vixmqn8pNZhn016asQvwlzjE=;
	b=yTb1dg6Fls3ZU4P4i9qd3VJS6w9x6Pf+xEBdWxnq5orcKJKcqVujAhkTw+Isx/D0GklI
	 QaP7X+nQ2X4bUGfbsIOp2VRZssjD9vcIE0ave5Nmc0BDsfUd8gASBUGZ2MsTvHAWToDWZ
	 Nk25JIu52/Y1jiVkRmX4hb4GvHBRD6aZyyXhgxjxugXdSUFF2NrVqJlBMJC9HX05BYLA+
	 dUeE+UiCciGb5k4Q41wbDJca3V+ps5dfcghbi2UdZnas1h+QwZQiPZ6TDrh68toylceSP
	 c5Z2F7Lf/NbP1EP5H6ylOwGaB7dcfkyVap16q/PIaHZeD5uHreTaRCQvrjuDbJV1IIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bp56tnKS;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F1606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355F1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bp56tnKS
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9995ce866so20951345ad.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470827; x=1793075627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INhBvwgYYMYOboSZED5Vixmqn8pNZhn016asQvwlzjE=;
        b=bp56tnKSjBxrg5Seu2m8wE6XghNHoqC5DJv12pkpCZuWm5sqZ5cKRFGmBSrlkcZ5LL
         eQi8YX+ft90cKGFo4waQmxb4leXPx1M6+DPhd9Dn1PVjv1FfUHcLSoshGi3iFkLdCX0h
         fLSrPVeHuT4gLL/YQW0hgsCngLGcccQcGgAlRU8KzqbAUb00lsVzUQekjVxid+8hYlSw
         xRGnAkntR/DBu/ZirMCcDwzrvvTQbIZrCOAFmlRwoNTAAePrNMB/4zP64qCrXlDjRQBe
         lkVnH2JpFt4sFZNpq12HJMYLe4Xv2lnzxbz3mNF5GWMq2p19W8azju/tReM7Nz+IFQbD
         0VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470827; x=1793075627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=INhBvwgYYMYOboSZED5Vixmqn8pNZhn016asQvwlzjE=;
        b=IPN2yLdH/MibBYv5tPlSnARJu6zdJQhw6Fwk19y9ZGB9vydEat+VLfUAvznfbsJiQo
         IPiUiqUYTNzw6+W70rEOpxnqJPKfWUE4Gm3ji1KDPikn6xKwFQjBXtr/0ePJHBAF+bHu
         uk6bS5MMFfkms5bci7JFCRmWXn3IPLjTOOq59rLFILsu9iPXo1L56mZS9LXMaAKowCjP
         D8hUvr8jh75WcHfY/GVeD0LH7ARy3y0q15gAhVEXwrpXD8YeLqMyAFaC2BhcYt6zusLF
         ukb5QArRBnsceOcUnMZsQBc31Vfz7XAnlMpY4hF4cc60nboTnkDtcACz19bJlVofAZvR
         Jq2Q==
X-Gm-Message-State: AFq9FYI0iIVLKobn5ei9cSyqwYNeduGcHIm27g+ca9N8YGzyZR/CNO7p
	x0kaQfYRsFEaQKilRUUNEWIASIZ4/TWwRLZqiqR5luEGXqBD9cLi2Oc0UkBsTA==
X-Gm-Gg: AYBFou0nn/3Uix44EFI9LbUxAuZGIm06AmMl7ybfRgX1ZyziCJT3gFg2L+LXlIGIong
	CutoU+e2PZbGw6kSO6YZHOF9TsjrfXKFduP9Jcnnu5xjAl+IaNbfBTvAoxuJg25UEVVbP5MIXsx
	TEegqfUQqp7VCYpPcamLpYp1+Tuqzsklt7YVxWc2a4NcoOtfgppnBfIJgRvv3tIH4LCUw/pD2+E
	HlDu6IkMV0igW58p6IVWCgFkYjRdR4tdsfpCYZnciJ2ykwgkDcU7jhwmQ5hI8b0v6zqsEnfBCmo
	Y+Z653qdEq/HcHQYj9tpAf45S3mVH9HBeOWQkl2PYNS1chOKQKJAC7wvUEG6uB22foad75XRD7G
	IC7GZl380vLc6er2AH4THjc0wxLaKMdhPPGEDB2gg6M1M0VffHWvwbREfND/N4BTmVsP9qGo43T
	AH341WK66wcOa42Ygp+idPYut641jmpvrx8ebFUdx53hIqI2OlvPxx5zKfMxOa/CU3ZUrmdI+7E
	Gks6w3RSWKWeSYhOT15QBGNv0kdeNrfuWi3HZ6L7sq0jS4bRSJcX15p0D5qcyT/KVr9xGPIM/VY
	zarlcW0U/mTi+AS+NRchlp6qb1ZEOm8QrH1ijGeyheKtMA==
X-Received: by 2002:a17:903:15cf:b0:2e9:798b:221c with SMTP id d9443c01a7336-2e9a68e69a7mr84652805ad.17.1792470827140;
        Mon, 19 Oct 2026 21:33:47 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151a7c5csm8240395ad.74.2026.10.19.21.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 4/6] selftests/bpf: Add tests for unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 04:33:17 +0000
Message-ID: <20261020043319.3031996-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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

The tests spell the two insns out as raw insns, so they don't depend on
llvm version.

verifier_unwind:
- A static subprog, a global one and a callee of callx leave either way at
  run time, through one and two frames. The verifier follows a static
  subprog, so the tests derive the argument from skb->len or read it from
  a map.
- r0 of unwind_exit, r6-r9 and the stack are there in the pad. r1-r5
  are not readable.
- A pad is checked like any other code: it has to drop rcu_read_lock.
- How the callee left is a part of the verifier state: two states that
  differ only in that are not pruned.
- The pad of a call of a global subprog is always checked.
- A callee that never returns, where unwind_goto stays, and one that never
  unwinds, where it goes away with the pad.
- What follows unwind_goto runs speculatively: with CAP_BPF only there is
  nospec in front of an insn that isn't safe with r0 of unwind_exit.
- unwind_exit without unwind_goto after the call.
- unwind_goto that doesn't follow a call of a subprog or is a jump target.
- Reserved fields.
- A sync, an async and an exception callback cannot unwind. What a callback
  calls can.
- Tail call and ld_abs in a subprog that can unwind.
- unwind_exit of the main prog is exit.
- What x86-64 and arm64 JITs emit.
- Private stack. On x86-64 r9 has to be restored on the way to the pad.

The last one has to look at the return value of a prog that uses private
stack. raw_tp is such a prog. Its test_run doesn't take a packet, so let
test_loader run it like it runs syscall progs.

unwind_attach, with the caller run after every attach:
- fentry on a subprog that unwinds. fexit is refused.
- freplace of a subprog that unwinds by an extension that returns and by
  one that unwinds. The caller goes on after the call or in the pad.
- An extension that unwinds cannot replace a subprog that doesn't.

Every check that the series adds was removed in turn to see that a test
fails.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwind_attach.c  |  111 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_attach.c       |   43 +
 .../selftests/bpf/progs/verifier_unwind.c     | 1182 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |    3 +-
 5 files changed, 1340 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
new file mode 100644
index 000000000000..92eab5b77f62
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "verifier_unwind.skel.h"
+#include "unwind_attach.skel.h"
+
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
+static char log_buf[16 * 1024];
+
+static int run(int fd)
+{
+	char data[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = data,
+		.data_size_in = sizeof(data),
+		.repeat = 1,
+	);
+
+	ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), "test_run");
+	return opts.retval;
+}
+
+/*
+ * msg: why it cannot be loaded. Otherwise retval is what the target returns
+ * with the prog attached.
+ */
+static void attach(int tgt_fd, const char *func, const char *name, const char *msg, int retval)
+{
+	struct bpf_link *link = NULL;
+	struct unwind_attach *skel;
+	struct bpf_program *prog;
+	int err;
+
+	skel = unwind_attach__open();
+	if (!ASSERT_OK_PTR(skel, "unwind_attach__open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, name);
+	if (!ASSERT_OK_PTR(prog, name))
+		goto out;
+	bpf_program__set_autoload(prog, true);
+	log_buf[0] = 0;
+	bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
+	err = bpf_program__set_attach_target(prog, tgt_fd, func);
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = unwind_attach__load(skel);
+	if (msg) {
+		ASSERT_ERR(err, name);
+		ASSERT_HAS_SUBSTR(log_buf, msg, name);
+		goto out;
+	}
+	if (!ASSERT_OK(err, name))
+		goto out;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto out;
+	ASSERT_EQ(run(tgt_fd), retval, "retval");
+	if (prog == skel->progs.fentry_unwind)
+		ASSERT_EQ(skel->bss->fentry_cnt, 1, "fentry_cnt");
+out:
+	bpf_link__destroy(link);
+	unwind_attach__destroy(skel);
+}
+
+void test_unwind_attach(void)
+{
+	struct verifier_unwind *tgt;
+	struct bpf_program *prog;
+	int tgt_fd, plain_fd, err;
+
+	tgt = verifier_unwind__open();
+	if (!ASSERT_OK_PTR(tgt, "verifier_unwind__open"))
+		return;
+	bpf_object__for_each_program(prog, tgt->obj)
+		bpf_program__set_autoload(prog, prog == tgt->progs.calls_global_unwinds ||
+						prog == tgt->progs.calls_global_never_unwinds);
+	err = verifier_unwind__load(tgt);
+	if (err == -ENOTSUPP) {
+		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "verifier_unwind__load"))
+		goto out;
+	/*
+	 * It calls global_unwinds(), which unwinds with r0 = 5, and returns r0 + 10
+	 * from the pad.
+	 */
+	tgt_fd = bpf_program__fd(tgt->progs.calls_global_unwinds);
+	plain_fd = bpf_program__fd(tgt->progs.calls_global_never_unwinds);
+	ASSERT_EQ(run(tgt_fd), 15, "retval");
+
+	attach(tgt_fd, "global_unwinds", "fentry_unwind", NULL, 15);
+	/* unwind_exit would return to the trampoline */
+	attach(tgt_fd, "global_unwinds", "fexit_unwind",
+	       "Only fentry can attach to global_unwinds", 0);
+	/* An extension leaves either way, like what it replaced */
+	attach(tgt_fd, "global_unwinds", "freplace_returns", NULL, 9);
+	attach(tgt_fd, "global_unwinds", "freplace_unwinds", NULL, 13);
+	/* There is no unwind_goto after the call */
+	attach(plain_fd, "global_never_unwinds", "freplace_unwinds",
+	       "Extension program can unwind, while original does not", 0);
+	ASSERT_EQ(run(tgt_fd), 15, "retval");
+out:
+	verifier_unwind__destroy(tgt);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6df440d82675..04740ba37e91 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -130,6 +130,7 @@
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
+#include "verifier_unwind.skel.h"
 #include "verifier_unpriv_perf.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
@@ -320,6 +321,7 @@ void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
+void test_verifier_unwind(void)               { RUN(verifier_unwind); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
diff --git a/tools/testing/selftests/bpf/progs/unwind_attach.c b/tools/testing/selftests/bpf/progs/unwind_attach.c
new file mode 100644
index 000000000000..df73c26c1ff4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwind_attach.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/* The targets are global_unwinds() and global_never_unwinds() in verifier_unwind.c */
+
+int fentry_cnt;
+
+SEC("?fentry/global_unwinds")
+int BPF_PROG(fentry_unwind)
+{
+	fentry_cnt++;
+	return 0;
+}
+
+SEC("?fexit/global_unwinds")
+int BPF_PROG(fexit_unwind)
+{
+	return 0;
+}
+
+SEC("?freplace/global_unwinds")
+unsigned long freplace_returns(void)
+{
+	return 9;
+}
+
+SEC("?freplace/global_unwinds")
+__naked unsigned long freplace_unwinds(void)
+{
+	asm volatile (
+		"r0 = 3;"
+		".8byte %[unwind_exit];"
+		:
+		: __imm_insn(unwind_exit,
+			     BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+	);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
new file mode 100644
index 000000000000..dbe7b5d91acd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -0,0 +1,1182 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/*
+ * llvm lowers unwinding to two insns:
+ *   invoke foo unwind pad    call foo; unwind_goto pad
+ *   resume                   unwind_exit
+ * The tests spell them out as raw insns, so they don't depend on llvm version.
+ * The argument of unwind_goto() is the number of insns to skip.
+ */
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
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+extern void bpf_throw(__u64 cookie) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} prog_array SEC(".maps");
+
+struct timer_elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_elem);
+} timer_map SEC(".maps");
+
+/* The verifier doesn't know what is in there */
+unsigned long zero;
+unsigned long one = 1;
+
+/*
+ * The verifier follows a static subprog, so it knows which way it leaves when
+ * it knows the argument. To have both ways at run time the tests pass skb->len,
+ * which is 64, or skb->len - 64.
+ *
+ * r1 == 0: returns 7, otherwise unwinds with r0 = 5
+ */
+__naked __noinline __used
+static unsigned long may_unwind(void)
+{
+	asm volatile (
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/* owns nothing: its pad only carries on */
+__naked __noinline __used
+static unsigned long passes_on(void)
+{
+	asm volatile (
+		"call may_unwind;"
+		unwind_goto(2)
+		"r0 += 1;"
+		"exit;"
+		unwind_exit
+		:
+		: __imm_unwind_goto(2),
+		  __imm_unwind_exit
+	);
+}
+
+__naked __noinline __used
+static unsigned long always_unwinds(void)
+{
+	asm volatile (
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+__naked __noinline __used
+static unsigned long never_unwinds(void)
+{
+	asm volatile (
+		"r0 = 7;"
+		"exit;"
+	);
+}
+
+/* Both can unwind. This one returns 7. */
+__naked __noinline __used
+unsigned long global_returns(void)
+{
+	asm volatile (
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(zero),
+		  __imm_unwind_exit
+	);
+}
+
+/* This one unwinds with r0 = 5 */
+__naked __noinline __used
+unsigned long global_unwinds(void)
+{
+	asm volatile (
+		"r1 = %[one] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(one),
+		  __imm_unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind: the callee returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int callee_returns(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"call may_unwind;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the callee unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int callee_unwinds(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: return through two frames")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(8)
+__naked int two_frames_return(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"call passes_on;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* unwind_exit returns r0 like exit does */
+SEC("tc")
+__description("unwind: unwind through two frames, r0 reaches the pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(15)
+__naked int two_frames_unwind(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call passes_on;"
+		unwind_goto(1)
+		"exit;"
+		"r0 += 10;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: r6-r9 and the stack are intact in the pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(1111)
+__naked int pad_sees_callee_saved(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r6 = 1;"
+		"r7 = 10;"
+		"r8 = 100;"
+		"r9 = 400;"
+		"*(u64 *)(r10 - 8) = 600;"
+		"call passes_on;"
+		unwind_goto(2)
+		"r0 = 0;"
+		"exit;"
+		"r0 = r6;"
+		"r0 += r7;"
+		"r0 += r8;"
+		"r0 += r9;"
+		"r1 = *(u64 *)(r10 - 8);"
+		"r0 += r1;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: r1-r5 are not readable in the pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R3 !read_ok")
+__naked int pad_reads_r3(void)
+{
+	asm volatile (
+		"r3 = 0;"
+		"call always_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = r3;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_exit of the main prog is exit")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(3)
+__naked int main_prog_unwinds(void)
+{
+	asm volatile (
+		"r0 = 3;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_exit of the main prog needs r0")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R0 !read_ok")
+__naked int main_prog_unwinds_no_r0(void)
+{
+	asm volatile (
+		unwind_exit
+		:
+		: __imm_unwind_exit
+		: __clobber_all
+	);
+}
+
+/* What follows unwind_goto is dead code. unwind_exit still has to find the pad. */
+SEC("tc")
+__description("unwind: the callee never returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__xlated("0: call pc+3")
+__xlated("1: unwind_goto pc+0")
+__xlated("2: r0 = 42")
+__xlated("3: exit")
+__naked int callee_never_returns(void)
+{
+	asm volatile (
+		"call always_unwinds;"
+		unwind_goto(2)
+		"r0 = 1;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+/* The pad is dead code and goes away together with unwind_goto */
+SEC("tc")
+__description("unwind: the callee never unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__xlated("0: call pc+1")
+__xlated("1: exit")
+__xlated("2: r0 = 7")
+__xlated("3: exit")
+__naked int callee_never_unwinds(void)
+{
+	asm volatile (
+		"call never_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the pad drops what the frame owns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int pad_unlocks(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"call %[bpf_rcu_read_lock];"
+		"r1 = r6;"
+		"call may_unwind;"
+		unwind_goto(3)
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm_unwind_goto(3)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the pad is checked like any other code")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__naked int pad_does_not_unlock(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"call %[bpf_rcu_read_lock];"
+		"r1 = r6;"
+		"call may_unwind;"
+		unwind_goto(3)
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm_unwind_goto(3)
+		: __clobber_all
+	);
+}
+
+/* Leaves either way with the same registers */
+__naked __noinline __used
+static unsigned long same_regs(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/*
+ * After the call the two states differ only in the way the callee left.
+ * The second one must not be pruned, or nobody looks at the pad.
+ */
+SEC("tc")
+__description("unwind: the way the callee left is a part of the state")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R0 invalid mem access 'scalar'")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked int no_pruning_after_the_call(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call same_regs;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* Returns ctx, or unwinds with a number in r0 */
+__naked __noinline __used
+static unsigned long ctx_or_unwind(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + %[len]);"
+		"if r2 > 100 goto 1f;"
+		"r0 = r1;"
+		"exit;"
+	"1:"
+		"r0 = 0;"
+		unwind_exit
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_exit
+	);
+}
+
+/*
+ * unwind_exit changes its return address, so the cpu mispredicts the return and
+ * runs what follows unwind_goto with r0 of unwind_exit.
+ */
+SEC("socket")
+__description("unwind: what follows unwind_goto runs speculatively")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(50) /* 64 without the ethernet header */
+__success_unpriv __retval_unpriv(50)
+__caps_unpriv(CAP_BPF)
+#ifdef SPEC_V1
+__xlated_unpriv("unwind_goto pc+{{.*}}")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
+__xlated_unpriv("r0 = *(u32 *)(r0 +{{.*}})")
+#endif
+__naked int speculative_fall_through(void)
+{
+	asm volatile (
+		"call ctx_or_unwind;"
+		unwind_goto(2)
+		"r0 = *(u32 *)(r0 + %[len]);"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: a global subprog returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int calls_global_returns(void)
+{
+	asm volatile (
+		"call global_returns;"
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
+SEC("tc")
+__description("unwind: a global subprog unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(15)
+__naked int calls_global_unwinds(void)
+{
+	asm volatile (
+		"call global_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 += 10;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* The verifier doesn't look inside */
+SEC("tc")
+__description("unwind: the pad of a call of a global subprog is always checked")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R0 invalid mem access 'scalar'")
+__naked int global_pad_is_checked(void)
+{
+	asm volatile (
+		"call global_returns;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+unsigned long global_never_unwinds(void)
+{
+	asm volatile (
+		"r0 = 7;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: a global subprog that cannot unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int calls_global_never_unwinds(void)
+{
+	asm volatile (
+		"call global_never_unwinds;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: no unwind_goto after a call of a global subprog")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("no unwind_goto after the call of global_returns()")
+__naked int global_no_unwind_goto(void)
+{
+	asm volatile (
+		"call global_returns;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: no unwind_goto after a call of a static subprog")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_exit, but no unwind_goto after the call at insn 1")
+__naked int static_no_unwind_goto(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+/* The verifier sees that it doesn't get to unwind_exit */
+SEC("tc")
+__description("unwind: no unwind_goto is fine when the callee doesn't unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int static_does_not_get_there(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"call may_unwind;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: callx, the callee returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int callx_returns(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"r6 = %[may_unwind] ll;"
+		"callx r6;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_addr(may_unwind),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: callx, the callee unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int callx_unwinds(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r6 = %[may_unwind] ll;"
+		"callx r6;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_addr(may_unwind),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto after a plain insn")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 1 doesn't follow a call of a subprog")
+__naked int unwind_goto_after_mov(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		unwind_goto(0)
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto is the first insn")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 0 doesn't follow a call of a subprog")
+__naked int unwind_goto_first(void)
+{
+	asm volatile (
+		unwind_goto(0)
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto after a call of a helper")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 1 doesn't follow a call of a subprog")
+__naked int unwind_goto_after_helper(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		unwind_goto(0)
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto after a call of a kfunc")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 1 doesn't follow a call of a subprog")
+__naked int unwind_goto_after_kfunc(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		unwind_goto(0)
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: jump to unwind_goto")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("jump to unwind_goto at insn 3")
+__naked int jump_to_unwind_goto(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 0 goto 1f;"
+		"call never_unwinds;"
+	"1:"
+		unwind_goto(0)
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: reserved fields of unwind_goto")
+__failure __msg("invalid may_goto imm 1")
+__naked int unwind_goto_reserved(void)
+{
+	asm volatile (
+		"call never_unwinds;"
+		".8byte %[bad];"
+		"exit;"
+		:
+		: __imm_insn(bad, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, 0, 1))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unknown kind of jcond")
+__failure __msg("invalid may_goto imm 0")
+__naked int jcond_unknown(void)
+{
+	asm volatile (
+		"call never_unwinds;"
+		".8byte %[bad];"
+		"exit;"
+		:
+		: __imm_insn(bad, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO + 1, 0, 0))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unknown kind of exit")
+__failure __msg("BPF_EXIT uses reserved fields")
+__naked int exit_unknown(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		".8byte %[bad];"
+		:
+		: __imm_insn(bad, BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT + 1, 0, 0))
+		: __clobber_all
+	);
+}
+
+/* r1 is the index: unwinds in the second iteration */
+__naked __noinline __used
+static unsigned long cb_unwinds(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind: callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("callback cannot unwind")
+__naked int callback_unwinds(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind: async callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("callback cannot unwind")
+int async_callback_unwinds(void *ctx)
+{
+	struct timer_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&timer_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->t, &timer_map, 0);
+	bpf_timer_set_callback(&val->t, (void *)always_unwinds);
+	return 0;
+}
+
+/* Not naked: the argument has to have a name in BTF */
+__noinline int exception_cb_unwinds(__u64 cookie)
+{
+	if (cookie)
+		asm volatile ("r0 = 0;" unwind_exit :: __imm_unwind_exit : "r0");
+	return 0;
+}
+
+SEC("tc")
+__description("unwind: exception callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__attribute__((btf_decl_tag("exception_callback:exception_cb_unwinds")))
+__failure __msg("callback cannot unwind")
+int exception_callback_unwinds(struct __sk_buff *skb)
+{
+	bpf_throw(skb->len);
+	return 0;
+}
+
+/* What it calls can unwind as long as it doesn't let it out */
+__naked __noinline __used
+static unsigned long cb_catches(void)
+{
+	asm volatile (
+		"call may_unwind;"
+		unwind_goto(0)
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+	);
+}
+
+SEC("tc")
+__description("unwind: callback catches")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(3)
+__naked int callback_catches(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_catches];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_catches),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Both leave the subprog like exit does */
+__naked __noinline __used
+static unsigned long does_tail_call(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"r2 = %[prog_array] ll;"
+		"r3 = 0;"
+		"call %[bpf_tail_call];"
+		"r0 = 7;"
+		"if r6 == 64 goto 1f;"
+		unwind_exit
+	"1:"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm(bpf_tail_call),
+		  __imm_addr(prog_array),
+		  __imm_unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind: tail call in a subprog that can unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int tail_call_in_subprog(void)
+{
+	asm volatile (
+		"call does_tail_call;"
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
+/* The packet is shorter than that: ld_abs leaves the subprog with r0 = 0 */
+__naked __noinline __used
+static unsigned long does_ld_abs(void)
+{
+	asm volatile (
+		"r6 = r1;"
+		"r0 = *(u8 *)skb[1000];"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind: ld_abs in a subprog that can unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int ld_abs_in_subprog(void)
+{
+	asm volatile (
+		"call does_ld_abs;"
+		unwind_goto(2)
+		"r0 += 7;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+/*
+ * JITs don't emit anything for unwind_goto. It's an extable entry, where
+ * unwind_exit looks its return address up.
+ */
+SEC("tc")
+__description("unwind: jit")
+__success __retval(42)
+__load_if_JITed()
+__arch_x86_64
+__jited("	callq	0x{{.*}}")
+__jited("	movl	$0x7, %eax")
+__jited("...")
+__jited("	movl	$0x5, %eax")
+__jited("	pushq	%rax")
+__jited("	pushq	%rsi")
+__jited("	movq	0x8(%rbp), %rdi")
+__jited("...") /* call depth accounting */
+__jited("	callq	0x{{.*}}")
+__jited("	movq	%rax, 0x8(%rbp)")
+__jited("	popq	%rsi")
+__jited("	popq	%rax")
+__arch_arm64
+__jited("	bl	{{.*}}")
+__jited("	mov	x8, x0")
+__jited("	mov	x8, #0x7")
+__jited("...")
+__jited("	mov	x8, #0x5")
+__jited("	stp	x8, x1, [sp, #-0x10]!")
+__jited("	ldr	x17, [x29, #0x8]")
+__jited("...")
+__jited("	str	x17, [x29, #0x8]")
+__jited("	ldp	x8, x1, [sp], #0x10")
+__naked int jit(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		unwind_goto(2)
+		"r0 = 7;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+/* r1 == 0: returns 7, otherwise unwinds with r0 = 5 */
+__naked __noinline __used
+static unsigned long may_unwind_big_stack(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 200) = r1;"
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/*
+ * x86-64 keeps the pointer to the private stack in r9 and saves it around a call.
+ * The value that is read back in the pad is there only when r9 is restored.
+ */
+SEC("raw_tp")
+__description("unwind: private stack, the callee unwinds")
+__success __retval(47)
+__load_if_JITed()
+__arch_x86_64
+__jited("	pushq	%r9")
+__jited("...") /* call depth accounting */
+__jited("	callq	0x{{.*}}")
+__jited("	popq	%r9")
+__jited("	jmp	L{{.*}}")
+__jited("	popq	%r9")
+__jited("	jmp	L{{.*}}")
+__arch_arm64
+__naked int private_stack_unwinds(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 200) = 42;"
+		"r1 = %[one] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"call may_unwind_big_stack;"
+		unwind_goto(1)
+		"exit;"
+		"r1 = *(u64 *)(r10 - 200);"
+		"r0 += r1;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("raw_tp")
+__description("unwind: private stack, the callee returns")
+__success __retval(49)
+__load_if_JITed()
+__arch_x86_64
+__arch_arm64
+__naked int private_stack_returns(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 200) = 42;"
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"call may_unwind_big_stack;"
+		unwind_goto(3)
+		"r1 = *(u64 *)(r10 - 200);"
+		"r0 += r1;"
+		"exit;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm_unwind_goto(3)
+		: __clobber_all
+	);
+}
+
+/*
+ * BTF FUNC records are not generated for kfuncs referenced
+ * from inline assembly. These records are necessary for
+ * libbpf to link the program. The function below is a hack
+ * to ensure that BTF FUNC records are generated.
+ */
+void __kfunc_btf_root(void)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 18d47e925400..824e5912ebcb 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1546,7 +1546,8 @@ void run_subtest(struct test_loader *tester,
 		}
 
 		err = do_prog_test_run(bpf_program__fd(tprog), &retval,
-				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false,
+				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ||
+				       bpf_program__type(tprog) == BPF_PROG_TYPE_RAW_TRACEPOINT,
 				       spec->linear_sz);
 		if (!err && retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
-- 
2.55.0

