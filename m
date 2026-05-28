Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699B3FAE08
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990460; cv=none; b=pSfdSgIVCmvZBVlWGC/XSLlEPWXifb71mZSXxjk5F9EEsSQmCkP3m7Rk8Dp4+t1rrO0hDe7s9r843tDEfF81OT7sQTj5hbCX6t9vDC04Xo2sfEfKHcPv2RViAdIBQK561VCAtkhohshH7B7Y0BgUvzLw9qOKOk2kXB68SSkVssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990460; c=relaxed/simple;
	bh=TxIb32XQNb5FgO9TJlTRoIFeRTceI8dsajMDerxt1HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0sHLkFoKVA/RtPnVT8wrVyblwyF6m7/+wJSxJOc+fZPZMUyFcsMdS9BkHmsxdAwr1BNMrciFBDkXtUMNE98MOYEoXMJypyJNZ6qcyHyCzHdLh5R3gHMkDqdoK4fmrPgyMznTL7hZdkirHXm+SAlYwnbHXOp7EGdG20tdTK6tfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSDUE0Qt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSDUE0Qt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4904127c32cso43303645e9.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990455; x=1780595255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUV/KGZhBIQWTjs4PRB2d5yHpLxXi26s9TyJym1BZzM=;
        b=pSDUE0QtUYOe2KjTWhtgNIRo2S5eBeuhM2CfScD+ezANJ4WSvNBQ5JNvun+z82JaNK
         itauwD7w5hj8zMBYULeLqRKHk2EpRc2VlX4b3jZwNds23hCEj0kGOw7b8sp3oHBChvL4
         zG+kCV6ADuhxiYBF8xRva0cCFsWHKfIAcMu2gvyMN8j3YEp91uzZLUekl/9vxzzUHZru
         RagH2pCawoOQg3SLRw/UKq0oBEs9Kc+f4o276+grdtuyPXmz7/9sTKP+FzdxLcW+HdMf
         6jw3WhWA5/tBrWY6vvq2DVRGguRJ+2AjIGhJ8bbx0wdreRfuIH+k+awj0PKCqI9vdLtb
         nTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990455; x=1780595255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUV/KGZhBIQWTjs4PRB2d5yHpLxXi26s9TyJym1BZzM=;
        b=SreDCxEsdozTf0huVCWnI+V2Q6/sRh2Ldw66cfVyCM6Lj0Mn6jA6p3HaZk/BDg2jM3
         yjnRZxtBL88OekbhEuwp4MCz/Y9GG+Q+mUvi9TRdTVjx1ORn+AYHOH5Dp7nP0xV8EeEd
         VAmSaxGzNtC330frRnOsU3PDoX4u0ThvXL1BVOQWZKOwop5Xhkl5j8xRzKXC4HRglsqX
         WybDvvD6BW0RXMjM69uzakz0BIWY+kOCcz3J8PxKR7qbAwvuT7p9IDPs50C37stZnQif
         hPrq3smKn17iMekWrcv5gkE2ThoITiU1c2W5fJzeoksxrp3Fh+bwDOqmtasEzup5aSGi
         kO4Q==
X-Gm-Message-State: AOJu0Yz7hCCxtQPXG13r+V/Xztjm1rbGTZ2/jyRkyeEUH34PKAMwsg6w
	VvkINK4c1topLablxURlOViBrxpnPmXjzo1OrhrpjYd3Lv/vMH8p3XNs
X-Gm-Gg: Acq92OGsQm9YFi9W4YWoiHLWRrlMegUiltTQWvo0XmVPRSc7/0B2OzkW2RvkEJ/3eaw
	cdO5WxcSMhlkIXpij8+W7ugu7hltj32xavE1t350GjnmnRZ6PukrCCJrt1cNA1WjIJIaUPwTa9y
	og01UeZ+M1sq9XFdZLPKvwE2czdnNUKY3AcpjuXiNB6S167+5/AUodf4arOIk9TKvDH1rCZW2Nd
	qir3HNU5ZZCVhOZvLowFO47TFjfx6MzMmsilt5ltIy9m8R9cX7Wfbl7lKTATR56ktR35GPhb/qx
	up4XdyuSzefmru/Jxb26W9YlTu0G+nPBvCzUhA5MhceEweUSmDjCVdkNQuT+W92ch3Sa9inOwwD
	SBz5FqJmLne+/XOY3CR77/6i5nrMtvXbWYCzigNI2Hxt73+g0b37SBSImiFRkmOoy6s4Yfa0vqJ
	Leo8aAKb6Vku/GMULtuzMSKemMowODCnYNy0w=
X-Received: by 2002:a05:600c:37c8:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-49042ae09eemr479480725e9.32.1779990454913;
        Thu, 28 May 2026 10:47:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909295a467sm50437485e9.13.2026.05.28.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:12 -0700
Subject: [PATCH bpf-next v5 01/11] rhashtable: Add rhashtable_next_key()
 API
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-1-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=4829;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=KCGHtfOZObTQbWUZsLWO8eZL8wK8Rafw33dg+TPu6OY=;
 b=rKGqVfA661xYAnunnh3YilqRJ6zii2oBMtdiduj0egCm52a5yVJTHLnZihSOi5fwI5bSkbVpN
 BA2VF7G5V+QB5AaFLahGqBR1127AwA7D0ugl/ITK8hiGH3T/E+OT3CR
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

Best-effort semantics: an element being migrated may transiently
appear in both source and destination tables and be observed
twice. Concurrent inserts and shrinks may be skipped. Termination
of a full iteration is not guaranteed under continuous adversarial
rehash; callers must bound their loop externally. If prev_key is
not present in any in-flight table, returns ERR_PTR(-ENOENT).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ef5230cece36..d6eb3ba476ea 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -650,6 +650,97 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
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
+			if (found)
+				return he;
+			if (params.obj_cmpfn ?
+			    !params.obj_cmpfn(&arg, rht_obj(ht, he)) :
+			    !rhashtable_compare(&arg, rht_obj(ht, he)))
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
+ *   - If prev_key was concurrently deleted and is not present in any
+ *     in-flight table, returns ERR_PTR(-ENOENT).
+ *
+ * Returns entry of the next element, or NULL when iteration is exhausted
+ * or ERR_PTR(-ENOENT) if prev_key is not found.
+ */
+static inline void *rhashtable_next_key(
+	struct rhashtable *ht, const void *prev_key,
+	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
+{
+	struct bucket_table *tbl;
+	struct rhash_head *he;
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

