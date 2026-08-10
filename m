Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B97440A26
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395245; cv=pass; b=svt9p02jZY3TQ6Klz2fO9/nm1O4HcTTEYtS4IN0CYPKVsEnVI7V7AR19PrEmKJIQgFBzPh46aILKpcYAfF4ReWpCdZK3bHgCgxNBATFtubHWRpAkMOq6oQM8Mu+ySua6FDKnAl6TZOTNa6eUzLes/jMDSEzosEXy6saJ4ijjhL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395245; c=relaxed/simple;
	bh=wWO1R5iW+3lbBA+UquVqFB5JjV6n/SrFZrrZTw5YfhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG7rW6OQjnuX0/k7xLqmJBGpQkU8rTs2xgVDc1qS0f1HRvcRrQcTfZgmhpDS3qWMrqpDEjKTootIwlsverEzYdeFbVHxrlwcjbK+8kOcA/ProwaR8mExJoSkKLwsDQSIg79t25b/BLyAYYMYRGAxp0HdrihSKFVRVibpJ0cq3dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0octypa; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0octypa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4994d67d260so6275e9.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 13:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786395242; cv=none;
        d=google.com; s=arc-20260327;
        b=cvmW7pNEZ1msyILSO0vcc2sdOy3rnXXYNR3OnY+y+A8MKTHZzOKI65QaXfSieI5cqU
         AscVBSItkQVLVzAelltPYZGQLXlLXbHCORxExYkA+C4ZTzZBY3cg4nLjcj83ejmM+Slc
         gQUUxHkozf2RxW41YC+QQfTOkZs8pFNlea+mn/2B8izQBdSQNpCt3MhA6TF4/2XErGsS
         U4buYV3y1996wX9Ux8wqgWZy1I0UXkrxFijQ8xKywuVouKVfecynAFWd4d+tDDTHzRgI
         wsFDW7e7VyP1AD0mHB0v3bRHKX9l3AkJOalh+cvTpjEAyS4hmh9/cjmVF4BcaCAPT9Nx
         CxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZyDMZlNYEEbu1aLIM8R0k+H7EZsqSyUl/Im6MARLZw=;
        fh=N+nc9Ekw9/5ldiIz4X5+TpqZ5LsyEz6uQvy2ae4SSUE=;
        b=Xfy277xf911IIeC/xAPAq8KdDDby4w4qKNLU9TMF0C4CognumplmBNUQQemCBMepIF
         ewta61plpW+9IxgH/uHyuirI03xRmgA7Pni2gZKmZbkBL5MOwBvPkRk+ppT780aVmjzU
         re8rWr4sU7RJNzcdAU56vy+jEWQruFPSLqIZDvXcNRFIjzVn0+Tze+m95pUwP+hvTHDk
         v4AHG5FiW2AQvCjSqfo1PcP/f46CH9uZ4filTLJFOZqTG99Vn4vexPj/rHovmv+YrFc5
         amVno1eVVzcR3NeM1Bza6QnFfE+kZbaTkJre60JjRYVf4xl0XNlR9Oi+ZjTrkFeP5Itr
         VG+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786395242; x=1787000042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZyDMZlNYEEbu1aLIM8R0k+H7EZsqSyUl/Im6MARLZw=;
        b=B0octypaWOH/OMyhD80VB0L0XPbcEokzNHVuUPc3K0quhaNucPWSKBC6doYvsLpN9g
         YBrJGzBhoS0Zlr9rO5GWVxYAenQ7EuIB+EuFB0uMo7RZ9jwR8Y5yx/mO2djony9gb4qd
         1g9dLj+xK7dqZN/99Kzxvk381v9k8Qc6JDbN47YXpqpUSCHur2878nRuqAcfY0ZK3s//
         pLI5vW8ghmndDoVSCVx5s7PQRek5eQF8nGNcakNxb3IMLtZ3tqvnqaVLkjoqX0vAdzy1
         JJ5hJWrLrkOeTUdQ0oT6Q4v6Y8A7SrP9nL7ig02SX0NwQFkft+3QgEhOyB9wb3tdGYj9
         ZcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395242; x=1787000042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZyDMZlNYEEbu1aLIM8R0k+H7EZsqSyUl/Im6MARLZw=;
        b=gRT6B1XXLyH0tm4zicXHg+ZM7vmKstWTa+lf0WJgv8E1kT5hoBNzH5k4odk91ik1fC
         6X+nIlnf1opSTkdm1BtXT6WKTjby0bL5P5iLod3My+/Dzt3pjftFkCh8FnyBfByvli0s
         ufM7utEomLUqWxhMsp39s+qBVG09iEmVSYNkKSvs7xUs64SJAQBwtEoZNwca8Iq/7Tui
         XgPvJoY4P+pWCHaU3O1ama5KI84JhcqZLHqAbXBDVmA3wAjMf34EpAlTAi4yIzlP4zLs
         S9ITpT4QccGoebrOLaNnHCHBJfB+OHzcwTEauS4dg2ATSwSWxEJVOHYnt7MfmTWnklzW
         5rsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiVBjS8MeRuq4o35k+PBWrmJIGQMN2bInLCTs4djVPw9aU5KIg1RV4FNhNc6Fonsc2auA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJ8uGkXWJwg0XBPm6Joe5DoegRZ6g2HD5IQ0NjAtc4+4eNriS
	s8novs3vKgRmiEIZqqyiW7XEWyNLXh+PVllBsQ0cFA4XT33V41nfBSrvnYYEkWYXNwxwAUtS+4H
	c6CfRkIht7Ai4odrK3enEJ2VUgelCd6DGeFStulTS
X-Gm-Gg: AR+sD12JOM3c8A+RQkfYnM0hlU6FbBXwEFS2nIov04h9zkHWZin6+apE5JJ9FNpXt9f
	IGNFZkg3m2WjXrbaVbZl8U0ygm/nse3mKmtXVSYyqWxv1ufjIIHWHnL9tO8X8kN/aH4k+FEFJyi
	9RE7Ja76G+eLfofWMPtkbOMGFA7H2IdehP+BH1t5E+Sw/fQptvA/hdcakAr5xt3rwKhsDnhf1pE
	Q0MdJSThu6WJbZ7CDvKdWujPawsYfUrNT7WsCh4G+DzLkd2PfkpXlbqw2us5o+mjk+70r2ok30C
	7GQC5SwaWF8xwIl0bPjABvTEalkFFAAgeL1jD24ozVmUGo/66bPE0hlQB0KGVsXZEQkrnHJuHF1
	7yeuYNMWD0b7fz/WGTnjFgd+3ZQHtTVs=
X-Received: by 2002:a05:600d:108:20b0:495:4593:616c with SMTP id
 5b1f17b1804b1-49975c21896mr97115e9.1.1786395241437; Mon, 10 Aug 2026 13:54:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805223516.1495988-1-tjmercier@google.com>
 <20260805223516.1495988-2-tjmercier@google.com> <e417cb09-8466-4d9e-9d33-7330d84df12a@gmail.com>
In-Reply-To: <e417cb09-8466-4d9e-9d33-7330d84df12a@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 10 Aug 2026 13:53:49 -0700
X-Gm-Features: AUfX_mwQi093HuxHPQ90nlznKhMNpxLGKwC-JDmHT7GfWtuPg7zXaBbEWiAKPQk
Message-ID: <CABdmKX1rWLGyJsrtQopybUzuU-bMe55JqYKPMr1NBd_Yd1K+6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:25=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 8/5/26 11:35 PM, T.J. Mercier wrote:
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
> >  kernel/bpf/hashtab.c    | 362 +++++++++++++++++++++++++---------------
> >  kernel/bpf/map_in_map.c |  13 ++
> >  kernel/bpf/map_in_map.h |   2 +
> >  3 files changed, 242 insertions(+), 135 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 9f394e1aa2e8..f54366da459f 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -102,11 +102,13 @@ struct bpf_htab {
> >       bool use_percpu_counter;
> >       u32 n_buckets;  /* number of hash buckets */
> >       u32 elem_size;  /* size of each element in bytes */
> > +     u32 key_offset; /* offset of key in bytes */
> >       u32 hashrnd;
> >  };
> >
> >  /* each htab element is struct htab_elem + key + value */
> > -struct htab_elem {
> > +struct htab_elem;
> > +struct htab_node {
> >       union {
> >               struct hlist_nulls_node hash_node;
> >               struct {
> > @@ -117,11 +119,27 @@ struct htab_elem {
> >                       };
> >               };
> >       };
> > -     union {
> > -             /* pointer to per-cpu pointer */
> > -             void *ptr_to_pptr;
> > -             struct bpf_lru_node lru_node;
> > -     };
> > +};
> > +
> > +struct htab_elem {
> > +     struct htab_node node;
> > +     u32 hash;
> > +     char key[] __aligned(8);
> > +};
> > +
> > +struct htab_elem_lru {
> > +     struct htab_node node;
> > +     struct bpf_lru_node lru_node;
> > +     u32 hash;
> > +     char key[] __aligned(8);
> > +};
> > +
> > +/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't n=
eed
> > + * ptr_to_pptr, and use htab_elem.
> > + */
> > +struct htab_elem_pcpu {
> > +     struct htab_node node;
> > +     void *ptr_to_pptr;
> >       u32 hash;
> >       char key[] __aligned(8);
> >  };
> > @@ -136,6 +154,21 @@ static inline bool htab_is_prealloc(const struct b=
pf_htab *htab)
> >       return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
> >  }
> >
> > +static inline struct bpf_lru_node *htab_elem_lru_node(struct htab_elem=
 *l)
> > +{
> > +     return &((struct htab_elem_lru *)l)->lru_node;
> > +}
> > +
> > +static inline void *htab_elem_get_ptr_to_pptr(struct htab_elem *l)
> > +{
> > +     return ((struct htab_elem_pcpu *)l)->ptr_to_pptr;
> > +}
> > +
> > +static inline void htab_elem_set_ptr_to_pptr(struct htab_elem *l, void=
 *ptr)
> > +{
> > +     ((struct htab_elem_pcpu *)l)->ptr_to_pptr =3D ptr;
> > +}
> > +
> >  static void htab_init_buckets(struct bpf_htab *htab)
> >  {
> >       unsigned int i;
> > @@ -183,25 +216,30 @@ static inline bool is_fd_htab(const struct bpf_ht=
ab *htab)
> >       return htab->map.map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS;
> >  }
> >
> > -static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
> > +static inline void *htab_elem_key(struct bpf_htab *htab, struct htab_e=
lem *l)
> > +{
> > +     return (void *)l + htab->key_offset;
> > +}
> > +
> > +static inline void *htab_elem_value(struct bpf_htab *htab, struct htab=
_elem *l)
> >  {
> > -     return l->key + round_up(key_size, 8);
> > +     return htab_elem_key(htab, l) + round_up(htab->map.key_size, 8);
> >  }
> >
> > -static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size=
,
> > +static inline void htab_elem_set_ptr(struct bpf_htab *htab, struct hta=
b_elem *l,
> >                                    void __percpu *pptr)
> >  {
> > -     *(void __percpu **)htab_elem_value(l, key_size) =3D pptr;
> > +     *(void __percpu **)htab_elem_value(htab, l) =3D pptr;
> >  }
> >
> > -static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u3=
2 key_size)
> > +static inline void __percpu *htab_elem_get_ptr(struct bpf_htab *htab, =
struct htab_elem *l)
> >  {
> > -     return *(void __percpu **)htab_elem_value(l, key_size);
> > +     return *(void __percpu **)htab_elem_value(htab, l);
> >  }
> >
> > -static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct hta=
b_elem *l)
> > +static void *fd_htab_map_get_ptr(struct bpf_htab *htab, struct htab_el=
em *l)
> >  {
> > -     return *(void **)htab_elem_value(l, map->key_size);
> > +     return *(void **)htab_elem_value(htab, l);
> >  }
> >
> >  static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
> > @@ -209,6 +247,26 @@ static struct htab_elem *get_htab_elem(struct bpf_=
htab *htab, int i)
> >       return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_si=
ze);
> >  }
> >
> > +static inline u32 htab_elem_hash(struct bpf_htab *htab, struct htab_el=
em *l)
> > +{
> > +     if (htab_is_lru(htab))
> > +             return ((struct htab_elem_lru *)l)->hash;
> > +     else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> > +             return ((struct htab_elem_pcpu *)l)->hash;
>
> These casts in getter/setter are a bit annoying, not sure if there is a w=
ay to
> get rid of them.

Since this is only called for element types that have hashes, we can
use the fact that htab_elem_key() is always exactly 8 bytes after the
the hash.

return *(u32 *)(htab_elem_key(htab, l) - 8);

Gets rid of the branching too! But sorry, there is still some casting.
And void* arithmetic without even more casting.

> > +     else
> > +             return l->hash;
> > +}
> > +
> > +static inline void htab_elem_set_hash(struct bpf_htab *htab, struct ht=
ab_elem *l, u32 hash)
> > +{
> > +     if (htab_is_lru(htab))
> > +             ((struct htab_elem_lru *)l)->hash =3D hash;
> > +     else if (htab_is_percpu(htab) && !htab_is_prealloc(htab))
> > +             ((struct htab_elem_pcpu *)l)->hash =3D hash;
> > +     else
> > +             l->hash =3D hash;
> > +}
> > +
> ...
> >       htab->extra_elems =3D pptr;
> > @@ -425,8 +481,8 @@ static int htab_map_alloc_check(union bpf_attr *att=
r)
> >       bool zero_seed =3D (attr->map_flags & BPF_F_ZERO_SEED);
> >       int numa_node =3D bpf_map_attr_numa_node(attr);
> >
> > -     BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=3D
> > -                  offsetof(struct htab_elem, hash_node.pprev));
> > +     BUILD_BUG_ON(offsetof(struct htab_node, fnode.next) !=3D
> > +                  offsetof(struct htab_node, hash_node.pprev));
> >
> >       if (zero_seed && !capable(CAP_SYS_ADMIN))
> >               /* Guard against local DoS, and discourage production use=
. */
> > @@ -476,7 +532,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
> >       if (IS_ERR_OR_NULL(hrec->record))
> >               return;
> >
> > -     map_value =3D htab_elem_value(elem, hrec->key_size);
> > +     map_value =3D (void *)elem + sizeof(struct htab_elem) + round_up(=
hrec->key_size, 8);
>
> Why this can't be htab_elem_value()?

htab_elem_value() requires a struct bpf_htab pointer, but we can't use
that here because it might have already been freed.

> >       bpf_obj_free_fields(hrec->record, map_value);
> >  }
> >
> > @@ -583,8 +639,14 @@ static struct bpf_map *htab_map_alloc(union bpf_at=
tr *attr)
> >
> >       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);
> >
> > -     htab->elem_size =3D sizeof(struct htab_elem) +
> > -                       round_up(htab->map.key_size, 8);
> > +     if (htab_is_lru(htab))
> > +             htab->key_offset =3D sizeof(struct htab_elem_lru);
>
> nit: I think it'll be nicer to use explicit offsetof().

Yeah it does get changed to offsetof(data) in the second patch, but
I'll change it to offsetof(key) here in the first patch too.

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
> > @@ -692,14 +754,16 @@ static inline struct hlist_nulls_head *select_buc=
ket(struct bpf_htab *htab, u32
> >  }
> >
> ...
> > @@ -912,18 +982,19 @@ static int htab_map_get_next_key(struct bpf_map *=
map, void *key, void *next_key)
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
> >
> >       /* key was found, get next key in the same bucket */
> > -     next_l =3D hlist_nulls_entry_safe(rcu_dereference_raw(hlist_nulls=
_next_rcu(&l->hash_node)),
> > -                               struct htab_elem, hash_node);
> > +     next_l =3D hlist_nulls_entry_safe(
> > +                     rcu_dereference_raw(hlist_nulls_next_rcu(&l->node=
.hash_node)),
>
> nit: I think this line has not changed.

->hash_node got changed to ->node.hash_node putting the line width
over 100 chars, so I wrapped it.


> > +                     struct htab_elem, node.hash_node);
> >
> >       if (next_l) {
> >               /* if next elem in this hash list is non-zero, just retur=
n it */
> > -             memcpy(next_key, next_l->key, key_size);
> > +             memcpy(next_key, htab_elem_key(htab, next_l), key_size);
> >               return 0;
> >       }
> >  ...
