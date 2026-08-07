Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD6473C73
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116358; cv=none; b=Bi+ciKc5ac/UzXlA8X6DAldtVJSMQ+V5X9m0TPY1EGZRUbvs+/YcgP+oFMW58DtEpEZNvBQeTflrym0xjNPjIqzWG1Ksxi384dqvxt/+6Ps2peua9+ajdXfh0eWfzOZwKK4yBYaz994K+wha5Hbqy3KMTywqJadKt3iDmLbS3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116358; c=relaxed/simple;
	bh=wWfxLe/vtJPc2kBiE+PC0wSrSrI3sI/HFSVA1zDsFEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBL+Qei6uFkk1pmwKxryHGStL5+ZtAKYwt3M2T7ImatmP2gvBa6bVhYE/v9s4J8JtsyTSqjVdb0PruierubJQjCbmhjnVp3O63QINTX2+o4HtjCaQnMt+dgGsvZ5DY8sYVFQDKLORNmukLDSkvSl8fSc4z7V8rRxuUk+gt5ZgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPsY5VdV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPsY5VdV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fde295992so1870247f8f.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116354; x=1786721154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b19DBZrgqRtvgTA2UY4+qWG30o1EZ1ThmVcmO3JKVo4=;
        b=OPsY5VdVSLbiKyE9MTHvgxKQ6MD4xqlVtk7zt17GWc9NA7xOdRoOPManTaMJSp6d4T
         eLBHGFfX5de+ppza+QlKDMj5scVzPxlEVKUOomohxI1gPYagrSGrM4E78BT7jGCMfT5/
         ldDEDV6QC2RInTRp4uSxfQRiY8KcIYx39k8sgGLtUvkmin9olzKdvG2JLONBzqEwhKxm
         wHTZHXB5Pr8A1DNTwzM7Icbft/q/0jqlY6iaWA/I1tK6/f4iWgmm+B3T9ATRgBjBpQso
         7yMW0Z8cAtioke6HTRKmxH/v/DPts3glH5j92xlgyjMkR7a2uaY2oQyCg9JwkeD4efN8
         BMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116354; x=1786721154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b19DBZrgqRtvgTA2UY4+qWG30o1EZ1ThmVcmO3JKVo4=;
        b=TNp5IqUTtcnJv7EEWNyx4F5zI/zeub/QoMz/IWbEkKxMxb0wcOro2Y0QGaNgrHLBJr
         NxzhnM4m/gI/qOXgUJ35cJrHqcaAhRxoxVxb+hASzx/jYLzZ/sasbhhgU+5h9803ujnO
         2cxtdFQby84SsZPCttrVciCVQHop/XCExAc78br0nJ/SehNGkx+RsraX12+uN0KSEJcN
         rjdSAl16y1Ng3DYzAhDz1ZjPsJehUtK0Z0rMluwPxSJY8geZoFT8bLMfoEHEYbzMJCFN
         pRLqW4q8kbGT/kddgyMSjif2NVk/h6Xi37cBeR3GfgzY2VdBNyggoJSw66YpExP3wutL
         +2XA==
X-Gm-Message-State: AOJu0YyC6NU3JTd+E95cgFfajEedjEpL737iRFT+te/Jw2O0IWdmdmpT
	/qKL9mqoYK5lIVbCsQxfD5G0w7eGVYDonBz6u37Q9CiffdZsQXVwMfAS
X-Gm-Gg: AR+sD1377ShPUpUYIt7v8MYo46/dE7w5SxGATvOWGFVpeCLxAbv00z3/9lajzSO9JII
	rTA+aXihTgO2zR25fjLi4fcKgcdEOeMgS20vPjWqYtHKdI6WGe+a6L3KaFfXHEmY1KBtETyCtGk
	rDJt2HceWF0uX+EZqaVw1sWACIs1WElJT3fJG1qLvcCuXJNXKRZcJa/RMDrLkHzTdD8eSu+6WqH
	Uz95NxnQ4JT5Q/perZMU9CB5UmCCIygg+/eC/lPkYDvHOv0Ahm0i2vIk0r3Q5eDbHogBYZkiRNP
	WTxhpQPiJCrzTIN+3QySeGGOECdHYmflPD71VFeQ2VDrxOaCqXbRvTVPgJhjgrTzGjguX/y9oue
	YnUV+UqKxb4DOtXxHB8LvrzuRT7rzgFMW116ytRwBpCjEJO3uoYGxVPkm/U8dy8Pye9aiMfOnVK
	BwEu3DqaZCwGJZkefZ6Y76/22e2wOc5h7XnfjwRjJN3zqTx6b77gd3uwis8FaEBMgRAp6ghviHV
	lsSoPveykmhy5hRW+XaJ8fa
X-Received: by 2002:a05:6000:2d86:b0:47d:f508:3364 with SMTP id ffacd0b85a97d-47ff4ee359dmr17550094f8f.15.1786116353942;
        Fri, 07 Aug 2026 08:25:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:2b1f:92f:33a4:a386? ([2620:10d:c092:500::5:f21f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220ab11sm7074445f8f.35.2026.08.07.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 08:25:53 -0700 (PDT)
Message-ID: <e417cb09-8466-4d9e-9d33-7330d84df12a@gmail.com>
Date: Fri, 7 Aug 2026 16:25:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
To: "T.J. Mercier" <tjmercier@google.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805223516.1495988-1-tjmercier@google.com>
 <20260805223516.1495988-2-tjmercier@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260805223516.1495988-2-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 11:35 PM, T.J. Mercier wrote:
> The htab_elem struct is used as the per-element type for all BPF hash
> map types and includes bpf_lru_node in a union with a ptr_to_pptr
> pointer. For standard (non-LRU, non-PCPU) hash maps, the 24 byte union
> allocated for every element is entirely unused. For non-preallocated
> PCPU maps, ptr_to_pptr only requires 8 bytes, leaving 16 bytes of unused
> overhead in the union. For preallocated PCPU maps ptr_to_pptr is unused
> since elements are freed to the PCPU freelist.
> 
> Eliminate this per-element memory overhead by splitting htab_elem into
> dedicated structures for each map type:
>    - struct htab_elem: Minimal structure for standard hash maps and
>      preallocated PCPU maps (saves 24 bytes per element).
>    - struct htab_elem_pcpu: Structure for non-preallocated PCPU maps
>      containing ptr_to_pptr (saves 16 bytes per element).
>    - struct htab_elem_lru: Retains struct bpf_lru_node for LRU maps.
> 
> Because element sizes now vary by map type, add key_offset to struct
> bpf_htab to track the dynamic key offset. Update helper accessors and
> lookups to compute key and value offsets using htab->key_offset.
> 
> Pointers to struct htab_elem in the existing code (e.g. htab_elem_hash)
> serve as generic base element pointers. This is possible because
> htab_elem, htab_elem_pcpu, and htab_elem_lru share a common initial
> sequence, making pointer casts safe.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  kernel/bpf/hashtab.c    | 362 +++++++++++++++++++++++++---------------
>  kernel/bpf/map_in_map.c |  13 ++
>  kernel/bpf/map_in_map.h |   2 +
>  3 files changed, 242 insertions(+), 135 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e8..f54366da459f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -102,11 +102,13 @@ struct bpf_htab {
>  	bool use_percpu_counter;
>  	u32 n_buckets;	/* number of hash buckets */
>  	u32 elem_size;	/* size of each element in bytes */
> +	u32 key_offset;	/* offset of key in bytes */
>  	u32 hashrnd;
>  };
>  
>  /* each htab element is struct htab_elem + key + value */
> -struct htab_elem {
> +struct htab_elem;
> +struct htab_node {
>  	union {
>  		struct hlist_nulls_node hash_node;
>  		struct {
> @@ -117,11 +119,27 @@ struct htab_elem {
>  			};
>  		};
>  	};
> -	union {
> -		/* pointer to per-cpu pointer */
> -		void *ptr_to_pptr;
> -		struct bpf_lru_node lru_node;
> -	};
> +};
> +
> +struct htab_elem {
> +	struct htab_node node;
> +	u32 hash;
> +	char key[] __aligned(8);
> +};
> +
> +struct htab_elem_lru {
> +	struct htab_node node;
> +	struct bpf_lru_node lru_node;
> +	u32 hash;
> +	char key[] __aligned(8);
> +};
> +
> +/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
> + * ptr_to_pptr, and use htab_elem.
> + */
> +struct htab_elem_pcpu {
> +	struct htab_node node;
> +	void *ptr_to_pptr;
>  	u32 hash;
>  	char key[] __aligned(8);
>  };
> @@ -136,6 +154,21 @@ static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>  	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
>  }
>  
> +static inline struct bpf_lru_node *htab_elem_lru_node(struct htab_elem *l)
> +{
> +	return &((struct htab_elem_lru *)l)->lru_node;
> +}
> +
> +static inline void *htab_elem_get_ptr_to_pptr(struct htab_elem *l)
> +{
> +	return ((struct htab_elem_pcpu *)l)->ptr_to_pptr;
> +}
> +
> +static inline void htab_elem_set_ptr_to_pptr(struct htab_elem *l, void *ptr)
> +{
> +	((struct htab_elem_pcpu *)l)->ptr_to_pptr = ptr;
> +}
> +
>  static void htab_init_buckets(struct bpf_htab *htab)
>  {
>  	unsigned int i;
> @@ -183,25 +216,30 @@ static inline bool is_fd_htab(const struct bpf_htab *htab)
>  	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
>  }
>  
> -static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
> +static inline void *htab_elem_key(struct bpf_htab *htab, struct htab_elem *l)
> +{
> +	return (void *)l + htab->key_offset;
> +}
> +
> +static inline void *htab_elem_value(struct bpf_htab *htab, struct htab_elem *l)
>  {
> -	return l->key + round_up(key_size, 8);
> +	return htab_elem_key(htab, l) + round_up(htab->map.key_size, 8);
>  }
>  
> -static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
> +static inline void htab_elem_set_ptr(struct bpf_htab *htab, struct htab_elem *l,
>  				     void __percpu *pptr)
>  {
> -	*(void __percpu **)htab_elem_value(l, key_size) = pptr;
> +	*(void __percpu **)htab_elem_value(htab, l) = pptr;
>  }
>  
> -static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
> +static inline void __percpu *htab_elem_get_ptr(struct bpf_htab *htab, struct htab_elem *l)
>  {
> -	return *(void __percpu **)htab_elem_value(l, key_size);
> +	return *(void __percpu **)htab_elem_value(htab, l);
>  }
>  
> -static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
> +static void *fd_htab_map_get_ptr(struct bpf_htab *htab, struct htab_elem *l)
>  {
> -	return *(void **)htab_elem_value(l, map->key_size);
> +	return *(void **)htab_elem_value(htab, l);
>  }
>  
>  static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
> @@ -209,6 +247,26 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
>  	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
>  }
>  
> +static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_elem *l)
> +{
> +	if (htab_is_lru(htab))
> +		return ((struct htab_elem_lru *)l)->hash;
> +	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> +		return ((struct htab_elem_pcpu *)l)->hash;

These casts in getter/setter are a bit annoying, not sure if there is a way to
get rid of them.

> +	else
> +		return l->hash;
> +}
> +
> +static inline void htab_elem_set_hash(struct bpf_htab *htab, struct htab_elem *l, u32 hash)
> +{
> +	if (htab_is_lru(htab))
> +		((struct htab_elem_lru *)l)->hash = hash;
> +	else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> +		((struct htab_elem_pcpu *)l)->hash = hash;
> +	else
> +		l->hash = hash;
> +}
> +
...
>  	htab->extra_elems = pptr;
> @@ -425,8 +481,8 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>  	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
>  	int numa_node = bpf_map_attr_numa_node(attr);
>  
> -	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
> -		     offsetof(struct htab_elem, hash_node.pprev));
> +	BUILD_BUG_ON(offsetof(struct htab_node, fnode.next) !=
> +		     offsetof(struct htab_node, hash_node.pprev));
>  
>  	if (zero_seed && !capable(CAP_SYS_ADMIN))
>  		/* Guard against local DoS, and discourage production use. */
> @@ -476,7 +532,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
>  	if (IS_ERR_OR_NULL(hrec->record))
>  		return;
>  
> -	map_value = htab_elem_value(elem, hrec->key_size);
> +	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);

Why this can't be htab_elem_value()?

>  	bpf_obj_free_fields(hrec->record, map_value);
>  }
>  
> @@ -583,8 +639,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  
>  	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
>  
> -	htab->elem_size = sizeof(struct htab_elem) +
> -			  round_up(htab->map.key_size, 8);
> +	if (htab_is_lru(htab))
> +		htab->key_offset = sizeof(struct htab_elem_lru);

nit: I think it'll be nicer to use explicit offsetof().

> +	else if (percpu && !prealloc)
> +		htab->key_offset = sizeof(struct htab_elem_pcpu);
> +	else
> +		htab->key_offset = sizeof(struct htab_elem);
> +
> +	htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
>  	if (percpu)
>  		htab->elem_size += sizeof(void *);
>  	else
> @@ -692,14 +754,16 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
>  }
>  
...
> @@ -912,18 +982,19 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  	head = select_bucket(htab, hash);
>  
>  	/* lookup the key */
> -	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
> +	l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
>  
>  	if (!l)
>  		goto find_first_elem;
>  
>  	/* key was found, get next key in the same bucket */
> -	next_l = hlist_nulls_entry_safe(rcu_dereference_raw(hlist_nulls_next_rcu(&l->hash_node)),
> -				  struct htab_elem, hash_node);
> +	next_l = hlist_nulls_entry_safe(
> +			rcu_dereference_raw(hlist_nulls_next_rcu(&l->node.hash_node)),

nit: I think this line has not changed.

> +			struct htab_elem, node.hash_node);
>  
>  	if (next_l) {
>  		/* if next elem in this hash list is non-zero, just return it */
> -		memcpy(next_key, next_l->key, key_size);
> +		memcpy(next_key, htab_elem_key(htab, next_l), key_size);
>  		return 0;
>  	}
>  ...
