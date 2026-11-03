Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749423;
	b=J/+7I5m3pSowq/SdE9a0ZsYkhJak/ecNpvTCfHEq8AKw9q5f/JxiZgGrW8wrisqqKNxe
	 R+HbJhOMcdSPEbje1lsU9NGEvPz+YxGQpdPhJ1UigFH4k35194/MfGaKuUJuqtyOQqGRE
	 0EnSXKsF4f+OtywWOO3Ih0RVO96HDSOFHZENFbRfBup/QirzEU7HcYY396rAdc8qee8LJ
	 BvO6EAo5kqV4iWL987TVzOaCXYm3Ob5nhhS1wT8A9bC1QmCT8fnPCVyY5Ns7n1zum5s02
	 ZCUB8iJmDbY0zfX/JbV2tusT3C1LVF1sObFbXWmXLnr3vodCOcNGdz4oycg9e+oQ3xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qVVAW2484n1eUSuKjlYpz3Ix9PdYLfo1fJXWX1I/Hsg=;
	b=ZuTj8fV+C1rLyuYk7IcRe9S9333jSqLH1jAfQbIGOPWLBH/wIAocVsGDdCSGJJaXtYvI
	 GzJ2Ag5qq5MdhvUyS3Rmqpb3346deXNkCP19ZJowVataJ0IUNWtAVPdD1PWf7NwZjkXDj
	 /XbakbAGZO+FRtc6EJcEtc6K90ZpY59jyKv5mN2z1NvfPYN3l8ACNttfdmX9v0QY/bGsi
	 dpIeBTJHlFlIjFhCHPMFqV9NRcjg8GraRdcwctv9QjdK/lM/QBxmOHcl6i19EnxiyRSs6
	 WIHtS2ECn/uLE4VMLz/BkqSh3okBrALI6+5R3O+CJgW7Grb8ZiC4L3Q47dphDU0eK6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ne3/R+61";
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE2606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BE2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ne3/R+61
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so127270b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749422; x=1794354222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVVAW2484n1eUSuKjlYpz3Ix9PdYLfo1fJXWX1I/Hsg=;
        b=ne3/R+61W5sr/aeyTh9toHyb3so5MqVCHH9/8Um4A1qN/8EHZHLnX8ZlW0z3ULoksw
         UXGCxGc6N16In8OE7o5QBT5IBalTKa0pOF+HAWXWTmSL+euT4W43HpzTNUTNPE9tVIxi
         jjIyum8MT37gpU17U14a6GK1/lF/vs7qPMxn6kUfUddT4rXlNo0op66OCpkZIs08Fs/Z
         RgXG2AAbnFCTJcq9FMmbIx0FWfiGyqZLbshMByUNxxvD1YruFsnrFeJJfBNpwiQSwfXa
         QCRPuXWRMQktJJPMyNMYg5qoRl60PQsJiP5Bk0eMoH5MOsdngcR+xwznZAXZtrJTIAAz
         EPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749422; x=1794354222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVVAW2484n1eUSuKjlYpz3Ix9PdYLfo1fJXWX1I/Hsg=;
        b=yW8Fojoi1wLsxAHcWZ0QzXz1XRkX6e/kC45hxCYA4UXGqghfo7evQ6TucE/+4fDzYD
         Fg/haj5djgIerJcIHMrfNXTQsc0YkV8FSz1i4pJ+nIOgrDpNGDcMxH70T6Ol1uxkCXP5
         KJ7nZdHYb+gTtXcJB/BLbfW92PpgbQudMiPj5XCudVNq6VgAja//GfVb2cBnIsMu2Vj5
         YOv/jktth6HJCk7PoprLzuguBP40ZJInziTH2Vkfdg8620ZBHyfOsT//ZyiwAUGZoKEe
         RB3boZBGv9HJEqRbIVwNgqDvAyjLuwm9M0YUDJkHIVKiqEZCceboGs3pxpnHa5MC3llk
         O5FA==
X-Gm-Message-State: APuU4Z/wB1j0Q9yvGgQipyMOOUYpP3oHNRBtdzzvFUEgqQh79+sBkmC6
	M8kTfjEzmiUl+aJoBrCmPu1ehqP+2YrPa+aI7pId8NDNW0URVBQ0vrsPc8pMsA==
X-Gm-Gg: AYBFou3zWbyj8y81mqKeRhmpIIMZaugJwmK1gPeClBu9YeK3OPxxAp2STKwR608afRB
	2cnzIbc5b9S/0F8sn5uH4pBmIr5ATMdnbqRkPSUAX5x5OQx1cExI8lwU2WGPS+UVRtRPqoujITZ
	JkqKJVwO466T5YDwNoWPFh6qH9IJLHwh/Ti9l5tsYM8PfMBVrz7cD2fkJTAtfdjea6dQlQuJ1Xu
	mpUviJzAGzSKVHQrSOsI8B7ysahSKf2O3xVo/CuQdmsFega2GkSFW5gAXfl8H6UILRJ0QTa85pf
	7RhtmUVXpRWMJhbHXkES8FgcOdO1uGse+15PHis3sayFzlSWiKg5t4tAMK/uG6apOkuA5rz9Vqd
	ijo4O6k9JGBQE/8clpIIxoKf4cGUbrcbkteGEfO2Vef0x2yDryaJ3Jg5/XW5TjIidkwZhGmyV4d
	9ueV2yOkfA/zIIioHclBi4KXkOw7TnNO+Q0dph3C7O7Oin5som36hnGL5xyWL3EoSlRgVWQVU7s
	ph75rd7BNnprpDrwoT3w86fiTIS6OAWdvMENFZQH5RT/3qzTNKi+CQpunEd65oFoE4ozUIsokce
	L2x67EKJzXG+SCIJzJXD8chGjLaR9D1BTvrvfiz7EMiaYm/O1D86qNNWcA11hOOwYfzJv3qHAVg
	QFlG4lZx1amSBhJVDZzVTTOWpX+DBzAez3sD4sPJ30R4/bSXPBeVq/Hg1vG37OX3vFIjEdNO2L+
	4=
X-Received: by 2002:a05:6a00:10c5:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-8a9bc8321e4mr12722639b3a.32.1793749422086;
        Tue, 03 Nov 2026 15:43:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b569437sm149543b3a.34.2026.11.03.15.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 26/37] bpf: Compute bounds for a shift, a division and a remainder by a range
Date: Tue,  3 Nov 2026 23:40:51 +0000
Message-ID: <20261103234104.208239-27-alexei.starovoitov@gmail.com>
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

The result of x >> n, x << n, x s>> n, x / n and x % n is an unknown scalar
unless n is a known constant. Real code has n in a range: x >> (n & 31),
1 << order, hash % nr_cpus. A prog that uses such a result as an index is
rejected, unless the verifier sees each value of n as a constant in a state
of its own.

Compute the range of the result from the ranges of the two operands. With
x = [xmin, xmax] and n = [a, b], unsigned:

  x >> n    [xmin >> b, xmax >> a]
  x << n    [xmin << a, xmax << b] if no bit can be shifted out
  x s>> n   a larger count brings a signed bound closer to 0, or to -1
  x / n     [xmin / b, xmax / a]. [0, xmax] if a is 0: x / 0 is 0
  x % n     [0, min(xmax, b - 1)]. x if xmax < a.
            [0, xmax] if a is 0: x % 0 is x

The functions for << and >> have taken the smallest and the largest count
since commit f1174f77b50c ("bpf/verifier: rework value tracking"). Commit
bb7f0f989ca7 ("bpf: fix integer overflows") left them with constants only.
What they do with var_off holds for a constant only: a bit of x can end up
in more than one place. So var_off of x is forgotten first. Then
tnum_lshift() and tnum_rshift() by the smallest count give the bits that
are 0 for each count.

As before nothing is known if the count can be 64 (32 for a 32-bit insn) or
more, and about a signed division or remainder by a range. Nothing changes
for a constant.

The bounds decide jumps, and states that were equal can differ now, so the
verifier prunes fewer paths in some progs. In sched-ext/scx 26 progs
change, with 2.6 % fewer insns in total: flow_select_cpu 145475 -> 89352,
alloc_selftest 23734 -> 29898.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 85 ++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 94d9a065e62d..93ca0126a310 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16815,10 +16815,11 @@ static void scalar_min_max_shmul(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
 				  struct bpf_reg_state *src_reg)
 {
-	u32 src_val = reg_u32_min(src_reg); /* non-zero, const divisor */
+	u32 src_min = reg_u32_min(src_reg), src_max = reg_u32_max(src_reg); /* src_max isn't 0 */
 
-	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) / src_val,
-			 reg_u32_max(dst_reg) / src_val);
+	/* The largest divisor gives the smallest result, but for x / 0 = 0 */
+	reg_set_urange32(dst_reg, src_min ? reg_u32_min(dst_reg) / src_max : 0,
+			 reg_u32_max(dst_reg) / (src_min ?: 1));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
 	reset_reg64_and_tnum(dst_reg);
@@ -16827,10 +16828,11 @@ static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
 static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
 				struct bpf_reg_state *src_reg)
 {
-	u64 src_val = reg_umin(src_reg); /* non-zero, const divisor */
+	u64 src_min = reg_umin(src_reg), src_max = reg_umax(src_reg); /* src_max isn't 0 */
 
-	reg_set_urange64(dst_reg, div64_u64(reg_umin(dst_reg), src_val),
-			 div64_u64(reg_umax(dst_reg), src_val));
+	/* The largest divisor gives the smallest result, but for x / 0 = 0 */
+	reg_set_urange64(dst_reg, src_min ? div64_u64(reg_umin(dst_reg), src_max) : 0,
+			 div64_u64(reg_umax(dst_reg), src_min ?: 1));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
 	reset_reg32_and_tnum(dst_reg);
@@ -16911,17 +16913,17 @@ static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
 				  struct bpf_reg_state *src_reg)
 {
-	u32 src_val = reg_u32_min(src_reg); /* non-zero, const divisor */
-	u32 res_max = src_val - 1;
+	u32 src_min = reg_u32_min(src_reg), src_max = reg_u32_max(src_reg); /* src_max isn't 0 */
 
 	/*
-	 * If dst_umax <= res_max, the result remains unchanged.
-	 * e.g., [2, 5] % 10 = [2, 5].
+	 * If dst_umax < src_min, the result remains unchanged.
+	 * e.g., [2, 5] % [10, 20] = [2, 5].
 	 */
-	if (reg_u32_max(dst_reg) <= res_max)
+	if (reg_u32_max(dst_reg) < src_min)
 		return;
 
-	reg_set_urange32(dst_reg, 0, min(reg_u32_max(dst_reg), res_max));
+	/* The result is below the divisor and not above x, and x % 0 = x */
+	reg_set_urange32(dst_reg, 0, min(reg_u32_max(dst_reg), src_min ? src_max - 1 : U32_MAX));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
 	reset_reg64_and_tnum(dst_reg);
@@ -16930,17 +16932,17 @@ static void scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
 static void scalar_min_max_umod(struct bpf_reg_state *dst_reg,
 				struct bpf_reg_state *src_reg)
 {
-	u64 src_val = reg_umin(src_reg); /* non-zero, const divisor */
-	u64 res_max = src_val - 1;
+	u64 src_min = reg_umin(src_reg), src_max = reg_umax(src_reg); /* src_max isn't 0 */
 
 	/*
-	 * If dst_umax <= res_max, the result remains unchanged.
-	 * e.g., [2, 5] % 10 = [2, 5].
+	 * If dst_umax < src_min, the result remains unchanged.
+	 * e.g., [2, 5] % [10, 20] = [2, 5].
 	 */
-	if (reg_umax(dst_reg) <= res_max)
+	if (reg_umax(dst_reg) < src_min)
 		return;
 
-	reg_set_urange64(dst_reg, 0, min(reg_umax(dst_reg), res_max));
+	/* The result is below the divisor and not above x, and x % 0 = x */
+	reg_set_urange64(dst_reg, 0, min(reg_umax(dst_reg), src_min ? src_max - 1 : U64_MAX));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
 	reset_reg32_and_tnum(dst_reg);
@@ -17284,16 +17286,16 @@ static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
 				  struct bpf_reg_state *src_reg)
 {
-	u64 umin_val = reg_u32_min(src_reg);
+	u32 umin_val = reg_u32_min(src_reg), umax_val = reg_u32_max(src_reg);
+	s32 smin = reg_s32_min(dst_reg), smax = reg_s32_max(dst_reg);
 
-	/* Upon reaching here, src_known is true and
-	 * umax_val is equal to umin_val.
+	/*
+	 * A larger count brings the result closer to 0, or to -1.
 	 * Blow away the dst_reg umin_value/umax_value and rely on
 	 * dst_reg var_off to refine the result.
 	 */
-	reg_set_srange32(dst_reg,
-			 (u32)(((s32)reg_s32_min(dst_reg)) >> umin_val),
-			 (u32)(((s32)reg_s32_max(dst_reg)) >> umin_val));
+	reg_set_srange32(dst_reg, smin >> (smin < 0 ? umin_val : umax_val),
+			 smax >> (smax < 0 ? umax_val : umin_val));
 
 	dst_reg->var_off = tnum_arshift(tnum_subreg(dst_reg->var_off), umin_val, 32);
 
@@ -17304,13 +17306,12 @@ static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
 static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 				struct bpf_reg_state *src_reg)
 {
-	u64 umin_val = reg_umin(src_reg);
+	u64 umin_val = reg_umin(src_reg), umax_val = reg_umax(src_reg);
+	s64 smin = reg_smin(dst_reg), smax = reg_smax(dst_reg);
 
-	/* Upon reaching here, src_known is true and umax_val is equal
-	 * to umin_val.
-	 */
-	reg_set_srange64(dst_reg, reg_smin(dst_reg) >> umin_val,
-			 reg_smax(dst_reg) >> umin_val);
+	/* A larger count brings the result closer to 0, or to -1 */
+	reg_set_srange64(dst_reg, smin >> (smin < 0 ? umin_val : umax_val),
+			 smax >> (smax < 0 ? umax_val : umin_val));
 
 	dst_reg->var_off = tnum_arshift(dst_reg->var_off, umin_val, 64);
 
@@ -17401,22 +17402,19 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_END:
 		return true;
 
-	/*
-	 * Division and modulo operators range is only safe to compute when the
-	 * divisor is a constant.
-	 */
+	/* The range of a signed division or modulo is computed for a constant divisor only */
 	case BPF_DIV:
 	case BPF_MOD:
-		return src_is_const;
+		return src_is_const || !insn->off;
 
-	/* Shift operators range is only computable if shift dimension operand
-	 * is a constant. Shifts greater than 31 or 63 are undefined. This
-	 * includes shifts by a negative number.
+	/*
+	 * Shifts greater than 31 or 63 are undefined. This includes shifts by
+	 * a negative number.
 	 */
 	case BPF_LSH:
 	case BPF_RSH:
 	case BPF_ARSH:
-		return (src_is_const && reg_umax(src_reg) < insn_bitness);
+		return reg_umax(src_reg) < insn_bitness;
 	default:
 		return false;
 	}
@@ -17485,6 +17483,11 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			return sanitize_err(env, insn, ret);
 	}
 
+	/* The count of a shift is a range: a bit of dst_reg can end up in more than one place */
+	if ((opcode == BPF_LSH || opcode == BPF_RSH || opcode == BPF_ARSH) &&
+	    reg_umin(&src_reg) != reg_umax(&src_reg))
+		dst_reg->var_off = tnum_unknown;
+
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
 	 * There are two classes of instructions: The first class we track both
 	 * alu32 and alu64 sign/unsigned bounds independently this provides the
@@ -17547,7 +17550,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_DIV:
 		/* BPF div specification: x / 0 = 0 */
-		if ((alu32 && reg_u32_min(&src_reg) == 0) || (!alu32 && reg_umin(&src_reg) == 0)) {
+		if ((alu32 && reg_u32_max(&src_reg) == 0) || (!alu32 && reg_umax(&src_reg) == 0)) {
 			___mark_reg_known(dst_reg, 0);
 			break;
 		}
@@ -17565,7 +17568,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_MOD:
 		/* BPF mod specification: x % 0 = x */
-		if ((alu32 && reg_u32_min(&src_reg) == 0) || (!alu32 && reg_umin(&src_reg) == 0))
+		if ((alu32 && reg_u32_max(&src_reg) == 0) || (!alu32 && reg_umax(&src_reg) == 0))
 			break;
 		if (alu32)
 			if (off == 1)
-- 
2.55.0

