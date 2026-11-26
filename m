Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660868;
	b=g3RGVgDG9Lm37Z/Z75HLcl1TxdJb8zzBan+ruxDwimtN5nQMeA1NdiJMYWp6WfTsq2En
	 Al5Fwp/WBSStUnwp+Mss9T7hVJ+HsKQizw4LWcK3SFBe7HPfoxewp6c3Zws+Sp7VuXkn9
	 ibY3BqJDZyIUb06YaWxwopwlnBYbQDZKk/zhDHZALOwXDPBmXJ4A9kq/2wo+EJEOtYX9O
	 lwTam0bujnANZfgjKU1XbJX5Xv10omSndv/6kQy8DjYI8zIWfsVf2KOqZFpKwwgCmvVI8
	 w2sq9942qB4BHufLeBPI9F30Vmf3IqeKz/Q3z59OtE9cyQFDmEePYBbEsk7OB9IooLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=43+GgBIPNbN+EhlpfOo+kGIizseAq6F9VnzQ7NhmYAA=;
	b=hVJph/oqmphidohcD1Q741U42myfOVIr2/9fjbRNe1z58pzwq0ATOLv73qFSJAM9FbwF
	 OJtnYTbQK/ScKZTJMIKZg9GRH9CKGoRkz3R/ppN5Tht0qArPcjuex4hgo+5XKHfCuamng
	 e4xDrcqB3kl/mFkF4EvcyxlbbSz0bzfNKsEMPMksGNWI+XZQfpRQcg4/7kGrrgP+vw8gZ
	 J+OcPuhoAlZXNR1/0CJay14AEqooU2ADtEws/hiWBhlJpzRWD/KQQkvEGRSgpJXYoQPvV
	 Rf69oWzrCvfNDGslyVxZbRHK6HEqCDGNoA7W7C6Yy/+UA1gseLnQWeGWmaAaQ1hpZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQCE+SAl;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C6606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B83C6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQCE+SAl
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so2882162a12.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795660867; x=1796265667; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43+GgBIPNbN+EhlpfOo+kGIizseAq6F9VnzQ7NhmYAA=;
        b=EQCE+SAlEDsUEOQxrk2kQZAlepJI3cKTspMi1jIddcQanOqRVSDnl0uNzdvFM1hwiO
         cac2KvvMrmjmGy2P93tDQCpPBeOCp7U9DWD7pSlCL5Q8HeZtu63FHcdQPcUpq7Fvir+i
         5mclwRZ20i9MT31RBxWDO2Q2qGv+0ivIpwEDrPb6uv3cb5Z1CT9AkcOBJM9hfTF//BgJ
         Qq78swU7KiKaxrYEEsNTiOiR72GZg1/2gH2b4NKoSKBx8Jkg52R7u9JJynw2aSVK2CjH
         cHhOUVNv/FbVZ+cL9TWqRMWr6Up/Ljhr7N/i8Ar/TMgRGQal+j9OfwohX3czOnkdgvPl
         2lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660867; x=1796265667;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43+GgBIPNbN+EhlpfOo+kGIizseAq6F9VnzQ7NhmYAA=;
        b=0wrBBAhnHJSH9mSUEYZ9C20/DHS1vc/ay497PExrRh7UO52zo+9beP4Ut6na9v3xC2
         nzU4gy8rsgM5Cz5iistH1tiz5hD31nkpnRPCtpNJzXgy9JVyfBQ5Yq8uJ+rvQyKb/WQO
         QKRhp+hxtjTuNn76sbAAjY27vum576QvNwnPaYLHisOVBhoZVmEAV/dlTzsGJ9osvoc6
         ALe3XIgNIZtJxey+wo2Q/osHwvwD6iMgcRX3sWJvHc//n00oFvtRspfQRiTCrkw50yjY
         59CdhtXme37Q2LKB2gBnqCo564ckeRxaG8zxOfFSVuXIRpGWiJqvoR4UGmy0ZtVrQhR2
         M2mQ==
X-Forwarded-Encrypted: i=1; AL+hErE2lexjH1e+amssmoSr54c+W3S79BjFPXLSP3TtQId4LIPVmIXy2x+c0pO9hSPxlY7WyTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+htj6f4/HbCfaa+kUKpDXCp4ljwHPHKDE8Qr/Kp3em24mIab2n
	KquVuyvGI/t5onIADm2IFfxfmVZzRioqbwDunRFpKGhPNOgEsB1PuKTQ
X-Gm-Gg: AZFdTZdeyex9+1Ut1odBUSAiIpkmXYBU8sTrTGSD/qwmkEJZqk/uOgcdBYIy48mNulL
	1EdSakcQSSbGTUdxUWfuvlZNjkmxtmRTHs293ehUJPVAO0s0pK17Xl6qhfqpbGT+K6GT6NTSB2N
	I4hdAij/2FYbRyfbsjOMDc4lDjYk8sxlkcN/bVXa/R1s/fhVnXLcenIKYfoFGbo2G8sS6ZYi00t
	iRV0M46YQ9F2+O4kLk/WsdXFJ/bwgJHOuPfWTQL9zJ3zSjE7HGS1qXRHo1f1LhdFuuKIVXcsn1s
	PfnKJVQ85nFRhDT6IRbpiNRa3iyA9n63NjEGmvlLFAprSqNkIWk1FfMl0YMglrt4WMHQcTrNwep
	i4Nb6WegaRTzx3tRMPE0p+ll+idRLavwc3eRdDYPM+pkFkQ3kCPayeXV/NTiG+wbmNGzvKFY5dG
	HPneeMGI/SMhYfoHt0/EWLV1YY4DP1+/BHXAnww41VrrKoROZar+Fp6MuNMu2bm/TcS03GMi9uN
	HWBwjTfQDW/HNaOa6K68sMzBrNSmoijtV8IUV5R8bd8dkqsdixvb4yBhsVRu2arJNHng8W3SWqt
	Qt+DHBR9trqMhLQMB61phcN6fDnviWDBYjjYiiCeXQAuHyvwpSqtzwLx8fu7wF4q+c/LL9buS+e
	2zZv0JFceOlICYBlUjrL+OgL/i8CCAsMerA==
X-Received: by 2002:a17:90a:e7d0:b0:3ab:2737:3392 with SMTP id 98e67ed59e1d1-3b41c95fa25mr18864177a91.53.1795660866806;
        Wed, 25 Nov 2026 18:41:06 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm32703404a91.6.2026.11.25.18.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 18:41:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 02:41:06 +0000
Message-Id: <DN4SNHSNQ7E8.1Q1SW1CKDHLZS@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH] bpf: Require a bpf_spin_lock for bpf_list_head and
 rb_root
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Quan Sun" <m202672221@hust.edu.cn>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>
In-Reply-To: <b887fe56f02f8578e41cf0009da7638fb6f8ec0c.1795627805.git.m202672221@hust.edu.cn>
References: <b887fe56f02f8578e41cf0009da7638fb6f8ec0c.1795627805.git.m202672221@hust.edu.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 05:14 PM Quan Sun <m202672221@hust.edu.cn> wrote:
> of the object and then treat whatever it finds there as a lock.  The
> guard holds today only because btf_parse_fields() stores a negative
> errno in spin_lock_off; it is a load-bearing coincidence, not an
> invariant the code states anywhere.

It's not a coincidence. btf_parse_fields() has

  rec->spin_lock_off = -EINVAL;

and "< 0" is the test for a missing field. Your hunk uses the same test.
The damage is different. "continue" skips the root, so all nodes leak.
A refcounted node keeps a stale node->owner, like before 4a7910ee060d.

> test for that combination.  Restore the original requirement and let a
> follow-up teach bpf_{list_head,rb_root}_free() about rqspinlock if
> res-only guarding is actually wanted.  The BPF_F_LOCK checks in

It's wanted. The log of 0de2046137f9 says so. So does the log of
commit 7b7b8b596010 ("bpf: Reject resilient lock operations in rbtree
callbacks").
check_reg_allocation_locked() accepts res locks since v6.15.
Such progs load and run today. With this patch they stop loading.

The bug is in the free path. Fix it there.
It doesn't need the lock. Update and delete don't free the roots since
commit a3a81d247651 ("bpf: Cancel special fields on map value recycle").
Only these callers of bpf_obj_free_fields() can see a root:

  caller                         why no prog holds the lock
  -----------------------------  ----------------------------------
  array_map_free()               the map is freed next
  htab_free_prealloced_fields()  the map is freed next
  htab_mem_dtor()                kfree() of the element is next
  __bpf_obj_drop_impl()          the last owning reference is gone

The verifier takes a lock or a root from a map value or an owning
reference only. a3a81d247651 is in v7.2. Older trees need it first.

res_lock_roots_drop() should return -EINVAL today due to the stale owner.
With your patch the BTF of refcounted_kptr.c doesn't load.
The diff goes in place of your patch.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d1..d6b170f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -664,10 +664,8 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_wq_cancel_and_free(void *timer);
 void bpf_task_work_cancel_and_free(void *timer);
-void bpf_list_head_free(const struct btf_field *field, void *list_head,
-			struct bpf_spin_lock *spin_lock);
-void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
-		      struct bpf_spin_lock *spin_lock);
+void bpf_list_head_free(const struct btf_field *field, void *list_head);
+void bpf_rb_root_free(const struct btf_field *field, void *rb_root);
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
 /*
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 937a0d7..2dd0164 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2301,39 +2301,22 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 }
 EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 
-void bpf_list_head_free(const struct btf_field *field, void *list_head,
-			struct bpf_spin_lock *spin_lock)
+/*
+ * bpf_list_head_free() and bpf_rb_root_free() run when the object with the
+ * root is freed. No prog can lock it or reach the root, so they take no lock.
+ */
+void bpf_list_head_free(const struct btf_field *field, void *list_head)
 {
-	struct list_head *head = list_head, drain, *pos, *n;
+	struct list_head *head = list_head, *pos, *n;
 
 	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
 	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
-	INIT_LIST_HEAD(&drain);
 
-	/* Do the actual list draining outside the lock to not hold the lock for
-	 * too long, and also prevent deadlocks if tracing programs end up
-	 * executing on entry/exit of functions called inside the critical
-	 * section, and end up doing map ops that call bpf_list_head_free for
-	 * the same map value again.
-	 */
-	__bpf_spin_lock_irqsave(spin_lock);
-	if (!head->next || list_empty(head))
-		goto unlock;
+	if (!head->next)
+		return;
 	list_for_each_safe(pos, n, head) {
 		struct bpf_list_node_kern *node;
 
-		node = container_of(pos, struct bpf_list_node_kern, list_head);
-		WRITE_ONCE(node->owner, BPF_PTR_POISON);
-		list_move_tail(pos, &drain);
-	}
-unlock:
-	INIT_LIST_HEAD(head);
-	__bpf_spin_unlock_irqrestore(spin_lock);
-
-	while (!list_empty(&drain)) {
-		struct bpf_list_node_kern *node;
-
-		pos = drain.next;
 		node = container_of(pos, struct bpf_list_node_kern, list_head);
 		list_del_init(pos);
 		/* Ensure __bpf_list_add() sees the node as unlinked. */
@@ -2359,8 +2342,7 @@ unlock:
 	    pos && ({ n = rb_next_postorder(pos); 1; }); \
 	    pos = n)
 
-void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
-		      struct bpf_spin_lock *spin_lock)
+void bpf_rb_root_free(const struct btf_field *field, void *rb_root)
 {
 	struct rb_root_cached orig_root, *root = rb_root;
 	struct bpf_rb_node_kern *node;
@@ -2370,14 +2352,8 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
 	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
 
-	__bpf_spin_lock_irqsave(spin_lock);
 	orig_root = *root;
-	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
-		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
-		WRITE_ONCE(node->owner, BPF_PTR_POISON);
-	}
 	*root = RB_ROOT_CACHED;
-	__bpf_spin_unlock_irqrestore(spin_lock);
 
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
 		obj = pos;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec8e787..b105328 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -872,14 +872,10 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			unpin_uptr_kaddr(*(void **)field_ptr);
 			break;
 		case BPF_LIST_HEAD:
-			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
-				continue;
-			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
+			bpf_list_head_free(field, field_ptr);
 			break;
 		case BPF_RB_ROOT:
-			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
-				continue;
-			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
+			bpf_rb_root_free(field, field_ptr);
 			break;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index cae00f7..24551dd 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -757,6 +757,50 @@ int list_push_back_uninit_head(void *ctx)
 	return ret;
 }
 
+struct res_roots {
+	struct bpf_res_spin_lock lock;
+	struct bpf_rb_root root __contains(node_data, r);
+	struct bpf_list_head head __contains(node_data, l);
+};
+
+SEC("tc")
+__description("res_lock_roots_drop: drop of the roots unlinks the node")
+__success __retval(0)
+int res_lock_roots_drop(void *ctx)
+{
+	struct node_data *n, *m;
+	struct res_roots *o;
+	int err;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return -1;
+	n = bpf_obj_new(typeof(*n));
+	if (!n) {
+		bpf_obj_drop(o);
+		return -2;
+	}
+
+	err = bpf_res_spin_lock(&o->lock);
+	if (!err) {
+		m = bpf_refcount_acquire(n);
+		err |= bpf_rbtree_add(&o->root, &m->r, less);
+		m = bpf_refcount_acquire(n);
+		err |= bpf_list_push_front(&o->head, &m->l);
+		bpf_res_spin_unlock(&o->lock);
+	}
+	bpf_obj_drop(o);
+
+	/* Both fail when the node is still owned by the roots in 'o' */
+	m = bpf_refcount_acquire(n);
+	bpf_spin_lock(&lock);
+	err |= bpf_rbtree_add(&root, &m->r, less);
+	err |= bpf_list_push_front(&head, &n->l);
+	bpf_spin_unlock(&lock);
+
+	return err;
+}
+
 SEC("?tc")
 __failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
 long list_del_without_lock_fail(void *ctx)

Kumar's address had typo in Cc...

Taget bpf-next.

pw-bot: cr
