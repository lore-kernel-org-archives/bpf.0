Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD578F3A
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269262; cv=none; b=tfNbBARpJ709Cv18SRbdeG+LbsOG3tDlbJLrIJGSNB+7C/MhHyya1469PHN8az3dwM9Wtnst4/sAw53zP3fDgLQhf1HPmAz4HEr6ORSyqPv+IOcDSi037BOhDhM8i6w1ttclr2YpKU31Nq8we+kgrpSPJWzxLP2qmsq9f9IdQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269262; c=relaxed/simple;
	bh=QzRLfJo9js4vvCZggd4OgDBIvjSu37y2F0lpWCJ+zQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqi8Xxr3RWlXj48oXBMDt66yl5KQJB3JxeOM/5x8kDaFMZ506FV/3VdTCA3ZxqknH5j9+3BeTe4nlQ3agViooH6ozcVTbjZ8NhwXN0I3dil9c/2Wm2PnR6Mwd95hYvgxV/fZWp99efXycNavco9W1P95JszrxWtMOMT7aW9ZPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDbCncqB; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDbCncqB"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56f6afbd205so1679233e0c.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776269259; x=1776874059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiuyWJXzxavWGU2K5s6z/NFAJm9eCRSeFAmHxgXG+N0=;
        b=qDbCncqBMBvpvJCGKQuFr3xQjqFp9DDQqqd/NrgUIVfVCX+ccUKwtvzxM3YCzB1Mz7
         MZ1yKXzQtZijPUMK1znISweCr8WWu1ctMKad4rceWgGRnjTmI4Pa6g+I/UeOIpDVzdaU
         8y0NUtWy7bDxOIM8q2hour+rUnHAEwrWs/CPysAWAyOWDZFIFTkEwfZ9WehiTZ0waSx7
         mCE79JqKxyhTiGRJB5zRPxNdtMJTbfjn5AVuRrcILa5SjWXeaDZjzTwps2SCxLIZfCl8
         rnUziEzZCv2F6zB0tdCIAUM5IynthtxCs/fEgQP5vOa1IrSa1JcAgOQBvxaZ9/41MnpF
         6reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269259; x=1776874059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EiuyWJXzxavWGU2K5s6z/NFAJm9eCRSeFAmHxgXG+N0=;
        b=odRW3vVwvX4bm5whJW1mxXXVaj/BBQZrQyrc0o2gq1ldsjyY2nMIVQBxioYYv/oZ4n
         Cr33Fnc3L6u++8u4G1JxDAiMA/9aZz6ng8a/vSOq/mGt2tpizFFcUfpiQWL+ung/4Bpd
         1e/J9GAianC2TFurGtfF9nuhA5Z5/Xf3jl1LfIZhloVvpL29bIsLYdstROJEJVZvufjd
         xbAoQmR2UHDsKiqtGtl0Q3Nuk5XTb6N+lyfyOoqff9uSxYiXkDj5PJI3cqzmOimmFonB
         4syLlRXx6FsKal9ere9osYZgeC5V/LtScUOmDZq2SQZy2eIYuoYiMGrm4xI3RquZbS9g
         hiAw==
X-Gm-Message-State: AOJu0YxWbu7A2cDt4BVNDe9asxwe+0XSyL+f19ZWWUquIJyoOPKki/bn
	L/1PBcVqYxPHi+5bx61Gclv1XmCxh/mqQZarJfAaNs0OTrgkLSHVsSB1pH9wM6cS
X-Gm-Gg: AeBDiev1ThCcchaihzQeJUO3Bc803pd69ugdZ9M2JFNIzCNbruxeFgcyMylqvAEiaTx
	/cnbBbzOLglLOzUversCEDvblhIBMV9hfeODoC/qy+qz97wN2Z4VhRqh3r7sX0eNIGb0yrrmYWF
	/fTXpNo+E0xjkGebJVSewp2DtYnILOYGo6BWb0xqwxNvPrkqjcmueAkoJCv5nEtj67co6sqrWlo
	cSm8fp3mNrRi6BxbDQFo3gqsl/WhAqK3mXFnnMFKdF0crqeqb/HFMU4QDfnxEvMoLVEMTwvvdtA
	kt8kuKmouGFDSAfsAIn2BVClX2gxFnluEyfD+5GKPR5YrdwpgxAxf7phaK6oLv6CCHayGQTjaRf
	KJDhORYGN5GIfQAF1CCVEuQr1jOWPLSu3Pe0jO/hMqGZRTyxysarr3Ko99NMOhGx1N6TNxhmQZX
	Wkm/ERepeX2eQKtWCZOl2SioKglZJVXic6JlzjIUAHEIabOxKkpzOF7r/ah13SBflRO13olcFUO
	nZ8JHlY3Lox3cH69JScOyK5bOke+aA=
X-Received: by 2002:a05:6122:5114:b0:56e:e652:2c10 with SMTP id 71dfb90a1353d-56f947c5779mr93509e0c.4.1776269258705;
        Wed, 15 Apr 2026 09:07:38 -0700 (PDT)
Received: from lima-default (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c959839sm14883736d6.14.2026.04.15.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:07:38 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when simulating to detect dead branches
Date: Wed, 15 Apr 2026 12:07:27 -0400
Message-ID: <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces checks to detect if the ranges and/or tnums have
intersections between them, and uses the checks in
simulate_both_branches_taken and reg_bounds_sync.

The verifier is known to evolve the reg_states correctly (i.e. soundly)
on a live branch. In a previous commit [1], we used the ill-formedness
of a range (e.g. umin > umax), identified by range_bounds_violation, to
detect dead branches and prune the branch along which the ill-formedness
occurs.

Another opportunity to prune branches is when the ranges and/or tnums
have don't intersect. When the verifier evolves the reg_state along a
dead branch, it is possible that abstract value in one domain (e.g tnum)
doesn't match with the abstract value in the other domain (e.g. u64), so
that there is no single value x, that is contained in both the abstract
values.

First, we introduce intersection checks for each of the 5 domains (for a
total of 10 domain pairs), and wrap it in reg_bounds_intersect.

Next, in simulate_both_branches_taken, we use reg_bounds_intersect
instead of the existing range_bounds_violation to detect dead branches.
Because the new check in reg_bounds_intersect also checks for
range_bounds_violation, we are strictly increasing the detection of dead
branches when using the new check.

Finally, this commit also replaces the early exit in reg_bounds_sync. In
an older commit [2] we detected invalid inputs to reg_bounds_sync using
range_bounds_violation, i.e. checking for ill-formed ranges (e.g. umin >
umax), and exited early. If the inputs to reg_bounds_sync do not have
any intersection, they are also invalid. This way, we ensure that
subsequent operations in reg_bounds_sync don't inadvertently "fix" the
reg_state to become valid. This is important for example, when we
simulate_both_branches_taken; the call to reg_bounds_sync won't fix the
reg_state bounds, so we can still detect dead branches using
reg_bounds_intersect.

As a proof of correctness, for each domain pair, we individually
verified the C implementation against a logical specification. For each
pair, we used Agni [3] to encode the C implementation in logic. The
logical specification for a given pair asserts that an intersection
exists if and only if there is at least one concrete integer value that
is simultaneously a valid member of both abstract domains. All 10
verifications returned an "unsat", confirming the C implementation is
equivalent to the specification.

[1] commit b254c6d816e5 ("bpf: Simulate branches to prune based on range violations")
[2] commit a2a14e874b4e ("bpf: Exit early if reg_bounds_sync gets invalid inputs")
[3] https://github.com/bpfverif/agni

Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 224 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e4980128151..3f0d24ed2acc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2345,12 +2345,15 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
 
-static bool range_bounds_violation(struct bpf_reg_state *reg);
+static bool reg_bounds_intersect(struct bpf_reg_state *reg);
 
 static void reg_bounds_sync(struct bpf_reg_state *reg)
 {
-	/* If the input reg_state is invalid, we can exit early */
-	if (range_bounds_violation(reg))
+	/* If the input reg_state has no intersection between abstract values, it is
+	 * invalid. We can exit early, ensuring that subsequent operations don't
+	 * inadvertently fix the reg_state.
+	 */
+	if (!reg_bounds_intersect(reg))
 		return;
 	/* We might have learned new bounds from the var_off. */
 	__update_reg_bounds(reg);
@@ -2397,6 +2400,217 @@ static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
 	       reg->s32_min_value != sval32 || reg->s32_max_value != sval32;
 }
 
+/*
+ * Check if a reg_state's bounds in all domains (u64, s64, u32, s32, tnum)
+ * intersect. This ensures that for every pair of abstract values, there is
+ * *at least one* value x, such that x is a member of both abstract values.
+ * If there is no intersection between *any* pair of abstract values (10 pairs
+ * from the five domains), return false. Otherwise, return true.
+ */
+static bool reg_bounds_intersect(struct bpf_reg_state *reg)
+{
+	u64 umin = reg->umin_value, umax = reg->umax_value;
+	s64 smin = reg->smin_value, smax = reg->smax_value;
+	u32 u32_min = reg->u32_min_value, u32_max = reg->u32_max_value;
+	s32 s32_min = reg->s32_min_value, s32_max = reg->s32_max_value;
+	struct tnum t = reg->var_off;
+	struct tnum t32 = tnum_subreg(t);
+	u64 tmin = t.value, tmax = t.value | t.mask;
+	u32 t32_min = t32.value, t32_max = t32.value | t32.mask;
+
+	/*
+	 * If the min > max, then the range itself is ill-formed, so there can be no
+	 * intersection in abstract values across domains.
+	 */
+	if (range_bounds_violation(reg))
+		return false;
+
+	/*
+	 * If the var_off is ill-formed, there can be no intersection in abstract
+	 * values across domains.
+	 */
+	if ((t.value & t.mask) != 0)
+		return false;
+
+	/*
+	 * Intersect u64 with s64. We map the s64 range to u64 domain and check if
+	 * there is an intersection. If s64 range does not cross the sign boundary,
+	 * then we can treat it as a u64 range and check if its bounding values are
+	 * outside the u64 range. If s64 range crosses the sign boundary, then it
+	 * spans the u64 intervals [0, smax] and [smin, U64_MAX]. Intersection
+	 * exists if the u64 range overlaps either of these components, which is
+	 * equivalent to checking that the u64 range is not trapped between
+	 * (u64)smax and (u64)smin.
+	 */
+	if ((u64)smin <= (u64)smax) { /* s64 does not cross the sign boundary */
+		if ((u64)smax < umin || umax < (u64)smin)
+			return false;
+	} else { /* s64 crosses the sign boundary */
+		if ((u64)smin > umax && (u64)smax < umin)
+			return false;
+	}
+
+	/*
+	 * Intersect u32 with s32. This case is similar to u64-s64, but we map
+	 * the s32 range to the u32 domain.
+	 */
+	if ((u32)s32_min <= (u32)s32_max) {
+		if ((u32)s32_max < u32_min || u32_max < (u32)s32_min)
+			return false;
+	} else {
+		if ((u32)s32_min > u32_max && (u32)s32_max < u32_min)
+			return false;
+	}
+
+	/*
+	 * Intersect u64 with tnum. When we map the tnum to the u64 domain, the
+	 * bounding values of tnum might be outside the bounding values of u64.
+	 * In this case, there is no intersection. For example:
+	 *
+	 * u64:  --[xxxxxx]--------------
+	 * tnum: -----------xx-x-x----x--
+	 *               tmin         tmax
+	 *
+	 * However, it is also possible that the tnum "jumps over" the
+	 * u64, making the u64 range lie entirely "in-between" the tnum, and
+	 * in this case as well, there is no intersection. For example:
+	 *
+	 * u64:  ----[xxxxxx]------
+	 * tnum: -x-----------x----
+	 *      tmin         tmax
+	 *
+	 * We can check for intersection by checking if the next tnum value after
+	 * umin is beyond umax. If it is, there is no intersection.
+	 */
+	if (tmax < umin || tmin > umax)
+		return false;
+	if (t.value != (umin & ~t.mask)) {
+		if (tnum_step(t, umin) > umax)
+			return false;
+	}
+
+	/*
+	 * Intersect u32 with tnum. This case is similar to u64-tnum, but we map
+	 * the tnum to the u32 domain.
+	 */
+	if (t32_max < u32_min || t32_min > u32_max)
+		return false;
+	if (t32.value != (u32_min & ~t32.mask)) {
+		if (tnum_step(t32, u32_min) > u32_max)
+			return false;
+	}
+
+	/*
+	 * Intersect s64 with tnum. Similar to u64-tnum, but we map s64 and tnum to
+	 * the u64 domain. If s64 range does not cross the sign boundary, we can
+	 * treat it as a normal u64 range and check intersection with the tnum as
+	 * above. If s64 range crosses the sign boundary, it spans the u64 intervals
+	 * [0, smax] and [smin, U64_MAX]. Intersection exists if the tnum overlaps
+	 * either of these components. The tnum cannot "jump over" either of these
+	 * two intervals, because they contain endpoints 0 and U64_MAX respectively.
+	 * So it is sufficient to check if the bounding values of tnum are outside
+	 * the bounding values of the mapped s64.
+	 */
+	if ((u64)smin <= (u64)smax) { /* s64 does not cross sign boundary */
+		if (tmax < (u64)smin || tmin > (u64)smax)
+			return false;
+		if (t.value != ((u64)smin & ~t.mask)) {
+			if (tnum_step(t, (u64)smin) > (u64)smax)
+				return false;
+		}
+	} else { /* s64 crosses sign boundary */
+		if (tmin > (u64)smax && tmax < (u64)smin)
+			return false;
+	}
+
+	/*
+	 * Intersect s32 with tnum. This case is similar to s64-tnum, but we map
+	 * s32 and tnum to the u32 domain.
+	 */
+	if ((u32)s32_min <= (u32)s32_max) { /* s32 does not cross sign boundary */
+		if (t32_min > (u32)s32_max || t32_max < (u32)s32_min)
+			return false;
+		if (t32.value != ((u32)s32_min & ~t32.mask)) {
+			if (tnum_step(t32, (u32)s32_min) > (u32)s32_max)
+				return false;
+		}
+	} else { /* s32 crosses sign boundary */
+		if (t32_min > (u32)s32_max && t32_max < (u32)s32_min)
+			return false;
+	}
+
+	/*
+	 * Intersect u64 with u32. If the u64 range spans >=U32_MAX values then an
+	 * intersection is guaranteed, so we skip that case. Otherwise, we map the
+	 * u64 bounds to the u32 domain. When mapped, the u64 range might cross the
+	 * U32_MAX boundary. If it doesn't cross the boundary, it forms a single
+	 * contiguous range: [(u32)umin, (u32)umax] that we check intersection with
+	 * u32 bounds. If it does cross the U32_MAX boundary, we get two contiguous
+	 * ranges: [0, (u32)umax] and [(u32)umin, U32_MAX]. We check if any part of
+	 * the u32 bounds overlaps with either segment, which is equivalent to
+	 * ensuring the u32 bounds are not trapped between (u32)umax and (u32)umin.
+	 */
+	if (umax - umin < U32_MAX) { /* u64 range does not span entire 32-bit domain */
+		if ((u32)umin <= (u32)umax) { /* mapped u32 range is a single contiguous range */
+			if ((u32)umax < u32_min || u32_max < (u32)umin)
+				return false;
+		} else { /* mapped u32 range crosses U32_MAX boundary */
+			if ((u32)umin > u32_max && (u32)umax < u32_min)
+				return false;
+		}
+	}
+
+	/*
+	 * Intersect s64 with u32. This case is similar to u64-u32, but the s64
+	 * range is mapped to the u32 domain.
+	 */
+	if ((u64)smax - (u64)smin < U32_MAX) { /* s64 range does not span entire 32-bit domain */
+		if ((u32)smin <= (u32)smax) { /* mapped u32 range is a single contiguous range */
+			if ((u32)smax < u32_min || u32_max < (u32)smin)
+				return false;
+		} else { /* mapped u32 range crosses U32_MAX boundary */
+			if ((u32)smin > u32_max && (u32)smax < u32_min)
+				return false;
+		}
+	}
+
+	/*
+	 * Intersect u64 with s32. We map the u64 range to the s32 domain, where it
+	 * might cross the S32_MIN/S32_MAX boundary. If it doesn't cross the
+	 * boundary (it might still cross the -1/0 boundary), we check for overlap
+	 * in the standard way. Otherwise, we get two contiguous ranges (one of
+	 * which might cross the -1/0 boundary): [S32_MIN, (s32)umax] and
+	 * [(s32)umin, S32_MAX]. Intersection exists if the s32 bounds overlap with
+	 * either segment, which is equivalent to ensuring the s32 bounds are not
+	 * trapped between (s32)umax and (s32)umin.
+	 */
+	if (umax - umin < U32_MAX) { /* u64 range does not span entire 32-bit domain */
+		if ((s32)umin <= (s32)umax) { /* mapped s32 range is a single contiguous range */
+			if ((s32)umax < s32_min || s32_max < (s32)umin)
+				return false;
+		} else { /* mapped s32 range crosses S32_MIN/S32_MAX boundary */
+			if ((s32)umin > s32_max && (s32)umax < s32_min)
+				return false;
+		}
+	}
+
+	/*
+	 * Intersect s64 with s32. This case is similar to u64-s32, but the s64
+	 * range is mapped to the s32 domain.
+	 */
+	if ((u64)smax - (u64)smin < U32_MAX) { /* s64 range does not span entire 32-bit domain */
+		if ((s32)smin <= (s32)smax) { /* mapped s32 range is a single contiguous range */
+			if ((s32)smax < s32_min || s32_max < (s32)smin)
+				return false;
+		} else { /* mapped s32 range crosses S32_MAX/S32_MIN boundary */
+			if ((s32)smin > s32_max && (s32)smax < s32_min)
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
@@ -15493,7 +15707,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
 	 * TRUE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
+	if (!reg_bounds_intersect(&env->false_reg1) || !reg_bounds_intersect(&env->false_reg2))
 		return 1;
 
 	/* Jump (TRUE) branch */
@@ -15505,7 +15719,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
 	 * Only FALSE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
+	if (!reg_bounds_intersect(&env->true_reg1) || !reg_bounds_intersect(&env->true_reg2))
 		return 0;
 
 	/* Both branches are possible, we can't determine which one will be taken. */
-- 
2.51.0

