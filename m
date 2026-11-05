Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911714;
	b=Ro2LS0lb9oQSUBNq0Kii2TxwxoOn4it3v7AoPQ9zUDR4uOrIK3VI+/aCOuma6+VORu+J
	 XZBJ/2pcXIzez4syGxcdBkxt+fplaXM8C/oXfNsYHSAk6yGoDl4WPWICL6EmgCNjYyaKV
	 Rq2NHf9a7W4ws8TSmlDOpQjk9GhWjf+FKjFYx3C/+ZW+E+MZI+Ll5w4EBsj8s9nYDX1bB
	 oU1VzgnsanaUsGk+kJDiqzkvJ+RECvdFqbt50kRxZGRjV9YPhl/m0SgwxWLvvOvmdchJ5
	 LByClCRXG1k+M89Vs2ANoD93CVtGReQTxy7OUEGTJvmr6/TrNeNgEjRwJaMP5Rpftiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d5oJuSHIoT4PP7+GsouNsm/BX7U0oNOQOxX5/080pDo=;
	b=K3pktN1w+E+utO2Un+g8ymjQIMaxCmirqJP6FN513LNjzu3/No+w54khcpWiVBfr+4ZI
	 GGCD9e6rQ+C3KdqdjiaEle+Whr9k6UkLTT3mYFkzJAYkm4xtULwdgtgMy+Pt8uNcgKEeU
	 XC9oZHc4YpJxj0niRlo1lkxpoOGvVVDX2Tyw/o70b/GP609fsZs8wTzWkp9Q9xG24kDL0
	 22h9dj0+xi3QtuYklGbsGG/PnKAP7tERNn2oyGmYBZzpWK+OIfjo8+HWGZhacebG4Gk/i
	 A+r6ogG0KgmBz2XQLIsEAN0KRM3sWQlRiT0gMp0ANm3miU1aDBNIcBG/U6J391Q3mWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjpJJBS3;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33905606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33905606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjpJJBS3
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1466881a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911712; x=1794516512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5oJuSHIoT4PP7+GsouNsm/BX7U0oNOQOxX5/080pDo=;
        b=bjpJJBS3Npkdu4E6hHZcjIV2tsFeB4s6MdXoEXCd2fuiOuLOxCv0XEUMUsvLs6sWBe
         sqT+6xmX8mP+EJyz5q9qHi/LtaHjr2vP7HPRDNpOFUc+ge0f10fEqCh63fi7KHlTK6ww
         IMBGeZC9S3/WwTGFH6pW0YuK1TFIVMRcbW3I1h94+B/WzDeWeNgOEc1YyaMad69hRpLC
         Gh1iAIoZIrzN46M+ec6xZGuPDlpt+ZzXyQWIaqL1q6Zv0tbKZsghIsQCN9NFXfxipsCV
         YdYFpBH+WePD5WpcMVSeP8XmTp3kII6SbvwnL4FG+SqblfhDopZhFMPWuyBXkZ7RrqrH
         JohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911712; x=1794516512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5oJuSHIoT4PP7+GsouNsm/BX7U0oNOQOxX5/080pDo=;
        b=TAcCg42EnXuXT7Iji2KxnDmu1OGLHXmEVeGTG1TE0kXVrFAC8rlvWn8zUDXx+mqDDH
         ydLvh8YCWmJn2XeZX5y9AcBU+ZGnu3Am/tr67MeAEDgnvLSnTOQS0qluMyhilQ+/NU5V
         wErXdfoXQgCvSg1CB2BfsKArnVTRBLIFSdAftzZ8gcv/zUdzf5ll+YG7ezHr2ZAdjVhR
         Y05PdozhI+40CTblyN6jkyP3F7PSZNDmhkt+AIcOtMhQmVxHg/+EdP7vVqmyoRf57681
         jzT9109rLzxNTndMrGR8HB/c9ZIkfNk1n8BA6cBiLOA23uF2+IQUQMYsL3KiHwWa0Op6
         Brrg==
X-Gm-Message-State: APuU4Z9wNcs+nkZlILzrp/lltyyEtVCvHIOFZHEp9DTghu9tZkyfvmK0
	Bgb1ZXJyNQueZ9Ygf1dwyOSNiPyZ6KaQqEH3+JH4qNoLGIryop1XD61AEWrA9w==
X-Gm-Gg: AYBFou2fM6wdrDV4hi2w8bBMS8d1tzDyKntEcV7ciJH3FRjREe6DE0JRE06jS1WZ9U9
	EiT8lCLPOhEaXNNh1yCJxJHVkB8AvT6u+gdoY11S3TeFDcKy3wwvKfUNMNNeCrgjUcJEBt/ykYv
	ph668sVy+LuXjf6QchFwY2PtCNn1hyjbjCc1E49xXUCCraNHJVpcd+OenSQpPGF4REHWbpGgQFg
	yxIbx/I3FFw3kXsxmih26+TPhftRlB0DBfJNo7uygC0KC4nVujzXr6/CvJT2vQwomHT4vliqFas
	G4C+4oNu0eYn2LUdTm82aLiu9K6ltdY99ciMn+8kmRcnGOVIwiPu2//WGzP3P8S4MxBEfTYeyjL
	tLZVO5i4tDjT9y1lYAUGmd+yNOoCg8j7dp8Fe4jKwqb00Hnm6aZc3pDiFH6lau1Tfk76Cod47XM
	uHCpAeruQ9TjcdElXp5nTIbUDMnN/j33pa0eXVijAortu8G9Df0cNEOf7f/JTUq1/p5QkZcNwPm
	j9/6OIaMYZ6y+UYQk2E14X5g1fdYFhYkpdpAlLqUw22cm1cpxOLzg46otmQpKCpAvPA+Eyik0Rn
	0qL9pACbrRrCm96sYwZORDgNB2gNI+U6uhLACsPGaOggUMOLoMBhdFJupko5yLhCfHxKy6dQJtx
	KkTx+C4SVKVfURWoVlqldvuD7H0bB10cvRUeHE/HQ83450+t3IU7QkaV0uVYlCaltkBtIe8qCgQ
	==
X-Received: by 2002:a17:90b:4a89:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b0db6f8424mr205332a91.54.1793911712030;
        Thu, 05 Nov 2026 12:48:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b2cf80c9sm5280995a91.0.2026.11.05.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:48:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 33/35] selftests/bpf: Test loops that are counted, walked or widened
Date: Thu,  5 Nov 2026 20:45:10 +0000
Message-ID: <20261105204513.2230344-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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
   each register that has a closed form. The body is verified one time.
 - Walked: iteration by iteration, with the real values.
 - Widened: what returns to the head is joined with the state at the head.
   A bound that grows moves to a fixed stop, until nothing changes.
The wrong method rejects a valid prog or costs thousands of insns. A wrong
state at the head loads an unsafe prog.

  [W] "bpf: Add union and widening of the range of a register"
  [J] "bpf: Add join of registers and stack slots"
  [A] "bpf: Find the registers and stack slots that later checks depend on"
  [M] "bpf: Move states along edges, into loops and subprogs and out of
      them"
  [L] "bpf: Enter and leave loops in the main pass, build flow.c"
  [C] "bpf: Keep the count of a loop when a register has no closed form"

  verifier_..        the loop                     the verifier must
  -----------------  ---------------------------  -------------------------
  loop_need.c        is counted, 'x = x * 3 + 1'  [C] walk it if a jump, an
                     has no closed form           access or a call ahead
                                                  depends on x ([A]), else
                                                  verify it one time
  loop_as_is.c       is not counted               [M] join the state that
                                                  ends a walk with a state
                                                  of this walk only
                     'if (..) n--', from 3        [W] stop n at 0
  loop_walk.c        has two entries (bpfjailer)  [L] walk it to its end
                     each iteration decides       [L] go on with the walk
                     a jump that leaves the loop
                     'while (rnd()) n++'          [L] give up at once
                     32 states enter, each needs  [L] count the insns of
                     a walk of 300 insns          each walk, not of all
                     is too long for a walk       [L] not try it again
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
 .../bpf/progs/verifier_iterating_callbacks.c  |  53 +++
 .../selftests/bpf/progs/verifier_loop_as_is.c | 198 +++++++++++
 .../selftests/bpf/progs/verifier_loop_need.c  | 320 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_loop_walk.c  | 197 +++++++++++
 .../selftests/bpf/progs/verifier_scev.c       |  59 ++++
 .../bpf/progs/verifier_value_ptr_arith.c      |  55 +++
 7 files changed, 888 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_as_is.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_need.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_walk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a57744663e99..1424dc3036c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -83,7 +83,10 @@
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
@@ -284,7 +287,10 @@ void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
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
index 000000000000..0316da3003ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_as_is.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The state that enters a loop that is not counted is left as it is. So is the state that ends
+ * a walk through the iterations of such a loop. What stands for many iterations is a join of states
+ * that were seen, not a guess that is written into one of them.
+ */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_need.c b/tools/testing/selftests/bpf/progs/verifier_loop_need.c
new file mode 100644
index 000000000000..d13030f766bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_need.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A counted loop changes a number in a way that has no formula:
+ *	for (i = 0; i < 1000; i++) x = x * 3 + 1;
+ * The verifier can go through the iterations one by one to find out what x is. It does so only
+ * if something ahead looks at x: a jump, an access to memory, a call. Otherwise x is not
+ * known in the loop and behind it, and the loop is looked at once.
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
+NOT_WALKED __msg("processed 11 insns")
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
index 000000000000..f3e24fdfe12d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_walk.c
@@ -0,0 +1,197 @@
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
index 5e566933f7e4..a6a99afad3c3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -4411,6 +4411,65 @@ __naked void post_cond_jlt32_copy(void)
 	: __clobber_all);
 }
 
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
index f9ad07704578..260cbc22fbc4 100644
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

