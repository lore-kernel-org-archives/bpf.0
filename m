Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749429;
	b=jkwxnnioluxanes17yfNfR9Dx8E+/8kfOSsC4l9/y1FZGCfdLoKciuQiOdnDMfjXKiiQ
	 nzGE+luHhFMIRsh06TLlVyEiPr0yZgcghxvlOPkc3hpkndggGFo2K1TcxjmliZOgV7ISK
	 XCJOTO/aGmVWfEPMXC4fGYrkvoa/8p7EKJHCWN3NFCR/di8ZBQzh4l3osjEbyb0iEV2PT
	 /QU2AP2J7JCty2f8JzIduaJWo/w+OmCDZg+Z9efoBPXBouChAbc0oO72e2uffQV/cLfzW
	 XQAryFSVKf1qzl4g6RpP1xICs4D/p40KnGoRtzT7+zKxes+b955D7oFyfmypuhllfDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UmmQRlWiThWPUsUUM4dLjM9FgilSc8m9c1F/r1sfyVs=;
	b=yf4XGQCLaOAHK7S/LHNo5bQFclCKjhfz7osYHEv+r1A5IF/0UMaUUxTMGo8kWfLbNJqR
	 d0pAnjcY32Bxjwg4uu31qcv7EggJrzoPoVU2njQC0lsXmBGc08OF2jt/bI+cLfw0Zz63P
	 es1GadWWJeB0cbowiFmf7dm/wrVXQNi44DRwPI8nEBxsCbJU4H9l829I4G6wTC2xoCd9N
	 /D5xa5WdDy1rJqkE+MPdXE/bqpU8X0MNlnuHp8j3xNF+NhVdLjV3Rq3hSaWlCjN36m2Rr
	 Ge8c86CZWIW+69GyEzhEWTggifPVbw2YTmTIBh+yQ5A2KlsZlFyxi/1PdVtHSONjPhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yp/L3oGn";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2F606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D2F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yp/L3oGn
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so78771a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749428; x=1794354228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmmQRlWiThWPUsUUM4dLjM9FgilSc8m9c1F/r1sfyVs=;
        b=yp/L3oGnmfy7WioKhETAfrJcVdk45gHLtTLLzugdpl2jFGBk4k6NXUVnY/iiBw45nk
         DfmLzS3yGB7kHWa3AOeb2aQf07As3ETNBo7CuVWUwH8q72O+Q4JPj14JDyjwJ8v+MrJs
         Ok7hMkRcKYBUhMxvhwRDuKt4W/t7SY+D2GS2rK6PICNgj6BpqSFNHeejKtBf5WjfG3Pi
         HaXyyLE2IIUnK/FhbSlYvyXbt8Hrti0MF/rKD0YxjoA4IpB7sDzPl/dB7QonB99quBZo
         /Qxgr/WcsuT8tvkLLirYoWDTIjToJ6gSRKMtPyHBVGNMGQqdBDkMK+q8pHvJV9ATgU2S
         oz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749428; x=1794354228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UmmQRlWiThWPUsUUM4dLjM9FgilSc8m9c1F/r1sfyVs=;
        b=cKPvB2SnrEf8Bljd/5CMLhUTVJn/ZrM1qq7YOaliZMhTLnNNnXrE3F+lKax3uFyQDV
         5ClwGfQ7SHsxz8jamrIHIbqBiBKd4r2rOSaNdOOCglkHDlzNsVqCM3LWLHsegjb4pcyg
         tGzrRWCTGrq/FQJUDtOV/SWqVVILBoUMxxIvgJQDtg7NCw5Ejt5+6wFOLqGaEgdK6s8w
         ODkSs9RKazzrCPSFLp4bbiYP8wL9SXVoZ3LjLInxn4oHxmBLgguHZOWeRZnrXUMW2870
         8EoiXNYIsiIZSkrEF5FzhYn/3Lm5BWcDJ95N1dc8DPRpkGvhkMhwxgG+yvbnlvamCKoO
         RDhw==
X-Gm-Message-State: APuU4Z9fDKDDy3xiZb5jIXFm/qdv7f26Llz8ttvmPKo1kyJ3DEsZwpQ3
	R5B9d/6NjUbepfS5MNaSQbfUTrKO4u5T1e0RRey/RNuf6q4rE5W5SoHgR9G+1g==
X-Gm-Gg: AYBFou1C0P0EICsoDI2tT9QK5ZvAhemFu+ai+CeSDOlqdnDSrPe4XDE4EG4xgwuGU2i
	P8Wp6/cXEfUghunSBVPArJ5FbqUfz9ivUFvJqQzZQ4iFWRjrJ/yeP8yDV3vvMdgcp0gdgOlxd5T
	yCroZ/PO89/aP53RsXhWDRHnAjkQZylakMbkUZnPfadN+402ha2iqvHIULSbCaSoMluOt96kvR/
	u89B9qnKGaB8t/W7xJ+GFYBcm4eq5WtzQt50qsgjzNRZ9dVm3JkKYAbgIP71BqVtOf91iOrbq8a
	5edmcnPvYq3RURVycEzBesuLRPu2mBS0bbJLNNXudEeeQsZDXRmiXuinbha1xhG+mFGwHFi3vP0
	Zz2cSKApyKZ7HRJrbX3ROYipe2nkiXx9R6XrYmlbD0VPvZYQEuEFmPJGtz8zX+KnuI4jT4uvUg0
	ypAJvjp0s1ZXAybn7qDfUYaAAH96zB7D5oUpp//p12xyXVdL3R3Q3T1xXADSTY99DoKhyUp03zr
	TkTqbC95R8tSPbY0bz3ZD58hjdK6VI8SMxsEY2mwipIeYOZNm5VSi9JDWSR36H+8oCqDtl/uGya
	eM/nbS4kH/uWYDAlb878Pm8pTCW3KCNQr+nj77KOHv0WjuO/iVyi33Bizpv59Jj0LBKY48ZgPq7
	57cxA60q7cot1TyDpZA+qzsUJYM5sI2faHD+h5eu+sC9LHzWDosNsy8Sl4lwjAe0/z+3r/6Vv11
	s=
X-Received: by 2002:a17:90b:4a11:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3ae896f8539mr11194915a91.18.1793749427943;
        Tue, 03 Nov 2026 15:43:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0969eeacdsm320026a91.4.2026.11.03.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 27/37] selftests/bpf: Test a shift, a division and a remainder by a range
Date: Tue,  3 Nov 2026 23:40:52 +0000
Message-ID: <20261103234104.208239-28-alexei.starovoitov@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

For each op one prog needs both bounds of the result, in 64 and in 32 bits,
and expects the register as the log has it. Next to it are progs that get
to a bad read at run time if a bound is off by one, a bit is shifted out,
or the divisor is 0. The verifier must reject them. One prog has what stays
unknown: a count of 64 or 32, a signed division.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_alu_range.c  | 168 ++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_alu_range.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 99f0551c8b59..a771dfbaeb3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -9,6 +9,7 @@
 #include "cb_refs.skel.h"
 #include "verifier_aggregate_arg.skel.h"
 #include "verifier_aggregate_ret.skel.h"
+#include "verifier_alu_range.skel.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
@@ -204,6 +205,7 @@ void test_cb_refs(void)                       { RUN_TESTS(cb_refs); }
 
 void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggregate_arg); }
 void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret); }
+void test_verifier_alu_range(void)            { RUN(verifier_alu_range); }
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_alu_range.c b/tools/testing/selftests/bpf/progs/verifier_alu_range.c
new file mode 100644
index 000000000000..7bd13812941c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_alu_range.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The count of a shift, or a divisor, is a range and not a constant:
+ *	x >> [a, b]	[xmin >> b, xmax >> a]
+ *	x << [a, b]	[xmin << a, xmax << b], if no bit is shifted out
+ *	x s>> [a, b]	a larger count brings x closer to 0, or to -1
+ *	x / [a, b]	[xmin / b, xmax / a], and x / 0 = 0
+ *	x % [a, b]	[0, b - 1], x if it is below a, and x % 0 = x
+ * Each program that has to be rejected gets to the bad read at run time.
+ */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define OK(text)	SEC("socket") __description("alu range: " text) __success __log_level(2)
+#define BAD(text)	SEC("socket") __description("alu range: " text) __failure \
+			__msg("invalid read from stack")
+
+/* @reg is lo .. lo + mask */
+#define RANGE(reg, lo, mask)						\
+	"call %[bpf_get_prandom_u32];"					\
+	#reg " = r0;"							\
+	#reg " &= " #mask ";"						\
+	#reg " += " #lo ";"
+
+/* The read is not allowed */
+#define UNLESS(cond)	"if " cond " goto +1; r0 = *(u64 *)(r10 + 8);"
+
+/* r6 is the second operand. r7 and r8 are x. */
+#define ALU(src_lo, src_mask, x_lo, x_mask, insns)			\
+	asm volatile (							\
+	RANGE(r6, src_lo, src_mask)					\
+	RANGE(r7, x_lo, x_mask)						\
+	"r8 = r7;"							\
+	insns								\
+	"r0 = 0;"							\
+	"exit;"								\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all)
+
+OK("[128, 255] >> [2, 5]")
+__msg("r7 >>= r6 {{.*}} R7=scalar(smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))")
+__msg("w8 >>= w6 {{.*}} R8=scalar(smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))")
+__naked void rsh(void)
+{
+	ALU(2, 3, 128, 127, "r7 >>= r6; w8 >>= w6;"
+	    UNLESS("r7 >= 4") UNLESS("r7 <= 63") UNLESS("w8 >= 4") UNLESS("w8 <= 63"));
+}
+
+BAD("255 >> 2 is 63")
+__naked void rsh_max(void)
+{
+	ALU(2, 3, 128, 127, "r7 >>= r6;" UNLESS("r7 <= 62"));
+}
+
+OK("[3, 10] << [1, 4]")
+__msg("r7 <<= r6 {{.*}} R7=scalar(smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=160,var_off=(0x0; 0xfe))")
+__msg("w8 <<= w6 {{.*}} R8=scalar(smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=160,var_off=(0x0; 0xfe))")
+__naked void lsh(void)
+{
+	ALU(1, 3, 3, 7, "r7 <<= r6; w8 <<= w6;"
+	    UNLESS("r7 >= 6") UNLESS("r7 <= 160") UNLESS("w8 >= 6") UNLESS("w8 <= 160"));
+}
+
+BAD("10 << 4 is 160, 32 bits")
+__naked void lsh32_max(void)
+{
+	ALU(1, 3, 3, 7, "w7 <<= w6;" UNLESS("w7 <= 159"));
+}
+
+BAD("4 << 62 is 0")
+__naked void lsh_overflow(void)
+{
+	ALU(59, 3, 4, 1, "r7 <<= r6;" UNLESS("r7 != 0"));
+}
+
+BAD("4 << 30 is 0, 32 bits")
+__naked void lsh32_overflow(void)
+{
+	ALU(27, 3, 4, 1, "w7 <<= w6;" UNLESS("w7 != 0"));
+}
+
+OK("[-128, -65] s>> [2, 5], [-128, 127] s>> [2, 5]")
+__msg("r7 s>>= r6 {{.*}} R7=scalar(smin=smin32=-32,smax=smax32=-3,")
+__msg("w8 s>>= w6 {{.*}} R8=scalar(smin=0,smax=umax=0xffffffff,smin32=-32,smax32=31,")
+__naked void arsh(void)
+{
+	ALU(2, 3, -128, 63, "r7 s>>= r6;" UNLESS("r7 s>= -32") UNLESS("r7 s<= -3")
+	    RANGE(r8, -128, 255) "w8 s>>= w6;" UNLESS("w8 s>= -32") UNLESS("w8 s<= 31"));
+}
+
+BAD("-65 s>> 5 is -3")
+__naked void arsh_max(void)
+{
+	ALU(2, 3, -128, 63, "r7 s>>= r6;" UNLESS("r7 s<= -4"));
+}
+
+OK("[128, 255] / [2, 5], [128, 255] / [0, 3]")
+__msg("r7 /= r6 {{.*}} R7=scalar(smin=umin=smin32=umin32=25,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__msg("w8 /= w6 {{.*}} R8=scalar(smin=umin=smin32=umin32=25,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__msg("r9 /= r6 {{.*}} R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
+__naked void div(void)
+{
+	ALU(2, 3, 128, 127, "r9 = r7; r7 /= r6; w8 /= w6;"
+	    UNLESS("r7 >= 25") UNLESS("r7 <= 127") UNLESS("w8 >= 25") UNLESS("w8 <= 127")
+	    "r6 += -2; r9 /= r6;" UNLESS("r9 <= 255"));
+}
+
+BAD("128 / 5 is 25, 32 bits")
+__naked void div32_min(void)
+{
+	ALU(2, 3, 128, 127, "w7 /= w6;" UNLESS("w7 >= 26"));
+}
+
+BAD("x / 0 is 0")
+__naked void div_by_zero(void)
+{
+	ALU(0, 3, 128, 127, "r7 /= r6;" UNLESS("r7 >= 42"));
+}
+
+OK("[128, 255] % [2, 5], [128, 255] % [256, 259], [128, 255] % [0, 3]")
+__msg("r7 %= r6 {{.*}} R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__msg("w8 %= w6 {{.*}} R8=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__msg("r9 %= r6 {{.*}} R9=scalar(smin=umin=smin32=umin32=128,smax=umax=smax32=umax32=255,var_off=(0x80; 0x7f))")
+__msg("w9 %= w6 {{.*}} R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
+__naked void mod(void)
+{
+	ALU(2, 3, 128, 127, "r9 = r7; r7 %%= r6; w8 %%= w6;" UNLESS("r7 <= 4") UNLESS("w8 <= 4")
+	    "r6 += 254; r9 %%= r6;" UNLESS("r9 >= 128") UNLESS("r9 <= 255")
+	    "r6 += -256; w9 %%= w6;" UNLESS("w9 <= 255"));
+}
+
+BAD("129 % 5 is 4")
+__naked void mod_max(void)
+{
+	ALU(2, 3, 128, 127, "r7 %%= r6;" UNLESS("r7 <= 3"));
+}
+
+BAD("255 % 255 is 0")
+__naked void mod_same(void)
+{
+	ALU(255, 3, 128, 127, "r7 %%= r6;" UNLESS("r7 >= 128"));
+}
+
+BAD("x % 0 is x, 32 bits")
+__naked void mod32_by_zero(void)
+{
+	ALU(0, 3, 128, 127, "w7 %%= w6;" UNLESS("w7 <= 2"));
+}
+
+/* The cpu takes the count modulo 64 or 32, and a signed division can change the sign */
+OK("not known: a count of 64 or 32, a signed division")
+__msg("r7 >>= r6 {{.*}} R7=scalar()")
+__msg("w8 >>= w6 {{.*}} R8=scalar()")
+__msg("r7 s/= r6 {{.*}} R7=scalar()")
+__msg("w8 s%= w6 {{.*}} R8=scalar()")
+__naked void not_known(void)
+{
+	ALU(63, 1, 128, 127, "r7 >>= r6; r6 += -32; w8 >>= w6;"
+	    RANGE(r7, 128, 127) "r8 = r7; r7 s/= r6; w8 s%%= w6;");
+}
+
+BAD("x >> 64 is x")
+__naked void rsh_64(void)
+{
+	ALU(63, 1, 128, 127, "r7 >>= r6;" UNLESS("r7 == 0"));
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

