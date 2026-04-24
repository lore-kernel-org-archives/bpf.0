Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA183FA5CF
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060280; cv=none; b=Psdyi3waEQemI/yiSoweQPZWcUqae6VhlPayXHQml07w+hz8zemxLCGZzzEvClQ/x4IJGeXnnhWzcKxN4Kh+uaC1tnWHWsRi8aDuYsUQA21a8GUU3FEqNMZskNjohmfNAEYmO9L0N+HIhaLa+xEE1V9YycQYA4shHItMR0zVGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060280; c=relaxed/simple;
	bh=81hCcnG9O4+EsPYq197wynIKmlIWkK8Pv9DMhUczunE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHnZL0CnwO/KfbzzSj3MYqSOjpKELOf1xczqMw/6PLi3tZJrulElrv0oHRhns1EJH0X4RUyQaFSPLj+A4Gd8dLYEp1gdjHaxcKPH6yF/U8D6uboe6LEPPk0SEY1IPyC2AXJsogvLcw8uCwx5tXhynolHZXytHJV9Ys5fW9W9ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9mOGid9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9mOGid9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dea72099eso8691159e87.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060264; x=1777665064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFDyaPyyYq9FofvTfwcigKlvkMb+TsX8Xds+zVWo8Lk=;
        b=a9mOGid98ELxr38GUMWS6nkwTXmJFs6ThTOUlLT8+Hm9dOchrqO1RD/+W5ULm671H+
         wHiOMoyTHAYDqgOSjyqB+PdFHHaKroGdeTBNRrwvdvRCZw7HqXrMcT7rpV/PEt9PezFC
         fRqVQbEkmvDOAAjQPP1bDj8QVYf89YTqfbdN2HtHNGYOa0thL2yfIz6dOTVN85WcpzyM
         9H46WcinNjEt3oyRw74e8j1oNPSUgGz+p38Ki5qqpwfLReBbZl1cjUfQlhX96lmwalb1
         G//RkUwVMyMSQmchwKFd7j6z8GNY3+j6AOb2VvNojTpca4EfGRakuykEJVUIzYAL6CRT
         AHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060264; x=1777665064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LFDyaPyyYq9FofvTfwcigKlvkMb+TsX8Xds+zVWo8Lk=;
        b=eXOC35TogwZx2AKH8viX1u1gkHwXiHkik/ermaUAp3kadbJChUAxb8tq8M/xU4OtiF
         DKx7v/nuZLj/4EadlNrgeya9+BO5i9iNOU0L2Ck7IgQtEwhD1kj86e4pPVUrnUDthUvJ
         ng2vxFHzAdtvKFl35urFcidMMTyHf6QTsy+iuGtxlIhBTk4Ovb5/FOeIvdKl3sSMDx5P
         gY2OCQiJX04MS34djFwh3cXbqqwF6/SiQRiHDEcH9Yv4efJkT539+EhGbBWJlIlc9SDI
         FQWFlLyQfcP2v8+PTfEJKoqylZa0CYovwrSnrfZQUNhMsOLsQNuj8bR1jSYYOm39yCyL
         cBLw==
X-Gm-Message-State: AOJu0YzxERl4QkQEsNji+hXO0kx8Mmln5vXUEAECQ2JmPo77IwiDaSOq
	SPZcTnmpVutOcCXdS5nspU1nJ5Xebwiha7BRaNQw3yO82D/ozQrazxeB
X-Gm-Gg: AeBDieu4NI2gH1XHAGK9rxwIJy50WzVisdDChdFOaYzAGfXvrzkqwesISuQdcSkmeaO
	3ogX5B+5P/co6KRMbFnq3i9EuG+h9HjGIyfmkaVUAVkBjYD+40TRKNQ946fZDaSzzVwlvzUFAHc
	2fPZaBBOtdO4fSR/LI5KLfvf8lVn1dFTyJ6B/CpzkE6+N5p+iXdowaSUt2kE2UaRjZFEe94R38E
	JeTxSLaCtPdEUSqF66157ZczGqQgYudG9uTDmeFwRYn7xTKhy/L3bIQWs5OsO8LoGCTFDVE3hC3
	XPAKgjX1Tmv0sIo/FaqMih87rSL8wjz0p3Z5/7SfAFRLGL9YGSc2S3AHUNBPnV0nxVMO+ZS7fhk
	rJV8z2N5GrKypJag/Mlvvg2Q0AohSup3IaGJuuqc8CmQOFCBIjcvKpx1N0YpVf9x2kWdZQSMRcX
	C+/xTlMi5rbaWmCOmIFKnBSIfyQC3nw/lXqw==
X-Received: by 2002:a05:6512:3b0b:b0:5a2:c0ab:b57f with SMTP id 2adb3069b0e04-5a4172bfef2mr9872391e87.14.1777060263571;
        Fri, 24 Apr 2026 12:51:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ec277sm6291480e87.84.2026.04.24.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:44 -0700
Subject: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=8605;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=vjEGvVm/nH83wAKGE50PPMqmWTbme7VkjQDrDcCdki8=;
 b=KLbgv3xTOfnjVxpcKAM3XIqbAyxW4wr46iGk3/Xk0Hfea9oMgvmAY+pIiyGrlcCtXzhUpTP9o
 WJvk39vEvMACX531eB3zo2N/eTMFd3Hn+qaqyKeESAj0nxjw8ORCBzq
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
walker resets to the beginning.

Refactor __rhashtable_lookup into __rhashtable_lookup_one to reuse
the single-table lookup in both the two-table search and the new
enter_from positioning.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h |  31 +++++++++--
 lib/rhashtable.c           |  41 ++++++++++++++
 lib/test_rhashtable.c      | 131 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 0480509a6339..6ac547d6c619 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -246,6 +246,11 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
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
@@ -606,8 +611,8 @@ static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
 }
 
 /* Internal function, do not use. */
-static __always_inline struct rhash_head *__rhashtable_lookup(
-	struct rhashtable *ht, const void *key,
+static __always_inline struct rhash_head *__rhashtable_lookup_one(
+	struct rhashtable *ht, struct bucket_table *tbl, const void *key,
 	const struct rhashtable_params params,
 	const enum rht_lookup_freq freq)
 	__must_hold_shared(RCU)
@@ -617,13 +622,10 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
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
@@ -639,6 +641,25 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
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
index 6074ed5f66f3..2a6098edf737 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -692,6 +692,47 @@ void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
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
+ * containing @key.  If @key is not present in the main table, the iterator is
+ * positioned at the beginning.
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
+	tbl = iter->walker.tbl;
+	if (!tbl)
+		return;
+
+	he = __rhashtable_lookup_one(ht, tbl, key, params,
+				     RHT_LOOKUP_NORMAL);
+	if (!he)
+		return;
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
index 0b33559a910b..0c4f489bf655 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -23,6 +23,7 @@
 #include <linux/random.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
+#include <linux/cleanup.h>
 
 #define MAX_ENTRIES	1000000
 #define TEST_INSERT_FAIL INT_MAX
@@ -679,6 +680,133 @@ static int threadfunc(void *data)
 	return err;
 }
 
+static int __init test_walk_enter_from(void)
+{
+	struct rhashtable ht;
+	struct test_obj objs[4];
+	struct rhashtable_iter iter;
+	struct test_obj *obj;
+	struct test_obj_val key = { };
+	int err, i, count;
+	int len_freq[4] = { 0, 0, 0, 0 };
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
+		key.id = i * 2;
+		scoped_guard(rcu) {
+			rhashtable_walk_enter_from(&ht, &iter, &key,
+						   test_rht_params);
+			rhashtable_walk_start(&iter);
+		}
+
+		do {
+			obj = rhashtable_walk_next(&iter);
+		} while (PTR_ERR(obj) == -EAGAIN);
+
+		/* Successor must not be the key itself */
+		if (IS_ERR(obj) || (obj && obj->value.id == i * 2)) {
+			pr_warn("walk_enter_from: returned err %ld or key %d instead of successor\n",
+				PTR_ERR(obj), i * 2);
+			err = -EINVAL;
+		}
+
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+
+		if (err)
+			goto out;
+	}
+
+	/* Test 2: walk_enter_from with non-existent key starts from the beginning */
+	key.id = 99;
+	scoped_guard(rcu) {
+		rhashtable_walk_enter_from(&ht, &iter, &key, test_rht_params);
+		rhashtable_walk_start(&iter);
+	}
+
+	do {
+		obj = rhashtable_walk_next(&iter);
+	} while (PTR_ERR(obj) == -EAGAIN);
+
+	if (IS_ERR(obj)) {
+		pr_warn("walk_enter_from: returned err %ld\n", PTR_ERR(obj));
+		err = -EINVAL;
+	}
+
+	/* Should still return some element (iteration from bucket start) */
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	if (err)
+		goto out;
+
+	/* Test 3: verify walk_enter_from + walk_next can iterate remaining elements */
+	for (i = 0; i < 4; i++) {
+		key.id = i * 2;
+		count = 0;
+
+		scoped_guard(rcu) {
+			rhashtable_walk_enter_from(&ht, &iter, &key, test_rht_params);
+			rhashtable_walk_start(&iter);
+		}
+
+		/* Count the number of elements after this one */
+		do {
+			obj = rhashtable_walk_next(&iter);
+			count++;
+		} while (obj && (!IS_ERR(obj) || (PTR_ERR(obj) == -EAGAIN)));
+
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+		if (count > 4) {
+			pr_warn("walk_enter_from: walked %d elements instead of max 4\n", count);
+			goto out;
+		}
+		/*
+		 * Collect the lengths of every walked path,
+		 * we should have each length walked one time
+		 */
+		len_freq[count - 1]++;
+	}
+
+	for (i = 0; i < 4; i++) {
+		/*
+		 * Should see at least some elements after key 0.
+		 * Exact count depends on hash distribution.
+		 */
+		if (len_freq[i] != 1) {
+			pr_warn("walk_enter_from: duplicate tail length\n");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	pr_info("walk_enter_from: all tests passed\n");
+out:
+	rhashtable_destroy(&ht);
+	return err;
+}
+
 static int __init test_rht_init(void)
 {
 	unsigned int entries;
@@ -738,6 +866,9 @@ static int __init test_rht_init(void)
 
 	test_insert_duplicates_run();
 
+	pr_info("Testing walk_enter_from: %s\n",
+		test_walk_enter_from() == 0 ? "pass" : "FAIL");
+
 	if (!tcount)
 		return 0;
 

-- 
2.52.0

