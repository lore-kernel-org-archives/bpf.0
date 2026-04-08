Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BE3D5256
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661047; cv=none; b=TlbqczJwcaYM5jmfIr4rHfrYIW3xij5Xa+TsxEv87NjkM/lDSfKzwuREP94vI5eOo/ngAfGz+/VLkUPPCsRDLh/3hHgD/JtyiA4YCjEV05U5052a2QSfS2pmGvie+pg10Ft5v8ViZRaTgdfVXVQYWAMOJiwGQyOGHyZd0BHe1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661047; c=relaxed/simple;
	bh=gaP5ySj7h+SnFOzS6pB9gOxtSDtqw+ztxk7Tc6gq3KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phZwW1+dATQ7MoItBjpf5pUwK0A50qL8dQGjb6Qa+CgRXBuQpBjb9etSd83D2f3Z2flt88QcwQ//NEe9Hz5epOc3Z/BelxkUu4hlxCcQUVq1kuS/mDihMM91Gu1e6tBXhbeie8cvQbqyG9qTg2AKC3zLR7HzorHodF5HTgrQsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFKCVhd1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFKCVhd1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488971db0fdso52273565e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661039; x=1776265839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcX/ko03a6d4SEGIjPswlxh+wscJTppsFfY0lIcJDLw=;
        b=OFKCVhd1KWgs7fjNzbzLbq4URPrjk+QR9xg1g9f33OyCf0KwDvo+WlH9agqOJm9gOl
         9gVFEYGURldEAmPCxGBAFZPYxsxvrLgx4ILpDPCjLfc/EGlpjKZdXBhCaVU2SSMs+TJz
         XM5XMLWinvtydVjb6WUA4YkFSjIBGozTWyDMmWiE97TPGXHi3+rivMKksQRykWFbX/h+
         LQgBK8HWSPaBeSq+SMTsAEQ6qs+igmns/O91GOJAJoYoehzRBO61wQasqP2Xw9JOr80r
         +sqYkcCZz+ia1czGdVAV2SdkpDCjQk5culX4JmRrrgCZWSBJ8IwIx6BUXtgmZXKfyCYC
         TLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661039; x=1776265839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IcX/ko03a6d4SEGIjPswlxh+wscJTppsFfY0lIcJDLw=;
        b=YL9I+SkBtA8sAB1JlOUtx38ckqx0UPi1is1Ilvt/TTupMrMJJSuv/2ckcrFqJu0YEq
         zRvD7IZrXk/OxHmr7967EIFEYyIJjtKAPc8WO+XW/09UlILq+/8YB0IASNNxIe6qvsbN
         aokMzF+f9mvA7IR2t8dpfrBsmZhZjTl2HbrZFFXgJ7fLWZ0/maNLyqfw4wrL1AuBOaaQ
         pqt2y0KezLNksS333eQ8OYEQDlnoIUuUeDwDk/ImTfiAh5OljhfMCm1dpX6ssCvfyEOn
         L2r4pBjhz18QaEmbg2g1KF2RYa3d2ooenjUV5yRn7mArV6eHB8/sLW6Ulzmn4GQUCL3d
         0ARg==
X-Gm-Message-State: AOJu0Yw1UQquWgBkaRSBILwJJpx9pQOlVkCjGoijseTUBqd9R/epWxVj
	axipf7Div9R9AmeoZszUnWzrNKgjzVzb8p50wKJ2Qxn9DBprUBmdzQHz
X-Gm-Gg: AeBDievm0FWMI8AJ/gU9UaeewQdpeBWcOmfysoBRms0HaGFkpRVZQZTZ6vBNGTLkxkc
	KSbvXyGFDGwqzsAZX38RA++WJG6edA9Y4a0GjT0j6VtGpwjpJ/hTIuFvZKt6QylTvbQzOQzeGZ0
	AdKDrShysEBW6p+0qH21/JAYT+EzAsr+rVqVbqWHSLqb9nEKX/N6zdX6aEpGYvuJrPJjZzIp/KU
	iV5rjTMAPLPDZvMPu00BkuBVLAgNNTTzdUZAagEgQeKO292PnYTEhRS1IUKZOpVDhSVLNJ1MDP3
	9uPmGmc0TXx4A7tjq570iDRLOUWLwd1uQ1NR4KhuxDcKmVTWVuJpO7c+/znnzdh6qdCLTBok0MF
	P82B62a8DkuEGvkmgyhIypxV2oiKwSgeH39100hj2wv/sPgqUeL79C4le4JtQY9nL+X9c402BaJ
	zFVnmURwKc2+y4Cg==
X-Received: by 2002:a05:600c:548d:b0:485:3423:727d with SMTP id 5b1f17b1804b1-488cd068ce8mr749965e9.26.1775661039271;
        Wed, 08 Apr 2026 08:10:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dd63d6sm20962215e9.34.2026.04.08.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:09 -0700
Subject: [PATCH RFC bpf-next v2 04/18] rhashtable: Add
 rhashtable_walk_enter_from()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-4-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661028; l=8669;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=nBrQiGS5XbekLGn5nIJd56+swnNm845Cw/aL7050vrc=;
 b=1sRxfCwIIy1jsWmUv5L+CzIDEfbq9TXyMb6nh1LD+u1nwEJq4FeW6MsLIsf6Do5Uz6BKqie+a
 H4DzCUGo7FoA7OGtTa5Y8m/3i0vOngurhoLMw/sNU4n/OP4ixoxFNF/
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF resizable hashmap needs efficient iteration resume for
get_next_key and seq_file iterators. rhashtable_walk_enter()
always starts from bucket 0, forcing linear skip of already-seen
elements.

Add rhashtable_walk_enter_from() that looks up the key's bucket
and positions the walker there, so walk_next returns the successor
directly. If a resize moved the key to the future table, the
walker is migrated to that table.

Refactor __rhashtable_lookup into __rhashtable_lookup_one to reuse
the single-table lookup in both the two-table search and the new
enter_from positioning.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h |  31 ++++++++++--
 lib/rhashtable.c           |  53 ++++++++++++++++++++
 lib/test_rhashtable.c      | 120 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 5 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 133ccb39137a..2c7a343ac592 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -253,6 +253,11 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 	(void)rhashtable_walk_start_check(iter);
 }
 
+void rhashtable_walk_enter_from(struct rhashtable *ht,
+				struct rhashtable_iter *iter,
+				const void *key,
+				const struct rhashtable_params params);
+
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases_shared(RCU);
@@ -613,8 +618,8 @@ static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
 }
 
 /* Internal function, do not use. */
-static __always_inline struct rhash_head *__rhashtable_lookup(
-	struct rhashtable *ht, const void *key,
+static __always_inline struct rhash_head *__rhashtable_lookup_one(
+	struct rhashtable *ht, struct bucket_table *tbl, const void *key,
 	const struct rhashtable_params params,
 	const enum rht_lookup_freq freq)
 	__must_hold_shared(RCU)
@@ -624,13 +629,10 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 		.key = key,
 	};
 	struct rhash_lock_head __rcu *const *bkt;
-	struct bucket_table *tbl;
 	struct rhash_head *he;
 	unsigned int hash;
 
 	BUILD_BUG_ON(!__builtin_constant_p(freq));
-	tbl = rht_dereference_rcu(ht->tbl, ht);
-restart:
 	hash = rht_key_hashfn(ht, tbl, key, params);
 	bkt = rht_bucket(tbl, hash);
 	do {
@@ -646,6 +648,25 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 		 */
 	} while (he != RHT_NULLS_MARKER(bkt));
 
+	return NULL;
+}
+
+/* Internal function, do not use. */
+static __always_inline struct rhash_head *__rhashtable_lookup(
+	struct rhashtable *ht, const void *key,
+	const struct rhashtable_params params,
+	const enum rht_lookup_freq freq)
+	__must_hold_shared(RCU)
+{
+	struct bucket_table *tbl;
+	struct rhash_head *he;
+
+	tbl = rht_dereference_rcu(ht->tbl, ht);
+restart:
+	he = __rhashtable_lookup_one(ht, tbl, key, params, freq);
+	if (he)
+		return he;
+
 	/* Ensure we see any new tables. */
 	smp_rmb();
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6074ed5f66f3..2fc277207dcc 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -692,6 +692,59 @@ void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_enter);
 
+/**
+ * rhashtable_walk_enter_from - Initialise a walk starting at a key's bucket
+ * @ht:		Table to walk over
+ * @iter:	Hash table iterator
+ * @key:	Key whose bucket to start from
+ * @params:	Hash table parameters
+ *
+ * Like rhashtable_walk_enter(), but positions the iterator at the bucket
+ * containing @key. If a resize is in progress and @key has been migrated
+ * to the future table, the walker is moved to that table.
+ *
+ * Same constraints as rhashtable_walk_enter() apply.
+ */
+void rhashtable_walk_enter_from(struct rhashtable *ht,
+				struct rhashtable_iter *iter,
+				const void *key,
+				const struct rhashtable_params params)
+				__must_hold(RCU)
+{
+	struct bucket_table *tbl;
+	struct rhash_head *he;
+
+	rhashtable_walk_enter(ht, iter);
+
+	if (!key)
+		return;
+
+	tbl = rht_dereference_rcu(ht->tbl, ht);
+	he = __rhashtable_lookup_one(ht, tbl, key, params,
+				     RHT_LOOKUP_NORMAL);
+	if (!he) {
+		smp_rmb();
+		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
+		if (!tbl)
+			return;
+
+		he = __rhashtable_lookup_one(ht, tbl, key, params,
+					     RHT_LOOKUP_NORMAL);
+		if (!he)
+			return;
+
+		spin_lock(&ht->lock);
+		list_del(&iter->walker.list);
+		iter->walker.tbl = tbl;
+		list_add(&iter->walker.list, &tbl->walkers);
+		spin_unlock(&ht->lock);
+	}
+
+	iter->slot = rht_key_hashfn(ht, tbl, key, params);
+	iter->p = he;
+}
+EXPORT_SYMBOL_GPL(rhashtable_walk_enter_from);
+
 /**
  * rhashtable_walk_exit - Free an iterator
  * @iter:	Hash table Iterator
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 0b33559a910b..0084157a96b4 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -23,6 +23,7 @@
 #include <linux/random.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
+#include <linux/cleanup.h>
 
 #define MAX_ENTRIES	1000000
 #define TEST_INSERT_FAIL INT_MAX
@@ -679,6 +680,122 @@ static int threadfunc(void *data)
 	return err;
 }
 
+static int __init test_walk_enter_from(void)
+{
+	struct rhashtable ht;
+	struct test_obj objs[4];
+	struct rhashtable_iter iter;
+	struct test_obj *obj;
+	int err, i;
+
+	err = rhashtable_init(&ht, &test_rht_params);
+	if (err)
+		return err;
+
+	/* Insert 4 elements with keys 0, 2, 4, 6 */
+	for (i = 0; i < 4; i++) {
+		objs[i].value.id = i * 2;
+		objs[i].value.tid = 0;
+		err = rhashtable_insert_fast(&ht, &objs[i].node,
+					     test_rht_params);
+		if (err) {
+			pr_warn("walk_enter_from: insert %d failed: %d\n",
+				i, err);
+			goto out;
+		}
+	}
+
+	/*
+	 * Test 1: walk_enter_from positions at key, walk_next returns
+	 * the successor (not the key itself).
+	 */
+	for (i = 0; i < 4; i++) {
+		struct test_obj_val key = { .id = i * 2 };
+
+		scoped_guard(rcu) {
+			rhashtable_walk_enter_from(&ht, &iter, &key,
+						   test_rht_params);
+			rhashtable_walk_start(&iter);
+		}
+
+		obj = rhashtable_walk_next(&iter);
+		while (IS_ERR(obj) && PTR_ERR(obj) == -EAGAIN)
+			obj = rhashtable_walk_next(&iter);
+
+		/* Successor must not be the key itself */
+		if (obj && obj->value.id == i * 2) {
+			pr_warn("walk_enter_from: returned key %d instead of successor\n",
+				i * 2);
+			err = -EINVAL;
+			rhashtable_walk_stop(&iter);
+			rhashtable_walk_exit(&iter);
+			goto out;
+		}
+
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+	}
+
+	/* Test 2: walk_enter_from with non-existent key starts from bucket */
+	{
+		struct test_obj_val key = { .id = 99 };
+
+		scoped_guard(rcu) {
+			rhashtable_walk_enter_from(&ht, &iter, &key,
+						   test_rht_params);
+			rhashtable_walk_start(&iter);
+		}
+
+		obj = rhashtable_walk_next(&iter);
+		while (IS_ERR(obj) && PTR_ERR(obj) == -EAGAIN)
+			obj = rhashtable_walk_next(&iter);
+
+		/* Should still return some element (iteration from bucket start) */
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+	}
+
+	/* Test 3: verify walk_enter_from + walk_next can iterate remaining elements */
+	{
+		struct test_obj_val key = { .id = 0 };
+		int count = 0;
+
+		scoped_guard(rcu) {
+			rhashtable_walk_enter_from(&ht, &iter, &key,
+						   test_rht_params);
+			rhashtable_walk_start(&iter);
+		}
+
+		while ((obj = rhashtable_walk_next(&iter))) {
+			if (IS_ERR(obj)) {
+				if (PTR_ERR(obj) == -EAGAIN)
+					continue;
+				break;
+			}
+			count++;
+		}
+
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+
+		/*
+		 * Should see at least some elements after key 0.
+		 * Exact count depends on hash distribution.
+		 */
+		if (count == 0) {
+			pr_warn("walk_enter_from: no elements found after key 0\n");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	pr_info("walk_enter_from: all tests passed\n");
+	err = 0;
+out:
+	rhashtable_destroy(&ht);
+	return err;
+}
+
 static int __init test_rht_init(void)
 {
 	unsigned int entries;
@@ -738,6 +855,9 @@ static int __init test_rht_init(void)
 
 	test_insert_duplicates_run();
 
+	pr_info("Testing walk_enter_from: %s\n",
+		test_walk_enter_from() == 0 ? "pass" : "FAIL");
+
 	if (!tcount)
 		return 0;
 

-- 
2.52.0

