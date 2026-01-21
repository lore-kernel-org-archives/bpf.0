Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15247A0DA
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011990; cv=pass; b=Qp+R6zSxLGn/0R08Se5EkMib9lYbi9zJuDGPsoT+QKE97YOWEWsnXFTZfzeNqXPusrL1q0u5baFeIvPJu+Z/Y0dUd1oy9PEvalsUTNDEHOmQRDCj+3mYhjW9KllLltcSQCpwLv7BFzHDf2Kcr8vqDwsBbRxGY+mxU1mvbE51aY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011990; c=relaxed/simple;
	bh=09NOKDVJj6trxa1kaSXP8kGXrD3k9fvCUVw5NqQHsJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptEPlOzRDBW0qZMAOv1ZsrR+DXLFvY1D+rUhV3ctBpp8S6tQJrWbLmjCjfkQwyeeqru6w8VDnZt3eOGml48biDwt8AEr0LMKdMFjHsMaE0HL9y7W8CIxoZCOl+M87RRwXTshfOXLYiglyF9hN+IMH8ohSGy/2MPFCfwH96PtV3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q862qMpW; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q862qMpW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-501511aa012so110391cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 08:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769011986; cv=none;
        d=google.com; s=arc-20240605;
        b=cMyPzV8KNEmgZuBHLXFJ51DHzxnAFGv1Eb9YpO3IIsC1KGCb81Oi2iziYMc+gzetAB
         YjekC996fm1suscoPgvDFL9f/1QUc9xrGuRXtrtIvGjX3v+B1afUpHygqEuBkI3aHeEI
         BDbOM1J0JI0YWd3P69nRVDlFnAmorQT4xVbyuBAgqH3Ss67uwsrMki/pxHJRUmXz+4p8
         zDzQ4Rc8LrJgPr0UyAopne1fEKI0G0fMxs/paWSIeJY2yhyJgC+oVrp64FJIGzWBObVy
         pIjqM1EPE1ER4nnsYOG++wtRW3wywTG9BH8k4psF91n+yxemz1mNlX25hm3qGNArn7+r
         EXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1GwHpmSY+Ssuo+YrlkBnP/wYaSl4q4+E3mKjKXYR/c=;
        fh=TYmT2YwjVlqQc37qpfbiV7u7ejuflC+kBpi7TewOQbE=;
        b=c5VO5ve6k7pa+bfQO5YpCRsKoPV2H9FZPTPH52HpSqjNFhaIrTUOwUjhPS0wG1Maim
         CeZFG7VaSscohQRevSFz1JNlBrjtWiAgtO2Tom74wd0xtBBcweo62N61qE5adQrCtoxM
         8FQC6aOfqqgt1aURwSWZ+MtSi0HQ+t/4LyG2EFYL6yvE9O8cOoH+0X/I746+O6QS4xFq
         t1nCT2K1MqmqdGW9HiWglabG68ChDAKCytgvoEFM90qDw7ChXKYUdie6U13F9rXxGLdl
         zD9Fs4O/O6TVl0sxPXDGeGmg1xr5U/qBgygkhe0GmF+wcCK437Ht1ZNDS0JI+wDV2XA8
         47pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011986; x=1769616786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1GwHpmSY+Ssuo+YrlkBnP/wYaSl4q4+E3mKjKXYR/c=;
        b=Q862qMpWJiLVIVSdFolvbVpi+BDwXexpF+JSra/xTIqqYnipokkrIFJx+EG13lj1EV
         squCrl0GaNExVCNM2UFVNVK6TO0pDzCX9ZQsreaYi7AEcB7FKUbNzkbw7ZBiyX+0kVDs
         LaMiZHR5dyuVKzGONTvfRTAVyApBVMBTwEyrqIJ9j91N3H3sP8dVS9HrRSk+o+7NiMgE
         DdAUTCVRftrh+5MVfE+VJju0IlAWXs9ka61u5yTvJp9bsvZ0hHhV8Ecsgbcb470DHahE
         PDdpsyP48aXkRIa3okWaLk5i2HNn6XcxH1aFv/GadNClL3io9Didnwb0JG5vOx+Bwqki
         2Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011986; x=1769616786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1GwHpmSY+Ssuo+YrlkBnP/wYaSl4q4+E3mKjKXYR/c=;
        b=rYEsnWCq2b7XVFyprTfMj5R9V31OllmDfPeTW2/MXQsdVI+8GjyNClSc5fxaqbVNOb
         EWylg0WO4+43m8ZBIChkAD7+jRNZ6B8q2aoGkBkDEdjAOx+OKB10uWi+eBWVke7cI6Ef
         VIMkxW/OameqIghVyQwNT0j6HHrPnGcCyOMO0q8MPyMLZtAPNG5Jf6Tm+XnbojecnUbq
         8QQahXbrEy8ZR6xcNQimDoo1+yVYlFAXcWqmj0gqjz7DjBn3b5y8Uygf0ZfzwnIpAx+O
         fEnisqSIe0iAlKX2gZzrdCu5gwl+Ea46PQfiH5HCNinO7pG1SEFyTrrZ4qUHzmIp2hSi
         AIUg==
X-Forwarded-Encrypted: i=1; AJvYcCUguC5tBYfIgoXZt+sSuKsCTMSznwF9O4HXVqNSjG/zLb1Vxj7RL1IKRfWKJmH91kjAdbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKWKLL2hzNvDfj1As3KXxHt8KDat5xg6iti8PuYdnWHCtE413
	cUzBsKE3yPhjiXd4zJV9+OVqawOjKVueCzlM+SVjt9MmV2T6ZC4D4hwO4kQS50MyZWY1amFm2BH
	ZsrgaOuSlKtvtWYWjUTtTDEiU0khcV389uvo8qfCz
X-Gm-Gg: AZuq6aJTwWNS52+pFXAr1hPErF7FX2iGu427laLo2ZbaWc1BlrFyrqIylhDv/cpXRks
	eW7aaUN0DYu/qKAGAlQn1GcKzsvNKGpv5W9u3cLjSHHHPk1jzWDhBNRjt1HmdxA0ZXQhQzPpodZ
	oJvHVLCUe6f72pVXLkrkZ7fuwPLDUjXK/TYXm5pTYqNTg1UWjMfUclW3wxV+r8AOrTj2dJSr542
	XPdM/b5V52PejCdQtTEEHNC9NjGNbjG1PtI3zoFWRjnAD8ls/wf3mmd7jH2urPil7q0DZDBgqGC
	xzM8bC4y8D081FGfWT9vDE/s9UybcResKQ==
X-Received: by 2002:a05:622a:1888:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-502e1a18978mr11594511cf.1.1769011985614; Wed, 21 Jan 2026
 08:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz> <CAJuCfpErRjMi2aCCThHiS1F_LvaXjkVQvX9kJjqrpw8YnXoNBA@mail.gmail.com>
 <fec4ed92-32e1-4618-99d6-0eac77da1ff3@suse.cz>
In-Reply-To: <fec4ed92-32e1-4618-99d6-0eac77da1ff3@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:12:54 +0000
X-Gm-Features: AZwV_QiSjzEmuwsWdtzV6KlI2OJ4fFRrfgPi7_dAQ80cVBUvpM4Z4I7qS0kyx9I
Message-ID: <CAJuCfpFzZnbZBX84xTTtTHmKebVxWXUXjFe5AQRTGnu-9AnRLA@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial list
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 1:22=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/20/26 18:19, Suren Baghdasaryan wrote:
> > On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> At this point we have sheaves enabled for all caches, but their refill
> >> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> >> slabs - now a redundant caching layer that we are about to remove.
> >>
> >> The refill will thus be done from slabs on the node partial list.
> >> Introduce new functions that can do that in an optimized way as it's
> >> easier than modifying the __kmem_cache_alloc_bulk() call chain.
> >>
> >> Extend struct partial_context so it can return a list of slabs from th=
e
> >> partial list with the sum of free objects in them within the requested
> >> min and max.
> >>
> >> Introduce get_partial_node_bulk() that removes the slabs from freelist
> >> and returns them in the list.
> >>
> >> Introduce get_freelist_nofreeze() which grabs the freelist without
> >> freezing the slab.
> >>
> >> Introduce alloc_from_new_slab() which can allocate multiple objects fr=
om
> >> a newly allocated slab where we don't need to synchronize with freeing=
.
> >> In some aspects it's similar to alloc_single_from_new_slab() but assum=
es
> >> the cache is a non-debug one so it can avoid some actions.
> >>
> >> Introduce __refill_objects() that uses the functions above to fill an
> >> array of objects. It has to handle the possibility that the slabs will
> >> contain more objects that were requested, due to concurrent freeing of
> >> objects to those slabs. When no more slabs on partial lists are
> >> available, it will allocate new slabs. It is intended to be only used
> >> in context where spinning is allowed, so add a WARN_ON_ONCE check ther=
e.
> >>
> >> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> >> only refilled from contexts that allow spinning, or even blocking.
> >>
> >
> > Some nits, but otherwise LGTM.
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks.
>
> >
> > From the above code it seems like you are trying to get at least
> > pc->min_objects and as close as possible to the pc->max_objects
> > without exceeding it (with a possibility that we will exceed both
> > min_objects and max_objects in one step). Is that indeed the intent?
> > Because otherwise could could simplify these conditions to stop once
> > you crossed pc->min_objects.
>
> Yeah see my reply to Harry, it's for future tuning.

Ok.

>
> >> +       if (slab->freelist) {
> >
> > nit: It's a bit subtle that the checks for slab->freelist here and the
> > earlier one for ((slab->objects - slab->inuse) > count) are
> > effectively equivalent. That's because this is a new slab and objects
> > can't be freed into it concurrently. I would feel better if both
> > checks were explicitly the same, like having "bool extra_objs =3D
> > (slab->objects - slab->inuse) > count;" and use it for both checks.
> > But this is minor, so feel free to ignore.
>
> OK, doing this for your and Hao Li's comment:

Sounds good. Thanks!

>
> diff --git a/mm/slub.c b/mm/slub.c
> index d6fde1d60ae9..015bdef11eb6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4505,7 +4505,7 @@ static inline void *get_freelist(struct kmem_cache =
*s, struct slab *slab)
>   * Assumes the slab is isolated from node partial list and not frozen.
>   *
>   * Assumes this is performed only for caches without debugging so we
> - * don't need to worry about adding the slab to the full list
> + * don't need to worry about adding the slab to the full list.
>   */
>  static inline void *get_freelist_nofreeze(struct kmem_cache *s, struct s=
lab *slab)
>  {
> @@ -4569,10 +4569,17 @@ static unsigned int alloc_from_new_slab(struct km=
em_cache *s, struct slab *slab,
>  {
>         unsigned int allocated =3D 0;
>         struct kmem_cache_node *n;
> +       bool needs_add_partial;
>         unsigned long flags;
>         void *object;
>
> -       if (!allow_spin && (slab->objects - slab->inuse) > count) {
> +       /*
> +        * Are we going to put the slab on the partial list?
> +        * Note slab->inuse is 0 on a new slab.
> +        */
> +       needs_add_partial =3D (slab->objects > count);
> +
> +       if (!allow_spin && needs_add_partial) {
>
>                 n =3D get_node(s, slab_nid(slab));
>
> @@ -4594,7 +4601,7 @@ static unsigned int alloc_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>         }
>         slab->freelist =3D object;
>
> -       if (slab->freelist) {
> +       if (needs_add_partial) {
>
>                 if (allow_spin) {
>                         n =3D get_node(s, slab_nid(slab));
>
