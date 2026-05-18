Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846C18C332
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075260; cv=pass; b=kGRNyRlsUWAAQiN/IYtk7DH14XlOV8n5m44QcYbCEeFgOfUw/uidItUQyQr3QmWTGHYT2/YKzmz1DKVuMfv2i2y9L3bZu7H2pMd7xWXy5yZBSvS5t4jVwM6DzIpM5OConTxqyrhaxAIPjgW+Fh9z5YdZ8K7mmL6OZHcLjh0D3bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075260; c=relaxed/simple;
	bh=NFGYR/wcp66AA/oTdBkMNaxqsM7q3cXaHBaOtCqRPDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR2b9pok6kuX9yePFhq6D3rC94TF4LL5r1adfIsi7XvWWcaep8ZxertBr4vLhUhKRWWMyXif1JdxoNcz8FZAV3Z10BELC2s3ERsjmN8I+aRWUoxPgDIX9e+ZFPIKjqjKJWB3PfiIbNxqZpetUZeWXi4/JzG2TcOCtshZrBpS9T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOYkAsWK; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOYkAsWK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso13536215e9.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 20:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779075257; cv=none;
        d=google.com; s=arc-20240605;
        b=JrrKAprM2N2EWXLaCXkkbReJxh+mysVueUKW+zDkezNC7TYwp0HoL/w8OjG6kTYDhJ
         0/BcDJSX33tLgBWbyGvAoSq5ALYbqFCrcqpIkesHUUAteQMKrPBaY8XJbXFlk106mXjo
         naq/rAs9VZAnntQHW1DvMPBMeicC0Ch39MPA5lSCxf0sSVMnmf3m4JaYDjzcLuygEH75
         sIVBCgZ3qH9Tr57b2WCu0Xgcuh9n39zziJBcVQilJLy2RbOqUF1SdpGyLff5INcvZz3e
         Pwk1SYyYUANdUzBRhvzItWaLOaoEyNy0IPMqOvrVJmwQH0w/xGynazsy1zjhM8VXBFBT
         BXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLIHXSEtBj1Y3zXlgtyNF1FdnWRyVIYeVkWci6GRUrs=;
        fh=VjcWLqoPViBaPCqpkFoB7lkEm5jwOZ6ITtd0a5Q1ro8=;
        b=R2NQ32Dg+usK4qfM6wNtwqI/erYzwA+ZIjuaKfRK5tX0h8A1uUQlx7wG/cEPBEcylD
         JtAVjLhTozTR0bKlUdMLa4pek94E7QEi5liMEvydoTAFyVKXEhVXq5ScZDWeq0Q4wisz
         MVxlxrv+tkhtqvWSkhmLCKZzZAr+Z7GkZC1S3y7yZNFVFIWjnqFVGecuAfVDzPfow1eP
         TKjHEwNfeQPh9FvF1kfhshpwrOGEoses4DB26LBxg3Rj97uTUvHSOr7Fx0ZjV7umL3pL
         VfS3Vuq7u4Wr0vB9C/5TmzAOBFq5ii3qXwygWNQyMwUIDsstr5sMm89cO7PExnLIstXz
         Ncmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075257; x=1779680057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLIHXSEtBj1Y3zXlgtyNF1FdnWRyVIYeVkWci6GRUrs=;
        b=sOYkAsWKr8nrA2P2PTxbIE9UrZI6pyLLU9lt2ThtuH6QfElL+cbVRvIXIeUSniZzrF
         5J85//bzJ9PDIvsI2F3F5/IbkswBSFdH+uCnifo7+19mZ2hB2++FE5rLg5WSxF8os3q1
         CNd00Gfr+ywfjlWcLV4rBCwor57R9Od5DsUcNbrZja8HP3IKy89SAUEOrnrZbQun5Rxi
         hled0f+LIa3ZB5z9kdKgRu6nE9xTPkNkvOxd8biRiI0upqtESEnpcoz2J66AXbt+kzYj
         TbNM7kNmwXXEhgoiHxfdgUjmTVxaoo1c6cDjjze6JSPQflAi9EWkWov6MXT3MmxSuO0t
         iALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075257; x=1779680057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLIHXSEtBj1Y3zXlgtyNF1FdnWRyVIYeVkWci6GRUrs=;
        b=oclNB5XizKpMQhLjts6skbrZqdKwzIpO9LwSWn6J4H7tbKmghv4vIMe99cDWjK+V1w
         qVFtHqQotyqvMGp5k5TMvhnSuTBFvyZpryrWiaSAireTxCb8tAAsQFGnBTU/E3yVK2tN
         3igXYKqwBDM0GsIYxJ1cYgOHTjy+SXwlfMT+nezZ3dg81qVndsAfvIQwfIfQPnIWMbyi
         TDS6v0npANrF8pPFWLSc+gw9EusrTbTcPlRJM/WZ90s/mXhR3V++28+gBbA28n5xo3mQ
         xm0COOx4VxD0Wqe8XC51U7AE7g8/p9sl9YwEpvpqUY/PyfS8ojsi2euohcuDNDE8w3UH
         PdAg==
X-Forwarded-Encrypted: i=1; AFNElJ9fNV1n7RrV9Y0DP87v3PTYopx4a83+MlG79Xxsc4Yx9JQdkGNemhqg4cAxPTyUW0ujB6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9h9mSsrAuP3Ud15YhB/kv46ItD46FmyIqYy1Wp4mp3tTnPv3
	/XxboH9XriTD/wdDV2LZvI7qOnMMJx2Z1haugpQvYSzE+9/OwqtgZ/3aNKVxzFmXocmUSTSNyXA
	AFMvbSe7IJvVIzDraGej3Q+q2hMSEf+o=
X-Gm-Gg: Acq92OHoG2bJNj5f2QLNBJY5ycfxtpVAruM75qe2FEk4c8nfPQM0JgnJc3/7ihV2hrB
	xyJqRnTmHXc0yMtoQl8ESbfXihLC+8/vtVd2trL+PrToLIenfwOXDeoeqnw3n678Ftw6PSb0wKa
	8D9DchiXv//sykyMR1Piit1P89jjiELeaJn9+7oWNggC4VZ3ttyaGz2KerXSJGGGS2107lf7ISD
	XMyykFr2e8/5yeu9/RyGhCnpiOh7q0zTjsANi91crYxc4/2ix9wme995CvUIZElMY5dgWvdc7AU
	xKzB71p+mXiGun3Wx43Hhhh2bjNNdLpFQODAgW0iykCsEQXFUDWtlUstf42yfqyGxdzbWAjODNa
	USmiMBGilGueGDu5CVBo+dvTL9G4Tq1D0FLMY
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fe6328bb7mr220974775e9.21.1779075257090; Sun, 17 May 2026
 20:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-rhash-v4-1-dd3d541ccb0b@meta.com> <95f425fece8396e78971f50a19a7a1222c044417ec12a4b997ff9e5383cd804a@mail.kernel.org>
In-Reply-To: <95f425fece8396e78971f50a19a7a1222c044417ec12a4b997ff9e5383cd804a@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 May 2026 20:34:06 -0700
X-Gm-Features: AVHnY4Krd3-s0F0kc4cNSxZOWNrpP_vT9aHgl8xHffGTvR4tFEqkM2lpQnV4DkA
Message-ID: <CAADnVQKz5wDt6i23296bQy=D51-GgjSb9oGQt4EhnK_um9pDbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/11] rhashtable: Add rhashtable_next_key() API
To: bot+bpf-ci@kernel.org
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 4:21=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> > index ef5230cece36..edf4d4c5102e 100644
> > --- a/include/linux/rhashtable.h
> > +++ b/include/linux/rhashtable.h
> > @@ -650,6 +650,91 @@ static __always_inline struct rhash_head *__rhasht=
able_lookup(
> >       return NULL;
> >  }
> >
> > +/* Internal: scan one element forward from prev_key's position.
> > + * Returns first rhash_head whose bucket >=3D prev_key's bucket and
> > + * (if within prev_key's bucket) appears after prev_key in chain.
> > + * Returns first element if prev_key is NULL or ERR_PTR(-ENOENT) if pr=
ev_key
> > + * is not found.
> > + */
> > +static __always_inline struct rhash_head *__rhashtable_next_in_table(
> > +     struct rhashtable *ht, struct bucket_table *tbl,
> > +     const void *prev_key, const struct rhashtable_params params)
> > +     __must_hold_shared(RCU)
> > +{
> > +     struct rhashtable_compare_arg arg =3D { .ht =3D ht, .key =3D prev=
_key };
> > +     struct rhash_head *he;
> > +     unsigned int b =3D 0;
> > +     bool found =3D false;
> > +
> > +     if (prev_key) {
> > +             b =3D rht_key_hashfn(ht, tbl, prev_key, params);
> > +             rht_for_each_rcu(he, tbl, b) {
> > +                     if (found)
> > +                             return he;
> > +                     if (params.obj_cmpfn ?
> > +                         !params.obj_cmpfn(&arg, rht_obj(ht, he)) :
> > +                         !rhashtable_compare(&arg, rht_obj(ht, he)))
> > +                             found =3D true;
> > +             }
> > +             if (!found)
> > +                     return ERR_PTR(-ENOENT);
> > +             b++;
> > +     }
> > +
> > +     for (; b < tbl->size; b++)
> > +             rht_for_each_rcu(he, tbl, b)
> > +                     return he;
> > +     return NULL;
> > +}
> > +
> > +/**
> > + * rhashtable_next_key - return next element after a given key
> > + * @ht:              hash table
> > + * @prev_key:        pointer to previous key, or NULL for the first el=
ement
> > + * @params:  hash table parameters
> > + *
> > + * Returns the next element in best-effort iteration order, walking th=
e
> > + * @tbl chain (including any future_tbl in flight). Caller must hold R=
CU.
> > + *
> > + * Pass @prev_key =3D=3D NULL to obtain the first element. To iterate,=
 set
> > + * @prev_key to the key of the previously returned element on each cal=
l,
> > + * and stop when NULL is returned.
> > + *
> > + * Best-effort semantics:
> > + *   - Across the tbl->future_tbl chain, an element being migrated may
> > + *     transiently appear in both tables and be observed twice.
> > + *   - Concurrent inserts may or may not be observed.
> > + *   - Termination of a full iteration loop is NOT guaranteed under
> > + *     adversarial continuous rehash; callers MUST tolerate skips and
> > + *     repeats and SHOULD bound their loop externally.
> > + *   - If prev_key was concurrently deleted and is not present in any
> > + *     in-flight table, returns ERR_PTR(-ENOENT).
> > + *
> > + * Returns entry of the next element, or NULL when iteration is exhaus=
ted
> > + * or ERR_PTR(-ENOENT) if prev_key is not found.
> > + */
> > +static inline void *rhashtable_next_key(
> > +     struct rhashtable *ht, const void *prev_key,
> > +     const struct rhashtable_params params)
> > +     __must_hold_shared(RCU)
> > +{
> > +     struct bucket_table *tbl;
> > +     struct rhash_head *he;
> > +
> > +     tbl =3D rht_dereference_rcu(ht->tbl, ht);
> > +     do {
> > +             he =3D __rhashtable_next_in_table(ht, tbl, prev_key, para=
ms);
> > +             if (!IS_ERR_OR_NULL(he))
> > +                     return rht_obj(ht, he);
> > +             if (!he)
> > +                     prev_key =3D NULL;
> > +             /* Ensure we see any new future_tbl attached during a reh=
ash. */
> > +             smp_rmb();
> > +             tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
> > +     } while (tbl);
> > +     return he; /* NULL or -ENOENT */
> > +}
>
> In v3 of this patch series, Herbert Xu raised a concern about rehashing
> causing infinite iteration in get_next_key():
>
>   https://lore.kernel.org/bpf/afCNDOhbszgMlGB7@gondor.apana.org.au/
>
>   "The same issue from v2 still exists here. If a rehash occurs in
>   between calls to rhtab_map_get_next_key you could be iterating over
>   the table forever."
>
> This v4 takes a different approach by introducing a new
> rhashtable_next_key() API instead of using the rhashtable_walk_* API.
> The commit message now documents the issue:
>
>   "Termination of a full iteration is not guaranteed under continuous
>   adversarial rehash; callers must bound their loop externally."
>
> However, Herbert Xu has not yet reviewed or acknowledged this new
> approach in v4. Given that he maintains rhashtable and raised concerns
> about the iteration behavior in v3, would it be helpful to get his
> feedback on this alternative design before merging?

heh. bot has a point.

Herbert,
Is it an acceptable api?
I suspect you don't like it.
I don't like it either, but it's a lesser evil we discussed earlier.
It matches the rest of map apis.

Perf numbers are quite nice, so I'd like to move forward.
