Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752511;
	b=13w8ACwU1nC0gcQU/RWDEuEx+jXGmNvEXmbxw6HzeAEUfkBP2Z1UNGZ/7PeovCVlX6Me
	 jCXDT3jsqLyLKP58SVNVA2ANyVEPFKC1QyZptVTUUvzwz+86BQ5zWKticWTI2rl/zZ4Bs
	 5T4oF7oruGXRgIEMOIHUNJbFtTSljjo06e8oijSvDfEuxsKfq6vxH5YAlCrSu6PEIKfzD
	 CCo60Tx0hu4cbYZKBmSh6zyk8RuAljfVxWE6AOwVilYTesOB+FrB9/QCff5sVF6rtYWHj
	 aOhnooc2dapDR4gto2X94xlJgUP1H6SFedDr4tQge5SOS03ThBMBMwCLaOTcW9MKSLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FcHuatx2meUTlgCG0m9y4eNcSRZC+D790iV3bNU7SzY=;
	b=p4DXt1juJTYL7YI+QA43N9uHKUXWuhtCyflQUgwCvBCR9hWoXtXHY8kQNuWXEZttiJWx
	 gpPglm37EHD/rDVWyXTmZ67kbEi1RhBeIZXCcpFeIQp7SpY1PclBxfQBR3QxNB3ovh3B8
	 Gi2FE1pN5XPFexmHPazldwzv12GC/XAYExYHxzjZYwhnNCR+rVUDoaBggKvKy6bdm3vy2
	 1FQDCs/4l96Rzzx1MOFTXaMEf8yoNMloLvVhjtrwRtOSR/X3JpupmCaE1bF43HhL2QtMl
	 cSg+F0tV0zzMJATwrwIbHPSkzlHLoAowfwYHuKDBCZJG05MDutLtkyRKm3afZ+YfN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldUqheBG;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E7606A324
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E1E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldUqheBG
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed08b07213so413785ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752510; x=1794357310; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FcHuatx2meUTlgCG0m9y4eNcSRZC+D790iV3bNU7SzY=;
        b=ldUqheBG7uRnuiKhd9W2cb9bgQJMGO7+vnNvtoIXd2DCURC5f2rpCpBEehiAtlDkZc
         nZa/6IW7UotN7sRfVuufxDTOb0nKSsvUpy8sQBXuzYEL7F7aejhmnC72UWZd6D6p48bI
         yzTncya7rsLZU4uc4V0PGkPTlg1N+I1jDUSPa/Dq9xX/MfVgv7qiZs8NXFXZ4BbyqA+h
         VK6zMZZcVZqDV1GpCz7bu8AXdbBwT1TJJX+A370plPPdh26D2+giv8yrFiKZd/1tCFYZ
         YxwLYBof8lB9dfPjxPpXkudjKcGBeFcxqKmdBsuIPhaHISydHkDoIIj1t1eaQ4Kq0jGQ
         pexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752510; x=1794357310;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcHuatx2meUTlgCG0m9y4eNcSRZC+D790iV3bNU7SzY=;
        b=di3KUuyCKX3U6KT4oLT3HLTuE4nPJaoXoZ4UZp89kmN0BKCwrfGRlFksu++oCM1Cba
         prqOAsAKnDfkDP4vUNFQmIgo2tctC6Yo7FCxcIqgCGRcfdecxVlclUt81CKePWX7Bl8V
         1fdokSQ9gef7U3NiUCc8hEQIGzmE9YqGH426CXabKCL/HfeA8+vojOlpLHQdOHxsHzpy
         zIb/vWElNV5PSzQ7qYVCot8flLYxWp1lmTaxk3WuaaEVB2tj3xvwTqTYtnHAaG4Qx9mL
         3VW4AN5pqlJ2zWF/roUjKK8AtIrmzHIC2DSdRViHkhSVLPdbmVU2mEmYFDB+GyRwyCr4
         VEsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYV+o2nQSM99I5PFXmfELP83tYI7l5+btmICnrzFNT3PyTcBtL4KuWD0L+T+gFGMOsKoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Yg4Rq7GjrcFVHAwaOLYHSlqe5PCsLbAJJMOkxPssaxJ5fA31E
	g4E7wa0nVy0LqVSfuIkfQbTHrQqajsnqtR5vKX35C+va5rUo/+y4xuC7
X-Gm-Gg: AYBFou1Bd3OF0SX5qyfBWg1iX/XPUaS86oDZdklisnZvpSluBRtoKrhwzB5ZgKLi9+g
	bFml5rDsRdY0yKSjfJ8L31gc/gOXSeED54nr3wsCy8RcBjyEEXQ+lP32XYrHnqjQVfyfFuJHPiy
	R0vzPHHVgjntm3Kob9rPaAqrJAimzx5V/Rvk7UKG7SUr8ot5Q8cXqSsoXJvfEjdx/ekeo32crmq
	+xilEUlyBcw2t46fs573tzwYgwoJwVl7NK2bWq9I2NelRzMaoNhIsuno/Hjff5cqTNAD0m80BVE
	2h78MLZSiAJSV/ekMArBwji3una9wf6Ub5xVVRNHO9lWbZke/WQODGRazMkbQbKKCTeAhR6+SvP
	IwSd71nDaJsOUrvW8baZYSM0H8a+jH4EYQCR8cJw2H+mJwUDsQO0zfTge/BvlsO7bRgT4X6EuHN
	z8+skX8AQUJWZwaQ/ywd2Hr96w14OTcFO+sblJGUe68uCPdy9ShC9EjCf+pjVE4j30I4Jn5EvY3
	fII29f9hga8ez8GpchNeFxvt6iC/I5BMg/P06P+blYyNMXZy+DbTW5u6r0XcUwKl1EamnyX+JFf
	Xw27H1qvmHQGqMnyPwZU9Fw4iwrADNQcyw1kNKW8dALiCaRdoJijcJaX++BbIBXDQjlXbW1oRL+
	VP9LmGBxNckSSXgfYcG3NkX9MNB7vxTTyBg==
X-Received: by 2002:a17:90a:e7c6:b0:3ac:6e91:3f22 with SMTP id 98e67ed59e1d1-3ae897dc106mr10674785a91.52.1793752510264;
        Tue, 03 Nov 2026 16:35:10 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1183720a91.1.2026.11.03.16.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:35:09 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:35:08 +0000
Message-Id: <DMM072L9H884.193UBSBZRTKYO@gmail.com>
To: <mt4022@columbia.edu>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Mykyta Yatsenko" <yatsenko@meta.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <tz2294@columbia.edu>
Subject: Re: [PATCH bpf] bpf: Fail rhtab inserts and deletes with IRQs
 disabled
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
References: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
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

On Tue, Nov 03, 2026 at 10:46 AM Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org> wrote:
> A bucket lock is only ever held with IRQs disabled, so return -EBUSY
> from deletes and from inserts of new keys when IRQs are already
> disabled, like the other hash maps do on re-entry.  Lookups and updates

The other hash maps fail on re-entry only. rqspinlock detects it.
This check fails every insert and delete with irqs disabled.
That's perf_event progs, kprobes via int3, sched_switch and
sched_wakeup tracepoints, sched_ext ops under rq lock.
imo it's not worth breaking all of them for a rare deadlock.

> This is the check Alexei suggested on the RFC of the series [1].  It also
> stops perf_event and other programs that run with IRQs disabled from
> inserting or deleting keys.  I can turn the reproducer into a selftest
> if that helps.

It was my suggestion, sorry. It's too broad.
v4 of rhash picked bpf_disable_instrumentation() to keep these callers:
https://lore.kernel.org/bpf/20260513-rhash-v4-0-dd3d541ccb0b@meta.com/

Only a caller with irqs disabled can run inside the locked section of
this cpu. Lets trylock the bucket in that case and spin otherwise.

  caller with irqs disabled    today      this patch   trylock
  -------------------------    --------   ----------   -------
  bucket is not locked         works      -EBUSY       works
  locked by another cpu        spins      -EBUSY       -EBUSY
  locked by this cpu           deadlock   -EBUSY       -EBUSY

Then no need for bpf_disable_instrumentation() in rhtab.
params.trylock_irqsoff is a compile time constant in the fast path,
like insecure_elasticity. The other rhashtable users pay nothing.

The diff leaves one more bug: rhashtable_insert_rehash() calls
kvmalloc(GFP_ATOMIC). That's not ok in NMI.

Something like this (compile tested only):

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 3576b8f..a5c4e69 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -52,6 +52,8 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
  * @min_size: Minimum size while shrinking
  * @insecure_elasticity: Set to true to disable chain length checks
  * @automatic_shrinking: Enable automatic shrinking of tables
+ * @trylock_irqsoff: With irqs disabled insert and remove don't spin on
+ *		     the bucket lock and return -EBUSY
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
  * @obj_cmpfn: Function to compare key with object
@@ -65,6 +67,7 @@ struct rhashtable_params {
 	u16			min_size;
 	bool			insecure_elasticity;
 	bool			automatic_shrinking;
+	bool			trylock_irqsoff;
 	rht_hashfn_t		hashfn;
 	rht_obj_hashfn_t	obj_hashfn;
 	rht_obj_cmpfn_t		obj_cmpfn;
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 70dac92..ba2c594 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -339,6 +339,33 @@ static inline unsigned long rht_lock(struct bucket_table *tbl,
 	return rht_lock_nested(tbl, bkt, 0);
 }

+/*
+ * The bucket lock is held with irqs disabled. A caller with irqs disabled
+ * may run inside the locked section of this cpu (NMI, kprobe, tracepoint).
+ * It cannot spin.
+ */
+static inline bool rht_lock_or_busy(struct bucket_table *tbl,
+				    struct rhash_lock_head __rcu **bkt,
+				    const struct rhashtable_params params,
+				    unsigned long *flags)
+	__cond_acquires(true, __bitlock(0, bkt))
+{
+	if (!params.trylock_irqsoff || !irqs_disabled()) {
+		*flags = rht_lock(tbl, bkt);
+		return true;
+	}
+	/* bit_spin_trylock() always succeeds on UP */
+	if (!IS_ENABLED(CONFIG_SMP))
+		return false;
+	local_irq_save(*flags);
+	if (!bit_spin_trylock(0, (unsigned long *)bkt)) {
+		local_irq_restore(*flags);
+		return false;
+	}
+	lock_acquire_exclusive(&tbl->dep_map, 0, 1, NULL, _THIS_IP_);
+	return true;
+}
+
 static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head __rcu **bkt,
 			      unsigned long flags)
@@ -785,7 +812,9 @@ static __always_inline void *__rhashtable_insert_fast(
 	if (!bkt)
 		goto out;
 	pprev = NULL;
-	flags = rht_lock(tbl, bkt);
+	data = ERR_PTR(-EBUSY);
+	if (!rht_lock_or_busy(tbl, bkt, params, &flags))
+		goto out;

 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
@@ -1066,7 +1095,8 @@ static __always_inline int __rhashtable_remove_fast_one(
 	if (!bkt)
 		return -ENOENT;
 	pprev = NULL;
-	flags = rht_lock(tbl, bkt);
+	if (!rht_lock_or_busy(tbl, bkt, params, &flags))
+		return -EBUSY;

 	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
@@ -1149,6 +1179,7 @@ static __always_inline int __rhashtable_remove_fast(
 	 */
 	while ((err = __rhashtable_remove_fast_one(ht, tbl, obj, params,
 						   rhlist)) &&
+	       err != -EBUSY &&
 	       (tbl = rht_dereference_rcu(tbl->future_tbl, ht)))
 		;

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6e21154..edc7572 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2983,6 +2983,7 @@ struct bpf_rhtab {
 static const struct rhashtable_params rhtab_params = {
 	.head_offset = offsetof(struct rhtab_elem, node),
 	.key_offset  = offsetof(struct rhtab_elem, data),
+	.trylock_irqsoff = true,
 };

 static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
@@ -3011,6 +3012,7 @@ static const struct rhashtable_params rhtab_params_long = {
 	.head_offset = offsetof(struct rhtab_elem, node),
 	.key_offset  = offsetof(struct rhtab_elem, data),
 	.key_len     = sizeof(long),
+	.trylock_irqsoff = true,
 	.hashfn      = rhtab_hashfn_long,
 	.obj_cmpfn   = rhtab_key_cmp_long,
 };
@@ -3143,21 +3145,11 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 {
 	int err;

-	/*
-	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
-	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
-	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
-	 * raw tracepoints, which we don't have in rhashtable.
-	 */
-	bpf_disable_instrumentation();
-
 	if (rhtab->map.key_size == sizeof(long))
 		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params_long);
 	else
 		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);

-	bpf_enable_instrumentation();
-
 	if (err)
 		return err;

@@ -3268,16 +3260,11 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);

-	/* Prevent deadlock for NMI programs attempting to take bucket lock */
-	bpf_disable_instrumentation();
-
 	if (map->key_size == sizeof(long))
 		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params_long);
 	else
 		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);

-	bpf_enable_instrumentation();
-
 	if (tmp) {
 		bpf_mem_cache_free(&rhtab->ma, elem);
 		if (IS_ERR(tmp))
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 500c45c..2dc13f0 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -650,7 +650,8 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 		} else {
 			bool inserted;

-			flags = rht_lock(tbl, bkt);
+			if (!rht_lock_or_busy(tbl, bkt, ht->p, &flags))
+				return ERR_PTR(-EBUSY);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,

Pls add the reproducer as a selftest in patch 2 and cc Herbert Xu
on respin.

pw-bot: cr
