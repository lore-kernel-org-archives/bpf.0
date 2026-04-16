Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86635175A7F
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345102; cv=none; b=rLrOZ1cMfpeA0IswPCQoPHsxf8rpgZTGzU7KbOwgfkspJn8Gvoc8DN4MU0+UsxSaFryH68wDTrUXiFlXtkycdY+771qv6naW/RjJtlbE4g/lYM68qcmLUWx0NiUb8xhYbGF6vNtyVL1pjq8kZ0DGNTNyWC3C7xQTmdr5F0qVHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345102; c=relaxed/simple;
	bh=0vWpt09VZ2WRx3a3MU6mJCg+aWiS4N05k5nlpuobxE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoa6WtgSpYVoKUOpQwDseY8F1MHaZNxPjKU1eqisFWnuGxLXoShJMwxnpbnNF3wnf/BLvFFNq0l8uy/KddSHCRod6bLFqWAtKHbW1rP3UShYzddxZNDDMBhkfTJ/0Qhlol6VuhW53GzSJhVaRd19wOgJXr+mxHSHRLFEX1ekaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf2sNxJq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf2sNxJq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso77958505e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345099; x=1776949899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOqJ9s6oehBiqrJEO6CFeG47ZHKiSvpClr6y9D+4zJg=;
        b=Nf2sNxJqC9HQQAHJb8MrNWYD/CSJ6mGfsIxJ9ftfp7c7/rl1d2DPA9keBfZe9G0mk/
         FxMmO9GjhGRHu/Kh/YEwIhvsY7sBDwqbh6FzU2DNIzsQ+WhAZDvn8I8dvi235XL4ciMG
         s64Wv4Z8yYUnNAvkaj3jOCspED2+X6gnXl1adWGQXw7B1pY6VIlWq6N5bDBLQzqXhQ5s
         2/Hb55W0cz8hTppv5y17Cv7+igta6MVIoBGqUQ/57/Uz1NesC7pqyQGW3tBXIPdeJoS+
         rfYoeyRPEOBAjpZzGg/qlUqkIdpP4QFYy+/vsUME8OJFlsdOnKd0UUeJnzXx7ihIFNnm
         LV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345099; x=1776949899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOqJ9s6oehBiqrJEO6CFeG47ZHKiSvpClr6y9D+4zJg=;
        b=oZshI7CSNSWGL4MzMuZrVR5CoS1XCfokQ1J2Dm/TBYOmc7A6KUy0Adz1p+B94kd8Zx
         jsgiiUU//0ArLo48BQeofpfpo6n/IoI1yWadwjm7CMiJcldPGC5DcTLC8/dwo/Gg5l4i
         F8f0Zv07fiDCRBiypnMHrul2YL0ldHbpOp1p4XTSqJaYbvAX1sxSE5iIlHAnXkLKY2tw
         ZRdOjqxQmMxpHMJo0rbaJaqEMFGpQEQgQSV4umOi3RFTFbKuA721dn6GDtGjwOfLX7+2
         NtkzaPEF10w2kqtK+aYD5yFJ7ACrcgqlMUOyLkTuBezhvsOUTdQktKfDMpEMBGbzPuf0
         8cXg==
X-Gm-Message-State: AOJu0YxIXfos3BRPEl7VEH3ltut1n8u/+PXaGurcZS32gFCOQkOatkhR
	xZlkjMjwPTOIkt5446CetUOo+YGZeXhqlhwHx/iMlhgil+qRRfp7jD20Uge9/RwJ
X-Gm-Gg: AeBDietciuwWFgvujUXDTXH4V043BGNpVSujqJayXlkHC59VzcBj+yA6/yK46/ILvRJ
	QP96n/zbWWUa/3eTj9/WvD0OWNUpIr6QRDEpr2Gkh2IbjM03rJhO+Du3tDDDAT/cDVr+UlW5im+
	26An/gT5omAr743idcKpUYR5/g3LxtpePYpQKtfHHGrSGgTdUpGHajMqR037aciF2IKXGEESBwm
	dwB3uKp/R0Au9EI9Ewg2TSA0yxnuhB4A2XPjqoJPeaV+FKnRStWkjL4wDzSIspgcYICDStqwTaC
	DR3hqT0IITK460rqRIUfVDu3HtCULEtRTnr3PiwwqY0PdwYnA8cqhX/Ry86BJfFiNeh0EsqdSvU
	0jJd3MpZK9CNDrkzivbuzw006nP1HAylS9yS1/i6hPSHUgL6B5YlOGB5optDduzD286Db83sATl
	is0z0OdpDfRu3cUzQ8Cp1ivhy7NGwiOM6xwxXNCr6JjElgW4aW0V0iTSACH69p1oc80REZTygwe
	SjevOjY4fOwa0ICGDa6HDXMq4PAU04ZPgUrrUZ6yhLly2POL+1KYz+qVGx/rTpyLFhczqYu/t+r
	4d61o89Fu0vyUWPFKRVCYzG/sXhGb2Cjxef1glAlRAoDeZYAgjDm
X-Received: by 2002:a05:600c:8b27:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-488d687664emr339471615e9.17.1776345098666;
        Thu, 16 Apr 2026 06:11:38 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5854163sm53613345e9.13.2026.04.16.06.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:11:38 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:11:36 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 1/7] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
Message-ID: <681fc6e748330e6a765a89f7193c17b33d4ea26f.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

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

[1] commit b254c6d816e5 ("bpf: Simulate branches to prune based on range violations")
[2] commit a2a14e874b4e ("bpf: Exit early if reg_bounds_sync gets invalid inputs")

Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 213 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e4980128151..1d5d2b7e5140 100644
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
@@ -2397,6 +2400,206 @@ static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
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
+	 * there is an intersection. If s64 range does not cross the -1/0 sign
+	 * boundary, then we can treat it as a u64 range and check if its bounding
+	 * values are outside the u64 range. If s64 range crosses the sign boundary,
+	 * then it spans the u64 intervals [0, smax] and [smin, U64_MAX].
+	 * Intersection exists if the u64 range overlaps either of these components.
+	 */
+	if ((u64)smin <= (u64)smax) { /* s64 does not cross the sign boundary */
+		if ((u64)smax < umin || umax < (u64)smin)
+			return false;
+	} else {
+		if ((u64)smin > umax && (u64)smax < umin)
+			return false;
+	}
+
+	/*
+	 * Intersect u64 with tnum. If the bounding values of tnum when mapped to
+	 * the u64 domain are outside the bounding values of u64, there is no
+	 * intersection. However, it is also possible that the tnum "jumps over" the
+	 * u64, making the u64 range lie entirely "in-between" the tnum:
+	 *
+	 * u64:  ----[xxxxxx]------
+	 * tnum: -x-----------x----
+	 *
+	 * In this case, if the next tnum value after umin is beyond umax, there is
+	 * no intersection.
+	 */
+	if (tmax < umin || tmin > umax)
+		return false;
+	if (t.value != (umin & ~t.mask)) {
+		if (tnum_step(t, umin) > umax)
+			return false;
+	}
+
+	/*
+	 * Intersect s64 with tnum. Similar to u64-tnum, but we map s64 to u64
+	 * domain and check if there is an intersection with tnum. If s64 range does
+	 * not cross the -1/0 sign boundary, we can treat it as a normal u64 range
+	 * and check intersection with the tnum as above. If s64 range crosses
+	 * the sign boundary, it spans the u64 intervals [0, smax] and [smin,
+	 * U64_MAX]. Intersection exists if the tnum overlaps either of these
+	 * components. The tnum cannot "jump over" either of these two intervals,
+	 * because they contain endpoints 0 and U64_MAX respectively. So it is
+	 * sufficient to check if the bounding values of tnum are outside the
+	 * bounding values of the mapped s64.
+	 */
+	if ((u64)smin <= (u64)smax) { /* s64 does not cross the sign boundary */
+		if (tmax < (u64)smin || tmin > (u64)smax)
+			return false;
+		if (t.value != ((u64)smin & ~t.mask)) {
+			if (tnum_step(t, (u64)smin) > (u64)smax)
+				return false;
+		}
+	} else { /* s64 crosses the sign boundary */
+		if (tmin > (u64)smax && tmax < (u64) smin)
+			return false;
+	}
+
+	/* Intersect u32 with s32. This case is similar to u64-s64 */
+	if ((u32)s32_min <= (u32)s32_max) {
+		if ((u32)s32_max < u32_min || u32_max < (u32)s32_min)
+			return false;
+	} else {
+		if ((u32)s32_min > u32_max && (u32)s32_max < u32_min)
+			return false;
+	}
+
+	/* Intersect u32 with tnum. This case is similar to u64-tnum */
+	if (t32_min > u32_max || t32_max < u32_min)
+		return false;
+	if ((t32.value != (u32_min & ~t32.mask)) && (tnum_step(t32, u32_min) > u32_max))
+		return false;
+
+	/* Intersect s32 with tnum. This case is similar to s64-tnum */
+	if ((u32)s32_min <= (u32)s32_max) {
+		if (t32_min > (u32)s32_max || t32_max < (u32)s32_min)
+			return false;
+		if (t32.value != ((u32)s32_min & ~t32.mask)) {
+			if (tnum_step(t32, (u32)s32_min) > (u32)s32_max)
+				return false;
+		}
+	} else {
+		if (t32_min > (u32)s32_max && t32_max < (u32)s32_min)
+			return false;
+	}
+
+	/*
+	 * Intersect u64 with u32. If the u64 range spans >=U32_MAX values then an
+	 * intersection is guaranteed, so we skip that case. Otherwise, we map the
+	 * u64 bounds to the u32 domain and check if the new u32 range intersects
+	 * with the u32 bounds. When mapped, the u64 range might cross the U32_MAX
+	 * boundary. If it doesn't cross the boundary, it forms a single contiguous
+	 * range: [(u32)umin, (u32)umax] that we can check intersection with u32
+	 * bounds. If it does cross the U32_MAX boundary, we get two contiguous
+	 * ranges: [0, (u32)umax] and [(u32)umin, U32_MAX]. We check if any part of
+	 * the u32 bounds overlaps with either segment, which is equivalent to
+	 * ensuring the u32 bounds are not trapped between (u32)umax and (u32)umin.
+	 */
+	if (umax - umin < U32_MAX) { /* u64 range does not span the entire 32-bit domain */
+		if ((u32)umin <= (u32)umax) { /* mapped u32 range is a single contiguous range */
+			if ((u32)umax < u32_min || u32_max < (u32)umin)
+				return false;
+		} else { /* mapped u32 range crosses the U32_MAX boundary */
+			if ((u32)umin > u32_max && (u32)umax < u32_min)
+				return false;
+		}
+	}
+
+	/*
+	 * Intersect u64 with s32. This case is similar to u64-u32, but the u64
+	 * range is mapped to the s32 domain, where it might cross the
+	 * S32_MIN/S32_MAX boundary. If it doesn't cross the S32_MIN/S32_MAX
+	 * boundary (it might still cross the -1/0 sign boundary), we check for
+	 * overlap in the standard way. Otherwise, we get two contiguous ranges (one
+	 * of which crosses the S32_MIN/S32_MAX boundary, and might also cross the
+	 * -1/0 sign boundary): [S32_MIN, (s32)umax] and [(s32)umin, S32_MAX].
+	 * Intersection exists if the s32 bounds overlap with either segment, which
+	 * is equivalent to ensuring the s32 bounds are not trapped between
+	 * (s32)umax and (s32)umin.
+	 */
+	if (umax - umin < U32_MAX) { /* u64 range does not span the entire 32-bit domain */
+		if ((s32)umin <= (s32)umax) { /* mapped s32 range is a single contiguous range */
+			if ((s32)umax < s32_min || s32_max < (s32)umin)
+				return false;
+		} else { /* mapped s32 range crosses the S32_MIN/S32_MAX boundary */
+			if ((s32)umin > s32_max && (s32)umax < s32_min)
+				return false;
+		}
+	}
+
+	/*
+	 * Intersect s64 with u32. This case is similar to u64-u32, but the s64
+	 * range is mapped to the u32 domain, where it might cross the U32_MAX
+	 * boundary. If it doesn't, we check for overlap the standard way. If it
+	 * does, we check that the u32 bounds are not trapped between (u32)smax and
+	 * (u32)smin.
+	 */
+	if ((u64)smax - (u64)smin < U32_MAX) { /* s64 range does not span the entire 32-bit domain */
+		if ((u32)smin <= (u32)smax) { /* mapped u32 range is a single contiguous range */
+			if ((u32)smax < u32_min || u32_max < (u32)smin)
+				return false;
+		} else { /* mapped u32 range crosses the U32_MAX boundary */
+			if ((u32)smin > u32_max && (u32)smax < u32_min)
+				return false;
+		}
+	}
+
+	/*
+	 * Intersect s64 with s32. This case is similar to u64-u32, but the s64
+	 * range is mapped to the s32 domain where it might cross the
+	 * S32_MAX/S32_MIN boundary. If it doesn't, we check for overlap the
+	 * standard way. If it does, we check that the s32 bounds are not trapped
+	 * between (s32)smax and (s32)smin.
+	 */
+	if ((u64)smax - (u64)smin < U32_MAX) { /* s64 range does not span the entire 32-bit domain */
+		if ((s32)smin <= (s32)smax) { /* mapped s32 range does not cross S32_MAX/S32_MIN boundary */
+			if ((s32)smax < s32_min || s32_max < (s32)smin)
+				return false;
+		} else { /* mapped s32 range crosses the S32_MAX boundary */
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
@@ -15493,7 +15696,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
 	 * TRUE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
+	if (!reg_bounds_intersect(&env->false_reg1) || !reg_bounds_intersect(&env->false_reg2))
 		return 1;
 
 	/* Jump (TRUE) branch */
@@ -15505,7 +15708,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
 	 * Only FALSE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
+	if (!reg_bounds_intersect(&env->true_reg1) || !reg_bounds_intersect(&env->true_reg2))
 		return 0;
 
 	/* Both branches are possible, we can't determine which one will be taken. */
-- 
2.43.0

