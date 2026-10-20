Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520033;
	b=35peS2rbeMFBD4sLDOYhAB9DTVuY/dYpjzlHeJbPannf7lmDoQ6cFvLoi8pIcQjHmdlU
	 PaHMzy74SZNZoi0fWEhLoOFiCQUJCUXCCecPvEIaJMaMAP75emBXHFLZuTNf+PaoxnfgL
	 ZySu0WsDE09367yhJgcjDwo1z2S7lujOwr+DSIktv5G8mfYZEgJKJMVlICMgTzofXKkFd
	 aPm8dm3r7e/88fELX8u1jG9+FZ8C6KNK+zcKe1vIOKNQCm1CxG4lDKK7lxACwDxHRqZxp
	 xY01u6TeFLq86b5Pyq0o6xhYOGBFzUf1H34w5due4UAHZknHcGiwdc+tbiveJE0PreQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E5GRdTjgm3r6s5bRsioAyxUDf8oohvPm1EeE57A2JKM=;
	b=LGfUDkN3asK3WUPHZTVce2wNgaiYJU6FjMbQ5gP61fTUYB9h9psaPuaMyXxLYJAvpJbj
	 l52hWDkETWsGztlzcHtHljvBkoiDPgPdrnaGCvNvfBF+WIrac4oKoWI2jVy3CnrDVXikq
	 l9xvI7vw6J7gsy0X2wMpQXhSquYeiAfYdb3s6CYsEf1lP1FoDVaPCb8zAj721x5N7G9Xg
	 YSpmz/QfFx9aHW+kSAQ+USmHk76T9xlv30yjS46210VHaKvkAyex/NklBQ4P9L5+w9827
	 0sISv9dC/ikndU74wuFmKUVBtDYu+9rxVLtuNNUeFMa/BSRXHK6qS8EJ7kYstwB2GHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gT7nmDK3;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA397606A322
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA397606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gT7nmDK3
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso1357146a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520031; x=1793124831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5GRdTjgm3r6s5bRsioAyxUDf8oohvPm1EeE57A2JKM=;
        b=gT7nmDK3/6+TYZ5xzS78lqodk0oGh9A1ff0Ee9FqGmrrqPHGiRSTtj01m+AwSJFFNr
         InMmTK1j4tDQVdOx/aGXGIhYqxlEmw5bAIXS/9D443Rd5iHb7nC0I0KPxjUhI751X6+L
         b3VEUkPxUaD67ZwCmybvFULi7MtPpnobsy9/V9bAsjmgZYFihZO8rXDEpnl/KFnZt/m6
         Cp0HZPE+aUzn8w8KoqrLubZApiMMEO0OiRNXcZJsxM6Q4s1UNIB/m78VUyE4cdyDABSc
         a0xhwT+XiDJwsHx84HzRtF493dxUNpMEK1JTxe5Qe0NFpafD9KfAqXg58U+s1lRnQbH0
         K7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520031; x=1793124831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5GRdTjgm3r6s5bRsioAyxUDf8oohvPm1EeE57A2JKM=;
        b=2NvNUm9zJvVdAyiPbRJcNigzArRPJ7j5mjrhFU2hZjZT84sGl31h4rEPHo+ORenjnD
         6Y4HEmCapeOOKg4rK30cgaK5Ud/vSZAHqEKnnQjE6NkQShDzMnmhNtsCuXl0Xug7bZEs
         0ImZJ/JaeCSJait8RrJxEP7VIjWzLQnYQlkGG7Lf7+nwYQDZObzY591jMKRK5H3DNR5P
         EUML2w/luHswFZN0jHFbT8aAxLPddKy9Of63k64r61RByC8/xHNlOE1o1eWwKVYwb9f6
         koUb7WNybXdBJ4cwidq+gcN5SyFVBLBXnQxVqM6J9fLHnWhNV7fsm3pXkgQPFhC1Wv6E
         QGZw==
X-Gm-Message-State: AFq9FYLTTztoSWpLInZ65lQis4wlZeomLt7W48K9gveZzPyQCnxlL+vg
	ZhVUoL/L07hqaIgkr1K19ArwNIjbnhjqyiWMuoQvdWcGOxwgdrXaCdq5daICdw==
X-Gm-Gg: AYBFou1w9QRiKTCBQYmnwDf3EMrPr8LVfYt4fCLcK+rzohZ91ZnRBefaVC20zvOKlbI
	HKjW5LVWBbVQvOrgeDDdMdciXD19X+KVxs6qz8WyGjqaMlTAUQHBPzXyxx1zLneoFb/bJ4Hmwsj
	u8LNWBCcWyG/RoTPevWsHSuYO8cNHFw+yGlkWSbPIYoTNhu9DNc6tp5WYxPwDzWhz0P1CQOi/yw
	bdOlCmPy1Xf26jAR0sljVtRGq4KgVQE6i9otDTpc42t5hX+E3GWfO4lOZV3555AnX4XWgIsOKBE
	RXrQ+V9AANsWdJwHZzo5Db2Uic4SKRv3JnrySc9Gl55WBICpMMFmwxMu/Kw5v5tzueDZDsm/AiA
	W0haB2Dz3arvzSxwz0ZHiK1O1S8tU8n28fWQQaPBz+RZfxuk0ZDcADEcQ/e3pAsRI12t7iYjC5R
	h08ZZ2ohl+3TQEuNqKckxlxBcANzIF2d60/dL73Acbv6Iz2qEQ06QdcuFLjPJg/uvQWl/3ad6Lc
	rhMEpBhzLhADhThjMG7mot7J3njpVNaZ4OnWNGEpUVw8ybDznCcxqh2yfzqmU1lkWHzTiwvZX1a
	iJHgmwa+tS/JE0NFWkTy4g5rvwxq9VJsGV8BuHgQi2I=
X-Received: by 2002:a17:90b:580d:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3acee2939c2mr9753862a91.3.1792520030941;
        Tue, 20 Oct 2026 11:13:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a872499csm47585a12.26.2026.10.20.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:13:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 bpf-next 4/6] selftests/bpf: Add tests for unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 18:13:18 +0000
Message-ID: <20261020181320.1284798-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
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
- A callee that never returns, where unwind_goto stays and 'goto pc-1'
  follows it, and one that never unwinds, where it goes away with the pad.
- What follows unwind_goto runs speculatively: with CAP_BPF only there is
  nospec in front of an insn that isn't safe with r0 of unwind_exit.
- unwind_exit without unwind_goto after the call.
- unwind_goto that doesn't follow a call of a subprog or is a jump target.
- Reserved fields.
- A sync callback cannot unwind. What it calls can.
- unwind_exit of an async and of an exception callback is exit.
- Tail call and ld_abs in a subprog that can unwind.
- unwind_exit of the main prog is exit.
- What x86-64 and arm64 JITs emit. With KASAN x86-64 JIT wraps a load in
  pushes, a call and pops, so the patterns start after the loads.
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
 .../selftests/bpf/prog_tests/unwind_attach.c  |  112 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_attach.c       |   43 +
 .../selftests/bpf/progs/verifier_unwind.c     | 1211 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |    3 +-
 5 files changed, 1370 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
new file mode 100644
index 000000000000..ada8b3273ccb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "verifier_unwind.skel.h"
+#include "unwind_attach.skel.h"
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
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
+		test__skip();
+		return;
+	}
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
index 000000000000..0a75cb8af67f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -0,0 +1,1211 @@
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
+/*
+ * What follows unwind_goto is dead code. unwind_exit still has to find the pad,
+ * and the cpu predicts that the callee returns: there is a trap for that.
+ */
+SEC("tc")
+__description("unwind: the callee never returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__xlated("0: call pc+4")
+__xlated("1: unwind_goto pc+1")
+__xlated("2: goto pc-1")
+__xlated("3: r0 = 42")
+__xlated("4: exit")
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
+__naked __noinline __used
+static unsigned long async_cb_unwinds(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/* The kernel calls it. It's the top frame like the main prog: unwind_exit is exit. */
+SEC("tc")
+__description("unwind: async callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(0)
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
+	bpf_timer_set_callback(&val->t, (void *)async_cb_unwinds);
+	bpf_timer_start(&val->t, 0, 0);
+	return 0;
+}
+
+/* Not naked: the argument has to have a name in BTF */
+__noinline int exception_cb_unwinds(__u64 cookie)
+{
+	if (cookie)
+		asm volatile ("r0 = 7;" unwind_exit :: __imm_unwind_exit : "r0");
+	return 0;
+}
+
+SEC("tc")
+__description("unwind: exception callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__attribute__((btf_decl_tag("exception_callback:exception_cb_unwinds")))
+__success __retval(7)
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
+ * With KASAN x86-64 JIT wraps a load in pushes, a call and pops. 'r2 = 0x1234'
+ * is where the patterns start, so that they don't take that call for the one
+ * of the subprog.
+ */
+SEC("tc")
+__description("unwind: jit")
+__success __retval(42)
+__load_if_JITed()
+__arch_x86_64
+__jited("	movl	$0x1234, %esi")
+__jited("...") /* call depth accounting */
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
+__jited("	mov	x1, #0x1234")
+__jited("	bl	{{.*}}")
+__jited("	mov	x8, x0")
+__jited("	mov	x8, #0x7")
+__jited("...")
+__jited("	mov	x8, #0x5")
+__jited("	stp	x8, x1, [sp, #-0x10]!")
+__jited("	ldr	x0, [x29, #0x8]")
+__jited("...")
+__jited("	mov	x10, x0")
+__jited("	ldp	x8, x1, [sp], #0x10")
+__jited("...")
+__jited("	add	x30, x30, x10")
+__jited("	ret")
+__naked int jit(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r2 = 0x1234;"
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
+__jited("	movl	$0x1234, %esi") /* past the load, see above */
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
+		"r2 = 0x1234;"
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

