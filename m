Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828515;
	b=HqanZSALzYoxNK6428H+GWN9+GAFh6H3WRY5E5E/LGwxby7o0uBMPuyR2HEv86NyvWIx
	 KVGqE6q3dGiW9oMaxo5nNTH+iF3tO83FLJ0HFatZP6FAcJBT/eNwzJqmF9cTGYxKzAauG
	 hg8P3GEHoGIP4fQ6Rgoiol2/fH0XgEpGvsGGRdVdiJ0snSmWRbT5hySI2amNvHMXSv1Cm
	 J1WmAYrPb8tvpe0ljEqDww6xpXfYPwwuYRDwBfO+u0jyMs4Ua13rQzvsYWfQWvJ/7keB5
	 sRqrPXRFSXvAeaUrkJwXOCMnKEJYEuRqhCd/fV98XLdro9pCq2JFPVkrE8hm2ip6IZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q7Og+mW7oxCgirZzxRtSQUVOjU4FsOOYcTyf3uefVNI=;
	b=YTIrpPJSQMo5SHkKzRt70VFGoYHjlpqEm1EBOuKkJb3xd3S4DumbBZ6R/kl908MQkYRW
	 0d65GKctNrjreb44EMLRBLl7qGk2UQyC/9VZvza812gwGDNXISiMvbiQhFt/wgDdTMVKs
	 3CICenUfjMRl+f96k1BNkoBKmMCHDeIzRzA+FZjw663BCycVbURJNzGxVnnpXxknlPvEw
	 9fYpuPxljVc5vnVQAVCONK8MXXaOa9IaYvBCRdruN2GYoDmPkosE4+F4eNeNXxQMPnFjO
	 VutMvHPypaLq1lU16Zr5ajAmbMI5epB+pskX6bDE5zpRfeS2sDxK9zWclsq1pPiMeQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPqkaDeD;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB7606E2F4
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEBB7606E2F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPqkaDeD
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so11239905e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793828513; x=1794433313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7Og+mW7oxCgirZzxRtSQUVOjU4FsOOYcTyf3uefVNI=;
        b=nPqkaDeDDqROg1NgJ818bCBuDwWCrbuYLnYOJkqP5HpbG1l2XeD3T73FcKfmHaKkb5
         LvPVkqWWB39JgS+5qxZVC84CARLKFzrramGeO1Jjp242vVNA/ONhj6KzGaicLXWoZiKP
         x3vW9du2GbyB/fgp/FGvJxPCkEkf/FZBgYcV8DcZfl/4PHq+G3IhfiCSKMTQhZJCpf0d
         yiC/ArqxMdKFcDCiCkxBb9k2Q7/KYV3GaoJ/yxA3m5YZjhyb39+jYGkFbNsOvGkZOIkT
         wt1dujwaqjNA9dZNvDey1orpcUOn4ANTgAvAuCBbL6DVb9Byyu/6cuct49LOJ0OHYsr5
         aZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828513; x=1794433313;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7Og+mW7oxCgirZzxRtSQUVOjU4FsOOYcTyf3uefVNI=;
        b=0FbNuNohzEPtWxtfcV1CphcdWJ9GpviDX1lVQ6eFqFCTbJIIzgJu6Q0lurvZS1XaJt
         3KNsu+IEKE0Y56Kp1bjL72CBZqWKnTE1NVTVdInElXH5gn0w4J3lKByPpWSoxFdNKur6
         jciMrFQpvufrDw3RjysQsDEvVvN4mpQEkRFeVSVpUdhKrD6VniUL7CUf9eJTf3cUL0y2
         uv8OBnnA82x8IztGJmtdHW1u/NeB2PqBLWn7EjG/0STld71Y8+lt7JmLFsoOd1bSgz3e
         qNTXpHHvqtk7hVfENm99VwR4p0BLBdB4QpUWAxsplKT63lIaFwv1ZjhCBU+ULQGU/GC5
         HSKw==
X-Forwarded-Encrypted: i=1; AKwUvBwJnebD8pJWdWyfUmCmBU+M0VVSc9GbCK1cVnBqMHoArQty5RP2j7L4bKKxOzbZZwOrRxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lZ1HfWvha6WpDoQ59GAAoXR7IO5N55l++Z1gZ8lYf/S72hM3/
	3gZj3RJtShsJLByR8mp5CuIwhx5pDl5s8GmkZDRkzfIA+SdSKW3As90G
X-Gm-Gg: AYBFou1GIGh0FjahEcFbgNnHlE6vxZzFhUZZi2KQjZQ2pnh76SAruHoWgGf89UvTyzL
	A+JklxdDxzAxBTc4RM5CgsNeHdJ4whscUqgqiGZvpAOjYIeSiMnKFWiTbHTMPbTWa8hDU4+dSNQ
	26VBROV06690CreZJP5dEvYlRhIcS7TlOJtt85HEqQKo3iNw3yFNYOtQQ1p2qB5IXxtvRrjf4bL
	y375JtO9QKsy/rdDmakBzYAuWxUoulaBy3u4iEI0h13U97GWeitvnpkK1kkp9/Mm1Vx1rhg6GE+
	jK/2ZodI6Vb0VKylyX35wvJaXVFdnB6tjezsnA8Lb+jiaRccobN4vrcXHnkRANYomg1LXFma5Bt
	ONm2Iaal4eSB/8TCZl54ThfYVWeWxZhY0lCft5byXS5REjlUB2tOuSGVhjzAO65zKHeJVHZo6mL
	m9IiyopPRh0bqB4It7XSD2P7P4x4o9ly+EjCXwMPVcwiSno87E98HisMZhRnm68eRPX22Srnk43
	2L2EtscvMHW6PHOAEQ4gy8G5SyAy+ebVZ4slewmJug2AfCEIyQgnCEn0bclLJ17kTe2X38Kvv6n
	QcVUFMjoU/0+3vB2NSBqTSAjpVXV+IMZqvZE4wgSPe8NLDvZPCq5mSQJ/u/5vc08
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ac150b38d0mr378320765e9.2.1793828512992;
        Wed, 04 Nov 2026 13:41:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:b226:92e7:4fdc:71f4? ([2620:10d:c092:500::6:d12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ea594cfsm11464455e9.5.2026.11.04.13.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 13:41:52 -0800 (PST)
Message-ID: <380e70f0-476b-4ea1-91a1-621404f573f0@gmail.com>
Date: Wed, 4 Nov 2026 21:41:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fail rhtab inserts and deletes with IRQs
 disabled
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, mt4022@columbia.edu,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu
References: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
 <DMM072L9H884.193UBSBZRTKYO@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DMM072L9H884.193UBSBZRTKYO@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/26 12:35 AM, Alexei Starovoitov wrote:
> On Tue, Nov 03, 2026 at 10:46 AM Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org> wrote:
>> A bucket lock is only ever held with IRQs disabled, so return -EBUSY
>> from deletes and from inserts of new keys when IRQs are already
>> disabled, like the other hash maps do on re-entry.  Lookups and updates
> 
> The other hash maps fail on re-entry only. rqspinlock detects it.
> This check fails every insert and delete with irqs disabled.
> That's perf_event progs, kprobes via int3, sched_switch and
> sched_wakeup tracepoints, sched_ext ops under rq lock.
> imo it's not worth breaking all of them for a rare deadlock.
> 
>> This is the check Alexei suggested on the RFC of the series [1].  It also
>> stops perf_event and other programs that run with IRQs disabled from
>> inserting or deleting keys.  I can turn the reproducer into a selftest
>> if that helps.
> 
> It was my suggestion, sorry. It's too broad.
> v4 of rhash picked bpf_disable_instrumentation() to keep these callers:
> https://lore.kernel.org/bpf/20260513-rhash-v4-0-dd3d541ccb0b@meta.com/
> 
> Only a caller with irqs disabled can run inside the locked section of
> this cpu. Lets trylock the bucket in that case and spin otherwise.
> 
>   caller with irqs disabled    today      this patch   trylock
>   -------------------------    --------   ----------   -------
>   bucket is not locked         works      -EBUSY       works
>   locked by another cpu        spins      -EBUSY       -EBUSY
>   locked by this cpu           deadlock   -EBUSY       -EBUSY
> 
> Then no need for bpf_disable_instrumentation() in rhtab.
> params.trylock_irqsoff is a compile time constant in the fast path,
> like insecure_elasticity. The other rhashtable users pay nothing.
> 
> The diff leaves one more bug: rhashtable_insert_rehash() calls
> kvmalloc(GFP_ATOMIC). That's not ok in NMI.
> 
> Something like this (compile tested only):
> 
> diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
> index 3576b8f..a5c4e69 100644
> --- a/include/linux/rhashtable-types.h
> +++ b/include/linux/rhashtable-types.h
> @@ -52,6 +52,8 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
>   * @min_size: Minimum size while shrinking
>   * @insecure_elasticity: Set to true to disable chain length checks
>   * @automatic_shrinking: Enable automatic shrinking of tables
> + * @trylock_irqsoff: With irqs disabled insert and remove don't spin on
> + *		     the bucket lock and return -EBUSY
>   * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
>   * @obj_hashfn: Function to hash object
>   * @obj_cmpfn: Function to compare key with object
> @@ -65,6 +67,7 @@ struct rhashtable_params {
>  	u16			min_size;
>  	bool			insecure_elasticity;
>  	bool			automatic_shrinking;
> +	bool			trylock_irqsoff;
>  	rht_hashfn_t		hashfn;
>  	rht_obj_hashfn_t	obj_hashfn;
>  	rht_obj_cmpfn_t		obj_cmpfn;
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index 70dac92..ba2c594 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -339,6 +339,33 @@ static inline unsigned long rht_lock(struct bucket_table *tbl,
>  	return rht_lock_nested(tbl, bkt, 0);
>  }
> 
> +/*
> + * The bucket lock is held with irqs disabled. A caller with irqs disabled
> + * may run inside the locked section of this cpu (NMI, kprobe, tracepoint).
> + * It cannot spin.
> + */
> +static inline bool rht_lock_or_busy(struct bucket_table *tbl,
> +				    struct rhash_lock_head __rcu **bkt,
> +				    const struct rhashtable_params params,
> +				    unsigned long *flags)
> +	__cond_acquires(true, __bitlock(0, bkt))
> +{
> +	if (!params.trylock_irqsoff || !irqs_disabled()) {
> +		*flags = rht_lock(tbl, bkt);
> +		return true;
> +	}
> +	/* bit_spin_trylock() always succeeds on UP */
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return false;
> +	local_irq_save(*flags);
> +	if (!bit_spin_trylock(0, (unsigned long *)bkt)) {
> +		local_irq_restore(*flags);
> +		return false;
> +	}
> +	lock_acquire_exclusive(&tbl->dep_map, 0, 1, NULL, _THIS_IP_);
> +	return true;
> +}
> +
>  static inline void rht_unlock(struct bucket_table *tbl,
>  			      struct rhash_lock_head __rcu **bkt,
>  			      unsigned long flags)
> @@ -785,7 +812,9 @@ static __always_inline void *__rhashtable_insert_fast(
>  	if (!bkt)
>  		goto out;
>  	pprev = NULL;
> -	flags = rht_lock(tbl, bkt);
> +	data = ERR_PTR(-EBUSY);
> +	if (!rht_lock_or_busy(tbl, bkt, params, &flags))
> +		goto out;
> 
>  	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
>  slow_path:
> @@ -1066,7 +1095,8 @@ static __always_inline int __rhashtable_remove_fast_one(
>  	if (!bkt)
>  		return -ENOENT;
>  	pprev = NULL;
> -	flags = rht_lock(tbl, bkt);
> +	if (!rht_lock_or_busy(tbl, bkt, params, &flags))
> +		return -EBUSY;
> 
>  	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
>  		struct rhlist_head *list;
> @@ -1149,6 +1179,7 @@ static __always_inline int __rhashtable_remove_fast(
>  	 */
>  	while ((err = __rhashtable_remove_fast_one(ht, tbl, obj, params,
>  						   rhlist)) &&
> +	       err != -EBUSY &&
>  	       (tbl = rht_dereference_rcu(tbl->future_tbl, ht)))
>  		;
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6e21154..edc7572 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2983,6 +2983,7 @@ struct bpf_rhtab {
>  static const struct rhashtable_params rhtab_params = {
>  	.head_offset = offsetof(struct rhtab_elem, node),
>  	.key_offset  = offsetof(struct rhtab_elem, data),
> +	.trylock_irqsoff = true,
>  };
> 
>  static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
> @@ -3011,6 +3012,7 @@ static const struct rhashtable_params rhtab_params_long = {
>  	.head_offset = offsetof(struct rhtab_elem, node),
>  	.key_offset  = offsetof(struct rhtab_elem, data),
>  	.key_len     = sizeof(long),
> +	.trylock_irqsoff = true,
>  	.hashfn      = rhtab_hashfn_long,
>  	.obj_cmpfn   = rhtab_key_cmp_long,
>  };
> @@ -3143,21 +3145,11 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  {
>  	int err;
> 
> -	/*
> -	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
> -	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
> -	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
> -	 * raw tracepoints, which we don't have in rhashtable.
> -	 */
> -	bpf_disable_instrumentation();
> -
>  	if (rhtab->map.key_size == sizeof(long))
>  		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params_long);
>  	else
>  		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
> 
> -	bpf_enable_instrumentation();
> -
>  	if (err)
>  		return err;
> 
> @@ -3268,16 +3260,11 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>  	memcpy(elem->data, key, map->key_size);
>  	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> 
> -	/* Prevent deadlock for NMI programs attempting to take bucket lock */
> -	bpf_disable_instrumentation();
> -
>  	if (map->key_size == sizeof(long))
>  		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params_long);
>  	else
>  		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
> 
> -	bpf_enable_instrumentation();
> -
>  	if (tmp) {
>  		bpf_mem_cache_free(&rhtab->ma, elem);
>  		if (IS_ERR(tmp))
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 500c45c..2dc13f0 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -650,7 +650,8 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  		} else {
>  			bool inserted;
> 
> -			flags = rht_lock(tbl, bkt);
> +			if (!rht_lock_or_busy(tbl, bkt, ht->p, &flags))
> +				return ERR_PTR(-EBUSY);
>  			data = rhashtable_lookup_one(ht, bkt, tbl,
>  						     hash, key, obj);
>  			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
> 
> Pls add the reproducer as a selftest in patch 2 and cc Herbert Xu
> on respin.
> 

The lookup infinite loop issue that bots reported looks real too,
we can use the parameter that Alexei added in the lookup as well to 
mitigate it for the price of possibly not finding the element that is
in the hashtable:

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 70dac9214617..6eefdcfa5112 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -612,6 +612,18 @@ static __always_inline int rhashtable_compare(struct rhashtable_compare_arg *arg
                      params.key_len ? : ht->p.key_len);
 }

+/*
+ * The rehash links the last entry of a chain into the future table, then
+ * unlinks it from the chain. A walk between these two steps ends in the new
+ * chain and must retry. A caller with IRQs disabled can interrupt the rehash
+ * on this CPU, then the retry never ends. Such a caller does not retry, it
+ * finds the moved entries in the future table.
+ */
+static __always_inline bool rht_lookup_retry(const struct rhashtable_params params)
+{
+       return !params.trylock_irqsoff || !irqs_disabled();
+}
+
 /* Internal function, do not use. */
 static __always_inline struct rhash_head *__rhashtable_lookup(
        struct rhashtable *ht, const void *key,
@@ -644,7 +656,7 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
                /* An object might have been moved to a different hash chain,
                 * while we walk along it - better check and retry.
                 */
-       } while (he != RHT_NULLS_MARKER(bkt));
+       } while (he != RHT_NULLS_MARKER(bkt) && rht_lookup_retry(params));

        /* Ensure we see any new tables. */
        smp_rmb();
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 500c45cd1304..08eef1e2990f 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -274,7 +274,12 @@ static int rhashtable_rehash_one(struct rhashtable *ht,

        head = rht_ptr(new_tbl->buckets + new_hash, new_tbl, new_hash);

-       RCU_INIT_POINTER(entry->next, head);
+       /*
+        * A lookup that does not retry can walk into new_tbl through this
+        * pointer. Release it, so that the lookup then sees new_tbl in the
+        * future_tbl list.
+        */
+       rcu_assign_pointer(entry->next, head);

        rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry, flags);
> pw-bot: cr

