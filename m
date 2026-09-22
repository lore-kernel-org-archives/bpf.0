Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDC545D99
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081588; cv=none; b=rziIIa1yWuqYpfrwKxNt8OlMKGd3VcBihru1iMnRtIXYfAkR81ZmdRea7Sv6VMOZ+A02Yx765SFrGMLuqG8lCrrxHqqrjKKbZWXoViPmWLhplMIcV15rgusPSBm5UFTWf1QlKbOKUnbmUsZd1z2Aq5QhnI8UDbpqFh+TK5vnNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081588; c=relaxed/simple;
	bh=WxCetd9l3lOpt5ZKe3k8MQ64CIA3i52gbi2SiRR7yVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD4fvJXz3fG03/4qWIHfcQbIFs2BUFCxWFfTHw+pUiVxql9jhX+Cuu6tJxGnpj24PlSexYFzmxZutF8HSmNu7ErzsbLTuf/iISgzfX87YtmWfvX0RWCEKgllOenaNa1V5/CXhbR8vqlMOG2K0ky5e9WyKi723j1SMgzSFTk4WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJu/aHrh; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJu/aHrh"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so1189769f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790081584; x=1790686384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ryODMGpZCd9oPh4a+UYyi/y5Fz2V23dEYMd1yZOdFJk=;
        b=RJu/aHrhWj9Nasyi1z8ZsXyShIftq9jxkzd+MLaM5edG2A5T0goZeFIfIvvMyAIvIm
         2D0FF3WzxWISYOEmxDX2A0RZlzDo/z+612XP+a0H42JsxsC0/Tzdlh1Poze5iJXVWhSU
         TnGJu1q+hvGc3YNVorTn+UZf57npVONb6oW9jP0iGimGKWzxKzuWjUua75v8tfwtlXHE
         jCJFCjrHqRONocgJk+C6nXH9XIBQBuPw/t+ZjyBuRNLLYHi0tUQ4kPN9pe9Z2Jp+xpPF
         xA77uGRl1Kat3JH+SRBr2yJHRgkxA5CjAi/bLYfrr/sZZJHMw2eMmlpO7fFIH190TYLp
         EG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081584; x=1790686384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryODMGpZCd9oPh4a+UYyi/y5Fz2V23dEYMd1yZOdFJk=;
        b=NRHMG9KlbtUtusIdEckwwpB8zX3WL58MvFCn87v6ciFy5RqYngrCxshjgev1E8AsJC
         ZgaYA50pr9daoYAuhJP/wXx56myvc5AAy1OfxczOvtdasYR6fnLeFL0AF+IbTMuQ8/nv
         f/k9sLDnsT9GxoZQxVutxSOtKYjuBq0oqa5I1VYNpJWLb5ZtJ8YZHSp1IjcVJ79YJxt0
         3AylK5zNWOD6+4ne7vgY4VWI9Pnh4pMAISywouD+sgoTeEJIQALcPxENGfCe8+WIX3gi
         GbWtuQQlR00LL+E/+JSIxEwiSoJaXIjUZPjyTOR6UxxAbxvSvu73x+gFT1sz/jzCBSyc
         6PDQ==
X-Gm-Message-State: AFuF++l9gC3JpvVPFu8jiGHjFlp85NOaQYWXmpQ787VL5H7kRuGfH0kv
	OwH9ydQ7Rw0zY5fM+RC309b4g5dUSyIQSuKWr0BX8guauyXrtBt1WD4M
X-Gm-Gg: AYBFou2clkhTIcP2hHWOCILxW5lP/gY+kVlw4XFflYBG1g/W4Rdlhx6xm7xcqnTFYUN
	294zEbYRuCqhBJo8IqLPPORmd87CjCRffm0vPjIaekgBdIbKOJnEXHVuxEESquIdw3JhWoHkJnT
	ejuRK1TrkGjV0oIgbINySigAgV0H0yKHPFDSDgWSSnlOCJQVsUfzFcGT0Yk3DagSs2LE5DDK13V
	hSs3SbzBn7Exj+kyMrdtwBgZx9e0/IN2zWMhJqE//ugbjp2/aoE4nC+WqQZK572W4NRaTt/BRCW
	WF5jRddJuYSZ8IpWxbfhp1niGAeOogjQ4Dm5TVRzQYfXi9PrprQ2mVY/+CT/H3RFFoLs8G2HFak
	Dw2AIjkrVi4h9OzBSyZ1KY34L3sMl4El31O0+gBSk7IUHIxSGLuvXgeMQD/IFNv2gM9Wi81NiLj
	4JqZ31KpXFBBz8TzttxxVIS49cLCSqn07vBbdKM6x+vao6ACHKfpkAMXe93vOD7dU02peLyYJQe
	loW4X+o4oxKCHzTmQ==
X-Received: by 2002:a5d:5d02:0:b0:485:8ee5:5ffa with SMTP id ffacd0b85a97d-4871e36b1c7mr21190235f8f.38.1790081583840;
        Tue, 22 Sep 2026 05:53:03 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862788f61sm5018267f8f.26.2026.09.22.05.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:53:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:03:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
Message-ID: <arJ8pKywegWPY67m@mail.gmail.com>
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
 <arIu1SA3F66HhMkv@mail.gmail.com>
 <026b61de-c223-496f-ada2-854e2c13c3f2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026b61de-c223-496f-ada2-854e2c13c3f2@gmail.com>

On 26/09/22 12:45PM, Mykyta Yatsenko wrote:
> 
> 
> On 9/22/26 8:31 AM, Anton Protopopov wrote:
> > On 26/09/21 02:28PM, Mykyta Yatsenko wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Four- and eight-byte keys are common enough to warrant specialized htab
> >> lookups. Fold JHASH_INITVAL and the key length into hashrnd once when
> >> allocating maps with these key sizes.
> >>
> >> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
> >> map's fixed key size. Select u32- and u64-specific lookup entry points so
> >> the compiler can specialize both hash setup and key comparison. Other key
> >> sizes continue to use the generic lookup entry point.
> >>
> >> This preserves the jhash2() result and lookup semantics while avoiding
> >> generic length handling and repeated state setup.
> >>
> >> Measure this with six runs of:
> >>
> >>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
> >>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
> >>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
> >>       --map_flags 0x40
> >>
> >> inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
> >> first and the optimized kernel second. Use these workloads:
> >>
> >>              max_entries   nr_entries    nr_loops
> >>   small              512          256   8,388,608
> >>   medium          10,000        5,000   8,000,000
> >>   large          100,000       50,000   8,000,000
> >>
> >> Mean throughput in million lookups per second is:
> >>
> >>   Baseline:
> >>                          key size (bytes)
> >>                       1        4        8       10
> >>     small         89.45    91.21   103.40    91.74
> >>     medium       125.97    80.25    91.94    78.52
> >>     large        140.67    53.56    58.68    47.31
> >>
> >>   Optimized:
> >>                          key size (bytes)
> >>                       1        4        8       10
> >>     small         86.95   233.63   168.65    90.88
> >>     medium       124.97   150.20   137.76    77.51
> >>     large        131.06    80.51    76.04    47.25
> >>
> >>   Change:
> >>                          key size (bytes)
> >>                       1        4        8       10
> >>     small         -2.79% +156.15%  +63.11%   -0.94%
> >>     medium        -0.79%  +87.17%  +49.83%   -1.28%
> >>     large         -6.84%  +50.32%  +29.58%   -0.12%
> >>
> >> The u32 specialization improves lookup throughput by 50-156%, and the
> >> u64 specialization improves it by 30-63%. Ten-byte controls remain
> >> within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Added variants of __htab_map_lookup_elem() functions with inlined
> >> u32/u64 key sizes, use them in htab_map_gen_lookup();
> >> improved lookup perf significantly (Alexei)
> >> - Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
> >> ---
> >>  kernel/bpf/hashtab.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 42 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 6f331c80130d..77c96105eda8 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >>  		htab->hashrnd = 0;
> >>  	else
> >>  		htab->hashrnd = get_random_u32();
> >> +	/*
> >> +	 * Fold the jhash constant and key length into hashrnd once for the
> >> +	 * fixed-size fast paths instead of doing it on every lookup.
> >> +	 */
> >> +	if (htab->map.key_size == sizeof(u32) ||
> >> +	    htab->map.key_size == sizeof(u64))
> >> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
> >>  
> >>  	htab_init_buckets(htab);
> >>  
> >> @@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >>  
> >>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> >>  {
> >> -	if (likely(key_len % 4 == 0))
> >> +	const u32 *k = key;
> >> +	u32 b;
> >> +
> >> +	if (key_len == sizeof(u32))
> >> +		b = 0;
> >> +	else if (key_len == sizeof(u64))
> >> +		b = k[1];
> >> +	else if (likely(key_len % 4 == 0))
> >>  		return jhash2(key, key_len / 4, hashrnd);
> >> -	return jhash(key, key_len, hashrnd);
> >> +	else
> >> +		return jhash(key, key_len, hashrnd);
> >> +
> >> +	return __jhash_nwords(k[0], b, 0, hashrnd);
> >>  
> >>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
> >> @@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
> >>   * The return value is adjusted by BPF instructions
> >>   * in htab_map_gen_lookup().
> >>   */
> >> -static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> >> +static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
> >>  {
> >>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> >>  	struct hlist_nulls_head *head;
> >>  	struct htab_elem *l;
> >> -	u32 hash, key_size;
> >> +	u32 hash;
> >>  
> >>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
> >>  
> >> -	key_size = map->key_size;
> >> -
> >>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
> >>  
> >>  	head = select_bucket(htab, hash);
> >> @@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> >>  	return l;
> >>  }
> >>  
> >> +static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
> >> +{
> >> +	return __htab_lookup(map, key, map->key_size);
> >> +}
> >> +
> >> +static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
> >> +{
> >> +	return __htab_lookup(map, key, sizeof(u32));
> >> +}
> >> +
> >> +static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
> >> +{
> >> +	return __htab_lookup(map, key, sizeof(u64));
> >> +}
> >> +
> >>  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
> >>  {
> >>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
> >> @@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
> >>  
> >>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
> >>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
> >> -	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> >> +	if (map->key_size == sizeof(u32))
> >> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
> >> +	else if (map->key_size == sizeof(u64))
> >> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
> >> +	else
> >> +		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> > 
> > I am trying to remember why I didn't do this when I was touching this
> > code, I was definitely thinking about it... Given your changes,
> > it is worth to approach xxh3 again, it works way better for bigger key
> > sizes, see [1].
> > 
> >   [1] https://archive.fosdem.org/2023/schedule/event/bpf_hashing/
> > 
> > 
> Let me try to run the benchmark. Did you use an actual xxh3 (not
> available in kernel) or xxh32/xxh64?> 

The actual xxh3. For small keys xxh3 was really fragile (the hash was
outperforming in hash-only benchmarks, but was not that good when used in the
hashmap), so I ended up only patching code to use jhash2. For keys >=20,
I think, xxh3 becomes definitely better for all benchmarks. One further note:
the original xxh3 uses vectorized instructions for keys >=240 and for such keys
the fastest ist xxh64. (Well, for keys >5-6K the spooky hash was the best,
but are there any such use cases?)

For the code, I've used my own kernel port of xxh3. The XXH3 also uses a
key-size-based switch internally, so for generated lookups something like
xxh3_17_to_128 can be used specifically. Unfortanetely, I am not sure
what was the latest version I had... You can find one here:

  https://github.com/aspsk/bpf-next/commit/e86be3c926051ee87375da4f0df4b873d2f7e9c2

(notably see xxh3_17_to_128() and xxh3_129_to_240()). The code should work,
but definitely needs some love, maybe it's easier to re-import it using
modern tools.

> >>  	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
> >>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
> >>  				offsetof(struct htab_elem, key) +
> >>
> >> ---
> >> base-commit: 6e1ac8758fcd07bee12ccaff0087cc66930a4187
> >> change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e
> >>
> >> Best regards,
> >> --  
> >> Mykyta Yatsenko <yatsenko@meta.com>
> >>
> 
