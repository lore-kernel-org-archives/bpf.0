Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7F4C33DC
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542926; cv=none; b=AAFpf1ajIgq+LUaaGkxQ9rI06Sj0c+fvejOjI2tbc6X/yyZdd5hWtMyX7uN1toH8nKVVSeeeggSe0FKnEHkV3zAZOAwy7uTXs2Hqi6h+UZq+UO/HWkNCtif6oXizZjRFOgK5mmX/Zi6en2pZ/zsWNOKwkEeEVF7m/bUZVR/dJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542926; c=relaxed/simple;
	bh=MDuY9aRcJIxf4+qDsTcXrvdw1jYurKQHxAycH3Njrlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0uS95pO7EnoZD5M3NTAKRHcbTomEn/anJ+n1tlvGjcClmr6oA6vLzEkt9TOIGBGD5jMMvw/ep6ZyQDoQya8ETfjn8WiPtU72Op3143ljIzFKPss/skJkrT1WhSuf93LaxANtqx8cUCLR02ZLVu/n9qjRPGAQbhNEB5hOOTTnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjffkB7y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjffkB7y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab33730821so370181a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542909; x=1792147709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8q9Pz4c5sMGMdFy6E5oN0CPV5HljLFMVuaPl5Dhfavo=;
        b=MjffkB7yxeKe08zgBlTbJsIjOOTbDe5Fxnk/M3umnD05bNZ/wXVX5EzdwuYpCAALhp
         d75TWkf5kVIsKI1d47K17SlYWjHgGIbRLe+Uc+j2S8Vvzj6tvIdyPdafm5/acRLaV8yU
         rqvclG0oFy1bHfA1U9K6gdC9B6Xabi4q6sp54DEPf1x30VUFSirjTYBSCy0ysFavXqaN
         qIdwG9s01mjETisRO3XZ+r/+P3gRXtrIrroCNHglo9rcF3Lxj4XulgS3/0R2kp/sYe5b
         HiBcIFlEPRMSgQFcG/70Fh2rHG+/uUG26vGftR58XE52Zg6+A6AXHjZ8m3/DAPSVwOh7
         xXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542909; x=1792147709;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8q9Pz4c5sMGMdFy6E5oN0CPV5HljLFMVuaPl5Dhfavo=;
        b=Ws+KoQeSPUsu30GlywwF2qrxVAqb+Ul9RQlblqQ1ziifbmT+qmnViqnzYV3G468lxF
         X6Nb8GU9BVmtB6RUn6ZmQuBUrpfTsHrtzd85C/nIIIfYx+xKDFPdfaJUfK6ivn8Sp+Dp
         2SVz3IMlT6mIK7t1xv5BL+vFptQFP9PT/vym76ZVKsrgx1VIMiD69NNynFPVHrQCzMoi
         kvBzm9fwaP6BIEhX/YUCzrsYAwatd23IOk0BsEKDKzLATQWgPVswpu3D7k2HEz6wsfB9
         gBM3Dzbm2QJbJL7yUllDQJO7umZBpP3Ysl5STInF1dYneKD++R1GtYqXCBXfaN81g0JF
         5erA==
X-Gm-Message-State: AFq9FYJHF5Bdw5Vhzer6sfktUTPNIsFputYh7d2O6XaV4LqFOblFZF2k
	tiSV+8dxplCyOksQdjX1chDJTG8atXAasBss6CWf3s4iy67H/+3khsg42Y/hL8ue
X-Gm-Gg: AYBFou1l8oj8pU+knstHMflqVyjffsPTiUMLpEYCbDF+BepQt49TzNeVsIQKIyr9Dre
	HlR7A3kcbmciH5N0qHZFSoN7ybQOFivVC+KjmxxfUHFqJ9buUml8hC4glIsKXAb4rh/FrjZ4WCe
	YB55Cxh14mUUZfpw5cLTaPGww8KK4itQ6BnbsTmLL8EHN/M+aQ+b61pU46Udl26SfUVCyMzc1SS
	G4NNUauZ/9EZrLUQmFTCGh/Nmvj06p6LbfU1tgthN+F2j8iKLkvsRCPBhso8A1cdBGoypC5F297
	qZ8gp+JT6s4DNymzRqZI9j9jrhy3JBxVkB0ghzv+UVbAfV6+7b7mGOELw+FRh1bazvtept7M1RZ
	eGU6i00lY7CqxH58cYJdIG+JZdG86Xh8ux1DRysiMflaAqsz6gIpIJqqy5QPqy5DVqC/l0GaLQu
	/Aad6ID4DrWQsI34Ew6do2KUH1mAVC32P4oTpARefnv47WQKo0C/7TS4Pp4lgZkfBRTEn9dWx8M
	MbEg7QqEVply/k=
X-Received: by 2002:a17:90b:3b48:b0:3a4:dc2c:be9e with SMTP id 98e67ed59e1d1-3ab3a8d5755mr1419953a91.51.1791542909027;
        Fri, 09 Oct 2026 03:48:29 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 14/51] bpf: add cnum64_intersect_linear()
Date: Fri,  9 Oct 2026 03:47:32 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-14-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
index 05e6f091ad94..0422d4a1be01 100644
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
