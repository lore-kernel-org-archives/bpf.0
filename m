Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749453;
	b=W4zOJzNiBPw0iPSYiYDQEnpC8BkcDH/RNgN5qHfVUeasBTaOgDJAJh3NLUenqNjV45xn
	 HyAs/Mv7CkJ+3AJ0PVwEKXDs6YLNaDqVVtMD/AReGojqP6uAy1eWpOC1ZToMwFElHPQJ/
	 kyBZrmHKfhA/JTDlfh4rglogO46VXteGZzPImDzZ9VVTX1CODRIVBfflBNCGLXSSaCS42
	 uR2oz8Pe8N8FP42D57kuXK2r07Tr67YeaesCU9WAve6midaZ2xizQhC+0W4/gxiyLDpeh
	 wHzwbbTd/MQi+/IuA8Tb0c1w+4ndXKw6KbBxAb0Fowr0n4E0wsMxUlvkmWu4ug74TDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y/X3xCyeNL517/98jghL+kjSv3V0O5V53SUmE4Knfjw=;
	b=Z1M+4u4i/aLi1Uw81kbBYKSSfVBwNQHkipe6o/AMraGniD6T5f+FXMgR3bfmgiNue+na
	 v9LGdJOXCAgaUzUlMnicpfnjC2ZNM0ttGEX/WFaO2V2F7r6wkrrNAN0wrnkro5dIULbQn
	 qOq7NNlPpoJT5N09ieVjDs4p//7wFHVCHpMlBBGObM0hmx3gjWfpB+AmQdKgFWUEOdu/J
	 Phg4+jaaWSt2YAzbZh+btnzlGvXw3TGFDrq3p2ZOiuPfwtuOT1226Q2a+s9b2h17jAp/7
	 Xw04lUztUnn8iTDfO0sUvYe60skWWYMzgL9Jhbf/hCXlbpoLypZmxITRg1w+Tu4WZwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A/C8rLKb";
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0997606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0997606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A/C8rLKb
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e985106c0cso809385ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749452; x=1794354252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y/X3xCyeNL517/98jghL+kjSv3V0O5V53SUmE4Knfjw=;
        b=A/C8rLKbhWOv/KLBuTztRFei+cVZ9gMoqy9kvR3JtKgu73zsK6PXkV+wNhwht4WpwZ
         6zs1HkyikbTuPWzOp8nc4X3zP7SuP9CPDSWS4RmOeM0onvUXqJ67DCwE5i+R+6Iw/UFO
         E0QJIGvqcs9um5RgyajMAyQpOFFYwgyXc5F2AJGw/6ZjqkM9NfHDt5vLYgifUxLTYEK/
         DHJjlQJy1LgyK3x+cXoUzxW4tEQuSBc2FSK3yFRuoOFKDpgyuhiF80ED0HzEUKBNOKsq
         rjlZ/yoER6U02woJ2kX9vNwPUuO2JbI2F5pmXZNwjvIV40veLOQdkF+fZR5YUnXz8iAN
         hndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749452; x=1794354252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/X3xCyeNL517/98jghL+kjSv3V0O5V53SUmE4Knfjw=;
        b=FJTDq4EHtcL4bpxvPCcdJ2SDq/kMjZCk53kK109eDIG3Ebl2binXRcLZUoSlGqZIuT
         Zmr8VwIWXuJg9PJtvHiMB8A07KWOfq7xvesNC6OYhBEViGXNqn8xKW3rk6BvveOeF+rP
         QJEOpZoipWEYh/5bSBUtqwIOWus5s06pp9M6YAjjairgNxD6RQW/fznwh+TFhQ5/DlMp
         VtU/Tt9QucCusJEephz/K4QFndCbsxX0iT0IR2ICRo9YHk6FxJsrmatvWvYLyL6Hb7/x
         OcI4+XA4rkWkwlNZOy+PPSDz0nc8zroqXwvSwencZUc2qxOwZrzs5Lz9TKJmMZUInDBT
         G5NQ==
X-Gm-Message-State: APuU4Z/VUf2FKrhH7Bv1ewSX44hXsd2xPX8qEtExqzkRtaVSCvX7xjGO
	yi1GiWOBH/MwFBA+I1MPowxPo+rDaPOhWRT5uXhEQ59YQw6mQoZtRxmXLl2GOA==
X-Gm-Gg: AYBFou1t/ts/w9J2N+++E1Cj6OD0SbtE/xlmLcBUbiKcdn8wBhrePr++lIEFbcsygOC
	yhN8G0Wvacc0SyyNLt6QcYShOBofu4wJyyQ5pw4zAoShgiqh/qk5sxZL/ufacQ1HpwSaz7NpL+A
	4bOSw+JzDFWIjGyU2nIM3BHPDjtUTQ1DTtTO61qkIjv7yRAGGBWm6xcDwM5lsUhEit0zgS8dj0R
	aTm3OwRgqENrZ9QvuPqmC2l9M1XZ0naSrh9vSgkq3LSM33PE4FUg0DuSLpZg1ywvME7e+u2DacK
	Ga/GTj/AFD+NzG1iROfGPiAjFsUrLR8951c9cdxd0OxxMhBUNFUn0jAW4+yX+BV82P2rn7L+RgZ
	kym5Tm6vFtMdRaDX7Qrm6KNYQ8BnmR0ts+gWTUZ4ZEkq5ewvpWt72PkP2iARAwCbxNAyar3Qxjh
	1O9tQgeW8O7m26/3uxg/v2gtN6p0F/rICttedt7eADWj0hIdiROCzAui2NG1yYAIJDk8fpavbrT
	ZjlOuC5dOHT13bscsglb/d8vMC927ThgyMzhHgrVH6G01W6zCqBTDtQUHdR8cfL/aACqUqzJVD+
	2flyXSEIDn0KwdxTeZvmzwrPOIzxlkgX9BporCs+fLpb+JlmrecEc0d4pT4W6FUHltiPB89Jw6M
	LiedibSmk7get21/YYtTe/E4FLXBHrvR1arGBT6pWABsUEoUmmcoVpi+045imgNlus+Kji3pEZQ
	==
X-Received: by 2002:a17:903:b50:b0:2e9:7b4f:b994 with SMTP id d9443c01a7336-2eb364d67bdmr122343365ad.33.1793749452011;
        Tue, 03 Nov 2026 15:44:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0906cad4sm374205ad.33.2026.11.03.15.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 31/37] selftests/bpf: Test more latches of counted loops
Date: Tue,  3 Nov 2026 23:40:56 +0000
Message-ID: <20261103234104.208239-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

verifier_loop_latch.c has the latches in the forms that a compiler makes.
Each iteration stores a byte to a map value of 2048 bytes and moves the
pointer by one. The progs that load expect the count in the log. In the
progs that the verifier must reject, a store is behind the value at run
time.

 - The latch is false in the first iteration, for a constant and for all of
   a range, next to a second exit with a count of 4 billion. The same with
   two iterations. A latch that compares pointers, also with the first one
   in front of the value.
 - '!=' in 32 bits, down to -1 and up to 0: 2048 iterations, and one too
   many.
 - One unsigned test on a counter that goes down: in 32 and 64 bits, from a
   constant and from a range, and one iteration too many. Two loops that do
   not end below 0: a 64-bit jump on a 32-bit counter with a bound above
   32 bits, and a second back edge under a signed 64-bit jump.
 - The latch tests a flag: alone, with a store next to it, with a call
   between the two jumps, and one iteration too many. In 5 progs the loop
   goes on when the counter gets to 0: a call overwrites the flag, the flag
   is set again, is changed, is set again on one of two paths, or there is
   a second way to the jump that counts.

verifier_scev.c:
 - pre_lt_dir_high goes down under an unsigned test and starts above
   S64_MAX, where the rule does not hold.
 - 5 rows for '!=' across 0. A step that misses the bound and the way from
   4 up to 1 have no count.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_loop_latch.c | 165 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_scev.c       |   9 +
 3 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_latch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a771dfbaeb3f..574b06c383fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -78,6 +78,7 @@
 #include "verifier_liveness_exp.skel.h"
 #include "verifier_load_acquire.skel.h"
 #include "verifier_loop_hierarchy.skel.h"
+#include "verifier_loop_latch.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -272,6 +273,7 @@ void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
 void test_verifier_loop_hierarchy(void)       { RUN(verifier_loop_hierarchy); }
+void test_verifier_loop_latch(void)           { RUN(verifier_loop_latch); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
new file mode 100644
index 000000000000..1fcefce9ab01
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The jumps that tell how many iterations a loop has, in the forms that a compiler makes of
+ *	for (i = first; i < N; i++)	from the last index
+ *	for (i = N - 1; i >= 0; i--)	while (n--)	for (j = N - 1; j >= 0 && j < N; j--)
+ *
+ * Each iteration stores a byte and moves the pointer by one. The value has NR bytes. The programs
+ * that load expect the count in the log. In those that have to be rejected a store is behind the
+ * value at run time.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define NR	2048
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, char[NR]);
+} map SEC(".maps");
+
+#define OK(text, count)								\
+	SEC("socket") __description("latch: " text) __success __log_level(2)	\
+	__msg("header_count is " count)
+#define BAD(text)								\
+	SEC("socket") __description("latch: " text) __failure __msg("invalid access to map value")
+/* the pointer goes on and on */
+#define NO_COUNT(text)								\
+	SEC("socket") __description("latch: " text) __failure
+
+/* r6: the value, r7: a number that is not known. @init, then the loop. */
+#define LOOP(name, init, body)							\
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
+	call %[bpf_get_prandom_u32];						\
+	w7 = w0;								\
+" init "									\
+1:	r1 = 0;									\
+	*(u8 *)(r6 + 0) = r1;							\
+	r6 += 1;								\
+" body "									\
+9:	r0 = 0;									\
+	exit;									\
+"	:									\
+	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm_addr(map) \
+	: __clobber_all);							\
+}
+
+/*
+ * From the last index the latch is false in the first iteration. That is a count. The other way
+ * out of the loop has one too: 4 billion.
+ */
+#define UP_TO_8	"if r8 >= r7 goto 9f; r8 += 1; if r8 < 8 goto 1b;"
+
+OK("false at once, and another exit", "[0..1]")
+LOOP(false_at_once, "r8 = 7; r6 += 2047;", UP_TO_8)
+
+BAD("two iterations, and another exit")
+LOOP(false_in_second, "r8 = 6; r6 += 2047;", UP_TO_8)
+
+OK("false at once for all of a range", "[0..1]")
+LOOP(false_at_once_range, "r8 = r7; r8 &= 3; r8 += 7; r6 += 2047;", UP_TO_8)
+
+BAD("false at once for all of a range but one")
+LOOP(false_at_once_range_bad, "r8 = r7; r8 &= 3; r8 += 6; r6 += 2047;", UP_TO_8)
+
+/*
+ * The latch compares pointers. One byte in front of the value is less than a byte in it,
+ * although -1 is a large unsigned offset: the latch is true in the first iteration.
+ */
+#define PTR_UP(off)	"r8 += 1; r1 = r8; r1 += " #off "; if r1 < r9 goto 1b;"
+
+OK("pointers", "8")
+LOOP(ptr_up, "r8 = r6; r9 = r6; r9 += 8; r6 += 2040;", PTR_UP(0))
+
+BAD("pointers, the first one is in front of the value")
+LOOP(ptr_up_from_below, "r8 = r6; r9 = r6; r9 += 7; r6 += 2040;", PTR_UP(-2))
+
+/* an int goes down to -1, or up from -N to 0: the distance is a 32-bit number */
+#define DOWN_TO_M1	"w8 += -1; if w8 != -1 goto 1b;"
+#define UP_TO_0		"w8 += 1; if w8 != 0 goto 1b;"
+
+OK("down to -1 in 32 bits", "2048")
+LOOP(down_to_m1, "w8 = 2047;", DOWN_TO_M1)
+
+BAD("down to -1 in 32 bits, one too many")
+LOOP(down_to_m1_bad, "w8 = 2048;", DOWN_TO_M1)
+
+OK("up to 0 in 32 bits", "2048")
+LOOP(up_to_0, "w8 = -2048;", UP_TO_0)
+
+BAD("up to 0 in 32 bits, one too many")
+LOOP(up_to_0_bad, "w8 = -2049;", UP_TO_0)
+
+/* 'j >= 0 && j < N' is one unsigned test */
+OK("down, one unsigned test", "2048")
+LOOP(down_unsigned, "w8 = 2047;", "w8 += -1; if w8 < 2048 goto 1b;")
+
+BAD("down, one unsigned test, one too many")
+LOOP(down_unsigned_bad, "w8 = 2048;", "w8 += -1; if w8 < 2049 goto 1b;")
+
+OK("down, one unsigned test, 64 bits", "2048")
+LOOP(down_unsigned64, "r8 = 2047;", "r8 += -1; if r8 <= 2047 goto 1b;")
+
+OK("down from a range, one unsigned test", "[0..2048]")
+LOOP(down_unsigned_range, "if r7 > 2047 goto 9f;", "w7 += -1; if w7 < 2048 goto 1b;")
+
+BAD("down from a range, one unsigned test, one too many")
+LOOP(down_unsigned_range_bad, "if r7 > 2048 goto 9f;", "w7 += -1; if w7 < 2049 goto 1b;")
+
+/* below 0 a 32-bit counter is 0xffffffff for a 64-bit jump */
+BAD("down, a 64-bit test with a bound above 32 bits")
+LOOP(down_unsigned_wide_bound, "w8 = 2047; r9 = 0x100000800 ll;", "w8 += -1; if r8 < r9 goto 1b;")
+
+BAD("down, an unsigned and a signed 64-bit test")
+LOOP(down_two_tests, "w8 = 4; r6 += 2043;",
+     "w8 += -1; if r8 < 5 goto 2f; if r8 s>= 5 goto 1b; goto 9f; 2: if r8 < 5 goto 1b;")
+
+/* 'while (n--)': the jump that counts sets a flag, the jump that leaves the loop tests it */
+#define FLAG(mid)	"w8 += 1; w2 = 1; if w8 == 0 goto 2f; w2 = 0; 2: " mid " if w2 != 1 goto 1b;"
+
+OK("a flag", "2048")
+LOOP(flag, "w8 = -2048;", FLAG("r3 = r6;"))
+
+BAD("a flag, one too many")
+LOOP(flag_bad, "w8 = -2049;", FLAG("r3 = r6;"))
+
+OK("a flag, a store behind it", "2048")
+LOOP(flag_store, "w8 = -2048;",
+     "w8 += 1; w2 = 1; *(u32 *)(r10 - 4) = r8; if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
+
+OK("a flag, a call behind it", "2048")
+LOOP(flag_call, "w8 = -2048;",
+     "w8 += 1; w9 = 1; if w8 == 0 goto 2f; w9 = 0; 2: call %[bpf_get_prandom_u32]; if w9 != 1 goto 1b;")
+
+/* in these the loop goes on when the counter gets to 0 */
+NO_COUNT("a flag that a call overwrites")
+LOOP(flag_call_r0, "w8 = -2048;",
+     "w8 += 1; w0 = 1; if w8 == 0 goto 2f; w0 = 0; 2: call %[bpf_get_prandom_u32]; if w0 != 1 goto 1b;")
+
+NO_COUNT("a flag that is set again")
+LOOP(flag_set_again, "w8 = -2048;", FLAG("w2 = 0;"))
+
+NO_COUNT("a flag that is changed")
+LOOP(flag_changed, "w8 = -2048;", FLAG("w2 &= w7;"))
+
+NO_COUNT("a flag that is set again on one path")
+LOOP(flag_other_jump, "w8 = -2048;", FLAG("if r7 != 0 goto 4f; w2 = 0; 4:"))
+
+NO_COUNT("a flag, another way to the jump that counts")
+LOOP(flag_two_ways, "w8 = -2048;",
+     "w8 += 1; w2 = 0; if r7 != 0 goto 3f; w2 = 1; 3: if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 5cc886b92913..07c356fde68d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -877,9 +877,12 @@ PRE__COND_TEST (pre_ne_false,      "==",                 7,            2,
  *    while (++r9 <= 8 && r6 < 7) {  // r6 ∈ [5,3,1,U64_MAX]
  *        r6 -= 2;                   // r6 ∈ [3,1,U64_MAX]
  *    }
+ *
+ * From above S64_MAX it's a long way down.
  */
 PRE__COND_TEST2(pre_lt_dir,        ">=",                 5,           -2,                7, "header_count is [0..4] ")
 PRE__COND_TEST2(pre_le_dir,        ">",                  5,           -2,                7, "header_count is [0..4] ")
+PRE__COND_TEST2(pre_lt_dir_high,   ">=",  ITER_S64_MIN + 5,           -2, ITER_S64_MIN + 7, "can't compute iterations count")
 
 /*
  * The counter moves away from the exit; bound fallback verification.
@@ -1011,6 +1014,12 @@ POST_COND_TEST32(post32_le,        "<=",                   -9,    2,
 POST_COND_TEST32(post32_gt,        ">",                    -1,  -2u,               -7, "header_count is [0..3] ")
 POST_COND_TEST32(post32_ge,        ">=",                   -1,  -2u,               -7, "header_count is [0..4] ")
 POST_COND_TEST32(post32_ne,        "!=",                   -1,  -2u,               -7, "header_count is [0..3] ")
+/* across 0: in order as signed numbers. From 4 up to 1 goes all the way around. */
+POST_COND_TEST32(post32_ne_to_m1,   "!=",                    3,  -1u,               -1, "header_count is [0..4] ")
+POST_COND_TEST32(post32_ne_to_0,    "!=",                   -4,    1,                0, "header_count is [0..4] ")
+POST_COND_TEST32(post32_ne_to_m1_2, "!=",                    3,  -2u,               -1, "header_count is [0..2] ")
+POST_COND_TEST32(post32_ne_miss,    "!=",                    4,  -2u,               -1, "can't compute iterations count")
+POST_COND_TEST32(post32_ne_around,  "!=",                    4,    1,                1, "can't compute iterations count")
 
 /* An exit exactly at S32_MAX is accepted as well. */
 POST_COND_TEST32(post32_slt_max,   "s<",        INT32_MAX - 6,    2,        INT32_MAX, "header_count is [0..3] ")
-- 
2.55.0

