Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FE2DF128
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733786; cv=pass; b=iSIMNcjF9tLR8ldZQqzwdALtBoP1AfQ7r1zHZQMcw6qbOVvStBt38CeYwGIOZd2pluyu2aXYBN29/H4qljQbhSHiQwMbNs2mTRvov4cdsBxLXaqw78+4F5E6ljV6gp297JkQ3oXjvNh5yf3tzEa5pURprTHloTYGcdRT8PfSgbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733786; c=relaxed/simple;
	bh=j70uu2FMwecarTBfLTkycEwqg+OUmVrVo5QBmX5ENNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avXMztK36Jxj7uu5JiV2qt8EZitKjKnRREg8ZqefndYBRm1d1HdqVCrNeqegUr1CUDP85ResVXoBHa71fI8A9dyhita4FRjYeGJeU8rU8GmsOME5i5j0ugRYUJ4ywqzro1N1acdUjs5FUWsVSYOxMTXmqOCLHEON7b7ETLEoLps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u9DoXmh5; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u9DoXmh5"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-144e1b6d52cso2866c88.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 08:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791733785; cv=none;
        d=google.com; s=arc-20260327;
        b=QJH2s2n8BGhPpzGy4DqMZGq0DqZ4Yl40/1fbwP2nkTFblzkBZDNgNa4b7SKcwu2mfh
         aHbc3QMsaz6M06ucKwbhkzS6rVhmWA2FzNHEK2tlhRBKtUItiqGSP0TEmTqhBfSnjpB6
         beQWBSeVeN9iqpFu2BUJq0HjFMqavL3WotT30AVz3x5j6A8PxKtFGBU6C0XPJkiunSvs
         FuCGqv5vRk7lgnJ9JnqHWzQqNRqpE3BKPBsApd4aaMKYgSNXtrnFTt6wgryquHLDdSZc
         bQKvdPtBVi+2AG9x99V4ak1WLjY9KEc2okPdREMYUY72CfeMwkgAb9QLGn62dUUG38dl
         dnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecTB/b1KVuwggL9v6W55CF5SsosIuAwWeEbKXxOAN1s=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=B3J4nY3LtdGJTE2R5NP9n/koQjp707Q8rexzMvm/uY2TpR/8EMPcSmuUlJSJbGMrVm
         fN6/asyT6BSfNNAq9rI4fX4ENY1N0btkl1IMWokAdv8FWt3kOntakircOSOdTpwOKlLn
         HTHrJJHZCssPzSjh0qS9r1ttuy2cfAOmt+TKvqQsNWhdW4z86zgoovqaii1Z6WN7Ttd1
         lkRgeDzsFpHkcjZ7RQyU/yARm8m61m9u2hLSXDJ8zGWbzR9qHXenlxdBXVuVdRtSqoPb
         L5e5J65lcdDI0GKN+vhnE3fMF7QBkNbadwA0F+i0x/GNiAZxkbdkNeHnXjRnzIUPmdsa
         O76Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791733785; x=1792338585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ecTB/b1KVuwggL9v6W55CF5SsosIuAwWeEbKXxOAN1s=;
        b=u9DoXmh5uZkrkWi5/NRZ+tBsPT+5m9WFAcR//aJVIp0TB1RgUv2y05L7BsXcKl6WDf
         xOp+dBTP5W0QhFMIMwkCKTqBgDY9R/fRRNkLSc5bCh8i8nsd1ah9PXlcvo/JGb1IvHTV
         m0W4atwmV/IeoOOqtgKNzMIJLd3NNoG4A+M0XZx1oSE9zLKfZ9Gr1u58bGVvu9zcHMl9
         FzWpGHcL/ChV59S0p3Tb6anWq6R1Lj/Di0ROBDKshSb1m9Af4hno0ZWkxGz3STbnT1b4
         8vC1blAuu74wDQCIu7EvK1a2H/XPq/sZgkhQVF1eqcWCFFH+BbaxNQs3FIdBlXZfOJyQ
         88Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733785; x=1792338585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ecTB/b1KVuwggL9v6W55CF5SsosIuAwWeEbKXxOAN1s=;
        b=tE8Q0Y03PwZKQ5fG2YY9rhhcQTTMqgths/EJHhGsqmeEdBnBr4lOh9dRtN9JUt5/Mz
         0w5Sba1ZaEGOftkHse/Wuibopd98Kr9bRTXf2Q2A64EifnaVcZUcfyHnllGUPHQRTF00
         KVtnb5Gnffir2xYPajZiPplMDJk8d+5BOh07YbxSnfAKorQ2EJzOdl5UuKtw7rdH7SrC
         b782e7+/0u4R7BnwCKJgt3GpdMXDcl0qIPwBr251oyPOT6Zls503JCkhOkoLaTNUm5us
         MK7SY0RuW+pYMm1yPEFWqsP0s/k1YSFw9O3O5hFR+x1RhVAnUTi1rplsMM1tosK0UyMu
         U1xg==
X-Gm-Message-State: AFq9FYKSzJSRPv0ObfKCrwkxf1CgBUHEbE7jm3evxuYMvNWDp5G6SJh5
	vWXDDgm3eOjbHzARotOqea2sXgDM29R5PxUAmzLgylAaYo+3lmA2eld6jFAa8EOCvYKsCS3bx+Y
	tTfCh9I0F0BFNJWf0fsg/uK/D1OeuPg5+BLuhuFZx
X-Gm-Gg: AYBFou34gIjyI5xu2GNU/Qx9EiHUvWZrUipVOf0ulVX07Ae1lfu0iCtRabzOS4K6Z24
	AIaUpY11hyH2rD52Ceiy3HZO/WoLCtsD+UOz+oANTlAnc4GFu0gbI070PTxLZ1Hf5rYK4fNgH7p
	Xys1kjjya+RZWSk9YAN4gJ6A6uP1dSqyZjcPKTEKKJKOPiPHqXHfJjphP6E1tAq/Ql5ofIbK4Vq
	qj7Mf+IBPCU3SPY2atdWd0sWfrpCmfvJWUaZl65phUm08xFY7ZmpldToPUoLae0QOAid6taWk2Y
	PIb6Vx3raHIdY/2rPXpplFvDhY5nFzRvI97aKRdsAJefX+TaZiyi8Q==
X-Received: by 2002:a05:7022:f502:b0:15e:608d:75f8 with SMTP id
 a92af1059eb24-16e254ca4fbmr146550c88.3.1791733783545; Sun, 11 Oct 2026
 08:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010033630.1171692-1-almasrymina@google.com>
 <20261010033630.1171692-2-almasrymina@google.com> <sashiko-outbox-166995@kernel.org>
In-Reply-To: <sashiko-outbox-166995@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 08:49:28 -0700
X-Gm-Features: AclHuK9L0vL4j9AEIumLIt68WdyKkxbv8x7lovgP_4Jg8MgS4qrAZFJli8wQGdk
Message-ID: <CAHS8izP7iHx9po4p0mfOsriKPFiY2Xwa0=Gyt2yxUmLPRG6cxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: netmem: document netmem and memory
 provider design in comments
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 8:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] net: skb_try_coalesce() allows mixing fragments from different m=
emory providers
> --
>
> commit e4f91f2e0cb9de813eeecc8b5549e79dc322d463
> Author: Mina Almasry <almasrymina@google.com>
>
> net: netmem: document netmem and memory provider design in comments
>
> Clarify the netmem, memory provider, page_pool, and skb fragment design
> principles in header and code comments. It documents that all frags in an
> skb must either all be struct page-backed or all belong to the same memor=
y
> provider instance, and adds a check in skb_try_coalesce() to enforce this=
.
>
> Link: https://lore.kernel.org/netdev/20261008023030.1089616-1-almasrymina=
@google.com/
> Link: https://lore.kernel.org/netdev/20261005004958.3603059-1-almasrymina=
@google.com/
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index d56f4f0102f75..69d3d27e29d97 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
>
> [ ... ]
>
> > @@ -6210,6 +6210,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct=
 sk_buff *from,
> >       if (to->pp_recycle !=3D from->pp_recycle)
> >               return false;
> >
> > +     /* All frags in an skb must either all be struct page-backed or a=
ll
> > +      * belong to the same memory provider instance; do not coalesce s=
kbs
> > +      * that would mix them.
> > +      */
> > +     if (skb_frags_readable(from) !=3D skb_frags_readable(to))
> > +             return false;
>
> [Severity: High]
> Does this check reliably prevent mixing fragments from different memory
> providers?
>

Yep this is one of the biggest shortcuts we took in the memory
provider stuff. We just assumed here that unreadable =3D=3D comes from
memory provider and there is 1 or 2 memory providers present and it's
unlikely the user has both enabled on their system in the first place
so we'd need to differentiate.

If we land more memory providers (and it looks like we are) we need a
better way to differentiate. That is going to take some refactoring so
I'd prefer in separate patches. I think maybe the comments documenting
the design are useful anyway.

--=20
Thanks,
Mina
