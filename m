Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796945A2BB
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827598; cv=pass; b=ZkmpRSrH7Q0++JnXlUhiM2llTUyVqjCVCGhlpIHL9+gdAO+ZqiWLPZ6pM7ugqw9PySJIvRLmi4I2jCFHtBBLWiSB+nKV1dGkQx/OBHnMEdOehqPP6Hiw8h3zFpLnhspyznSIw2c16BGGTtQAP3WFBcNYknZKm68WH62VZSHk1FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827598; c=relaxed/simple;
	bh=DTIaC4ipnIeoXgCXvaKX132ivkveeQhybTkk62wtUPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8B21bozFnRzjEu45S8CcuorNkEnf54JYtxWYiaI/tOhDZt0NpaFwzo2IX8gTgpZpHSUd3bxRMBrXfbtDKPonX5q0J5eYa+bhWYYm6bxKIQnOU+qVzKSLlW288flgH4FoPXzLLtY8Czb4+Qwx9Jl4r+Mjp3Tn31qYvBATrPI5BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCihUvsE; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCihUvsE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so2665e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784827591; cv=none;
        d=google.com; s=arc-20260327;
        b=rnL3r3JNSe03KHg+YTBDn/FPy6LSL9Q7uON0bwT2sFy7ZkcvkbraS3X8MB39FLPeEA
         a0dCS9BvoCa4I0UM1T4i14NkuZtzYi688J3CIK1FUi0TBGvf876KCkzO9Vo3w2DTVLA8
         C2Cw97cKPdxPzP3K8g/Wn4b3p52P9M3WglJNSVgrmOoMwzKKjvGQGrgOrwYoORykEx23
         zfpIuoh770O4a/yh9vCVuyNLyEVMszCgY4o5Z544IDw2VanSGrMC+1+lVuNtW/eMnbNA
         OdOv6pUQyAs4ECVN1H4p5OoXJLDbvdgfX6zleHpOPYFDvO9FLyWZdDZkWZV5LxH2m0S8
         yHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IiuhlpNP8jdK7zZ7aGA2hUQfe9/jJHRYXgB3kfezrak=;
        fh=myJqSAx1FOouYQuh/d+S0c81KemBJPzsn+ntFPs0y6A=;
        b=oaNdMRxpo+OFMKpgFsBr/ToZpOyops2jHLK7Y60P9RTwWoNWAfLEFKsa8rw/dLswym
         +N6ybGEPvZHk6VkF65+LW481CcqStMnTtzug5qxzmN1NbCfHrE9YlHraIC3YQDwoXvyE
         jpiBJWmMeGiAJSK+ATHK69c0wivlLMXu0rDbnAy+B1OSPIC8ovLLVagRlJt1omf6Kkv6
         zFk4RsDVhvZxjh0vh/myQaRi0v13qNi3gUsMI4Hv8S3LrihFyzXOvQ/Nx7oj2VudOx2U
         yNUQhrLf17Dgwj13m3hUOFJQouU7Zm6gZ/9smmYlxs8JXSEiusBBEceNvieDPGf/Ns+m
         yJWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784827591; x=1785432391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IiuhlpNP8jdK7zZ7aGA2hUQfe9/jJHRYXgB3kfezrak=;
        b=cCihUvsErFV+zea8VvOTb1mAXgGOokBI7GKXJ4TkkA0xHq7IOrzUC6X0S+tYghLs8L
         hsu9CqDu8ltd+C22UNV5x4KsLiWpKZESM473XHL84ymKszmiUAt4Hla3QZFGnHJbkguF
         x1jOIx5ND5lmlaUiZWsZgheQUiMzJwztnjgcz88jsH1uJ5LQ4fQrFl6ZvnMuwNsVVqeA
         L85Pao8FlMTfcJVlIbkHwdzhj7uWdG5Db7AsQJpKKtG22kBfUgl7Ok74nJj5UyPTilTh
         ApctEEOirYXHlcNlma2XkYUNM1TvSseVMoLMbay7f3qdvwefJIeylqmwbtoudGpriqUb
         gwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827591; x=1785432391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IiuhlpNP8jdK7zZ7aGA2hUQfe9/jJHRYXgB3kfezrak=;
        b=ZPzxRPIbzU4Pe8hrkc2fxClaJcCESARzsBqOsyRNUIeAB3FlwrWUbruASBo+ch+g+7
         /8ksqLyiEScZzU1CpPEJI+HDE1gVpeSDeleCu6N3ArVve50fa3tv7P0TOAeQWWZ2HA8x
         ycaAdZnj9Pwj8WrD1CWQ/oytOIW9vGJkS1QdlMZLNJnPNW0eTFCMTB6t6tmC7kaXlHI7
         k4QrFPube4wsXROvojeAoEreAdNw0t0THX3UbuGF18gDHIJHrdudVLat+yhm6v+0SOV4
         wE3mbp5MSjwtJ9Nf2Ybq7FnuG4+tiCKpg7G7uxgHeoBAnd095DkNl9VkUZLH6HybTkmJ
         2gnw==
X-Forwarded-Encrypted: i=1; AHgh+RpkaIIyC0/ohzpcbG/VsGJ8ULvCseHSduwguTwrw+i6NY57lNuZxYI6g10D5uI4wTWxtW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmY6rNAyRYPXjDQABYFgKBNud3zO9WQDPF+qASzzY+lkuvNUP
	KcLVXd0dUwj/LoKYWjJoh4qoVJcDRXiVDkohJKL2KDXyDhgTUmZoSzxI2RlRmMHuhtudJgv0set
	fZiX2HkqzaM6WEoRnQK9BKpTwX/vwWR/Pf8tN5jgO
X-Gm-Gg: AR+sD10sfwjxZY2GFrIzG/7QJ6GhrbwxBAwOql46wEWjPh6oh43xENs0R6phxuK0YOy
	awVaoYwzMLaBJ7ig+iYVu2BLh65VouZkDrKh/KvrZdLW+X3DxGeUEbhxP7d0s8E8BznnxY7kF3h
	EgFLD3G1JYGn8KCdWBj0FOs+a90FesR1pEH2rUoriuLZrZLtgLutktzRrnS58w7FmX/babK8F3B
	f4b0PmcWbWn5bVPgA2fYXMIKYPYASnZMQ374qUl9UOsNLoKIdRpAM+OFXbMPWJXRnt0FBiBWt6T
	SqaOoJSgiz0K4AAo8AReVjTRAP+mQmw5HRvau17j39/ihYDh
X-Received: by 2002:a7b:c05a:0:b0:490:ab15:b9e8 with SMTP id
 5b1f17b1804b1-4957bc978e3mr24965e9.2.1784827590640; Thu, 23 Jul 2026 10:26:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722203801.1854941-1-tjmercier@google.com>
 <20260722203801.1854941-2-tjmercier@google.com> <c611f7ab-b1e1-4581-85c7-84931b9b1afb@gmail.com>
In-Reply-To: <c611f7ab-b1e1-4581-85c7-84931b9b1afb@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 23 Jul 2026 10:26:17 -0700
X-Gm-Features: AUfX_myiLTt0ksxdDvvBQaHN7B-r9tsEAH-4Cz52azXQ05h9eGy4K5mRep1LkfU
Message-ID: <CABdmKX0nvFoF2PfXXBURvwdcabm6E=exnf-i2j+zZcaoqURtTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: htab: Split htab_elem_lru and htab_elem_pcpu off
 of htab_elem
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:11=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 7/22/26 9:38 PM, T.J. Mercier wrote:
> > The htab_elem struct is used as the per-element type for all BPF hash
> > map types and includes bpf_lru_node in a union with a ptr_to_pptr
> > pointer. For standard (non-LRU, non-PCPU) hash maps, the 24 byte union
> > allocated for every element is entirely unused. For non-preallocated
> > PCPU maps, ptr_to_pptr only requires 8 bytes, leaving 16 bytes of unuse=
d
> > overhead in the union. For preallocated PCPU maps ptr_to_pptr is unused
> > since elements are freed to the PCPU freelist.
> >
> > Eliminate this per-element memory overhead by splitting htab_elem into
> > dedicated structures for each map type:
> >    - struct htab_elem: Minimal structure for standard hash maps and
> >      preallocated PCPU maps (saves 24 bytes per element).
> >    - struct htab_elem_pcpu: Structure for non-preallocated PCPU maps
> >      containing ptr_to_pptr (saves 16 bytes per element).
> >    - struct htab_elem_lru: Retains struct bpf_lru_node for LRU maps.
> >
> > Because element sizes now vary by map type, add key_offset to struct
> > bpf_htab to track the dynamic key offset. Update helper accessors and
> > lookups to compute key and value offsets using htab->key_offset.
> >
> > Pointers to struct htab_elem in the existing code (e.g. htab_elem_hash)
> > serve as generic base element pointers. This is possible because
> > htab_elem, htab_elem_pcpu, and htab_elem_lru share a common initial
> > sequence, making pointer casts safe.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  kernel/bpf/hashtab.c    | 318 +++++++++++++++++++++++++++-------------
> >  kernel/bpf/map_in_map.c |  13 ++
> >  kernel/bpf/map_in_map.h |   2 +
> >  3 files changed, 234 insertions(+), 99 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 9f394e1aa2e8..57729c3dff3d 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -102,6 +102,7 @@ struct bpf_htab {
> >       bool use_percpu_counter;
> >       u32 n_buckets;  /* number of hash buckets */
> >       u32 elem_size;  /* size of each element in bytes */
> > +     u32 key_offset; /* offset of key in bytes */
> >       u32 hashrnd;
> >  };
> >
> > @@ -117,14 +118,41 @@ struct htab_elem {
> >                       };
> >               };
> >       };
> > +     u32 hash;
> > +} __aligned(8);
> > +
> > +struct htab_elem_lru {
> >       union {
> > -             /* pointer to per-cpu pointer */
> > -             void *ptr_to_pptr;
> > -             struct bpf_lru_node lru_node;
> > +             struct hlist_nulls_node hash_node;
> > +             struct {
> > +                     void *padding;
> > +                     union {
> > +                             struct pcpu_freelist_node fnode;
> > +                             struct htab_elem_lru *batch_flink;
> > +                     };
> > +             };
> >       };
> > +     struct bpf_lru_node lru_node;
> >       u32 hash;
> > -     char key[] __aligned(8);
> > -};
> > +} __aligned(8);
> > +
> > +/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't n=
eed
> > + * ptr_to_pptr, and use htab_elem.
> > + */
> > +struct htab_elem_pcpu {
> > +     union {
> > +             struct hlist_nulls_node hash_node;
> > +             struct {
> > +                     void *padding;
> > +                     union {
> > +                             struct pcpu_freelist_node fnode;
> > +                             struct htab_elem_pcpu *batch_flink;
> > +                     };
> > +             };
> > +     };
>
> Will it make the code more readable if we move this common part into a se=
parate
> struct (keep the name htab_elem to minimise the change) and reuse it acro=
ss
> different variants: htab_elem_standard/htab_elem_pcpu/htab_elem_lru. This=
 will allow removing
> those BUILD_BUG_ON() and be explicit about the comon part of the layout.

I'll do that. It'll definitely save some lines.

> > +     void *ptr_to_pptr;
> > +     u32 hash;
>
> We can remove u32 hash field and instead add dynamic
> array `u8 data[] __aligned(8);` that going to store the same layout.
> I think that buys us clearer definition of dynamic
> section of the structure that has different layout depending on the key s=
ize.

That sounds good to me, but what do you think about keeping `char
key[] __aligned(8);` in patch 1, and then replacing both `hash` and
`key[]` with `u8 data[] __aligned(8);` in patch 2? In patch 1 all
element types still have and use `hash` fields.



>
> > +} __aligned(8);
> >
> >  struct htab_btf_record {
> >       struct btf_record *record;
> > @@ -136,6 +164,21 @@ static inline bool htab_is_prealloc(const struct b=
pf_htab *htab)
> >       return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
> >  }
> >
> ...
> > @@ -428,6 +494,25 @@ static int htab_map_alloc_check(union bpf_attr *at=
tr)
> >       BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=3D
> >                    offsetof(struct htab_elem, hash_node.pprev));
> >
> > +     /* htab_elem pointers are used as base pointers for htab_elem_lru=
 and
> > +      * htab_elem_pcpu. These structures must share a common initial s=
equence
> > +      * to ensure pointer casting between them is safe.
> > +      */
> > +     BUILD_BUG_ON(offsetof(struct htab_elem, hash_node) !=3D
> > +                  offsetof(struct htab_elem_lru, hash_node));
> > +     BUILD_BUG_ON(offsetof(struct htab_elem, hash_node) !=3D
> > +                  offsetof(struct htab_elem_pcpu, hash_node));
> > +
> > +     BUILD_BUG_ON(offsetof(struct htab_elem, padding) !=3D
> > +                  offsetof(struct htab_elem_lru, padding));
> > +     BUILD_BUG_ON(offsetof(struct htab_elem, padding) !=3D
> > +                  offsetof(struct htab_elem_pcpu, padding));
> > +
> > +     BUILD_BUG_ON(offsetof(struct htab_elem, fnode) !=3D
> > +                  offsetof(struct htab_elem_lru, fnode));
> > +     BUILD_BUG_ON(offsetof(struct htab_elem, fnode) !=3D
> > +                  offsetof(struct htab_elem_pcpu, fnode));
> > +
> >       if (zero_seed && !capable(CAP_SYS_ADMIN))
> >               /* Guard against local DoS, and discourage production use=
. */
> >               return -EPERM;
> > @@ -476,7 +561,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
> >       if (IS_ERR_OR_NULL(hrec->record))
> >               return;
> >
> > -     map_value =3D htab_elem_value(elem, hrec->key_size);
> > +     map_value =3D (void *)elem + sizeof(struct htab_elem) + round_up(=
hrec->key_size, 8);
> >       bpf_obj_free_fields(hrec->record, map_value);
> >  }
> >
> > @@ -583,8 +668,14 @@ static struct bpf_map *htab_map_alloc(union bpf_at=
tr *attr)
> >
> >       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);
> >
> > -     htab->elem_size =3D sizeof(struct htab_elem) +
> > -                       round_up(htab->map.key_size, 8);
> > +     if (htab_is_lru(htab))
> > +             htab->key_offset =3D sizeof(struct htab_elem_lru);
> > +     else if (percpu && !prealloc)
> > +             htab->key_offset =3D sizeof(struct htab_elem_pcpu);
> > +     else
> > +             htab->key_offset =3D sizeof(struct htab_elem);
> > +
> > +     htab->elem_size =3D htab->key_offset + round_up(htab->map.key_siz=
e, 8);
> >       if (percpu)
> >               htab->elem_size +=3D sizeof(void *);
> >       else
> > @@ -692,14 +783,16 @@ static inline struct hlist_nulls_head *select_buc=
ket(struct bpf_htab *htab, u32
> >  }
> >
> >  /* this lookup function can only be called with bucket lock taken */
> > -static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head=
, u32 hash,
> > +static struct htab_elem *lookup_elem_raw(struct bpf_htab *htab,
> > +                                      struct hlist_nulls_head *head, u=
32 hash,
> >                                        void *key, u32 key_size)
> >  {
> >       struct hlist_nulls_node *n;
> >       struct htab_elem *l;
> >
> >       hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > -             if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size=
))
> > +             if (htab_elem_hash(htab, l) =3D=3D hash &&
> > +                 !memcmp(htab_elem_key(htab, l), key, key_size))
> >                       return l;
> >
> >       return NULL;
> > @@ -709,7 +802,8 @@ static struct htab_elem *lookup_elem_raw(struct hli=
st_nulls_head *head, u32 hash
> >   * the unlikely event when elements moved from one bucket into another
> >   * while link list is being walked
> >   */
> > -static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head=
 *head,
> > +static struct htab_elem *lookup_nulls_elem_raw(struct bpf_htab *htab,
> > +                                            struct hlist_nulls_head *h=
ead,
> >                                              u32 hash, void *key,
> >                                              u32 key_size, u32 n_bucket=
s)
> >  {
> > @@ -718,7 +812,8 @@ static struct htab_elem *lookup_nulls_elem_raw(stru=
ct hlist_nulls_head *head,
> >
> >  again:
> >       hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > -             if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size=
))
> > +             if (htab_elem_hash(htab, l) =3D=3D hash &&
> > +                 !memcmp(htab_elem_key(htab, l), key, key_size))
> >                       return l;
> >
> >       if (unlikely(get_nulls_value(n) !=3D (hash & (n_buckets - 1))))
> > @@ -747,17 +842,18 @@ static void *__htab_map_lookup_elem(struct bpf_ma=
p *map, void *key)
> >
> >       head =3D select_bucket(htab, hash);
> >
> > -     l =3D lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_bu=
ckets);
> > +     l =3D lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab=
->n_buckets);
> >
> >       return l;
> >  }
> >
> >  static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
> >
> >       if (l)
> > -             return htab_elem_value(l, map->key_size);
> > +             return htab_elem_value(htab, l);
> >
> >       return NULL;
> >  }
> > @@ -775,6 +871,7 @@ static void *htab_map_lookup_elem(struct bpf_map *m=
ap, void *key)
> >   */
> >  static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *i=
nsn_buf)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct bpf_insn *insn =3D insn_buf;
> >       const int ret =3D BPF_REG_0;
> >
> > @@ -783,7 +880,7 @@ static int htab_map_gen_lookup(struct bpf_map *map,=
 struct bpf_insn *insn_buf)
> >       *insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> >       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
> >       *insn++ =3D BPF_ALU64_IMM(BPF_ADD, ret,
> > -                             offsetof(struct htab_elem, key) +
> > +                             htab->key_offset +
> >                               round_up(map->key_size, 8));
> >       return insn - insn_buf;
> >  }
> > @@ -791,12 +888,13 @@ static int htab_map_gen_lookup(struct bpf_map *ma=
p, struct bpf_insn *insn_buf)
> >  static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map=
 *map,
> >                                                       void *key, const =
bool mark)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
> >
> >       if (l) {
> >               if (mark)
> > -                     bpf_lru_node_set_ref(&l->lru_node);
> > -             return htab_elem_value(l, map->key_size);
> > +                     bpf_lru_node_set_ref(htab_elem_lru_node(l));
> > +             return htab_elem_value(htab, l);
> >       }
> >
> >       return NULL;
> > @@ -815,6 +913,7 @@ static void *htab_lru_map_lookup_elem_sys(struct bp=
f_map *map, void *key)
> >  static int htab_lru_map_gen_lookup(struct bpf_map *map,
> >                                  struct bpf_insn *insn_buf)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct bpf_insn *insn =3D insn_buf;
> >       const int ret =3D BPF_REG_0;
> >       const int ref_reg =3D BPF_REG_1;
> > @@ -824,15 +923,15 @@ static int htab_lru_map_gen_lookup(struct bpf_map=
 *map,
> >       *insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> >       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
> >       *insn++ =3D BPF_LDX_MEM(BPF_B, ref_reg, ret,
> > -                           offsetof(struct htab_elem, lru_node) +
> > +                           offsetof(struct htab_elem_lru, lru_node) +
> >                             offsetof(struct bpf_lru_node, ref));
> >       *insn++ =3D BPF_JMP_IMM(BPF_JNE, ref_reg, 0, 1);
> >       *insn++ =3D BPF_ST_MEM(BPF_B, ret,
> > -                          offsetof(struct htab_elem, lru_node) +
> > +                          offsetof(struct htab_elem_lru, lru_node) +
> >                            offsetof(struct bpf_lru_node, ref),
> >                            1);
> >       *insn++ =3D BPF_ALU64_IMM(BPF_ADD, ret,
> > -                             offsetof(struct htab_elem, key) +
> > +                             htab->key_offset +
> >                               round_up(map->key_size, 8));
> >       return insn - insn_buf;
> >  }
> > @@ -844,13 +943,13 @@ static void check_and_cancel_fields(struct bpf_ht=
ab *htab,
> >               return;
> >
> >       if (htab_is_percpu(htab)) {
> > -             void __percpu *pptr =3D htab_elem_get_ptr(elem, htab->map=
.key_size);
> > +             void __percpu *pptr =3D htab_elem_get_ptr(htab, elem);
> >               int cpu;
> >
> >               for_each_possible_cpu(cpu)
> >                       bpf_obj_cancel_fields(&htab->map, per_cpu_ptr(ppt=
r, cpu));
> >       } else {
> > -             void *map_value =3D htab_elem_value(elem, htab->map.key_s=
ize);
> > +             void *map_value =3D htab_elem_value(htab, elem);
> >
> >               bpf_obj_cancel_fields(&htab->map, map_value);
> >       }
> > @@ -869,8 +968,8 @@ static bool htab_lru_map_delete_node(void *arg, str=
uct bpf_lru_node *node)
> >       struct bucket *b;
> >       int ret;
> >
> > -     tgt_l =3D container_of(node, struct htab_elem, lru_node);
> > -     b =3D __select_bucket(htab, tgt_l->hash);
> > +     tgt_l =3D (struct htab_elem *)container_of(node, struct htab_elem=
_lru, lru_node);
> > +     b =3D __select_bucket(htab, htab_elem_hash(htab, tgt_l));
> >       head =3D &b->head;
> >
> >       ret =3D htab_lock_bucket(b, &flags);
> > @@ -912,7 +1011,7 @@ static int htab_map_get_next_key(struct bpf_map *m=
ap, void *key, void *next_key)
> >       head =3D select_bucket(htab, hash);
> >
> >       /* lookup the key */
> > -     l =3D lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_bu=
ckets);
> > +     l =3D lookup_nulls_elem_raw(htab, head, hash, key, key_size, htab=
->n_buckets);
> >
> >       if (!l)
> >               goto find_first_elem;
> > @@ -923,7 +1022,7 @@ static int htab_map_get_next_key(struct bpf_map *m=
ap, void *key, void *next_key)
> >
> >       if (next_l) {
> >               /* if next elem in this hash list is non-zero, just retur=
n it */
> > -             memcpy(next_key, next_l->key, key_size);
> > +             memcpy(next_key, htab_elem_key(htab, next_l), key_size);
> >               return 0;
> >       }
> >
> > @@ -941,7 +1040,7 @@ static int htab_map_get_next_key(struct bpf_map *m=
ap, void *key, void *next_key)
> >                                         struct htab_elem, hash_node);
> >               if (next_l) {
> >                       /* if it's not empty, just return it */
> > -                     memcpy(next_key, next_l->key, key_size);
> > +                     memcpy(next_key, htab_elem_key(htab, next_l), key=
_size);
> >                       return 0;
> >               }
> >       }
> > @@ -955,7 +1054,7 @@ static void htab_elem_free(struct bpf_htab *htab, =
struct htab_elem *l)
> >       check_and_cancel_fields(htab, l);
> >
> >       if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
> > -             bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
> > +             bpf_mem_cache_free(&htab->pcpu_ma, htab_elem_get_ptr_to_p=
ptr(l));
> >       bpf_mem_cache_free(&htab->ma, l);
> >  }
> >
> > @@ -965,7 +1064,7 @@ static void htab_put_fd_value(struct bpf_htab *hta=
b, struct htab_elem *l)
> >       void *ptr;
> >
> >       if (map->ops->map_fd_put_ptr) {
> > -             ptr =3D fd_htab_map_get_ptr(map, l);
> > +             ptr =3D fd_htab_map_get_ptr(htab, l);
> >               map->ops->map_fd_put_ptr(map, ptr, true);
> >       }
> >  }
> > @@ -1117,10 +1216,10 @@ static struct htab_elem *alloc_htab_elem(struct=
 bpf_htab *htab, void *key,
> >               }
> >       }
> >
> > -     memcpy(l_new->key, key, key_size);
> > +     memcpy(htab_elem_key(htab, l_new), key, key_size);
> >       if (percpu) {
> >               if (prealloc) {
> > -                     pptr =3D htab_elem_get_ptr(l_new, key_size);
> > +                     pptr =3D htab_elem_get_ptr(htab, l_new);
> >               } else {
> >                       /* alloc_percpu zero-fills */
> >                       void *ptr =3D bpf_mem_cache_alloc(&htab->pcpu_ma)=
;
> > @@ -1130,26 +1229,26 @@ static struct htab_elem *alloc_htab_elem(struct=
 bpf_htab *htab, void *key,
> >                               l_new =3D ERR_PTR(-ENOMEM);
> >                               goto dec_count;
> >                       }
> > -                     l_new->ptr_to_pptr =3D ptr;
> > +                     htab_elem_set_ptr_to_pptr(l_new, ptr);
> >                       pptr =3D *(void __percpu **)ptr;
> >               }
> >
> >               pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
> >
> >               if (!prealloc)
> > -                     htab_elem_set_ptr(l_new, key_size, pptr);
> > +                     htab_elem_set_ptr(htab, l_new, pptr);
> >       } else if (fd_htab_map_needs_adjust(htab)) {
> >               size =3D round_up(size, 8);
> > -             memcpy(htab_elem_value(l_new, key_size), value, size);
> > +             memcpy(htab_elem_value(htab, l_new), value, size);
> >       } else if (map_flags & BPF_F_LOCK) {
> >               copy_map_value_locked(&htab->map,
> > -                                   htab_elem_value(l_new, key_size),
> > +                                   htab_elem_value(htab, l_new),
> >                                     value, false);
> >       } else {
> > -             copy_map_value(&htab->map, htab_elem_value(l_new, key_siz=
e), value);
> > +             copy_map_value(&htab->map, htab_elem_value(htab, l_new), =
value);
> >       }
> >
> > -     l_new->hash =3D hash;
> > +     htab_elem_set_hash(htab, l_new, hash);
> >       return l_new;
> >  dec_count:
> >       dec_elem_count(htab);
> > @@ -1199,7 +1298,7 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
> >               if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_=
LOCK)))
> >                       return -EINVAL;
> >               /* find an element without taking the bucket lock */
> > -             l_old =3D lookup_nulls_elem_raw(head, hash, key, key_size=
,
> > +             l_old =3D lookup_nulls_elem_raw(htab, head, hash, key, ke=
y_size,
> >                                             htab->n_buckets);
> >               ret =3D check_flags(htab, l_old, map_flags);
> >               if (ret)
> > @@ -1207,7 +1306,7 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
> >               if (l_old) {
> >                       /* grab the element lock and update value in plac=
e */
> >                       copy_map_value_locked(map,
> > -                                           htab_elem_value(l_old, key_=
size),
> > +                                           htab_elem_value(htab, l_old=
),
> >                                             value, false);
> >                       return 0;
> >               }
> > @@ -1221,7 +1320,7 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
> >       if (ret)
> >               return ret;
> >
> > -     l_old =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l_old =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >
> >       ret =3D check_flags(htab, l_old, map_flags);
> >       if (ret)
> > @@ -1235,7 +1334,7 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
> >                * and update element in place
> >                */
> >               copy_map_value_locked(map,
> > -                                   htab_elem_value(l_old, key_size),
> > +                                   htab_elem_value(htab, l_old),
> >                                     value, false);
> >               ret =3D 0;
> >               goto err;
> > @@ -1275,7 +1374,7 @@ static void htab_lru_push_free(struct bpf_htab *h=
tab, struct htab_elem *elem)
> >  {
> >       check_and_cancel_fields(htab, elem);
> >       bpf_map_dec_elem_count(&htab->map);
> > -     bpf_lru_push_free(&htab->lru, &elem->lru_node);
> > +     bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
> >  }
> >
> >  static long htab_lru_map_update_elem(struct bpf_map *map, void *key, v=
oid *value,
> > @@ -1310,13 +1409,13 @@ static long htab_lru_map_update_elem(struct bpf=
_map *map, void *key, void *value
> >       l_new =3D prealloc_lru_pop(htab, key, hash);
> >       if (!l_new)
> >               return -ENOMEM;
> > -     copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size),=
 value);
> > +     copy_map_value(&htab->map, htab_elem_value(htab, l_new), value);
> >
> >       ret =3D htab_lock_bucket(b, &flags);
> >       if (ret)
> >               goto err_lock_bucket;
> >
> > -     l_old =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l_old =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >
> >       ret =3D check_flags(htab, l_old, map_flags);
> >       if (ret)
> > @@ -1327,7 +1426,7 @@ static long htab_lru_map_update_elem(struct bpf_m=
ap *map, void *key, void *value
> >        */
> >       hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> >       if (l_old) {
> > -             bpf_lru_node_set_ref(&l_new->lru_node);
> > +             bpf_lru_node_set_ref(htab_elem_lru_node(l_new));
> >               hlist_nulls_del_rcu(&l_old->hash_node);
> >       }
> >       ret =3D 0;
> > @@ -1383,7 +1482,7 @@ static long htab_map_update_elem_in_place(struct =
bpf_map *map, void *key,
> >       if (ret)
> >               return ret;
> >
> > -     l_old =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l_old =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >
> >       ret =3D check_flags(htab, l_old, map_flags);
> >       if (ret)
> > @@ -1392,10 +1491,10 @@ static long htab_map_update_elem_in_place(struc=
t bpf_map *map, void *key,
> >       if (l_old) {
> >               /* Update value in-place */
> >               if (percpu) {
> > -                     pcpu_copy_value(htab, htab_elem_get_ptr(l_old, ke=
y_size),
> > +                     pcpu_copy_value(htab, htab_elem_get_ptr(htab, l_o=
ld),
> >                                       value, onallcpus, map_flags);
> >               } else {
> > -                     void **inner_map_pptr =3D htab_elem_value(l_old, =
key_size);
> > +                     void **inner_map_pptr =3D htab_elem_value(htab, l=
_old);
> >
> >                       old_map_ptr =3D *inner_map_pptr;
> >                       WRITE_ONCE(*inner_map_pptr, *(void **)value);
> > @@ -1456,20 +1555,20 @@ static long __htab_lru_percpu_map_update_elem(s=
truct bpf_map *map, void *key,
> >       if (ret)
> >               goto err_lock_bucket;
> >
> > -     l_old =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l_old =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >
> >       ret =3D check_flags(htab, l_old, map_flags);
> >       if (ret)
> >               goto err;
> >
> >       if (l_old) {
> > -             bpf_lru_node_set_ref(&l_old->lru_node);
> > +             bpf_lru_node_set_ref(htab_elem_lru_node(l_old));
> >
> >               /* per-cpu hash map can update value in-place */
> > -             pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> > +             pcpu_copy_value(htab, htab_elem_get_ptr(htab, l_old),
> >                               value, onallcpus, map_flags);
> >       } else {
> > -             pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
> > +             pcpu_init_value(htab, htab_elem_get_ptr(htab, l_new),
> >                               value, onallcpus, map_flags);
> >               hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> >               l_new =3D NULL;
> > @@ -1480,7 +1579,7 @@ static long __htab_lru_percpu_map_update_elem(str=
uct bpf_map *map, void *key,
> >  err_lock_bucket:
> >       if (l_new) {
> >               bpf_map_dec_elem_count(&htab->map);
> > -             bpf_lru_push_free(&htab->lru, &l_new->lru_node);
> > +             bpf_lru_push_free(&htab->lru, htab_elem_lru_node(l_new));
> >       }
> >       return ret;
> >  }
> > @@ -1521,7 +1620,7 @@ static long htab_map_delete_elem(struct bpf_map *=
map, void *key)
> >       if (ret)
> >               return ret;
> >
> > -     l =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >       if (l)
> >               hlist_nulls_del_rcu(&l->hash_node);
> >       else
> > @@ -1556,7 +1655,7 @@ static long htab_lru_map_delete_elem(struct bpf_m=
ap *map, void *key)
> >       if (ret)
> >               return ret;
> >
> > -     l =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >
> >       if (l)
> >               hlist_nulls_del_rcu(&l->hash_node);
> > @@ -1602,7 +1701,7 @@ static void htab_free_malloced_internal_structs(s=
truct bpf_htab *htab)
> >               hlist_nulls_for_each_entry(l, n, head, hash_node) {
> >                       /* We only free internal structs on uref dropping=
 to zero */
> >                       bpf_map_free_internal_structs(&htab->map,
> > -                                                   htab_elem_value(l, =
htab->map.key_size));
> > +                                                   htab_elem_value(hta=
b, l));
> >               }
> >               cond_resched_rcu();
> >       }
> > @@ -1697,7 +1796,7 @@ static int __htab_map_lookup_and_delete_elem(stru=
ct bpf_map *map, void *key,
> >       if (ret)
> >               return ret;
> >
> > -     l =3D lookup_elem_raw(head, hash, key, key_size);
> > +     l =3D lookup_elem_raw(htab, head, hash, key, key_size);
> >       if (!l) {
> >               ret =3D -ENOENT;
> >               goto out_unlock;
> > @@ -1708,14 +1807,14 @@ static int __htab_map_lookup_and_delete_elem(st=
ruct bpf_map *map, void *key,
> >               void __percpu *pptr;
> >               int off =3D 0, cpu;
> >
> > -             pptr =3D htab_elem_get_ptr(l, key_size);
> > +             pptr =3D htab_elem_get_ptr(htab, l);
> >               for_each_possible_cpu(cpu) {
> >                       copy_map_value_long(&htab->map, value + off, per_=
cpu_ptr(pptr, cpu));
> >                       check_and_init_map_value(&htab->map, value + off)=
;
> >                       off +=3D roundup_value_size;
> >               }
> >       } else {
> > -             void *src =3D htab_elem_value(l, map->key_size);
> > +             void *src =3D htab_elem_value(htab, l);
> >
> >               if (flags & BPF_F_LOCK)
> >                       copy_map_value_locked(map, value, src, true);
> > @@ -1898,13 +1997,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_m=
ap *map,
> >               goto next_batch;
> >
> >       hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
> > -             memcpy(dst_key, l->key, key_size);
> > +             memcpy(dst_key, htab_elem_key(htab, l), key_size);
> >
> >               if (is_percpu) {
> >                       int off =3D 0, cpu;
> >                       void __percpu *pptr;
> >
> > -                     pptr =3D htab_elem_get_ptr(l, map->key_size);
> > +                     pptr =3D htab_elem_get_ptr(htab, l);
> >                       if (elem_map_flags & BPF_F_CPU) {
> >                               cpu =3D elem_map_flags >> 32;
> >                               copy_map_value(&htab->map, dst_val, per_c=
pu_ptr(pptr, cpu));
> > @@ -1918,7 +2017,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
> >                               }
> >                       }
> >               } else {
> > -                     value =3D htab_elem_value(l, key_size);
> > +                     value =3D htab_elem_value(htab, l);
> >                       if (is_fd_htab(htab)) {
> >                               struct bpf_map **inner_map =3D value;
> >
> > @@ -2183,12 +2282,12 @@ static int __bpf_hash_map_seq_show(struct seq_f=
ile *seq, struct htab_elem *elem)
> >               ctx.meta =3D &meta;
> >               ctx.map =3D info->map;
> >               if (elem) {
> > -                     ctx.key =3D elem->key;
> > +                     ctx.key =3D htab_elem_key(info->htab, elem);
> >                       if (!info->percpu_value_buf) {
> > -                             ctx.value =3D htab_elem_value(elem, map->=
key_size);
> > +                             ctx.value =3D htab_elem_value(info->htab,=
 elem);
> >                       } else {
> >                               roundup_value_size =3D round_up(map->valu=
e_size, 8);
> > -                             pptr =3D htab_elem_get_ptr(elem, map->key=
_size);
> > +                             pptr =3D htab_elem_get_ptr(info->htab, el=
em);
> >                               for_each_possible_cpu(cpu) {
> >                                       copy_map_value_long(map, info->pe=
rcpu_value_buf + off,
> >                                                           per_cpu_ptr(p=
ptr, cpu));
> > @@ -2293,13 +2392,13 @@ static long bpf_for_each_hash_elem(struct bpf_m=
ap *map, bpf_callback_t callback_
> >               rcu_read_lock();
> >               head =3D &b->head;
> >               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node)=
 {
> > -                     key =3D elem->key;
> > +                     key =3D htab_elem_key(htab, elem);
> >                       if (is_percpu) {
> >                               /* current cpu value for percpu map */
> > -                             pptr =3D htab_elem_get_ptr(elem, map->key=
_size);
> > +                             pptr =3D htab_elem_get_ptr(htab, elem);
> >                               val =3D this_cpu_ptr(pptr);
> >                       } else {
> > -                             val =3D htab_elem_value(elem, map->key_si=
ze);
> > +                             val =3D htab_elem_value(htab, elem);
> >                       }
> >                       num_elems++;
> >                       ret =3D callback_fn((u64)(long)map, (u64)(long)ke=
y,
> > @@ -2403,10 +2502,11 @@ const struct bpf_map_ops htab_lru_map_ops =3D {
> >  /* Called from eBPF program */
> >  static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *ke=
y)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
> >
> >       if (l)
> > -             return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
> > +             return this_cpu_ptr(htab_elem_get_ptr(htab, l));
> >       else
> >               return NULL;
> >  }
> > @@ -2414,6 +2514,7 @@ static void *htab_percpu_map_lookup_elem(struct b=
pf_map *map, void *key)
> >  /* inline bpf_map_lookup_elem() call for per-CPU hashmap */
> >  static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_=
insn *insn_buf)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct bpf_insn *insn =3D insn_buf;
> >
> >       if (!bpf_jit_supports_percpu_insn())
> > @@ -2424,7 +2525,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_=
map *map, struct bpf_insn *insn
> >       *insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> >       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
> >       *insn++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
> > -                             offsetof(struct htab_elem, key) + roundup=
(map->key_size, 8));
> > +                             htab->key_offset + roundup(map->key_size,=
 8));
> >       *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> >       *insn++ =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> >
> > @@ -2433,6 +2534,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_=
map *map, struct bpf_insn *insn
> >
> >  static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, v=
oid *key, u32 cpu)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l;
> >
> >       if (cpu >=3D nr_cpu_ids)
> > @@ -2440,18 +2542,19 @@ static void *htab_percpu_map_lookup_percpu_elem=
(struct bpf_map *map, void *key,
> >
> >       l =3D __htab_map_lookup_elem(map, key);
> >       if (l)
> > -             return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), c=
pu);
> > +             return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
> >       else
> >               return NULL;
> >  }
> >
> >  static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void=
 *key)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
> >
> >       if (l) {
> > -             bpf_lru_node_set_ref(&l->lru_node);
> > -             return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
> > +             bpf_lru_node_set_ref(htab_elem_lru_node(l));
> > +             return this_cpu_ptr(htab_elem_get_ptr(htab, l));
> >       }
> >
> >       return NULL;
> > @@ -2459,6 +2562,7 @@ static void *htab_lru_percpu_map_lookup_elem(stru=
ct bpf_map *map, void *key)
> >
> >  static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *ma=
p, void *key, u32 cpu)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l;
> >
> >       if (cpu >=3D nr_cpu_ids)
> > @@ -2466,8 +2570,8 @@ static void *htab_lru_percpu_map_lookup_percpu_el=
em(struct bpf_map *map, void *k
> >
> >       l =3D __htab_map_lookup_elem(map, key);
> >       if (l) {
> > -             bpf_lru_node_set_ref(&l->lru_node);
> > -             return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), c=
pu);
> > +             bpf_lru_node_set_ref(htab_elem_lru_node(l));
> > +             return per_cpu_ptr(htab_elem_get_ptr(htab, l), cpu);
> >       }
> >
> >       return NULL;
> > @@ -2475,6 +2579,7 @@ static void *htab_lru_percpu_map_lookup_percpu_el=
em(struct bpf_map *map, void *k
> >
> >  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, =
u64 map_flags)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l;
> >       void __percpu *pptr;
> >       int ret =3D -ENOENT;
> > @@ -2494,7 +2599,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, voi=
d *key, void *value, u64 map_fl
> >       /* We do not mark LRU map element here in order to not mess up
> >        * eviction heuristics when user space does a map walk.
> >        */
> > -     pptr =3D htab_elem_get_ptr(l, map->key_size);
> > +     pptr =3D htab_elem_get_ptr(htab, l);
> >       if (map_flags & BPF_F_CPU) {
> >               cpu =3D map_flags >> 32;
> >               copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
> > @@ -2532,6 +2637,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, v=
oid *key, void *value,
> >  static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *k=
ey,
> >                                         struct seq_file *m)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct htab_elem *l;
> >       void __percpu *pptr;
> >       int cpu;
> > @@ -2546,7 +2652,7 @@ static void htab_percpu_map_seq_show_elem(struct =
bpf_map *map, void *key,
> >
> >       btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
> >       seq_puts(m, ": {\n");
> > -     pptr =3D htab_elem_get_ptr(l, map->key_size);
> > +     pptr =3D htab_elem_get_ptr(htab, l);
> >       for_each_possible_cpu(cpu) {
> >               seq_printf(m, "\tcpu%d: ", cpu);
> >               btf_type_seq_show(map->btf, map->btf_value_type_id,
> > @@ -2620,7 +2726,7 @@ static void fd_htab_map_free(struct bpf_map *map)
> >               head =3D select_bucket(htab, i);
> >
> >               hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
> > -                     void *ptr =3D fd_htab_map_get_ptr(map, l);
> > +                     void *ptr =3D fd_htab_map_get_ptr(htab, l);
> >
> >                       map->ops->map_fd_put_ptr(map, ptr, false);
> >               }
> > @@ -2705,6 +2811,7 @@ static void *htab_of_map_lookup_elem(struct bpf_m=
ap *map, void *key)
> >  static int htab_of_map_gen_lookup(struct bpf_map *map,
> >                                 struct bpf_insn *insn_buf)
> >  {
> > +     struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> >       struct bpf_insn *insn =3D insn_buf;
> >       const int ret =3D BPF_REG_0;
> >
> > @@ -2713,7 +2820,7 @@ static int htab_of_map_gen_lookup(struct bpf_map =
*map,
> >       *insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> >       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
> >       *insn++ =3D BPF_ALU64_IMM(BPF_ADD, ret,
> > -                             offsetof(struct htab_elem, key) +
> > +                             htab->key_offset +
> >                               round_up(map->key_size, 8));
> >       *insn++ =3D BPF_LDX_MEM(BPF_DW, ret, ret, 0);
> >
> > @@ -3533,3 +3640,16 @@ const struct bpf_map_ops rhtab_map_ops =3D {
> >       .map_btf_id =3D &rhtab_map_btf_ids[0],
> >       .iter_seq_info =3D &rhash_iter_seq_info,
> >  };
> > +
> > +size_t bpf_htab_map_meta_size(void)
> > +{
> > +     return sizeof(struct bpf_htab);
> > +}
> > +
> > +void bpf_htab_map_meta_init(struct bpf_map *inner_map_meta, struct bpf=
_map *inner_map)
> > +{
> > +     struct bpf_htab *inner_htab_meta =3D container_of(inner_map_meta,=
 struct bpf_htab, map);
> > +     struct bpf_htab *inner_htab =3D container_of(inner_map, struct bp=
f_htab, map);
> > +
> > +     inner_htab_meta->key_offset =3D inner_htab->key_offset;
> > +}
> > diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> > index d2cbab4bdf64..b2db5d0c98be 100644
> > --- a/kernel/bpf/map_in_map.c
> > +++ b/kernel/bpf/map_in_map.c
> > @@ -7,6 +7,15 @@
> >
> >  #include "map_in_map.h"
> >
> > +static bool bpf_map_type_is_htab(enum bpf_map_type type)
> > +{
> > +     return type =3D=3D BPF_MAP_TYPE_HASH ||
> > +            type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> > +            type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
> > +            type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> > +            type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS;
> > +}
> > +
> >  struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
> >  {
> >       struct bpf_map *inner_map, *inner_map_meta;
> > @@ -29,6 +38,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
> >       /* In some cases verifier needs to access beyond just base map. *=
/
> >       if (inner_map->ops =3D=3D &array_map_ops || inner_map->ops =3D=3D=
 &percpu_array_map_ops)
> >               inner_map_meta_size =3D sizeof(struct bpf_array);
> > +     else if (bpf_map_type_is_htab(inner_map->map_type))
> > +             inner_map_meta_size =3D bpf_htab_map_meta_size();
> >
> >       inner_map_meta =3D kzalloc(inner_map_meta_size, GFP_USER);
> >       if (!inner_map_meta)
> > @@ -70,6 +81,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
> >               inner_array_meta->index_mask =3D inner_array->index_mask;
> >               inner_array_meta->elem_size =3D inner_array->elem_size;
> >               inner_map_meta->bypass_spec_v1 =3D inner_map->bypass_spec=
_v1;
> > +     } else if (bpf_map_type_is_htab(inner_map->map_type)) {
> > +             bpf_htab_map_meta_init(inner_map_meta, inner_map);
> >       }
> >       return inner_map_meta;
> >  }
> > diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
> > index 7d61602354de..1edc205772d8 100644
> > --- a/kernel/bpf/map_in_map.h
> > +++ b/kernel/bpf/map_in_map.h
> > @@ -15,5 +15,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map, struct =
file *map_file,
> >                        int ufd);
> >  void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defe=
r);
> >  u32 bpf_map_fd_sys_lookup_elem(void *ptr);
> > +size_t bpf_htab_map_meta_size(void);
> > +void bpf_htab_map_meta_init(struct bpf_map *inner_map_meta, struct bpf=
_map *inner_map);
> >
> >  #endif
>
