Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3853CA92
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077517; cv=none; b=MjSq6m3yq/n2LBKqjYmFDly6tPptH9Vygn3q97O15r+27il+kGvf6JaDe+rAxC+0BJrrZZAFZ7YqO6fJI5CpzjiQqzl3z+dBQRRHviCZ3vBqaisCLAil+Qy7tssiiDlU9DwUoNcQ4/4wfxv9oYLx88breXGV98cPLNE9SnJxcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077517; c=relaxed/simple;
	bh=qZS+ioZwk/D8+SzVvXL/W21i+HY1NIB5cgdI6T/dUzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMdYB3U/FVwDjMI8nebFsWMRPwtnKRI00Jiys/s9nsJ3Qb0lZim2z+LEXUvzpN6WjqhFsQ3ZmLm9fOYE8n7CEbEKCZEDQJXZCnRefiDqumJzFuo478lmpooqQEcugwp6krAZMObEwbclBGpG7u0KMDRj8onubdFvVKgJhYtS2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yiz8qXzZ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yiz8qXzZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so3126471f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790077513; x=1790682313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0vnw1R6C8QLM6c+u7s5nItZFLJrdOAwMH89b9oBqBk=;
        b=Yiz8qXzZCUEsQ2tx3LMMGM4M1tw+iMdhMDkVvvNYFD4F76MdjV85MBykOjjirr5dC3
         D34LBZg+Lq+MJrQLhDttBaSNJRYJzcKGOj/35HVdo5MRNne8dOi6ImN0un9sN6QaeEhw
         nT5yZUUkR6Qg++2QOrOj7pvFAUhrhv/Yzwd5P5bRWux4C23Y3JKjzP9yxCUp/DeFYSxd
         xp5BdfYSdWyLSbK3g+2q/gIcv5e1IVRhExYvbaTiHOXwdtev5wildqSJqiPHWoImKgmb
         cRV9t6EJs/+TvFoRig2C9iagV0Dlkw5W8UP6hET3IWA+JXFZ4rDNYnM22Nq21w+JOVxe
         LcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077513; x=1790682313;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0vnw1R6C8QLM6c+u7s5nItZFLJrdOAwMH89b9oBqBk=;
        b=lIcwXYKWuwRzHaDNcOX4EIwQv5ARHIgWzbe5cIJXkF5FXHZUR1u+is4SWcOwP3Z/uy
         vh2i1RRRi+hY0Q6g0uJGb5XrrCJOmGGO5IFlhbp2pg2l2QSu4ZvxMDtVNuTJsmNUXl/S
         CdGaJ7F/xlre4IWDHjHBIH19SlXgUE/uyfRxZOSluiaNPDwuUF+3P6JziLWHMijibpxK
         EgEGNAMtsUY89K4AdMQAYQKJ9ed+vh6G2MSXsxrDXCMEZgV/Tpi7/7DF0SlwFq4V1MK7
         KKPIt4WNb6hd43dUEyjLFGSL4Xavdx0Cck9Pw1LfbdTcs0a530ZbUCRfSIunD1NROZtF
         pyPg==
X-Gm-Message-State: AFuF++kUrmdQtncHysEzAeMeGdJhmYo2hGaUJi0qnPMBNDYBj9sm6i0z
	8Ye9N6bkzymko6LNUqWNI6ZDm3dVnoD21vM0Sn1OBZX48xHZEYr1QTS9
X-Gm-Gg: AYBFou1adKSh5zDukI46G1rwgg/XJELGmsXjP5j3w4/bphyj1X2jJu79+uNhQcABcAg
	ZdkM6y4S+22IS8gmnqNMFzVi753gQ96XdWGFmz8+1zzFxXjSheAYG8XLw9lAQslhDchvo0GCL2Z
	zxCgLJf8N6YHT4SNMhFUMpXp1HDk9rN1fL3xumIx8SdszBCuD1vJQQQno4MuPEdTPrmY+nY2MOP
	HG9vkEvB53MGD5TxVYgGHppNYr1V7C4OJ3LET0IP39eGpLG4G5QdKoMqMZU0t9Pc4/SOU1nMAvU
	kpYbW1I4DbRA8JRBWsTStuD9DnTtTMSOqo9ioeRozJ1metQ3Q5EaVmDKpPMD4apNDg5AIQxOu7p
	CPrwx5IqFQEh+iIp3MAgJFO4bnkir/gBGRc7mXVJTtlFqMdxNVThJA6yKlyZSZLZB8do9G0rvHe
	sJofQO1GsIENJil73FC2NJGjko2icdw8ifCzuFG6w0cwfDaMRjxt6Wvff3OiFGDZAVAjZ0bz5c2
	poYV3haNwy0HJbGa+9OX6VGIz9Djh6uRyM=
X-Received: by 2002:a05:6000:4028:b0:486:f1ec:f939 with SMTP id ffacd0b85a97d-4871e36d1admr20677913f8f.40.1790077513039;
        Tue, 22 Sep 2026 04:45:13 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1715:59a3:7aab:2955? ([2620:10d:c092:500::7:c6a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862795232sm4488615f8f.32.2026.09.22.04.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:45:12 -0700 (PDT)
Message-ID: <026b61de-c223-496f-ada2-854e2c13c3f2@gmail.com>
Date: Tue, 22 Sep 2026 12:45:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
 <arIu1SA3F66HhMkv@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <arIu1SA3F66HhMkv@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 8:31 AM, Anton Protopopov wrote:
> On 26/09/21 02:28PM, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Four- and eight-byte keys are common enough to warrant specialized htab
>> lookups. Fold JHASH_INITVAL and the key length into hashrnd once when
>> allocating maps with these key sizes.
>>
>> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
>> map's fixed key size. Select u32- and u64-specific lookup entry points so
>> the compiler can specialize both hash setup and key comparison. Other key
>> sizes continue to use the generic lookup entry point.
>>
>> This preserves the jhash2() result and lookup semantics while avoiding
>> generic length handling and repeated state setup.
>>
>> Measure this with six runs of:
>>
>>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
>>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
>>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
>>       --map_flags 0x40
>>
>> inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
>> first and the optimized kernel second. Use these workloads:
>>
>>              max_entries   nr_entries    nr_loops
>>   small              512          256   8,388,608
>>   medium          10,000        5,000   8,000,000
>>   large          100,000       50,000   8,000,000
>>
>> Mean throughput in million lookups per second is:
>>
>>   Baseline:
>>                          key size (bytes)
>>                       1        4        8       10
>>     small         89.45    91.21   103.40    91.74
>>     medium       125.97    80.25    91.94    78.52
>>     large        140.67    53.56    58.68    47.31
>>
>>   Optimized:
>>                          key size (bytes)
>>                       1        4        8       10
>>     small         86.95   233.63   168.65    90.88
>>     medium       124.97   150.20   137.76    77.51
>>     large        131.06    80.51    76.04    47.25
>>
>>   Change:
>>                          key size (bytes)
>>                       1        4        8       10
>>     small         -2.79% +156.15%  +63.11%   -0.94%
>>     medium        -0.79%  +87.17%  +49.83%   -1.28%
>>     large         -6.84%  +50.32%  +29.58%   -0.12%
>>
>> The u32 specialization improves lookup throughput by 50-156%, and the
>> u64 specialization improves it by 30-63%. Ten-byte controls remain
>> within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
>> ---
>> Changes in v2:
>> - Added variants of __htab_map_lookup_elem() functions with inlined
>> u32/u64 key sizes, use them in htab_map_gen_lookup();
>> improved lookup perf significantly (Alexei)
>> - Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
>> ---
>>  kernel/bpf/hashtab.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 42 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 6f331c80130d..77c96105eda8 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>  		htab->hashrnd = 0;
>>  	else
>>  		htab->hashrnd = get_random_u32();
>> +	/*
>> +	 * Fold the jhash constant and key length into hashrnd once for the
>> +	 * fixed-size fast paths instead of doing it on every lookup.
>> +	 */
>> +	if (htab->map.key_size == sizeof(u32) ||
>> +	    htab->map.key_size == sizeof(u64))
>> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
>>  
>>  	htab_init_buckets(htab);
>>  
>> @@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>  
>>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
>>  {
>> -	if (likely(key_len % 4 == 0))
>> +	const u32 *k = key;
>> +	u32 b;
>> +
>> +	if (key_len == sizeof(u32))
>> +		b = 0;
>> +	else if (key_len == sizeof(u64))
>> +		b = k[1];
>> +	else if (likely(key_len % 4 == 0))
>>  		return jhash2(key, key_len / 4, hashrnd);
>> -	return jhash(key, key_len, hashrnd);
>> +	else
>> +		return jhash(key, key_len, hashrnd);
>> +
>> +	return __jhash_nwords(k[0], b, 0, hashrnd);
>>  
>>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
>> @@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>>   * The return value is adjusted by BPF instructions
>>   * in htab_map_gen_lookup().
>>   */
>> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
>>  {
>>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>  	struct hlist_nulls_head *head;
>>  	struct htab_elem *l;
>> -	u32 hash, key_size;
>> +	u32 hash;
>>  
>>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
>>  
>> -	key_size = map->key_size;
>> -
>>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
>>  
>>  	head = select_bucket(htab, hash);
>> @@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>>  	return l;
>>  }
>>  
>> +static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +	return __htab_lookup(map, key, map->key_size);
>> +}
>> +
>> +static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
>> +{
>> +	return __htab_lookup(map, key, sizeof(u32));
>> +}
>> +
>> +static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
>> +{
>> +	return __htab_lookup(map, key, sizeof(u64));
>> +}
>> +
>>  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
>>  {
>>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
>> @@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>  
>>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
>>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
>> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>> +	if (map->key_size == sizeof(u32))
>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
>> +	else if (map->key_size == sizeof(u64))
>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
>> +	else
>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> 
> I am trying to remember why I didn't do this when I was touching this
> code, I was definitely thinking about it... Given your changes,
> it is worth to approach xxh3 again, it works way better for bigger key
> sizes, see [1].
> 
>   [1] https://archive.fosdem.org/2023/schedule/event/bpf_hashing/
> 
> 
Let me try to run the benchmark. Did you use an actual xxh3 (not
available in kernel) or xxh32/xxh64?> 
>>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>>  				offsetof(struct htab_elem, key) +
>>
>> ---
>> base-commit: 6e1ac8758fcd07bee12ccaff0087cc66930a4187
>> change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e
>>
>> Best regards,
>> --  
>> Mykyta Yatsenko <yatsenko@meta.com>
>>

