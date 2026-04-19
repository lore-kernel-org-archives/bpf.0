Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313220E023
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776603990; cv=pass; b=jks4taY9IRoChYKGLT+X3Xz2Ump0HyRCAv3NaRB56tCFpWYeaeLtWpd/KCYE6qzxMniExWY3QH5c8XwyF9IUE4c34220B9vKin+hFiGwpw5bbf2BZDWEVWNWPIZjffezVjs8Fp95IfVinEmW1mMVwLP8aAULVjY89YD2IZUotn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776603990; c=relaxed/simple;
	bh=M3ycx3HP78yqs1oPUoxtzecetBA0RfqqZYVsez8A+0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYPU+i/iu9IOEVAMHXMB8rIv5f9xmpu2A/5Fn9rJ/gJgczA7heP250j1LKf7ArZRqANVd8L0fuXH7IVPrjwlabrTQ9MTheKbSt+LokxeH4f6tatjCZhgvd7+jjMKineG/8kyqQlCKSSypC/PArpUVfClcDWNkZYExOT5W/RV29w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxcn4aZw; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxcn4aZw"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38dd9f0fdc6so33906751fa.0
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 06:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776603987; cv=none;
        d=google.com; s=arc-20240605;
        b=f1U+8I5HCrmQ6eJ2w1rlZBmHs6+7I2+tmpp2GWMdhW1eXGmNw/ELfZ/ckcGCRSatjA
         oO4BG8WmSVclegV5o+GUwjx3sWoK1A0fhkcnsit0NMlo4wY2x95ikeqQkDL6XWDfbha9
         nWYCQe0G1ljPNfuKPjgnlYvIzfXQH+9/hNvlk9En5uISn6KOe4Xbj/pUx4LxL4y/Ewk0
         Ow7O5wExwtkkGsvq4+CGDthP/t/wqlrWZg7FCRHFw33CxzKGNfEYuoU/keRRbXEN//cj
         7/lO55/xHOXhlpII40XctQlLfIjQqAMo8CqTg/+EZYRFJh/DJyQSocAayurU2AF7j+nX
         BaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WNpC1nd6L0CPDk4zbCH8Cuo2VCHC85lBeU44RC3l4ik=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=c2TI3PO2jDXBMCyWrywuJ/d3WrwurGQsDt+dRM6x1PpgOfhtf9FwjsXSjABVv8Z2xT
         7jPZOh2xeRCJGRf1JTI+1eIvd+Athqi7P7vn/bSp6TlHhZitvQiVcc44Yg6E34SPsNkA
         /F0bSKr9toP2qj4Dhc3XxSYN3WuCPYFOLvYf4PgpKd67ISmJHTgyz9kNORj/GHL06dMp
         N0Mc6bwNqKk3dN0tcc/AmbRpts+O9WT6fb8RLxtqvxI12EdEaU9xwhRGniz5A29lQW+a
         wDGN23wAULV2rd5VL5R6bYaQOoeDwctjAUDQXmH6Q2dTCVVh4aF3BuEkAN56vOcO7iPa
         5nHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776603987; x=1777208787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNpC1nd6L0CPDk4zbCH8Cuo2VCHC85lBeU44RC3l4ik=;
        b=fxcn4aZwTOuV/GFfu04YnX7Ijdr56mZHERdV0MSpW4HKkhTwUm+JhUEcYTo7Uw2GI3
         nabLdxQELaW6ATDZYKNnX3fHoz2yLHaNGrxS+8IY1SzpFBlpD5DvKCzGQppf8eR23c3P
         +PRjHWjU7Y2VMCjIK3DzIqrHpDle3Pz5OCIKdLawqfDPGiQMiOzuiDxgd64gtINP3bEt
         7WltbJ6uqNN9+i3c58i8WziSLPLuXuEBJZcik2JR/IdL4Ftzc8/dAlC6VnvimB91naMP
         kLzOoIplm7f3BGEsZGHIIPW396K6kP9nh4EfFW9Kp5uIQlZv0LugZaVkYI0Cm0RCF32h
         jK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776603987; x=1777208787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNpC1nd6L0CPDk4zbCH8Cuo2VCHC85lBeU44RC3l4ik=;
        b=Hp2ypbcIOks+l5Syu5c2idGCIv3ny7+t8tfGjCtYt3z8JweMIUIQaZwle8OFABnWoC
         fUyepWVNhyRGcekU0Os3RMuTiK5aE5AgFZxf9mhyqEFkSn2KCeehGf5P9S+at75ngmT4
         Wor6901MuK/r+kQIUDPs84gaxHmsorI0yiUhlwxt1DiWPURZvq5jPnQ/qz8VFhm2GV/w
         0UjKmGLc8ozliIRqTjr8UVPSWmtoA76EHZt5zqjcyVORgLogglOiPWd3XsDhArAeZU+X
         go3l4zVVYvpztmZ6jC5yeb2OXbuToIaUyyRTxIKkhjJAumT0DIyn8BvKx5fJ9O3BceU1
         8skw==
X-Gm-Message-State: AOJu0Yx5rejPighLC98YBrixZBPRSHqScPbSOlSM7zO3wQdb/HF0pxXZ
	rlL0DqlcCpKpL6nMCbzDZAD0JozkqMZrw4i79MstCAiOL0z8o4X0LNCuNTu4KNurp76MszPQZs2
	1hNbrgPIoR4aoP8Q4pRn0RfYx0sZUe8ldPY8DwwiZcg6g
X-Gm-Gg: AeBDiesSTG4fCEP2IZCgiAnNf2m272Oj40HoTpUDZY/m3vSEs7ntzwyqkpeZV8l87bc
	Cx2zm+fPRo/nJhsrKSwhMMhc6QwrGWemR/+S/ibhMAkmNXwnvgwudBwtlUkhTJlHla+ifjLqWIX
	XJ3KQhtRKING/sTSSo6+Rv9O9kCC8kejZf3WxfKjGVOpgT7cTUMVEzG7Ru5aWhSXvyUQlmwaqRG
	Jem/1rhdNY7fxNVa2t/15QcXWOwrpMqQEYi0qu/THLqXWonsHYa44IS7GZ7klWmPBseorLduoV3
	EZZKOXEwL6TjUIfpBA==
X-Received: by 2002:a05:6512:b87:b0:5a4:a85:ba3b with SMTP id
 2adb3069b0e04-5a4172a7831mr3011387e87.19.1776603986447; Sun, 19 Apr 2026
 06:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418045644.28612-2-kerneljasonxing@gmail.com> <20260419045822.843BFC2BCAF@smtp.kernel.org>
In-Reply-To: <20260419045822.843BFC2BCAF@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Apr 2026 21:05:48 +0800
X-Gm-Features: AQROBzCsB7ApA1p9olQI3oqDJZGQEhh5rgj8TiWKlM2IDkapmoaT94KipW8DKKc
Message-ID: <CAL+tcoBjsFmJNe-yQS-hgOtZHk=qMSpHDcqoeF_hyka_MWduUA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] Premature SKB free triggers AF_XDP completion destructor, corrup=
ting the Completion Queue (CQ) and causing an infinite TX loop.
> - [High] Calling `xsk_skb_metadata()` before SKB fragments are attached b=
reaks software checksum offload and permanently wedges the TX ring.
> --
>
> commit 7fb48e575c16e2e098969186062c6a31c8245353
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: avoid skb leak in XDP_TX_METADATA case
>
> This commit prevents a memory leak when xsk_skb_metadata() fails by
> explicitly freeing the skb before returning to the caller.
>
> Link: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.=
org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 887abed254668..5b273bcd0dbce 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -823,8 +823,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >               xsk_skb_init_misc(skb, xs, desc->addr);
> >               if (desc->options & XDP_TX_METADATA) {
> >                       err =3D xsk_skb_metadata(skb, buffer, desc, pool,=
 hr);
>
> Is it safe to call xsk_skb_metadata() here before the SKB fragments are
> attached?
>
> Because the fragments are populated later in the function via
> skb_fill_page_desc(), both skb->len and skb_headlen(skb) are 0 at this po=
int.
>
> If XDP_TXMD_FLAGS_CHECKSUM is requested and software fallback is active,
> xsk_skb_metadata() will call skb_checksum_help(). Because skb_headlen is =
0,
> the bounds check in skb_checksum_help() can trigger a WARN_ONCE and retur=
n
> -EINVAL. This permanently wedges the TX ring since -EINVAL does not consu=
me
> the descriptor.

I must state that this problem is not introduced by the series. The
following commit should be fixed soon:
commit 30c3055f9c0d84a67b8fd723bdec9b1b52b3c695
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date:   Thu Sep 25 18:00:09 2025 +0200

    xsk: wrap generic metadata handling onto separate function

    xsk_build_skb() has gone wild with its size and one of the things we ca=
n
    do about it is to pull out a branch that takes care of metadata handlin=
g
    and make it a separate function.

    While at it, let us add metadata SW support for devices supporting
    IFF_TX_SKB_NO_LINEAR flag, that happen to have separate logic for
    building skb in xsk's generic xmit path.

I'll consider folding it into the next version even though it's a bit
complex to handle :(

>
> > -                     if (unlikely(err))
> > +                     if (unlikely(err)) {
> > +                             kfree_skb(skb);
>
> Does freeing the SKB here cause issues with the completion queue?
>
> Just before this block, xsk_skb_init_misc() sets skb->destructor to
> xsk_destruct_skb. Calling kfree_skb() triggers this destructor, which sub=
mits
> the descriptor's address to the CQ and increments the producer index.
>
> However, the caller xsk_build_skb() will see the error and call
> xsk_cq_cancel_locked(), which decrements the cached producer index. This
> desynchronizes the queue reservation pointers.
>
> Additionally, because the error is not -EOVERFLOW, the kernel does not
> advance the TX ring consumer pointer. The bad descriptor remains in the T=
X
> ring and will be retried continuously, potentially causing an infinite lo=
op.
>
> Should skb->destructor be restored to sock_wfree before calling kfree_skb=
(),
> or should xsk_skb_init_misc() be deferred until after the metadata is
> validated?

Amazing really. The same here. Sashiko checked this pre-existing
behavior is buggy, which the patch 1 only does follow.
In terms of the free_err logic in xsk_build_skb, the untransmitted skb
should be freed by the common new helper:
static void xsk_drop_untransmitted_skb(struct sk_buff *skb)
{
        skb->destructor =3D sock_wfree;
        kfree_skb(skb);
}

Will cook it as a standalone patch to fix the commit:
commit c30d084960cf316c95fbf145d39974ce1ff7889c
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date:   Thu Sep 25 18:00:07 2025 +0200

    xsk: avoid overwriting skb fields for multi-buffer traffic

    We are unnecessarily setting a bunch of skb fields per each processed
    descriptor, which is redundant for fragmented frames.

    Let us set these respective members for first fragment only. To address
    both paths that we have within xsk_build_skb(), move assignments onto
    xsk_set_destructor_arg() and rename it to xsk_skb_init_misc().

Thanks,
Jason

>
> >                               return ERR_PTR(err);
> > +                     }
> >               }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.28=
612-1-kerneljasonxing@gmail.com?part=3D1
