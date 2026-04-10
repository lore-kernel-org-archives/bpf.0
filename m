Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D593181334;
	Fri, 10 Apr 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824857; cv=none; b=m4hZ3bp9SgEzy3QqJgWRBVl6n7DXI257UQeXp5sFCCyKa5vZFxxlbE5RLmGgB3Rp91sC+ZkVPxw9VX/jQmVjOCF/Sn6rK8pkhNmi0G0e8l+zJSJ0n2s7tiyBUpUtycldiQFHK8zAM5dOD0zcQG0EFfAk8QAQzVALG7S0uWEIbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824857; c=relaxed/simple;
	bh=f58Vx0UvA7DLYtnthJ1QgLCkjQluN/A7fbzZMZVhqNs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S71k/BSpRtRYlm6bD0Z91iE7Rs9pXib34qSvQUtk4WopfTUIFXA9p9NanKAyXWZU1mlwpXA0nwItdy2dR5sB+dlYzEyyjZrLQ+vNSCr7dEWKjCCqxF1HSk/WAYaA5PsSzioV95ElAKSzKN6OPv/PvxId4Nbw9C6lX9Yq005CdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ggFI/0Vf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ggFI/0Vf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GMOnElWjFvV7n3suXFvXe554PCnHWxci5bhcwLgnIF8=; b=ggFI/0VfSG4oIKeFuLShmEAOmc
	6Vl0ztbg2DMsBaw7gjp9DxBPLiWFLlzBiRe9B1CNBnWc9BRrqa1qezsQmxDzBcLHGJ4Cbc6SrYSF/
	iF9EcjXW1aJKM0pIcWyk1MinHJ7tNn2ENaLnJvzw0XGRiSthyhgd0/wk93/3//WkVw+ZC2m3fXzgf
	QUCGM4i4FcUwPqVqimJWRomxcPmy3qoPGl6DSy5H84bXv+plns0CVPM/0T+pFt097isuGAYvxagTT
	2E/6tVmAFyqsWxD800mMLnxeuZ+4Jy1PIzFM+DwLXBMdXEEDl+5eHYKUnYSTh5qJvcnHZWplQfEfy
	zRfpax3Q==;
Received: from [179.244.2.202] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wBBAG-00EMz1-0g; Fri, 10 Apr 2026 14:40:48 +0200
From: Helen Koike <koike@igalia.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	yonghong.song@linux.dev,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	koike@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with circular range logic
Date: Fri, 10 Apr 2026 09:40:27 -0300
Message-ID: <20260410124035.297632-1-koike@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify handling of signed and unsigned using circular range logic.

Signed and unsigned numbers follows the same order in bit
representation. We can think of it as a clock, were 12h is
0x0000_0000 and 11h is 0xFFFF_FFFF, regardless of its sign.

Then, instead of dealing with max and min, we deal with a base and len,
where len = max - min.

Example:
    range [-1, 3] is represented by base=0xFFFF_FFFF len=4
    since (u32)3 - (u32)-1 is 4.

And we can verify if a value v is in range if:
    (u32)(v - base) <= len
which is true if v is signed -1 or v is unsigned 0xFFFF_FFFF.

This automatically handles the wrapping case, discarding the need to
check if it crosses the signed range or not and handle each case.

It also fixes the following current issues:
* [(u32)umin, (u32)umax] falling outside of [u32_min_value, u32_max_value]
* [(u32)umin, (u32)umax] falling in the gap [(u32)s32_max_value, (u32)s32_min_value]

Fixes: c51d5ad6543c ("bpf: improve deduction of 64-bit bounds from 32-bit bounds")
[Circular representation]
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Helen Koike <koike@igalia.com>

---

This is a follow-up from discussion:
  https://lore.kernel.org/all/7fb97184-baaa-4639-a0b9-ac289bf2e54d@igalia.com/

I didn't tag this as v2 since it is a completely different
implementation.

I did do an implementation[1] without circular range logic, by using
if/elses blocks, but it feels I'm always missing a corner case and using
circular range logic feels safer.

Eduard, I didn't use the exact code you pointed, since it seems it is
covered by your RFC, so I used the logic just for this case while your
RFC doesn't move forward.

Please let me know what you think.

[1]
https://github.com/helen-fornazier/linux/commits/bpf-min-max-if-else-solution/
(3 last commits)

Thanks,
Helen
---
 kernel/bpf/verifier.c | 77 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..2944c17d2b7b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2700,6 +2700,48 @@ static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
 	}
 }
 
+/*
+ * Find the smallest v >= lo such that (u32)v is in the circular u32 range
+ * [b_min, b_max] (b_len = b_max - b_min wraps naturally for wrapping ranges).
+ */
+static u64 u64_tighten_umin(u64 lo, u64 hi, u32 b_min, u32 b_max)
+{
+	u32 b_len = b_max - b_min;
+	u64 a_len = hi - lo;
+	u64 cand;
+
+	/* lo32(lo) already in [b_min, b_max]? */
+	if ((u32)((u32)lo - b_min) <= b_len)
+		return lo;
+	/* Set lo32 to b_min and check if it's in the range [lo, hi] */
+	cand = (lo & ~(u64)U32_MAX) | b_min;
+	if (cand - lo <= a_len)
+		return cand;
+	/* Advance to the next 2^32 block */
+	return cand + BIT_ULL(32);
+}
+
+/*
+ * Find the largest v <= hi such that (u32)v is in the circular u32 range
+ * [b_min, b_max].
+ */
+static u64 u64_tighten_umax(u64 lo, u64 hi, u32 b_min, u32 b_max)
+{
+	u32 b_len = b_max - b_min;
+	u64 a_len = hi - lo;
+	u64 cand;
+
+	/* lo32(hi) already in [b_min, b_max]? */
+	if ((u32)((u32)hi - b_min) <= b_len)
+		return hi;
+	/* Set lo32 to b_max and check if it's in the range [lo, hi] */
+	cand = (hi & ~(u64)U32_MAX) | b_max;
+	if (hi - cand <= a_len)
+		return cand;
+	/* Retreat to the previous 2^32 block */
+	return cand - BIT_ULL(32);
+}
+
 static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 {
 	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
@@ -2714,19 +2756,28 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 	 * with are well-formed ranges in respective s64 or u64 domain, just
 	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
 	 */
-	__u64 new_umin, new_umax;
-	__s64 new_smin, new_smax;
-
-	/* u32 -> u64 tightening, it's always well-formed */
-	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
-	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
-	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
-	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
-	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
-	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
-	reg->smax_value = min_t(s64, reg->smax_value, new_smax);
+	u32 b_min, b_max;
+
+	/*
+	 * If [u32_min_value, u32_max_value] is conservative, i.e. [0, U32_MAX],
+	 * use [s32_min_value, s32_max_value] for tightening.
+	 */
+	if (reg->u32_min_value == 0 && reg->u32_max_value == U32_MAX) {
+		b_min = (u32)reg->s32_min_value;
+		b_max = (u32)reg->s32_max_value;
+	} else {
+		b_min = reg->u32_min_value;
+		b_max = reg->u32_max_value;
+	}
+
+	reg->umin_value = u64_tighten_umin(reg->umin_value, reg->umax_value, b_min, b_max);
+	reg->umax_value = u64_tighten_umax(reg->umin_value, reg->umax_value, b_min, b_max);
+
+	/* u32 -> s64 tightening uses the same circular algorithm. */
+	reg->smin_value = (s64)u64_tighten_umin((u64)reg->smin_value, (u64)reg->smax_value,
+						reg->u32_min_value, reg->u32_max_value);
+	reg->smax_value = (s64)u64_tighten_umax((u64)reg->smin_value, (u64)reg->smax_value,
+						reg->u32_min_value, reg->u32_max_value);
 
 	/* Here we would like to handle a special case after sign extending load,
 	 * when upper bits for a 64-bit range are all 1s or all 0s.
-- 
2.53.0

