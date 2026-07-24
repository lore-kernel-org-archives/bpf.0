Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917911DE4F1
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898666; cv=none; b=BHDdH25QTzQJZWZyNAZDf2jlJCB8nBvrsxnQvjMQxU5eWArkpjVMwnierJE90xQbOAHeXIJ7B4JaXyBym9/jnxx+JCnMwZGTbDrgyymxAtl+D+IaBxnrFS/HjXvUgeSZjnz8Mt7ENLrzYbzKgdW46NC2Onkx286EgYIrFyKXIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898666; c=relaxed/simple;
	bh=fVbWrUtKy6/QpfBED80HKudYiQIsRHoDhIk1p6C4zMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfe/l2vpYvwyLuwqxAYkPosJYGi64AIvjcJsd4Csj5EIibJyqZnx7aNV10STGdnwxPi2lAslsDFWE1ZSjYht5pgV/BcaPDfsLu6lVwEzn61c5rb6XPGhGX0MZVIpagXXnQ+GO1g8a7qXBT5TCIV4+BOEkkijO+wfcDX4PtyRJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afwyQedy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afwyQedy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so2603625e9.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784898661; x=1785503461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/eE/JzCP7wUM3CT6NO0uG/BNzOb/HJD6NouPRH8kR8=;
        b=afwyQedyPAUCuRr/EhUG8vCpx5kRuyLSSdkR23UbZ2cWYU/cm9NojDymI1GRWsjaA1
         1v2Zy33w4vfD94Fn0XMlFLsrQcuFu5qCTXoqD2todZBY0KnSSdt8SMni6f1LJIlcEN7r
         IYnpjS8bGzrc/qckysYfZ6AuYq6zMYdQhE43bTsvG6mA7MHg79e+9HcrZCcPRafNPIBg
         lvIc02KhfZNdDiAq84yv1o8Dth4XzYylm0zlJM+dBXSUzzmymREh5W1GC0DRr4VkJQA0
         UyxPbMvNxFsqrhvaJHGKXFdwcjotAJQxYrYb8O3qw91KTItad/Z7ePN/iZC74pFw+3BR
         4G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784898661; x=1785503461;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/eE/JzCP7wUM3CT6NO0uG/BNzOb/HJD6NouPRH8kR8=;
        b=V7wY0Bg5QhDYKJVSRibdHZ9R6Mm2p7H2Q5AD8kAtEsUgUk0lUxpzcnURTBiQ1KHyY4
         OCRV3EGsWV+JwNl2ofg4ZCvLl/ZhB7fjVfc6k1qqkEuiDIDr9CqxTtp7MPkPPO20DXNm
         ZuvWXWI4ZmkOYg8mYltJMyDetvIZJj1ztKKy0BPTwcOG09h9sexZErccvTejw0owBeDQ
         FOaN4DRHXcfgV1GHGU/xstHcW/nXRHamS3zCASMAzC+MwtsyFDuN6y3EmOKsl6RETky9
         WuTZzKJU3MWZhLO7ks2wA9+m8BR08OdieUXpbSrgApAuflOG1rPnXGrR2vRIfiWMi1/f
         dLkA==
X-Forwarded-Encrypted: i=1; AHgh+RoJjCh80rvlnaXZmwztY1dG8lCz5AfP4XvzIC8UxgWJyqbKkkSETtDvLF0Ph+xYLeItokY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve4v83X9hFFMyDH1VQEd/f79zeJZtGJ7VjDPZc/RpdWYrdf8S
	Tk41+iygq51CuAz8IKuP3fzh/UTf+jdi2y2Wm+pY0qQbF/iNZ8wPUKlS
X-Gm-Gg: AR+sD12aRhcgJJsw6zzTF5Qf88T9PMtTzBylGnizDt1JiUDHghnbGTYHlOmzJ+scqHh
	cpUpOHZUSzEAZNuj3wvsWuw++epeidiqgRP/OijYuJlFnZ76K6PbSTc+FzTZqG2E9feFNwR3b9n
	myGypVod+0rlos8pF3TPPXIQ0Kh29Ml12xWJ/b1JLuekstl5x+sTWGp4W86Ywx/PjzAR697hPg0
	jqF9rXPENencZuND2vnTDaL8OiO79GIjBEgWI63NwI7+TwXAjuJnbTog6kfmtMtPmpAYxRC5MM2
	r87HfS8/f4cMBJJEdqVbAFoS9p0R1IV8psTzMFnqi1cENKHeC/kwjQvZ+8YLYTu5zIOsZNVP6BM
	fDFUln192W7vr5RfBATHq7PyxMawwanhBI4g6TkgmO82BxeyKtSDFrM5eFvMHqi+xSWq6PRC92s
	np1l+1AeZZdFR40lGt0j+AZVqV9wOJ8p525fQtJgICxalTE29JaZMih4ZUk2jSB5Pv0y7kejvQ
X-Received: by 2002:a05:600c:19ca:b0:495:665d:75df with SMTP id 5b1f17b1804b1-49573cd8890mr99511605e9.23.1784898660265;
        Fri, 24 Jul 2026 06:11:00 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f5665f0sm33762075e9.0.2026.07.24.06.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 06:10:59 -0700 (PDT)
Message-ID: <9155bd29-c27e-4c1f-87e9-d712d6454544@gmail.com>
Date: Fri, 24 Jul 2026 14:10:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bpf: htab: Split htab_elem_lru and htab_elem_pcpu off
 of htab_elem
To: "T.J. Mercier" <tjmercier@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260722203801.1854941-1-tjmercier@google.com>
 <20260722203801.1854941-2-tjmercier@google.com>
 <c611f7ab-b1e1-4581-85c7-84931b9b1afb@gmail.com>
 <CABdmKX0nvFoF2PfXXBURvwdcabm6E=exnf-i2j+zZcaoqURtTA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CABdmKX0nvFoF2PfXXBURvwdcabm6E=exnf-i2j+zZcaoqURtTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/26 6:26 PM, T.J. Mercier wrote:
> On Thu, Jul 23, 2026 at 7:11 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> On 7/22/26 9:38 PM, T.J. Mercier wrote:
>>> The htab_elem struct is used as the per-element type for all BPF hash
>>> map types and includes bpf_lru_node in a union with a ptr_to_pptr
>>> pointer. For standard (non-LRU, non-PCPU) hash maps, the 24 byte union
>>> allocated for every element is entirely unused. For non-preallocated
>>> PCPU maps, ptr_to_pptr only requires 8 bytes, leaving 16 bytes of unused
>>> overhead in the union. For preallocated PCPU maps ptr_to_pptr is unused
>>> since elements are freed to the PCPU freelist.
>>>
>>> Eliminate this per-element memory overhead by splitting htab_elem into
>>> dedicated structures for each map type:
>>>    - struct htab_elem: Minimal structure for standard hash maps and
>>>      preallocated PCPU maps (saves 24 bytes per element).
>>>    - struct htab_elem_pcpu: Structure for non-preallocated PCPU maps
>>>      containing ptr_to_pptr (saves 16 bytes per element).
>>>    - struct htab_elem_lru: Retains struct bpf_lru_node for LRU maps.
>>>
>>> Because element sizes now vary by map type, add key_offset to struct
>>> bpf_htab to track the dynamic key offset. Update helper accessors and
>>> lookups to compute key and value offsets using htab->key_offset.
>>>
>>> Pointers to struct htab_elem in the existing code (e.g. htab_elem_hash)
>>> serve as generic base element pointers. This is possible because
>>> htab_elem, htab_elem_pcpu, and htab_elem_lru share a common initial
>>> sequence, making pointer casts safe.
>>>
>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>>> ---
>>>  kernel/bpf/hashtab.c    | 318 +++++++++++++++++++++++++++-------------
>>>  kernel/bpf/map_in_map.c |  13 ++
>>>  kernel/bpf/map_in_map.h |   2 +
>>>  3 files changed, 234 insertions(+), 99 deletions(-)
>>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 9f394e1aa2e8..57729c3dff3d 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -102,6 +102,7 @@ struct bpf_htab {
>>>       bool use_percpu_counter;
>>>       u32 n_buckets;  /* number of hash buckets */
>>>       u32 elem_size;  /* size of each element in bytes */
>>> +     u32 key_offset; /* offset of key in bytes */
>>>       u32 hashrnd;
>>>  };
>>>
>>> @@ -117,14 +118,41 @@ struct htab_elem {
>>>                       };
>>>               };
>>>       };
>>> +     u32 hash;
>>> +} __aligned(8);
>>> +
>>> +struct htab_elem_lru {
>>>       union {
>>> -             /* pointer to per-cpu pointer */
>>> -             void *ptr_to_pptr;
>>> -             struct bpf_lru_node lru_node;
>>> +             struct hlist_nulls_node hash_node;
>>> +             struct {
>>> +                     void *padding;
>>> +                     union {
>>> +                             struct pcpu_freelist_node fnode;
>>> +                             struct htab_elem_lru *batch_flink;
>>> +                     };
>>> +             };
>>>       };
>>> +     struct bpf_lru_node lru_node;
>>>       u32 hash;
>>> -     char key[] __aligned(8);
>>> -};
>>> +} __aligned(8);
>>> +
>>> +/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
>>> + * ptr_to_pptr, and use htab_elem.
>>> + */
>>> +struct htab_elem_pcpu {
>>> +     union {
>>> +             struct hlist_nulls_node hash_node;
>>> +             struct {
>>> +                     void *padding;
>>> +                     union {
>>> +                             struct pcpu_freelist_node fnode;
>>> +                             struct htab_elem_pcpu *batch_flink;
>>> +                     };
>>> +             };
>>> +     };
>>
>> Will it make the code more readable if we move this common part into a separate
>> struct (keep the name htab_elem to minimise the change) and reuse it across
>> different variants: htab_elem_standard/htab_elem_pcpu/htab_elem_lru. This will allow removing
>> those BUILD_BUG_ON() and be explicit about the comon part of the layout.
> 
> I'll do that. It'll definitely save some lines.
> 
>>> +     void *ptr_to_pptr;
>>> +     u32 hash;
>>
>> We can remove u32 hash field and instead add dynamic
>> array `u8 data[] __aligned(8);` that going to store the same layout.
>> I think that buys us clearer definition of dynamic
>> section of the structure that has different layout depending on the key size.
> 
> That sounds good to me, but what do you think about keeping `char
> key[] __aligned(8);` in patch 1, and then replacing both `hash` and
> `key[]` with `u8 data[] __aligned(8);` in patch 2? In patch 1 all
> element types still have and use `hash` fields.
> 
> 

Sounds good.

> 
>>
>>> +} __aligned(8);
>>>
>>>  struct htab_btf_record {
>>>       struct btf_record *record;
>>> @@ -136,6 +164,21 @@ static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>>>       return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
>>>  }
>>>
>> ...
>>> @@ -428,6 +494,25 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>>>       BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
>>>                    offsetof(struct htab_elem, hash_node.pprev));
>>>
>>> +     /* htab_elem pointers are used as base pointers for htab_elem_lru and
>>> +      * htab_elem_pcpu. These structures must share a common initial sequence
>>> +      * to ensure pointer casting between them is safe.
>>> +      */
>>> +     BUILD_BUG_ON(offsetof(struct htab_elem, hash_node) !=
>>> +                  offsetof(struct htab_elem_lru, hash_node));
>>> +     BUILD_BUG_ON(offsetof(struct htab_elem, hash_node) !=
>>> +                  offsetof(struct htab_elem_pcpu, hash_node));
>>> +
>>> +     BUILD_BUG_ON(offsetof(struct htab_elem, padding) !=
>>> +                  offsetof(struct htab_elem_lru, padding));
>>> +     BUILD_BUG_ON(offsetof(struct htab_elem, padding) !=
>>> +                  offsetof(struct htab_elem_pcpu, padding));
>>> +
>>> +     BUILD_BUG_ON(offsetof(struct htab_elem, fnode) !=
>>> +                  offsetof(struct htab_elem_lru, fnode));
>>> +     BUILD_BUG_ON(offsetof(struct htab_elem, fnode) !=
>>> +                  offsetof(struct htab_elem_pcpu, fnode));
>>> +
>>>       if (zero_seed && !capable(CAP_SYS_ADMIN))
>>>               /* Guard against local DoS, and discourage production use. */
>>>               return -EPERM;
>>> @@ -476,7 +561,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
>>>       if (IS_ERR_OR_NULL(hrec->record))
>>>               return;
>>>
>>> -     map_value = htab_elem_value(elem, hrec->key_size);
>>> +     map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
>>>       bpf_obj_free_fields(hrec->record, map_value);
>>>  }
>>>
>>> @@ -583,8 +668,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>>
>>>       htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
>>>
>>> -     htab->elem_size = sizeof(struct htab_elem) +
>>> -                       round_up(htab->map.key_size, 8);
>>> +     if (htab_is_lru(htab))
>>> +             htab->key_offset = sizeof(struct htab_elem_lru);
>>> +     else if (percpu && !prealloc)
>>> +             htab->key_offset = sizeof(struct htab_elem_pcpu);
>>> +     else
>>> +             htab->key_offset = sizeof(struct htab_elem);
>>> +
>>> +     htab->elem_size = htab->key_offset + round_up(htab->map.key_size, 8);
>>>       if (percpu)
>>>               htab->elem_size += sizeof(void *);
>>>       else
>>> @@ -692,14 +783,16 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
>>>  }
>>>
>>>  /* this lookup function can only be called with bucket lock taken */
>>> -static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
>>> +static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
>>> +                                      struct hlist_nulls_head *head, u32 hash,
>>>                                        void *key, u32 key_size)
>>>  {
>>>       struct hlist_nulls_node *n;
>>>       struct htab_elem *l;
>>>
>>>       hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>>> -             if (l->hash == hash && !memcmp(&l->key, key, key_size))
>>> +             if (htab_elem_hash(htab, l) == hash &&
>>> +                 !memcmp(htab_elem_key(htab, l), key, key_size))
>>>                       return l;
>>>
>>>       return NULL;
>>> @@ -709,7 +802,8 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
>>>   * the unlikely event when elements moved from one bucket into another
>>>   * while link list is being walked
>>>   */
>>> -static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>>> +static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
>>> +                                            struct hlist_nulls_head *head,
>>>                                              u32 hash, void *key,
>>>                                              u32 key_size, u32 n_buckets)
>>>  {
>>> @@ -718,7 +812,8 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>>>
>>>  again:
>>>       hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>>> -             if (l->hash == hash && !memcmp(&l->key, key, key_size))
>>> +             if (htab_elem_hash(htab, l) == hash &&
>>> +                 !memcmp(htab_elem_key(htab, l), key, key_size))
>>>                       return l;
>>>
>>>       if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
>>> @@ -747,17 +842,18 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>
>>>       head = select_bucket(htab, hash);
>>>
>>> -     l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
>>> +     l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
>>>
>>>       return l;
>>>  }
>>>
>>>  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>>
>>>       if (l)
>>> -             return htab_elem_value(l, map->key_size);
>>> +             return htab_elem_value(htab, l);
>>>
>>>       return NULL;
>>>  }
>>> @@ -775,6 +871,7 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
>>>   */
>>>  static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct bpf_insn *insn = insn_buf;
>>>       const int ret = BPF_REG_0;
>>>
>>> @@ -783,7 +880,7 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>>       *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>>>       *insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>>>       *insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>>> -                             offsetof(struct htab_elem, key) +
>>> +                             htab->key_offset +
>>>                               round_up(map->key_size, 8));
>>>       return insn - insn_buf;
>>>  }
>>> @@ -791,12 +888,13 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>>  static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
>>>                                                       void *key, const bool mark)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>>
>>>       if (l) {
>>>               if (mark)
>>> -                     bpf_lru_node_set_ref(&l->lru_node);
>>> -             return htab_elem_value(l, map->key_size);
>>> +                     bpf_lru_node_set_ref(htab_elem_lru_node(l));
>>> +             return htab_elem_value(htab, l);
>>>       }
>>>
>>>       return NULL;
>>> @@ -815,6 +913,7 @@ static void *htab_lru_map_lookup_elem_sys(struct bpf_map *map, void *key)
>>>  static int htab_lru_map_gen_lookup(struct bpf_map *map,
>>>                                  struct bpf_insn *insn_buf)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct bpf_insn *insn = insn_buf;
>>>       const int ret = BPF_REG_0;
>>>       const int ref_reg = BPF_REG_1;
>>> @@ -824,15 +923,15 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
>>>       *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>>>       *insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
>>>       *insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret,
>>> -                           offsetof(struct htab_elem, lru_node) +
>>> +                           offsetof(struct htab_elem_lru, lru_node) +
>>>                             offsetof(struct bpf_lru_node, ref));
>>>       *insn++ = BPF_JMP_IMM(BPF_JNE, ref_reg, 0, 1);
>>>       *insn++ = BPF_ST_MEM(BPF_B, ret,
>>> -                          offsetof(struct htab_elem, lru_node) +
>>> +                          offsetof(struct htab_elem_lru, lru_node) +
>>>                            offsetof(struct bpf_lru_node, ref),
>>>                            1);
>>>       *insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>>> -                             offsetof(struct htab_elem, key) +
>>> +                             htab->key_offset +
>>>                               round_up(map->key_size, 8));
>>>       return insn - insn_buf;
>>>  }
>>> @@ -844,13 +943,13 @@ static void check_and_cancel_fields(struct bpf_htab *htab,
>>>               return;
>>>
>>>       if (htab_is_percpu(htab)) {
>>> -             void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
>>> +             void __percpu *pptr = htab_elem_get_ptr(htab, elem);
>>>               int cpu;
>>>
>>>               for_each_possible_cpu(cpu)
>>>                       bpf_obj_cancel_fields(&htab->map, per_cpu_ptr(pptr, cpu));
>>>       } else {
>>> -             void *map_value = htab_elem_value(elem, htab->map.key_size);
>>> +             void *map_value = htab_elem_value(htab, elem);
>>>
>>>               bpf_obj_cancel_fields(&htab->map, map_value);
>>>       }
>>> @@ -869,8 +968,8 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>>>       struct bucket *b;
>>>       int ret;
>>>
>>> -     tgt_l = container_of(node, struct htab_elem, lru_node);
>>> -     b = __select_bucket(htab, tgt_l->hash);
>>> +     tgt_l = (struct htab_elem *)container_of(node, struct htab_elem_lru, lru_node);
>>> +     b = __select_bucket(htab, htab_elem_hash(htab, tgt_l));
>>>       head = &b->head;
>>>
>>>       ret = htab_lock_bucket(b, &flags);
>>> @@ -912,7 +1011,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>>       head = select_bucket(htab, hash);
>>>
>>>       /* lookup the key */
>>> -     l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
>>> +     l = lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab->n_buckets);
>>>
>>>       if (!l)
>>>               goto find_first_elem;
>>> @@ -923,7 +1022,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>>
>>>       if (next_l) {
>>>               /* if next elem in this hash list is non-zero, just return it */
>>> -             memcpy(next_key, next_l->key, key_size);
>>> +             memcpy(next_key, htab_elem_key(htab, next_l), key_size);
>>>               return 0;
>>>       }
>>>
>>> @@ -941,7 +1040,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>>                                         struct htab_elem, hash_node);
>>>               if (next_l) {
>>>                       /* if it's not empty, just return it */
>>> -                     memcpy(next_key, next_l->key, key_size);
>>> +                     memcpy(next_key, htab_elem_key(htab, next_l), key_size);
>>>                       return 0;
>>>               }
>>>       }
>>> @@ -955,7 +1054,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
>>>       check_and_cancel_fields(htab, l);
>>>
>>>       if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
>>> -             bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
>>> +             bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_pptr(l));
>>>       bpf_mem_cache_free(&htab->ma, l);
>>>  }
>>>
>>> @@ -965,7 +1064,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
>>>       void *ptr;
>>>
>>>       if (map->ops->map_fd_put_ptr) {
>>> -             ptr = fd_htab_map_get_ptr(map, l);
>>> +             ptr = fd_htab_map_get_ptr(htab, l);
>>>               map->ops->map_fd_put_ptr(map, ptr, true);
>>>       }
>>>  }
>>> @@ -1117,10 +1216,10 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>>>               }
>>>       }
>>>
>>> -     memcpy(l_new->key, key, key_size);
>>> +     memcpy(htab_elem_key(htab, l_new), key, key_size);
>>>       if (percpu) {
>>>               if (prealloc) {
>>> -                     pptr = htab_elem_get_ptr(l_new, key_size);
>>> +                     pptr = htab_elem_get_ptr(htab, l_new);
>>>               } else {
>>>                       /* alloc_percpu zero-fills */
>>>                       void *ptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
>>> @@ -1130,26 +1229,26 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>>>                               l_new = ERR_PTR(-ENOMEM);
>>>                               goto dec_count;
>>>                       }
>>> -                     l_new->ptr_to_pptr = ptr;
>>> +                     htab_elem_set_ptr_to_pptr(l_new, ptr);
>>>                       pptr = *(void __percpu **)ptr;
>>>               }
>>>
>>>               pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
>>>
>>>               if (!prealloc)
>>> -                     htab_elem_set_ptr(l_new, key_size, pptr);
>>> +                     htab_elem_set_ptr(htab, l_new, pptr);
>>>       } else if (fd_htab_map_needs_adjust(htab)) {
>>>               size = round_up(size, 8);
>>> -             memcpy(htab_elem_value(l_new, key_size), value, size);
>>> +             memcpy(htab_elem_value(htab, l_new), value, size);
>>>       } else if (map_flags & BPF_F_LOCK) {
>>>               copy_map_value_locked(&htab->map,
>>> -                                   htab_elem_value(l_new, key_size),
>>> +                                   htab_elem_value(htab, l_new),
>>>                                     value, false);
>>>       } else {
>>> -             copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
>>> +             copy_map_value(&htab->map, htab_elem_value(htab, l_new), value);
>>>       }
>>>
>>> -     l_new->hash = hash;
>>> +     htab_elem_set_hash(htab, l_new, hash);
>>>       return l_new;
>>>  dec_count:
>>>       dec_elem_count(htab);
>>> @@ -1199,7 +1298,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>               if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
>>>                       return -EINVAL;
>>>               /* find an element without taking the bucket lock */
>>> -             l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
>>> +             l_old = lookup_nulls_elem_raw(htab, head, hash, key, key_size,
>>>                                             htab->n_buckets);
>>>               ret = check_flags(htab, l_old, map_flags);
>>>               if (ret)
>>> @@ -1207,7 +1306,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>               if (l_old) {
>>>                       /* grab the element lock and update value in place */
>>>                       copy_map_value_locked(map,
>>> -                                           htab_elem_value(l_old, key_size),
>>> +                                           htab_elem_value(htab, l_old),
>>>                                             value, false);
>>>                       return 0;
>>>               }
>>> @@ -1221,7 +1320,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>       if (ret)
>>>               return ret;
>>>
>>> -     l_old = lookup_elem_raw(head, hash, key, key_size);
>>> +     l_old = lookup_elem_raw(htab, head, hash, key, key_size);
>>>
>>>       ret = check_flags(htab, l_old, map_flags);
>>>       if (ret)
>>> @@ -1235,7 +1334,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>                * and update element in place
>>>                */
>>>               copy_map_value_locked(map,
>>> -                                   htab_elem_value(l_old, key_size),
>>> +                                   htab_elem_value(htab, l_old),
>>>                                     value, false);
>>>               ret = 0;
>>>               goto err;
>>> @@ -1275,7 +1374,7 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>>>  {
>>>       check_and_cancel_fields(htab, elem);
>>>       bpf_map_dec_elem_count(&htab->map);
>>> -     bpf_lru_push_free(&htab->lru, &elem->lru_node);
>>> +     bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
>>>  }
>>>
>>>  static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
>>> @@ -1310,13 +1409,13 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>>>       l_new = prealloc_lru_pop(htab, key, hash);
>>>       if (!l_new)
>>>               return -ENOMEM;
>>> -     copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size), value);
>>> +     copy_map_value(&htab->map, htab_elem_value(htab, l_new), value);
>>>
>>>       ret = htab_lock_bucket(b, &flags);
>>>       if (ret)
>>>               goto err_lock_bucket;
>>>
>>> -     l_old = lookup_elem_raw(head, hash, key, key_size);
>>> +     l_old = lookup_elem_raw(htab, head, hash, key, key_size);
>>>
>>>       ret = check_flags(htab, l_old, map_flags);
>>>       if (ret)
>>> @@ -1327,7 +1426,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>>>        */
>>>       hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>>       if (l_old) {
>>> -             bpf_lru_node_set_ref(&l_new->lru_node);
>>> +             bpf_lru_node_set_ref(htab_elem_lru_node(l_new));
>>>               hlist_nulls_del_rcu(&l_old->hash_node);
>>>       }
>>>       ret = 0;
>>> @@ -1383,7 +1482,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>>>       if (ret)
>>>               return ret;
>>>
>>> -     l_old = lookup_elem_raw(head, hash, key, key_size);
>>> +     l_old = lookup_elem_raw(htab, head, hash, key, key_size);
>>>
>>>       ret = check_flags(htab, l_old, map_flags);
>>>       if (ret)
>>> @@ -1392,10 +1491,10 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>>>       if (l_old) {
>>>               /* Update value in-place */
>>>               if (percpu) {
>>> -                     pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>>> +                     pcpu_copy_value(htab, htab_elem_get_ptr(htab, l_old),
>>>                                       value, onallcpus, map_flags);
>>>               } else {
>>> -                     void **inner_map_pptr = htab_elem_value(l_old, key_size);
>>> +                     void **inner_map_pptr = htab_elem_value(htab, l_old);
>>>
>>>                       old_map_ptr = *inner_map_pptr;
>>>                       WRITE_ONCE(*inner_map_pptr, *(void **)value);
>>> @@ -1456,20 +1555,20 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>>       if (ret)
>>>               goto err_lock_bucket;
>>>
>>> -     l_old = lookup_elem_raw(head, hash, key, key_size);
>>> +     l_old = lookup_elem_raw(htab, head, hash, key, key_size);
>>>
>>>       ret = check_flags(htab, l_old, map_flags);
>>>       if (ret)
>>>               goto err;
>>>
>>>       if (l_old) {
>>> -             bpf_lru_node_set_ref(&l_old->lru_node);
>>> +             bpf_lru_node_set_ref(htab_elem_lru_node(l_old));
>>>
>>>               /* per-cpu hash map can update value in-place */
>>> -             pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
>>> +             pcpu_copy_value(htab, htab_elem_get_ptr(htab, l_old),
>>>                               value, onallcpus, map_flags);
>>>       } else {
>>> -             pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
>>> +             pcpu_init_value(htab, htab_elem_get_ptr(htab, l_new),
>>>                               value, onallcpus, map_flags);
>>>               hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>>               l_new = NULL;
>>> @@ -1480,7 +1579,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>>  err_lock_bucket:
>>>       if (l_new) {
>>>               bpf_map_dec_elem_count(&htab->map);
>>> -             bpf_lru_push_free(&htab->lru, &l_new->lru_node);
>>> +             bpf_lru_push_free(&htab->lru, htab_elem_lru_node(l_new));
>>>       }
>>>       return ret;
>>>  }
>>> @@ -1521,7 +1620,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
>>>       if (ret)
>>>               return ret;
>>>
>>> -     l = lookup_elem_raw(head, hash, key, key_size);
>>> +     l = lookup_elem_raw(htab, head, hash, key, key_size);
>>>       if (l)
>>>               hlist_nulls_del_rcu(&l->hash_node);
>>>       else
>>> @@ -1556,7 +1655,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
>>>       if (ret)
>>>               return ret;
>>>
>>> -     l = lookup_elem_raw(head, hash, key, key_size);
>>> +     l = lookup_elem_raw(htab, head, hash, key, key_size);
>>>
>>>       if (l)
>>>               hlist_nulls_del_rcu(&l->hash_node);
>>> @@ -1602,7 +1701,7 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
>>>               hlist_nulls_for_each_entry(l, n, head, hash_node) {
>>>                       /* We only free internal structs on uref dropping to zero */
>>>                       bpf_map_free_internal_structs(&htab->map,
>>> -                                                   htab_elem_value(l, htab->map.key_size));
>>> +                                                   htab_elem_value(htab, l));
>>>               }
>>>               cond_resched_rcu();
>>>       }
>>> @@ -1697,7 +1796,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
>>>       if (ret)
>>>               return ret;
>>>
>>> -     l = lookup_elem_raw(head, hash, key, key_size);
>>> +     l = lookup_elem_raw(htab, head, hash, key, key_size);
>>>       if (!l) {
>>>               ret = -ENOENT;
>>>               goto out_unlock;
>>> @@ -1708,14 +1807,14 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
>>>               void __percpu *pptr;
>>>               int off = 0, cpu;
>>>
>>> -             pptr = htab_elem_get_ptr(l, key_size);
>>> +             pptr = htab_elem_get_ptr(htab, l);
>>>               for_each_possible_cpu(cpu) {
>>>                       copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
>>>                       check_and_init_map_value(&htab->map, value + off);
>>>                       off += roundup_value_size;
>>>               }
>>>       } else {
>>> -             void *src = htab_elem_value(l, map->key_size);
>>> +             void *src = htab_elem_value(htab, l);
>>>
>>>               if (flags & BPF_F_LOCK)
>>>                       copy_map_value_locked(map, value, src, true);
>>> @@ -1898,13 +1997,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>>               goto next_batch;
>>>
>>>       hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>>> -             memcpy(dst_key, l->key, key_size);
>>> +             memcpy(dst_key, htab_elem_key(htab, l), key_size);
>>>
>>>               if (is_percpu) {
>>>                       int off = 0, cpu;
>>>                       void __percpu *pptr;
>>>
>>> -                     pptr = htab_elem_get_ptr(l, map->key_size);
>>> +                     pptr = htab_elem_get_ptr(htab, l);
>>>                       if (elem_map_flags & BPF_F_CPU) {
>>>                               cpu = elem_map_flags >> 32;
>>>                               copy_map_value(&htab->map, dst_val, per_cpu_ptr(pptr, cpu));
>>> @@ -1918,7 +2017,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>>                               }
>>>                       }
>>>               } else {
>>> -                     value = htab_elem_value(l, key_size);
>>> +                     value = htab_elem_value(htab, l);
>>>                       if (is_fd_htab(htab)) {
>>>                               struct bpf_map **inner_map = value;
>>>
>>> @@ -2183,12 +2282,12 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
>>>               ctx.meta = &meta;
>>>               ctx.map = info->map;
>>>               if (elem) {
>>> -                     ctx.key = elem->key;
>>> +                     ctx.key = htab_elem_key(info->htab, elem);
>>>                       if (!info->percpu_value_buf) {
>>> -                             ctx.value = htab_elem_value(elem, map->key_size);
>>> +                             ctx.value = htab_elem_value(info->htab, elem);
>>>                       } else {
>>>                               roundup_value_size = round_up(map->value_size, 8);
>>> -                             pptr = htab_elem_get_ptr(elem, map->key_size);
>>> +                             pptr = htab_elem_get_ptr(info->htab, elem);
>>>                               for_each_possible_cpu(cpu) {
>>>                                       copy_map_value_long(map, info->percpu_value_buf + off,
>>>                                                           per_cpu_ptr(pptr, cpu));
>>> @@ -2293,13 +2392,13 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
>>>               rcu_read_lock();
>>>               head = &b->head;
>>>               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
>>> -                     key = elem->key;
>>> +                     key = htab_elem_key(htab, elem);
>>>                       if (is_percpu) {
>>>                               /* current cpu value for percpu map */
>>> -                             pptr = htab_elem_get_ptr(elem, map->key_size);
>>> +                             pptr = htab_elem_get_ptr(htab, elem);
>>>                               val = this_cpu_ptr(pptr);
>>>                       } else {
>>> -                             val = htab_elem_value(elem, map->key_size);
>>> +                             val = htab_elem_value(htab, elem);
>>>                       }
>>>                       num_elems++;
>>>                       ret = callback_fn((u64)(long)map, (u64)(long)key,
>>> @@ -2403,10 +2502,11 @@ const struct bpf_map_ops htab_lru_map_ops = {
>>>  /* Called from eBPF program */
>>>  static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>>
>>>       if (l)
>>> -             return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
>>> +             return this_cpu_ptr(htab_elem_get_ptr(htab, l));
>>>       else
>>>               return NULL;
>>>  }
>>> @@ -2414,6 +2514,7 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>>>  /* inline bpf_map_lookup_elem() call for per-CPU hashmap */
>>>  static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct bpf_insn *insn = insn_buf;
>>>
>>>       if (!bpf_jit_supports_percpu_insn())
>>> @@ -2424,7 +2525,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
>>>       *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>>>       *insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
>>>       *insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
>>> -                             offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
>>> +                             htab->key_offset + roundup(map->key_size, 8));
>>>       *insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
>>>       *insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>>>
>>> @@ -2433,6 +2534,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
>>>
>>>  static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l;
>>>
>>>       if (cpu >= nr_cpu_ids)
>>> @@ -2440,18 +2542,19 @@ static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key,
>>>
>>>       l = __htab_map_lookup_elem(map, key);
>>>       if (l)
>>> -             return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
>>> +             return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
>>>       else
>>>               return NULL;
>>>  }
>>>
>>>  static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l = __htab_map_lookup_elem(map, key);
>>>
>>>       if (l) {
>>> -             bpf_lru_node_set_ref(&l->lru_node);
>>> -             return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
>>> +             bpf_lru_node_set_ref(htab_elem_lru_node(l));
>>> +             return this_cpu_ptr(htab_elem_get_ptr(htab, l));
>>>       }
>>>
>>>       return NULL;
>>> @@ -2459,6 +2562,7 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>>>
>>>  static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l;
>>>
>>>       if (cpu >= nr_cpu_ids)
>>> @@ -2466,8 +2570,8 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
>>>
>>>       l = __htab_map_lookup_elem(map, key);
>>>       if (l) {
>>> -             bpf_lru_node_set_ref(&l->lru_node);
>>> -             return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
>>> +             bpf_lru_node_set_ref(htab_elem_lru_node(l));
>>> +             return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
>>>       }
>>>
>>>       return NULL;
>>> @@ -2475,6 +2579,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
>>>
>>>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l;
>>>       void __percpu *pptr;
>>>       int ret = -ENOENT;
>>> @@ -2494,7 +2599,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_fl
>>>       /* We do not mark LRU map element here in order to not mess up
>>>        * eviction heuristics when user space does a map walk.
>>>        */
>>> -     pptr = htab_elem_get_ptr(l, map->key_size);
>>> +     pptr = htab_elem_get_ptr(htab, l);
>>>       if (map_flags & BPF_F_CPU) {
>>>               cpu = map_flags >> 32;
>>>               copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
>>> @@ -2532,6 +2637,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>>>  static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
>>>                                         struct seq_file *m)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct htab_elem *l;
>>>       void __percpu *pptr;
>>>       int cpu;
>>> @@ -2546,7 +2652,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
>>>
>>>       btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
>>>       seq_puts(m, ": {\n");
>>> -     pptr = htab_elem_get_ptr(l, map->key_size);
>>> +     pptr = htab_elem_get_ptr(htab, l);
>>>       for_each_possible_cpu(cpu) {
>>>               seq_printf(m, "\tcpu%d: ", cpu);
>>>               btf_type_seq_show(map->btf, map->btf_value_type_id,
>>> @@ -2620,7 +2726,7 @@ static void fd_htab_map_free(struct bpf_map *map)
>>>               head = select_bucket(htab, i);
>>>
>>>               hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>>> -                     void *ptr = fd_htab_map_get_ptr(map, l);
>>> +                     void *ptr = fd_htab_map_get_ptr(htab, l);
>>>
>>>                       map->ops->map_fd_put_ptr(map, ptr, false);
>>>               }
>>> @@ -2705,6 +2811,7 @@ static void *htab_of_map_lookup_elem(struct bpf_map *map, void *key)
>>>  static int htab_of_map_gen_lookup(struct bpf_map *map,
>>>                                 struct bpf_insn *insn_buf)
>>>  {
>>> +     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>>       struct bpf_insn *insn = insn_buf;
>>>       const int ret = BPF_REG_0;
>>>
>>> @@ -2713,7 +2820,7 @@ static int htab_of_map_gen_lookup(struct bpf_map *map,
>>>       *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
>>>       *insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
>>>       *insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
>>> -                             offsetof(struct htab_elem, key) +
>>> +                             htab->key_offset +
>>>                               round_up(map->key_size, 8));
>>>       *insn++ = BPF_LDX_MEM(BPF_DW, ret, ret, 0);
>>>
>>> @@ -3533,3 +3640,16 @@ const struct bpf_map_ops rhtab_map_ops = {
>>>       .map_btf_id = &rhtab_map_btf_ids[0],
>>>       .iter_seq_info = &rhash_iter_seq_info,
>>>  };
>>> +
>>> +size_t bpf_htab_map_meta_size(void)
>>> +{
>>> +     return sizeof(struct bpf_htab);
>>> +}
>>> +
>>> +void bpf_htab_map_meta_init(struct bpf_map *inner_map_meta, struct bpf_map *inner_map)
>>> +{
>>> +     struct bpf_htab *inner_htab_meta = container_of(inner_map_meta, struct bpf_htab, map);
>>> +     struct bpf_htab *inner_htab = container_of(inner_map, struct bpf_htab, map);
>>> +
>>> +     inner_htab_meta->key_offset = inner_htab->key_offset;
>>> +}
>>> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
>>> index d2cbab4bdf64..b2db5d0c98be 100644
>>> --- a/kernel/bpf/map_in_map.c
>>> +++ b/kernel/bpf/map_in_map.c
>>> @@ -7,6 +7,15 @@
>>>
>>>  #include "map_in_map.h"
>>>
>>> +static bool bpf_map_type_is_htab(enum bpf_map_type type)
>>> +{
>>> +     return type == BPF_MAP_TYPE_HASH ||
>>> +            type == BPF_MAP_TYPE_PERCPU_HASH ||
>>> +            type == BPF_MAP_TYPE_LRU_HASH ||
>>> +            type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>>> +            type == BPF_MAP_TYPE_HASH_OF_MAPS;
>>> +}
>>> +
>>>  struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>>>  {
>>>       struct bpf_map *inner_map, *inner_map_meta;
>>> @@ -29,6 +38,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>>>       /* In some cases verifier needs to access beyond just base map. */
>>>       if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops)
>>>               inner_map_meta_size = sizeof(struct bpf_array);
>>> +     else if (bpf_map_type_is_htab(inner_map->map_type))
>>> +             inner_map_meta_size = bpf_htab_map_meta_size();
>>>
>>>       inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
>>>       if (!inner_map_meta)
>>> @@ -70,6 +81,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>>>               inner_array_meta->index_mask = inner_array->index_mask;
>>>               inner_array_meta->elem_size = inner_array->elem_size;
>>>               inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
>>> +     } else if (bpf_map_type_is_htab(inner_map->map_type)) {
>>> +             bpf_htab_map_meta_init(inner_map_meta, inner_map);
>>>       }
>>>       return inner_map_meta;
>>>  }
>>> diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
>>> index 7d61602354de..1edc205772d8 100644
>>> --- a/kernel/bpf/map_in_map.h
>>> +++ b/kernel/bpf/map_in_map.h
>>> @@ -15,5 +15,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
>>>                        int ufd);
>>>  void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer);
>>>  u32 bpf_map_fd_sys_lookup_elem(void *ptr);
>>> +size_t bpf_htab_map_meta_size(void);
>>> +void bpf_htab_map_meta_init(struct bpf_map *inner_map_meta, struct bpf_map *inner_map);
>>>
>>>  #endif
>>

