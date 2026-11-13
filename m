Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611335;
	b=J7AYsq8gH2OTX1MlBIgHUWGlk9IqMFxS1XWfFfkhDtljKGRANGLavPDwjC5+y8LUhy1S
	 wwS0gFzIgvmv2wADhvFt8v4KISUo5SYFN+7PsOYNKAEuVZeT3ERhQpWdlrjRPbOtoq4mk
	 KyqKmz0jz1a51qFbYS7Ln7o01IfHPNhcUeuUbmX8I49xAhpcIQfYFOtHsHn+imxhzsB92
	 1tDpCx6EtvfDviXWC5hcFfoQ9p1sWAM6HS6bCyI7rQWtd3rD42Y/SyCw+0Lg2evkg3P7f
	 dwyimD4a1G5FqAo2IssFdWhkrxvZnFPmgVo1dHOX07JndwmEb27sya2I03faGUlxtmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GJoooGPhLJPY6s6gMD1zBsANV/pXSdErIppoBI/AIcQ=;
	b=cecON/dJlED7Aq8stFd34HIelpb/X5iQanQoS2k29AwrHOgLjdttVF+g9yhPJnEIJ5yv
	 BRqj5lJmZPfwenFufGpgvfKiiKywStwSS3Z8sRxgEXnMGy2K+EjXO9hWY5Xtoxy3MajW/
	 l1J/3wB35JjwTE6YutyFW6NON4P4IiA4QcbmpJhDL/0Daw1ZTneARkSKs280xQqyJDqlS
	 96uTU4KEbC3tNNom5HDVlip9HFK0iUAYBFheTUZ7yqro4WJXtTV7jI6/AhYp6GHtsYHv0
	 hcVj44hxzydHJ9UqkRZwKF72Bd7/lhfw7g3KJSinmkm9UkpHsM3PGX2F8G9YEtr8dHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gc5SGeVi;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239D606A32E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E239D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gc5SGeVi
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b32daac9d7so12242287b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611334; x=1795216134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJoooGPhLJPY6s6gMD1zBsANV/pXSdErIppoBI/AIcQ=;
        b=gc5SGeVidl7XoHtPDUSm1n1EqbgiD1bOaZ85QqFPNATphPe5uO+t38jmaF+5ZS7JDF
         8to7CkEqWoDnMoA7DOe5wDgI4b2Umemu8EJHEiAlLP8HDytQArjcH/t3dinogtQQPzqY
         Qh77yYnqqoEdSu+PxKIS8v9jaWDoE9JTrog68ilQ7cC4/penIeCq5DfqTyIKsuVoge16
         BxXDGDDZ/2juQPght+7b47VSB0HgNHMenyJQcSPbw9EvgbEX6Lpvg0wGkAfkGrvdTbJh
         L3x+xj1Nco7Q1qjue6iViNQ2sr0AiTkmMLAkDJECGQqobvC/w9ANgT7WPdBjJWJxv8Qj
         u/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611334; x=1795216134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJoooGPhLJPY6s6gMD1zBsANV/pXSdErIppoBI/AIcQ=;
        b=kVrKQu7FviyVCXG8ItqxLW2EY6NyoUpBRWpjQFemza0QL3SCjTJohNpN6b3nV2BBiw
         F2OU0d0hn1VjsHBXPq6r3yG2qpiZuNw+bNjL9vu5hdr5YHQ1nI8EdbIOyQw/UbDF/xn3
         GKh/n5CnX3eo7PWwC4vlxWSzKY1G/NcmTuDeN3uczSW6lA4yy0EH3Q7lPa1e5A1hzzcJ
         XEEPuBZRmgeJrs84n88DIvTee2N5lRK54L6zzoECbhJcIA2g/e0lKu6llzCl2JYfMFIF
         HByl5zyvNjnuFpSh4QEpKBuqlFVFiyZ1tJQ+tLf9nmYrQ5lxl/P7A3o5UHzZhP/i0sxv
         RcJA==
X-Gm-Message-State: APuU4Z/E2QqoeY5NoEvp5/1kBPxfV4U3CpDHPwlDF9oRFJ7zVBCfjkBH
	B9nwE/xNCUsi9LQFcc4CfZ0ltdYuZsFtzfLRQYZpeNGXVoaesDdsAQ2m
X-Gm-Gg: AYBFou0iEba1aWXjFDeIi9dAAzS8YZ0jdAQbEkV1xE70er/wLVSzDilP4CPyIc4J/lR
	NSPtRBM2YPg2+THYeiSfS/4LE7ez/jgM59MrQX92ISKvuKuYIkfmKHYBOJx9jcUf15OmQUurTqg
	bIDNBNDeTmuzXDugL3k+ECsL2lsMaH9kwLpX4Rf6ZcNrZkD/NlrekFdc7/iDVnMAqvvqq9GUI0A
	QIkg2rFS3V2ucrA5VkofxyOtLaxvuuRAJCVaHa3+tNUXvW99tuIo9Oc7CS/HJepSISlr2N1DgjL
	3YKgH5JzrQ5jV0Z03s+ZoF0kN4aOnQY6FhyaoaTgM8yRTAZe18xJ51QccEd5z2YexSn8fN8aEnk
	wCysTxYqK2RZZH1azR3YVRywR2nlKPGByrIWPh2vkDHVdAnPAliUZT27sfGoko1LnYUh8kbOeGH
	X3QWw3QktoOcPjkkMKJwwD0RQI7NPug5xXq0B2hiPSSRAvADd7fjzTAWDcyxbwsQGJeIdGj4ns0
	BCi+qAKZwiyvPlBRKuHv9ouzFiSb44h5UkHrXFkBZqdh6QEAC146Lm0hGi50ei2lL9pKqeFccrj
	vTWuzNsYBNkrKoe0rDBYmQIbV0rCgkUIrOPDp0RC
X-Received: by 2002:a05:690c:8010:10b0:8a9:a1e9:2665 with SMTP id 00721157ae682-8b3bb0580famr29939947b3.6.1794611333650;
        Fri, 13 Nov 2026 15:08:53 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aaa0ea50sm31554767b3.42.2026.11.13.15.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:53 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:29 -0800
Subject: [PATCH RFC bpf-next 06/13] bpf: Keep local storage objects with an
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
Message-Id: <20261113-sls_f1-v1-6-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=8639;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=yHk0OmNetEFIcmtzLE7qgJHhrQReIzJGp9KAbDT/5Vg=;
 b=ZU4JTFjfVYb2Gl+AekDsDzkOMOLI+YAVly1KGywwgtksvCAOh/WDo8GlHRqnM8cm2TyKUsJbh
 4D05/eWJxKtBJws8xgjz8D0UDPZ4YPUOd4o3PClNpBeWrFd0DHDi+iL
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

