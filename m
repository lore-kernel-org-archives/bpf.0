Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFE598C05
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202965; cv=none; b=JjbGZ9saI/AgNp9MuQxEoSCTNq1dBu2XRxsbP7Xtf3bx/4K2VZKRhiSfgEHD3iRo5IR5qjCzl1L8Q0KwjIZIkOOk1n5c7WTJgUqmp4uS7jYztN2yDafpJ4EnnOVENbMeQiNf5579xOS3gLGxE7ReO0LgRIVL7CN+20zlK2s6QT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202965; c=relaxed/simple;
	bh=+9Pk8hLj7O3LiYYS2uT0oBFVa0AZns7C2G+msrYdaOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpqNGJHs/1a/7xCTYoWKCQBQYIHi9ieRDqGsSJyZKK5L+ASQDr7I8VimqbQBDuXx9Z4qkkLscllInXB5v/8lisgmtl7t5Yo/l1/Tc0FJ+ayrchAgiAzwlbY9gHq7q4XfxDRTxZvHWLH6yOmIDeYcLZclPVesfWbMeMmZnTiCcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBSuVha5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBSuVha5"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd77300825so9204265ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202961; x=1790807761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3HkDqFc+t/oNfAFzxW62ZNpAB0nHFCeqsGXFkzhICzA=;
        b=lBSuVha50NTnHvYvJHE5rZVXabqBhKKpgOpSeYtNkdAHCLe98l4kwb0tYIR7Zsbxrz
         mYrq8LvnMcV4TWfM+gKOZUqgZ+kZe42pmuDSDS5J+vWU+42Uxcz1EZI8AWltHEEGI3jz
         s6vhGZTI1VS/ClZnKdhcN4kjcauZByANsX1QzPV8/NTo4G2WUx/rm+jEJadV0IdWQKr/
         eOQO30hjU4zq19+OCFpuSWKPu29tEOwvFvT7AkgD0fu6amTD1uWy2BbQ0tEDXJir09xR
         3uLl7Mx8+eaZHbrTh7M4LtEITunUCyhRQM40r/IXx+yJusRjsuQ9aReY03/qPdoNsPCu
         nWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202961; x=1790807761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3HkDqFc+t/oNfAFzxW62ZNpAB0nHFCeqsGXFkzhICzA=;
        b=jPoBD6IRfJpZZhxOLf3LzCg/to60Xl0qJL2GvnOjDWFB3pc9tuvaG54Qr+ghmZClsT
         bK3oeuj8ofMTh5bJMwE2+lmz3zwHP2Pn4cw+/2+XlqqdPnOg2gEHBKa4fHSjU9gIRi0R
         b5c6NOcyLEZh9abs81hYlrZSXJqhLbcx+osxLeAS368wV5UxX3bi19VMQJRlTXikehjW
         Ryu5suTuGO7VSPYQjAoPxyGFqmXHslagdRGGl2wdqerjb7yFKEKaGw03ybiwrwRR9DUJ
         7k1vor6njCawjVqioij5kjhkAx59nG0DyROk0ktM/v6iMPpttuyg4a1FQcA2IDcJvHKJ
         9O/w==
X-Gm-Message-State: AFuF++kDcrtQsrMMIvdbejuoEPHzxedWI/1amd0YcY8XbR0dafURzA7k
	lyhf98cPvke0N3a/9cM/qqnZLE5Ah5++6cFTo2gZHdRmbEhiTKkDn6+qMOkd5Q==
X-Gm-Gg: AYBFou1JRvbN8Tp9JyV9VM8x2l2DhKOYCrHFyxBOAu7IiqTWP3uPQznRo7qikRRrye6
	CAEew9WnYHT+A19ZWSieEpx1B23mw+OPUXuQF1dT7CCBCkQ0yU0EPFRMOz18C910+8vLyMSQu+u
	IpVEnUafzYLYaWdnEXFXgnWV4k1qCoPI8teVt/EV4rSH7uFBKGYKBJJEe5bOhGc3JfUx0+gGfl3
	IO6Puz2b0/WLOmStlXPKdHj4hiKH0L/H1CH1lTfIlmDpMGuvCMgET+UZN/HG7kLcixgJ6xH9cJE
	eG02sE0qLRviDelgMVx3/x856olWiEGZJYODiV3Tl0/g0wfse0Tx0v4/RbgDN3ZanszaCdUDQIv
	Gx1Yr/GfjEbHY9R1W1MXy2eBLS6IdhpSU5uBCZSMVW8TJ5Qj7QYsG/tBgoTROsvlbs0U9utrSpG
	dSbK7LPLuJ1CN0evfVYcqf7jKJoAuPfvEL5JfykyJ1Zoymxp5V/d8v7S6dyFGg8Cl9WKhjUU59P
	Ft5W4WkOQXN6hk+pzMfexzFcBYu4eUxczJ3/sHt4TJhXZjBaE/oXRXuy+FnCrYqphglaGtlnvpe
	7JCkLBSIe8s6RwMQnMarORNyewV0TIa1icANj2TfhBE=
X-Received: by 2002:a17:902:d2c5:b0:2df:7001:1f74 with SMTP id d9443c01a7336-2df7de90e91mr4619685ad.61.1790202960826;
        Wed, 23 Sep 2026 15:36:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5db266sm17124885ad.59.2026.09.23.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/8] bpf: Trim range ends to var_off members
Date: Wed, 23 Sep 2026 22:35:47 +0000
Message-ID: <20260923223554.562379-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

__update_reg{32,64}_bounds() intersect the range with [tnum min, tnum max],
but the ends of the result can still be values that are not members of
var_off. For example var_off=(0x0; 0xfc) umax=255 where 252 is the largest
possible value.

Move both ends of r64 and r32 inwards to the nearest member of var_off.
Values dropped from the ends are not members of var_off, so the set of
values described by the register doesn't change. If the range has no
member of var_off it is left as is.

It matters when a loop counter is tracked as a range. In the loop:

  13: (07) r6 += 4
  14: (55) if r6 != 0x190 goto pc-5

r6 of [0, 399] with var_off=(0x0; 0x1fc) at the loop head becomes
[4, 403] after insn 13 and insn 14 cannot cut it. With the ends trimmed
the ranges are [0, 396] and [4, 400]. Insn 14 cuts 400 off and r6 that
goes back to the loop head is within the range it started with.

No veristat changes in selftests.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..cb5d498ada69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2094,9 +2094,71 @@ static struct cnum64 cnum64_from_tnum(struct tnum tnum)
 		return cnum64_from_urange(tnum.value, (tnum.value | tnum.mask));
 }
 
+/* smallest member of @t that is >= @x, wraps around to the smallest member of @t */
+static u64 tnum_member_ge(struct tnum t, u64 x)
+{
+	if ((x & ~t.mask) == t.value)
+		return x;
+	if (x > (t.value | t.mask))
+		return t.value;
+	return tnum_step(t, x);
+}
+
+/* largest member of @t that is <= @x, wraps around to the largest member of @t */
+static u64 tnum_member_le(struct tnum t, u64 x)
+{
+	/* members of 'tc' are bitwise complements of members of 't' */
+	struct tnum tc = { .value = ~(t.value | t.mask), .mask = t.mask };
+
+	return ~tnum_member_ge(tc, ~x);
+}
+
+/*
+ * Move both ends of arc @c inwards to the nearest members of @t.
+ * Values that are dropped are not members of @t.
+ */
+static struct cnum64 cnum64_tighten_by_tnum(struct cnum64 c, struct tnum t)
+{
+	u64 lo, hi, dlo, dhi;
+
+	if (cnum64_is_empty(c) || c.size == U64_MAX || !t.mask)
+		return c;
+	lo = tnum_member_ge(t, c.base);
+	dlo = lo - c.base;
+	if (dlo > c.size)
+		return c;
+	hi = tnum_member_le(t, c.base + c.size);
+	dhi = c.base + c.size - hi;
+	if (dhi > c.size - dlo)
+		return c;
+	return (struct cnum64){ .base = lo, .size = c.size - dlo - dhi };
+}
+
+static struct cnum32 cnum32_tighten_by_tnum(struct cnum32 c, struct tnum t)
+{
+	struct tnum tc;
+	u32 lo, hi, dlo, dhi;
+
+	t = tnum_subreg(t);
+	if (cnum32_is_empty(c) || c.size == U32_MAX || !t.mask)
+		return c;
+	lo = tnum_member_ge(t, c.base);
+	dlo = lo - c.base;
+	if (dlo > c.size)
+		return c;
+	/* complement within 32 bits */
+	tc = (struct tnum){ .value = (u32)~(t.value | t.mask), .mask = t.mask };
+	hi = ~(u32)tnum_member_ge(tc, (u32)~(c.base + c.size));
+	dhi = c.base + c.size - hi;
+	if (dhi > c.size - dlo)
+		return c;
+	return (struct cnum32){ .base = lo, .size = c.size - dlo - dhi };
+}
+
 static void __update_reg32_bounds(struct bpf_reg_state *reg)
 {
 	cnum32_intersect_with(&reg->r32, cnum32_from_tnum(reg->var_off));
+	reg->r32 = cnum32_tighten_by_tnum(reg->r32, reg->var_off);
 }
 
 static void __update_reg64_bounds(struct bpf_reg_state *reg)
@@ -2105,6 +2167,7 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
 	bool umin_in_tnum;
 
 	cnum64_intersect_with(&reg->r64, cnum64_from_tnum(reg->var_off));
+	reg->r64 = cnum64_tighten_by_tnum(reg->r64, reg->var_off);
 
 	/* Check if u64 and tnum overlap in a single value */
 	tnum_next = tnum_step(reg->var_off, reg_umin(reg));
-- 
2.55.0

