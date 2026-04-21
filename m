Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9933F5BA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775930; cv=pass; b=fYzOGkaQ04KKUNBBt4jkeprgpa/iIbgplPmfcfp9xSBg1dgmbgM/nmQGkUn0yQ5z8ssV230Atn20L7fNzGjYvdD9B2SOLKo2Mut/UX/7LbT+Hf21nvbWKqxWS3pvSWTbyjAw/g9LwMxKqrRZPQjIlbJsNbPflMz3AfdDqC2boC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775930; c=relaxed/simple;
	bh=VpRx5r5O9+CKQARAYRtkajkTtNPQfi3cLUARV3b7Rps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBdmaD4xYq2a9Md9wDIqEHnRa3BMQlBGQJHKjiYO2EwVPb7liItYgfVta3rQbyyjudo3V9js9s78IKeODgTIlo/VtZzTx1qXt5U424WtyCxKF9ax1BIDLyPlzW+F+U9z3+JXtnwRQL69CIxUxwwlJOeNdSpKlbGS1D/u/Cm8yxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzwLEDY9; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzwLEDY9"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a337552604so4058171e87.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 05:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776775927; cv=none;
        d=google.com; s=arc-20240605;
        b=NYe22dxXumi18LEnTOYOUyHs1v3jnUYhqnrrsXS3yGRpyl+hzuyMB2XvHUiAR11O/i
         kRa9N9zOYVHs+kiEwq+7Ng7XfTY4BjxeInQrjz+2T3TsOXHuD9K8k5ga7fSxsZ+3TuoJ
         IqsR+2fFhuK6oeJWBGub2kAMxd3oj7NlXslWKe6XV34yJeg3KoM6LqhWWP4wrAICensy
         LnJMwpM9DPB0Xhs2S3YwO1HrtQLrpcdsUguQ3duAQYZaWUIIKe/0Y58Aut+GTkXAs1WO
         TmrfmjZpIXInRcK5rPv+rZo4A8/9XRLfKhjM6nhsSTkm0lZWhfqq3tThjJH7T0pID+E1
         DfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=737XG/nDMJ/5q6E1OMCzl01bn4enPbna+/IOlrDsYmo=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=Gom7noz7J6N1T4YHE35bhs9c5+qfjuOKo2m9ISLPrHE0qxhwAyJZdKHi6fe6aApLw/
         A0fi3eZ3N0how6pzaLw+4q6sdQXrQlWzHX54JBRAU1scakP/veHvj5MA7G2XPczBtEqX
         OLwD5rfSmc1gtU/gS3L14RX04cxM739GFMpIb4novacNgHdz6/Youb5tz5zO7ELN+8U4
         r1vjWsPCnHSRpS1PDTIGRu+7x6uy/NsgJgndjEMNa/0fWB46M3mldTBtoOkwJm5LYX11
         ooU+KYJTMDKZRp//CntsElE0TRBGVgqXGXQNmJ37oN5Krq5SwkBk0qXUi5jS+QFI4y1z
         CDyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775927; x=1777380727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=737XG/nDMJ/5q6E1OMCzl01bn4enPbna+/IOlrDsYmo=;
        b=lzwLEDY9Yuz0toc3aHMXpx1KPuI52s786xyWnpAJ3NrVQ69812biyooIs7P+7tzIPX
         TwTVorVoWxnIlQXjfPtWvSMz8phmLOAtCNMNkjyQ/ZDcSR0ubrcNYjE4U0EO2hiMRTOL
         Ho9Mog50SSqhpFUfra2XM9U1VQj4PWh8yRI4MFvg/k6q5KmdgRvWSYvpJY7wO9XA7LFE
         qhaTo98iEkBQQ2+A+4RBEr/fgn23OyLbjkDWibHPPMalWqGoLEAYCyc245HsXueC9hvG
         2YqcwS9crMtEapwMF4rjejxM7cNQQjXYO5Xo5KjRtzN4lhhPWkiAksnnqcCH/WCZqmTh
         zAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775927; x=1777380727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=737XG/nDMJ/5q6E1OMCzl01bn4enPbna+/IOlrDsYmo=;
        b=gXSxZ323PC7q045y6acjjs2EhDtPU1CqOOptdDd5+eHCpWtm0sw88R4ZqxG4kWsT92
         eOx3g2P/2xCzIkxZghp6fF1l9OZiLm5hB/ZJpJhVj2Y4mIVNcF77+GerWF1LH/3Q+tfr
         0gA5bafFQyGbLUg/jv1fOlaI6PC3MzxSA5xlyFov8uJpqNQhHuxC5CHuQr4jLwrsSEsd
         mtOKRVSF/lO7ZXZP0akBJeMyl9qqiRIxMaJUReHBVIqGphZZvmusrIkmTCKrl78p6KVx
         ht6QcbFW3+9Zszh7RhqXyzqpUQroxYpZE4gY4S5amYQTGTZcnjWDcFBM6ulb0xtpKwrf
         8lHw==
X-Gm-Message-State: AOJu0YwYcUjvwnBOP0+Zef5unCR2UswaNS6G+Vpug22hME752LTq49Kp
	BciCgCBzMKpxZQ3uZ6k/Uf5tTDa5HSlyYxQCJ/EkoECVSJSkO2Kd5kpH3ZFq3w4Odo7UiXP0Y8P
	GUE2PM+ohFVaajqyaLCh8S90g2WFhaTr5zji4iQw=
X-Gm-Gg: AeBDiesFsQlySPj6PgeCzH/PyiFRD+kp33SJ5FGwKk4Y/sb5OW0/OxR67AzxFO39ytx
	GarmPQKWkR1ziAzMJ3Xoo7u4rxjKEcGsZ9+HbYqNI24jFp1W2FGONwWXA4ID4ELZ5cP+r0SczRm
	pMwQkVX02Df0+Yd+8i/kGG3BcljgtpOnvwdE/uDbSj7NxCqRvoxNiCGHQaw5gGjOCUbPgE7AdUx
	Zbl5KP2wfw8LfGU+bkUk5bcVXEZCE/I3zX+Ma0a6MOtBQVeUw/3kc7HJ/U+Q4pbSCerJcTPIKqp
	lFTTBav4yVq7KIf4zw==
X-Received: by 2002:a05:6512:3053:b0:5a2:7bc9:5ea8 with SMTP id
 2adb3069b0e04-5a417308d6dmr4825857e87.42.1776775926500; Tue, 21 Apr 2026
 05:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-4-kerneljasonxing@gmail.com> <20260421094024.5E8EBC2BCB0@smtp.kernel.org>
In-Reply-To: <20260421094024.5E8EBC2BCB0@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 20:51:28 +0800
X-Gm-Features: AQROBzBvOEVDnrllqINttlteAMoHUYhHG9TTyxC-L4vg0Zi7omrGlHiNO77ggG8
Message-ID: <CAL+tcoDYCX0cdte=jFiFfR5VhkoMQ4-w9Xp-ySLL-aOYS+zFRA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Critical] Dangling `xs->skb` pointer on `-EOVERFLOW` error path leadin=
g to Use-After-Free.
> --
>
> commit 4ce0cecf5e8e18bd369c02242f70a42cc8fbdf03
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
>
> This commit aims to fix a use-after-free in the xsk_build_skb() error
> handling path by ensuring we only free newly allocated skbs when a
> continuation descriptor fails. It prevents freeing an in-progress
> multi-buffer skb by adding a check for !xs->skb before kfree_skb(skb).
>
> Link: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@=
gmail.com/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -969,7 +969,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> [ ... ]
> >  free_err:
> > -     if (skb && !skb_shinfo(skb)->nr_frags)
> > +     if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
>
> Does this patch leave a use-after-free on the -EOVERFLOW error path?
>
> When xsk_build_skb() handles a continuation descriptor and encounters an
> -EOVERFLOW error, it jumps to free_err and enters this block. Looking at =
the
> subsequent code in xsk_build_skb():
>
>         if (err =3D=3D -EOVERFLOW) {
>                 if (xs->skb) {
>                         /* Drop the packet */
>                         xsk_inc_num_desc(xs->skb);
>                         xsk_drop_skb(xs->skb);
>                 } else {
>
> The xsk_drop_skb(xs->skb) call consumes and frees the socket buffer, but
> xs->skb is never set to NULL.

This conclusion doesn't hold since this path (xsk_consume_skb(skb) ->
xs->skb =3D NULL) handles this.

>
> Because xsk_build_skb() returns ERR_PTR(-EOVERFLOW), the caller
> __xsk_generic_xmit() intercepts this error and continues its transmission
> loop without aborting.
>
> On the next iteration, __xsk_generic_xmit() would pass the dangling xs->s=
kb
> pointer back into xsk_build_skb(), which will dereference the freed memor=
y
> when checking skb_shinfo(skb)->nr_frags.
>
> Should xs->skb be cleared to NULL after calling xsk_drop_skb() here?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.14=
844-1-kerneljasonxing@gmail.com?part=3D3
