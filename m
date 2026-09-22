Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52504515898
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061673; cv=none; b=OSbBoOYtZCb/GSv9Mjjv0VU8ODTrBPsp0q/9B/Ik5ORU4k/tHfzJnJie/BYRlGfcRn3UB6ADK/3wr5fyY/Jub3DRn3I3XdppkHbas4oRLg+Y9OSVdN1XF+7fnyPTGEly+qgb0PE1XG9lWNQfA4R8YWkVzorQfb0LkvXUbe7ocmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061673; c=relaxed/simple;
	bh=ezk01bh1yoUKAmJFyJBag4JSoRZM/nZ1KecXib9IobU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZS0wesbxZSNk0F+j6HtX39BIkLG6fVI+Hp2ritygpPT9t4FLabgNQYXqwCbHZfMcOcRKFt+uU/l643tojEL1wsjRhY72bHeDlAZ7GwWRJ5QpDh7YXiFmToH8eBvVgemiWgPLrh7Be/TtHp1PR7vzWf4vFhhMBffKH8nGrQx1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3OV1vId; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3OV1vId"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so28096665e9.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061665; x=1790666465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KSmTsjgyxlnZQzH/X2iHCh2sJw6F1xUBCZBw0/aS0WQ=;
        b=O3OV1vIdGlxAlXRZ0emHstkM4rdOltbRbpv9zDyNO9NtfBMS9I1L16u1Xbb4lyT4xZ
         ytMpZIoRuanEBKw2TYA2cdFSFMrwXUgSESjEj9WRWGNZmC8Tf7FoxxlFf/+oY8aiMZYI
         0Inc3v+AMfaKlohGEwbUMEnoOmQ3MkYWVlhjJabN12eMaXCfkVHtgqIfxKRnq27lw4J0
         5t01NYNbv4NaV+l+bP34UGUPv6H36p02EQqHCKeuxjwxK18j8Ifrfgxeuo9wA5zH+ADf
         KW1u47xbIuZSLBOEK+C2C1uSjRbEuOkYcSDqv31hPeJmhbb6JYR4ZPaStZoFKXgM1fms
         87Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061665; x=1790666465;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KSmTsjgyxlnZQzH/X2iHCh2sJw6F1xUBCZBw0/aS0WQ=;
        b=i0iJWohOvGWs4PFiBUvrQk7nhlfWuHaEQeudzLeE4cwjoXTjZUDbrJpUcU3wtOA/fu
         1PKM4mO3wjlLTgd27brHhY9WgtAi+9mAwYcHZbluakHMdBKjJMb8nBphRzyTZB0HOtEC
         ugI/M69pM07dltt4pi4YRoleJxh3rTYARxMX4+lJ1m8sui2iFEeAujzll1soyd7sCcE4
         uffQpu6kB6Cm2Y7yy3xIUPJInnPX6UrL2NxzSmacBTzVwPlulL8z3zGeY70jy/1uQpcD
         q9VmwlMMgZDcbZKK0XcafELaTU0hhOW7/c5a271dPpn+hqKfeFnn72EvmfqirEJEY6kE
         2JAQ==
X-Gm-Message-State: AFuF++kRjbPvFSQgi2vqFG4ouUfg3QnQ/0j+05bRdZ1/0K3wm+dYYzLU
	6UH1ddYsJ4i2E+3RPIPQUEAQZK88FEO5nQumO447tXr6g4WwdRwbmIo1
X-Gm-Gg: AYBFou1/pUTDNZdpxUc6d2YsSqmGJWjGdFi+5yT/S+XQvjTOqhR8HQswt3wEaIwxp7r
	eM/MqBuoApQ+78sPfhPuBH3K95xaI+Q29vrI9GL8mFvwtG478O9bHE6N8kYO4r4YBnGRYAB+W1c
	iPfB8MQByAAzCVbhhWj7mT3AJ4/3Y5NT5LFlKEDuY2YNUe0GSrfr2VDQx8dmp+FXoJ+yPtZoIhx
	DvRhH60AgzLEOhXQwe6mD7ezu90rA4t2P5MGdbo7ckx8O8Qh0T3vHgAKPvcbfnz23dg6j2fYogt
	lneQWEwWTb4iABhTO3g6vKHEUiBMzLpgWROvPkYauiG8T1f21l5zZ4HbvIiVAMK8r/3ush2Dq1y
	Q3ZRshSm4UUE8y0ZS9T5XHRu8FAC2PdP74Yo/Y4sb0qeScZhDm7BzaW5c9yQKgQaJFr8VfeR2H4
	CuiyOnKVz4rbq08CmV93VwjA25O28I94PVFJrR6X8EoHJkpt57kJ0Z0e86rHnO3UcB7H3Qb6Y7K
	4i9C+iPRB8gHD6vTw==
X-Received: by 2002:a05:600c:198b:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49fc574f05dmr185666045e9.33.1790061664409;
        Tue, 22 Sep 2026 00:21:04 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad53b47sm27942955e9.13.2026.09.22.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:21:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 07:31:33 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
Message-ID: <arIu1SA3F66HhMkv@mail.gmail.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>

On 26/09/21 02:28PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Four- and eight-byte keys are common enough to warrant specialized htab
> lookups. Fold JHASH_INITVAL and the key length into hashrnd once when
> allocating maps with these key sizes.
> 
> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
> map's fixed key size. Select u32- and u64-specific lookup entry points so
> the compiler can specialize both hash setup and key comparison. Other key
> sizes continue to use the generic lookup entry point.
> 
> This preserves the jhash2() result and lookup semantics while avoiding
> generic length handling and repeated state setup.
> 
> Measure this with six runs of:
> 
>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
>       --map_flags 0x40
> 
> inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
> first and the optimized kernel second. Use these workloads:
> 
>              max_entries   nr_entries    nr_loops
>   small              512          256   8,388,608
>   medium          10,000        5,000   8,000,000
>   large          100,000       50,000   8,000,000
> 
> Mean throughput in million lookups per second is:
> 
>   Baseline:
>                          key size (bytes)
>                       1        4        8       10
>     small         89.45    91.21   103.40    91.74
>     medium       125.97    80.25    91.94    78.52
>     large        140.67    53.56    58.68    47.31
> 
>   Optimized:
>                          key size (bytes)
>                       1        4        8       10
>     small         86.95   233.63   168.65    90.88
>     medium       124.97   150.20   137.76    77.51
>     large        131.06    80.51    76.04    47.25
> 
>   Change:
>                          key size (bytes)
>                       1        4        8       10
>     small         -2.79% +156.15%  +63.11%   -0.94%
>     medium        -0.79%  +87.17%  +49.83%   -1.28%
>     large         -6.84%  +50.32%  +29.58%   -0.12%
> 
> The u32 specialization improves lookup throughput by 50-156%, and the
> u64 specialization improves it by 30-63%. Ten-byte controls remain
> within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
> Changes in v2:
> - Added variants of __htab_map_lookup_elem() functions with inlined
> u32/u64 key sizes, use them in htab_map_gen_lookup();
> improved lookup perf significantly (Alexei)
> - Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
> ---
>  kernel/bpf/hashtab.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6f331c80130d..77c96105eda8 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  		htab->hashrnd = 0;
>  	else
>  		htab->hashrnd = get_random_u32();
> +	/*
> +	 * Fold the jhash constant and key length into hashrnd once for the
> +	 * fixed-size fast paths instead of doing it on every lookup.
> +	 */
> +	if (htab->map.key_size == sizeof(u32) ||
> +	    htab->map.key_size == sizeof(u64))
> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
>  
>  	htab_init_buckets(htab);
>  
> @@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  
>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
>  {
> -	if (likely(key_len % 4 == 0))
> +	const u32 *k = key;
> +	u32 b;
> +
> +	if (key_len == sizeof(u32))
> +		b = 0;
> +	else if (key_len == sizeof(u64))
> +		b = k[1];
> +	else if (likely(key_len % 4 == 0))
>  		return jhash2(key, key_len / 4, hashrnd);
> -	return jhash(key, key_len, hashrnd);
> +	else
> +		return jhash(key, key_len, hashrnd);
> +
> +	return __jhash_nwords(k[0], b, 0, hashrnd);
>  
>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
> @@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>   * The return value is adjusted by BPF instructions
>   * in htab_map_gen_lookup().
>   */
> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>  	struct hlist_nulls_head *head;
>  	struct htab_elem *l;
> -	u32 hash, key_size;
> +	u32 hash;
>  
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
>  
> -	key_size = map->key_size;
> -
>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
>  
>  	head = select_bucket(htab, hash);
> @@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>  	return l;
>  }
>  
> +static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	return __htab_lookup(map, key, map->key_size);
> +}
> +
> +static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
> +{
> +	return __htab_lookup(map, key, sizeof(u32));
> +}
> +
> +static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
> +{
> +	return __htab_lookup(map, key, sizeof(u64));
> +}
> +
>  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
>  {
>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
> @@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>  
>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> +	if (map->key_size == sizeof(u32))
> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
> +	else if (map->key_size == sizeof(u64))
> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
> +	else
> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);

I am trying to remember why I didn't do this when I was touching this
code, I was definitely thinking about it... Given your changes,
it is worth to approach xxh3 again, it works way better for bigger key
sizes, see [1].

  [1] https://archive.fosdem.org/2023/schedule/event/bpf_hashing/



>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>  				offsetof(struct htab_elem, key) +
> 
> ---
> base-commit: 6e1ac8758fcd07bee12ccaff0087cc66930a4187
> change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e
> 
> Best regards,
> --  
> Mykyta Yatsenko <yatsenko@meta.com>
> 
