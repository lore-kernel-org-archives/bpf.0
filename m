Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253D4D2EFB
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659695; cv=none; b=g+YT6pyrhb32qehCWsRBIPWLHRz07fdb6zlnB1X191twpBpgM4b/hxTjfGYmjSur8UCLS2VvuPgTMxq2jejStEBpqkWRiguuFdiRPzS9Xu8r+MY8BOXyAQ+2YLk0QRyalxdDK3DlxYtwVD+Ay2aw0zBENCAr15KT4eo9Xwb9pqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659695; c=relaxed/simple;
	bh=ZV6GBYauZtLugtcy1MdDxe4mWZY5aoB46gvBBQd9fCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wv2gl24fkK29QA23TApmSTvKt8l+XTAtVZ3+eak8Dn7PfdaHxNuuFnqUWZCf9wZJA/ZVvgMqrMBZewh9xXCvxJsC5/q7E4RQc3ti3VJ6nE5tIBDaotl7xiz6FidDOfio0W0XSDxDKRsVI+/JpjXDZRdqlHVQfB1qggrMDqx+LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op3n25HO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op3n25HO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4908b92904fso20929055e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659692; x=1781264492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P66BBRVd6jwxbM6uS7S88bccFVAeLim2nN/Lf9ZdBMA=;
        b=Op3n25HOvASOjwg6mrOeUCQOSgBz2jBqQGU1L2BzgciBjn7Z/UfQ4fVWOUwoRRR73Z
         UnkN/QIytty2nEVBamTOY6HbO5uiK1o0HoniIFukBgd/PjEtSLyGXrUWh60Ngy7paZVt
         DAw+abfPenOOfKB1tsla8sTa6yPJxFHZoZrMzz/xOh6lBlToBMLqai1zHUsSs98kQT/W
         7RBNrdjGTCWY6Juh8vHwYhzW0wWqRzDhvTVAheT3ne/xYqZNWiHH6c0HATlRij3nMAxk
         5RoY65Bh5LaBceB2NC3fK3SfV0ypY7pKGck1GdZDYUW2S0n0e1i/WH31+VjzNP64JJJA
         PsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659692; x=1781264492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P66BBRVd6jwxbM6uS7S88bccFVAeLim2nN/Lf9ZdBMA=;
        b=G8nkDMSXloPymxsAuhfSuTfrRTSzMxSUZm3Brkqvo0qPXUDyjSxcAY49sBZWVJ5rRC
         dP8DZfchw2ZcjvXxaYOcVfqGdMQS4/bmpyeISyS8/fhdqniVQ6B4siTtmLcPRvtdeU5y
         T3ygKpUHN1AQHNsP9VIq+aWVVHcEzGTtVIYHJRtP5DG8B48NCFaK7vntx3WFpH8tvpci
         fhuCoKUyRa7Il7zP6mwYuPBostneGT0MwMxEPJ32dQpNo47ns7b0LxQ+HKcbmmqHnWTq
         xyOoy3lhixG83eDzysp2WE1+s2ZUAwFiN7M5NCOOYHQkWu+qbcXSUiRSP99A02tnJFmv
         uOVg==
X-Gm-Message-State: AOJu0YzHqD3yn7Vfw9tggZmE753fCwEGEP9064KkFj2yZ1+13fhknAhb
	9dwRbRM4d0RXNsQHehNyLoO3QM+O0wLDxIHVLRZMMQkPxgRWskIMAIYP
X-Gm-Gg: Acq92OFt2opVmh0eMTV066v07gLS4N44E39G3YXBKqQzhk/WoqyDK29BejshGrVfnck
	GmjSOGFdj4eJYRYXuTD8lvKckUD+jkbZRL0O095yrv/VznWl5qwnjnH8+oXYf/wkXRgFyV29LXu
	hH/StCF88T7zrsQkOs+pFl16/h+/zZa74XJW4ZOHli7rYPzhM7Cxi5wzZkFqRcqvDZYRHsT/XsC
	hV8kHdvKn9sHB+rhMyWwp6cQUX8HXOxOD7n2yeeUUWYXro/HIX7Sy5wndsuFy+KRVv/OjA4QGy5
	V1LsRsGeIUUFrdHw/X7YIXvLvGUyid1AibcT5W4Kn7knJ355NEk5w4/yXax0CRFa1ZcfNO08kWv
	QJctNfiy9iJExbbS09speReFz6601UskTNydxdeb+WCxUD7Vxld4Muf8ABmLDGUzbEIUvFptQtG
	yeetiZPQRN9S9ZzntMs080ZEBr
X-Received: by 2002:a05:600c:3f14:b0:48f:e230:2a1d with SMTP id 5b1f17b1804b1-490c26460b8mr50284005e9.32.1780659692226;
        Fri, 05 Jun 2026 04:41:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm18984487f8f.10.2026.06.05.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:18 -0700
Subject: [PATCH bpf-next v7 01/12] rhashtable: Add rhashtable_next_key()
 API
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-rhash-v7-1-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=5934;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=IhudPVGz/mJ1bq3UMGR1uaV4aWlE/cO06I0K0nNhP/M=;
 b=vjxdvKEfDOjyg7n89riXyTFlDOY2UYknbUlGYsrRsjvj2DvqtRnHzW1j5xqpYcS3ww1RfLcqe
 W3NJSX2epFtBlB2PnqY3eNccN8J5ZeKzcHEt29rTKsXN6Kmge5ozdnX
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce a simpler iteration mechanism for rhashtable that lets
the caller continue from an arbitrary position by supplying the
previous key, without the per-iterator state of the
rhashtable_walk_* API.

  void *rhashtable_next_key(struct rhashtable *ht,
                            const void *prev_key);

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
Behavior on tables with duplicate keys is undefined.
rhltable is not supported — returns ERR_PTR(-EOPNOTSUPP).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h | 40 +++++++++++++++++++++++++++
 lib/rhashtable.c           | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ef5230cece36..6f3aea498515 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -650,6 +650,46 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 	return NULL;
 }
 
+/**
+ * rhashtable_next_key - return next element after a given key
+ * @ht:		hash table
+ * @prev_key:	pointer to previous key, or NULL for the first element
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
+ *   - Behavior on tables that contain duplicate keys is undefined:
+ *     duplicates may be skipped, repeated, or trap the walk in a
+ *     cycle. Callers requiring duplicate-key iteration must use
+ *     rhashtable_walk_*() instead.
+ *   - rhltable instances are not supported and return
+ *     ERR_PTR(-EOPNOTSUPP).
+ *   - If prev_key was concurrently deleted and is not present in any
+ *     in-flight table, returns ERR_PTR(-ENOENT).
+ *
+ * Returns entry of the next element, or NULL when iteration is exhausted,
+ * or ERR_PTR(-ENOENT) if prev_key is not found, or
+ * ERR_PTR(-EOPNOTSUPP) if @ht is an rhltable.
+ */
+void *rhashtable_next_key(struct rhashtable *ht, const void *prev_key);
+
 /**
  * rhashtable_lookup - search hash table
  * @ht:		hash table
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 04b3a808fca9..dd6eaa09c55d 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -687,6 +687,75 @@ void *rhashtable_insert_slow(struct rhashtable *ht, const void *key,
 }
 EXPORT_SYMBOL_GPL(rhashtable_insert_slow);
 
+/* Scan one element forward from prev_key's position in @tbl.
+ * Returns first rhash_head whose bucket > prev_key's bucket, or the
+ * element immediately after prev_key inside prev_key's bucket.
+ * Returns the first element if prev_key is NULL, NULL when @tbl is
+ * exhausted, or ERR_PTR(-ENOENT) if prev_key is not found in @tbl.
+ */
+static struct rhash_head *__rhashtable_next_in_table(
+	struct rhashtable *ht, struct bucket_table *tbl,
+	const void *prev_key)
+{
+	struct rhashtable_compare_arg arg = { .ht = ht, .key = prev_key };
+	const struct rhashtable_params params = ht->p;
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
+ *
+ * See include/linux/rhashtable.h for the full contract.
+ */
+void *rhashtable_next_key(struct rhashtable *ht, const void *prev_key)
+{
+	struct bucket_table *tbl;
+	struct rhash_head *he;
+
+	if (unlikely(ht->rhlist))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	tbl = rht_dereference_rcu(ht->tbl, ht);
+	do {
+		he = __rhashtable_next_in_table(ht, tbl, prev_key);
+		if (!IS_ERR_OR_NULL(he))
+			return rht_obj(ht, he);
+		if (!he)
+			prev_key = NULL;
+		/* See any new future_tbl attached during a rehash. */
+		smp_rmb();
+		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
+	} while (tbl);
+	return he; /* NULL or -ENOENT */
+}
+EXPORT_SYMBOL_GPL(rhashtable_next_key);
+
 /**
  * rhashtable_walk_enter - Initialise an iterator
  * @ht:		Table to walk over

-- 
2.53.0-Meta

