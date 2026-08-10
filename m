Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F543F8B9
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395333; cv=pass; b=H8IWSWI4kS9AtoQOENB0zymoz3Mwmw6Ttaj38tpHBZNuKx8CXSOPD4EBZAo/V6dUE1uR9pZyvwd3Up7t16snSOteyYnIskaiC3zdZIk6+gG9kwF2ez8DzIDKmHiicJnIdQWiADJ4LEXe85FJDLbkFfHa4aqblSds+7Brq7ljWEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395333; c=relaxed/simple;
	bh=p3F6ymBJO5EBEkvWBMuW9xqLKEqiAZSvz3sJEqKmjTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKfeVMUcxQvfuDPWvj9b9hQYb4sHv+YfV2/s4ydJDbZ3pTpLLoYnXTJNahTJwe+qfs9xaxApAVx3l/bRjHc9ntpJp/O/s2VI1LfOi98cfaplOJTAXVzbaFN9MXNkpTXxdklEwB27CA8CXn5MLTAuFIr7qnfAkOsJZDmCrNIGSeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfkv7BEm; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfkv7BEm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4994d67d260so6475e9.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 13:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786395330; cv=none;
        d=google.com; s=arc-20260327;
        b=khiYrnO0zS6mTCv4PAgaUA+sKvBGba7qO7NJqg58zl6Oj189c8K9FAgwPr2zsEz9co
         PnmmFTiv0seS2dlX0833ye3gUdYrH0aj7qdLgtxd5N6kWPPUqhvqlWRVvwnIOnh+KG7K
         qpyay2f9VL81xVz7Efg3C4ax7nPhX1lDjFkQlESZrnLqVlkfF85PxBKWUUhRLWyRZsQa
         wF3EqFk/NNwqzY1b44/O7MY8LIqwX1nnzb7tk0kEkQwDr32O5TzRULiZWCVJGgBIwaND
         SMcRmih1vRdlBNTyQvcsLIclTwcIEL6ds8oUBrrOCUJ5Zp148Kg90+6QPPutcjZqjAM+
         z4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1TtlyjazrX283GLO+zBSmn2h3geHMWiMC9TJl3GAFLw=;
        fh=sheSDnGf0LVeEPFF8wjZ6wEBbL3UQPp+gXSdgGipdWM=;
        b=TIUx2UqdIBFYL2gQcR3a5VYFQRG46NDjFx0aBHKWfqG1s0ZDne6QauFiArVG/lLJHA
         cf+qNHZX2AVT9k3t9pTqNPtr9VLgSfnXuPWDxyw6HDjRY5dWsPIMbr5ms52Vj9FdvNzY
         ti9kmGuqzTSCVH5FfzUZI96ySmLOscTz0yMGdXzklHYSTedD1ioSOSOoIWLoBH0MAiHk
         HWjNJs0QQyWpKX71eFu+cgrRHhsa+tvf8+CRnd7gIwORlTyhGGVvMFewbXex+9PYOc89
         qrWSarB3ZEzcT208dQmy1L8LAo8Hv9JbAxoVhP5jDMHkQKSw6nWg3D02y4aKXV4we3ve
         RFFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786395330; x=1787000130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1TtlyjazrX283GLO+zBSmn2h3geHMWiMC9TJl3GAFLw=;
        b=nfkv7BEmpyb9pcHpM9W0Xy59/aaw67HjRAaYbhr2KGIHgEVoAYuUKwa1n7Sjxd2NFt
         LQuqFe2bIn9Z2oLbIlyDiJWTXJ/OTziPnP3zzjwQthtlKULEUMyH0ZmhsFCuStoA2TOC
         q2F+eMvSFQmNl0zZvePZAlEdEDfqTgUFTeH6yhrwXLi5NEPFfjopgjzCobIH1ttdx1mx
         bw6j9V67On2S7FGdSE40Zsp7IIvTFN9gCgmKx8leM5icfgvWrEXKIwzAhNz8ipee5XyA
         w/nULDofsn9codLnhcysShpkeqNmUQxwCZ4i9qqPJeP8zvjkcLnqh+C3qr0nIuBEctMU
         FntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395330; x=1787000130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1TtlyjazrX283GLO+zBSmn2h3geHMWiMC9TJl3GAFLw=;
        b=paKP4PdklRo19/EpS1pXD0gJJCS+567PERQV5C3PjaSNF7MuK8ojXZuakAU9ULBXvg
         /zSGR2VxtYFb6UuYyGvySDBwvqimFglKzYYOU+U1O6baGL8HLHwfKHWmzvtA57hc/PA2
         NnllX3InDlZn/3Z2mqewksB4VNOf1Puy+E6KdpYOwHOrj7WKnBfhbD4ssV5eSSSpYuGu
         I3CWCOPuZsPBTiBVz8fSHAr2vtHuP1Kr/COK6w0HCYvVvxPsel53JLOEjlfdqGpUAIJy
         B69rdw+d2m8sbWeVlPbrT439HghkkuJ+Eq42e+QPCjqD1unJffK4NfPujdr9taFqUKoA
         NvwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU8v77c0w90e/+GnazkmR/K28XGKeEY2DewaHcO6VFvPd248TT1HpaHUSOfM7oQK1F8LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNipeWzVRsirt8JE9KaHiIvwCca7VOi/+ArqnvAgSDLBfWXfX
	H1ceu0zvK1uG73cTmGC32hho1/sxVIiFK6oSfu90SqNuTJusj6Mx2uSNFZF3oeYT/T5bgcZSLuD
	LmoKOKvQYMlaV4dg4RldZNEtmPF1aKPIJ16pgKv0V
X-Gm-Gg: AR+sD11UG3Vn4fdrSwL+yznP63LmS5+C/S5pXw8xBZB8kypi+c0CHotIqnZrE/6tDb0
	UYlFefR2J+vJpUDbds6M7XlZvZ5+9Y9ph+/KFHGehLvMCmyJv7x9H6F2+00kts4xv5x+ez2CYzt
	VhecUr7iueZYSI1OEacOMZHoKmF1BHcniMQumDbdROKSAnZixO0IDRuiMSggZxdYiK9Q8DKtjez
	KbeLlFhWR3h1gky13G5lG18/25My2nrO3x4eGFEAIqym7KK0A70YVerwmEukiY17a+egpKIYkRe
	L6X5DSvotmFkWHaZSTth9F+YLdsSGe5ZMsKlfzUbez7zJuOZrCxYG+i+KplqgblQRGflGJSs5Wd
	Uf36RtiZTtN8e8qVqkygq8oN5+QiRKN4GLQAhu+sWL1s=
X-Received: by 2002:a05:600d:844f:10b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-49974469c4emr98135e9.2.1786395329191; Mon, 10 Aug 2026 13:55:29
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805223516.1495988-1-tjmercier@google.com>
 <20260805223516.1495988-3-tjmercier@google.com> <7ce1d67b-ae88-445c-b4f8-ffa0eea9befc@gmail.com>
In-Reply-To: <7ce1d67b-ae88-445c-b4f8-ffa0eea9befc@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 10 Aug 2026 13:55:17 -0700
X-Gm-Features: AUfX_mwnQN5CLZZEPeGzWJm8VhOlCuBqobtU_eydQz55FE8lX7mgE9HeIN9QUpE
Message-ID: <CABdmKX1w+xfO5NcV-0_W0gOuAkWRai+p3x0oKwF50cJHG4kKaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:33=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 8/5/26 11:35 PM, T.J. Mercier wrote:
> > For standard and PCPU (non-LRU) hash maps with small key sizes (less
> > than or equal to the word size), comparing keys requires only a single
> > instruction. Storing a cached 32-bit hash value to shortcut full key
> > comparisons provides no performance advantage for small keys, and
> > consumes memory for every element.
> >
> > This memory can be saved by eliminating hash along with its associated
> > 4 byte padding before the key, reducing the elem_size (and key_offset)
> > by 8 bytes for standard and PCPU maps.
> >
> > Introduce htab_has_hash() to check whether a map requires a cached hash
> > field. Update htab_elem_set_hash(), lookup_elem_raw(), and
> > lookup_nulls_elem_raw() to conditionally bypass hash checking and
> > storage when htab_has_hash() is false.
> >
> > Together with the previous patch, this reduces the minimum standard and
> > preallocated hash map element size from 64 bytes down to 32 bytes, and
> > non-preallocated per-CPU element size from 64 bytes down to 40 bytes.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  kernel/bpf/hashtab.c                          | 108 +++++++++++++-----
> >  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
> >  2 files changed, 79 insertions(+), 31 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index f54366da459f..9967268d453d 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -100,6 +100,7 @@ struct bpf_htab {
> >       struct percpu_counter pcount;
> >       atomic_t count;
> >       bool use_percpu_counter;
> > +     bool has_hash;
> >       u32 n_buckets;  /* number of hash buckets */
> >       u32 elem_size;  /* size of each element in bytes */
> >       u32 key_offset; /* offset of key in bytes */
> > @@ -123,15 +124,13 @@ struct htab_node {
> >
> >  struct htab_elem {
> >       struct htab_node node;
> > -     u32 hash;
> > -     char key[] __aligned(8);
> > +     u8 data[] __aligned(8);
> >  };
> >
> >  struct htab_elem_lru {
> >       struct htab_node node;
> >       struct bpf_lru_node lru_node;
> > -     u32 hash;
> > -     char key[] __aligned(8);
> > +     u8 data[] __aligned(8);
> >  };
> >
> >  /* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't n=
eed
> > @@ -140,13 +139,13 @@ struct htab_elem_lru {
> >  struct htab_elem_pcpu {
> >       struct htab_node node;
> >       void *ptr_to_pptr;
> > -     u32 hash;
> > -     char key[] __aligned(8);
> > +     u8 data[] __aligned(8);
> >  };
> >
> >  struct htab_btf_record {
> >       struct btf_record *record;
> >       u32 key_size;
> > +     u32 key_offset;
> >  };
> >
> >  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
> > @@ -247,24 +246,31 @@ static struct htab_elem *get_htab_elem(struct bpf=
_htab *htab, int i)
> >       return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_si=
ze);
> >  }
> >
> > +static inline bool htab_has_hash(const struct bpf_htab *htab)
> > +{
> > +     return htab->has_hash;
> > +}
> > +
> >  static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_el=
em *l)
> >  {
> >       if (htab_is_lru(htab))
> > -             return ((struct htab_elem_lru *)l)->hash;
> > +             return *(u32 *)((struct htab_elem_lru *)l)->data;
> >       else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> > -             return ((struct htab_elem_pcpu *)l)->hash;
> > +             return *(u32 *)((struct htab_elem_pcpu *)l)->data;
> >       else
> > -             return l->hash;
> > +             return *(u32 *)l->data;
> >  }
> >
> >  static inline void htab_elem_set_hash(struct bpf_htab *htab, struct ht=
ab_elem *l, u32 hash)
> >  {
> > +     if (!htab_has_hash(htab))
> > +             return;
> >       if (htab_is_lru(htab))
> > -             ((struct htab_elem_lru *)l)->hash =3D hash;
> > +             *(u32 *)((struct htab_elem_lru *)l)->data =3D hash;
> >       else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> > -             ((struct htab_elem_pcpu *)l)->hash =3D hash;
> > +             *(u32 *)((struct htab_elem_pcpu *)l)->data =3D hash;
> >       else
> > -             l->hash =3D hash;
> > +             *(u32 *)l->data =3D hash;
> >  }
> >
> >  /* Both percpu and fd htab support in-place update, so no need for
> > @@ -405,7 +411,7 @@ static int prealloc_init(struct bpf_htab *htab)
> >       if (htab_is_lru(htab))
> >               err =3D bpf_lru_init(&htab->lru,
> >                                  htab->map.map_flags & BPF_F_NO_COMMON_=
LRU,
> > -                                offsetof(struct htab_elem_lru, hash) -
> > +                                offsetof(struct htab_elem_lru, data) -
> >                                  offsetof(struct htab_elem_lru, lru_nod=
e),
> >                                  htab_lru_map_delete_node,
> >                                  htab);
> > @@ -532,7 +538,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
> >       if (IS_ERR_OR_NULL(hrec->record))
> >               return;
> >
> > -     map_value =3D (void *)elem + sizeof(struct htab_elem) + round_up(=
hrec->key_size, 8);
> > +     map_value =3D (void *)elem + hrec->key_offset + round_up(hrec->ke=
y_size, 8);
> >       bpf_obj_free_fields(hrec->record, map_value);
> >  }
> >
> > @@ -558,7 +564,7 @@ static void htab_dtor_ctx_free(void *ctx)
> >  }
> >
> >  static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *=
ma,
> > -                        void (*dtor)(void *, void *))
> > +                        void (*dtor)(void *, void *), u32 key_offset)
>
> do we need to add key_offset param? What if we read key_offset from map->=
htab->key_offset?

Ah, but this is used for both bpf_htab and bpf_rhtab, so container_of
doesn't quite work. We could depend on the fact that map is the first
element of both bpf_rhtab and bpf_htab, but bpf_rhtab doesn't have
key_offset since it's always `offsetof(struct rhtab_elem, data)`. So
we'd have to add key_offset to bpf_rhtab for that to work, and that
seems like overkill vs adding the param here.

> >  {
> >       struct htab_btf_record *hrec;
> >       int err;
> > @@ -571,6 +577,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, str=
uct bpf_mem_alloc *ma,
> >       if (!hrec)
> >               return -ENOMEM;
> >       hrec->key_size =3D map->key_size;
> > +     hrec->key_offset =3D key_offset;
> >       hrec->record =3D btf_record_dup(map->record);
> >       if (IS_ERR(hrec->record)) {
> >               err =3D PTR_ERR(hrec->record);
> > @@ -593,9 +600,9 @@ static int htab_map_check_btf(struct bpf_map *map, =
const struct btf *btf,
> >        * populated in htab_map_alloc(), so it will always appear as NUL=
L.
> >        */
> >       if (htab_is_percpu(htab))
> > -             return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem=
_dtor);
> > +             return bpf_ma_set_dtor(map, &htab->pcpu_ma, htab_pcpu_mem=
_dtor, htab->key_offset);
> >       else
> > -             return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor);
> > +             return bpf_ma_set_dtor(map, &htab->ma, htab_mem_dtor, hta=
b->key_offset);
> >  }
> >
> >  static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> > @@ -618,6 +625,13 @@ static struct bpf_map *htab_map_alloc(union bpf_at=
tr *attr)
> >
> >       bpf_map_init_from_attr(&htab->map, attr);
> >
> > +     /* Avoid hash memory use and comparisons where unnecessary.
> > +      * u32 hash reads are always atomic. If we elide them, key compar=
isons must also be atomic
> > +      * to avoid false positive key matches due to torn key reads / wr=
ites. This is only possible
> > +      * when the key fits within a word, so check key_size.
> > +      */
> > +     htab->has_hash =3D htab_is_lru(htab) || htab->map.key_size > size=
of(unsigned long);
> > +
> >       if (percpu_lru) {
> >               /* ensure each CPU's lru list has >=3D1 elements.
> >                * since we are at it, make each lru list has the same
> > @@ -640,11 +654,13 @@ static struct bpf_map *htab_map_alloc(union bpf_a=
ttr *attr)
> >       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);
> >
> >       if (htab_is_lru(htab))
> > -             htab->key_offset =3D sizeof(struct htab_elem_lru);
> > +             htab->key_offset =3D offsetof(struct htab_elem_lru, data)=
 + 8;
> >       else if (percpu && !prealloc)
> > -             htab->key_offset =3D sizeof(struct htab_elem_pcpu);
> > +             htab->key_offset =3D offsetof(struct htab_elem_pcpu, data=
) +
> > +                                (htab_has_hash(htab) ? 8 : 0);
> >       else
> > -             htab->key_offset =3D sizeof(struct htab_elem);
> > +             htab->key_offset =3D offsetof(struct htab_elem, data) +
> > +                                (htab_has_hash(htab) ? 8 : 0);
> >
> >       htab->elem_size =3D htab->key_offset + round_up(htab->map.key_siz=
e, 8);
> >       if (percpu)
> > @@ -761,10 +777,22 @@ static struct htab_elem *lookup_elem_raw(struct b=
pf_htab *htab,
> >       struct hlist_nulls_node *n;
> >       struct htab_elem *l;
> >
> > -     hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> > -             if (htab_elem_hash(htab, l) =3D=3D hash &&
> > -                 !memcmp(htab_elem_key(htab, l), key, key_size))
> > -                     return l;
> > +     if (htab_has_hash(htab)) {
> > +             hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node=
)
> > +                     if (htab_elem_hash(htab, l) =3D=3D hash &&
> > +                         !memcmp(htab_elem_key(htab, l), key, key_size=
))
> > +                             return l;
> > +     } else {
> > +             /* When hash is omitted, key comparisons must be atomic. =
Zero extend
> > +              * the caller's key to the word size to support an atomic=
 compare.
> > +              */
> > +             unsigned long k =3D 0;
> > +
> > +             memcpy(&k, key, key_size);
> > +             hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node=
)
> > +                     if (READ_ONCE(*(unsigned long *)htab_elem_key(hta=
b, l)) =3D=3D k)
> > +                             return l;
> > +     }
> >
> >       return NULL;
> >  }
> > @@ -782,10 +810,20 @@ static struct htab_elem *lookup_nulls_elem_raw(st=
ruct bpf_htab *htab,
> >       struct htab_elem *l;
> >
> >  again:
> > -     hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> > -             if (htab_elem_hash(htab, l) =3D=3D hash &&
> > -                 !memcmp(htab_elem_key(htab, l), key, key_size))
> > -                     return l;
> > +     if (htab_has_hash(htab)) {
> > +             hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node=
)
> > +                     if (htab_elem_hash(htab, l) =3D=3D hash &&
> > +                         !memcmp(htab_elem_key(htab, l), key, key_size=
))
> > +                             return l;
> > +     } else {
> > +             /* See lookup_elem_raw() comment above. */
> > +             unsigned long k =3D 0;
> > +
> > +             memcpy(&k, key, key_size);
> > +             hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node=
)
> > +                     if (READ_ONCE(*(unsigned long *)htab_elem_key(hta=
b, l)) =3D=3D k)
> > +                             return l;
> > +     }
>
> This hunk is quite big, maybe move it to a separate function to reuse in
> lookup_elem_raw() and lookup_nulls_elem_raw().

Thanks, I've prepped that for the next version. I will probably send
that in another day or two since the merge window is coming soonish.



> >       if (unlikely(get_nulls_value(n) !=3D (hash & (n_buckets - 1))))
> >               goto again;
> > @@ -1188,7 +1226,17 @@ static struct htab_elem *alloc_htab_elem(struct =
bpf_htab *htab, void *key,
> >               }
> >       }
> >
> > -     memcpy(htab_elem_key(htab, l_new), key, key_size);
> > +     if (htab_has_hash(htab)) {
> > +             memcpy(htab_elem_key(htab, l_new), key, key_size);
> > +     } else {
> > +             /* Zero-extend key into k for an atomic write to support
> > +              * lockless RCU readers.
> > +              */
> > +             unsigned long k =3D 0;
> > +
> > +             memcpy(&k, key, key_size);
> > +             WRITE_ONCE(*(unsigned long *)htab_elem_key(htab, l_new), =
k);
> > +     }
> >       if (percpu) {
> >               if (prealloc) {
> >                       pptr =3D htab_elem_get_ptr(htab, l_new);
> > @@ -3191,7 +3239,7 @@ static int rhtab_map_check_btf(struct bpf_map *ma=
p, const struct btf *btf,
> >  {
> >       struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, m=
ap);
> >
> > -     return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
> > +     return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor, offsetof(=
struct rhtab_elem, data));
> >  }
> >
> >  static void rhtab_map_free_internal_structs(struct bpf_map *map)
> > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/t=
esting/selftests/bpf/progs/map_ptr_kern.c
> > index 373c8d17ea55..6bd4cb68c20c 100644
> > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > @@ -114,7 +114,7 @@ static inline int check_hash(void)
> >       VERIFY(check_default_noinline(&hash->map, map));
> >
> >       VERIFY(hash->n_buckets =3D=3D MAX_ENTRIES);
> > -     VERIFY(hash->elem_size =3D=3D 64);
> > +     VERIFY(hash->elem_size =3D=3D 32);
> >
> >       VERIFY(hash->count.counter =3D=3D 0);
> >       VERIFY(bpf_map_sum_elem_count(map) =3D=3D 0);
>
