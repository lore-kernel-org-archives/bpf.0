Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD2405C27
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982628; cv=pass; b=kTXGOCG9berpm0bET9Qq8bJ1JVAmQAmM6Ipk9blh2a1pHx5ZAlJjlQFzRgqvxNlGxvmtncB5kveC3VMp0kMrLRHncze1sI4DjV2OcskRe8Aa5uqUd/+bK675AulvJNDboQLmz4DJ9I0J+ajbPDrrx8GXS5GuUxoAig+Eb8J49ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982628; c=relaxed/simple;
	bh=nYJ1lQWEQZMAUa8pscubpFTZASsZvEJcD69gXaCEt2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyvrmE5viGa+fNxNT/K3QSyr2k7GPbQha6RN4P0QK38rGVnAN3CgpM08vb2bwR+XNbAfbgTuvhAUGtXLFhz1iJJolJyFXtBnvgENIPp+zSke/i5/1S0/fyJIfis4lXekUA6hNMIkT0LcyprhahqTOxsjk7C+Cq4GNRpFNh3eyx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJqk6sR3; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJqk6sR3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a887ebb416so1375986e87.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 18:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778982624; cv=none;
        d=google.com; s=arc-20240605;
        b=OWNXn0YBsr7n3tq2Qchv2ioeQZomLwQgEQDRajyztnVITVwn//5fstwHHoFE9oZjiC
         neQWJFJ1qF5tF9Te3EDXFRsg187q4JFPRSgkQNxOOqgej7bPFp93GYTKkRdcDaB6gNT7
         sgfHCMLpcYDfgO51aiJbXuLsSoIHaksvAYx0KWNi+cKKs10J8sdSRv7ufqbg6PQqH9mk
         /ULN1jbgXaXnKrqMlxuo+x2a5G8UJQEWxEVJ9xO1IQHb29yh4msSjNu8jXw8Pee7HKvL
         eYcprYCtymv9r04YVWn+Gezqw5Eg8RxvbS81ZKs2+GC+qg96S1w10gaTNL7lxl7r3zOp
         nXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hOEykRQTpFKMfjOoZ1QFIYhrfxe+UpeYQRXwMBS6ryU=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Bww+k054BSIsFIY6kwWzeR+YGoFdA8b0sb693GNNN386xiGS2sA5zGBBoB2PxA+iOL
         4NaXwUH4+ZOCI2FXvRN25WPKz3T40qHMEyiY/BYcxd25w4d8YGShr6b8b156rV4O9meM
         FaQVYN+4uhLg9m5bvcQ2yMUD9wtxeh3KcKTBcMdDHLWh2aUhy7iEFsxH1QBXVWLCM8gr
         anyTCWRivOI3qceWwQI2MaokPARUT594eIv4J1I1eRb4/K8vA0pR6eeEQLzs8WEngsCo
         CcK/NGERAHA0lYnIAb8DV9Hpl1OeDTiACyqfvss5jHeXUM+9Br0R2aFcjOxkcBmF4tGi
         eApQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982624; x=1779587424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOEykRQTpFKMfjOoZ1QFIYhrfxe+UpeYQRXwMBS6ryU=;
        b=BJqk6sR3NX+GIzxCC70QDbKkcMxH6ex6u0BUW8wEgZlzcyi1qWIKx2Tigz315dbzvY
         +VC9Gew+TFTVWuX4U+ddUrQ1GfFLGNeAzPX6wNgb4C58etsXpgJdBuwsQFRT1p9ASOCg
         ghVZWkm8HvkIbviOPlGoNSTK0MUYKtVsc6W0qWMKPLXOr3Z/8LmyaZWHx1Q0XMQmwu7I
         yjQhQ7LNMB1P1ZKiJ5wVoiyP9ElLDSAZDwAD+oUuU4B45AWWWG4PWod99BGQBKnKcnRT
         7qhhrceq00j9a6Nhyf3KU4+fxzvMhWvmtxwEDIpquddzANCqMRQu4IdZB7P2mMlANW1H
         I1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982624; x=1779587424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOEykRQTpFKMfjOoZ1QFIYhrfxe+UpeYQRXwMBS6ryU=;
        b=LIR285mMBv83AeAM+mV+Sr5HgYu3Ls3PKtSJDWbRbTXUqo4AILqU2zfp9WiHSdTyWG
         qwRgbiLGzdLq7umTTruiYsA+85bQIzIqnYXg1FsNCH0uXO+/v6O/p0SO1F3NfvrVeTg9
         9OMEtcdk4kW6udt8mAbZE317wPfV65i8SI8/pQTWYcJ4Dit4n4v0sUnu4koIqcHaLMbV
         2vkc7s/+mYBWJbuUL7ToEi3td32keEiI6Jfv7iB3DlP5VtuJPKWgffUKPBdUTlKNzPyk
         cprVyUGgUONRUVqMvShEVwliSbncij50TAyIareFW4QdEPW12Dh31/IBYQpNkl94y2oj
         kqtw==
X-Gm-Message-State: AOJu0YwI5FEvk2QarHHowS7vFWraH8qdDxN/hqQ23Be1FyW2maonoVaP
	cCJ2u8jhnLQ5TTB0E0Ult+ptZfUst5nk4mrR+VOnh3pjnOaagR6QfBfnD4hP3Wn9jVnccrPPSoi
	4wcIvpo/JsD2Jq/zhLBD/RyYvrCBrfZ/TyWlHPlQ=
X-Gm-Gg: Acq92OHFsXtAWMQh3l+v4z+duuWcJwTF4I2kvJmOO769xo3ZueuJbSRrCGIdWKp+8aW
	+JKdfT5qyBpzRucAfUupxEk83f7uC7ro/bZwokE8QHh2u+lomujfmsSuEM/mT0qylZSuyKqEINU
	0kwb8VX5//crEMqR94j8pUtH+pyw1O74QrZlxULGIMKAdx1Zcek6Q5Je+KM6x+xa4VLA+EE4fgm
	8W4MLa8pDK+c/Btryrqb5cRS1/SN+ZaRqi/vnlGmgmkPCJAAgFPORJIkZCltC0ZwEPed7zcHemV
	/E6nV+/V/R2N+6CdhlhWva50gB5fryCSgORMuK4=
X-Received: by 2002:a05:6512:118a:b0:5a8:e32f:6edd with SMTP id
 2adb3069b0e04-5aa0e5baa13mr2904320e87.0.1778982624275; Sat, 16 May 2026
 18:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515123018.80147-4-kerneljasonxing@gmail.com> <20260516123127.1A234C19425@smtp.kernel.org>
In-Reply-To: <20260516123127.1A234C19425@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 17 May 2026 09:49:46 +0800
X-Gm-Features: AVHnY4IkiF7kus0UIm1_JsybGIshEID6rvZs8CBtI_oGvGHBAcRvdcmb7VqBtVo
Message-ID: <CAL+tcoBbv-dO9CEm5cWHyZ7Xt4siJfvWuWndizXX5KYO65xFeA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 8:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] UAPI breakage and transmission batch abortion due to returning -=
EOVERFLOW to userspace
> --
>
> commit 1d238b3786b35997fb62e781dd7528f204ca8b34
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: drain continuation descs after overflow in xsk_build_skb()
>
> When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> only the current descriptor is released from the TX ring. This patch
> introduces a drain_cont flag to properly handle the remaining continuatio=
n
> descriptors, preventing them from being misinterpreted as the beginning
> of a new packet.
>
> Link: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.=
org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 0a6203c425766..9c51eed6ee99c 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> [ ... ]
> > @@ -1062,6 +1064,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > +             if (unlikely(xs->drain_cont)) {
> > +                     unsigned long flags;
> > +                     u32 idx;
> > +
> > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags)=
;
> > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr=
);
> > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, f=
lags);
> > +
> > +                     xs->tx->invalid_descs++;
> > +                     xskq_cons_release(xs->tx);
> > +                     if (!xp_mb_desc(&desc)) {
> > +                             xs->drain_cont =3D false;
> > +                             err =3D -EOVERFLOW;
> > +                             goto out;
>
> Does returning -EOVERFLOW to userspace break the expected UAPI here?
>
> The original code suppressed the -EOVERFLOW error to silently drop the in=
valid
> packet and continue processing the batch:
>
>                 if (IS_ERR(skb)) {
>                         err =3D PTR_ERR(skb);
>                         if (err !=3D -EOVERFLOW)
>                                 goto out;
>                         err =3D 0;
>                         continue;
>                 }
>
> By using goto out with err =3D -EOVERFLOW, doesn't this abort the transmi=
ssion
> batch prematurely? Any valid packets queued immediately behind the malfor=
med
> packet would not be processed during the current system call.
>
> Additionally, if the batch is aborted before any valid packets are transm=
itted
> (when sent_frame =3D=3D false), the __xsk_tx_release(xs) call at the out =
label
> will be skipped. Will this cause the global TX consumer index to remain
> un-updated for the dropped descriptors, leading to a ring slot leak from =
the
> userspace perspective?
>
> Note that a later patch in the series ('selftests/xsk: fix multi-buffer
> invalid desc tests for drain_cont') acknowledges this behavior by modifyi=
ng
> the selftests to tolerate the early return, but does this actually fix th=
e
> underlying ABI breakage in the kernel?

Yes, Stan also pointed out. I've already removed this part in the incoming =
v3.

Thanks,
Jason

>
> > +                     }
> > +                     continue;
> > +             }
> > +
> >               skb =3D xsk_build_skb(xs, &desc);
> >               if (IS_ERR(skb)) {
> >                       err =3D PTR_ERR(skb);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515123018.80=
147-1-kerneljasonxing@gmail.com?part=3D3
