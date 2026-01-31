Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2235C18E
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885182; cv=pass; b=EDZIwiKF/q8PdN9G3VANncEY/RkX2o7lFbK08QNFtmi3PpQoFKDtqcfpX03mBoBtvLcI+m62Mvd+zdQs2IAq0trtVgn1YgSqzPWKrYjbhMcIDcXClfIhhPUGKX+k8eZKckz5gjCHcQOkjGrzAX4N0R/4oox2N/Z8IXr1RauQtUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885182; c=relaxed/simple;
	bh=gjyoI+aqRNh9f6i4kHhtuIbw2jbHU9s631hyA+eBL44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/h70NIVfIV842VPVVs95ho+yoKGBZXjdF0z7Gc6OryMpv+yMsJw8Uu+avzkftdntDALaaGws2NdvcscCHdMGnITh7STdGw61cUpLYhlItJu4icLmcSd2ZHtKasjGB4v3j3D3Jxc3ozoFokrBxLqt7+FbKQNPZTBFPyjtIYssjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc+M2eaV; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc+M2eaV"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649655f14d7so3194226d50.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 10:46:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885180; cv=none;
        d=google.com; s=arc-20240605;
        b=l10iZwz8g3/PehdxiJRk+0dmcB5PtW1B8pBWaL0wdCGOHjDeW52oVkf9JFsmfkNHCw
         D61Ws7Qe5LRxHDWNzNDByxbw5pmAg4jsqnrB9iDV7Xy4fKldfiOApI2kmE7SVyqeKMM9
         Gs0Id5HVSWjTCluYFVWE18hQZN09nMe70Vr9EvkS5g2KzPNRo9kBULgrW08VURxqxYsU
         Z+jso1LMIOmBijlNV/Om0bo3THUCgqkeMeAEp9Hof1W5PLsm/IXJUbWUnIJxqcGl1ZYg
         /9wgVms1GQ1brkzKRqCY2qNh4k53cHs3Pgv8kRC2ukFXfJqUDnnThM3aLGJt6xKaX3QR
         InRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fh4osU5Y3eXPnZOJ7E5U71ADiiPnVo958vEhF9Dljs=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=gbrUt811PNyGiq1ei8uR2+EN7eHUCO9vHrfS0lC4mfkrEwmZE7vagn/mdDIYNa/mMm
         4rucrjvbljgmjN0ld1TKM5sdLvNO32bmPppxD7gpajJtWyOzxS+0+sKvmLlCaqYoSm5m
         YnF5aYB/hGd8qxG0WeCioP9Ae4YzAobDqnFjJH7+Tt5upA+G+tP/48YzPyfsne1Q00jx
         mEY/QlvQhBDnvTbOxTtlwA9UvNPb/R+DXjDEgP1ImLRUASNYAK9wL4RIY715adggTiet
         cXyiyo16sHnQmlmAY9f7BpkKpxnFZ/2wffuq6084KMA17gZlar8Lh+npRBhEbtykPtgG
         CN0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885180; x=1770489980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fh4osU5Y3eXPnZOJ7E5U71ADiiPnVo958vEhF9Dljs=;
        b=Vc+M2eaVwY8XTqjvrsbBrqYLKl8Ftcpj6AEn2LBFxSg+sMcBNrvT1SQA6xOyaSQ9qa
         u0qFkKSqXa5BDXi7kWsiyHnnFwonqxIzLeBOEZiZWjgOPwlen2D4qWYZLv4xCZ0yj3yq
         QB9B10EEN8Iy7qZIkkUKzbcBoVwRKWY11/hOcAaw1rSzTXzvs2Zdbfq1tSsr43SBiN6b
         4twMBTs60tygb5AszdH60BiJfGOf+J9nLEJPqsn5Yf4GircqSyytM+j2FE3GqhSpCNTw
         OMAwoBT3wn7fK07vcoXhi6tE3UcsQHBkr/3vvTz4NEyFiNBC7U4OsHhIHFMHlwgfQbqn
         PDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885180; x=1770489980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fh4osU5Y3eXPnZOJ7E5U71ADiiPnVo958vEhF9Dljs=;
        b=fAonPL0gg+HZavCFmnBkitTBlJCudUwP0Ey7rRNAgrsjtMS9V+8PH2QE/Hqxk3uqlH
         fWPQRq7PKF7T6DssyFwjPKwD9pxhU5MvS0q7Fs2a1vfpW9gNB+NbBwhB5DD1wVdt4DKI
         75hTcAJAs7JaOEgNY2BppkCTmkysDbk/QcvMcTz4JUKrtcsWd9K/1+DQa0sxj4hTLE27
         9GWAKx2F7UAQlZyvBovK3P4z3jo/fdETL4PwmhWe7DFp0X1ozcT3b25BdGEuvB0tC1i4
         /GYKiDOlAw9PNEMe0DrGNIO1OzO306Bh3Gb4PxxWuFmzN2BXVIxbelmHT7R3/ezeTa3z
         fmLg==
X-Gm-Message-State: AOJu0Ywj+rx7EWgAKj4ex9J9JPfrE9l2PHSSEgqOaMFe3EqW8Z8h886s
	9zMXPntsTITGnjyz/beqDaMhtMC5hfvDKUATXZHM+VKW4bYXYOBDD0mjS+TeB6dC7CmhpSXFkue
	YB1+W528iAeOwyB1OfkahDk3+yI9ND6g=
X-Gm-Gg: AZuq6aIMngiLpNcBL+WyEodbgBuKY75i38O5HgAu3mfIARTccDr/l3WIhItKjpi6ysW
	Veuf1Sg5oxKisUFPhFECL9L/TdMeodnQN4L4KbetLRtg/VXY82vRbk4fkRHZ6hmiu+E5MBC5U+L
	nONcJ/d8WcvWQs/U65K1VH5WyJYv3h9Us9qPWveQbHCecwscFBYUni/619q/aorL4OrBjDS3EEF
	Ptjn8k8FGBGWbLT1QqC8mbjZJSoKllP6LCn9fDM49wcDLYSVwT0vTptraLg5QyAbyELGqQ=
X-Received: by 2002:a05:690e:1249:b0:63f:b952:dfef with SMTP id
 956f58d0204a3-649a825bc25mr5211366d50.0.1769885179889; Sat, 31 Jan 2026
 10:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-6-ameryhung@gmail.com> <0a0eaa11c4b429d41ea2adfc36b56b75b61eacd777dffb2a25cd2857f72d5f2d@mail.kernel.org>
In-Reply-To: <0a0eaa11c4b429d41ea2adfc36b56b75b61eacd777dffb2a25cd2857f72d5f2d@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:46:09 -0800
X-Gm-Features: AZwV_Qj4nDCbzN_Zy7806jAMA7hzx_7N4tuIi7HkMm7XEcf5sh35YEA-9k4xwGw
Message-ID: <CAMB2axPxujt7tUXcZrhQVf4BC6tM35GqTg00pSB7KyGs6ndohw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/16] bpf: Change local_storage->lock and
 b->lock to rqspinlock
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
> > index 824d05325..7661319ad 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
>
> [ ... ]
>
> > @@ -572,7 +591,9 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
> >       if (!alloc_selem)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     raw_spin_lock_irqsave(&local_storage->lock, flags);
> > +     err =3D raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> > +     if (err)
> > +             return ERR_PTR(err);
>
> If the lock acquisition fails here, doesn't this leak alloc_selem? The
> allocation at the top of this function succeeded:
>
>     alloc_selem =3D selem =3D bpf_selem_alloc(smap, owner, value, ...);
>     if (!alloc_selem)
>         return ERR_PTR(-ENOMEM);
>
> But on lock failure, the early return bypasses the cleanup at the end of
> the function:
>
>     if (alloc_selem) {
>         mem_uncharge(smap, owner, smap->elem_size);
>         bpf_selem_free(alloc_selem, true);
>     }
>
> Should this goto unlock instead of returning directly, or add explicit
> cleanup before returning?

Right. It should be "goto unlock".

>
> [ ... ]
>
> This isn't a bug, but the commit message has a minor wording issue:
>
> > Change bpf_local_storage::lock and bpf_local_storage_map_bucket::lock t=
o
> > from raw_spin_lock to rqspinlock.
>
> "to from" should be "from".
>
> > For, __bpf_local_storage_map_cache(), instead of handling the error,
> > skip updating the cache.
>
> There's an extra comma after "For".
>

Ack.

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
> AI-authorship-explanation: The commit follows standard kernel development=
 patterns with appropriate technical detail and no AI-typical phrasing or s=
tructure.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Memory leak on error path in bpf_local_storag=
e_update when rqspinlock times out; affects only rare lock failure scenario=
s.
