Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED6434E5F
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121129; cv=none; b=NjqGP0jiRIpv1JzR6rdmkVDCfo3hW24QhjhUgwI88CBjH4WGqrL8fAr5pOdGataCQosYgGkEUhoDgmHpa0DwDRfIg6al0y1rCO+r2mXfYFBJP3ZDbRtQFDrLxsaGWHpnrP5c67DNhuhrR2rUhnY/iVwNDTrPWiKVnV72mEeyC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121129; c=relaxed/simple;
	bh=TuOnTQNMi/XtXEodS3adlyioSZfcnetEH+Z6rue79zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAAoeggs+NMSXcmKv+qWos1HHXsH1WjIVSglx25c3sba9/P3ctVs9ULm9rP4xPm69X/SFQJMwueV8c23h+Us2z7/TIl5OOQXQ2M/T0owMGFB1Vv0bW2kDX4rREXORVROoTn6JJsJ+rMKW6wgNYWypUgaqg4IW9haWNOCqsAYBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLfGwMoo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLfGwMoo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a49623b865so439740a91.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121127; x=1791725927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p72f2E8ZaLO4ZyOI6LIBtbL3Tzn16u3BxVLIvBobADA=;
        b=eLfGwMooOHo8Sb20LM9WG2PTeQD48DLpBGqDvlZm0AiLWAnfz9EgyrCoy/klaOh01h
         qCCeY2VMZZNxfyWOWUaxDAXqL2GwGRTJM1CwmSG4b206RdbIf5Cpy0meNtXn2ImVtoWs
         WokBb0gW0AapFZbrktvrtfBjhDWifTNUbbkfHlODujVFT/uUoMlTloityg3vSKVYN2yr
         qjnI699nPUBqpLvc3WaJh1n+vQNPqfQ8FDw7uSGnixT4TN1Ib4D6Si8In32IA6ic71Ap
         Xpz/Ql/vz+7VFToOYIXvDKyu9X5EcYwooCMpYTn1YrJqelUcmvX9uH90gwaOxo/ySkbh
         6quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121127; x=1791725927;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p72f2E8ZaLO4ZyOI6LIBtbL3Tzn16u3BxVLIvBobADA=;
        b=MWOUrb7/JSLu6OzGqMocKqnLFlALHWSn3Fb5K1Lz7TW0fY/nq9kwcscmcJkKgQ2I6p
         0Of7Bkz25I5nH7O8tjw4DRJXfdRvibQwFiW8DLTQn4Okh/kodxWTrEChG1j3CCntgQcn
         haktCcpdNSrcIgXSCwGTv1WIfXaCxjhQ5INAZ43yOskaI359sJnlV/Lz4ENj+b808PVy
         mUUde9bTg5dFw6lf72Wzi1NZFD3YwAoX/rthtBBAImVoDqEKDFH40mBK2h3JXbDBpspf
         B/j3jUGh24hnH0b2Ks7Z/AyPcsspaeHAn/ip9GI4zUElN60lPS06e5jSjLnV8z16U2dP
         k/dw==
X-Gm-Message-State: AFq9FYL9Vg7IqIYLWM41grzRcw/3BZUl8wjximuLZZR8/hkhoGggSFip
	Rm2OCMIfqBJgZpW+Yp9MLtkuZYHZFX26rJ3RBjfdOKw0olxqMK/SWeO56Ngziw==
X-Gm-Gg: AYBFou1mRk1IrjpTZLxu+4KlKG3Uu+OaJ1nyF7XbEfhjauC+o2LWOcG+wliqoKSsayg
	w+FamWxatOsLQKi3KYUk+9gpRPEogRKfBeQMMisW4t3licVsq5IFVeRPtRYdjax2ViPp+kKZ30p
	wGMXxAx5LwByy39XDrcmcaFAR1Tg7xoSZEXk9rrWhXadk8ArVS4Ry9DfVks4/521q8c2CDGperS
	OzSlhSbLr0TAuY66ATUfTFcFGkHJnMWzfI/v3Uur9gQa7ilpJVSGNHDsV34s3Ti2RZSwrrQbsVD
	yL+jRjLHA2+kJ2bQYakSu7nbyxyIsZ09l/dW6HcxZ3ojDi7HzFnQnz1jPG3/7bCFW+IsCWUeWIX
	TGvpl7SFFyPcd8i19v/cbmaKjkLLIBrje8CCpQzubwCF0ay8gl8ZG6qhTBL2AyRWikbWuJuS2Fi
	epu1bNq+mKcIB2HJFZPyutRYVsSMzLSE1aOKFCIa2b25MaH2mhcKDJ7PK9PeFmWXOgGv8yn10HU
	PwA2HudqckSIZc=
X-Received: by 2002:a17:90b:4f:b0:3a0:deda:3d07 with SMTP id 98e67ed59e1d1-3a787181df6mr3529853a91.14.1791121127451;
        Sun, 04 Oct 2026 06:38:47 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 11/43] bpf: add cnum64_intersect_linear()
Date: Sun,  4 Oct 2026 06:37:53 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-11-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add cnum64_intersect_linear(), which intersects a cnum64 interval with the
set of integers congruent to 'base' modulo 'step', i.e. the points
base + step * k. It tightens the interval by rounding its signed minimum up
and its signed maximum down to the nearest such point, and returns an empty
cnum when no point falls within the interval.

The arithmetic is done on the signed bounds [smin, smax]. The line is defined
over the integers, while a cnum64 is an arc on the u64 circle, so a u64-modular
computation would misplace the line for negative values whenever 'step' does
not divide 2^64. Working from the signed bounds keeps the residues consistent,
e.g. it can reason about a range like [-9, 3] with step 3.

Also add imod() to bpf_verifier.h: a mathematical modulo returning an
always-non-negative residue (unlike C's '%', which follows the sign of the
dividend). It is used by cnum64_intersect_linear() and by the base/step
tracking added in subsequent patches.

This is a building block for tracking scalar registers whose value is known
to lie on a line base + step * k.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 14 ++++++++++++++
 include/linux/cnum.h         |  1 +
 kernel/bpf/cnum.c            | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d31c1a500958..79ca8b28a83a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -9,6 +9,20 @@
 #include <linux/filter.h> /* for MAX_BPF_STACK */
 #include <linux/tnum.h>
 #include <linux/cnum.h>
+#include <linux/math64.h> /* for div_s64_rem() */
+
+/*
+ * Mathematical modulo, the residue of 'v' modulo 'step', normalized to [0, step).
+ * This differs from C's '%' operator, which truncates the quotient toward zero
+ * and so returns a remainder with the sign of the dividend (e.g. -1 % 3 == -1, not 2).
+ */
+static inline u16 imod(s64 v, u16 step)
+{
+	s32 rem;
+
+	div_s64_rem(v, step, &rem);
+	return rem < 0 ? rem + step : rem;
+}
 
 /* Maximum variable offset umax_value permitted when resolving memory accesses.
  * In practice this is far bigger than any realistic pointer offset; this limit
diff --git a/include/linux/cnum.h b/include/linux/cnum.h
index ddf4726841e6..49160318adf9 100644
--- a/include/linux/cnum.h
+++ b/include/linux/cnum.h
@@ -80,5 +80,6 @@ bool cnum64_is_subset(struct cnum64 outer, struct cnum64 inner);
 
 struct cnum32 cnum32_from_cnum64(struct cnum64 cnum);
 struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b);
+struct cnum64 cnum64_intersect_linear(struct cnum64 in, u16 base, u16 step);
 
 #endif /* _LINUX_CNUM_H */
diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
index 86142cb2aee5..8ec5187d7c75 100644
--- a/kernel/bpf/cnum.c
+++ b/kernel/bpf/cnum.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bits.h>
+#include <linux/bpf_verifier.h> /* for imod() */
 
 #define T 32
 #include "cnum_defs.h"
@@ -118,3 +119,38 @@ struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b)
 	}
 	return t;
 }
+
+/* Intersect 'in' with the set of integers defined by equation 'base + step * k'. */
+struct cnum64 cnum64_intersect_linear(struct cnum64 in, u16 base, u16 step)
+{
+	s64 smin = cnum64_smin(in);
+	s64 smax = cnum64_smax(in);
+	s64 lo, hi;
+	u16 d;
+
+	if (step <= 1 || cnum64_is_empty(in) || cnum64_srange_overflow(in))
+		return in;
+	/*
+	 * Round smin up to the next value congruent to 'base' modulo 'step',
+	 * i.e. increase smin by d = (base - smin) mod step:
+	 *
+	 *                 |<---- d ---->|
+	 *     |-----------|=============|...
+	 * base+step*k    smin       base+step*(k+1)
+	 */
+	d = imod(base - imod(smin, step), step);
+	if ((u64)smax - (u64)smin < d)
+		return CNUM64_EMPTY;
+	lo = smin + d;
+	/*
+	 * Round smax down to the previous value congruent to 'base' modulo 'step',
+	 * i.e. decrease smax by d = (smax - base) mod step:
+	 *
+	 *     |<--- d --->|
+	 *  ...|===========|-------------|
+	 * base+step*k    smax       base+step*(k+1)
+	 */
+	d = imod(imod(smax, step) - base, step);
+	hi = smax - d;
+	return cnum64_from_srange(lo, hi);
+}

-- 
2.53.0
