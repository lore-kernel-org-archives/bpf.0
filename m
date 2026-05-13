Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF42DC76A
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711824; cv=none; b=JoConQsSOo2rKFtA2zHvnkEJsy/1gu+wmtJl7/QSlNS9+y2JjZWamg6Az3jFpGokgNaPQdKVzohuI7le1zZdRj1+FBDml6XKGonaUntCLnMwflpFYiBv0kbgD2sqVvehizMg7CL9vJqfT9KIHAqTldAfZsmCdvD/MQb17vlHcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711824; c=relaxed/simple;
	bh=b8uxesipo2+a8zctfJJdsyLDhN/xa1ZlUm680yhCTPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKiE151m04vcnpZAh2jdEyyxFTqdy/cLVxaHSnMvJ0tUNe+IVMPo7LY1mY0asg3BY+jg5I+dXWfhI5a0FPuSrWuyGO4lUr+vHMqX+SdwLVO46Y4lK4IGPJhFqGJLId2+QjnGA8rbl5gnvBSLLVKp0enuLMLnI4QGvGv4F3FAeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYGFLCHk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYGFLCHk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b150559bso57119145e9.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711821; x=1779316621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgePqYaBPMSYuMeMEaSdF8Xfsqi/BqiNwzf8UGBC4lE=;
        b=YYGFLCHkSNqWuhXygzjm7Q54iItL6wzlQ0is8DVVZ9riHRg3KNLYLFJ4CHcg8Gut/m
         WnLp8VkraeG9Tr9RrARKXlWDle8hq2gc9J2Y/rZ+aAZpybdkCks9hQ0CgkGag5+yrfTb
         HKwPqC5maaVz0unUEt3W+GvSrutsg2Hu8vq71dAVEkiA8I3ZP/rifIS+7mwJgw9tWodD
         DU6KouW52hjiMtdT0Xypy3hOSJzVdvZOqX4FNA1G6H3FIKQKiP8V+RK0weNWaWY87NeB
         7+Jq4YQavUiJ3apgdQhliAPiwMNBqX5lY5jsMxVw2QJ1KzrenWbEf6ZQSWFNHMb2RQYd
         lJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711821; x=1779316621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JgePqYaBPMSYuMeMEaSdF8Xfsqi/BqiNwzf8UGBC4lE=;
        b=GVOEBuL4iCIjOeMwr0zM2fC9reP6J2A5F09a2aA6+zBnivdnzoQbJ5a/5xPNIWIgWH
         gp9O2Kqd7fAnw46/DZug2A4Lst/+6JezpR6N+XXmR/oLSGaKqLsWDf0NQW+iaynuLPP5
         Ji/H8iaSw4rK0tyQFTrsB44QhzAf9/lUxxSkusDZfW76cveO4xXB/yasnNZhJFOYMiHH
         7YArbzY2ex+Xqq9J2HSZO6V4uCr/zWROWzW823ieEwHlKD9GIjfuW0IcIFawsMHcTyA4
         mEJ4nuXseXM+hvoXBeqSj6VmletmIxFqB9bC0oEkqleX7y+cBSWj1Pl8GyeUX7sqsx7s
         Sztw==
X-Gm-Message-State: AOJu0YyXpa3m7cIhdp9wnUmI3rGtJFJmnNKqzwRyZml2UC90QbDspKBa
	mv0bUYHmAwzb4tEh0/M+9MUcPu71w1jYmQwbBl0TsyLpukIIs2MBpGQq
X-Gm-Gg: Acq92OH7My7UmYN0jLeMQmvR9uxrWAlMeIl0HrhxJ6WG2Z+d4TpE3lP44yjCU1xcXKM
	025xNp4u7MC+ComQbMeunkBA3yr8lU8BnzLnk2I4zwPza78aWp6xretJmgPzDaeJ+iATInaYBfw
	VAmcyDUIKlZJctX0WHpvBxkR5C5rpXH9NcCvHuuamTlEIn7jRg1ysYzzNKvSqxpxmEbJ+BKuVvu
	9bK2oZ8YUFESK4FxBZKTjFOuVlq9hCAzis2nBsK7u731xm+ja4KYOmiOH8K9wNwh9i5egc5MpN4
	kk3rMS/9Ayre1lUwV+ngF8J8os9TpouRqNbKGmS8X9R00Rujm4CGP63Yx0S6iYmkV9yCXxyRAJ+
	4J2vKTBlGrcT7TwPF9RcjovkJi/WaFRKS+XoYAad6W4NuHnr6r2hsmFnuZLZeyLqfC1XB3MhdEt
	blySUHxkcnhLfcGwg9reWiOfc=
X-Received: by 2002:a05:600c:8b75:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48fc9a3b8e2mr76534035e9.21.1778711821327;
        Wed, 13 May 2026 15:37:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64d9f63sm18630725e9.12.2026.05.13.15.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:01 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:04 -0700
Subject: [PATCH bpf-next v4 01/11] rhashtable: Add rhashtable_next_key()
 API
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-1-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=4497;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Vo7/79tDMCiHKsgZkUc/2Sxz7l+uhO9fZYCtmOt3ooA=;
 b=Tqokqv0Zs+VVBxw95+I8/YikNFNLUgZBf+TXf5zV9r4IdWiaAUcPkojyfcDWCrC12BBi+42kb
 VN875A8Ot0AC9OnbOIehiAT0B3tJ9zqki7fkRB4uM8eTYqpeno1PIzK
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
 include/linux/rhashtable.h | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ef5230cece36..edf4d4c5102e 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -650,6 +650,91 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
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

