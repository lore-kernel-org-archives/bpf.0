Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749441;
	b=CAhLYrOGFzXCzmDa1EHB3pZFSQlivTt3Dxc74H9NGvC/wzjp9nt4GD9iRslEZOiOl0e4
	 pWMefaWvi7Fb8MdAj2rBBWXBIaYNKqYJZg5TukOZl5gzAHOXLCGuS6Ww3diYKPYgw23sJ
	 1Hh6HjTxW+yetadQttCL6Mh0zqYf3Boii+2o3XoZRIpu1vO3Z1icQDfA/raNFfvtPqnp0
	 JLnI10AD6oY3daMYXofzwNwbi/lPvSZX+oIjcgQ/woYtrgge0oSvZU1GkTUq1cwrdoCk8
	 1OcFgDm/5FYL5J+weCPll0KIYS4wYr4tjXHCWdvjYhSgaU5l+2Rb1/17X91qRqVtzsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=B3CiS2vIIEWibZ8xKyC/emDWJoZpUr+EEgSkPg8pnRM=;
	b=xldJR5f9s0NZLy3MoeX+v9jc1IQHwSZyxHuHvKtoswWy30MVrjxiR5lItJrs6w9RUZOc
	 7zng1S38OCiULBXVSK/yCdAUN1+4zTcrKZrb2FUjCqiV4JrC3OoITy0bzHvPYc9u5jjG5
	 72FjxNnpFQzlUzDzbiGxasbhvrcr+5YgEwtCA0A67dMTLl/Zkuj8ZBSa2gEKqFFb+sX53
	 enPIbRkexrCnMOcdLcdg5X2I88gVaZnq1BP0Gzb/JuRPUoM5VX3+KdsoXEDpwuxj5etMi
	 MagtTeqVzDE5u3SQjzbo2A0zlkgDmKrDk9O62BQpUt93KvmK/Tq8ReEEifrVGZuP+XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MU2QfuhX;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE1606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFAE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MU2QfuhX
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd623dfe420so142939a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749440; x=1794354240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3CiS2vIIEWibZ8xKyC/emDWJoZpUr+EEgSkPg8pnRM=;
        b=MU2QfuhX5Wq6Wd56GSYuoWmswYh1qnVfoHrhxEEXWmvtLMXua1i6oAU1YPO4thzF3P
         Yw6B168G9fc0S/JhIu/jlKM7K9iKCIMBUhdeVdOUrlyy7y/Omejv/5Kt0OG9KUYqqnXW
         FsQ1ZVXMKYNuCbYf5nCOsznSRQSrTOFF8TJrb9x0CRKFSLQaTC8hDOYFAAXgiU3Krl32
         FTz4Ew30s6yplCXRqqKA+ijn6h2o7YYV2TfnPBR9R6pUP+rqXotkkQ5JUQoIH/WguRbJ
         wiFEYmE9wq3EnL3Dy2WoZFQZSB1L2xaQtyK4im1iYXi2bx3d0s9gAvIPC1b39fTXiA2s
         /zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749440; x=1794354240;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3CiS2vIIEWibZ8xKyC/emDWJoZpUr+EEgSkPg8pnRM=;
        b=OjgfKCghqlxZNBaXlgNhWjYCa0zwpU6l+Sx0lzz1eVaDEi6X15zeWRShESDHtTG4mg
         to9EVPNWJBZzjYdcz49T+iop75bJRARqccclj4y01UWKEe7Jzg7Ng5QiRdT4loNbwihn
         d0AxAq8FoIaQf3Bj3E6XgyFNyUX7qRsUcMMVh6ys6Gsd9jlBKy0Z2JrtsajTAZSur3/G
         Et851TUSKt4dmipllS3LhzrAFvu9EJ6JSe1wlxBPbNwCm2LuaSbSQCtcplLSLma7LtvC
         uX0wAsB/TpAF/Bn+eZ2XtW0FddPFrD9oLfzDV+CY7C9393Kyn8NMXB1NBkTMe+t4slMe
         fp+w==
X-Gm-Message-State: APuU4Z9eyBAvgjSgBdpSwoEphgQtZzcKbuw2VZm14UNzAvNKGTnJRccC
	Jjgxfe6AMveJq04TDX6oZEeSD8Q00GCg+AMlO2919B+m0h8JM6QwOu765U3POg==
X-Gm-Gg: AYBFou2JkY7YmU1J1f4NLYonqM56SGeZYNgiYhknBD0wzaUTpTr/TZzVLZzriBcplvV
	qqEzIRF9fG9f8PbHqEsy5VmaZqGBy64VkrM6qU08uTsqZ8/oHNt5eEFAYSnBaDeaxwwAVX7Z7uS
	kSsEyOMudMBsMgheGweQWZYymJPgW7toiL199qpQfYmZN4KUUe1wgqfUJQ10kUiUR8Dw88s+eHH
	ULZIgHA15XfMdd/EU1jDwLIebFg7fMB0JV5y2LOVS0mfVic3KQtqqS8PQwCAIHu5ic4Xw71QGnE
	hTGSNFQnz6pTjdWyJnxyYA67FAkCsUlhXSnmaZ/OZhMth3mLnmOUyKHhlP5Y5QVQZEbCg3ooHfj
	E8w3rlCjM6TeRacLuamtmJLfAg8ImIXIXldqT9On+eTEXNTSNp1dDQSoLcnLZJiKU5vfl9e6pB1
	Rx9LCQo53MDIcaapgvFOziFIohxi/PqRcXL0DqUfQ+TulWx3ytRptpsBbTBHxRZ4cn+cF8z+jSn
	GOMNCk/5slGcsPKkebRMb3Cf8X8gyDa1weSBfR5PYR5nJ4PirlaDN+K4Nsp8B5WPQF2jIPcpvEv
	kMAJRACfxf4xIBGSvl8JgvkSlu7EgFFCTOx5ipDdfMFlZK6L+1oqW/GwgKrXTL5XtnZRlu03mNH
	dZnpB7cPbS86BspZVLUxiavxyEEJ4Lo7cyQ3a8AY9lbjl3ZD/6JxcMXd4wT55YkdWyW9xLIdA4+
	4=
X-Received: by 2002:a17:90b:2d8a:b0:3ab:9c73:12a with SMTP id 98e67ed59e1d1-3ae8957470cmr11551555a91.2.1793749439860;
        Tue, 03 Nov 2026 15:43:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928d1sm6551600a91.14.2026.11.03.15.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 29/37] bpf: Count '!=' across 0 in 32 bits and loops that go down
Date: Tue,  3 Nov 2026 23:40:54 +0000
Message-ID: <20261103234104.208239-30-alexei.starovoitov@gmail.com>
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

Compilers make these latches of loops that end at 0:

  for (i = 63; i >= 0; i--)                w6 += -1; if w6 != -1 goto l
  n = 64; while (n--)                      w6 += 1; if w6 != 0 goto l
  for (j = n - 1; j >= 0 && j < 128; j--)  w6 += -1; if w6 < 128 goto l

None of them has a count. In each the variable goes across 0, and scalar
evolution looks at it as an unsigned number. As a signed number it is in
order, and the signed order has formulas.

'!=': the count for constants is calculated in 64 bits from operands that
are zero extended. From 62 down to 0xffffffff is a distance of almost 2^64.
When the first value is on the wrong side of the bound as an unsigned
number, take the operands as signed 32-bit numbers: 7 goes down to -1, -8
goes up to 0. The formula for ranges does that already. From 4 up to 1 is
wrong in both orders: there is still no count.

'<': the compiler makes one unsigned test of 'j >= 0 && j < 128', and '<'
has a count only for a variable that goes up. A variable that goes down
stays below the bound. The loop ends when it gets below 0, which is a large
unsigned number. So count the latch as 'j >= 0', signed, if the bound is
not negative as a signed number. A 64-bit jump on a 32-bit counter compares
all 64 bits of the bound: there the bound has to fit in 31 bits. 'j >= 0'
has a formula for constants and for ranges. Each value that the unsigned
test lets through is not negative. Thus the count is not too small,
whatever the first value is.

Only the count takes the signed form. In a loop with several back edges
same_latch() compares the jumps as the prog has them.

The verifier no longer verifies these loops one iteration at a time.
A compiler zero extends a 32-bit counter that goes down in the loop, not in
front of it. If the first value comes from a 64-bit register and only
a 32-bit jump limits it, nothing is known about j at the loop head:

  for (u32 j = bpf_get_prandom_u32(); j < 128; j--)

An access at index j is rejected now. No prog of Cilium, scx, the selftests
or the public progs of Meta is lost.

pre_lt_dir, pre_le_dir, range_lt_dir and range_le_dir of verifier_scev.c go
down under an unsigned test. They have a count now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 34 ++++++++++++++++---
 .../selftests/bpf/progs/verifier_scev.c       | 22 +++++++++---
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 9ddaae03ac35..70d15449eebe 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2738,8 +2738,9 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	struct scev *scev = env->scev;
 	struct scev_value initial_val, step_val, bound_val;
 	u64 step, bound, initial, total_change, backedge_taken_count;
-	bool konst;
+	struct linear_latch counted;
 	u8 op = latch->op;
+	bool konst, sign32 = latch->jmp32 && is_signed_op(op);
 
 	iters->iv_reg = -1;
 
@@ -2761,6 +2762,23 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 
 	if (!scev_value_is_const(&step_val))
 		return false;
+	/*
+	 * 'i >= 0 && i < 128' is one unsigned test. A counter that goes down stays below 128.
+	 * The loop ends when it gets below 0. A 64-bit jump compares all 64 bits of the bound.
+	 * The latch of the caller stays as it is: same_latch() compares what the prog tests.
+	 */
+	if ((op == BPF_JLT || op == BPF_JLE) && initial_val.ptr_reg < 0 &&
+	    (latch->jmp32 || latch->zext32 ?
+	     (s32)step_val.umin < 0 && initial_val.u32_min < bound_val.u32_max &&
+	     (latch->jmp32 ? bound_val.u32_max : bound_val.umax) <= S32_MAX :
+	     (s64)step_val.umin < 0 && initial_val.umin < bound_val.umax &&
+	     bound_val.umax <= S64_MAX)) {
+		counted = *latch;
+		latch = &counted;
+		op = latch->op = BPF_JSGE;
+		bound_val = (struct scev_value){ .ptr_reg = -1 };
+		sign32 = true;
+	}
 	konst = scev_value_is_const(&initial_val) && scev_value_is_const(&bound_val);
 	if (!konst) {
 		if (!compute_backedge_taken_max(env, st, latch, &initial_val, &step_val, &bound_val,
@@ -2785,7 +2803,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		 * With the above constraint doing `l: w0 += 1; if r0 s< 256 goto l;`
 		 *                is equivalent to `l: w0 += 1; if r0 < 256 goto l;`
 		 */
-		if (latch->jmp32 && is_signed_op(op)) {
+		if (sign32) {
 			initial = (s64)(s32)(u32)initial;
 			bound   = (s64)(s32)(u32)bound;
 			step    = (s64)(s32)(u32)step;
@@ -2803,7 +2821,15 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 				"scev: mixed-width latch has operands outside 32-bit ranges\n");
 		return false;
 	}
-
+	/*
+	 * 7 goes down to -1, -8 goes up to 0: on the wrong side of the bound as unsigned
+	 * numbers, on the right side as signed ones. From 4 up to 1 is wrong both ways.
+	 */
+	if (op == BPF_JNE && latch->zext32 && ((s64)step < 0 ? initial < bound : initial > bound)) {
+		initial = (s64)(s32)(u32)initial;
+		bound   = (s64)(s32)(u32)bound;
+		sign32 = true;
+	}
 
 	if (!compute_backedge_taken_count(op, initial_val.ptr_reg >= 0, initial, step, bound,
 					  &backedge_taken_count))
@@ -2819,7 +2845,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	if (latch->zext32 || latch->jmp32) {
 		/* total_change is guaranteed not to overflow at this point */
 		total_change = initial + step * backedge_taken_count;
-		if (latch->jmp32 && is_signed_op(op)) {
+		if (sign32) {
 			if ((s64)total_change < S32_MIN || (s64)total_change > S32_MAX)
 				return false;
 		} else {
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 790cbfe1f2e4..5cc886b92913 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -869,7 +869,7 @@ PRE__COND_TEST (pre_sge_false,     "s<",                -2,           -2,
 PRE__COND_TEST (pre_ne_false,      "==",                 7,            2,                7, "header_count is 1 ")
 
 /*
- * The counter moves away from the exit; bound fallback verification.
+ * An unsigned counter goes down and leaves the range below 0.
  *
  * Example: pre_lt_dir
  *
@@ -878,8 +878,19 @@ PRE__COND_TEST (pre_ne_false,      "==",                 7,            2,
  *        r6 -= 2;                   // r6 ∈ [3,1,U64_MAX]
  *    }
  */
-PRE__COND_TEST2(pre_lt_dir,        ">=",                 5,           -2,                7, "can't compute iterations count")
-PRE__COND_TEST2(pre_le_dir,        ">",                  5,           -2,                7, "can't compute iterations count")
+PRE__COND_TEST2(pre_lt_dir,        ">=",                 5,           -2,                7, "header_count is [0..4] ")
+PRE__COND_TEST2(pre_le_dir,        ">",                  5,           -2,                7, "header_count is [0..4] ")
+
+/*
+ * The counter moves away from the exit; bound fallback verification.
+ *
+ * Example: pre_gt_dir
+ *
+ *    u64 r6 = 5, r9 = 0;
+ *    while (++r9 < 8 && r6 > 3) {   // r6 ∈ [5,7,...,19]
+ *        r6 += 2;                   // r6 ∈ [7,9,...,19]
+ *    }
+ */
 PRE__COND_TEST2(pre_gt_dir,        "<=",                 5,            2,                3, "can't compute iterations count")
 PRE__COND_TEST2(pre_ge_dir,        "<",                  5,            2,                3, "can't compute iterations count")
 PRE__COND_TEST2(pre_slt_dir,       "s>=",               -1,           -2,                1, "can't compute iterations count")
@@ -1128,9 +1139,10 @@ RANGE_TEST(range32_ne_far,  "", M32 - 5, M32 - 3,  1, M32 - 1, M32 + 3,
 /* the first jump tests what enters the loop, and that is not zero extended */
 RANGE_TEST(range32_first_is_wide, "", 0, M32 + 9,  2,      15,      20,
 	   LOOP_HEAD "if r6 >= r7 goto 2f; w6 += w8; goto 1b;", NO_COUNT)
+/* An unsigned counter goes down and leaves the range below 0. */
+RANGE_TEST(range_lt_dir,    "",  3, 10,    -2,  15, 20,  PRE(">="),   COUNTED(7, "-2..10"))
+RANGE_TEST(range_le_dir,    "",  3, 10,    -2,  15, 20,  PRE(">"),    COUNTED(7, "-2..10"))
 /* The counter moves away from the exit. */
-RANGE_TEST(range_lt_dir,    "",  3, 10,    -2,  15, 20,  PRE(">="),   NO_COUNT)
-RANGE_TEST(range_le_dir,    "",  3, 10,    -2,  15, 20,  PRE(">"),    NO_COUNT)
 RANGE_TEST(range_gt_dir,    "", 10, 20,     2,   3,  5,  PRE("<="),   NO_COUNT)
 RANGE_TEST(range_ge_dir,    "", 10, 20,     2,   3,  5,  PRE("<"),    NO_COUNT)
 /* '!=' can step over the bound, or start behind it. */
-- 
2.55.0

