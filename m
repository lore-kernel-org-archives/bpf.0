Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BC43744F
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121128; cv=none; b=qqiOlxFkCVDCrLwnFwTjCGF0M2AXq6VVt/RbXwX2STZWO5guvsadVEB7YsKdbTC/GeZa6ohX6ovT3SGTHR9zse6502sAhZnqIem/iLQAxJigx1RrGZZ/5NtkP0oUrxzKNFPPUquQ05m21wp4WWIEJMcoxpCV6Cr4gHeY2jumr9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121128; c=relaxed/simple;
	bh=I4sSQfnTXzSEZ50MVAEDsmLeM66GZKdoFlkeV6vWYMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYB0udcl79/zcxdtm10U4ZrT8ajx+6nmt1HBZ1ekmMcaqT1kyT01FHRmQudBhgZmIlV+x+8BH+kxLrSuBHGQFnO6Qp6ZBs5BbAeyTWEnyOyF1nFMvhJqZydyjQ7i2p09YahkROOoPRvpIvx2MrTnYvcTKda7DSPAC8c5YZdWjH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQAcuF/X; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQAcuF/X"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so764646a91.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121126; x=1791725926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xfHa/khCuCmDjgWe2a8hZU60K/GdSodHnu/h+kWecc=;
        b=PQAcuF/XUMU5HLbSyI8EC2n3QOvuWyJSNfV3TLjfMEtj4banybZH7K4pPxfqn2jP6O
         j0g8eDOQ0fCt4aQ2NJlUfQQfS6yQ5i1uUbkO0VlnAZnPNezlNrljJyw3Z1CXMAWtiu9T
         /3ox8vMKAOqqN1LW0J6vpzxnJjTy718ZSw724o14FBCrvAAVL2/ZlA1bwhcAZ+nHD4wy
         b/zDikx5p3Vr5UVUhio+cKbyP66Us2Rehdj6mhVLp7667ovHbFb/XA6EqawevgnaGZSJ
         5WheGC4kWABVYO4D9sZFre+LooYuxWb15rS175+Guf5Jy2vHsdfq+PJGykINllF11PsY
         TdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121126; x=1791725926;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xfHa/khCuCmDjgWe2a8hZU60K/GdSodHnu/h+kWecc=;
        b=kkhWKYzxH3WbpHlblk2I/17RluwceODQwid+c+/C5XvQTzoAsPMdr09UeMK3lmEL67
         hs7KgzHeME7em6ToyPJi3vw1vcRaX+oO6zz2A4k5B74Szf1/P1qWDVw8hqDCnNIJV9Gc
         T84PUqDtzvcFGyTL7kP//acuivuFHn4SlTLa2K0OKB1hRw8Gpg51+42ejG3zXUXhMgy2
         4Yn0PQVKFcaS2Yi3Ph8XYQTrOYd4RHL/DNZLt7mg1f/nWXnFLfw9i5yfrA06j26qxeUn
         kjso3eW7Q/6JDSwykNg+JfOyri1YpiG3pOHcj4RqNuTfy4k3HCviuKtWu29spvTkI6dM
         7ntQ==
X-Gm-Message-State: AFq9FYJMWZebnyIVDtl3NW6LXeTD3sl5bzdao2W7Wo5Udt330fbkTjvA
	wQLN7HnJxEA5it5BBGHR8lrhXk+mefM9ROmE6+vBxNcEBajfQ8XLuEdJ4C2iDQ==
X-Gm-Gg: AYBFou1H9ahEkfntrHNBmcWlHOF1PlDfB6uEqm4A18X57iEEHzXOh3Lv/GGwV6ccKwE
	rfD6hBtu9iZkYQr8/q/UMNhCzTq/tIZNXp6lpC3yWMk/ZCx4zLDLpgrRdFTc27C2h+JkPKOcTnb
	2VLGM8zehi/69IxqhVaP0p0nTtILiN0naWHj4BodEr1CY5bnd9X8+dKwlQ50RkZbg6BdPVBL9xb
	Nu/OpoxMOw1AORKoc1l797iT5tfeNghbWziw8lcnexDAAmLoHnAbqOkYqdarsYXZgpNprQroXa9
	cQcNrXPqaywqkDVamfcpwS2aav29A+5YziuchGPLzYrXQ859wXwK96SQkNM3lA3iKq6sTAf826O
	+jg7EVpD5GwYtChnuO1AiXTM0K0zWc9JyUg0xkRGS/tNGcR2OGDJtRpkrgBZGTvwu2aBDQlkAAk
	O1helTsMQEumIegcWYng70YGUJb7F1IkgkViu7EFTIbT0RJwnrLyUuXFjKfZs/4LCdm+tDeuvep
	c2g3hDgnlJ62Ng=
X-Received: by 2002:a17:90a:e70f:b0:3a4:b6c2:b159 with SMTP id 98e67ed59e1d1-3a7873b0ff6mr3766792a91.34.1791121126516;
        Sun, 04 Oct 2026 06:38:46 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.45
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
Subject: [PATCH bpf-next v2 10/43] bpf: add cnum{32,64}_union()
Date: Sun,  4 Oct 2026 06:37:52 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-10-f6254e29fdf2@gmail.com>
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
