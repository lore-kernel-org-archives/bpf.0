Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA443596E1
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884831; cv=pass; b=mW+B5qHGChEHF42MFaQ3Zq81k9xpnb41MOjHAAzV/JPVll2N4KLoKAEw0yRtT0xA+FIcjNPkmAfuuDcgwmxSpcSk3SVZiWTwyB9YfWzkXeDC9DZvo61M4hwhJNU4GO/kJocFptuVTno6JrixTdnUpX9CzUt13JG6R7M5toPf4OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884831; c=relaxed/simple;
	bh=PRn824+A/c7Ht8xBpSIA1cULL2eht/BI7CyXtooYyNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLNqDhd6Q7SZplp2eJeI2M/N2I1D8TEbxJdPH4/LOwPYwMHX6/nWrshh4winxgW4Xq/o/S9qgo1TSvPlvYsM8WHiIXBHGoOJZV2SKK+F88k74xeuosV8nzk48l2DA+L3Ptw08gadF15k1UT2OTuP8y/7dDvoj6EOTFXiJp9VzLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuJdc+DM; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuJdc+DM"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7945838691aso47607167b3.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 10:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769884829; cv=none;
        d=google.com; s=arc-20240605;
        b=BQPO5gIJe0psaw7IUk9djRF2RKf1z4A1GJLtabyhdkb7q/kDNDhzqoVYdHsISCdnay
         c7jPaWIbBOWzeGN4hkmeOZcqfkyMsfqyhXxQinPcjj+MitIL041DWE8lZudyYx5A8Lqk
         vJsK+rw4NctAWeP2QSG0etED6xplCGhfNMFyHQiGD0QV45nXDUT6rsFW3BlnoInC7k9N
         j/AlvjYs4Dg/+QSnNom5064Af18T61N9mpt4Nbwr6+PX9zG5fDZQfkP4apyO/pyc03KR
         1YdAZ5mFLFVjOco5AHRQIeDom4wissW9c9Gj7pSzjzrKg/+b3o6XDMv4/lZZG7uH2ahC
         n6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZAAZwuiurkfmrGKZybeACCskuypcxNx54sP1LxN8Mkg=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=HXm+koxPaaTP9r9ToG8wvCk/sd7+qCLIkPFWP0xsfl55bKoqdZjpQPfSBcRoipznjp
         xtLA84HqGsf+xjj5O3IRuAZiuUXXJPP/EkIsHWOB3gV3/Sg60j+pS4AQsJwqt6yfI6Ul
         zhbBF2eafFLR1nmpDxHAUtvjc71jMkUDFf8pZYgufYVc51AXysxb3FeYyhweKvX9Sno0
         bxAe4EvfBbedTYxNobPYlsgQ6DbrkxTwNGnFbgbMtM+Osu3l62xRC3VRO47ThuB0/eTb
         A8dKr+nRRHGkFDLjdMY9ldEjOiRCP0ATK7ynyTlfP0dJa4+nyBN9bedddOHyM4mWQKn4
         +5HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769884829; x=1770489629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAAZwuiurkfmrGKZybeACCskuypcxNx54sP1LxN8Mkg=;
        b=XuJdc+DMAGQDyljVXnnF35jRAGnQJnn4Xju31mOumd5wW1jFZeC7rNtMgfjASTmoL5
         +sw0iWZfXsDpbKsc3oO+9QWjVzGa99cHuc0GT3Zn/TyAf1q3KZwu84i4D+hf5+LmVi2s
         1dudSdYTvaY+i+hCtDGe40sfvvtyPP7CypoQ3QRYYcxlI23zT3fi/cqciuo/ST87NIUA
         uXN1S+Vtk/92AiZcD6aZp5iaLPpEDA7vhoKTK/QZ2ebmN0B9kU00YcEMUK8w9Z3Dd/LP
         RkMLxmLhTLqGGGt9bxLp8Rw4+xj5rvGQjf+QpNYL+8jOeLC4fAx/Lh3KjHPY/T02eDRO
         WsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769884829; x=1770489629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAAZwuiurkfmrGKZybeACCskuypcxNx54sP1LxN8Mkg=;
        b=fWyyvlW+1XrLwj2ToD5Gsrqk9bsRvoZ391TUjPghCHHq5x+kXLjReWuWV4+FUpWNOK
         ngytGNlvL++PJRA6JeuY14LjCqzmA3DvtSf8Khg0Q31ImAbBHM1vC9s1H6FOqcCdln3b
         r4x6DlyO29upoPpw7+r6NIw3weJKSGEHJUybLIYX+TaGl8aTeQHD/jLz7Y4h7iM1c55e
         K2+5lBi4RLWIeeJwbrdUnzbEWeeCy6IycZdrQqlCaZQha4YuHAsrWfaJdzzqpHKPWe+t
         2HCdf2wc1kMW11qazivuCi218hE+JfRzthHfaWkq5Cz8X+LyXXvgopZdiatKg2BUjEuV
         A9UA==
X-Gm-Message-State: AOJu0Yz88mWLvYyWjsxBaasaZ4E9yttUE/Z7WVbVDzVs+oLsO1SOensM
	pr7a0B4hdmCPbobPkj47xnYnTKT/9hgk2ypRD2o4ylDniWN1qa3545BpNWtD/yBoKljoP019Q/C
	woHSCXW95e1uNrvqNoRffMEp9S+EDxOY=
X-Gm-Gg: AZuq6aKqYTVhIcMN67+4NB8Q91wG594LP+h/6uCQieqjmOoiFGMEb7N9xt6fmKpxGFQ
	uJ/TxJT2NCpcUBpJtWKjcLCqKDK7rKCymH04R9ImaDa1yK0libE99VgRNLpecHzlfJR6EO5Q5cY
	jiDuVBazYY9chr+D7NxL1vD9pue8UNixV8DKgT+kp0Y1CPQsuWJ/VGgmimkHBfPuFYh0au7YcrT
	2n11Mt/7Zjls9JDrNKHTSx6iDMFWFwojePBNIJq26npnX3btrlLd7R8vvABry8L0FfNbro=
X-Received: by 2002:a05:690e:118a:b0:649:4621:92a3 with SMTP id
 956f58d0204a3-649a8e90d32mr5040731d50.45.1769884828958; Sat, 31 Jan 2026
 10:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-2-ameryhung@gmail.com> <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
In-Reply-To: <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:40:18 -0800
X-Gm-Features: AZwV_QgZdXjlzSWfe-SaHSbm78i9UD87mqJEBMyrqX5PVwUTPucEaKRgHovIzR8
Message-ID: <CAMB2axMA_8t6M2RJ97Y-9BB_E3N0h=9ZKArazbNKS_ySuNkKAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/16] bpf: Select bpf_local_storage_map_bucket
 based on bpf_local_storage
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index e2fe6c328..6615091dd 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
>
> [ ... ]
>
> > @@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_local_=
storage_elem *selem)
> >  void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> >                       struct bpf_local_storage_elem *selem)
> >  {
> > -     struct bpf_local_storage_map_bucket *b =3D select_bucket(smap, se=
lem);
> > +     struct bpf_local_storage *local_storage;
> > +     struct bpf_local_storage_map_bucket *b;
> >       unsigned long flags;
> >
> > +     local_storage =3D rcu_dereference_check(selem->local_storage,
> > +                                           bpf_rcu_lock_held());
> > +     b =3D select_bucket(smap, local_storage);
>
> The commit message states: "This is safe since a selem is always linked t=
o
> local_storage before linked to map."
>
> Is this claim accurate? Looking at bpf_local_storage_update(), the order =
is:
>
>     /* First, link the new selem to the map */
>     bpf_selem_link_map(smap, selem);
>
>     /* Second, link (and publish) the new selem to local_storage */
>     bpf_selem_link_storage_nolock(local_storage, selem);
>
> The comment explicitly says "First, link the new selem to the map" which =
is
> the opposite order from what the commit message claims.
>
> Similarly, in bpf_sk_storage_clone() when new_sk_storage is non-NULL:
>
>     bpf_selem_link_map(smap, copy_selem);
>     bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
>
> Since bpf_selem_alloc() does not initialize selem->local_storage (it only
> sets SDATA(selem)->smap), and bpf_selem_link_storage_nolock() is what set=
s
> selem->local_storage, wouldn't this mean bpf_selem_link_map() reads NULL
> from selem->local_storage?
>
> With local_storage being NULL, select_bucket() would compute hash_ptr(NUL=
L)
> which returns 0, placing all newly linked selems into bucket 0. Later whe=
n
> bpf_selem_unlink_map() runs, selem->local_storage has been set, so it
> computes a different bucket and tries to unlink from the wrong bucket.
>
> The next commit in the series (82de4fd08 "bpf: Convert bpf_selem_unlink_m=
ap
> to failable") introduces bpf_selem_link_map_nolock() to fix this for
> bpf_local_storage_alloc() and bpf_local_storage_update(), but
> bpf_sk_storage_clone() still uses bpf_selem_link_map() and appears to
> remain affected throughout the series.

AI is right here. I will fix the bug. We should follow the
local_storage then map linking order in these three places.

>
> >       raw_spin_lock_irqsave(&b->lock, flags);
> >       hlist_add_head_rcu(&selem->map_node, &b->list);
> >       raw_spin_unlock_irqrestore(&b->lock, flags);
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit has typical human characteristics: =
domain-specific BPF knowledge, concise explanations, and follows kernel con=
ventions.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: Hash bucket mismatch causes selems to be inse=
rted into wrong bucket and never properly unlinked, leading to hash list co=
rruption.
