Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148307;
	b=D8Bs0LuV68ymdKRAUv/ftgvy/ubDEgVSjYYGz5oSUuP/NQtf8VkTdXD8AYz+TM1RRGwP
	 B7WsSbixtuZxl4dEyOO7kawSvSZqQ/i4eD1sKonyRpMIhQSpDXewaGASskyH9yHLLh0r9
	 x7Ufpwi3oQ4uAep6QYnZupjtPNM+9JjAfBscpGE8a5xhY38werD7pjfRr8K0tXyp2PZhy
	 T/ZbDp9wNdw6a5fO6RTVSMaAStkJfQ++fE4xBoRB02Zi+U5NZPNIkteCsWjxM+L58Kjd/
	 mtEQiGQrfahTBWaAooddQ86uPjlaOU50cWwlk9D0FLfsaV+/50RhUvOOPS20/nDUxXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Qag8Cg/XKK6bHPjOrJODrcRKXYPMsRlQr3bCAVMAuPs=;
	b=MJ6zZ225vIbjLqjYXBiMb7UOVVZpe7WgTm0zX4v6S6wwgwsKb3PeXRK6mxQyghb5hLGk
	 6/8gE+QUUAHL1k5/hsRqLA5izWgLN3QnFacq+JX+DRZbDhm/vwSf5um7mS1HY18r+lEla
	 y3Lko1VwDI8DYYY9uJrkzfotoqcNyUP69gXuiuAqi8UrjGSWvJhdGiqbkTUFJujdJJuLA
	 pjMWw7fFWh2C16kmm2+/Di1ppHw7MT+LhpCmqqaqKxSERxr/6KciZgQuVZdDarmb3ZubD
	 Z36EC8ajuPdYforFWjnEPo+l0+LYLBI+tsttifO4UeVqpLbVyuD6cGMCMg3VvczrgKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ih+vNXMk;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CF606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ih+vNXMk
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a35e178418so1824565e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148305; x=1793753105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qag8Cg/XKK6bHPjOrJODrcRKXYPMsRlQr3bCAVMAuPs=;
        b=ih+vNXMkz6k9h20lAzYmLiT9kWxx3vLEMPwgo5aS3+5La2JFDtMlkhDENAMaQC/oqP
         SbcmkSEL5Ojbw1aUlSHsHTsvclC8IG5rkknWScC6D65SGYe2RVSThWhteccu0/j38CSC
         YLDelwxLrVjZbexmtkDwcvv5q58mnU1s2Lcg4ztyEOGdmhqBhoXqJ8auEDAYwMJCnNIM
         eyAuusDmSII5Ex7v35DT6f8E3qb/x1STS/yFEUSyFo11T8nJIJuNYPdUsy6hYy/CUib2
         JFfnPQNmaUesoRiWaCIfz92C1L8c4+63/0PsaCFY1/jYpYQ/4RMDWm5kGwu0gnDR4J0D
         nv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148305; x=1793753105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qag8Cg/XKK6bHPjOrJODrcRKXYPMsRlQr3bCAVMAuPs=;
        b=KvEqw1mkzM8P0dUmAV/ww4UMJKhwzI2R/nczt+X3g/g1abIR/PTCP095uNgR2V3Kmo
         KITGeeKPPOB0igI1DI8hjLTd7ZgQxakoDkvBGZ4UV6LQMUOisNtsa8G8ktU37uf9bTJ2
         OUr2mfqyP8fTvs+ZevZUyA0mE4aDODrXd0hPpf2BVKNC5KzmiW+nC+1ihUW95/3nK9PG
         2Z5vfGhoSgc8Tkdshf8L4g5+E5DahyAHTRhu7Rnk9rx8gt08JderidEs/GNsgwQhkIHO
         VLPunqI0WScJJe8EuAaIs8n0TEuQDJ5ko+FddhPKI50wQomt/d/Mgcl2RUYaf0dyfLmH
         l6GQ==
X-Gm-Message-State: AFq9FYKwukYI4smJPE1PObnWx7AATexI6sC5KD+9dsM4l3PvB9bUwyZv
	7FdFOeAqjvoKyUwIY5tIScw5ZGVs1dt2N38hS4+v6W7JnOJh3n1hw+SgpYLGOAEm
X-Gm-Gg: AYBFou2S4S32eIBlQsbJxdtSvLf9YaV80mNFxTBeXVheNw1e4sBs8IzQk5SRvOjCTxW
	hO2xv6cFDJ1BwJHzS68xTXZ2ECXJbT14EmSC1z1AJYJqSm5oxGFlyJsF0/rKOoByZXCyM6iLKG/
	imYUulXcJ9rW9x//djqKUXEI1HqL2XO6g7QSuVpZA0/pcW3RQjmckbKq0DqCeRTOgHr/PzAhgHE
	2Yt20UU0BkZ50ANpmxQ6dqemlCL86q1MG5qJJA+xeu6sG6MTcUzc5A7JWaXSVUfpgukeNhtrNT0
	0dDuZwXrb+YdfyH3H1FNQSx+2bJg5JpcegdIwG2zHDhoL532clG58CP9HK6TUPNFB4iYINSK0d3
	cfWLFDs6YK1LRjSHDXLxxSgO9uhUD1yJHXSS+Vs25AdDGgPWxVtsOiFFzrJwtL13dZzN8ZOi8qF
	FN3usAFOfXz8scKdov7KkRhjRJP8eh9tJo8N6DcIgjwpC3XZ2kwB4aLvnGfWG7TLF92L/WjtF4/
	d+MlFE507oVoCS5emwqKjh5QMmCIcJ+uIAQsvdgEpQpmKMLcACgsm2NOHCeYM3E/x4Vnz9SHkB2
	XBzK19/XLsdNkqlTt/ch0YpVlbular3y8kf2sjAWr2UJoINUE7y8VVfftq6jnAJZ1x9WdaWr6hy
	dI4OAEwkq4mtgqmGj5m1tsRNB8kI3jFnqLFiDL0td7ihhnxX7RDHyxtwwNr29/86n1EAc
X-Received: by 2002:a05:600c:1d1a:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4a966c4111amr12092675e9.17.1793148305191;
        Tue, 27 Oct 2026 17:45:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97cebfa16sm10650425e9.13.2026.10.27.17.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:45:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 10/11] selftests/bpf: Test callbacks that unwind
Date: Wed, 28 Oct 2026 01:44:47 +0100
Message-ID: <2fb53df72300b10ba5f5aff123c331b80a7c4be5.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21895; i=memxor@gmail.com; h=from:subject:message-id; bh=ZKwHhkOjho5h6Tsfu6YizKenrgysrsEwi5Tk39XC+eI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh4wvTtWd3Xz4p4Kav9v6/e+wXuVdXzeY9VxadGPx6P 3v2gdkfO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRr8oM//T8FhdftnHdd+KC rcDVorkHw/bdDH75qP7ChWPyGbfsDsgxMtz2zu9xnVjVZVh+40xh7EJLs8duG6bGHn9tHvVRdk/ sSyYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

One file for the callbacks of bpf_loop(), bpf_for_each_map_elem() over
an array, a hash and an rhash the prog fills first, bpf_find_vma() on
the stack of the current task, and the comparator of bpf_rbtree_add(),
in both spellings, meeting the one node that is in the tree. Each with
a callback that unwinds on its first run, where the pad after the call
returns the number of runs plus what the helper left in r0, which is
what the callback unwound with, plus 41. One callback of bpf_loop()
unwinds on its third run, one unwinds through its own pad, one call
sees a callback that unwinds on one path and one that returns on the
other, and the pad after a callback that returns is never taken.
Refused is the call without unwind_goto after it. A loop of no rounds
never runs its callback: it needs no unwind_goto, and the inlined loop
leaves the insn after the call alone. The normal path of the helpers is
what their own tests run.

The file includes vmlinux.h for the offsets the find_vma tests need,
which rules out BPF_RAW_INSN(), so unwind_goto and unwind_exit are raw
words. The rbtree test is in C with a naked subprog around the call of
the kfunc, since the unwind_goto has to follow the call.

The callback of bpf_user_ringbuf_drain() needs samples from user space,
so its test is a prog_tests one. The callback unwinds on the sample it
is given, with r0 = 5, and the pad after the call returns the number of
runs plus 5 plus 41. The drain before any sample returns 0, the one
after the unwind finds the sample consumed and the busy bit dropped,
and the one after the next sample unwinds again.

The existing "callback unwinds" test used bpf_loop() to get "callback
cannot unwind". bpf_loop() has a pad now, so what it lacks is the
unwind_goto after the call, and that is what the test expects.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/unwind_drain.c   |  71 +++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/unwind_drain.c        |  69 +++
 .../selftests/bpf/progs/verifier_unwind.c     |   3 +-
 .../selftests/bpf/progs/verifier_unwind_cb.c  | 569 ++++++++++++++++++
 5 files changed, 713 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_drain.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_drain.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind_cb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_drain.c b/tools/testing/selftests/bpf/prog_tests/unwind_drain.c
new file mode 100644
index 000000000000..54b9cfbef440
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_drain.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "unwind_drain.skel.h"
+
+static int run(struct bpf_program *prog)
+{
+	char data[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = data,
+		.data_size_in = sizeof(data),
+		.repeat = 1,
+	);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "test_run"))
+		return -1;
+	return opts.retval;
+}
+
+static int submit(struct user_ring_buffer *rb)
+{
+	void *sample = user_ring_buffer__reserve(rb, 8);
+
+	if (!ASSERT_OK_PTR(sample, "reserve"))
+		return -1;
+	user_ring_buffer__submit(rb, sample);
+	return 0;
+}
+
+/*
+ * The callback unwinds on the sample it is given, with r0 = 5. The pad after
+ * the call of bpf_user_ringbuf_drain() returns the number of runs plus 5 plus
+ * 41. The sample is consumed and the busy bit dropped on the way there: the
+ * next drain finds an empty ring buffer, and the one after that another
+ * sample.
+ */
+void test_unwind_drain(void)
+{
+	struct user_ring_buffer *rb = NULL;
+	struct unwind_drain *skel;
+	int err;
+
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
+		test__skip();
+		return;
+	}
+	skel = unwind_drain__open_and_load();
+	err = libbpf_get_error(skel);
+	if (err == -ENOTSUPP) {
+		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
+		test__skip();
+		return;
+	}
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	rb = user_ring_buffer__new(bpf_map__fd(skel->maps.user_ringbuf), NULL);
+	if (!ASSERT_OK_PTR(rb, "user_ring_buffer__new"))
+		goto out;
+
+	ASSERT_EQ(run(skel->progs.drain), 0, "empty");
+	if (submit(rb))
+		goto out;
+	ASSERT_EQ(run(skel->progs.drain), 47, "unwinds");
+	ASSERT_EQ(run(skel->progs.drain), 0, "consumed");
+	if (submit(rb))
+		goto out;
+	ASSERT_EQ(run(skel->progs.drain), 48, "unwinds again");
+out:
+	user_ring_buffer__free(rb);
+	unwind_drain__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 04740ba37e91..10beba6bed20 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -131,6 +131,7 @@
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
 #include "verifier_unwind.skel.h"
+#include "verifier_unwind_cb.skel.h"
 #include "verifier_unpriv_perf.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
@@ -322,6 +323,7 @@ void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
 void test_verifier_unwind(void)               { RUN(verifier_unwind); }
+void test_verifier_unwind_cb(void)            { RUN(verifier_unwind_cb); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
diff --git a/tools/testing/selftests/bpf/progs/unwind_drain.c b/tools/testing/selftests/bpf/progs/unwind_drain.c
new file mode 100644
index 000000000000..1277d1a3e82e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwind_drain.c
@@ -0,0 +1,69 @@
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
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 4096);
+} user_ringbuf SEC(".maps");
+
+/* How many times the callback ran */
+__u64 runs;
+
+/* Unwinds on every sample */
+__naked __noinline __used
+static unsigned long cb_unwinds(void)
+{
+	asm volatile (
+		"r1 = %[runs] ll;"
+		"r2 = *(u64 *)(r1 + 0);"
+		"r2 += 1;"
+		"*(u64 *)(r1 + 0) = r2;"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(runs),
+		  __imm_unwind_exit
+	);
+}
+
+/* The pad returns the number of runs plus what the helper left in r0, 5, plus 41 */
+SEC("tc")
+__naked int drain(void)
+{
+	asm volatile (
+		"r1 = %[user_ringbuf] ll;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_user_ringbuf_drain];"
+		unwind_goto(1)
+		"exit;"
+		"r1 = %[runs] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r0 += r1;"
+		"r0 += 41;"
+		"exit;"
+		:
+		: __imm_addr(user_ringbuf),
+		  __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_user_ringbuf_drain),
+		  __imm_unwind_goto(1)
+		: __clobber_common
+	);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
index 5a21345c34d4..3de145a2d065 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unwind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -896,12 +896,13 @@ static unsigned long cb_unwinds(void)
 	);
 }
 
+/* bpf_loop() has a pad for it, so what's missing is the one after the call */
 SEC("tc")
 __description("unwind: callback unwinds")
 __arch_x86_64
 __arch_arm64
 __load_if_JITed()
-__failure __msg("callback cannot unwind")
+__failure __msg("no unwind_goto after the call of bpf_loop()")
 __naked int callback_unwinds(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c b/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c
new file mode 100644
index 000000000000..8a3dee4330ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind_cb.c
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+/*
+ * A callback that a helper or a kfunc calls unwinds into a pad in the helper,
+ * which leaves to the pad after the call of the helper. See verifier_unwind.c
+ * for the insns. vmlinux.h, for the offsets the find_vma tests need, leaves no
+ * BPF_RAW_INSN(), so here they are raw words: the code, src_reg = 1 in the
+ * high nibble of the second byte, off in the next two bytes.
+ */
+#define unwind_goto(off) ".8byte (" #off " << 16) | 0x10e5;"	/* BPF_JMP | BPF_JCOND */
+#define unwind_exit ".8byte 0x1095;"				/* BPF_JMP | BPF_EXIT */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, int);
+	__type(value, int);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 3);
+	__type(key, int);
+	__type(value, int);
+} hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 3);
+	__type(key, int);
+	__type(value, int);
+} rhash SEC(".maps");
+
+struct node_data {
+	long key;
+	struct bpf_rb_node node;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_rb_root groot __contains(node_data, node);
+
+/* How many times the callback ran */
+__u64 runs;
+
+#define count_run()				\
+	"r1 = %[runs] ll;"			\
+	"r2 = *(u64 *)(r1 + 0);"		\
+	"r2 += 1;"				\
+	"*(u64 *)(r1 + 0) = r2;"
+
+/* Unwinds with r0 = 5 on its first run */
+__naked __noinline __used
+static unsigned long cb_unwinds(void)
+{
+	asm volatile (
+		count_run()
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(runs)
+	);
+}
+
+/* Returns 0 twice, then unwinds */
+__naked __noinline __used
+static unsigned long cb_unwinds_third(void)
+{
+	asm volatile (
+		count_run()
+		"if r2 == 3 goto 1f;"
+		"r0 = 0;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(runs)
+	);
+}
+
+/* Returns 0: the loop runs to its end */
+__naked __noinline __used
+static unsigned long cb_returns(void)
+{
+	asm volatile (
+		count_run()
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(runs)
+	);
+}
+
+__naked __noinline __used
+static unsigned long always_unwinds(void)
+{
+	asm volatile (
+		"r0 = 5;"
+		unwind_exit
+	);
+}
+
+/* What it calls unwinds. Its pad counts the run and unwinds on. */
+__naked __noinline __used
+static unsigned long cb_passes_on(void)
+{
+	asm volatile (
+		"call always_unwinds;"
+		unwind_goto(2)
+		"r0 = 0;"
+		"exit;"
+		count_run()
+		"r0 = 7;"
+		unwind_exit
+		:
+		: __imm_addr(runs)
+	);
+}
+
+/*
+ * The pad after the call of the helper returns the number of runs plus what
+ * the helper left in r0, which is what the callback unwound with, plus 41.
+ */
+#define PAD					\
+	"r1 = %[runs] ll;"			\
+	"r1 = *(u64 *)(r1 + 0);"		\
+	"r0 += r1;"				\
+	"r0 += 41;"				\
+	"exit;"
+
+/* The loop is inlined, and so is its pad: unwind_goto after the call of the callback */
+SEC("tc")
+__description("unwind cb: the callback of bpf_loop unwinds on its first run")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__xlated("unwind_goto pc+7")
+__naked int loop_cb_unwinds(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind cb: the callback of bpf_loop unwinds on its third run")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(49)
+__naked int loop_cb_unwinds_third(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_unwinds_third];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_ptr(cb_unwinds_third),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* unwind_goto after a helper whose callback returns: the pad is never taken */
+SEC("tc")
+__description("unwind cb: unwind_goto after bpf_loop whose callback returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(3)
+__naked int loop_cb_returns_pad(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_returns];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_ptr(cb_returns),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind cb: the exception goes through the pad of the callback")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(49)
+__naked int loop_cb_passes_on(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"r2 = %[cb_passes_on];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_ptr(cb_passes_on),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind cb: no unwind_goto after bpf_loop whose callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("no unwind_goto after the call of bpf_loop()")
+__naked int loop_cb_unwinds_no_pad(void)
+{
+	asm volatile (
+		"r1 = 10;"
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
+/*
+ * A loop of no rounds never runs its callback, so the call needs no unwind_goto,
+ * and the inlined loop gets no pad: the insn after the call is what it was, not
+ * the jump of a pad.
+ */
+SEC("tc")
+__description("unwind cb: a loop of no rounds needs no pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int loop_none_cb_unwinds(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/*
+ * One path passes a callback that unwinds, the other one that returns. The pad
+ * is there for whoever takes it. 64 bytes come in: the first one.
+ */
+SEC("tc")
+__description("unwind cb: the callbacks of one call may differ")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int loop_cbs_differ(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"r2 = %[cb_unwinds];"
+		"if r6 == 64 goto 1f;"
+		"r2 = %[cb_returns];"
+	"1:"
+		"r1 = 3;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_ptr(cb_unwinds),
+		  __imm_ptr(cb_returns),
+		  __imm_addr(runs),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("tc")
+__description("unwind cb: the callback of bpf_for_each_map_elem over an array unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int for_each_array_cb_unwinds(void)
+{
+	asm volatile (
+		"r1 = %[array] ll;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_addr(array),
+		  __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+/* Two elements go in first. The hash iterators run the callback under RCU. */
+#define FILL_MAP(map)				\
+	"r1 = 1;"				\
+	"*(u32 *)(r10 - 4) = r1;"		\
+	"*(u32 *)(r10 - 8) = r1;"		\
+	"r1 = %[" #map "] ll;"			\
+	"r2 = r10;"				\
+	"r2 += -4;"				\
+	"r3 = r10;"				\
+	"r3 += -8;"				\
+	"r4 = 0;"				\
+	"call %[bpf_map_update_elem];"		\
+	"r1 = 2;"				\
+	"*(u32 *)(r10 - 4) = r1;"		\
+	"r1 = %[" #map "] ll;"			\
+	"r2 = r10;"				\
+	"r2 += -4;"				\
+	"r3 = r10;"				\
+	"r3 += -8;"				\
+	"r4 = 0;"				\
+	"call %[bpf_map_update_elem];"
+
+SEC("tc")
+__description("unwind cb: the callback of bpf_for_each_map_elem over a hash unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int for_each_hash_cb_unwinds(void)
+{
+	asm volatile (
+		FILL_MAP(hash)
+		"r1 = %[hash] ll;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_addr(hash),
+		  __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_map_update_elem),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind cb: the callback of bpf_for_each_map_elem over an rhash unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int for_each_rhash_cb_unwinds(void)
+{
+	asm volatile (
+		FILL_MAP(rhash)
+		"r1 = %[rhash] ll;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_addr(rhash),
+		  __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_map_update_elem),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+/*
+ * The vma of the stack of the current task. The callback runs under the mmap
+ * lock, which the helper drops on its way out whichever way the callback left.
+ */
+SEC("tc")
+__description("unwind cb: the callback of bpf_find_vma unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(47)
+__naked int find_vma_cb_unwinds(void)
+{
+	asm volatile (
+		"call %[bpf_get_current_task_btf];"
+		"r6 = r0;"
+		"r1 = *(u64 *)(r6 + %[mm]);"
+		"r2 = *(u64 *)(r1 + %[start_stack]);"
+		"r1 = r6;"
+		"r3 = %[cb_unwinds];"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call %[bpf_find_vma];"
+		unwind_goto(1)
+		"exit;"
+		PAD
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm_addr(runs),
+		  __imm(bpf_get_current_task_btf),
+		  __imm(bpf_find_vma),
+		  __imm_const(mm, offsetof(struct task_struct, mm)),
+		  __imm_const(start_stack, offsetof(struct mm_struct, start_stack))
+		: __clobber_common, "r6"
+	);
+}
+
+static bool less_returns(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	return true;
+}
+
+/* Not naked: the branch keeps the return reachable. Unwinds with r0 = 5. */
+static bool less_unwinds(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	runs++;
+	if (a)
+		asm volatile ("r0 = 5;" unwind_exit ::: "r0");
+	return false;
+}
+
+/* The kfunc with a pad after it. The verifier fills r4 and r5. r0 + 42 from the pad. */
+__naked __noinline __used
+static int rbtree_add_with_pad(void *root, void *node, void *less)
+{
+	asm volatile (
+		"call %[bpf_rbtree_add];"
+		unwind_goto(1)
+		"exit;"
+		"r0 += 42;"
+		"exit;"
+		:
+		: __imm(bpf_rbtree_add)
+		: __clobber_all
+	);
+}
+
+/*
+ * The other spelling of it, with its own copy of the body and of the pad. It
+ * takes meta and off from the prog, and the verifier fills them in.
+ */
+__naked __noinline __used
+static int rbtree_add_impl_with_pad(void *root, void *node, void *less)
+{
+	asm volatile (
+		"r4 = 0;"
+		"r5 = 0;"
+		"call %[bpf_rbtree_add_impl];"
+		unwind_goto(1)
+		"exit;"
+		"r0 += 42;"
+		"exit;"
+		:
+		: __imm(bpf_rbtree_add_impl)
+		: __clobber_all
+	);
+}
+
+/*
+ * The first node goes in without a comparison. The second one meets it, the
+ * comparator unwinds, and the kfunc drops the node on its way to the pad. The
+ * lock is the caller's.
+ */
+static __always_inline int rbtree_cb_unwinds_via(bool impl)
+{
+	struct node_data *n, *m;
+	int ret;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	m = bpf_obj_new(typeof(*m));
+	if (!m) {
+		bpf_obj_drop(n);
+		return 2;
+	}
+
+	bpf_spin_lock(&glock);
+	if (impl) {
+		bpf_rbtree_add_impl(&groot, &n->node, less_returns, NULL, 0);
+		ret = rbtree_add_impl_with_pad(&groot, &m->node, (void *)less_unwinds);
+	} else {
+		bpf_rbtree_add(&groot, &n->node, less_returns);
+		ret = rbtree_add_with_pad(&groot, &m->node, (void *)less_unwinds);
+	}
+	bpf_spin_unlock(&glock);
+	return ret + runs;
+}
+
+SEC("tc")
+__description("unwind cb: the comparator of bpf_rbtree_add unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(48)
+int rbtree_cb_unwinds(void *ctx)
+{
+	return rbtree_cb_unwinds_via(false);
+}
+
+SEC("tc")
+__description("unwind cb: the comparator of bpf_rbtree_add_impl unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(48)
+int rbtree_impl_cb_unwinds(void *ctx)
+{
+	return rbtree_cb_unwinds_via(true);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

