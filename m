Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186F4BD79E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542920; cv=none; b=OceOB6eQAXGFbWGD1u4+3oZwytAILD9QjN2PWwWBxDfdV9mPYmp2/dgSxpfV8YRu97Hw2lPqO0eP8njaTx8KwbEyFt/E3OA3XsY+0j1nOuZ5ldp3NVvFU8nJE6n/+xu19tC+nN9fHoNBTiPx/sC2/EPmiPq8NIArlGp5R4adgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542920; c=relaxed/simple;
	bh=I4sSQfnTXzSEZ50MVAEDsmLeM66GZKdoFlkeV6vWYMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUqH01mwCduwsXjldQ8mOj4AqlS64B23n5bO1wBFucmL5/nfqJw5co3dATaUXWhjinZ5U/oZhaekIa4jngKP9TICzW7ee81lEE9v9UZCe+oVUi3tc43Q3XRU3GxzexFVZO5P/DjlNP+aVblcla24ZTRSJUKpRgzPswpCr3u24gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkPF3n91; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkPF3n91"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab41538192so356202a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542907; x=1792147707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xfHa/khCuCmDjgWe2a8hZU60K/GdSodHnu/h+kWecc=;
        b=TkPF3n91UavzAb6paCedFiv42XKvbIoquwo6ib49SSOgPDQoFdkOciDRHg/r4+h15j
         91BoKCpRw8PC5jRjgxF7tFB4gXZQTtN+iY4DR+wBH0PXN9QadZ9u/HpDJG62F87Z/YuK
         AxSrCjLk0rBufAZ0Eutl8s11TzBYlfOtAp1WfPSdBY3+GL3vlWJQvjceEuIJgfpY4Ojr
         hI556wLF3yNoa52qVKd46vfW1MjQCuoP0h+Y5jK4LHWsV/NAPRBgbOOeoewhOB/g6NHy
         1m303GQpTj2yWTFTOaoLdPJLx4fnx8lSe9kBEnPsHkBOQWLIABL684h1Y9QtBCS75e25
         UUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542907; x=1792147707;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xfHa/khCuCmDjgWe2a8hZU60K/GdSodHnu/h+kWecc=;
        b=T/1IbD1eCJUOPMniaXsG4o++Nt+qy/HeBuex8DP7kLtDFt4Rlz+Fr8uOFMtHzaClV2
         N/f5z41SN4pMkDR2UPI7wcT0OkwaElHOIvtL1VBpgrWHDB65MESOHCPcraRt9wBBDR95
         YNa15cawj+BQiUQkRfNLPbrxjY1imO3SA32UPQEj+F9H/SmdsF2J2yOjT7YAIIhNt0Mi
         Y7neWthnVZ2mAb6FIZCuMJmQ8+NgWDjn1TuQXQevSjZcWehCZW2RN2GHBFNuMJxW6Gbp
         toRI4LDNreKndAH0eKADV/SlvYpxat3cwH6kiapa+Df2bj4J6WYeRa4F+8mTsdmdZ8nD
         bVyQ==
X-Gm-Message-State: AFq9FYLzwIz7PrvSd1MfRiRch1km2mDH2qo7HqtU/92MaUVprOfMfH9T
	8TuyN+EcDyvBuZ0ZyLzNA+A5kcGSgvRJ3B5gaqEuAwpILGVa8mcb7HNCl/zSBZCW
X-Gm-Gg: AYBFou2zFj8l8zIGcoLwvpQYFnroK/lyikN0AioAVThmC4XNOjK1jJqbHla++BNpyg6
	4nifE+hU50hmCRbYuIP6ppR+wSgQGAmoHT5fdgC0Qf8f0pnzhM91qJUvPrCJWBt0AVU3I5HolkQ
	4LAEuGU+98yYNnI5wraxPPTnyl1IIKuE6zAGMvaThDPdjiOSpz8KJgMdEtgMjrMWX49gvWNHfSP
	KTPt6+brJFQiG27eHTp8nfhw+hqHi3YYmw0eqb1abL8pCAP1HQqSgbcfQqmTrxllK3xcWf4J3CI
	T1DuHRcGFJ/FnBNTqaTHtPCyBC5mUodhVsMirliY8LfpUbgoRE/BsRj05l+SqPgm4CQIgfjolbn
	fn085iS7GcuZZjxu5XZvUVVsRXVwSpEwvPz1MjuwxKBw3/C0e3Q3gGzN+TY7WnjkObK6KranG6J
	5boem77YBi8sCxAe/lODXegi5M2LiuKviCEANmXxbQhSd+Qazp5DCLRbmqk7BXM5Q7z+XJqHn6l
	2OkNGff3NAjqTE=
X-Received: by 2002:a17:90b:4d86:b0:3a6:d8e0:c359 with SMTP id 98e67ed59e1d1-3ab3a2fe039mr1399954a91.2.1791542907430;
        Fri, 09 Oct 2026 03:48:27 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 13/51] bpf: add cnum{32,64}_union()
Date: Fri,  9 Oct 2026 03:47:31 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-13-bcba9bc53ac9@gmail.com>
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

Add cnum32_union() and cnum64_union() to compute a smallest circular
range containing both inputs.

Do so by enumerating the following configurations in a rotated
frame (a.base at the origin):

0                                              UT_MAX
|---------------------------------------------------|
[= a ==============================]                |
[= b tail =]           [= b main ===================>
[= union ===========================================]

0                                              UT_MAX
|---------------------------------------------------|
[= a =====================]                         |
[= b tail ======]                    [= b main =====>
[= union tail ============]          [= union main =>

0                                              UT_MAX
|---------------------------------------------------|
[= a =======]                                       |
[= b tail =============]             [= b main =====>
[= union tail =========]             [= union main =>

0                                              UT_MAX
|---------------------------------------------------|
[= a =========================]                     |
|                 [= b ====================]        |
[= union ==================================]        |

0                                              UT_MAX
|---------------------------------------------------|
[= a =====================================]         |
|               [= b ========]                      |
[= union =================================]         |

0                                              UT_MAX
|---------------------------------------------------|
[= a ============]                                  |
|                               [= b =======]       |

Two possible covering arcs:

[= ab ======================================]       |
[= ba tail ======]              [= ba main =========>

Pick the smaller one.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/cnum.h   |  2 ++
 kernel/bpf/cnum_defs.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/cnum.h b/include/linux/cnum.h
index 49b7d0c7645d..ddf4726841e6 100644
--- a/include/linux/cnum.h
+++ b/include/linux/cnum.h
@@ -39,6 +39,7 @@ u32 cnum32_umin(struct cnum32 cnum);
 u32 cnum32_umax(struct cnum32 cnum);
 s32 cnum32_smin(struct cnum32 cnum);
 s32 cnum32_smax(struct cnum32 cnum);
+struct cnum32 cnum32_union(struct cnum32 a, struct cnum32 b);
 struct cnum32 cnum32_intersect(struct cnum32 a, struct cnum32 b);
 void cnum32_intersect_with(struct cnum32 *dst, struct cnum32 src);
 void cnum32_intersect_with_urange(struct cnum32 *dst, u32 min, u32 max);
@@ -65,6 +66,7 @@ u64 cnum64_umin(struct cnum64 cnum);
 u64 cnum64_umax(struct cnum64 cnum);
 s64 cnum64_smin(struct cnum64 cnum);
 s64 cnum64_smax(struct cnum64 cnum);
+struct cnum64 cnum64_union(struct cnum64 a, struct cnum64 b);
 struct cnum64 cnum64_intersect(struct cnum64 a, struct cnum64 b);
 void cnum64_intersect_with(struct cnum64 *dst, struct cnum64 src);
 void cnum64_intersect_with_urange(struct cnum64 *dst, u64 min, u64 max);
diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index 30685e43de04..05b17a8b4814 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -198,6 +198,50 @@ static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
 	return cnum;
 }
 
+/*
+ * Return a smallest arc containing both 'a' and 'b'.
+ * Break equal-size ties by choosing the smaller base.
+ */
+struct cnum_t FN(union)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t b1, ab, ba;
+	ut end;
+
+	if (FN(is_empty)(a))
+		return b;
+	if (FN(is_empty)(b))
+		return a;
+
+	/*
+	 * Rotate so that a1.base == 0 and a1.end == a.size.
+	 * Normalize b1 to preserve the full-circle representation.
+	 */
+	b1 = FN(normalize)((struct cnum_t){ b.base - a.base, b.size });
+	end = max(a.size, (ut)(b1.base + b1.size));
+
+	if (FN(urange_overflow)(b1)) {
+		/* a1 reaches b1's main arc: together they cover the circle. */
+		if (b1.base <= a.size)
+			return (struct cnum_t){ 0, UT_MAX };
+
+		/* Extend b1's tail through a1's end, then rotate back. */
+		return FN(normalize)((struct cnum_t){ b.base, end - b1.base });
+	}
+
+	/* ab, rotated back, covers both nonwrapping arcs. */
+	ab = (struct cnum_t){ a.base, end };
+	if (b1.base <= a.size)
+		return FN(normalize)(ab);
+
+	/* The arcs are disjoint; ba is the other possible covering arc. */
+	ba = (struct cnum_t){ b.base, a.size - b1.base };
+	if (ba.size < ab.size ||
+	    (ba.size == ab.size && ba.base < ab.base))
+		ab = ba;
+
+	return FN(normalize)(ab);
+}
+
 struct cnum_t FN(add)(struct cnum_t a, struct cnum_t b)
 {
 	if (FN(is_empty)(a) || FN(is_empty)(b))

-- 
2.53.0
