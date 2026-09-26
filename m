Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262C468C1B
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432456; cv=none; b=YazU65C3gDYsHu5G5kYF9/E27MVIq/EWIxpOJLk191Wh6WDwII1npH1o9qDm9FLtJEvR8ZTxEfcof37/Bcd4//o05iaWamUcnwPkmUO19QI4jeOTzSNevaVrlgNJZkF9K88+cGVsmSKhcOPno0TyF4WQlrsgokIw7CASZoySr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432456; c=relaxed/simple;
	bh=sMmOIXkhzdwiRAFPqnKfagn9kBWVgxEvhTEJ7fo0iSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox8KFa6QI3EfVqRn7BYCxPGkZDG74zcQH3nIY2A0W+wtnAjeCm3Es3wSm2JMFPOhxkrE48fAEQ+Yqv3rJQZor3yUP5Qix7TQJucTqkDvdrcZcCWuaOX79mo7gfMP/s25swdvmQ+XqHqV9jbV4SCK/JgJ5kfhrd2CtxeZcaTW8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah0srfkm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah0srfkm"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1106200a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432454; x=1791037254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwfcDoC9E5kcfM6N0UZWGKAJlnd5sGUc3Iila3SpWys=;
        b=Ah0srfkmVv5ec8hf+rLz/ZTcKair/KOidUCDY66OFq4A9d0Po58c2hPt4JUIEBGKDG
         vB5I8vL0YTTXrKsztD2oD7xPpvoTiy4wVHEezz3PXSJ3VjIQwKEQy2sx55hTocszc/XD
         8taBbvnnelG1a6yy7TXLpGiTPo83b2+NYc9zM9rcc67NdzdHCTVq48PHGT/56CsBaBPd
         2RFqrjKMQJ/V+T0tz8+VHZj8Xfzcx08Z8xiZglQWoFIkO7vswYLyH5vJepEp9U3ktl+k
         W3tXPZ37rUhf7q/yHQbIJdJ9JF1ey5JwELvurXipJlXfH2F7uSip55GZs0Spwqe9ieBH
         MYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432454; x=1791037254;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwfcDoC9E5kcfM6N0UZWGKAJlnd5sGUc3Iila3SpWys=;
        b=tFPuiGbip16rAIJOfNWnoQUjAe0fPJIoBWIUMCOVwkoRokiwBg/96QB2ZLYvZXDAI+
         Vn6URZyegkeXx4edNwQmeR+85rHH8XQ+1Vzm6kcwIPli9lSzvzfHWAAIue76QVd+VyKL
         rlf3Kf/Fki0iOGY8t4Tro6tU2ohLSUYRfHiTDgECYnJq2EVffomRB7QZPpda/vSMg9LL
         SeAlnvKrwRLzm4OVnTDpJQpi1D7OHEDkfMWVdNldbxxERKKb+u2gWcITAEHOuET/h0pq
         k/kye+BeTPSLjG02YDjyhbz0XA+QIktQQx812NVrh+zIr2s9C7XL1RE45TS+UwEegwHm
         J7gQ==
X-Gm-Message-State: AFq9FYLeG2A1F7+X3vKp8Qxvbu9gC3viAmbuz19g0eVpSD+4n6YC3Mrc
	8WbyRU2+5LxgHOT+uPVVABfXARKY/EFiR0F8FHgs+ZvsXT44GJ/ObQESazKwvHj14pM=
X-Gm-Gg: AYBFou0txeT/DT2wxzSeBD3incGimBS3p0mzh/jaVDpR5xIGOrBZPvanlGqum+STtN4
	QVJeNIgYaz5Vldhkc6cs+MP4BAB6nc1YQXTEFoGm8pCHgoQFFU5/YLDITXDlEVZEbkxUOG33bb/
	gGdxFEeD66i5dJOZmghm1Nz8nBL9UVc4SqSXCqP8lGHcrQnoMQCz45GhQZ3BZgy0xCHtXZko934
	6OVtGgyDMSOyNIKiMqRGYqOIHlq0LVELEvQxeSySuFVtTNL1JOPBomXB02P2YFtgB4utL+CToPR
	EPfdX413BXeZmUXTnE/H0fAJmcMmKXStsdNyBvEDDuXXfkN2kDu1Qjv8F5fp01O/I9GSxz795yn
	aW6puoTn6lTbcCk7O6gQUK6/c5dQuklk2Wl6FcWw2vawrSEET4ua8V8OSZbLAhN2eqeLMi/a0Cn
	Hrb2L4kridjwrmOkJHwlEM26qJyeZiZEFr419vfS77FMqHbhJSJ7dakNLqr1dP5o3Wav1JNWm73
	N7R6hvDQkL00UQrwkZZ6WvrP55k68CB9uqC9kEONcD8h0GW7tjOICYQfwawZUg=
X-Received: by 2002:a17:90b:48d1:b0:3a0:e476:576b with SMTP id 98e67ed59e1d1-3a0e476584dmr1403717a91.37.1790432453794;
        Sat, 26 Sep 2026 07:20:53 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 08/36] bpf: add cnum64_intersect_linear()
Date: Sat, 26 Sep 2026 07:20:06 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-8-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
index c9fb0a9985d4..b6cfac01ef3f 100644
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
index 86142cb2aee5..2bff2c7e0cdf 100644
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
+	if (step <= 1 || cnum64_is_empty(in))
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
2.55.0
