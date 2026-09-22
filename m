Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA705616BD
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092681; cv=none; b=Im20tc5Q96JqrtYMaAOFh6sMPCWT/XW1o1yBEMGQueJucaKshnoGotv+xPD19I+NW/jQSlFPwDKENx1BUOyyUQlLIfbWzkROEJjtZ99HEWYy2YnVzTPK2fJkG/aHk9LFQFtDrxO5rOgAQyuG/fiKG4QYQ1R6iIJhYXyCdvivUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092681; c=relaxed/simple;
	bh=FYwTSSnETIU0WkUvLt0jX+gKuB93YVzuo+JUT5AN/Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2SQOEfSxrOkFigz8aMwcNtVuqRGkVAFKygSESb5z7zH36DgbwbfVj32wkXCzjAdzGUPEawJlnS5gl1L5c16F9USs1++5odqo7DAeYNgrzP8hiJxDrx05k6mMVtw4jo2LUUaVuj/g7sKrMznB0VgC82gMTo8fPLGJBWXbacjZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEsjiHRa; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEsjiHRa"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so56176f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092677; x=1790697477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfNPyT+dSkmCukQoGzWfDQjJ7BhXjDa9feN2Nf5BmpA=;
        b=gEsjiHRaUiZa0UGrHUBxkyKMJFi7WyG/TPltB0w4vgCa/m/urm1gZZC5SrCEY+/Du8
         jCvotDKVUHZ9FJlp3yNKm3g+u87C61avbw33mp/Que043q7gmy7BZStKHauQMI705I+R
         7PvHfeGpQc3Zq823IboLgFtNOTUjNLiQEvOZv7Jb0SgrNZU7rCCMcDEEMR2eKwK0HIJj
         jDG5YEWSH6b2aKLQLNsEoowSBP5jcWirUi2/sYN4J5KZlgflM4ftLO0v/A4pxWi7Et2a
         fD+A5bNfOcoRBD2+1Gs9QCtvrltxosVyaBtTF+LbIx7zXm9F9frpvNKnLhW8wNE1AobD
         RWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092677; x=1790697477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfNPyT+dSkmCukQoGzWfDQjJ7BhXjDa9feN2Nf5BmpA=;
        b=sautH5F9hjqK7eQf+nmmclRST96MB2RxbSo2JLVNlfnFhjCNnDh3u8BQeQHDWD5toH
         AR7haLr1c6Y58m8SOT+5qlvgs0sZMGe6YiC8cpTWSGaIdhNPd2n9Sa5QHOkUZC21fKhq
         G9g1W/aETZKTpFaknCXoSk70DauvNHl0pZDQ/u3KwZY2nJPj+tGjUaPO9F7Gu4OJpl18
         FsVyDFAy2KyghSBtFpZvpcsjpie/seWgIP6kqRmfmo4T4TVec9QO40yuqLX0WEGZx40K
         RsC/iWik4fD6iugcBwB1q223kf2C/ODbJWXgUkbhlZkJMhrUH5w0E/a9pG05ny0yz/4a
         VH5w==
X-Gm-Message-State: AFuF++kmPIpOpiMisyScFRK/PAbp64IDjiY6yMkegX58iyBKibp7+rEe
	qBy8c2jQ/CE+twBcRKFC5jayvIlCI1F0468ULETbG+4iM0mIks2TwTfL
X-Gm-Gg: AYBFou1APpaw0jVQs16gM985rkP7hvZ6TB1iV7QDXZOUVw5RxYPYKYpPRzPnO0i82pv
	/FGVz1r6gcRobaCaUG5dM1CupRpmfNiGoTVC6siGJRTLOAZNERa4nMFBy0DZZgQcfV7VxlCBPEj
	xeF4j/hOhY8ImaAmUF0Nd383p7y462KMQ/9L+W3SaxiGVe4TLpXpOrOEuRbnzkW/AqpB2iD3+C6
	KzXPvBhFJskKB4cbp5NYwr36HfEIE7sWIW5ofp1wknNnmNnhapHWFKkgjcDo3d5B2QHPnbb5bfz
	+Yc9VglyXo92Fk98lQMtWoatxCPAAncqgkAkKpj/L9Xv4f4wxCJu4GtYW5pKgGlhMGbq4vtAkZK
	aWpcDXI8J0cY4CAhEXkSNs4Zgs/naEap/Tr9XCR+qmjWyJWw6rYEZds1pxNUBZe7lcEG2IF2EkB
	xWngwjBMvAhIrt2VDIXfLgy8dxywOtVYvqygzuXnNmX0vXFUoVtmSgbm1DSv9eYAOumdQY4mf07
	XMT2d31dQagtpSa+Am9OcoscT+G5AbCbXM=
X-Received: by 2002:a05:6000:26d3:b0:487:1681:2218 with SMTP id ffacd0b85a97d-488670afe46mr8931f8f.45.1790092677057;
        Tue, 22 Sep 2026 08:57:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1715:59a3:7aab:2955? ([2620:10d:c092:500::7:c6a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886277def8sm6401817f8f.14.2026.09.22.08.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:57:56 -0700 (PDT)
Message-ID: <c3595598-20a6-4043-87ac-06acab7d5744@gmail.com>
Date: Tue, 22 Sep 2026 16:57:56 +0100
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
 <026b61de-c223-496f-ada2-854e2c13c3f2@gmail.com>
 <arJ8pKywegWPY67m@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <arJ8pKywegWPY67m@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 2:03 PM, Anton Protopopov wrote:
> On 26/09/22 12:45PM, Mykyta Yatsenko wrote:
>>
>>
>> On 9/22/26 8:31 AM, Anton Protopopov wrote:
>>> On 26/09/21 02:28PM, Mykyta Yatsenko wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Four- and eight-byte keys are common enough to warrant specialized htab
>>>> lookups. Fold JHASH_INITVAL and the key length into hashrnd once when
>>>> allocating maps with these key sizes.
>>>>
>>>> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
>>>> map's fixed key size. Select u32- and u64-specific lookup entry points so
>>>> the compiler can specialize both hash setup and key comparison. Other key
>>>> sizes continue to use the generic lookup entry point.
>>>>
>>>> This preserves the jhash2() result and lookup semantics while avoiding
>>>> generic length handling and repeated state setup.
>>>>
>>>> Measure this with six runs of:
>>>>
>>>>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
>>>>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
>>>>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
>>>>       --map_flags 0x40
>>>>
>>>> inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
>>>> first and the optimized kernel second. Use these workloads:
>>>>
>>>>              max_entries   nr_entries    nr_loops
>>>>   small              512          256   8,388,608
>>>>   medium          10,000        5,000   8,000,000
>>>>   large          100,000       50,000   8,000,000
>>>>
>>>> Mean throughput in million lookups per second is:
>>>>
>>>>   Baseline:
>>>>                          key size (bytes)
>>>>                       1        4        8       10
>>>>     small         89.45    91.21   103.40    91.74
>>>>     medium       125.97    80.25    91.94    78.52
>>>>     large        140.67    53.56    58.68    47.31
>>>>
>>>>   Optimized:
>>>>                          key size (bytes)
>>>>                       1        4        8       10
>>>>     small         86.95   233.63   168.65    90.88
>>>>     medium       124.97   150.20   137.76    77.51
>>>>     large        131.06    80.51    76.04    47.25
>>>>
>>>>   Change:
>>>>                          key size (bytes)
>>>>                       1        4        8       10
>>>>     small         -2.79% +156.15%  +63.11%   -0.94%
>>>>     medium        -0.79%  +87.17%  +49.83%   -1.28%
>>>>     large         -6.84%  +50.32%  +29.58%   -0.12%
>>>>
>>>> The u32 specialization improves lookup throughput by 50-156%, and the
>>>> u64 specialization improves it by 30-63%. Ten-byte controls remain
>>>> within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> - Added variants of __htab_map_lookup_elem() functions with inlined
>>>> u32/u64 key sizes, use them in htab_map_gen_lookup();
>>>> improved lookup perf significantly (Alexei)
>>>> - Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
>>>> ---
>>>>  kernel/bpf/hashtab.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>>>>  1 file changed, 42 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>> index 6f331c80130d..77c96105eda8 100644
>>>> --- a/kernel/bpf/hashtab.c
>>>> +++ b/kernel/bpf/hashtab.c
>>>> @@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>>>  		htab->hashrnd = 0;
>>>>  	else
>>>>  		htab->hashrnd = get_random_u32();
>>>> +	/*
>>>> +	 * Fold the jhash constant and key length into hashrnd once for the
>>>> +	 * fixed-size fast paths instead of doing it on every lookup.
>>>> +	 */
>>>> +	if (htab->map.key_size == sizeof(u32) ||
>>>> +	    htab->map.key_size == sizeof(u64))
>>>> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
>>>>  
>>>>  	htab_init_buckets(htab);
>>>>  
>>>> @@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>>>  
>>>>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
>>>>  {
>>>> -	if (likely(key_len % 4 == 0))
>>>> +	const u32 *k = key;
>>>> +	u32 b;
>>>> +
>>>> +	if (key_len == sizeof(u32))
>>>> +		b = 0;
>>>> +	else if (key_len == sizeof(u64))
>>>> +		b = k[1];
>>>> +	else if (likely(key_len % 4 == 0))
>>>>  		return jhash2(key, key_len / 4, hashrnd);
>>>> -	return jhash(key, key_len, hashrnd);
>>>> +	else
>>>> +		return jhash(key, key_len, hashrnd);
>>>> +
>>>> +	return __jhash_nwords(k[0], b, 0, hashrnd);
>>>>  
>>>>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
>>>> @@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>>>>   * The return value is adjusted by BPF instructions
>>>>   * in htab_map_gen_lookup().
>>>>   */
>>>> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
>>>>  {
>>>>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>>  	struct hlist_nulls_head *head;
>>>>  	struct htab_elem *l;
>>>> -	u32 hash, key_size;
>>>> +	u32 hash;
>>>>  
>>>>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
>>>>  
>>>> -	key_size = map->key_size;
>>>> -
>>>>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
>>>>  
>>>>  	head = select_bucket(htab, hash);
>>>> @@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>>  	return l;
>>>>  }
>>>>  
>>>> +static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>> +{
>>>> +	return __htab_lookup(map, key, map->key_size);
>>>> +}
>>>> +
>>>> +static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
>>>> +{
>>>> +	return __htab_lookup(map, key, sizeof(u32));
>>>> +}
>>>> +
>>>> +static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
>>>> +{
>>>> +	return __htab_lookup(map, key, sizeof(u64));
>>>> +}
>>>> +
>>>>  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>>  {
>>>>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>>> @@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>>>  
>>>>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
>>>>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
>>>> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>>>> +	if (map->key_size == sizeof(u32))
>>>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
>>>> +	else if (map->key_size == sizeof(u64))
>>>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
>>>> +	else
>>>> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>>>
>>> I am trying to remember why I didn't do this when I was touching this
>>> code, I was definitely thinking about it... Given your changes,
>>> it is worth to approach xxh3 again, it works way better for bigger key
>>> sizes, see [1].
>>>
>>>   [1] https://archive.fosdem.org/2023/schedule/event/bpf_hashing/
>>>
>>>
>> Let me try to run the benchmark. Did you use an actual xxh3 (not
>> available in kernel) or xxh32/xxh64?> 
> 
> The actual xxh3. For small keys xxh3 was really fragile (the hash was
> outperforming in hash-only benchmarks, but was not that good when used in the
> hashmap), so I ended up only patching code to use jhash2. For keys >=20,
> I think, xxh3 becomes definitely better for all benchmarks. One further note:
> the original xxh3 uses vectorized instructions for keys >=240 and for such keys
> the fastest ist xxh64. (Well, for keys >5-6K the spooky hash was the best,
> but are there any such use cases?)
> 
> For the code, I've used my own kernel port of xxh3. The XXH3 also uses a
> key-size-based switch internally, so for generated lookups something like
> xxh3_17_to_128 can be used specifically. Unfortanetely, I am not sure
> what was the latest version I had... You can find one here:
> 
>   https://github.com/aspsk/bpf-next/commit/e86be3c926051ee87375da4f0df4b873d2f7e9c2
> 
> (notably see xxh3_17_to_128() and xxh3_129_to_240()). The code should work,
> but definitely needs some love, maybe it's easier to re-import it using
> modern tools.
> 

Trying xxh3:
```
  Small map:
                            key size (bytes)
                    16      32      64     128     256     512    1024
    jhash        91.15   61.31   32.26   16.55    8.26    4.34    2.20
    full_name    53.43   47.50   36.96   25.37   15.29    8.93    4.93
    XXH64        40.16   32.50   29.65   23.73   17.25   11.57    7.19
    XXH3         54.94   53.56   48.39   37.66   22.33   13.31    7.71

  Medium map:
                            key size (bytes)
                    16      32      64     128     256     512    1024
    jhash        68.93   52.25   28.27   16.02    7.98    3.92    2.08
    full_name    43.71   39.56   31.52   22.19   13.90    7.20    4.21
    XXH64        35.18   28.95   25.83   21.40   15.51    8.97    5.66
    XXH3         43.06   42.86   39.05   32.37   19.78   10.58    6.13

  Large map:
                            key size (bytes)
                    16      32      64     128     256     512    1024
    jhash        45.42   35.95   21.62   13.35    6.84    2.94    1.43
    full_name    24.14   22.50   19.46   15.15   10.59    4.31    2.23
    XXH64        20.73   18.35   17.43   14.99   11.75    4.89    2.78
    XXH3         24.63   24.26   23.17   20.75   13.97    5.27    2.76

                            key size (bytes)
                    64     128     256     512    1024
   small        +54.9% +128.4% +167.2% +203.7% +256.0%
   medium       +37.1% +104.7% +149.6% +169.6% +209.3%
   large        +14.6%  +59.0% +104.6%  +95.5%  +98.6%

XXH3 starts winning consistently at 64-byte keys. Additional
measurements at 40, 48, and 56 bytes still showed regressions for the
large map, so 64 bytes is used as the conservative cutoff.
```

I don't think we have a lot of maps with 64+ bytes keys on the
hot paths, but generally looks like a useful addition.

We'll need to bring xxh3 into the kernel (it's not small), 
do we want to limit it to bpf only or not.
Either way sounds like a good direction, but maybe for another
patch series.
Anton, Alexei, any thoughts, on xxh3 direction? Do we need it
at all, where to put hash implementation, should it go into this patch series 
or new.
>>>>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>>>>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>>>>  				offsetof(struct htab_elem, key) +
>>>>
>>>> ---
>>>> base-commit: 6e1ac8758fcd07bee12ccaff0087cc66930a4187
>>>> change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e
>>>>
>>>> Best regards,
>>>> --  
>>>> Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>

