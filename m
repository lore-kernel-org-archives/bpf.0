Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022938;
	b=FKz2qHQ+ajw6q2gpCWPrImREEjuCR3ePg3tV3GI8LCoEh/GznutLS1O9OWEwQMPPgZgt
	 UVjPwe1SE9MthizzU+kQAS1uSapjYUaySdCTp3pJyrVJ+slZMlWaLtM3V1OdJLqol8pjo
	 jp65+nnBlNPoxNARpByJv5wrp/n4OndbrhZCLwMz0yHa49SK6dxG26H93IMIGEUXjKji2
	 HhBBfSNhWKEgyJY9waOhNNGBJmFVQrmOv3ZG1YpPGW62eVDvKh0NoawK2f3OMtU8gZ0sp
	 EHpHVLbDwLk/KSL2APMp5xrj7W9clXvNcNl2mWrOpwKvUtlQzFXX+KcMoK3MtOX5Hag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gUzYil+6JKN5nkQ3/uS5X5CreQu6aypd/6gujI4mN88=;
	b=JEcff22krHZTPASWREEGXOQTG2ljkKwxwFlyBfv/XrnAbOJ3ozqo4uL8e2wEyzldOfWE
	 fj2Z9EqRbMqZtlY5QFX08NCk+tvKRG8LNJtGEeKBxxi0nkCpv3NDVcWjzJwZUIQVwQ5Cf
	 4Rt7iPFsrqA0miqm2763BFns93ifc5/fPiyoipsot1Ari/1VGswW7TQ/dEAeRRFQainvX
	 KBK6C5V3dE0S9PlTec2+2f82xtw96WNZ9mnN/KUe/XHl48Dht6Jud6cwOvaQHsv8CGA7n
	 K2A4MxB9FNJ9u9BiIyNzWZROZ7xUXetjNxwWo47fZxJhnjo7ktmt88OUvWL3OJmuB4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxBBCimc;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2A606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1C2A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxBBCimc
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0fd031198so280219a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022936; x=1794627736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUzYil+6JKN5nkQ3/uS5X5CreQu6aypd/6gujI4mN88=;
        b=SxBBCimc9WO9egczFfeEkW78mEQv0WCF3DNgBlJo24OAnhRcFpCFyATrx++/et3jYU
         +9nequuPdbnK/CW+xAXey0XV2jG9iGUgjH/IVE3/B5f0+4fcQxA2S3Qmg+0wokDRO1YG
         ulyHgWl/nOtrY7wyjnlYfihhFEZ5NnqG7tssMoex2HzqTLZ2hgsPI5b6Xcg4YxUkECG1
         R6B5jVtJlQIsEXQWGkGdOenWE16cE8nbhVwds+1zp5S0DrPeqmsL+TRXntPscKoJIT+F
         MN5Vq+RfmX18VsJwplRBOYY9AvjE/xtwRkN8lB0vT/tG5X5bn2ApVRC8Or7FvmJunXYI
         Rggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022936; x=1794627736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUzYil+6JKN5nkQ3/uS5X5CreQu6aypd/6gujI4mN88=;
        b=j4ELuQ8klyw2H9WdkmGVdmy+YLAefIPEd6KXtmwnTJu/MGC+jPSpwOMMrIyvw0cvJd
         0GAznnP1j9mqoQeYHSxwlxZOPkZNcdFCteORqI4fiJAnlaWO3P1Gfh26A2N8TmOjP9eO
         3xq8GsfCSOaOdOmx41BS2Ct1je7EiPQ4nK0gVc4jfbM+RpJNIRADZ37KqW4sBuysXIwo
         aWbYO0qSt9X8k2Nu4d9eFt3UWxHwphCkdpn+TeqxI9T3jEc8ZZLs1JHi3nq6Htv+rG9k
         U5Zlg2V4Jum6uQGFD7sXaX7no9XisVHoXbGxKPTjgHeGbDS6uA1ZV0TuOCnYgEt8VIf0
         /C4A==
X-Gm-Message-State: APuU4Z/f7rfgz/16qR1skO5HbU+vpSZGlrKcnQ1xVPubCWAAWUovpcVg
	fTLwu7XviuP7soN+7sLEaBUo3mq6h5cyLhxhAfvgukwgPXbsa5xvVKlxWrGCqg==
X-Gm-Gg: AYBFou2ReOFbrd7y5ZaBBjjFe6aOU6ZR1XdFBKCrwMGN89sFcVv3WCj2NFedZ7xBiAN
	B+7EHpLfYT4z0aZtN+aRKyPUv6DVdMx7/J1UMDraJKvgowVL33BuOjR6tdil3IqjGwwLx7ySxU1
	1gfRi97yn0gN4eqkuxukN0dW/jZFMf+NFOYxxL2Ne4eP1fdd1XhZf/XdYjshY5FznJTyXp03fRc
	KW9QetoSLXah5uNOPIYby08g3zrHppf0qhlwPgPsxwBJsmB4OvqxieHVtblSNhNEch+qSau26u0
	8bEAi8V7DJSDvBLQZtx0jBj10lUXS1d0udBdoDQBGg9RlSJdwo4M+S6cRLe90fk9Ey1vB01zA0J
	My+0vRN+i3hHb64v2rlL5mroVZTkhmDyfSEFJ4ALmcPTNh7dk7hClnM588r55H0tsEUoBcq1lDQ
	SEZIuew2rnGnIEDXdFCRd+oi/eVT7fuLpzcbucNOD9SZyr1OXqij+dborZwhnmqIDpewOejzj1k
	2dMoVEaWRgylObWj8pOESZtKE3WpV+bOiLVxKwF8Upogq8+xVaPFFnQmJMWffXZLMCJi5TlSq4u
	uOHV8OJ3MmZQ5EfroP7tn02r2Lnv0ra41k/pBRi94u0oh5qKjg/3nkQ2GnoyPu0EhJljR0nzUVy
	aKhIdT9u77SQ+apXi+rBufQOQ6g8E3GCvvMEWeDCulxUWJMH6Mdofft2yfbmFfph3d5XA/lTHlQ
	==
X-Received: by 2002:a17:90b:1c0d:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3b0db6e04e3mr4380021a91.11.1794022935158;
        Fri, 06 Nov 2026 19:42:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105817ce1sm1502570a91.9.2026.11.06.19.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:42:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 42/46] selftests/bpf: Test loops that are counted, walked or widened
Date: Sat,  7 Nov 2026 03:37:50 +0000
Message-ID: <20261107033758.1547725-43-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

The verifier has three methods for a loop:
 - Counted: scalar evolution gives the number of iterations and a range for
   each register that has a closed form. The loop gets no may_goto.
 - Walked: iteration by iteration, with the real values.
 - Widened: what returns to the head is joined with the state that it comes
   from. A bound that grows moves to a fixed stop, until nothing changes.
The wrong method rejects a valid prog or costs thousands of insns. A wrong
state at the head loads an unsafe prog.

  [W] "bpf: Add union and widening of the range of a register"
  [J] "bpf: Add join of registers and stack slots"
  [A] "bpf: Find the registers and stack slots that later checks depend on"
  [E] "bpf: Merge the state that arrives into the set at an insn"
  [M] "bpf: Move states along edges, into loops and subprogs and out of
      them"
  [L] "bpf: Enter and leave loops in the main pass, build flow.c"
  [C] "bpf: Keep the count of a loop when a register has no closed form"
  [G] "bpf: Tell the passes over the graph where an added may_goto goes"
  [1] "bpf: Keep the first iteration of a counted loop apart"
  [R] "bpf: What a call returns in each iteration is like what the loop
      loads"
  [T] "bpf: Find where the jumps of a loop stop a number"
  [B] "bpf: A loop is one iteration shorter behind the jump that counts it"
  [P] "bpf: Give the places of a back edge to the jumps that count"
  [Y] "bpf: Count a loop whose exit tests a copy of the counter"

  verifier_..        the loop                     the verifier must
  -----------------  ---------------------------  -------------------------
  loop_need.c        is counted, 'x = x * 3 + 1'  [C] walk it if a jump, an
                     has no closed form           access or a call ahead
                                                  depends on x ([A]), else
                                                  widen x
                     is too long for a walk,      [1] verify the first
                     'idx = table[idx]',          iteration on its own
                     'x = rnd() & 15'             [R] the same
  loop_as_is.c       is not counted               [M] join the state that
                                                  ends a walk with a state
                                                  of this walk only
                     or bpf_loop(): two states    [E] join what comes back
                     get there, with 0 and 8      with the state that it
                                                  comes from
                     'if (..) n--', from 3        [W] stop n at 0
                     'sum += x', no jump depends  [J] forget sum at once:
                     on sum, in 64 and 32 bits    two passes
                     a jump compares sum with     [J] stop sum at S32_MAX
                     a register
                     'if (sum == 77)'             [W] not try S64_MAX after
                                                  U32_MAX
                     the largest of numbers       [W] keep the lower bound
                     'off -= 4' until off is -4   [W] keep the step of 4
                     'if (n < 8) a[n++] = j',     [T] stop n at 8, off at
                     'off += l' below 8000        7999
                     is counted, too long for     [C] stop n at 8, add no
                     a walk, 'if (n < 8) n++'     may_goto
  loop_walk.c        has two entries (bpfjailer)  [L] walk it to its end
                     each iteration decides       [L] go on with the walk
                     a jump that leaves the loop
                     'while (rnd()) n++'          [L] give up at once
                     has two iterations, a flag   [L] walk both
                     for a counter, and a call
                     only a flag that went both   [L] give up
                     ways decides its jump
                     32 states enter, each needs  [L] count the insns of
                     a walk of 300 insns          each walk, not of all
                     is too long for a walk       [L] not try it again
  loop_latch.c       ends when a flag is false:   [G] count it by the jump
                     'more = ++i < N && cond',    that clears the flag
                     20 insns, a jump or calls
                     in front of 'while (more)'
                     the same with 40 jumps, an   [G] count it
                     error code or a size
                     from that jump a path leads  [G] not count it
                     to another back edge, or
                     into a nested loop
                     the flag is a constant only  [G] not count it
                     without an added may_goto
                     a load changes the flag,     [G] not count it
                     101 of 64 - 127 goes on
                     a store behind the jump      [B] one iteration less
                     that counts                  for the pointer
                     that jump leaves by way of   [B] not shorten the range
                     a flag, or on both edges
                     five statuses of calls are   [P] count it, by way of
                     nearer to the back edge      a flag too
                     'while (buf[i++] && i < N)'  [Y] count it if the two
                     tests a copy of i            are equal at the entry
  value_ptr_arith.c  'p = &v[p->next]'            [J] keep [0, 31] next to
                                                  0: it covers the rest
                     'p += 1'                     [J] reject
  scev.c             takes a reference in each    [L] reject, or load
                     iteration, or in one
  iterating_         bpf_loop() is the head of    [L] verify the callback
  callbacks.c        a walked loop                in the last iteration too

In most tests the number is an index after the loop, where no jump limits
it: its range at the head decides.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   6 +
 .../bpf/progs/verifier_iterating_callbacks.c  |  53 ++
 .../selftests/bpf/progs/verifier_loop_as_is.c | 513 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_loop_latch.c | 300 +++++++++-
 .../selftests/bpf/progs/verifier_loop_need.c  | 372 +++++++++++++
 .../selftests/bpf/progs/verifier_loop_walk.c  | 306 +++++++++++
 .../selftests/bpf/progs/verifier_scev.c       | 130 +++++
 .../bpf/progs/verifier_value_ptr_arith.c      |  55 ++
 8 files changed, 1733 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_as_is.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_need.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_walk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 3f3b9b48523f..978d6d7773ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -84,7 +84,10 @@
 #include "verifier_liveness_exp.skel.h"
 #include "verifier_load_acquire.skel.h"
 #include "verifier_loop_hierarchy.skel.h"
+#include "verifier_loop_as_is.skel.h"
 #include "verifier_loop_latch.skel.h"
+#include "verifier_loop_need.skel.h"
+#include "verifier_loop_walk.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -286,7 +289,10 @@ void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
 void test_verifier_loop_hierarchy(void)       { RUN(verifier_loop_hierarchy); }
+void test_verifier_loop_as_is(void)           { RUN(verifier_loop_as_is); }
 void test_verifier_loop_latch(void)           { RUN(verifier_loop_latch); }
+void test_verifier_loop_need(void)            { RUN(verifier_loop_need); }
+void test_verifier_loop_walk(void)            { RUN(verifier_loop_walk); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index a3e31aa25fe1..e30f7676081f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -290,6 +290,59 @@ static __naked void iter_limit_bug_cb(void)
 	);
 }
 
+static __naked __noinline __used void set_flag_cb(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r2 + 0) = r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all
+	);
+}
+
+/*
+ * bpf_loop() is the head of a loop whose iterations are looked at one by one, because of r1.
+ * The callback comes back to it in the same iteration, the last one included.
+ */
+SEC("socket")
+__failure __msg("frame pointer is read only")
+__naked void callback_returns_to_loop_head(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 1;"
+	"r2 = %[set_flag_cb] ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"1:"
+	"call %[bpf_loop];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"if r1 == 0 goto 2f;"
+	"if r7 != 3 goto 2f;"
+	"r10 = 0;"
+	"2:"
+	"r7 += 1;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r7;"
+	"r2 = %[set_flag_cb] ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"if r7 < 4 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(set_flag_cb),
+	  __imm(bpf_loop)
+	: __clobber_all
+	);
+}
+
 /*
  * may_goto doesn't leave the loop, so it's not what stops it. The address is greater than 10:
  * the loop spins until may_goto that the verifier adds ends the prog.
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_as_is.c b/tools/testing/selftests/bpf/progs/verifier_loop_as_is.c
new file mode 100644
index 000000000000..fffc53e17b5d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_as_is.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The state that enters a loop that is not counted is left as it is. So is the state that ends
+ * a walk through the iterations of such a loop. What stands for many iterations is a join of states
+ * that were seen, not a guess that is written into one of them.
+ */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64[9]);
+} map SEC(".maps");
+
+#define LOOKUP(reg)							\
+	"r1 = 0;"							\
+	"*(u32 *)(r10 - 4) = r1;"					\
+	"r2 = r10;"							\
+	"r2 += -4;"							\
+	"r1 = %[map] ll;"						\
+	"call %[bpf_map_lookup_elem];"					\
+	#reg " = r0;"							\
+	"if r0 == 0 goto 9f;"
+
+#define END								\
+"9:"									\
+	"r0 = 0;"							\
+	"exit;"								\
+	:								\
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)			\
+	: __clobber_all
+
+/* END with more operands. may_goto leaves the loop: @off insns ahead */
+#define END_WITH(more)							\
+"9:"									\
+	"r0 = 0;"							\
+	"exit;"								\
+	:								\
+	: __imm(bpf_map_lookup_elem), __imm_addr(map), more		\
+	: __clobber_all
+#define MAY_GOTO(off) __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0))
+
+#define OK(text)	SEC("socket") __description("as is: " text) __success __retval(0)
+#define BAD(text)	SEC("socket") __description("as is: " text) __failure
+
+/*
+ *	do { n += 3; } while (v[0]);
+ * Two iterations are looked at as they are. The second one ends the walk: its jump goes both
+ * ways. Its state is joined with the one before, nothing stops n, so n is any number.
+ * What comes back next is within that. The number of insns tells that there is no fourth pass.
+ * The loop gets may_goto when the walk ends, and all is done again: two times 24 insns.
+ */
+OK("the state that ends a walk is joined with the one before")
+__log_level(1) __msg("processed 48 insns")
+__naked void two_passes(void)
+{
+	asm volatile (
+	LOOKUP(r7)
+	"r6 = 0;"
+"1:"
+	"r6 += 3;"
+	"r1 = *(u32 *)(r7 + 0);"
+	"if r1 != 0 goto 1b;"
+	"r6 &= 63;"
+	"r7 += r6;"
+	"r0 = *(u8 *)(r7 + 8);"
+	END);
+}
+
+/*
+ *	x = (v[0] & 1) << 62; do { x |= x >> 1; if (x > 1 << 62) break; } while (v[1]);
+ * The range at the head is 0..1 << 62 in every pass, the lower half is 0, and one more bit is not
+ * known: bit 61, 60 .. 32. That is not followed bit by bit, 30 passes and more in a nest of loops:
+ * the known bits are what the range says after the first one.
+ */
+OK("known bits are not lost one by one")
+__log_level(1) __msg("processed 74 insns")
+__naked void bits_one_by_one(void)
+{
+	asm volatile (
+	LOOKUP(r7)
+	"r6 = *(u64 *)(r7 + 0);"
+	"r6 &= 1;"
+	"r6 <<= 62;"
+	"r8 = 1;"
+	"r8 <<= 62;"
+"1:"
+	"r1 = r6;"
+	"r1 >>= 1;"
+	"r6 |= r1;"
+	"if r6 > r8 goto 9f;"
+	"r1 = *(u64 *)(r7 + 8);"
+	"if r1 != 0 goto 1b;"
+	"r6 >>= 60;"
+	"r7 += r6;"
+	"r0 = *(u8 *)(r7 + 0);"
+	END);
+}
+
+/*
+ *	if (x < 1000000) return; do { if (x && !v[2]) x--; } while (v[1]);
+ * x is 1000000..U64_MAX, then 999999..U64_MAX. As a signed number it's S64_MIN..S64_MAX all the
+ * time: no signed bound moves, and the range does, a million times if nothing is done about it.
+ */
+OK("a range moves and its signed bounds do not")
+__log_level(1) __msg("processed 68 insns")
+__naked void unsigned_bound_moves(void)
+{
+	asm volatile (
+	LOOKUP(r7)
+	"r6 = *(u64 *)(r7 + 0);"
+	"if r6 < 1000000 goto 9f;"
+"1:"
+	"if r6 == 0 goto 2f;"
+	"r1 = *(u64 *)(r7 + 16);"
+	"if r1 != 0 goto 2f;"
+	"r6 += -1;"
+"2:"
+	"r1 = *(u64 *)(r7 + 8);"
+	"if r1 != 0 goto 1b;"
+	"r6 &= 7;"
+	"r7 += r6;"
+	"r0 = *(u8 *)(r7 + 0);"
+	END);
+}
+
+/*
+ *	n = 3; while (v[0]) { if (v[0] != 1 && n) n--; }
+ * n goes from 3 to 0. The bound that moves at the head of the loop is put at 0, the nearest of the
+ * fixed stops, and that holds. Without it n goes on to fall, and n & 63 is up to 63.
+ */
+OK("a number that falls stops at 0")
+__naked void stops_at_0(void)
+{
+	asm volatile (
+	LOOKUP(r6)
+	"r7 = 3;"
+"1:"
+	"r1 = *(u64 *)(r6 + 0);"
+	"if r1 == 0 goto 3f;"
+	"if r1 == 1 goto 2f;"
+	"if r7 == 0 goto 2f;"
+	"r7 += -1;"
+"2:"
+	"goto 1b;"
+"3:"
+	"r7 &= 63;"
+	"r6 += r7;"
+	"r0 = *(u8 *)(r6 + 68);"
+	END);
+}
+
+/*
+ *	sum = 0; n = 0; max = v[1]; if (max > 64) return;
+ *	while (can_loop) { @test sum += (u8)v[0]; if (!(u8)v[0]) break; }
+ *	@use ((u8 *)v)[sum]
+ * The loop has may_goto, @off insns long, so it is neither counted nor walked. The number of insns
+ * tells how many times it is looked at.
+ */
+#define SUM(name, test, add, off, use)					\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r7)							\
+	"r6 = 0;"							\
+	"r9 = 0;"							\
+	"r8 = *(u64 *)(r7 + 8);"					\
+	"if r8 s> 64 goto 9f;"						\
+"1:"									\
+	".8byte %[may_goto];"						\
+	test								\
+	"r1 = *(u8 *)(r7 + 0);"						\
+	add								\
+	"if r1 != 0 goto 1b;"						\
+	use								\
+	"r7 += r6;"							\
+	"r0 = *(u8 *)(r7 + 0);"						\
+	END_WITH(MAY_GOTO(off)));					\
+}
+
+/* No jump of the loop depends on the sum, no stop holds it: two passes, with 0 and any number */
+OK("a sum is any number at once")
+__log_level(1) __msg("processed 25 insns")
+SUM(sum_two_passes, "", "r6 += r1;", 3, "r6 &= 63;")
+
+BAD("a sum is any number at once, and no index")
+__msg("register with unbounded min value is not allowed")
+SUM(sum_two_passes_bad, "", "r6 += r1;", 3, "")
+
+/* sum = x + sum + x; if (x != 3) n -= x; */
+OK("a sum has many forms")
+__log_level(1) __msg("processed 36 insns")
+SUM(sum_forms, "",
+    "r2 = r1; r2 += r6; r6 = r2; r6 += r1; if r1 == 3 goto +1; r9 -= r1;", 8, "r6 += r9; r6 &= 63;")
+
+/* A test of the low half is sufficient behind the loop */
+OK("a sum in 32 bits is any number of 32 bits at once")
+__log_level(1) __msg("processed 25 insns")
+SUM(sum32_two_passes, "", "w6 += w1;", 3, "if w6 > 63 goto 9f;")
+
+/* 0..S32_MAX at the head, 0..63 behind the jump. Of any number the jump leaves S64_MIN..63. */
+OK("a sum that a jump compares with a register is not forgotten")
+SUM(sum_below_max, "if r6 s>= r8 goto 9f; r2 = r7; r2 += r6; r0 = *(u8 *)(r2 + 0);",
+    "r6 += r1;", 7, "r6 &= 63;")
+
+/* The same jump in a loop in the loop: do { if (sum >= max) return; } while (((u8 *)v)[sum]); */
+OK("a sum that a jump of a nested loop compares with a register is not forgotten")
+SUM(sum_below_max_nested,
+    "2: if r6 s>= r8 goto 9f; r2 = r7; r2 += r6; r0 = *(u8 *)(r2 + 0); if r0 != 0 goto 2b;",
+    "r6 += r1;", 8, "r6 &= 63;")
+
+/* 0, 0..S32_MAX, 0..U32_MAX, any number. 0..S64_MAX would be one more pass, and wraps. */
+OK("a sum that gets past U32_MAX is any number")
+__log_level(1) __msg("processed 37 insns")
+SUM(sum_past_u32_max, "if r6 == 77 goto +0;", "r6 += r1;", 4, "r6 &= 63;")
+
+/* 0, S32_MIN..0, any number */
+OK("a sum that gets past S32_MIN is any number")
+__log_level(1) __msg("processed 32 insns")
+SUM(sum_past_s32_min, "if r6 == 77 goto +0;", "r6 -= r1;", 4, "r6 &= 63;")
+
+/*
+ *	while (can_loop) { x = v[1] >> 1; if (x > sum) sum = x; if (!(u8)v[0]) break; }
+ * 0..S64_MAX is what arrives. No guess has failed: the lower bound stays, the signed test needs it.
+ */
+OK("the largest of numbers up to S64_MAX is not negative")
+SUM(largest, "r2 = *(u64 *)(r7 + 8); r2 >>= 1; if r2 <= r6 goto +1; r6 = r2;", "", 6,
+    "if r6 s> 63 goto 9f;")
+
+/*
+ *	n = 0; while (v[0]) { if (v[0] != 1 && n < 8) n++; }
+ *	((u8 *)v)[n + off]
+ * n grows in some iterations only, and no edge of the jump that looks at it leaves the loop. n is
+ * an index behind the loop, where no jump has cut it: what counts is its range at the head.
+ * 7 goes on to the add, so 8 comes back at most.
+ * @load, @store: n lives in a register, or in 32 bits of a stack slot.
+ */
+#define GROWS(name, load, store, off)					\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r6)							\
+	"r7 = 0;"							\
+	store								\
+"1:"									\
+	"r1 = *(u64 *)(r6 + 0);"					\
+	"if r1 == 0 goto 3f;"						\
+	"if r1 == 1 goto 2f;"						\
+	load								\
+	"if r7 >= 8 goto 2f;"						\
+	"r7 += 1;"							\
+	store								\
+"2:"									\
+	"goto 1b;"							\
+"3:"									\
+	load								\
+	"r6 += r7;"							\
+	"r0 = *(u8 *)(r6 + " #off ");"					\
+	END);								\
+}
+
+OK("a jump of the loop stops a number at 8")
+GROWS(stops_at_8, "", "", 63)
+
+BAD("a jump of the loop stops a number at 8, one byte too far")
+__msg("invalid access to map value, value_size=72 off=72 size=1")
+GROWS(stops_at_8_bad, "", "", 64)
+
+OK("a jump of the loop stops a number in a stack slot at 8")
+GROWS(slot_stops_at_8, "r7 = *(u32 *)(r10 - 16);", "*(u32 *)(r10 - 16) = r7;", 63)
+
+/*
+ *	n = 0; for (i = 0; i < 100000; i++) { if (v[0] != 1 && n < 8) n++; }
+ *	((u8 *)v)[n + off]
+ * The loop has a count and is too long for a walk. The count tells what i is and that there is
+ * no need for may_goto. It has nothing to say about n, which is joined and widened as above.
+ */
+#define COUNTED_GROWS(name, off)					\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r6)							\
+	"r7 = 0;"							\
+	"r8 = 0;"							\
+"1:"									\
+	"r1 = *(u64 *)(r6 + 0);"					\
+	"if r1 == 1 goto 2f;"						\
+	"if r7 >= 8 goto 2f;"						\
+	"r7 += 1;"							\
+"2:"									\
+	"r8 += 1;"							\
+	"if r8 < 100000 goto 1b;"					\
+	"r6 += r7;"							\
+	"r0 = *(u8 *)(r6 + " #off ");"					\
+	END);								\
+}
+
+OK("a jump of a counted loop stops a number at 8")
+__xlated("...")
+__xlated("r8 += 1")
+__xlated("if r8 < 0x186a0 goto pc-{{[0-9]+}}")
+COUNTED_GROWS(counted_stops_at_8, 63)
+
+BAD("a jump of a counted loop stops a number at 8, one byte too far")
+__msg("invalid access to map value, value_size=72 off=72 size=1")
+COUNTED_GROWS(counted_stops_at_8_bad, 64)
+
+/* 8 comes back to the head of the inner loop, and goes from there to the head of the outer one */
+OK("a jump of the inner loop stops a number at 8")
+int inner_loop_stops_at_8(void *ctx)
+{
+	__u32 key = 0;
+	__u64 n = 0, *v;
+	int i, j;
+
+	v = bpf_map_lookup_elem(&map, &key);
+	if (!v)
+		return 0;
+	bpf_for(i, 0, 100) {
+		bpf_for(j, 0, 100) {
+			if (*(volatile __u64 *)v == 1)
+				continue;
+			if (n < 8)
+				v[n++] = 0;
+		}
+	}
+	return v[n];
+}
+
+/*
+ *	err = 0; n = 0; @init
+ *	while (can_loop) { n += 3; @body if (!v[0]) break; }
+ *	@test never();
+ * The loop has may_goto, @off insns long, so it is neither counted nor walked.
+ */
+#define ERR_LOOP(name, init, body, off, test)				\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r7)							\
+	"r6 = 0;"							\
+	"r8 = 0;"							\
+	init								\
+"1:"									\
+	".8byte %[may_goto];"						\
+	"r8 += 3;"							\
+	body								\
+	"r1 = *(u64 *)(r7 + 0);"					\
+	"if r1 != 0 goto 1b;"						\
+	test								\
+	"r0 = r5;"							\
+"2:"									\
+	"r8 &= 7;"							\
+	"r7 += r8;"							\
+	"r0 = *(u8 *)(r7 + 0);"						\
+	END_WITH(MAY_GOTO(off)));					\
+}
+
+/*
+ *	if (v[1]) err = 8; ... if (err != 0 && err != 8) never();
+ * Two states enter the loop. What comes around it with 0 is for the state with 0. Next to 8 it
+ * looks like a number that grew.
+ */
+#define TWO_ENTRIES(name, write)					\
+ERR_LOOP(name, "r1 = *(u64 *)(r7 + 8); if r1 == 0 goto 1f; r6 = 8;",	\
+	 write, 4, "if r6 == 0 goto 2f; if r6 == 8 goto 2f;")
+
+OK("what comes around a loop is for the state that it comes from")
+TWO_ENTRIES(two_entries, "r1 = r8;")
+
+BAD("what comes around a loop is for the state that it comes from, the loop writes")
+__msg("R5 !read_ok")
+TWO_ENTRIES(two_entries_bad, "r6 = r8;")
+
+#define COUNT(name, write)						\
+static __naked __noinline __used int name(void)				\
+{									\
+	asm volatile (							\
+	"r1 = *(u64 *)(r2 + 0);"					\
+	"r1 += 1;"							\
+	"*(u64 *)(r2 + 0) = r1;"					\
+	write								\
+	"r0 = 0;"							\
+	"exit;"								\
+	::: __clobber_all);						\
+}
+
+COUNT(count, "")
+COUNT(count_and_write, "*(u64 *)(r2 + 8) = r1;")
+
+/* The same with bpf_loop(100, @cb, &n, 0) in place of the loop. err is in the slot above n. */
+#define TWO_CALLS(name, cb)						\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r7)							\
+	"r1 = 0;"							\
+	"*(u64 *)(r10 - 16) = r1;"					\
+	"*(u64 *)(r10 - 8) = r1;"					\
+	"r1 = *(u64 *)(r7 + 8);"					\
+	"if r1 == 0 goto 1f;"						\
+	"r1 = 8;"							\
+	"*(u64 *)(r10 - 8) = r1;"					\
+"1:"									\
+	"r1 = 100;"							\
+	"r2 = " #cb " ll;"						\
+	"r3 = r10;"							\
+	"r3 += -16;"							\
+	"r4 = 0;"							\
+	"call %[bpf_loop];"						\
+	"r6 = *(u64 *)(r10 - 8);"					\
+	"if r6 == 0 goto 9f;"						\
+	"if r6 == 8 goto 9f;"						\
+	"r0 = r5;"							\
+	END_WITH(__imm(bpf_loop)));					\
+}
+
+OK("what a callback comes back with is for the state that it comes from")
+TWO_CALLS(two_calls, count)
+
+BAD("what a callback comes back with is for the state that it comes from, it writes")
+__msg("R5 !read_ok")
+TWO_CALLS(two_calls_bad, count_and_write)
+
+/*
+ *	for (i = n; i >= 0; i--) sum += v[i];
+ * A compiler counts in bytes and leaves the loop one element below the array:
+ *	off = n * 8; do { sum += *(u64 *)(v + off); off -= @step; } while (off != -8);
+ * n is a range, so the loop is not counted. Only -8 leaves it. The offset doesn't get past -8
+ * because it is a multiple of 8, and that has to be known at the head of the loop.
+ */
+#define DOWN(name, step)						\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r7)							\
+	"r6 = *(u32 *)(r7 + 64);"					\
+	"if r6 > 7 goto 9f;"						\
+	"r6 <<= 3;"							\
+"1:"									\
+	"r2 = r7;"							\
+	"r2 += r6;"							\
+	"r0 = *(u64 *)(r2 + 0);"					\
+	"r6 += -" #step ";"						\
+	"if r6 != -8 goto 1b;"						\
+	END);								\
+}
+
+OK("down by 8 bytes, left at -8")
+DOWN(down_by_8, 8)
+
+/* 16, 4, -8 is fine, 8, -4 is not */
+BAD("down by 12 bytes, left at -8")
+__msg("min value is negative")
+DOWN(down_by_12, 12)
+
+static __naked __noinline __used void nothing(void)
+{
+	asm volatile ("r0 = 0; exit;" ::: __clobber_all);
+}
+
+/*
+ *	if (v[0]) { n = 7; have = 1; }
+ *	nothing();
+ *	i = 0; do { if (v[0] != 3) i++; } while (i < 8 && v[0] != 2);
+ *	if (have) return n;
+ * (have = 0, n is not set) and (have = 1, n = 7) wait for the function. What comes out of it goes
+ * to both at once, and the insn behind the call is the head of the loop: two walks begin, and no
+ * insn is looked at in between. The state that ends one of them is joined with a state of
+ * that walk. With a state of the other one it would be (have = 0 or 1, n is not set).
+ */
+#define TWO_WALKS(name, test)						\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	LOOKUP(r8)							\
+	"r9 = 0;"							\
+	"r1 = *(u32 *)(r8 + 0);"					\
+	"if r1 != 0 goto 1f;"						\
+	"r7 = 0;"							\
+	"goto 2f;"							\
+"1:"									\
+	"r6 = 7;"							\
+	"r7 = 1;"							\
+"2:"									\
+	"call nothing;"							\
+"3:"									\
+	"r1 = *(u32 *)(r8 + 0);"					\
+	"if r1 == 3 goto +1;"						\
+	"r9 += 1;"							\
+	"if r9 > 7 goto 4f;"						\
+	"if r1 == 1 goto 3b;"						\
+	"if r1 != 2 goto 3b;"						\
+"4:"									\
+	test								\
+	"r0 = r6;"							\
+	"exit;"								\
+	END);								\
+}
+
+OK("two walks begin at the same time")
+TWO_WALKS(two_walks_at_once, "if r7 == 0 goto 9f;")
+
+/* n is read when it is not set */
+BAD("two walks begin at the same time, the register is not set")
+__msg("R6 !read_ok")
+TWO_WALKS(two_walks_at_once_bad, "if r7 != 0 goto 9f;")
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index e8daf791b4c0..12c1cb2f0384 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -21,6 +21,16 @@ struct {
 	__type(value, char[NR]);
 } map SEC(".maps");
 
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
+/* BTF of a kfunc that only asm refers to is not generated */
+void __kfunc_btf_root(void)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+}
+
 #define OK(text, count)								\
 	SEC("socket") __description("latch: " text) __success __log_level(2)	\
 	__msg("header_count is " count)
@@ -53,7 +63,8 @@ __naked void name(void)								\
 9:	r0 = 0;									\
 	exit;									\
 "	:									\
-	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm_addr(map) \
+	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm_addr(map), \
+	  __imm(bpf_rcu_read_lock), __imm(bpf_rcu_read_unlock)			\
 	: __clobber_all);							\
 }
 
@@ -87,6 +98,96 @@ LOOP(ptr_up, "r8 = r6; r9 = r6; r9 += 8; r6 += 2040;", PTR_UP(0))
 BAD("pointers, the first one is in front of the value")
 LOOP(ptr_up_from_below, "r8 = r6; r9 = r6; r9 += 7; r6 += 2040;", PTR_UP(-2))
 
+/*
+ * The store behind the jump that counts is not reached in the last iteration. r9 is linear at the
+ * jump, also when it moved in front of it, and has the range of one iteration less.
+ */
+#define AT_TOP(n)	"if w8 == " #n " goto 9f; *(u8 *)(r9 + 0) = r1; r9 += 1; w8 += 1;"
+#define MOVED(n)	"r9 += 1; if w8 == " #n " goto 9f; *(u8 *)(r9 + 0) = r1; w8 += 1;"
+
+OK("a store behind the jump that counts", "5")
+LOOP(behind, "w8 = 0; r9 = r6; r9 += 2044;", AT_TOP(4) "goto 1b;")
+
+BAD("a store behind the jump that counts, one too many")
+LOOP(behind_bad, "w8 = 0; r9 = r6; r9 += 2044;", AT_TOP(5) "goto 1b;")
+
+OK("a store behind the jump that counts, the pointer has moved", "5")
+LOOP(behind_moved, "w8 = 0; r9 = r6; r9 += 2043;", MOVED(4) "goto 1b;")
+
+BAD("a store behind the jump that counts, the pointer has moved too far")
+LOOP(behind_moved_bad, "w8 = 0; r9 = r6; r9 += 2044;", MOVED(4) "goto 1b;")
+
+OK("a store behind the jump that counts two back edges", "5")
+LOOP(behind_two, "w8 = 0; r9 = r6; r9 += 2044;", AT_TOP(4) "if r7 == 7 goto 1b; goto 1b;")
+
+BAD("a store behind the jump that counts two back edges, one too many")
+LOOP(behind_two_bad, "w8 = 0; r9 = r6; r9 += 2044;", AT_TOP(5) "if r7 == 7 goto 1b; goto 1b;")
+
+/*
+ * Both edges of the first jump that counts leave the loop: the one that is not taken at once, the
+ * other one by way of a flag: w2 is 1 or 3. The store behind it is reached in the last iteration.
+ */
+#define BOTH_LEAVE								\
+	"r9 += 1; w8 += 1; call %[bpf_get_prandom_u32]; if r0 == 0 goto 2f;"	\
+	"if w8 >= 2 goto 3f; goto 9f;"						\
+	"3: *(u8 *)(r9 + 0) = r0; w2 = 1; if r7 == 3 goto 4f; w2 = 3;"		\
+	"4: if w2 == 0 goto 1b; goto 9f;"					\
+	"2: if w8 < 4 goto 1b;"
+
+OK("a store behind a jump that leaves on both edges", "[0..4]")
+LOOP(behind_both, "w8 = 0; r9 = r6; r9 += 2043;", BOTH_LEAVE)
+
+BAD("a store behind a jump that leaves on both edges, one too far")
+LOOP(behind_both_bad, "w8 = 0; r9 = r6; r9 += 2044;", BOTH_LEAVE)
+
+/* The statuses of five calls are nearer to the back edge than the jump that counts */
+#define STATUS		"call %[bpf_get_prandom_u32]; if r0 == 0 goto 9f;"
+#define FAR_UP(n)	"if w8 == " #n " goto 9f; w8 += 1;"			\
+			STATUS STATUS STATUS STATUS STATUS "goto 1b;"
+
+OK("behind five jumps that don't count", "[0..2048]")
+LOOP(far_up, "w8 = 0;", FAR_UP(2047))
+
+BAD("behind five jumps that don't count, one too many")
+LOOP(far_up_bad, "w8 = 0;", FAR_UP(2048))
+
+/*
+ * The same in C: each frame appends up to 32 words. The index has no formula. Its range follows
+ * from the number of frames: the iterations are looked at one by one.
+ */
+u64 word;
+
+#define READ(dst)	bpf_probe_read_kernel(&dst, sizeof(dst), &word)
+#define FRAMES(name, max)							\
+int name(void *ctx)								\
+{										\
+	int i, j, n, idx = 0, frames = 0;					\
+	u64 a, b, c, d, e, *out;						\
+	u32 zero = 0;								\
+										\
+	out = bpf_map_lookup_elem(&map, &zero);					\
+	if (!out)								\
+		return -1;							\
+	bpf_for(i, 0, 100) {							\
+		if (frames == max)						\
+			break;							\
+		if (READ(a) || READ(b) || READ(c) || READ(d) || READ(e))	\
+			break;							\
+		n = 32 - (a & 1);						\
+		for (j = 0; j < n; j++)						\
+			out[idx + j] = b + c + d + e;				\
+		idx += n;							\
+		frames++;							\
+	}									\
+	return idx;								\
+}
+
+OK("frames of a stack walker", "[0..9]") __retval(256)
+FRAMES(eight_frames, 8)
+
+BAD("frames of a stack walker, one too many")
+FRAMES(nine_frames, 9)
+
 /* an int goes down to -1, or up from -N to 0: the distance is a 32-bit number */
 #define DOWN_TO_M1	"w8 += -1; if w8 != -1 goto 1b;"
 #define UP_TO_0		"w8 += 1; if w8 != 0 goto 1b;"
@@ -127,6 +228,75 @@ BAD("down, an unsigned and a signed 64-bit test")
 LOOP(down_two_tests, "w8 = 4; r6 += 2043;",
      "w8 += -1; if r8 < 5 goto 2f; if r8 s>= 5 goto 1b; goto 9f; 2: if r8 < 5 goto 1b;")
 
+/*
+ * 'while (buf[i++] && i < N)': the jump tests r9, a copy of the counter r8 from before the
+ * increment. It is made in front of the loop and at the end of each iteration.
+ */
+#define COPY(n)	"r8 += 1; if r9 > " #n " goto 8f; r9 = r8; if r7 != 0 goto 1b; 8:"
+/* one more store, at the index that the counter is behind the loop */
+#define AT_R8	"r5 += r8; *(u8 *)(r5 + 0) = r1;"
+
+OK("a copy of the counter", "[0..2048]")
+LOOP(copy, "r8 = 0; r9 = r8;", COPY(2046))
+
+BAD("a copy of the counter, one too many")
+LOOP(copy_bad, "r8 = 0; r9 = r8;", COPY(2047))
+
+BAD("a copy of the counter, another number at the entry")
+LOOP(copy_other_const, "r8 = 2047; r9 = 0; r6 += 2047;", COPY(2046))
+
+OK("a copy of the counter, a range", "[0..2]")
+LOOP(copy_range, "r5 = r6; r8 = r7; r8 &= 1; r8 += 2045; r9 = r8;", COPY(2045) AT_R8)
+
+BAD("a copy of the counter, another number of the same range at the entry")
+LOOP(copy_other_range,
+     "r5 = r6; r8 = r7; r8 &= 1; r8 += 2045; r9 = r7; r9 >>= 1; r9 &= 1; r9 += 2045;",
+     COPY(2045) AT_R8)
+
+NO_COUNT("a copy of the counter that is one behind")
+LOOP(copy_behind, "r8 = 0; r9 = r8;",
+     "r8 += 1; if r9 > 2046 goto 9f; r9 = r8; r9 += -1; if r7 != 0 goto 1b;")
+
+/* what the jump says about the copy holds for the counter */
+OK("a copy of the counter, the jump bounds both", "[0..2048]")
+LOOP(copy_bounds_both, "r5 = r6; if r7 > 2047 goto 9f; r8 = r7; r9 = r8;",
+     "if r9 > 2046 goto 8f; r8 += 1; r9 = r8; if r7 != 0 goto 1b; 8:" AT_R8)
+
+/*
+ * Behind the jump that counts the counter has moved on and the copy has not: at the store r9 is
+ * r8 - 1, or r8 + 1 when they go down. A test of r8 is no test of r9 there.
+ */
+#define NOT_EQUAL(step, leave, skip, off)					\
+	"r8 += " #step "; if r9 " leave " goto 9f; if r8 " skip " goto 2f;"	\
+	"r4 = r5; r4 += r9; *(u8 *)(r4 " off ") = r1; 2: r9 = r8; if r7 != 0 goto 1b;"
+
+OK("a copy of the counter, one less behind the jump", "[0..2048]")
+LOOP(copy_less, "r5 = r6; r8 = 0; r9 = r8;", NOT_EQUAL(1, "> 2046", "< 2", "- 1"))
+
+BAD("a copy of the counter, one less behind the jump, not equal")
+LOOP(copy_less_bad, "r5 = r6; r8 = 0; r9 = r8;", NOT_EQUAL(1, "> 2046", "< 2", "- 2"))
+
+OK("a copy of the counter, one more behind the jump", "[0..2047]")
+LOOP(copy_more, "r5 = r6; r8 = 2047; r9 = r8;", NOT_EQUAL(-1, "s< 2", "> 2045", "+ 1"))
+
+BAD("a copy of the counter, one more behind the jump, not equal")
+LOOP(copy_more_bad, "r5 = r6; r8 = 2047; r9 = r8;", NOT_EQUAL(-1, "s< 2", "> 2045", "+ 2"))
+
+/*
+ * r4 is what r9 was at the head. It is r9 that has to be equal to the counter when the loop is
+ * entered, not r4. 64 insns more: too long for a walk.
+ */
+#define X4(insns)	insns insns insns insns
+#define OF_COPY		"r3 = r4; r4 = r9; r8 += 1; if r8 > 2047 goto 9f;"	\
+			"r3 = r4; r3 &= 4095; r3 += r5; *(u8 *)(r3 + 0) = r1;"	\
+			X4(X4(X4("r3 = 0;"))) "r9 = r8; if r7 != 0 goto 1b;"
+
+OK("a copy of a copy of the counter", "[0..2048]")
+LOOP(copy_of_copy, "r5 = r6; r8 = 0; r9 = 0; r4 = 0;", OF_COPY)
+
+BAD("a copy of what is no copy of the counter")
+LOOP(copy_of_no_copy, "r5 = r6; r8 = 0; r9 = r7; r9 &= 4095; r4 = 0;", OF_COPY)
+
 /* 'while (n--)': the jump that counts sets a flag, the jump that leaves the loop tests it */
 #define FLAG(mid)	"w8 += 1; w2 = 1; if w8 == 0 goto 2f; w2 = 0; 2: " mid " if w2 != 1 goto 1b;"
 
@@ -136,6 +306,15 @@ LOOP(flag, "w8 = -2048;", FLAG("r3 = r6;"))
 BAD("a flag, one too many")
 LOOP(flag_bad, "w8 = -2049;", FLAG("r3 = r6;"))
 
+/* A flag leaves the loop later: what is behind the jump runs in the last iteration too */
+#define STORE		"*(u8 *)(r9 + 0) = r1; r9 += 1;"
+
+OK("a flag, a store behind the jump that counts", "[0..2048]")
+LOOP(flag_behind, "w8 = -2048; r9 = r6;", FLAG(STORE))
+
+BAD("a flag, a store behind the jump that counts, one too far")
+LOOP(flag_behind_bad, "w8 = -2048; r9 = r6; r9 += 1;", FLAG(STORE))
+
 OK("a flag, a store behind it", "[0..2048]")
 LOOP(flag_store, "w8 = -2048;",
      "w8 += 1; w2 = 1; *(u32 *)(r10 - 4) = r8; if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
@@ -144,7 +323,84 @@ OK("a flag, a call behind it", "[0..2048]")
 LOOP(flag_call, "w8 = -2048;",
      "w8 += 1; w9 = 1; if w8 == 0 goto 2f; w9 = 0; 2: call %[bpf_get_prandom_u32]; if w9 != 1 goto 1b;")
 
-/* in these the loop goes on when the counter gets to 0 */
+OK("a flag that is set in front of another jump", "[0..2048]")
+LOOP(flag_far, "w8 = -2048;",
+     "w8 += 1; w2 = 1; if r7 != 0 goto 3f; r3 = r6;"
+     "3: if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
+
+/*
+ * 'do { ...; more = ++i < N && cond; work; } while (more);': a compiler keeps the flag when the
+ * work is more than some 10 insns. The flag has two reasons to be 0.
+ */
+#define MORE(count, mid)							\
+	count "w9 = 1; if w7 != 0 goto 2f; w9 = 0; 2: " mid "w9 &= 1; if w9 != 0 goto 1b;"
+#define UP_TO(n)	"w8 += 1; w9 = 0; if w8 > " #n " goto 2f;"
+#define WORK4		"r1 = *(u8 *)(r10 - 4); r1 += 1; *(u8 *)(r10 - 4) = r1; r1 = r6;"
+#define WORK20		WORK4 WORK4 WORK4 WORK4 WORK4
+#define RND		"call %[bpf_get_prandom_u32];"
+
+OK("more: work", "[0..2048]")
+LOOP(more_work, "w8 = 0;", MORE(UP_TO(2047), WORK20))
+
+BAD("more: work, one too many")
+LOOP(more_work_bad, "w8 = 0;", MORE(UP_TO(2048), WORK20))
+
+OK("more: work with a jump in it", "[0..2048]")
+LOOP(more_jump, "w8 = 0;", MORE(UP_TO(2047), WORK4 "if r7 > 5 goto 4f;" WORK20 "4:"))
+
+OK("more: work with calls in it", "[0..2048]")
+LOOP(more_calls, "w8 = 0;", MORE(UP_TO(2047), RND WORK20 RND))
+
+OK("more: the counter is spilled", "[0..2048]")
+LOOP(more_spill, "r8 = 0; *(u64 *)(r10 - 16) = r8;",
+     MORE("r8 = *(u64 *)(r10 - 16); w8 += 1; w9 = 0; *(u64 *)(r10 - 16) = r8;"
+	  "if w8 > 2047 goto 2f;", RND "w8 = w0;" WORK20 RND))
+
+#define NOT_TAKEN(n)	"w8 += 1; if w8 < " #n " goto 4f; w9 = 0; goto 2f; 4:"
+
+OK("more: the edge that is not taken leaves", "[0..2048]")
+LOOP(more_not_taken, "w8 = 0;", MORE(NOT_TAKEN(2048), WORK20))
+
+BAD("more: the edge that is not taken leaves, one too many")
+LOOP(more_not_taken_bad, "w8 = 0;", MORE(NOT_TAKEN(2049), WORK20))
+
+#define JUMP		"if r7 > 5 goto 4f;" WORK4 "4:"
+#define JUMP8		JUMP JUMP JUMP JUMP JUMP JUMP JUMP JUMP
+
+OK("more: work with 40 jumps in it", "[0..2048]")
+LOOP(more_jumps, "w8 = 0;", MORE(UP_TO(2047), JUMP8 JUMP8 JUMP8 JUMP8 JUMP8))
+
+OK("more: behind five jumps that don't count", "[0..2048]")
+LOOP(more_far, "w8 = 0;", MORE(UP_TO(2047), STATUS STATUS STATUS STATUS STATUS))
+
+BAD("more: behind five jumps that don't count, one too many")
+LOOP(more_far_bad, "w8 = 0;", MORE(UP_TO(2048), STATUS STATUS STATUS STATUS STATUS))
+
+OK("more: the flag is 0 or 2 where two paths meet", "[0..2048]")
+LOOP(more_even, "w8 = 0;", MORE(UP_TO(2047), "if r7 > 5 goto 4f; w9 += 2; 4:"))
+
+OK("a flag, a jump on the way out knows a constant", "[0..2048]")
+LOOP(flag_const, "w8 = -2048;",
+     "w8 += 1; w2 = 1; if w8 == 0 goto 2f; w2 = 0;"
+     "2: w3 = 0; if w2 != 0 goto 3f; goto 1b; 3: if w3 == 2 goto 1b;")
+
+/* 'do { ...; err = -E2BIG; if (++i < N) err = f(); work; } while (!err);' */
+#define ERR(last, other, test)							\
+	"w8 += 1; w9 = " #last "; if w8 > 2047 goto 2f; w9 = " #other "; 2: " WORK20 test
+
+OK("an error code", "[0..2048]")
+LOOP(err, "w8 = 0;", ERR(-7, 0, "if w9 == 0 goto 1b;"))
+
+OK("an error code, a signed test", "[0..2048]")
+LOOP(err_signed, "w8 = 0;", ERR(-7, 0, "if w9 s>= 0 goto 1b;"))
+
+OK("a size", "[0..2048]")
+LOOP(size, "w8 = 0;", ERR(128, 0, "if w9 <= 63 goto 1b;"))
+
+OK("a bit of a size", "[0..2048]")
+LOOP(size_bit, "w8 = 0;", ERR(130, 0, "if w9 & 128 goto 9f; goto 1b;"))
+
+/* in these the loop goes on when the counter gets to its last value */
 NO_COUNT("a flag that a call overwrites")
 LOOP(flag_call_r0, "w8 = -2048;",
      "w8 += 1; w0 = 1; if w8 == 0 goto 2f; w0 = 0; 2: call %[bpf_get_prandom_u32]; if w0 != 1 goto 1b;")
@@ -158,6 +414,46 @@ LOOP(flag_changed, "w8 = -2048;", FLAG("w2 &= w7;"))
 NO_COUNT("a flag that is set again on one path")
 LOOP(flag_other_jump, "w8 = -2048;", FLAG("if r7 != 0 goto 4f; w2 = 0; 4:"))
 
+NO_COUNT("a flag that is set again behind the jump that counts")
+LOOP(flag_set_behind, "w8 = 0;",
+     "w8 += 1; w3 = 0; if w8 > 2047 goto 2f; w3 = 5; goto 3f; 2: w3 = 2;"
+     "3: if w3 == 0 goto 9f; if w8 <= w7 goto 1b;")
+
+NO_COUNT("a flag that a load overwrites")
+LOOP(flag_load, "w8 = -2048;", FLAG("r2 = *(u8 *)(r10 - 4);"))
+
+NO_COUNT("the one number of its range that goes on")
+LOOP(err_near, "w8 = 0;", ERR(101, w7, "if w9 == 101 goto 1b;"))
+
+NO_COUNT("a bit that not all numbers of the range have")
+LOOP(size_other_bit, "w8 = 0;", ERR(130, w7, "if w9 & 2 goto 1b;"))
+
+NO_COUNT("a size that is changed")
+LOOP(size_changed, "w8 = 0;", ERR(128, w7, "w9 &= 1; if w9 <= 63 goto 1b;"))
+
+NO_COUNT("an error code of 64 bits, a 64-bit test")
+LOOP(err_wide, "w8 = 0;",
+     "w8 += 1; if w8 > 2047 goto 3f; r9 = r7; r9 <<= 32; r9 s>>= 32; goto 2f;"
+     "3: r9 = -7; 2: if r9 s< 0 goto 1b;")
+
+NO_COUNT("more: a back edge that doesn't test the flag")
+LOOP(more_back_edge, "w8 = 0;",
+     MORE(UP_TO(2047), "if w7 == 3 goto 5f;") "goto 9f; 5: if w8 == 2048 goto 1b;")
+
+/* A nested loop can get may_goto. It goes where a jump of that loop goes, whatever the flag is. */
+NO_COUNT("more: the way out leads through a nested loop")
+LOOP(more_nested, "w8 = 0; call %[bpf_rcu_read_lock];",
+     "w8 += 1; w9 = 0; if w8 > 2047 goto 2f; w9 = 1;"
+     "2: if w9 == 5 goto 4f; if w9 != 0 goto 3f; if w9 == 0 goto 8f; 3: goto 2b;"
+     "4: if w8 <= w7 goto 1b; 8: call %[bpf_rcu_read_unlock];")
+
+/* May_goto at the head of the first loop goes to 7 with w9 = 1. The program gets there with 0. */
+NO_COUNT("more: a flag that is a constant without may_goto")
+LOOP(more_stale, "call %[bpf_rcu_read_lock];" RND "w4 = w0; w8 = 0; w9 = 0;"
+     "5: if w4 == 0 goto 6f; w9 = 0; if w4 == 1 goto 7f; w9 = 1; goto 5b; 6: w9 = 1; goto 5b; 7:",
+     "w5 = w9; w8 += 1; if w8 > 2047 goto 2f; w5 = 1;"
+     "2: if w8 > w7 goto 8f; if w5 != 0 goto 1b; 8: call %[bpf_rcu_read_unlock];")
+
 NO_COUNT("a flag, another way to the jump that counts")
 LOOP(flag_two_ways, "w8 = -2048;",
      "w8 += 1; w2 = 0; if r7 != 0 goto 3f; w2 = 1; 3: if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_need.c b/tools/testing/selftests/bpf/progs/verifier_loop_need.c
new file mode 100644
index 000000000000..281f94bfeb47
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_need.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A counted loop changes a number in a way that has no formula:
+ *	for (i = 0; i < 1000; i++) x = x * 3 + 1;
+ * The verifier can go through the iterations one by one to find out what x is. It does so only
+ * if something ahead looks at x: a jump, an access to memory, a call. Otherwise what comes back
+ * to the head of the loop is joined with what entered and widened: the loop is looked at
+ * a few times, however many iterations it has.
+ *
+ * What looks at a number is found ahead of the main pass, and it is a guess. A use that is missed
+ * rejects a program that would load after a walk. It never loads a program that is not safe.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* a map value of 64 bytes that holds nothing but numbers */
+u64 vals[8];
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+#define OK(text)	SEC("socket") __description("need: " text) __success
+#define BAD(text)	SEC("socket") __description("need: " text) __failure
+#define NOT_WALKED	__log_level(2) __msg("nothing looks at it")
+#define WALKED		__log_level(2) __not_msg("nothing looks at it")
+
+/* The read is not allowed */
+#define UNLESS(cond)	"if " cond " goto +1; r0 = *(u64 *)(r10 + 8);"
+
+/* r6 is 1 or 2, and is multiplied by 3 in each of @n iterations. @use comes behind the loop. */
+#define TIMES_3_IN(init, n, use)					\
+	asm volatile (							\
+	init								\
+	"call %[bpf_get_prandom_u32];"					\
+	"r6 = r0;"							\
+	"r6 &= 1;"							\
+	"r6 += 1;"							\
+	"r7 = 0;"							\
+"1:	r6 *= 3;"							\
+	"r7 += 1;"							\
+	"if r7 < " #n " goto 1b;"					\
+	use								\
+	"exit;"								\
+	:: __imm(bpf_get_prandom_u32), __imm_addr(vals) : __clobber_all)
+#define TIMES_3(n, use)	TIMES_3_IN("", n, use "r0 = 0;")
+
+OK("a number that is only stored is not followed")
+NOT_WALKED __msg("processed 17 insns")
+__naked void stored_only(void)
+{
+	TIMES_3(1000, "*(u64 *)(r10 - 8) = r6;");
+}
+
+OK("a jump looks at the number")
+WALKED
+__naked void jump(void)
+{
+	TIMES_3(5, UNLESS("r6 <= 486"));
+}
+
+BAD("a jump looks at the number, which is too large")
+__msg("invalid read from stack")
+__naked void jump_too_large(void)
+{
+	TIMES_3(5, UNLESS("r6 <= 485"));
+}
+
+OK("the number is an offset in a map value that holds numbers")
+WALKED
+__naked void value_offset(void)
+{
+	/* 27 or 54 */
+	TIMES_3(3, "r1 = %[vals] ll; r1 += r6; r0 = *(u8 *)(r1 + 9);");
+}
+
+#define VALUE_AT(reg, off)	"r1 = %[vals] ll; r1 += " #reg "; r0 = *(u8 *)(r1 + " #off ");"
+
+__naked __noinline __used
+static unsigned long value_at_plus_9(void)
+{
+	asm volatile ("r2 = r1;" VALUE_AT(r2, 9) "exit;" :: __imm_addr(vals) : __clobber_all);
+}
+
+OK("the number is an offset in a map value in a function")
+WALKED
+__naked void value_offset_argument(void)
+{
+	TIMES_3(3, "r1 = r6; call value_at_plus_9;");
+}
+
+__naked __noinline __used
+static unsigned long times_27(void)
+{
+	TIMES_3_IN("", 3, "r0 = r6;");
+}
+
+OK("what a function returns is an offset in a map value")
+WALKED
+__naked void value_offset_returned(void)
+{
+	asm volatile ("call times_27;" VALUE_AT(r0, 9) "exit;"
+		      :: __imm_addr(vals) : __clobber_all);
+}
+
+#if defined(__clang_major__) && __clang_major__ >= 23
+struct pair {
+	__u64 lo;	/* r0 */
+	__u64 hi;	/* r2 */
+};
+
+__naked __noinline __used
+static struct pair zero_and_times_27(void)
+{
+	TIMES_3_IN("", 3, "r0 = 0; r2 = r6;");
+}
+
+OK("the second half of what a function returns is an offset in a map value")
+__load_if_JITed() WALKED
+__naked void value_offset_returned_in_r2(void)
+{
+	asm volatile ("call zero_and_times_27;" VALUE_AT(r2, 9) "exit;"
+		      :: __imm_addr(vals) : __clobber_all);
+}
+#endif
+
+__naked __noinline __used
+static unsigned long times_27_there(void)
+{
+	TIMES_3_IN("r8 = r1;", 3, "*(u64 *)(r8 + 0) = r6; r0 = 0;");
+}
+
+#define TIMES_27_AT_FP_8	"r1 = r10; r1 += -8; call times_27_there; r2 = *(u64 *)(r10 - 8);"
+
+OK("a function stores the number in the stack of its caller")
+WALKED
+__naked void stored_for_the_caller(void)
+{
+	asm volatile (TIMES_27_AT_FP_8 VALUE_AT(r2, 9) "exit;"
+		      :: __imm_addr(vals) : __clobber_all);
+}
+
+OK("the number is an offset in the stack")
+WALKED
+__naked void stack_offset(void)
+{
+	/* fp-9 or fp-18 */
+	TIMES_3(2, "*(u64 *)(r10 - 8) = r7; *(u64 *)(r10 - 16) = r7; *(u64 *)(r10 - 24) = r7;"
+		   "r6 = -r6; r1 = r10; r1 += r6; r0 = *(u8 *)(r1 + 0);");
+}
+
+__naked __noinline __used
+static unsigned long times_9(void)
+{
+	TIMES_3_IN("", 2, "r0 = r6;");
+}
+
+/* fp-9 or fp-18, plus @off */
+#define STACK_AT_MINUS_R0(off)						\
+	"*(u64 *)(r10 - 8) = r0; *(u64 *)(r10 - 16) = r0; *(u64 *)(r10 - 24) = r0;"	\
+	"r0 = -r0; r1 = r10; r1 += r0; r0 = *(u8 *)(r1 + " #off ");"
+
+OK("what a function returns is an offset in the stack")
+WALKED
+__naked void stack_offset_returned(void)
+{
+	asm volatile ("call times_9;" STACK_AT_MINUS_R0(0) "exit;" ::: __clobber_all);
+}
+
+/* r6 is 1, and is multiplied by 3 in each of 2 iterations */
+#define NINE(use)							\
+	asm volatile (							\
+	"r6 = 1;"							\
+	"r7 = 0;"							\
+"1:	r6 *= 3;"							\
+	"r7 += 1;"							\
+	"if r7 < 2 goto 1b;"						\
+	use								\
+	"r0 = 0;"							\
+	"exit;"								\
+	:: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard),	\
+	   __imm_addr(ringbuf) : __clobber_all)
+
+OK("the number is part of a size that has to be a constant")
+WALKED
+__naked void constant_argument(void)
+{
+	NINE("r1 = %[ringbuf] ll; r2 = 7; r2 += r6; r3 = 0; call %[bpf_ringbuf_reserve];"
+	     "if r0 == 0 goto +3; r1 = r0; r2 = 0; call %[bpf_ringbuf_discard];");
+}
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+/* Nothing checks where a pointer to arena points to */
+OK("an address in arena is not followed")
+NOT_WALKED
+__naked void arena_address(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r6 = 1;"
+	"r7 = 0;"
+"1:	r1 = addr_space_cast(r6, 0x0, 0x1);"
+	"r0 = *(u64 *)(r1 + 0);"
+	"r6 *= 3;"
+	"r7 += 1;"
+	"if r7 < 1000 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(arena) : __clobber_all);
+}
+#endif
+
+/*
+ *	p = NULL; for (i = 0; i < 3; i++) { if (have) n += *p; p = &val; have = 1; }
+ * No jump and no add looks at p.
+ */
+OK("the base of a load is 0 in the first iteration")
+WALKED
+__naked void base_of_a_load(void)
+{
+	asm volatile (
+	"r6 = %[vals] ll;"
+	"r7 = 0;"
+	"r8 = 0;"
+	"r9 = 0;"
+"1:	if r9 == 0 goto 2f;"
+	"r0 = *(u64 *)(r8 + 0);"
+"2:	r8 = r6;"
+	"r9 = 1;"
+	"r7 += 1;"
+	"if r7 < 3 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(vals) : __clobber_all);
+}
+
+/* r8 goes on by 0 or 8 bytes. Nothing tells how far but the iterations. */
+OK("a pointer that moves is followed")
+WALKED
+__naked void pointer(void)
+{
+	asm volatile (
+	"r8 = %[vals] ll;"
+	"r7 = 0;"
+"1:	r1 = r7;"
+	"r1 &= 1;"
+	"r1 <<= 3;"
+	"r8 += r1;"
+	"r7 += 1;"
+	"if r7 < 14 goto 1b;"
+	"r0 = *(u64 *)(r8 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(vals) : __clobber_all);
+}
+
+/* The sets have 64 slots of the stack. What is deeper is followed. */
+OK("a jump looks at a slot below fp-512")
+__load_if_large_stack()
+WALKED
+__naked void deep_slot(void)
+{
+	asm volatile (
+	"r6 = 2;"
+	"*(u64 *)(r10 - 520) = r6;"
+	"r7 = 0;"
+"1:	r6 = *(u64 *)(r10 - 520);"
+	"r6 *= 3;"
+	"*(u64 *)(r10 - 520) = r6;"
+	"r7 += 1;"
+	"if r7 < 5 goto 1b;"
+	"r6 = *(u64 *)(r10 - 520);"
+	UNLESS("r6 == 486")
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The iterator is not a number. It is at its end after 3 of 5 iterations. */
+OK("a slot that holds an iterator is followed")
+WALKED
+__naked void iterator_slot(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 3;"
+	"call %[bpf_iter_num_new];"
+	"r7 = 0;"
+"1:	r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_next];"
+	"r7 += 1;"
+	"if r7 < 5 goto 1b;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_iter_num_new), __imm(bpf_iter_num_next), __imm(bpf_iter_num_destroy)
+	: __clobber_all);
+}
+
+/*
+ *	for (i = 0; i < n; i++) { if (i != skip) sum += prev; prev = (x ^ i) * 3; }
+ * prev is not set when the loop is entered. A compiler doesn't set what is not read.
+ */
+#define SUM_OF_PREV(skip, n, use)					\
+	asm volatile (							\
+	"call %[bpf_get_prandom_u32];"					\
+	"r6 = r0;"							\
+	"r7 = 0;"							\
+	"r9 = 0;"							\
+"1:	if r7 == " #skip " goto 2f;"					\
+	"r9 += r8;"							\
+"2:	r8 = r6;"							\
+	"r8 ^= r7;"							\
+	"r8 *= 3;"							\
+	"r7 += 1;"							\
+	"if r7 < " #n " goto 1b;"					\
+	use								\
+	"r0 = 0;"							\
+	"exit;"								\
+	:: __imm(bpf_get_prandom_u32), __imm_addr(vals) : __clobber_all)
+
+OK("what is not set at the entry is set from the second iteration on")
+NOT_WALKED __msg("processed 22 insns")
+__naked void set_in_the_first_iteration(void)
+{
+	SUM_OF_PREV(0, 40, "*(u64 *)(r10 - 8) = r9;");
+}
+
+BAD("what is not set at the entry is read in the first iteration")
+__msg("R8 !read_ok")
+__naked void read_in_the_first_iteration(void)
+{
+	SUM_OF_PREV(1, 40, "*(u64 *)(r10 - 8) = r9;");
+}
+
+/* What a call returns is made anew in every iteration, like what is loaded */
+OK("a long loop carries what a call returns")
+int call_in_a_long_loop(void *ctx)
+{
+	u64 sum = 0;
+	u32 x = 0;
+	int i;
+
+	for (i = 0; i < 20000; i++) {
+		sum += vals[x];
+		x = bpf_get_prandom_u32() & 7;
+	}
+	return sum;
+}
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_iter_num_new(0, 0, 0);
+	bpf_iter_num_next(0);
+	bpf_iter_num_destroy(0);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_walk.c b/tools/testing/selftests/bpf/progs/verifier_loop_walk.c
new file mode 100644
index 000000000000..1a6180aceacc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_walk.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A loop that is not counted is looked at iteration by iteration for a while: some thousand insns.
+ * Each such walk counts the insns that are looked at in it, not those of the walks next to it.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, char[2048]);
+} map SEC(".maps");
+
+/* 0 and 2 stay apart up to the jump that looks at them */
+#define SET(slot)								\
+	"call %[bpf_get_prandom_u32]; r1 = 0; if r0 == 0 goto +1; r1 = 2;"	\
+	"*(u64 *)(r10 - " #slot ") = r1;"
+#define TEST(slot)	"r1 = *(u64 *)(r10 - " #slot "); if r1 == 1 goto 9f;"
+#define PAD4		"r3 = r6; r3 += 1; r4 = r3; r4 += 1;"
+
+/*
+ * 32 states enter the loop one after the other. The counter has 8 bits, which has no formula. The
+ * offset is 1, 2, 4 ...: only a walk tells that it stays in the value. One walk takes 300 insns.
+ */
+#define WALKS(name, trips)							\
+__naked void name(void)								\
+{										\
+	asm volatile ("								\
+	r1 = 0;									\
+	*(u32 *)(r10 - 4) = r1;							\
+	r2 = r10;								\
+	r2 += -4;								\
+	r1 = %[map] ll;								\
+	call %[bpf_map_lookup_elem];						\
+	if r0 == 0 goto 9f;							\
+	r6 = r0;								\
+"	SET(16) SET(24) SET(32) SET(40) SET(48) "				\
+	w8 = 0;									\
+	r9 = 1;									\
+1:	r1 = r6;								\
+	r1 += r9;								\
+	r2 = 0;									\
+	*(u8 *)(r1 + 0) = r2;							\
+	r9 <<= 1;								\
+"	PAD4 PAD4 PAD4 PAD4 "							\
+	w8 += 1;								\
+	w2 = w8;								\
+	w2 &= 255;								\
+	if w2 < " #trips " goto 1b;						\
+"	TEST(16) TEST(24) TEST(32) TEST(40) TEST(48) "				\
+9:	r0 = 0;									\
+	exit;									\
+"	:									\
+	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm_addr(map) \
+	: __clobber_all);							\
+}
+
+SEC("socket")
+__description("walk: 32 walks at a time")
+__success
+WALKS(walks_32, 11)
+
+/*
+ *	for (i = 7; i >= 0; i--) { if (i >= n) continue; a[i] = 0; }
+ * A compiler tests 'i >= n' in front of the loop too and jumps into the middle of it. Such a loop
+ * has no count. It's walked to its end whichever way its jumps go: no may_goto is added.
+ */
+SEC("socket")
+__description("walk: a loop with two entries")
+__success __retval(0)
+__arch_x86_64
+__arch_arm64
+__xlated("w3 += -1")
+__xlated("if w3 s< 0x0 goto pc+2")
+__xlated("if w3 < w2 goto pc-6")
+__xlated("goto pc-4")
+__xlated("exit")
+__naked void two_entries(void)
+{
+	asm volatile ("								\
+	call %[bpf_get_prandom_u32];						\
+	r2 = r0;								\
+	r2 &= 7;								\
+	r0 = 0;									\
+	w3 = 7;									\
+	if w3 >= w2 goto 2f;							\
+1:	r1 = r10;								\
+	r1 += r3;								\
+	*(u8 *)(r1 - 8) = r0;							\
+2:	w3 += -1;								\
+	if w3 s< 0 goto 3f;							\
+	if w3 < w2 goto 1b;							\
+	goto 2b;								\
+3:	exit;									\
+"	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ *	for (i = 0; (u8)i < 11; i++) { if (!rnd()) break; v[1 << i] = 0; }
+ * One jump that leaves the loop goes both ways in each iteration, the other one is decided in
+ * each iteration: the loop counts. The walk goes on. Only a walk tells what the offset is.
+ */
+SEC("socket")
+__description("walk: goes on while an iteration decides a jump that leaves the loop")
+__success
+__naked void walk_goes_on(void)
+{
+	asm volatile ("								\
+	r1 = 0;									\
+	*(u32 *)(r10 - 4) = r1;							\
+	r2 = r10;								\
+	r2 += -4;								\
+	r1 = %[map] ll;								\
+	call %[bpf_map_lookup_elem];						\
+	if r0 == 0 goto 9f;							\
+	r6 = r0;								\
+	w8 = 0;									\
+	r9 = 1;									\
+1:	call %[bpf_get_prandom_u32];						\
+	if r0 == 0 goto 9f;							\
+	r1 = r6;								\
+	r1 += r9;								\
+	*(u8 *)(r1 + 0) = r0;							\
+	r9 <<= 1;								\
+	w8 += 1;								\
+	w2 = w8;								\
+	w2 &= 255;								\
+	if w2 < 11 goto 1b;							\
+9:	r0 = 0;									\
+	exit;									\
+"	:									\
+	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm_addr(map) \
+	: __clobber_all);
+}
+
+static __naked __noinline __used int zero_or_one(void)
+{
+	asm volatile ("								\
+	call %[bpf_get_prandom_u32];						\
+	r0 &= 1;								\
+	exit;									\
+"	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ *	for (i = 0; i < 2; i++) off += zero_or_one();
+ * A compiler makes a flag of i: there is nothing to count. Both trips are walked although the loop
+ * calls a function. Only a walk tells that off is 2 at most.
+ */
+#define TWO_TRIPS(name, size)							\
+__naked void name(void)								\
+{										\
+	asm volatile ("								\
+	r6 = 1;									\
+	r7 = 0;									\
+1:	call zero_or_one;							\
+	r7 += r0;								\
+	r1 = r6;								\
+	r6 = 0;									\
+	if r1 != 0 goto 1b;							\
+	r1 = r10;								\
+	r1 += r7;								\
+	r0 = 0;									\
+	*(u8 *)(r1 - " #size ") = r0;						\
+	exit;									\
+"	::: __clobber_all);							\
+}
+
+SEC("socket")
+__description("walk: two trips of a loop with a call")
+__success __retval(0)
+TWO_TRIPS(two_trips, 3)
+
+SEC("socket")
+__description("walk: two trips of a loop with a call, off by one")
+__failure __msg("invalid variable-offset write to stack R1")
+TWO_TRIPS(two_trips_off_by_one, 2)
+
+/*
+ *	while (rnd()) n++;
+ * The second iteration decides nothing. The walk gives up at once: less than 100 insns.
+ */
+SEC("socket")
+__description("walk: gives up when an iteration decides no jump that leaves the loop")
+__success __log_level(4) __msg("processed {{..}} insns")
+__naked void walk_gives_up(void)
+{
+	asm volatile ("								\
+	r6 = 0;									\
+1:	call %[bpf_get_prandom_u32];						\
+	if r0 == 0 goto 2f;							\
+	r6 += 1;								\
+	goto 1b;								\
+2:	r0 = 0;									\
+	exit;									\
+"	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ *	do { n++; more = rnd(); ... } while (more);
+ * A compiler keeps the flag. States with 0 and with 1 are not joined in front of its test, so the
+ * test is decided in each of them. That decides nothing: the walk gives up as above.
+ */
+SEC("socket")
+__description("walk: gives up when only a flag that went both ways decides the jump")
+__success __log_level(4) __msg("processed {{..}} insns")
+__naked void walk_gives_up_flag(void)
+{
+	asm volatile ("								\
+	r6 = 0;									\
+1:	call %[bpf_get_prandom_u32];						\
+	r6 += 1;								\
+	w7 = 1;									\
+	if r0 != 0 goto 2f;							\
+	w7 = 0;									\
+2:	w7 &= 1;								\
+	if w7 != 0 goto 1b;							\
+	r0 = 0;									\
+	exit;									\
+"	:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ *	for (off = 1; !done; off <<= 1) { v[off] = 0; done = off > 512; if (rnd()) n++; }
+ * done is known in every iteration. Another flag went both ways, and was tested before it: the
+ * walk goes on. Only a walk tells what the offset is.
+ */
+SEC("socket")
+__description("walk: goes on when the flag that leaves the loop is known")
+__success
+__naked void walk_goes_on_flag(void)
+{
+	asm volatile ("								\
+	r1 = 0;									\
+	*(u32 *)(r10 - 4) = r1;							\
+	r2 = r10;								\
+	r2 += -4;								\
+	r1 = %[map] ll;								\
+	call %[bpf_map_lookup_elem];						\
+	if r0 == 0 goto 9f;							\
+	r6 = r0;								\
+	r9 = 1;									\
+1:	r1 = r6;								\
+	r1 += r9;								\
+	r2 = 0;									\
+	*(u8 *)(r1 + 0) = r2;							\
+	w8 = 1;									\
+	if r9 > 512 goto 2f;							\
+	w8 = 0;									\
+2:	r9 <<= 1;								\
+	call %[bpf_get_prandom_u32];						\
+	w7 = 1;									\
+	if r0 != 0 goto 3f;							\
+	w7 = 0;									\
+3:	if w7 == 0 goto 4f;							\
+	r2 = 0;									\
+4:	if w8 == 0 goto 1b;							\
+9:	r0 = 0;									\
+	exit;									\
+"	:									\
+	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm_addr(map) \
+	: __clobber_all);
+}
+
+static __naked __noinline __used int long_loop(void)
+{
+	asm volatile ("								\
+	w3 = 0;									\
+1:	w3 += 1;								\
+	w2 = w3;								\
+	w2 &= 0xffff;								\
+	if w2 < 5000 goto 1b;							\
+	r0 = 0;									\
+	*(u64 *)(r1 + 0) = r0;							\
+	exit;									\
+"	::: __clobber_all);
+}
+
+/*
+ * The walk doesn't get to the end of the loop. The function is looked at three times, for three
+ * pointers. There is no walk the second and the third time: less than 10000 insns in all.
+ */
+SEC("socket")
+__description("walk: no other try for a loop that is too long")
+__success __log_level(4) __msg("processed {{....}} insns")
+__naked void walk_fails_once(void)
+{
+	asm volatile ("								\
+	r1 = r10;								\
+	r1 += -8;								\
+	call long_loop;								\
+	r1 = r10;								\
+	r1 += -16;								\
+	call long_loop;								\
+	r1 = r10;								\
+	r1 += -24;								\
+	call long_loop;								\
+	r0 = 0;									\
+	exit;									\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index d89ffe90c6bc..c1aede6fa4ae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -4410,6 +4410,136 @@ __naked void post_cond_jlt32_copy(void)
 	: __clobber_all);
 }
 
+/*
+ * The loop loads r6 again in every iteration. It's 0 at the entry and a byte in all iterations
+ * but the first one: the first iteration is verified on its own, the state that comes back to
+ * the head stands for the rest.
+ */
+SEC("socket")
+__success __retval(0)
+__log_level(2)
+__msg("header_count is 10 ")
+__msg("can't widen r6, expr is _")
+__not_msg("widening r8")
+__msg("clamping r8 to 0..9 step 1")
+__naked void index_loaded_in_previous_iteration(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r7 = r0;					\
+	r6 = 0;						\
+	r8 = 0;						\
+1:	r1 = r7;					\
+	r1 += r6;					\
+	r0 = *(u8 *)(r1 + 0);				\
+	r6 = *(u8 *)(r7 + 0);				\
+	r8 += 1;					\
+	if r8 < 10 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+/*
+ * What the first iteration makes of r6 is a guess about the rest. A byte in the first
+ * iteration, 16 bits in the others: the state that comes back to the head next is not within it.
+ */
+SEC("socket")
+__failure __msg("R1 unbounded memory access")
+__naked void first_iteration_loads_less(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 4f;				\
+	r7 = r0;					\
+	r6 = 0;						\
+	r8 = 0;						\
+1:	r1 = r7;					\
+	r1 += r6;					\
+	r0 = *(u8 *)(r1 + 0);				\
+	if r8 != 0 goto 2f;				\
+	r6 = *(u8 *)(r7 + 0);				\
+	goto 3f;					\
+2:	r6 = *(u16 *)(r7 + 0);				\
+3:	r8 += 1;					\
+	if r8 < 10 goto 1b;				\
+4:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+/*
+ * Every iteration takes a reference, only the last one is released. The state that comes back
+ * to the head of the loop has a reference that nothing holds.
+ */
+SEC("socket")
+__failure __msg("Unreleased reference")
+__naked void loop_takes_reference_every_time(void)
+{
+	asm volatile (
+	"r6 = 0;"
+"1:"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r8 = r0;"
+	"r6 += 1;"
+	"if r6 < 10 goto 1b;"
+	"r1 = r8;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard), __imm_addr(ringbuf)
+	: __clobber_all);
+}
+
+/*
+ * The first iteration that has something to say takes a reference, the rest use it. The state
+ * that comes back to the head has a reference more than the state that entered, once.
+ */
+__u64 nr_vals, vals[64];
+
+SEC("socket")
+__success __retval(0)
+int loop_takes_reference_once(void *ctx)
+{
+	__u64 *sum = NULL;
+	int i;
+
+	bpf_for(i, 0, nr_vals) {
+		if (i >= 64 || !vals[i])
+			continue;
+		if (!sum) {
+			sum = bpf_ringbuf_reserve(&ringbuf, sizeof(*sum), 0);
+			if (!sum)
+				break;
+			*sum = 0;
+		}
+		*sum += vals[i];
+	}
+	if (sum)
+		bpf_ringbuf_submit(sum, 0);
+	return 0;
+}
+
 /*
  * r6 is a pointer to ringbuf memory with a step of 1. bpf_ringbuf_discard() in the first iteration
  * makes a number of it. The offsets 0..1 of the pointer are not the range of this number: it's an
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index dbf6da950324..5a3893151f64 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -859,6 +859,61 @@ l0_%=:	r0 = 1;						\
 	: __clobber_all);
 }
 
+/*
+ * A list in a map value: it starts at element 0 and goes on with the element that the current one
+ * names. The offset is 0 in front of the loop and [0, 31] after every trip. The second of
+ * these states at the head of the loop stands for all that follow.
+ */
+SEC("tc")
+__description("map access: the offset of a value pointer grows in the first trip of a loop")
+__success
+__naked void loop_offset_settles(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10; r2 += -8;"
+	"r1 = %[map_array_48b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r2 = r6;"
+"1:	r5 = *(u8 *)(r2 + 0);"
+	"r5 &= 31;"
+	"r2 = r6; r2 += r5;"
+	"may_goto 2f;"
+	"goto 1b;"
+"2:	r0 = 0; exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("map access: the offset of a value pointer grows in every trip of a loop")
+__failure __msg("invalid access to map value, value_size=48 off=48 size=1")
+__naked void loop_offset_grows(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10; r2 += -8;"
+	"r1 = %[map_array_48b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r2 = r0;"
+"1:	r5 = *(u8 *)(r2 + 0);"
+	"r2 += 1;"
+	"may_goto 2f;"
+	"goto 1b;"
+"2:	r0 = 0; exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("map access: value_ptr += known scalar, 4")
 __success __success_unpriv __retval(1)
-- 
2.55.0

