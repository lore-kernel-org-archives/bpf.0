Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06F33C19E
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124022; cv=none; b=TrltyVMO0Z6HVs8Sttk/P6zU47EivW498iT1FJFO5OVr5sBmtXl1DslqSzPEN0d770MJ85LCy5AG3zZuZ68i2qcd/ntizd47vUS+95/w+hG4WH2Cd3viuwjfXErqWUTkviMciKLoO83zo6hnvWkxgXv9TW4gmQRLJdsn9uRAPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124022; c=relaxed/simple;
	bh=36xJJx+rSpHrlu2ubi1CyhFmFGmq5DFdkwIdFl9v1Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYSPzf2+ejYBsbd/RDBaPV+w1cfuawTi5bt9EY1WZDzS5t6lh17xTDk6COxUvmRZafSdyZ8whTGJf2D139IDRcnVAh7enm2QE5sp7o0AdUGbiqsvVEGEaOJOhJhUemrSkYnzFVM83tkiRJxyPpWrhJ1hFSnRaZLv61URxTi0NpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6khcOTb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6khcOTb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2270277f8f.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786124016; x=1786728816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WeEcnWNRin83bx8B/hDqgB2G8eYV9Ff1QenpcTFLNA=;
        b=P6khcOTbJg2QXGAKwvagoOFrdO8LfyjNo2iX23g4+7LXnX8zUeQonuwlIKbQjuh9Nd
         J78o8ZwA+Jd9ptoDGkkevg5uEWttX+bvGWq7jLGsynPptcI8aPQGrGxyffS+1wk+oo0T
         kSPWgB+ahHNGDPbfH9TziLInRVF1q7fpFmWkhcEpxiup1P7RAnHRdcHMxmmRfLqhvpEx
         IuUjm9MQ/iSxT4uPk+UjadRfjL7FEUfL9XclUBHwEbqYS4Ia/mY4AmffYRPdokrfzGOV
         m98cfawTY8bnvMPs5+RcjHUMk7QYXvH8dpBywUAOpnY+ET7TPrebaUzXw6tNMmnpgek+
         9Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124016; x=1786728816;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WeEcnWNRin83bx8B/hDqgB2G8eYV9Ff1QenpcTFLNA=;
        b=VoSFA1USGWZbQbt+YsvKdqO3qm4QPmzr1H5O4c2wT6v8R3mnJ1/8lA70wX0BU2ZFX2
         v4VJNa27Ah1rtmYKteQbie7FLxkv98l+6dOew4s1y3KX4ahnbH294tPYy2dOsZPBUQHq
         B3S8xWBqK6zbglXEh+uARdBfI2E7BmK9Y8oVS1jyGEX5D4kY7tcHO1D1OrohjjxLbcFS
         pPqFHIydCOFoLFQsbjvVfgHOgX8MSs+K+9p4r8isjz4k+bdH24EKOK/prjFya+g4wMpo
         EJDMtgUegj3NTrWMZnuW2f+7OIebuaFEYmkbGWIeZ7Sy0xEwp7GH6jfMYREVVCcGb6OE
         RFPw==
X-Gm-Message-State: AOJu0YydkdKIfJjZjZhd7mIoe4xmNGk7hOPRHXBakQ/z3Lx4x44yUuLg
	nKeSffH76O+CkWQLqM3dYfOztJRRoILgkutl3wMIEghNfIOu8cs3uGE8
X-Gm-Gg: AR+sD10Tpvl7S3YaBnawL16Hba8LpEWwyLE6tky2QjB79ii/qrnc0jp5Nykz12uxTvz
	2u5HYW6FmXB7SdMf2gq5nG2XaXIYwzD8EjzU7Hq5hnZoDApG1wyFivpXIhBQ839LPnpVC+15FP0
	lBmv1MPpX3EOUoowrUdl10g50ZunaY+uG/25BIlU3UUATludBvyWxWeE+vZ39uJATuy0JhGIcEl
	LoY6UiwXphi7RFS9tYEnsZlxLTMJqtQT4b0B9xvfwQtlRgo27MkAAfCyuFaSowGywzzaERxm8zb
	PyDiK7MgMlLnq9YtVckXjzXRUD2iL/zeHOsJCjNLqCuqc7wxALb926s3QJipDI3NQSJ5EM0+y5p
	h2LTtE5EG8lNMcQcw1yFoktD5uMDtVfS3fLkuut3yXiNRX6kVmkkp3oq3LBX56ulIfeM+sLd5hW
	HurwWstI23yrfR2uH3BQITOK5Z6NQFsjfco9Scni8SjsYISuVgV+AYyAl4u6vJEOfgiEg1lYY90
	QkFgyPUUuISDaXxrzwyivpslLLTDuSANUIzmwxySv67UHHr4afDHmyirRn/
X-Received: by 2002:adf:d006:0:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47fec62a14amr30940114f8f.27.1786124015714;
        Fri, 07 Aug 2026 10:33:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021457ebsm7382587f8f.6.2026.08.07.10.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 10:33:34 -0700 (PDT)
Message-ID: <7ce1d67b-ae88-445c-b4f8-ffa0eea9befc@gmail.com>
Date: Fri, 7 Aug 2026 18:33:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
To: "T.J. Mercier" <tjmercier@google.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805223516.1495988-1-tjmercier@google.com>
 <20260805223516.1495988-3-tjmercier@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260805223516.1495988-3-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 11:35 PM, T.J. Mercier wrote:
> For standard and PCPU (non-LRU) hash maps with small key sizes (less
> than or equal to the word size), comparing keys requires only a single
> instruction. Storing a cached 32-bit hash value to shortcut full key
> comparisons provides no performance advantage for small keys, and
> consumes memory for every element.
> 
> This memory can be saved by eliminating hash along with its associated
> 4 byte padding before the key, reducing the elem_size (and key_offset)
> by 8 bytes for standard and PCPU maps.
> 
> Introduce htab_has_hash() to check whether a map requires a cached hash
> field. Update htab_elem_set_hash(), lookup_elem_raw(), and
> lookup_nulls_elem_raw() to conditionally bypass hash checking and
> storage when htab_has_hash() is false.
> 
> Together with the previous patch, this reduces the minimum standard and
> preallocated hash map element size from 64 bytes down to 32 bytes, and
> non-preallocated per-CPU element size from 64 bytes down to 40 bytes.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  kernel/bpf/hashtab.c                          | 108 +++++++++++++-----
>  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
>  2 files changed, 79 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index f54366da459f..9967268d453d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -100,6 +100,7 @@ struct bpf_htab {
>  	struct percpu_counter pcount;
>  	atomic_t count;
>  	bool use_percpu_counter;
> +	bool has_hash;
>  	u32 n_buckets;	/* number of hash buckets */
>  	u32 elem_size;	/* size of each element in bytes */
>  	u32 key_offset;	/* offset of key in bytes */
> @@ -123,15 +124,13 @@ struct htab_node {
>  
>  struct htab_elem {
>  	struct htab_node node;
> -	u32 hash;
> -	char key[] __aligned(8);
> +	u8 data[] __aligned(8);
>  };
>  
>  struct htab_elem_lru {
>  	struct htab_node node;
>  	struct bpf_lru_node lru_node;
> -	u32 hash;
> -	char key[] __aligned(8);
> +	u8 data[] __aligned(8);
>  };
>  
>  /* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
> @@ -140,13 +139,13 @@ struct htab_elem_lru {
>  struct htab_elem_pcpu {
>  	struct htab_node node;
>  	void *ptr_to_pptr;
> -	u32 hash;
> -	char key[] __aligned(8);
> +	u8 data[] __aligned(8);
>  };
>  
>  struct htab_btf_record {
>  	struct btf_record *record;
>  	u32 key_size;
> +	u32 key_offset;
>  };
>  
>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
> @@ -247,24 +246,31 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
>  	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
>  }
>  
> +static inline bool htab_has_hash(const struct bpf_htab *htab)
> +{
> +	return htab->has_hash;
> +}
> +
>  static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
>  {
>  	if (htab_is_lru(htab))
> -		return ((struct htab_elem_lru *)l)->hash;
> +		return *(u32 *)((struct htab_elem_lru *)l)->data;
>  	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> -		return ((struct htab_elem_pcpu *)l)->hash;
> +		return *(u32 *)((struct htab_elem_pcpu *)l)->data;
>  	else
> -		return l->hash;
> +		return *(u32 *)l->data;
>  }
>  
>  static inline void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
>  {
> +	if (!htab_has_hash(htab))
> +		return;
>  	if (htab_is_lru(htab))
> -		((struct htab_elem_lru *)l)->hash = hash;
> +		*(u32 *)((struct htab_elem_lru *)l)->data = hash;
>  	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> -		((struct htab_elem_pcpu *)l)->hash = hash;
> +		*(u32 *)((struct htab_elem_pcpu *)l)->data = hash;
>  	else
> -		l->hash = hash;
> +		*(u32 *)l->data = hash;
>  }
>  
>  /* Both percpu and fd htab support in-place update, so no need for
> @@ -405,7 +411,7 @@ static int prealloc_init(struct bpf_htab *htab)
>  	if (htab_is_lru(htab))
>  		err = bpf_lru_init(&htab->lru,
>  				   htab->map.map_flags & BPF_F_NO_COMMON_LRU,
> -				   offsetof(struct htab_elem_lru, hash) -
> +				   offsetof(struct htab_elem_lru, data) -
>  				   offsetof(struct htab_elem_lru, lru_node),
>  				   htab_lru_map_delete_node,
>  				   htab);
> @@ -532,7 +538,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
>  	if (IS_ERR_OR_NULL(hrec->record))
>  		return;
>  
> -	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
> +	map_value = (void *)elem + hrec->key_offset + round_up(hrec->key_size, 8);
>  	bpf_obj_free_fields(hrec->record, map_value);
>  }
>  
> @@ -558,7 +564,7 @@ static void htab_dtor_ctx_free(void *ctx)
>  }
>  
>  static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
> -			   void (*dtor)(void *, void *))
> +			   void (*dtor)(void *, void *), u32 key_offset)

do we need to add key_offset param? What if we read key_offset from map->htab->key_offset?

>  {
>  	struct htab_btf_record *hrec;
>  	int err;
> @@ -571,6 +577,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
>  	if (!hrec)
>  		return -ENOMEM;
>  	hrec->key_size = map->key_size;
> +	hrec->key_offset = key_offset;
>  	hrec->record = btf_record_dup(map->record);
>  	if (IS_ERR(hrec->record)) {
>  		err = PTR_ERR(hrec->record);
> @@ -593,9 +600,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  	 * populated in htab_map_alloc(), so it will always appear as NULL.
>  	 */
>  	if (htab_is_percpu(htab))
> -		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor);
> +		return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem_dtor, htab->key_offset);
>  	else
> -		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor);
> +		return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor, htab->key_offset);
>  }
>  
>  static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> @@ -618,6 +625,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  
>  	bpf_map_init_from_attr(&htab->map, attr);
>  
> +	/* Avoid hash memory use and comparisons where unnecessary.
> +	 * u32 hash reads are always atomic. If we elide them, key comparisons must also be atomic
> +	 * to avoid false positive key matches due to torn key reads / writes. This is only possible
> +	 * when the key fits within a word, so check key_size.
> +	 */
> +	htab->has_hash = htab_is_lru(htab) || htab->map.key_size > sizeof(unsigned long);
> +
>  	if (percpu_lru) {
>  		/* ensure each CPU's lru list has >=1 elements.
>  		 * since we are at it, make each lru list has the same
> @@ -640,11 +654,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
>  
>  	if (htab_is_lru(htab))
> -		htab->key_offset = sizeof(struct htab_elem_lru);
> +		htab->key_offset = offsetof(struct htab_elem_lru, data) + 8;
>  	else if (percpu && !prealloc)
> -		htab->key_offset = sizeof(struct htab_elem_pcpu);
> +		htab->key_offset = offsetof(struct htab_elem_pcpu, data) +
> +				   (htab_has_hash(htab) ? 8 : 0);
>  	else
> -		htab->key_offset = sizeof(struct htab_elem);
> +		htab->key_offset = offsetof(struct htab_elem, data) +
> +				   (htab_has_hash(htab) ? 8 : 0);
>  
>  	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
>  	if (percpu)
> @@ -761,10 +777,22 @@ static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
>  	struct hlist_nulls_node *n;
>  	struct htab_elem *l;
>  
> -	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> -		if (htab_elem_hash(htab, l) == hash &&
> -		    !memcmp(htab_elem_key(htab, l), key, key_size))
> -			return l;
> +	if (htab_has_hash(htab)) {
> +		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> +			if (htab_elem_hash(htab, l) == hash &&
> +			    !memcmp(htab_elem_key(htab, l), key, key_size))
> +				return l;
> +	} else {
> +		/* When hash is omitted, key comparisons must be atomic. Zero extend
> +		 * the caller's key to the word size to support an atomic compare.
> +		 */
> +		unsigned long k = 0;
> +
> +		memcpy(&k, key, key_size);
> +		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> +			if (READ_ONCE(*(unsigned long *)htab_elem_key(htab, l)) == k)
> +				return l;
> +	}
>  
>  	return NULL;
>  }
> @@ -782,10 +810,20 @@ static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
>  	struct htab_elem *l;
>  
>  again:
> -	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> -		if (htab_elem_hash(htab, l) == hash &&
> -		    !memcmp(htab_elem_key(htab, l), key, key_size))
> -			return l;
> +	if (htab_has_hash(htab)) {
> +		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> +			if (htab_elem_hash(htab, l) == hash &&
> +			    !memcmp(htab_elem_key(htab, l), key, key_size))
> +				return l;
> +	} else {
> +		/* See lookup_elem_raw() comment above. */
> +		unsigned long k = 0;
> +
> +		memcpy(&k, key, key_size);
> +		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> +			if (READ_ONCE(*(unsigned long *)htab_elem_key(htab, l)) == k)
> +				return l;
> +	}

This hunk is quite big, maybe move it to a separate function to reuse in
lookup_elem_raw() and lookup_nulls_elem_raw().

>  
>  	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
>  		goto again;
> @@ -1188,7 +1226,17 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  		}
>  	}
>  
> -	memcpy(htab_elem_key(htab, l_new), key, key_size);
> +	if (htab_has_hash(htab)) {
> +		memcpy(htab_elem_key(htab, l_new), key, key_size);
> +	} else {
> +		/* Zero-extend key into k for an atomic write to support
> +		 * lockless RCU readers.
> +		 */
> +		unsigned long k = 0;
> +
> +		memcpy(&k, key, key_size);
> +		WRITE_ONCE(*(unsigned long *)htab_elem_key(htab, l_new), k);
> +	}
>  	if (percpu) {
>  		if (prealloc) {
>  			pptr = htab_elem_get_ptr(htab, l_new);
> @@ -3191,7 +3239,7 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  {
>  	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>  
> -	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
> +	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor, offsetof(struct rhtab_elem, data));
>  }
>  
>  static void rhtab_map_free_internal_structs(struct bpf_map *map)
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index 373c8d17ea55..6bd4cb68c20c 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -114,7 +114,7 @@ static inline int check_hash(void)
>  	VERIFY(check_default_noinline(&hash->map, map));
>  
>  	VERIFY(hash->n_buckets == MAX_ENTRIES);
> -	VERIFY(hash->elem_size == 64);
> +	VERIFY(hash->elem_size == 32);
>  
>  	VERIFY(hash->count.counter == 0);
>  	VERIFY(bpf_map_sum_elem_count(map) == 0);

