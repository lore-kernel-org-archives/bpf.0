Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446973;
	b=TSdHnMDg12t8CyE7r+RQCr7sSkQkAGAKiqw4V/6t02CeoDBF8523G7l7sLhPAsMCeZJW
	 H82eMTd5pKoGplb3iPzsjaY40mTxmWTaqORp0yMUkLs4wIjAVslwOtrA+vwOP3ViJCzWI
	 zQ+kH5EZiO9HBugS/1tLRGL/Fj+JtKLkwvgVq3kXTCdJbpmaICqduHL7wrL8BnpbIaIJr
	 WSpzzot7o4dkysgpBHGSfwTSfWACTTrck8sfe9SGn61dIkogua8LZrkCpq7/99lPulIzB
	 RUL67bWSN7yG45z14SjjQ+/hzIod3OQefyDPe4RPzRWVM2hcRcTEHIbf2a8n8zVE4Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GJoooGPhLJPY6s6gMD1zBsANV/pXSdErIppoBI/AIcQ=;
	b=ReN6/niQ0C0bDnmngvKQDnP2LFvo7VrSxM3i4XO/5zQteknkaRYjvIVWuHXFL3GCMAuv
	 cfBOp4mOdiQPKv80ndwfqQjpfexge/aYJs8vti2V+SKa8z5MqkuJJJZVGUovnp9rugomh
	 DpPFdCQhLueAwlGV+WlBaB4QiLCxxTxbjVPQQVuBKhzzYMJm2ln23r3kLSDOSxPGwKawv
	 4mZclxvEky9Jt5RsLZKB0SYb3VDpcofn6Yfweojcl5lGkb0Cw7//AF/JAoUFuE6o9gHrz
	 2/5XMRiYxexrrNYBac8QtYWEMmvrYnebIVIc6An3VD9RooMX6XHiaD0r9//WLY+FFKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUqJcc7M;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741C606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6741C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUqJcc7M
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-475920b9ca2so1105103fac.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446972; x=1796051772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJoooGPhLJPY6s6gMD1zBsANV/pXSdErIppoBI/AIcQ=;
        b=KUqJcc7MuukMb5uHoFTPb2JoPhBiqeZUDDoyP+Jn/sf+2cqCP+AZpWlu27QMoX8x23
         G/zQgnrrIMkhPMSHWF0GOLrEqY6XMy6FsIqWfMuZ5H1NhGzTmCIigvRP59LFP/q9cqL3
         mElI/qHqV7OUjlqXbDRfM4cAjAsL40dugharu97BIxT3NjxP8U6tE/SKLzFSC00AEFfZ
         OedybgiJZ9y9STPCfUHVKuAeNn54gH8k3TaOCvxvJ6kXWvhENJJBbO0oBwRPYoadtm+0
         P2zm1YEpzqu+gE1gvnyF+waQTpRJNishrLe9MZC66q6gyVfnZWG/PS9KQwFhWETym8um
         KDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446972; x=1796051772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJoooGPhLJPY6s6gMD1zBsANV/pXSdErIppoBI/AIcQ=;
        b=E0C2zixi9GWIX9LmOz1/LKMtpTDoAnsrD35QAkIrn9uiI6jQ/ZmqbWtFu4bVsOUlU7
         MMh7IVEFKYFyHmTxYXrS/MxyhsRTleonvpJ5komSr71ERM/k+6oXfPhrZIOuPsmcukal
         MhgdJAuft5swEQK+vo5gczRfjj2uI9My9SCej3fwXBRQvA624kPdLKVK2XOVmsOmGkJ5
         nphXOyspkHqeu8HRBAQr+lhnPU7u523PahZ/nRQrmm2k1j1zGifw4Vh6rVPlTw67dlGy
         hc1r4LWCzLlTNstTfWLkH1aUB1p1ZvpP2c2hDn0JE3xt9FwpEf9sAbgQwbJqoWxxOVJG
         FLdQ==
X-Gm-Message-State: APuU4Z/V2xo6QV4Q/cb1vohxe0mgP5L29nUG2iSZpCamGk6Tyouhqvj4
	pnb3EQQB+S+Q4F0ULiihL58l1Ku0HcJegIbUEpanwoTKfH/sG0oCaiKa
X-Gm-Gg: AZFdTZdU1uKSR65Yk9RoRfBTjcL7/yfBcSUP/QmSxBecjGtpe+qiQYRSuS6xIF4B6TG
	Hy2nUu44nJi2Oa8pOigxIX4pBo4zmD5Gj/y0Ac63enTRN+eaduwda/eHg9m+xR5RXTfBdOLisAi
	rxSI/Up7N8W9GoByGj/BMnxru9NWLMXGX6fkIg/4UfjgMoSQtbeaFHu7K+Dk6amHmHZTUHyEHRJ
	rSHEeyGEV9QYO3lcpZ6w2SIklKmxYSUQMQs1b9fftNm23q3YfG0UHDkLfGSL6OCTKC14Ga90h5T
	amcKd8YV/RDeYIavYG4A35DTLbgZafq62Y68OAEaAWWaWDFiK0Jekw+jOlHzPsNFO4gLQ1YEdHS
	MSOzvp/b6E/bC4xMavnWlAC8oL44wQUa/kdGkkY/d2QfzYdVpfhw/VVt6R2IsdRUDlrfKQNnSrQ
	4nq81NnvWOi8K+FOthVIaG430kxQapZXIdm/Ri1SdbRgZnZMqBF5T+LszgQk0XPWLUO5BO2QDVC
	PLoTnkfcTRjohsQbgJoyQ6PORRjCyttJcWDr9vNEWG2d4kAqINX5v0XhhQusuTuNjW6SmmyZiRR
	PsRJM8wIHnXeQoJAZdcL
X-Received: by 2002:a05:6808:2211:b0:4d6:90d4:6bc with SMTP id 5614622812f47-57a0ba53115mr11627992b6e.46.1795446972232;
        Mon, 23 Nov 2026 07:16:12 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34250fa1sm8603923b6e.5.2026.11.23.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:11 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:46 -0800
Subject: [PATCH bpf-next v2 06/13] bpf: Keep local storage objects with an
 inline area until owner death
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sls_f1-v2-6-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=8639;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=yHk0OmNetEFIcmtzLE7qgJHhrQReIzJGp9KAbDT/5Vg=;
 b=JxLRzr7AsBVeNB7GqNBKoWOKMswYJ8LcB6ZZEgTxbbhVLCvJZyDCWd2UB5V6tM7RT4F6kpEHv
 4aelzczkaLiCrikq4RixeEObh5FFW+dZIKLb0T/jahDOct+ZhIZ3owh
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A later patch lets programs get pointers to values in the inline area.
Such a value has no selem, so an empty list does not mean that nobody
uses the object. Free an object with an inline area only after destroy(),
and always after an RCU tasks trace grace period, so that sleepable
programs cannot see freed memory.

Updaters can no longer use an empty list to see that the object goes
away, so destroy() marks it as dying under the storage lock. If it
cannot take that lock, it tries again after a grace period, so the mark
adds no leak. A failed unlink of an selem leaks as before.

While an inline map exists, new objects of its owner type are bigger and
live until owner death, also when the owner uses only normal maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h | 11 +++++
 kernel/bpf/bpf_local_storage.c    | 96 +++++++++++++++++++++++++++++++++++----
 2 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index f8e4e47b47c6..7a5f024622e6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -111,8 +111,19 @@ struct bpf_local_storage {
 	u32 obj_size;		/* Size of this object. It does not change. */
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
+	bool dying;		/* destroy() has run. Only with an inline area */
 };
 
+/*
+ * A program can hold a pointer into the inline area without an selem. So an
+ * object with an inline area lives until its owner goes away.
+ */
+static inline bool
+bpf_local_storage_has_inline(const struct bpf_local_storage *local_storage)
+{
+	return local_storage->obj_size > sizeof(*local_storage);
+}
+
 /*
  * Drop a reference got by refcount_inc_not_zero(&local_storage->owner_refcnt).
  * bpf_local_storage_destroy() may have dropped the owner's reference meanwhile
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 072807a1245f..b737b2e67c8a 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -114,7 +114,12 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 	if (!local_storage)
 		return;
 
-	if (reuse_now) {
+	/*
+	 * A sleepable program can still use an inline value: wait for it. A
+	 * tasks trace grace period also covers plain RCU readers: RCU Tasks
+	 * Trace is SRCU-fast, and its grace period calls synchronize_rcu().
+	 */
+	if (reuse_now && !bpf_local_storage_has_inline(local_storage)) {
 		kfree_rcu(local_storage, rcu);
 		return;
 	}
@@ -184,6 +189,31 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 		bpf_selem_free(selem, reuse_now);
 }
 
+/*
+ * Free local_storage when selem, its last selem, goes away. An object with an
+ * inline area can hold values with no selem, so free it only after destroy()
+ * marked it.
+ */
+static bool bpf_local_storage_free_last(struct bpf_local_storage *local_storage,
+					struct bpf_local_storage_elem *selem)
+{
+	if (!hlist_is_singular_node(&selem->snode, &local_storage->list))
+		return false;
+	return !bpf_local_storage_has_inline(local_storage) ||
+	       READ_ONCE(local_storage->dying);
+}
+
+/*
+ * local_storage goes away: the owner needs a new one for a new value. An
+ * object with an inline area can be empty, so destroy() marks it instead.
+ */
+static bool bpf_local_storage_gone(const struct bpf_local_storage *local_storage)
+{
+	if (bpf_local_storage_has_inline(local_storage))
+		return READ_ONCE(local_storage->dying);
+	return hlist_empty(&local_storage->list);
+}
+
 static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *selem,
 						 struct bpf_local_storage_map *smap,
 						 struct bpf_local_storage *local_storage,
@@ -227,8 +257,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	free_local_storage = hlist_is_singular_node(&selem->snode,
-						    &local_storage->list);
+	free_local_storage = bpf_local_storage_free_last(local_storage, selem);
 
 	bpf_selem_unlink_storage_nolock_misc(selem, smap, local_storage,
 					     free_local_storage, false);
@@ -440,8 +469,8 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
 		if (!err) {
 			if (likely(selem_linked_to_storage(selem))) {
-				free_storage = hlist_is_singular_node(&selem->snode,
-								      &local_storage->list);
+				free_storage = bpf_local_storage_free_last(local_storage,
+									   selem);
 				 /*
 				  * Okay to skip clearing owner_storage and storage->owner in
 				  * destroy() since the owner is going away. No user or bpf
@@ -634,7 +663,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
-	if (!local_storage || hlist_empty(&local_storage->list)) {
+	if (!local_storage || bpf_local_storage_gone(local_storage)) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
@@ -683,7 +712,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto free_selem;
 
 	/* Recheck local_storage->list under local_storage->lock */
-	if (unlikely(hlist_empty(&local_storage->list))) {
+	if (unlikely(bpf_local_storage_gone(local_storage))) {
 		/* A parallel del is happening and local_storage is going
 		 * away.  It has just been checked before, so very
 		 * unlikely.  Return instead of retry to keep things
@@ -901,6 +930,48 @@ int bpf_local_storage_map_check_btf(struct bpf_map *map,
 	return 0;
 }
 
+/*
+ * A storage is freed when its last selem goes away. An object with an inline
+ * area can hold values with an empty list, so mark it as dying under the
+ * lock: from now on updaters return -EAGAIN, and the last selem frees the
+ * object. Free an empty object now.
+ *
+ * If destroy() could not take the lock to unlink an selem, the selem stays
+ * linked. A racing map free that read its storage pointer before destroy()
+ * cleared it unlinks it and frees the object. Else the object leaks, as the
+ * selem does: map free skips the storage, and bpf_selem_unlink_nofail()
+ * warns.
+ *
+ * Only a timeout can fail the lock here: destroy() holds no other lock.
+ * Then try again after a grace period. Nothing frees the object while dying
+ * is false, so its rcu head is free. destroy() never runs in NMI.
+ */
+static void bpf_local_storage_mark_dying_rcu(struct rcu_head *rcu);
+
+static void bpf_local_storage_mark_dying(struct bpf_local_storage *local_storage)
+{
+	unsigned long flags;
+	bool empty;
+
+	if (raw_res_spin_lock_irqsave(&local_storage->lock, flags)) {
+		call_rcu_tasks_trace(&local_storage->rcu,
+				     bpf_local_storage_mark_dying_rcu);
+		return;
+	}
+	WRITE_ONCE(local_storage->dying, true);
+	empty = hlist_empty(&local_storage->list);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+
+	if (empty)
+		bpf_local_storage_free(local_storage, false);
+}
+
+static void bpf_local_storage_mark_dying_rcu(struct rcu_head *rcu)
+{
+	bpf_local_storage_mark_dying(container_of(rcu, struct bpf_local_storage,
+						  rcu));
+}
+
 /*
  * Destroy local storage when the owner is going away. Caller must uncharge memory
  * if memory charging is used.
@@ -908,6 +979,7 @@ int bpf_local_storage_map_check_btf(struct bpf_map *map,
 u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
 	struct bpf_local_storage_elem *selem;
+	u32 mem;
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -931,7 +1003,15 @@ u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		smp_mb();
 	}
 
-	return local_storage->mem_charge;
+	/*
+	 * The loop must not free an object with an inline area: only the mark
+	 * lets the last selem free it, so mark it after the loop. The mark can
+	 * free the object, so read mem_charge first.
+	 */
+	mem = local_storage->mem_charge;
+	if (bpf_local_storage_has_inline(local_storage))
+		bpf_local_storage_mark_dying(local_storage);
+	return mem;
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)

-- 
2.53.1-Meta

