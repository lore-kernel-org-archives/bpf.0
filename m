Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0A45C70E
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432455; cv=none; b=kl+TUMSV+iTKSqUQN7dMvUCzBMINb2fu89vvf6g7HkX9hIpzWpy+ADBM3ol7jY4JGOr1AlB5x407kQek3vS/Os2sxq0GRhk/UHxSnSKL5Yxr02Mk72vhC9OmaU50FvCAekk8XOi3Q/rSiae8f+DgoKD1M+vQfeA3NtoERaD6qDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432455; c=relaxed/simple;
	bh=aAMS7GR2IPU4cdgDTUEqDE3CeI6CFxANRxbtBYuGKB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7ud2JpMvbkju7+RT23NJXcjZj+6VNvyECmauS/etNab4BInEL6jN1UU/bH05y5w9aeDpgVb0FKYSgS1ooE/SniBKr4RbelI1qON1gqbp5aQZcFuJp4MoJ+AAlyk/OcIP9OyYWxLcNfRZNYAmk8rhTQTu87FCix57TcwLSqN2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHBxBkFz; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHBxBkFz"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so1003109a12.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432453; x=1791037253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MJGrlcNgSz3LrDg2uuiqS6Nb1GOd+/HLgF3iBBxN4A=;
        b=bHBxBkFzqpMwIjPTPdQkGCXQkl8l11VgELsydLGG2ktUc6FwjrZTeloI+1HZERuC64
         2MKvfKGfFL6ZgXSFmhQjynTPZt+8y7RZmsoBHyBuGuOZgYm27JfEuFHwGSFHas0esFOW
         UQviLZHbIH3kmahsHxJwRRhin9aGJ6xNYKw/f8s3LAm2WICFbWzLq4G9QpvweBxOJpkZ
         /GIiDRBuPFTknUYBOxgJN2jZ4R5NA4i5uXVsHJ8mq1xSB3dmwb2os0l6TpLLDBKwgnQS
         OQUjGESC43U6eLOvsvLsR4XTjbTlhIqLfDdO/sFVVbRlwfXus9t8DzEiEMm+/C2JidSl
         JJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432453; x=1791037253;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MJGrlcNgSz3LrDg2uuiqS6Nb1GOd+/HLgF3iBBxN4A=;
        b=fMPyetrg3YnggsEddPsekGW2Qe1ZbOItRP8OivyhDPN5I9L9Me14jGMIC5G/vHGCvf
         aHcTnForPzgPmPsQrj7HEXD6kYHdFCmv0KnCsDK6axHD/brXgkQVaKaRUkH1Q449QPq7
         /0YPOw+Hn+7UkZrRpuEJ3kTqABgkoDd9tm7Q0iedN1qFSHq73AxzLQY8asKU/cFW51ml
         7amEuZR3QwXA/wiWwlb2aSiTjmxPbn9zfrY95sXxY/xUGL4S1JrOwCo+LtzcaXgoBfeI
         bdI+TZgNYglls2GcirexhiXVjE9dOgcUc2y5a18Z8zRL4xcasSGOwrIU/IwmqBrBLFmw
         9vzA==
X-Gm-Message-State: AFq9FYJOXjhGwC6v4JCbqIWtWXIOREnClinpAa/FxrIr9PgpmVBtAZo9
	PtdnywmItLde+aZ3jCx3Pvi31xsn77IlVek0xCbHKadBEbzXCxI+/9QmsbqhSlGYp9w=
X-Gm-Gg: AYBFou3CMxJVR5Oe+p9BgzaK3EBwMSKdDMV+otr8W7G+0G8xEYBHSzGxisDcnoWLSQM
	cEYN1IREjMB8tWzZDdLlxqgHQ4AkgcJt2qSX1xongx8rGcEtOJ+qY+L0iSnhkwROryEAv7zCP/2
	DzjeYgKrLx6X6k9EN4D8FYIB8MstHTFQoWy+eKPmny297PI19aJC0CzlcxqGDq/9OJk82FmOYVc
	oviWY7V0r5Ss/yapwq9lpfNTDddCml95/vTOnlJ1gtguomg1LRf8UpuoDZtl47Gw2ANBOW/LzMf
	vrqXBz6yYpbakwLNJMNerZ1eQvSt8AfmYzE/Ul8KrtPznziZFI6vQrw9nqs/0nQ+GKJobzN6UBe
	O7nue2XHUoPCWngklViFz5P7OdD7/skq3C3/CBF3rPGnbSQoBxjpDDGZ8UBTq4kipx7t3MRQ6S6
	T1s0qGdynCy7S1jn/3DysNNmDqo1ea+4RTi3MMWqplx5NpHRu9XT3w70fv6gyxTAKQ3K5zsWGPb
	R/HmH6C3THhS4spRG65l/L9aFdR9LGf/KciRC4TlQ==
X-Received: by 2002:a17:90b:1643:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3a0bb62f2d3mr4677442a91.45.1790432453038;
        Sat, 26 Sep 2026 07:20:53 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:52 -0700 (PDT)
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
Subject: [PATCH bpf-next 07/36] bpf: add cnum{32,64}_union()
Date: Sat, 26 Sep 2026 07:20:05 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-7-c8e5ab5ba79f@gmail.com>
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
2.55.0
