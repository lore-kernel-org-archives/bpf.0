Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9138657D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433171; cv=none; b=LxjqVPRS+Lv5xMJNdAaChMwFrp1sRi6KCV0z08yi27VeodILTdsEiWul+s1yyUylGfsqGaQ0GcvuoRQpk8bveMUm0uDDuh6EL2U26nf3+1gktLureYN7la4d4DRs4EMM3sgqmdtGZyZ3M+OIotnDzjLyLAwu1tpCWUtA+OS+HHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433171; c=relaxed/simple;
	bh=F6c/IOwzvg5wL6zSATbq4ZGo+IKB+Wnu/6R/A7fhX4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQxOQFdI/8lBY74f41yB8KG2R1gDklsR0IwNAoX4iPPgunS6PE+tg4HbsH9gUqvnECdU5f6smAuKD5uea7mCIOwR156hQRbXkepPwNHCrolyWgH6mBZg0gLDifj5w1QKZwah9ZLHFQrwVVS7YAELYl0FtbbleyQmYBp6FdohWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RobmguKB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RobmguKB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ac357c55so25496585e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433168; x=1781037968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbFGDiiHnzspafoxIXv0HDamYBJN7CJv1VW5OcAU3EQ=;
        b=RobmguKBTHtXTWvn2o78RlQx4x+HRjRktlZdZX4t6R5ZSH7cC42koAH12lpYGCN8Da
         YkJz2Bq3x15EZeGpmD7hmnij/n3HHMCL8FWL62uIQaw4wrD6i9g3jpumlcY+6J4uNkfa
         b1ZruoCyM3Pe5h1oZD8NIAI2eREcOKClu4haa8Ug58B5070PxR4P8SXGZhH4w44wIk/e
         oZBFSDDDh5bqFMGBc4dRBe9MDqEJm4EnPnTDdeFvI6C/zLyvhUdmW2CSmXxyxKnLI8fo
         VgvnrwbszyLHaHn4cZDagAA4Z5H3lAXhqMq7pASpw6VEW5zCKwI2hlERxqUo2CTkna2P
         6R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433168; x=1781037968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fbFGDiiHnzspafoxIXv0HDamYBJN7CJv1VW5OcAU3EQ=;
        b=DqSOAUGgAUgH5B0lUmJdf3ZHge0v9mM9HfTwkNiHQ1Sh7rFl8LFtKRY5p5pDIAOmSJ
         gaMABIrpJfAqGkmaYtk1CqFBU+hi65UL8cYkGuEO241Hacc2ZRfu9W5t+HbhF8DDFKl6
         FiU7dQx3OhIWAlXpGccnn20EREoQVcAzBWqdfH90xL3AhF8PkxjIch6TMK/ZtliaQW8d
         LT7MCpe1KhK2jMHjuYWKZE6NZcdHzBYioO45MjfdwxAHyVdiw5ypr8ol2F9SjfnZnp6g
         mxjGvx+f8HwqV6qQnXUW9TffDzuJaJ9AQCkFh8VYhan87ikTsr6ZuEuZg8HfYKEKgGvB
         DKOw==
X-Gm-Message-State: AOJu0YzHJ0DrHMln/Nq8wOp6ohwE9OAorLNpjsXKB2JgZMtR55bFngzx
	vP1Wg4t6RuhK01HgUBuLSfsMsAaGD2d9fYr+GH5yhKD36vaIkVP0KkGG
X-Gm-Gg: Acq92OF4EZRoz/TRaRSJQWyPX8Bpl8lfEAK/hZ4J4KBLCm+MZXTOUrcwN8DQ/1lkeRs
	gNW4TN2siIGworQXyw19SqIW5+7RnQJ+ZNmWxdpqzak0DYaP35vCnaYFEOmtavluWHy6+6kWmXG
	3LPuPuEIGjS2YKUTYUOwsWiSdnE/X+5VLmCQObIXharrvpw0IEFl9OtGmnYSvFmS5FwZljwJjY1
	LGDSqm7LZe4VyGUi5bLK84viDiMu5s3yVzf/GsTmRHHFQ2jLoymfwXs2ZvGBnsPYUCRXyaN+ihM
	va4alFjPmGPAJiICUaMFNaMCythiJCEN44dg57Z5cwYC9g4ZCh3JLzOvzpaAf8IyTimDgCcP5pi
	URo30dJh/QoGb8kpAgNTJ2Np85aoiS1X6sS4O16IZsQ5hRQgMGPzkoQg0VbgQO8ycNQRxB7Q4Rs
	MUMaxM8LnA5QtRD6Gu3OmdnMmo
X-Received: by 2002:a05:600c:64c5:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490b5ed43cbmr5733755e9.20.1780433168154;
        Tue, 02 Jun 2026 13:46:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b612f92fsm1648545e9.15.2026.06.02.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:07 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:30 -0700
Subject: [PATCH bpf-next v6 01/11] rhashtable: Add rhashtable_next_key()
 API
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=5345;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=8uygxpPegjvMhH3mpuOGU/BXPv+C35UGImIEq0H4hGQ=;
 b=I6JVQIsAQnwJ1pc+Vudiy3teua+W7Mb693EIEWViYR39FgJzRqNJgiKCUYxY8sdZbTRhpMf3n
 WApkDi5snRjB8M2Z3dHyMrgTSCXUhMXb+ckGyiCIdRHMFrnGGnbB/pj
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce a simpler iteration mechanism for rhashtable that lets
the caller continue from an arbitrary position by supplying the
previous key, without the per-iterator state of the
rhashtable_walk_* API.

  void *rhashtable_next_key(struct rhashtable *ht,
                            const void *prev_key,
                            const struct rhashtable_params params);

Caller holds RCU; passes NULL prev_key for the first element or
the previously returned key to advance. Walks tbl->future_tbl
chain so in-flight rehashes are observed.

Best-effort: in case of concurrent resize, provides no guarantees:
 - may produce duplicate elements
 - may skip any amount of elements
 - termination of the loop is not guaranteed in case of
 sustained rehash. Callers are advised to bound loop externally
 or avoid inserting new elements during such loop.
Returns ERR_PTR(-ENOENT) if prev_key is not found.
Duplicate keys are skipped.
rhltable is not supported — returns ERR_PTR(-EOPNOTSUPP).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h | 104 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ef5230cece36..7bcc380ec192 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -650,6 +650,110 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 	return NULL;
 }
 
+/* Internal: scan one element forward from prev_key's position.
+ * Returns first rhash_head whose bucket >= prev_key's bucket and
+ * (if within prev_key's bucket) appears after prev_key in chain.
+ * Returns first element if prev_key is NULL or ERR_PTR(-ENOENT) if prev_key
+ * is not found.
+ */
+static __always_inline struct rhash_head *__rhashtable_next_in_table(
+	struct rhashtable *ht, struct bucket_table *tbl,
+	const void *prev_key, const struct rhashtable_params params)
+	__must_hold_shared(RCU)
+{
+	struct rhashtable_compare_arg arg = { .ht = ht, .key = prev_key };
+	struct rhash_head *he;
+	unsigned int b = 0;
+	bool found = false;
+
+	if (prev_key) {
+		b = rht_key_hashfn(ht, tbl, prev_key, params);
+		rht_for_each_rcu(he, tbl, b) {
+			bool match = params.obj_cmpfn
+				     ? !params.obj_cmpfn(&arg, rht_obj(ht, he))
+				     : !rhashtable_compare(&arg, rht_obj(ht, he));
+			if (found) {
+				/* Skip duplicate keys. */
+				if (match)
+					continue;
+				return he;
+			}
+			if (match)
+				found = true;
+		}
+		if (!found)
+			return ERR_PTR(-ENOENT);
+		b++;
+	}
+
+	for (; b < tbl->size; b++)
+		rht_for_each_rcu(he, tbl, b)
+			return he;
+	return NULL;
+}
+
+/**
+ * rhashtable_next_key - return next element after a given key
+ * @ht:		hash table
+ * @prev_key:	pointer to previous key, or NULL for the first element
+ * @params:	hash table parameters
+ *
+ * WARNING: this walk is highly unstable. Unlike rhashtable_walk_*(),
+ * it cannot detect a concurrent resize or rehash, so a full iteration
+ * is NOT guaranteed to terminate under adversarial or sustained
+ * rehashing. Callers MUST tolerate skipped and duplicated elements and
+ * SHOULD bound their loop externally.
+ *
+ * Returns the next element in best-effort iteration order, walking the
+ * @tbl chain (including any future_tbl in flight). Caller must hold RCU.
+ *
+ * Pass @prev_key == NULL to obtain the first element. To iterate, set
+ * @prev_key to the key of the previously returned element on each call,
+ * and stop when NULL is returned.
+ *
+ * Best-effort semantics:
+ *   - Across the tbl->future_tbl chain, an element being migrated may
+ *     transiently appear in both tables and be observed twice.
+ *   - Concurrent inserts may or may not be observed.
+ *   - Termination of a full iteration loop is NOT guaranteed under
+ *     adversarial continuous rehash; callers MUST tolerate skips and
+ *     repeats and SHOULD bound their loop externally.
+ *   - Walks the main bucket chain only. Tables with duplicate keys
+ *     in the main chain are handled (each duplicate visited once).
+ *     rhltable instances are not supported and return
+ *     ERR_PTR(-EOPNOTSUPP).
+ *   - If prev_key was concurrently deleted and is not present in any
+ *     in-flight table, returns ERR_PTR(-ENOENT).
+ *
+ * Returns entry of the next element, or NULL when iteration is exhausted,
+ * or ERR_PTR(-ENOENT) if prev_key is not found, or
+ * ERR_PTR(-EOPNOTSUPP) if @ht is an rhltable.
+ */
+static inline void *rhashtable_next_key(
+	struct rhashtable *ht, const void *prev_key,
+	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
+{
+	struct bucket_table *tbl;
+	struct rhash_head *he;
+
+	if (unlikely(ht->rhlist))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	tbl = rht_dereference_rcu(ht->tbl, ht);
+	do {
+		he = __rhashtable_next_in_table(ht, tbl, prev_key, params);
+		if (!IS_ERR_OR_NULL(he))
+			return rht_obj(ht, he);
+		if (!he)
+			prev_key = NULL;
+		/* Ensure we see any new future_tbl attached during a rehash. */
+		smp_rmb();
+		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
+	} while (tbl);
+	return he; /* NULL or -ENOENT */
+}
+
 /**
  * rhashtable_lookup - search hash table
  * @ht:		hash table

-- 
2.53.0-Meta

