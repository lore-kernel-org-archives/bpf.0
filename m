Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CB2D1F44
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093348; cv=none; b=cwkpN6yU2BZY6crnyrl/7jf7szNB/B2LICIag+eputgRcVhMchcJ2anDzPWh9cAz+Ps5xzCZr21p6H25ePbDZY+L3KG/AfUxECQfq680Kvo2zFW7l92CGKRVu3TIMx3Qd4tB56H+NgG8vP+U/4haYpHu6DCSufwuvQuDJXyr/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093348; c=relaxed/simple;
	bh=v8IETkHvCgERTWuM2y7zsCae+HNsXRLPeYSzHxFs2U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyzBrP6qQ9el03iHz5UVX3ivV8w8yG1eqNvWICAtWrq4O4T+zGHIm41948p41k9bQ7D/5Uwgtl8OVWWBfCBFyuAAMk/HQp8HX0b1kAn+GA/1w38HOlK8SE6PK6kte4nFqaOvEXsmfreBCcQMM/IFpjG9ew4AUCoFJRorYictHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooILyrnp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooILyrnp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso21529655e9.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093343; x=1790698143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZB6nluJrWvp0wAZwKXSzMN1a5h1rx9eZMkJpM0ahpHA=;
        b=ooILyrnp8jr2WJe2VlqSINUljdWVrJlY/pp5cGJIqUZENr95AUYcmvHJUWDUOWnuI3
         UtPQtnN+WxSZFm+1/p2zlY4X8v5CHBWlyChbt+qCnvrVNuoxkKTjyOayb8OpCT1QcnRo
         8rYwyQ1b2Si8wkMDw89hoNBhAMID6oFFqGmeBI2+ikUbuikD1wDDXnt6zysjnlHqzYL3
         Y0/h2WyCrAg3K5mVkAZ56wKy1Dtbug9Qa/e83mgW4IFfkrtChQldbb1gA4DEgP5v5Y86
         Li5OhiVUnVoyJhD0CB/VcKYZNDvJ8RAyXTilF1NXezbiLsu3NZaFoh0DxM2eu/woVT8B
         pqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093343; x=1790698143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZB6nluJrWvp0wAZwKXSzMN1a5h1rx9eZMkJpM0ahpHA=;
        b=08ejhhpu7kFz9M5wDrG2sgM5lR2l0/1/529vRh8jGRhXWuKkwSe82HaONAMaaZiuxR
         0+PyzlrtvsV3k+7EmrRn16SvgZ+V60LpOxatu0bO3119Jx3Q79jFghO9gbRrW3Act8aT
         oz5QIXR45jqbaYjUxAQaJ1nfIY6vsr4o81ZrYtLRRqOT31jS1B69qp6DS9qKeCnfhvz4
         134sdHooZ6aua7k7Z6qcSL4BYxevay7y3t8lNs+2LupeVO8dnIji7gG0PGp79/EI2a1T
         ph8/oUDl2EbyWoT6Zn9JVXNc3J30ZCu1f4yYZGLJyX4yEXvgwhezuYEDtrnFZ4FKtK3d
         rKHQ==
X-Gm-Message-State: AFuF++mFRsLIK3zfHYoQxRVhAzF8Sn2gno2WAylB1+N3ZlCFXokVHoUM
	qBkFCIR9K68oio/wFsJNPZLgMi4YyhTc2QdTB6jHDUL++G3c275olqE+
X-Gm-Gg: AYBFou2zkFJGrTwLGFBLiPLMqS+YeZWzIXNha1A1YCX9n5Z3gj3gD90A6AB352J96Ng
	H9/RNECY5+mgqkvW62UGjLIW5nPL8dcVuSslLcICFexAi0Nbtx+HbBrGs0nhNDvFJm2dr3PjRZV
	wmjkmtC0RbEoqcBErHWB0O1TrLx8JdvMAWbTKBvO2iJnH8qCHgdukHFaV+SKCwIf13vXgyRi8eP
	8Q1k4eT6GCww5ctT6RPtjYtH640/1fBDOnTEGdi//aJA1jt/CDdvYwz3zgJun/e+ZR2Svbn6mD4
	ETUDN43UewJp0T5ly2i5m8+5/YiGZdpNlQPRIC3hiTI96DulEnOSOMTaVJF3EVNjSWlrm0zWhfi
	asWFkNrOfOYLJfey5bmk0fdSmbiwGyUTAWOimO6F5/i6ULPqT3QQhbCz/AHXSt1+ASe18mmZtpw
	Ru1R2bEU3j1SB8pdfUyIg4Rf4FbwaLX7jFBPEH5hZ0qRlChYkmTAsaVwgfoR2P6xzHaFnx92CRd
	CU0BHI=
X-Received: by 2002:a05:600d:6401:10b0:49f:cbae:3414 with SMTP id 5b1f17b1804b1-49fcbae34a9mr126783415e9.4.1790093343291;
        Tue, 22 Sep 2026 09:09:03 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886277def8sm6476448f8f.14.2026.09.22.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:09:02 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:19:31 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
Message-ID: <arKqk5QsR6Fq1hFe@mail.gmail.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
 <arIu1SA3F66HhMkv@mail.gmail.com>
 <026b61de-c223-496f-ada2-854e2c13c3f2@gmail.com>
 <arJ8pKywegWPY67m@mail.gmail.com>
 <c3595598-20a6-4043-87ac-06acab7d5744@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3595598-20a6-4043-87ac-06acab7d5744@gmail.com>

On 26/09/22 04:57PM, Mykyta Yatsenko wrote:
> On 9/22/26 2:03 PM, Anton Protopopov wrote:
> > On 26/09/22 12:45PM, Mykyta Yatsenko wrote:
> >>
> >>
> >> On 9/22/26 8:31 AM, Anton Protopopov wrote:
> >>> On 26/09/21 02:28PM, Mykyta Yatsenko wrote:
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> Four- and eight-byte keys are common enough to warrant specialized htab
> >>>> lookups. Fold JHASH_INITVAL and the key length into hashrnd once when
> >>>> allocating maps with these key sizes.
> >>>>
> >>>> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
> >>>> map's fixed key size. Select u32- and u64-specific lookup entry points so
> >>>> the compiler can specialize both hash setup and key comparison. Other key
> >>>> sizes continue to use the generic lookup entry point.
> >>>>
> >>>> This preserves the jhash2() result and lookup semantics while avoiding
> >>>> generic length handling and repeated state setup.
> >>>>
> >>>> Measure this with six runs of:
> >>>>
> >>>>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
> >>>>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
> >>>>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
> >>>>       --map_flags 0x40
> >>>>
> >>>> inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
> >>>> first and the optimized kernel second. Use these workloads:
> >>>>
> >>>>              max_entries   nr_entries    nr_loops
> >>>>   small              512          256   8,388,608
> >>>>   medium          10,000        5,000   8,000,000
> >>>>   large          100,000       50,000   8,000,000
> >>>>
> >>>> Mean throughput in million lookups per second is:
> >>>>
> >>>>   Baseline:
> >>>>                          key size (bytes)
> >>>>                       1        4        8       10
> >>>>     small         89.45    91.21   103.40    91.74
> >>>>     medium       125.97    80.25    91.94    78.52
> >>>>     large        140.67    53.56    58.68    47.31
> >>>>
> >>>>   Optimized:
> >>>>                          key size (bytes)
> >>>>                       1        4        8       10
> >>>>     small         86.95   233.63   168.65    90.88
> >>>>     medium       124.97   150.20   137.76    77.51
> >>>>     large        131.06    80.51    76.04    47.25
> >>>>
> >>>>   Change:
> >>>>                          key size (bytes)
> >>>>                       1        4        8       10
> >>>>     small         -2.79% +156.15%  +63.11%   -0.94%
> >>>>     medium        -0.79%  +87.17%  +49.83%   -1.28%
> >>>>     large         -6.84%  +50.32%  +29.58%   -0.12%
> >>>>
> >>>> The u32 specialization improves lookup throughput by 50-156%, and the
> >>>> u64 specialization improves it by 30-63%. Ten-byte controls remain
> >>>> within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.
> >>>>
> >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>>> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Added variants of __htab_map_lookup_elem() functions with inlined
> >>>> u32/u64 key sizes, use them in htab_map_gen_lookup();
> >>>> improved lookup perf significantly (Alexei)
> >>>> - Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
> >>>> ---
> >>>>  kernel/bpf/hashtab.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
> >>>>  1 file changed, 42 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >>>> index 6f331c80130d..77c96105eda8 100644
> >>>> --- a/kernel/bpf/hashtab.c
> >>>> +++ b/kernel/bpf/hashtab.c
> >>>> @@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >>>>  		htab->hashrnd = 0;
> >>>>  	else
> >>>>  		htab->hashrnd = get_random_u32();
> >>>> +	/*
> >>>> +	 * Fold the jhash constant and key length into hashrnd once for the
> >>>> +	 * fixed-size fast paths instead of doing it on every lookup.
> >>>> +	 */
> >>>> +	if (htab->map.key_size == sizeof(u32) ||
> >>>> +	    htab->map.key_size == sizeof(u64))
> >>>> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
> >>>>  
> >>>>  	htab_init_buckets(htab);
> >>>>  
> >>>> @@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >>>>  
> >>>>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> >>>>  {
> >>>> -	if (likely(key_len % 4 == 0))
> >>>> +	const u32 *k = key;
> >>>> +	u32 b;
> >>>> +
> >>>> +	if (key_len == sizeof(u32))
> >>>> +		b = 0;
> >>>> +	else if (key_len == sizeof(u64))
> >>>> +		b = k[1];
> >>>> +	else if (likely(key_len % 4 == 0))
> >>>>  		return jhash2(key, key_len / 4, hashrnd);
> >>>> -	return jhash(key, key_len, hashrnd);
> >>>> +	else
> >>>> +		return jhash(key, key_len, hashrnd);
> >>>> +
> >>>> +	return __jhash_nwords(k[0], b, 0, hashrnd);
> >>>>  
> >>>>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
> >>>> @@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
> >>>>   * The return value is adjusted by BPF instructions
> >>>>   * in htab_map_gen_lookup().
> >>>>   */
> >>>> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> >>>> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
> >>>>  {
> >>>>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> >>>>  	struct hlist_nulls_head *head;
> >>>>  	struct htab_elem *l;
> >>>> -	u32 hash, key_size;
> >>>> +	u32 hash;
> >>>>  
> >>>>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
> >>>>  
> >>>> -	key_size = map->key_size;
> >>>> -
> >>>>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
> >>>>  
> >>>>  	head = select_bucket(htab, hash);
> >>>> @@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> >>>>  	return l;
> >>>>  }
> >>>>  
> >>>> +static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> >>>> +{
> >>>> +	return __htab_lookup(map, key, map->key_size);
> >>>> +}
> >>>> +
> >>>> +static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
> >>>> +{
> >>>> +	return __htab_lookup(map, key, sizeof(u32));
> >>>> +}
> >>>> +
> >>>> +static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
> >>>> +{
> >>>> +	return __htab_lookup(map, key, sizeof(u64));
> >>>> +}
> >>>> +
> >>>>  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
> >>>>  {
> >>>>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
> >>>> @@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
> >>>>  
> >>>>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
> >>>>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
> >>>> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> >>>> +	if (map->key_size == sizeof(u32))
> >>>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
> >>>> +	else if (map->key_size == sizeof(u64))
> >>>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
> >>>> +	else
> >>>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> >>>
> >>> I am trying to remember why I didn't do this when I was touching this
> >>> code, I was definitely thinking about it... Given your changes,
> >>> it is worth to approach xxh3 again, it works way better for bigger key
> >>> sizes, see [1].
> >>>
> >>>   [1] https://archive.fosdem.org/2023/schedule/event/bpf_hashing/
> >>>
> >>>
> >> Let me try to run the benchmark. Did you use an actual xxh3 (not
> >> available in kernel) or xxh32/xxh64?> 
> > 
> > The actual xxh3. For small keys xxh3 was really fragile (the hash was
> > outperforming in hash-only benchmarks, but was not that good when used in the
> > hashmap), so I ended up only patching code to use jhash2. For keys >=20,
> > I think, xxh3 becomes definitely better for all benchmarks. One further note:
> > the original xxh3 uses vectorized instructions for keys >=240 and for such keys
> > the fastest ist xxh64. (Well, for keys >5-6K the spooky hash was the best,
> > but are there any such use cases?)
> > 
> > For the code, I've used my own kernel port of xxh3. The XXH3 also uses a
> > key-size-based switch internally, so for generated lookups something like
> > xxh3_17_to_128 can be used specifically. Unfortanetely, I am not sure
> > what was the latest version I had... You can find one here:
> > 
> >   https://github.com/aspsk/bpf-next/commit/e86be3c926051ee87375da4f0df4b873d2f7e9c2
> > 
> > (notably see xxh3_17_to_128() and xxh3_129_to_240()). The code should work,
> > but definitely needs some love, maybe it's easier to re-import it using
> > modern tools.
> > 
> 
> Trying xxh3:
> ```
>   Small map:
>                             key size (bytes)
>                     16      32      64     128     256     512    1024
>     jhash        91.15   61.31   32.26   16.55    8.26    4.34    2.20
>     full_name    53.43   47.50   36.96   25.37   15.29    8.93    4.93
>     XXH64        40.16   32.50   29.65   23.73   17.25   11.57    7.19
>     XXH3         54.94   53.56   48.39   37.66   22.33   13.31    7.71
> 
>   Medium map:
>                             key size (bytes)
>                     16      32      64     128     256     512    1024
>     jhash        68.93   52.25   28.27   16.02    7.98    3.92    2.08
>     full_name    43.71   39.56   31.52   22.19   13.90    7.20    4.21
>     XXH64        35.18   28.95   25.83   21.40   15.51    8.97    5.66
>     XXH3         43.06   42.86   39.05   32.37   19.78   10.58    6.13
> 
>   Large map:
>                             key size (bytes)
>                     16      32      64     128     256     512    1024
>     jhash        45.42   35.95   21.62   13.35    6.84    2.94    1.43
>     full_name    24.14   22.50   19.46   15.15   10.59    4.31    2.23
>     XXH64        20.73   18.35   17.43   14.99   11.75    4.89    2.78
>     XXH3         24.63   24.26   23.17   20.75   13.97    5.27    2.76
> 
>                             key size (bytes)
>                     64     128     256     512    1024
>    small        +54.9% +128.4% +167.2% +203.7% +256.0%
>    medium       +37.1% +104.7% +149.6% +169.6% +209.3%
>    large        +14.6%  +59.0% +104.6%  +95.5%  +98.6%
> 
> XXH3 starts winning consistently at 64-byte keys. Additional
> measurements at 40, 48, and 56 bytes still showed regressions for the
> large map, so 64 bytes is used as the conservative cutoff.
> ```
> 
> I don't think we have a lot of maps with 64+ bytes keys on the
> hot paths, but generally looks like a useful addition.
> 
> We'll need to bring xxh3 into the kernel (it's not small), 
> do we want to limit it to bpf only or not.
> Either way sounds like a good direction, but maybe for another
> patch series.
> Anton, Alexei, any thoughts, on xxh3 direction? Do we need it
> at all, where to put hash implementation, should it go into this patch series 
> or new.

I think this patch is great as is, no reason to block it by xxh3.

I've mentioned that xxh3 fragile, and I had few variants,
and the benchmarks depended a lot on compiler & hardware
it was run on (say, didn't get to testing it on arm at all).
So if you're getting mixed results as well, then let's pass
on it, until there is "reliably optimized" implementation...

> >>>>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
> >>>>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
> >>>>  				offsetof(struct htab_elem, key) +
> >>>>
> >>>> ---
> >>>> base-commit: 6e1ac8758fcd07bee12ccaff0087cc66930a4187
> >>>> change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e
> >>>>
> >>>> Best regards,
> >>>> --  
> >>>> Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>
> 
