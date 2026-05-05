Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0C3D7D9B
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009855; cv=pass; b=gvu5G8LvRO8k7MEzIa1uC7FWienP4PGI7hyGPNTHlak4pKs4xlupQHTCc17ph2uBeY5sUoImhUDyQNbXcHOt0DHXQrpTLymoaOHUxspdsjR6qzctYUEvbgqfpVO9i6P5GpMBznCkT9K0xEmxIw0WOImz7aoTARRaNVDNL3uOnzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009855; c=relaxed/simple;
	bh=a3zVB/5vAYynCtb4zf8lzhkLA1AuHgKmJ2HODw/ZOT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwt3QB0SXR0USN+Kt6Pl+vtAMf1zWmKvzrZdQ7bYNg154IgdW0pEAthsPhc65YqshNXN3D0m9BB3QWgzos2kvAarf3Im1YkZf1c95HyF5P+patljFZnLjVCQscduEotA1R5TxjELsMqk76Oa/f9bsySkQoNo5n2T4ovbH3OdK74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYp2kpK8; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYp2kpK8"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a87782588cso3194296e87.3
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778009852; cv=none;
        d=google.com; s=arc-20240605;
        b=EgIxe/zJje/w6rYD5w1K1AFEPwxPWC2JiopwER1fGCXm/v5f+M3QDGizmMUGQ9Pmwq
         06cWcmvMgqNfiTHHvw9UESnYX2GGA5c595cGWdYbbTL4uDmeUAGU9A+fKYju0XxxrB1c
         HVmTQIOLBoQA+LkSh/17onltoGuLbfpTDYfNeEvY+jMwIZg4breZFQLbBp5QDGnHk5oP
         cXz+dxk9nhSubFS/iSHuIt1nScMGrppxE+thzGjYNcIb9W9Rp38meiKhAhNycqHsl9E9
         CsJJ0zKKHCVjqrXWE47vkoZGXuMLK7TQ0/ykx3gLu0qUUP5xWK8FVqQH0AvhcM8TFImv
         QEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AyTGTquhOThBRNg9Rcr6RTDs9jq+NcxIxr17tuis9js=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=bbCAhQIcv/kwuNVK3LrkxDEfJJ4Z4o4AMAiMKiMzhGF8WW6PEjnzNBtIugqYGNL0Gb
         Ia3PhpM9gYsUdhNvURYWyYIJh7ZOpHlOqwH3K9GEP+o7lixHEkLeIpapKwxQXuBKFim5
         cWOVdW8uW9JEZVDRdTJ5beRtK3QVOaJRQgXRZDUJOnjxTygwmSWCXhY5BR1jFr+nRDBG
         D5e9xAeejh7MStQwP61GebtWUsUzikqEBLJ275j4ND5kuIS28Yb0Vh+JYzlBt69Z5xEF
         ENZPdS2tfzv+amHE1sYrzqIMeYRl15dca1XD3RP8lgKB6k4IgsTv7CcyZKfcGvLACKUg
         EM4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009852; x=1778614652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyTGTquhOThBRNg9Rcr6RTDs9jq+NcxIxr17tuis9js=;
        b=jYp2kpK8bOOsC69j8Tz2D0wbKwUoOd2y2ibBS4Ijn4ps04Qfrv0dm3JT64YGW6BlTd
         dn5psE85d0EH7Y1nV4yJj5MjEED84aHAenWCk/Qam/SkY4gj0lCTK3T4XCTPS7RhjXBx
         LvyN+zMSFBFqADUTStKKablcB7ahWYD4Tn8Yp2Qh9xH/Ik5pCsHV7K5HoHT+soc8NGtW
         TOnQWxKve4C6zO1qoHYgNuC5IkJ18vV8fQul/OInx6LvfVRfHI42YrTk/J6T4l3iW7/0
         c6+KlXL8yX+ftVhGpNy5jwnQNPR3FISFSFNOJYl5yBbi90AmiuiC/H/EbaxbrrnVxOmK
         xObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009852; x=1778614652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyTGTquhOThBRNg9Rcr6RTDs9jq+NcxIxr17tuis9js=;
        b=SHYj0I61M5z9T0YumdIqgrECUWSAi836iCqUG9fTJ6PWxCSi2Z1A+hn1VHKdboAeg1
         vsJ93FQmXPlQ4BE+R5jCIQjopSE8BzqUig/aWChJsq7zn7/KO92GADp4wm8jzaybEhNK
         uWm49w6y7NpVuITFmlerAoXVY0eF9008A45VZjZkPjWaUtvYPjEV17EBMzinkzeI7B11
         dFOmmD6HtDTiSVqI7XwnATzEnpr0oEVvgY11NZdMXy4/XxB+D4Yd1iQtjvdcMDl+1PVh
         l7IfisUzOk4vMqds3w1S4IdxfgjeLQ+seqv36puEhTqpjNm4B1d0vNDuOAgXrKXLjnR0
         0xCA==
X-Gm-Message-State: AOJu0YwGrqjHGNmC7EVPTFaq7rCqqXw+l2ZDLVcMUQ02O6cqpmgtOs0d
	3L7wGtExC18Cnkt0LX7+TWwhiAZq++q283nC3r0T6iPOdJBfKUngTCnvMonR7+tKh0iLhp880cK
	aH0qNXOwY9Cslix+hvYDA3i0F62ubjnFdk4UKEJfGKQ==
X-Gm-Gg: AeBDiev5ucs4AaXk4hZlDPAiybInP/8CnRHlfTtecZgOuzCMaXxZcADESUAChJCoLce
	yo21jVZpjm/F1ZVfd6D2gwXCpf43VEoRK5R7qJQDS4r0mdJ3YkeHIov/KrfWUmqRWOvALM4J3IK
	9xTpg8rp1DWVelz23wNiwK8aErA0YIi+rSngH3ONJfnFS90M37jr8Jt/qh/i0dAC5m8ERbA+CR8
	n8sVc1qlSlE47q0MxEi+FOZ6kdYo39HZn2+V/AxstGSgXOvVYJhGPZJ9gxr1SaSHvNxisL3gxdp
	Uff71XwQzFH1DFP3+ArtY2QDMpakPuCxR92ua2+RtpWSv9KF
X-Received: by 2002:a05:6512:128b:b0:5a8:750c:2f79 with SMTP id
 2adb3069b0e04-5a887adfdbemr38798e87.3.1778009852279; Tue, 05 May 2026
 12:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-6-kerneljasonxing@gmail.com> <20260503200926.A500AC2BCB4@smtp.kernel.org>
In-Reply-To: <20260503200926.A500AC2BCB4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:36:53 +0300
X-Gm-Features: AVHnY4Lv4vujM9OdF2Kv59LtFWowj4-r1E10gZUeClG3VQAR8iTW2QBhQqUgW2g
Message-ID: <CAL+tcoAio7SLOWBh7LJp_9syGFAD+P8HbG1CzbF=cgrVN+agog@mail.gmail.com>
Subject: Re: [PATCH net v5 5/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] In `xsk_build_skb_zerocopy()`, if `xsk_skb_metadata()` fails, th=
e newly allocated `skb` is leaked.
> --
>
> commit 88b75ff1d12b482a55e1724cc457909cf3ea19dd
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
>
> Postpone the skb initialization phase in xsk_build_skb() until the first
> frag allocation is completed to prevent the skb destructor from running
> on error paths. Before the initialization, the skb can be safely freed
> by kfree_skb().
>
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kerne=
l.org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 55378c3855d5..af3c5752bb63 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -819,8 +819,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
> >                       return ERR_PTR(err);
> >
> >               skb_reserve(skb, hr);
> > -
> > -             xsk_skb_init_misc(skb, xs, desc->addr);
> >               if (desc->options & XDP_TX_METADATA) {
> >                       err =3D xsk_skb_metadata(skb, buffer, desc, pool,=
 hr);
> >                       if (unlikely(err))
>
> Could this leak the newly allocated skb if xsk_skb_metadata() fails?
>
> If xsk_skb_metadata() returns an error, xsk_build_skb_zerocopy() will ret=
urn
> ERR_PTR(err) directly without freeing the skb.
>
> The caller receives the error pointer, sets its local skb variable to NUL=
L,
> and jumps to the free_err label:
>
> net/xdp/xsk.c:xsk_build_skb() {
>     ...
>         if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
>                 skb =3D xsk_build_skb_zerocopy(xs, desc);
>                 if (IS_ERR(skb)) {
>                         err =3D PTR_ERR(skb);
>                         skb =3D NULL;
>                         goto free_err;
>                 }
>     ...
> }
>
> Because the skb is explicitly nullified here, the kfree_skb(skb) call in
> the cleanup path is bypassed, leaving the socket buffer and its associate=
d
> sk_wmem_alloc charge leaked.
>
> While this pre-existing issue is explicitly fixed later in this patch ser=
ies
> in commit "xsk: avoid skb leak in XDP_TX_METADATA case", should it be
> addressed earlier to ensure intermediate states remain safe during a bise=
ct?

No, again, I've mentioned this previously. Not the same issue here. No
more severe issue is caused because of this. And it is fixed in the
series.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D5
