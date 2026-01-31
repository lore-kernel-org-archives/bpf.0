Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85608355037
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886838; cv=pass; b=WQ+knx2LeUuJFIR07Gn+ttF2CcYe1N9oNcejVbeDuqzMsvXTjVObxv5J7JTJXx4S+NvT4Wg/f4mpTWbcrTh4PPqKIktliNeUKDzv8Ag7PfJ9J40C5kx2F0DEj+4WjDESyVVMzEZ2p67zfUBuDHmeOyXfkEpJrOjqnoBBVyd9xyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886838; c=relaxed/simple;
	bh=ekOn+DEhFEy/8AkcFkDhbU/K+bPIUURUGDSbh6V3fUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPwhRyfsdZ7iMwkitB4pt5yWZTAK2qCVfjYWbJ9Mh31WPxJUtsaXaIWZH5jAlvo9P7kvYO36I+ELDnjK4kgglbZ0YWvK+wHxFCy+M11pYkkjtDbzkP+0NjmP5lp3asQUfnlDk+iK4MAgHm2gjWO2AZ++kVXUztcU8XCZY9wJzCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqwclV+f; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqwclV+f"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64942ebf1a3so2967220d50.3
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 11:13:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769886836; cv=none;
        d=google.com; s=arc-20240605;
        b=dzZADKIWdB9vJXJ2bDvrmxs4w8/r4qGi3RSv0hF9TV76WkRp/kV3z95MXEY89l6kLf
         U7u906iotrTW10tuRbalp5wxtBPn1a1HcM3KiI/eg96ocEWz1DpdhOCtTHuMHlh5k7Mb
         Qf8qeyWawvCujrf55kO7mHdSuop4FEvixIRmJUZM4JPolOnvXV0nI34T4urrYHADgn89
         r1sZ8QVjlof8vgpECaN4mizowkqMBKE/gkm3jt5iV1+iR1WwKlaiaWlYOXFSfz4e+dqd
         rd1ETo6ijtSm4RV8dpgdxoGOdcxfhCHlpD1yHwwQNqB+YrM3h5peG+yT8rtvbr20Sdpj
         +2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08g6K7KOBWEXWExX7xDMLno5kwYNjpmPpi5QBvnVcUw=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=GXF3/c9VmbiSqiC4eE50AVB9+KUU5g1uW+gnzUnJHyTYdq6XVwaYs6FH+NZWHHJuII
         Y+yWm6ejTEGfsQJBxEZLujDdeJb0imr0AW6UxfH8zw78cf0KzuMGXX0niMpnL5cmNmen
         WzD62c8ufCkR2izo5tKPuC4y0caZrvocX/dYeHLl1dalXfxZs8AMHy0zn91vWpCYoQ0v
         BZ5pNuQzHj8l8Qotpo/TAohpMUQKITNgLCRz3vccxqeYB/aSZzxBRtcaBuDriED8kaMN
         SRxgsqWZmm8jYhDiE8qIyWnvvzCdSHRu1fLxNS0diCCeWsVD//aV/M7Z47lnRknYk8sh
         KiXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886836; x=1770491636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08g6K7KOBWEXWExX7xDMLno5kwYNjpmPpi5QBvnVcUw=;
        b=fqwclV+f+UHilYybE4RcCC5YyWf2DFmkimjysZNxNmUvigNJ+BCwPPpHAaoFmqx9fe
         kH5O9YkNoj2H5Wi0HyO3kHCD2YfsAot5rOGpaOn1bQmzCcwks+XXwci3fZ4/iUfJQ7He
         6UO81YEnaVCjSVXN4N4vW/vcyDD1kjorpD4DhCpJhQZlt+mknaLtKkceWn/rW0ekXFez
         ElzgKS8iRc3Yp+gAkugT1gzEX5u7LE5TMVbroPDXB0kpY7Q9pIp8BNZ1aKd92VLfxCvK
         RcG7LXaTlgCcT3UE1ZPOoi3lHwOjxfogGK0zynqEwcM5BQKSam1opbN3mmFIRqIBnjJp
         uTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886836; x=1770491636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08g6K7KOBWEXWExX7xDMLno5kwYNjpmPpi5QBvnVcUw=;
        b=VoSJaAqzPx0CTfrG8FrRVvJHEwt6Gj/2bDIBJWadPehq9Aq6AKF/VIXqSrcYikOrlc
         Iu4CCT/JTDheenPW6eclGEGYZfiXoBUrZTBDwDIxBdDWYnukrsxVmpEEHy1T6qZHLioQ
         2LnR4zG/dNMHZNuSqcPio8q/sSoxO4TKxhYvRQ/lVg1BRaBWZ27Qr64CbpJcLeHDPvex
         REDnCEbcg2lJdBQhBJF7rw4dVzzInSm2wgF21mFQ0uToeTkzzL5xMkzTO9seCIoqRdfV
         W/0p0/GpsYvCUys1YWrAyM84ryO3bwZ42fVkjO8jDzLfBFFSwMtGqDpFwx66qtzLlZPG
         D6TA==
X-Gm-Message-State: AOJu0YwSTPPUnnPdk5nB65FwpNsIhKhimNwjQZNCd/EKlNv5ov7uzxCJ
	Pbdzghyr343oPdi5/q/FSgc10d7mdYyGpxwpzOc0wq605W6IKFo+ZaTxb3Ikud0OgQz30hU2ewk
	QF8LL8KKZg1rfD6/6B0xFhShaFQarJFY=
X-Gm-Gg: AZuq6aKhZabPo6RwZW7aj5N6cIUKCQwydGRf7ajLymy9bWY4DKg6a/7XftGmSKaEt5A
	lgXOnaOfNIuAd9KcfQOw0IaciKPrt0evmEosalVQA8C9vmOOrtvPbD541z+ORJGdjPRI9M9gxpu
	fZdStQpMnMXOKw4ond4p8bslQB1N0FLjAi56Tp1HR7iVwI7wWb78MqalawEeyQBKMqCzRKVom6y
	057DQsySQKhXxmSYWJSocM3OZcDlQyaNrT6gBivoEstN1JN4PBymgqXC2y3FR1qMj0mxmc=
X-Received: by 2002:a05:690e:1510:b0:63f:9937:6cce with SMTP id
 956f58d0204a3-649a849ef6fmr5497104d50.61.1769886836545; Sat, 31 Jan 2026
 11:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-2-ameryhung@gmail.com> <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
 <CAMB2axMA_8t6M2RJ97Y-9BB_E3N0h=9ZKArazbNKS_ySuNkKAQ@mail.gmail.com>
In-Reply-To: <CAMB2axMA_8t6M2RJ97Y-9BB_E3N0h=9ZKArazbNKS_ySuNkKAQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 11:13:45 -0800
X-Gm-Features: AZwV_QgR3Qklgxr5I6eJuJay4vGJHsEohIefeJJW_1k08xFjlty2yd7F843ksak
Message-ID: <CAMB2axOyfFGdDbyZO0tBvj9Yv9=CGrT=9+a_A4mu0OTjwy7UUQ@mail.gmail.com>
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

On Sat, Jan 31, 2026 at 10:40=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_st=
orage.c
> > > index e2fe6c328..6615091dd 100644
> > > --- a/kernel/bpf/bpf_local_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> >
> > [ ... ]
> >
> > > @@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_loca=
l_storage_elem *selem)
> > >  void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> > >                       struct bpf_local_storage_elem *selem)
> > >  {
> > > -     struct bpf_local_storage_map_bucket *b =3D select_bucket(smap, =
selem);
> > > +     struct bpf_local_storage *local_storage;
> > > +     struct bpf_local_storage_map_bucket *b;
> > >       unsigned long flags;
> > >
> > > +     local_storage =3D rcu_dereference_check(selem->local_storage,
> > > +                                           bpf_rcu_lock_held());
> > > +     b =3D select_bucket(smap, local_storage);
> >
> > The commit message states: "This is safe since a selem is always linked=
 to
> > local_storage before linked to map."
> >
> > Is this claim accurate? Looking at bpf_local_storage_update(), the orde=
r is:
> >
> >     /* First, link the new selem to the map */
> >     bpf_selem_link_map(smap, selem);
> >
> >     /* Second, link (and publish) the new selem to local_storage */
> >     bpf_selem_link_storage_nolock(local_storage, selem);
> >
> > The comment explicitly says "First, link the new selem to the map" whic=
h is
> > the opposite order from what the commit message claims.
> >
> > Similarly, in bpf_sk_storage_clone() when new_sk_storage is non-NULL:
> >
> >     bpf_selem_link_map(smap, copy_selem);
> >     bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
> >
> > Since bpf_selem_alloc() does not initialize selem->local_storage (it on=
ly
> > sets SDATA(selem)->smap), and bpf_selem_link_storage_nolock() is what s=
ets
> > selem->local_storage, wouldn't this mean bpf_selem_link_map() reads NUL=
L
> > from selem->local_storage?
> >
> > With local_storage being NULL, select_bucket() would compute hash_ptr(N=
ULL)
> > which returns 0, placing all newly linked selems into bucket 0. Later w=
hen
> > bpf_selem_unlink_map() runs, selem->local_storage has been set, so it
> > computes a different bucket and tries to unlink from the wrong bucket.
> >
> > The next commit in the series (82de4fd08 "bpf: Convert bpf_selem_unlink=
_map
> > to failable") introduces bpf_selem_link_map_nolock() to fix this for
> > bpf_local_storage_alloc() and bpf_local_storage_update(), but
> > bpf_sk_storage_clone() still uses bpf_selem_link_map() and appears to
> > remain affected throughout the series.
>
> AI is right here. I will fix the bug. We should follow the
> local_storage then map linking order in these three places.

Actually, we should link map first. I will pass local_storage to
bpf_selem_link_map() to get the bucket.

>
> >
> > >       raw_spin_lock_irqsave(&b->lock, flags);
> > >       hlist_add_head_rcu(&selem->map_node, &b->list);
> > >       raw_spin_unlock_irqrestore(&b->lock, flags);
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2153=
9340647
> >
> > AI-authorship-score: low
> > AI-authorship-explanation: The commit has typical human characteristics=
: domain-specific BPF knowledge, concise explanations, and follows kernel c=
onventions.
> > issues-found: 1
> > issue-severity-score: high
> > issue-severity-explanation: Hash bucket mismatch causes selems to be in=
serted into wrong bucket and never properly unlinked, leading to hash list =
corruption.
