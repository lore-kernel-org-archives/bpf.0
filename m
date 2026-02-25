Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16223161B1
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045492; cv=none; b=tR3Irz62a8hnd/bY8CQv0aonvQVUfLHKddYf9+QXz1iKYyt7fDteyYzrkjFlVcxjmD0fnnOrhCsrfFrqrF2NQKv70KmLm2apGU4nE26nM69zr+GSqDydSbmvPvSMJljMxKtOI0sVaEiroerqZBJYlUcEgma20qLXVoDHyxa2u3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045492; c=relaxed/simple;
	bh=CESFUKL4HrmoCuoD8i5FErj2LIZOs9mBkQSyTY4OXFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZngFl2yphr17Uq59Qxd/YWhLpb/LTWd8BCxUTU176V86mb1W7ujrcUHOsuc0umYVwqSmkmbv3NqswP04RPMcJachMSxTpBKQ4gneyWAIknqPTaLKLBxCDSN1SUOTkF9EJwTUTBEexyDilwFAntyWCB4o6RD3GVZup6UDzWmBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc1IvKjK; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc1IvKjK"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d1890f7ee4so4601057a34.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045485; x=1772650285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Amid55c5Nx+YrhOcrGe9HXEgOl3su/5W7e4xSvQBh4=;
        b=Qc1IvKjKTbAchwHIM8dF9j+bQmCfAVHyiebvpe1hUJIzPoznjOYqKIklDdgB1mU/Tt
         iFcJagBKyPFCvnZH3n2aAxeqzEmSAajEdPMPV1kfOtn94xkK0QRxBiG/iI5zXuE4wnLU
         ORVssrEk+5Q4XuCSefimY3deJbVFt3HOSTZ+s/Ac3gFyW1QTToOZboLx9ShNGVKXCFBy
         UvssVwcJ1rP0yMUkuU5LngOsrY4iHWYGZf7UrsQqyzNMc3eiGgahSn+a0KM5D/ZJ4FGJ
         RuJDaHv/MgVBMy2xjihf/fGZxmzbDz82IHV/DEqQL+WqtsspipCAPlmaoZoHY8DWXBVD
         9r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045485; x=1772650285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Amid55c5Nx+YrhOcrGe9HXEgOl3su/5W7e4xSvQBh4=;
        b=u6IMcLuCg+VP22bkAu45HUWoX8YpyuCdUCj2h8dxPKrl2BnnRQcHnZtJcGZwPnRcmK
         OA01lUaCCB1pAYdpymjwGUp74RcUM9riMvRz7mPjUYJPVz8zTbe34K1gLdJuRjOg2SS2
         tcXfmPTnxC/Y7XtLuH6UKuHd5riuwxjI2vHzDlf1LR7Tasb1Kl88bddHGy7bzW5lVm8I
         U1Qw2bIa2r1GuA5Wsf7mD9jMrqQK5Cn9t9SRGMdzVpI+TdSKWdrlI9Uu86GgxDw2taX4
         x5ZzCFpnDcH4B/ZHztj/514R4Pwe6SmJ+N66zBs9GRb1GyQNt7PAWTi6M01P9f2EhQj1
         AgNQ==
X-Gm-Message-State: AOJu0YzZgKmniC5pBZJfmePFRL7arRjZfIyhNRTZGTW1CVvxMKLQdBJ5
	u/D3g6c5jMzev2A8KbckHdSA+qxSXdDb34L8KCvbuk7FIHV+1Cli31+dq1/IWxfg
X-Gm-Gg: ATEYQzxSNN5uycN9FK0vBXiujE/fDg13YC/wRzuCYD5xD70qW22BUNJx7wpvrDVLQji
	SjF0GP7ajLZ4IXdSc5lKpVDpZJV/DAmBT2TYtzRSwPHqPt9VM08/rqK3wvQXMXPtuysLVtHQWR+
	J1VjX6xaBv5CNmJql7SvPtXF679yTCQcuUh6bP4uHM7gWUsmC7gIK4DwWZJyIcqezvMi1gREdhj
	+/oJ8PHa9yIkBZPL+v4OxyfLc/U+Lu8vP7CS3BcYv6hJzLifm8yfKRMP9/vVBANOLtASzeYcHGu
	QKkSK7h0D5BxxRKzuK048M/mD3u1l2om9Bjj9sqYtwORY3OPMMATl47MFK+Y3eDT44Rl43sHTB5
	dbq+r4tq1w77U3UPcQCKBAcle1eZoPRfdRMMjlrS7+VpR6nb4Yh72u9ysnIHXFnXh7rT5XQBO58
	MD/tOJqao39lUJbvK6kZg7hAj/9Ekh5g8DN2LZhF5pvGYw
X-Received: by 2002:a05:6870:8317:b0:409:ddda:a14b with SMTP id 586e51a60fabf-4157ac21a6cmr8962094fac.2.1772045484722;
        Wed, 25 Feb 2026 10:51:24 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9f666sm13013256fac.7.2026.02.25.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:51:24 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/4] bpf: Register dtor for freeing special fields
Date: Wed, 25 Feb 2026 10:51:18 -0800
Message-ID: <20260225185121.2057388-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225185121.2057388-1-memxor@gmail.com>
References: <20260225185121.2057388-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9659; h=from:subject; bh=CESFUKL4HrmoCuoD8i5FErj2LIZOs9mBkQSyTY4OXFE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpn0QMtvw3nndZDvqCQw5MlfBlgl4GHfNEDwcoR/ng R/fzGRGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaZ9EDAAKCRBM4MiGSL8Ryo38EA CtO4EfS/Q227HWg2KmF3GBgFC6RPUB1RfjX+IYjj94Qn/oS18dpERU1jlzx0KYqzxd3XrMY0Hmo3TL 4d2zuyh0634DRueKgfXaA+N8zznGa17T6YB+jsdxs7jSE6ZHejO/rNZKr5u3b065dSZyVl+6cTepRa QSCE6TTUc2TSjtfx3gyq3vYniZexfoVRfYp9DB4tY3jZDMHQLOhFV5B6z/eDM7EEmgfFp/+xOUSFuY m5YhO56zTsq7AJUcjSkz/hZKYe4JNcdvaLE63kj1ct5z7MKghf3XNo9AVE6g8KMAT+DA3qsQB5eHrH ifdH7maFyv7i/G7jXSZPZZQ36mytxG6XjM+X96JoM26RtW2chhmu0bchTQPQMRUjtJEzN52Ev+0YFy aL0NojeqY4EA8kKf8e2dJMuO+MFC4AfLO8HGjx5cuMroAmPOCY1uN8wB4a7hQPR7G21hLEQjF220/n L8Czc0Ixnlj53MtOYEDEPh//W8fszAPE6IbNgBvedm/JrFfDlueI+I2IE07/doO04BUjEBkxLrNSrE 8Edkm9odVEKQrs7b9g6UKdxws4Tbyc7FQScxDAoVsFjNqaKMtS4es2VQY6UwBLYlesQp05AVRxGmYr pywln49BbqOVNGHVt54pubnXo9/qz4VxnsQhpuMKOUZl94OutVBbVxE50Urg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There is a race window where BPF hash map elements can leak special
fields if the program with access to the map value recreates these
special fields between the check_and_free_fields done on the map value
and its eventual return to the memory allocator.

Several ways were explored prior to this patch, most notably [0] tried
to use a poison value to reject attempts to recreate special fields for
map values that have been logically deleted but still accessible to BPF
programs (either while sitting in the free list or when reused). While
this approach works well for task work, timers, wq, etc., it is harder
to apply the idea to kptrs, which have a similar race and failure mode.

Instead, we change bpf_mem_alloc to allow registering destructor for
allocated elements, such that when they are returned to the allocator,
any special fields created while they were accessible to programs in the
mean time will be freed. If these values get reused, we do not free the
fields again before handing the element back. The special fields thus
may remain initialized while the map value sits in a free list.

When bpf_mem_alloc is retired in the future, a similar concept can be
introduced to kmalloc_nolock-backed kmem_cache, paired with the existing
idea of a constructor.

  [0]: https://lore.kernel.org/bpf/20260216131341.1285427-1-mykyta.yatsenko5@gmail.com

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_mem_alloc.h |  4 ++++
 kernel/bpf/hashtab.c          | 37 ++++++++++++++++++++++++++++++
 kernel/bpf/memalloc.c         | 42 +++++++++++++++++++++++------------
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index e45162ef59bb..7517eaf94ac9 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -14,6 +14,8 @@ struct bpf_mem_alloc {
 	struct obj_cgroup *objcg;
 	bool percpu;
 	struct work_struct work;
+	void (*dtor)(void *obj, void *ctx);
+	void *dtor_ctx;
 };
 
 /* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
@@ -32,6 +34,8 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 /* The percpu allocation with a specific unit size. */
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
+void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma,
+			    void (*dtor)(void *obj, void *ctx), void *ctx);
 
 /* Check the allocation size for kmalloc equivalent allocator */
 int bpf_mem_alloc_check_size(bool percpu, size_t size);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3b9d297a53be..74f7a6f44c50 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -457,6 +457,32 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
+static void htab_mem_dtor(void *obj, void *ctx)
+{
+	struct bpf_htab *htab = ctx;
+	struct htab_elem *elem = obj;
+	void *map_value;
+
+	if (IS_ERR_OR_NULL(htab->map.record))
+		return;
+
+	map_value = htab_elem_value(elem, htab->map.key_size);
+	bpf_obj_free_fields(htab->map.record, map_value);
+}
+
+static void htab_pcpu_mem_dtor(void *obj, void *ctx)
+{
+	struct bpf_htab *htab = ctx;
+	void __percpu *pptr = *(void __percpu **)obj;
+	int cpu;
+
+	if (IS_ERR_OR_NULL(htab->map.record))
+		return;
+
+	for_each_possible_cpu(cpu)
+		bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+}
+
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -569,6 +595,17 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 						 round_up(htab->map.value_size, 8), true);
 			if (err)
 				goto free_map_locked;
+			/* See comment below */
+			bpf_mem_alloc_set_dtor(&htab->pcpu_ma, htab_pcpu_mem_dtor, htab);
+		} else {
+			/*
+			 * Register the dtor unconditionally.  map->record is
+			 * set by map_create() after map_alloc() returns, so it
+			 * is always NULL at this point.  The dtor checks
+			 * IS_ERR_OR_NULL(htab->map.record) and becomes a no-op
+			 * for maps without special fields.
+			 */
+			bpf_mem_alloc_set_dtor(&htab->ma, htab_mem_dtor, htab);
 		}
 	}
 
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bd45dda9dc35..137e855c718b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -102,6 +102,7 @@ struct bpf_mem_cache {
 	int percpu_size;
 	bool draining;
 	struct bpf_mem_cache *tgt;
+	struct bpf_mem_alloc *ma;
 
 	/* list of objects to be freed after RCU GP */
 	struct llist_head free_by_rcu;
@@ -260,12 +261,15 @@ static void free_one(void *obj, bool percpu)
 	kfree(obj);
 }
 
-static int free_all(struct llist_node *llnode, bool percpu)
+static int free_all(struct llist_node *llnode, bool percpu,
+		    struct bpf_mem_alloc *ma)
 {
 	struct llist_node *pos, *t;
 	int cnt = 0;
 
 	llist_for_each_safe(pos, t, llnode) {
+		if (ma->dtor)
+			ma->dtor((void *)pos + LLIST_NODE_SZ, ma->dtor_ctx);
 		free_one(pos, percpu);
 		cnt++;
 	}
@@ -276,7 +280,7 @@ static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size, c->ma);
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -308,7 +312,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
 			llnode = llist_del_all(&c->free_by_rcu_ttrace);
-			free_all(llnode, !!c->percpu_size);
+			free_all(llnode, !!c->percpu_size, c->ma);
 		}
 		return;
 	}
@@ -417,7 +421,7 @@ static void check_free_by_rcu(struct bpf_mem_cache *c)
 	dec_active(c, &flags);
 
 	if (unlikely(READ_ONCE(c->draining))) {
-		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
+		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size, c->ma);
 		atomic_set(&c->call_rcu_in_progress, 0);
 	} else {
 		call_rcu_hurry(&c->rcu, __free_by_rcu);
@@ -542,6 +546,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
+			c->ma = ma;
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -564,6 +569,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
+			c->ma = ma;
 
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
@@ -616,6 +622,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 		c->objcg = objcg;
 		c->percpu_size = percpu_size;
 		c->tgt = c;
+		c->ma = ma;
 
 		init_refill_work(c);
 		prefill_mem_cache(c, cpu);
@@ -624,7 +631,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 	return 0;
 }
 
-static void drain_mem_cache(struct bpf_mem_cache *c)
+static void drain_mem_cache(struct bpf_mem_cache *c, struct bpf_mem_alloc *ma)
 {
 	bool percpu = !!c->percpu_size;
 
@@ -635,13 +642,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
-	free_all(__llist_del_all(&c->free_llist), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra), percpu);
-	free_all(__llist_del_all(&c->free_by_rcu), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu, ma);
+	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu, ma);
+	free_all(__llist_del_all(&c->free_llist), percpu, ma);
+	free_all(__llist_del_all(&c->free_llist_extra), percpu, ma);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu, ma);
+	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu, ma);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu, ma);
 }
 
 static void check_mem_cache(struct bpf_mem_cache *c)
@@ -751,7 +758,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			c = per_cpu_ptr(ma->cache, cpu);
 			WRITE_ONCE(c->draining, true);
 			irq_work_sync(&c->refill_work);
-			drain_mem_cache(c);
+			drain_mem_cache(c, ma);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
@@ -766,7 +773,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				WRITE_ONCE(c->draining, true);
 				irq_work_sync(&c->refill_work);
-				drain_mem_cache(c);
+				drain_mem_cache(c, ma);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
@@ -1014,3 +1021,10 @@ int bpf_mem_alloc_check_size(bool percpu, size_t size)
 
 	return 0;
 }
+
+void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma,
+			    void (*dtor)(void *obj, void *ctx), void *ctx)
+{
+	ma->dtor = dtor;
+	ma->dtor_ctx = ctx;
+}
-- 
2.47.3

