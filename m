Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC47234964
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257223; cv=pass; b=YJkH2htKYZ6Bej6PD5IB66VPia6s57nBnil4aoZ+kUe01cd4K9kjQM34GXD8rDJKCH2nO+JgSN9tGEdQ45UNL2CrclRH2ier+NFjvc1ZXpU4BvF1rZTC+8v3g/y3Ux22bPGjHMFunb/rzcR3BihD4oD93LxK/AH5fSdfRO22szg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257223; c=relaxed/simple;
	bh=7r2bJR8KsrQzLNaDQYOwVaBSyqRffRu0q/J+AwtGkRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLJzJ2Z4yJagABHJ936iHGsXRpvWctUd1HgJqrjoKTLreN5vR66s96dCayI+7p4H92JVmBV1MXZdHvzZSs73PvjN7RnzrgwFow3QRe0A5+ruFphvo2bBIAFFFqi3hw79Xh63B9zKIttH+pMpYHa2NhSuJtvJZNIjtiq5QWNnEbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzXB7T9p; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzXB7T9p"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so6879813e87.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776257220; cv=none;
        d=google.com; s=arc-20240605;
        b=gH8CAGXyCvHEBXFsWK8fDHRvWep+eKW7UA5Bn2sn02lwnB3NXziAbADU0cO64Z38zT
         JaIc3xI2q8G2cD6tgMeNL1LmsmcMUnZUQhysArMMHjbs/UvO4HSdfm3aC3811sMh6gh+
         aDC5WuzY0QLmWqkhm6uIo0m9OihfjuMatIFewb4OGzc+qPvN22/sEhcDQkQjcq7/pFNI
         1MXM790JCY/yWy7HQ6YgFhTZIi5qSKs4aC8cR2yrDx5E7fz9CX9fCavAZDPQOwHeV/kT
         ugKhuAGE6N96h3HIUJQFlVNlNMcMtLFTiSo+dgkTR0scEqzyAmkYehcLxt0OFY/CeuaN
         ocqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLC685DtI3sbpd+l9TIrRi7xH7TjLQTUlTqJTD2I4tw=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=cKF2/U8NSIWEl4/TkxY/D7kZft57eGMznM80FMMsaoedmDlLJunu5BDpZiNurp3IPW
         cWBcenp0np16nt4t1tJk6YM1d+E5GQXuK78SsUltIndbymgUY2rRr5tvDYoLKiZj16ky
         WqVhxfmPim/bfy2UY8vQz2v5YokMCPULhlnK4EBeEjZJqe+4aRIElfz/Mu3xat7AF8dG
         ehtRzet+vbQ/Z+KuqNrjI0y2kw+fcs0E3dcpIluvaySP8gc3O2kplzOwcIvnurLN2ECP
         zuoTm4VROQYjOAPEUKPZBR5atDM5mjDLj2ciknHLQ7kFTp2Mt6zc4+7MIAC/7kulzDl4
         AVGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776257220; x=1776862020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLC685DtI3sbpd+l9TIrRi7xH7TjLQTUlTqJTD2I4tw=;
        b=HzXB7T9pDwyhRcLLNrx8/PdIUVZdj0pV9J03R3XAZCYNNWHWFebWSQV8ssSH9LtlRP
         r18tVYKUQj191CIOEGALeAQ3RcdmR5Pg8iy60bO+7b55lDOqtnvwAQe7bSbM59qnv2eI
         p9pD3UXeDLDBDzsBpC5lCWFP6WcDNXw3ln1icFXaSv/zQUqLeVtDQ3gjBduIT7mGvsoa
         d3MRyLliyQH+G2s3h1rW0ms3RUGhKCfT2f/DIMTv0GJZ9853i59zd9JxK/4zi7FcquJP
         Ce6v9AjRsquZCAO3FoAbjPz8UKI1fMGEaDQ4HNm48FK2zfLQAE8o1akJeLsHFc8YavFx
         9aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776257220; x=1776862020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLC685DtI3sbpd+l9TIrRi7xH7TjLQTUlTqJTD2I4tw=;
        b=COJGCMb4pTAzghtqIwFIRLsdlv4UbB9aDLuGmHiH+cuWAj42dHMiiztIwRUJ6xdFrY
         dsIvZlrKV4/ddRLYGGzfj0rgX2LRPBETwc7Sb097rtETgEa81gjVdP4ydZK/gMWOqIKU
         pby1Fu5hhLI2+g1Km3R38v7suNKlt/do/OgInCGSp9aZhZBKqkYw0HNfBiRJ+hdDAsU2
         A09W1sNn4fHuCdaCYmXcgWwzHs5jGxiaHn5CkubFlqafo8488dZatvMyuDIDipbBzM+D
         Nvm3/DlqhrBJH7edDz3ZwTJQUHyTjNaNUrJ2IBhi27Jg9YiDc0kRJijCmtVTU0BApBY/
         +qaQ==
X-Gm-Message-State: AOJu0YxoUiNQdy4CFMuMl1Yo0nGeYXIFvOry+k8w7ncaUO05L1PFQaKu
	3LEsHq3Cfftvsf1CYRsBEFVd47XheBHuTnboWUY9MKDwKO7EaTUAQdJmBqFJqIgbvVc/GCAGNYa
	i/yNr5K0nAbWtK9syLLaXk+yU6gSiY05QJ//Aqa7BINSj
X-Gm-Gg: AeBDieuVMTBdsw4g0Ym4pxcjCvpD4EAKLgrCKwbKsPsJOnr43WQBeotWlaKO3qdbpbR
	AVrjbH1/HGNr/jPjrI+aXU4qjQNbN3jtzSQqLuhSM1PT0+te97WQ5jZcXOjlBE9kxsSQL9U8Q+5
	u8WYzrvbfivj4YqVxd7X8mo087BWnypzPu37FQclSXs7UuV60RpF7xYCWhqEvjjAT3SIAiNTzSn
	dkbkHrIDrF5F1K5bgkreyX5MkMaHTH8zzpxKdBFuOsPVp65X5Ira7mUC0w+2074M0xKTs59RSdY
	BrasYyFiSzsC2vj4Cw==
X-Received: by 2002:a05:6512:3ba8:b0:5a2:be40:312 with SMTP id
 2adb3069b0e04-5a3efb2c40emr6151215e87.2.1776257219717; Wed, 15 Apr 2026
 05:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-2-kerneljasonxing@gmail.com> <20260415085138.703C8C19424@smtp.kernel.org>
In-Reply-To: <20260415085138.703C8C19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Apr 2026 20:46:22 +0800
X-Gm-Features: AQROBzC98LkunFAXvPz8KqDBlD6LfR4VlGyVaQDNUzaIq-Mn-z8LE-U42xl_mfM
Message-ID: <CAL+tcoAcuMq_SZNvXAettKcj-wmLstJUHiBCGjdPEc2C_iVc8w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 01/14] xsk: introduce XDP_GENERIC_XMIT_BATCH
 setsockopt
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 4:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] Unsafe array allocation using kmalloc for a potentially large, u=
ser-controlled size
> --
>
> commit 16fdf26210767cd884154d2717d7894d96a2ee54
> Author: Jason Xing <kernelxing@tencent.com>
> xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
>
> This commit introduces the XDP_GENERIC_XMIT_BATCH setsockopt to allow
> batch processing in copy mode, attempting to improve throughput by
> allocating and initializing multiple skbs at one time.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 3b46bc635c432..1194268ae8676 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> [ ... ]
> > @@ -1582,6 +1593,42 @@ static int xsk_setsockopt(struct socket *sock, i=
nt level, int optname,
> >               WRITE_ONCE(xs->max_tx_budget, budget);
> >               return 0;
> >       }
> > +     case XDP_GENERIC_XMIT_BATCH:
> > +     {
> > +             struct xsk_buff_pool *pool =3D xs->pool;
> > +             struct xsk_batch *batch =3D &xs->batch;
> > +             struct xdp_desc *descs;
> > +             struct sk_buff **skbs;
> > +             unsigned int size;
> > +             int ret =3D 0;
> > +
> > +             if (optlen !=3D sizeof(size))
> > +                     return -EINVAL;
> > +             if (copy_from_sockptr(&size, optval, sizeof(size)))
> > +                     return -EFAULT;
> > +             if (size =3D=3D batch->generic_xmit_batch)
> > +                     return 0;
> > +             if (!size || size > xs->max_tx_budget || !pool)
> > +                     return -EACCES;
> > +
> > +             mutex_lock(&xs->mutex);
> > +             skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP_KER=
NEL);
>
> Can the requested size here become large enough to trigger high-order
> allocation failures under memory fragmentation?
>
> Since size is bounded by xs->max_tx_budget, which follows the TX ring
> entries, it looks like this could reach up to 65536 on some configuration=
s.
> A 512KB contiguous allocation via kmalloc might fail on long-running
> systems and trigger page allocation warnings in the kernel log.
>
> Also, since size is a user-provided value bounded only by the maximum
> budget, could the open-coded multiplication overflow on 32-bit platforms?
>
> Would it be safer to use kvmalloc_array() here to prevent both integer
> overflows and the dependency on physically contiguous memory, similar to
> how kvcalloc() is used for the descs array right below it?

kvmalloc_array() indeed makes more sense. Will update it.

Thanks,
Jason
