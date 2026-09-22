Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798B49B44A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106207; cv=pass; b=OUnZFHwqY85FjNhTUARvSG+3UlXDPJghsakfCBn3uYBUmoJjlupoc12ZsQ7lIKDxIGbIIupGWtuMrYzdT37CcJ0JGedm33tFuIHp7Ndv3+0VB4cF4rV00lIvzJ0ywqNwVaq7E+U9U8atoJCp0C7Jo3hd3PxqBMvaYtwYPkqFH2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106207; c=relaxed/simple;
	bh=t56WzzMf+xL2l+ym6WmEghqyiAF7e2iQIkVLYDBSHto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsQhyhE9f/6SBx43kBjT0iEzV7MaZD0R1TcEAeIjAjn9EkxeAmhfXQAf9xHHEIKbkfmsrAFdzXHcZs/rl8LYVj3EcBgZ/fRDEHEL0YU83Wiq4OukYPhL5KenAJo2W440mvRE9joSMvIvGrHEYxN47RMC6eQpu/+zSDfBSg0NO1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR6AYisH; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR6AYisH"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso180592a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 12:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790106205; cv=none;
        d=google.com; s=arc-20260327;
        b=eGUCqFsbT6nBt4EJfvfVLb1jjWk/xNdPLaWpm7AAAuLWcM2ca/9bhULbOBMiI8prOn
         54EOkq6P3xABThEMbsIVMfophPEbTkRuEGeLf0q8NdVzi/v1vNj1DnaphiqAEYCVq6WP
         0Y2p8Js0II946VUFkdHrRi6IMCP+em2V/to0hPe0oRGOb7uF3q5/TbYsSbM5xVhFVvOP
         PWEayflZcvHrINNoNJpvFAhG5ITm+PAKLtLDzhrtOytN5BnhLQum8kLeTlRUZCsUydrl
         mBkcDXOHBLXlzW5vFQaRxQP+8Fnrgv0P6FbhagPaLMJDk+us1rRW/JtlyEaSW8caFcJy
         WiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r89UVCo6ULUFxYqmvwhZSMr5UIMq4cGKIinWgU1STPg=;
        fh=C7vKEYvi5hDFL3YByi3euORWsnMT/+JLAcwjVdFEqzM=;
        b=Aev/W6Kr4nvGjZpqviP4TBXAvLNWvv6g94H1HJWPki36Ld9+eQ3Vw0h7UDcS4AErUl
         xjjyKXbwo8VvC5/crqZVF4IumYcvStZhHZDQ3E9rQyDmBs2voaF9JYqYN6wgniuN+Fwf
         cODW5Zn2JLGQegM+o/LRLxSkdv53Cgny57lsklI2vMSkV2SuEMxxyXOUadOcgio2LGU1
         XU+cY4fqPmWEy78i7a0acQ+jph7MJPe6XySK7Evzygx5/4NZRimO6wdhTMoM29V+M912
         uIXuA0YyEGbn4c+wpJNo09BAicHOoHevSZwm1hobZWrJOriYIaCg23Z+7zbI/RVEn8FX
         U2Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790106205; x=1790711005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r89UVCo6ULUFxYqmvwhZSMr5UIMq4cGKIinWgU1STPg=;
        b=lR6AYisHaC4aAK+1hsA+D2y0x4Gux0HTi3f85NwT2h4wIKIymhhLgLd1Qb9hKJCR3U
         632PPwSZ39gC96lFx5ixu80lsuZMgT1o0c1M8xXYNwKQX6CfC7W0yaagt92Fm9HWXz47
         h56Q9YeeP+5kP019e9DQUTxhYTmx/ENfbECnEXJmqCJoOIvI094Un3I/7pPQc078Q3jX
         OWTv1iF8FuI+b96QyIOktQ2pP/u3+5f5BnLYkJmDOzDTFvViPx8G4JQ21H7W8FiwqmXy
         Zd6Vgp6EZM+lujXQR7S3RBUQmjcf8eRmmeOsJLCrTqiUrFbTvXoFv3qKQ9yj+4py3ZhD
         H6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106205; x=1790711005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r89UVCo6ULUFxYqmvwhZSMr5UIMq4cGKIinWgU1STPg=;
        b=PtbriQNohZc3/PZEwbq/pu8U1HZ+jopM4gjaR0bbVkmXmxUHGYU79my+QmRBCgX8uv
         lzPWGYFd80IVayEfA30U3wTZbFnjAwcfMN1sMdvitNvWtkCnRPQ5fOi530fY9UrJFwLK
         nCufgv/v97GsiRuZRiP1WAHz7Cv9D5TTjjn6j0tLTa2/2L4YkhLZ3Eql9hY+M9CW45M5
         neMaRcXfTLT5DUOiLBOQPh0WrtrbaI6TYKRnCb5D0M5d1gCEDyhcYlQkMTznbEKNQWwf
         GEqsNkuUC5zt6r+9u1vbq04cytPyXch4kEYl0imFt7PgcZAyOWBmfRLnGevl9yNAXHaZ
         dEkA==
X-Forwarded-Encrypted: i=1; AKwUvBxdoGtvoFBMk/ZJOpHmaYNFdq0LqhhvcpqavbxjxmHwNUfo5LCoyLUuMchqDTdPTMyB3VY=@vger.kernel.org
X-Gm-Message-State: AFuF++mtbCA9YUl5GkyWbPnGE4J4h1jFkxiOU8CgXAqdsghfKG3VWCLx
	KlOyB4pNmT0lao5FJYuSOydpuKS4vhyJOOxC4ZET0uHh5AniauCAc7VwoNOlxJl4WRZNbyhsgSr
	Y3ZdhNfDor6N1Rqp2XbR2Fhuxqkwyk1c=
X-Gm-Gg: AYBFou1iHCWlFP7sXf/OGe/ui2Egar/E5HUZrQz2jYpWBlgnLgtF0mq8T+zZonv1MGZ
	1R6AzfWbbtOnJIzKFg2VJApKN+Spx77d5QqlH7jrPGnCRu0GNeItbcZFAJ8eyOXmQGm/4PNMRNL
	/nW4q6S0LJ03KyPwbHNQ523E3MDGvCJ//i9G75n+Q0VQ7rh5xdeVC/abd/boSAI4hLMeXkC+5As
	neztwkQiKS+su+xDgi3vg3McGvpzo38bnED9Y7IL35jBhbfun1440Q01+Xv755m6Gb8DuhlC2KT
	GuQYKRmhW44lLmiuSMQKzW6q7UZXcltTYEHXKN9HtQFHxDst9Q+YB/moKGxWcqetveLaRIkPigr
	gEIG6mfSS+WaCXwJReP4StP5Ub3l2aXZMFCyoOWKEz32mEzucpGaG
X-Received: by 2002:a17:90b:4983:b0:39e:4498:4863 with SMTP id
 98e67ed59e1d1-3a07e562326mr386153a91.10.1790106204991; Tue, 22 Sep 2026
 12:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-3-ihor.solodrai@linux.dev> <CAEf4BzYXbPCAjbEg=E-VR-7owN3hGqE32OVTWRrWhPqDQVnC4w@mail.gmail.com>
 <e356ea48-b9a6-429e-bf30-18c0e079e01a@linux.dev>
In-Reply-To: <e356ea48-b9a6-429e-bf30-18c0e079e01a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Sep 2026 12:43:10 -0700
X-Gm-Features: AcwNN1VF9BWLfdWH3lfsPLR2KdRcyyX3P-j8c16a1C40Mxhz2GNuIqhUfg8W9cY
Message-ID: <CAEf4BzZm+sDM==bLguNxCWXx2ZA3PsdC_0WQ9CkTgn6kXm-utA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 9:59=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 9/17/26 4:59 PM, Andrii Nakryiko wrote:
> > On Wed, Sep 16, 2026 at 6:21=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> [...]
> >> ---
> >>  tools/lib/bpf/btf_dump.c | 94 +++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 94 insertions(+)
> >>
> >
> > series looks good, just small nits below
>
> Hi Andrii, thanks for the review.
> Sorry I didn't reply earlier, wanted to get that REF_TYPE_FRAME stuff out=
.
>
> >
> >> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> >> index 635fa969e145..1e8236c8b9a5 100644
> >> --- a/tools/lib/bpf/btf_dump.c
> >> +++ b/tools/lib/bpf/btf_dump.c
> >> @@ -77,6 +77,11 @@ struct btf_dump_data {
> >>         bool is_array_char;
> >>  };
> >>
> >> +struct decl_tag_desc {
> >> +       __u32 target_id;
> >> +       __u32 tag_id;
> >> +};
> >> +
> >>  struct btf_dump {
> >>         const struct btf *btf;
> >>         btf_dump_printf_fn_t printf_fn;
> >> @@ -93,6 +98,11 @@ struct btf_dump {
> >>         const char **cached_names;
> >>         size_t cached_names_cap;
> >>
> >> +       /* decl tags, sorted by (target ID, tag ID) */
> >> +       struct decl_tag_desc *decl_tags;
> >> +       size_t decl_tags_cnt;
> >> +       size_t decl_tags_cap;
> >
> > nit: decl_tag_cnt, decl_tag_cap, "count" expects singular noun before
> > it: "table count" not "tables count"
>
> ack
>
> >
> >> +
> >>         /* topo-sorted list of dependent type definitions */
> >>         __u32 *emit_queue;
> >>         int emit_queue_cap;
> >> @@ -192,9 +202,37 @@ struct btf_dump *btf_dump__new(const struct btf *=
btf,
> >>         return libbpf_err_ptr(err);
> >>  }
> >>
> >> +static int btf_dump_cmp_decl_tags(const void *a, const void *b)
> >> +{
> >> +       const struct decl_tag_desc *x =3D a, *y =3D b;
> >> +
> >> +       if (x->target_id !=3D y->target_id)
> >> +               return x->target_id < y->target_id ? -1 : 1;
> >> +       return x->tag_id < y->tag_id ? -1 : 1;
> >> +}
> >> +
> >> +static int btf_dump_push_decl_tag(struct btf_dump *d, __u32 id, const=
 struct btf_type *t)
> >> +{
> >> +       const struct btf_type *target =3D btf__type_by_id(d->btf, t->t=
ype);
> >> +
> >> +       if (!target || (!btf_is_composite(target) && !btf_is_typedef(t=
arget)))
> >
> > target shouldn't be null with correct t->type, don't add defensive chec=
ks
>
> According to comments, decl_tags technically can refer to a type that
> is not the BTF yet:

that means only during btf construction, I'm not sure how dumper
should behave if you pass it decl_tag that points to non-existing
type... erroring out would be one way, but silently ignoring is
probably not a right way anyways.

but as you said, I don't think anyone should pass half-constructed BTF
to dumper and expect that to work... incremental still means that any
point btf is correct and complete

>
> tools/lib/bpf/btf.c:3314-3323:
>
>   /*
>    * Append new BTF_KIND_DECL_TAG type with:
>    *   - *value* - non-empty/non-NULL string;
>    *   - *ref_type_id* - referenced type ID, it might not exist yet;
>    *   ...
>    */
>   int btf__add_decl_tag(...)
>
> Granted, I wouldn't expect this to be a real use-case. But if we
> decide to drop checks like this, then I think we should be explicit
> about "no incremental dump", and maybe simplify relevant code a bit.
>
> >
> > but also why this artificial limitation on the kind of thing that is
> > tagged? memory savings?
>
> Yeah, I guess the effect of this is memory savings, but that wasn't
> the motivation.  I just thought "why collect tags that we are not
> going to dump?".  But the index can collect everything, it shouldn't
> affect the dump. Do you think we should do that?

I'd collect everything to keep this part of logic complete and
forward-compatible without having to revisit it

>
>
> >
> >
> >> +               return 0;
> >> +
> >> +       if (libbpf_ensure_mem((void **)&d->decl_tags, &d->decl_tags_ca=
p,
> >> +                             sizeof(*d->decl_tags), d->decl_tags_cnt =
+ 1))
> >> +               return -ENOMEM;
> >> +
> >> +       d->decl_tags[d->decl_tags_cnt++] =3D (struct decl_tag_desc) {
> >> +               .target_id =3D t->type,
> >> +               .tag_id =3D id,
> >> +       };
> >> +       return 0;
> >> +}
> >> +
> >
> > [...]
>
