Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794285735;
	b=Nqf1nIAwqT6VQzRdd4mCF+CVGRSTgy89oVeKAeis2AneUMDFhk6XOXcI+Zl4qmn51jjK
	 o22O2vtWHd0Bfpp+avjBizJJzqXWbCkS5wM0Tv8jN7UXIgrPj2r/cIHXg+wlqu8hSiWll
	 9/sAwhPey4dHpH/xxqhkjy4mnOQPei/Z3fDbtcxh74nEDWdoKwrdRpEHJgTEStWDtuVHh
	 GjA8klVQaUe/TGelSJChLkOfhxFmghENmbUqaomd+Ci8CtNdIIEzkV621uBfH+foGPq88
	 cM/vMwNxG8n/nzI9sK2Mp2RD3mFEhT6RTJkdKdZfxSOVo4ZxiGboAVWR4BpIH9HdmMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
	b=gcFMsxkZQwiKvCKPIqiU5k2dzW4YNgBIwChL5KZng/71Pk73AjxUKFfElOkimnJW26KE
	 huTpboevSoSxUL5fbU5EgCs2mjHJbm9tt9VPIxAsNI2ZhmL8DBr9pGyUl1hIQMpS3KXrM
	 z5hbIqWUHSdXCkBpuNw8Rj2v/7ImHVPhQYI7SoeMmAtkXnGAxmUbU18DNPHN7nRfaIS//
	 JGidF7WIjV/24dl6+b7oIvidbDfH+uUQspeJ3eTuztgImN9H+FD0bGrwC6TodW2ojjrJI
	 YUylXJ2Nv0AxVxxEfeS3fdhlF0jd1tSCOR2AB2VopbHjg2wto2jgp6iVoAU5wRTvQ+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=b9b4S9xe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61275606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61275606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=b9b4S9xe
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6deb848ddd7so972872eaf.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 20:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794285734; cv=none;
        d=google.com; s=arc-20260327;
        b=VGAjYLAG7Qhl14yFkyNNeFDuM/TxIsckn3e0M9ZRIDCDtp1nQqtHZTOOnDYxbAJJMp
         z9dmBhuRJkB4vs/XGhnKA+ZVsFb07RJRd2vDzfOCtlH7ydGIqdKzKq3EaSuza5Sw2vSa
         X6PV/pri0pzfDfVWrg9rccrODN6B5XPbxdDW6aCFnhDMfnoUaixmwfgoYMRcVEhIlc1x
         GD7462FodQ1oWefVacJKbR0BiAHOscEbhDPYXX7oLOF62wgeypq4Mr+ZQo7w6STC7v9A
         iQCQCu0H4+OigSK2KjxvsPGgrC7VM3M0zRlDuY2N5y1w2Q4fLZHePFn85TwwnB1Dqbiv
         nIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
        fh=PqfXm7a08WrvkxC4ErIq7QV7bol4Dqx8CeublptW7zA=;
        b=fkAHBncjZ8sPTHE2fO8qD4I5oz3afOV9y4fm5e2qgeKypIfSJvpmrcRXnKTMf8npv0
         u2gwjluZKYP31t4qs3pZ7ZfnQD3akT1GH/m+Q/wKCbbOOszkUDjXB7E5AklBaANGy6GA
         lFgWaDqACEODL+ULjgSuPHceyqptf47HdOdr0KYJaggVcQXgKHZ24TigjEjSydmceAmh
         euQKFF03HMF0rnyqXlZJk4EEvBStVOFgKlFFm2uoAtdpXuVoAcgzYmGU1kStS+um+TXv
         /b9wYKoturSJcYCYDUetn3xlGhJByFLmtq5dgvg+orqGpgcn22HmxylCyjpP63AvrQnC
         Mv+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794285734; x=1794890534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
        b=b9b4S9xe+a74H42mepjOtMbGyeoNkHxGYlxrlGyNDZSur0CvjY96uY4+R1WUmKZElD
         NHdMl36sFQhngkklNn2TPpn8YMZqwZCvjXga58eZ0nW3ogacdY7UAeJ0kT2twLrN+tbv
         AZEQ+zH3Z25hnPse+czCleH5UT/PhkQRdGFx441yqGoGHvJHjGtSSeWJrZB0lQ+Czh6r
         ehiftpM5u8X/HKK2EnrWUOVVX1GCAn9dwdedmRT8TQMVtiD0PZ63yxs9pFM42rnw3KXM
         vA91kIs/J8XeHc/fjacpfxkU7g6QvS7slfAKL50TFvPONSWDd8RQKR41W3uKGLrfL3Fw
         bJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285734; x=1794890534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
        b=wKLoHYWm8qCUxGe4lIipBlZKsRM1NaSZn5APTMhD7P2wAHFNwEeLtMn+v1tJfxKbMz
         21sHTutCLVhEsN6KeWTXfobwCSevql5NJPBpvSoLjBQnPfczdYlxhIL9LZ2JHC8vuk/g
         86hnsbBhSgh9BjoW6GetEW88/hCbODQDuhjF9v6R8YshWEl2togd5Bgg18iZ4BGWLkFc
         8/Fb//SmFCl5yCnP3PCQ38jLbYeDpEyB3KoOxmgBycE7q5V6myJTDDYBXB8Vcx0oXJGc
         a05yLwiuXxV9WO72yONTGejs2NAo1/XeseGmsJMjID0uqG/gaeVq4A6XmUYmCEAlyUM/
         SaIQ==
X-Gm-Message-State: APuU4Z88ip9lvjwjbPuyOCWhwE24ywbCPE0Zrq8bbsVWqS8zu7zkFLnT
	fR5q9GXcbUF9gAqp8ad2P5LJQ2QA7ViWxdoCFnZaj4C8GvHFA8zYciMXWO/DHt6pdXaMDc0RYtj
	zllfsVaY42E6SZGkK3je9dHfTEjjZzfzkiFUgf0uF9ZjDy47alGwEMfXhWQ==
X-Gm-Gg: AYBFou2Hgtz/3XON1aBHat4wN8XP8rfFbAQpVxD6ww5YpfIVeN3wtvGZFrcoDhcswKV
	mYdH6+jp94VsNOHsezCv04+9CJZUbsAQYgrxF6y/E/1mn912yNxKutsOzsh4FRnWELMmsl0aKRB
	DAWeReIo9n0JAwvFNAC9Cbrq8B94k+pT5+jghiqwlnZq9KoRuyKj/PH0uwqk/UlQgbppN/LvQ1E
	Sw35BP6+o2V4kSJDVBJAhqxr/A8QJvxjZfdLy9ibnIA8kuLEzPgpHGeisPCAlvyxa0pZNKe40Ru
	3emG4dsfXlvQTlzzBzRwI/NV6iwz76zbzGfdIb5eqpztGVVWIo+/JSpa0b3cxKiJ37vQrE1j3RR
	LPNhtDDofRCr0bT6LDMvb/RnTNaj07q/nkbBbl9DFw66i8Bj3uU21LzksYKrdw55rBYKzHBbX65
	Cih7Layn8+LA==
X-Received: by 2002:a05:6820:824:b0:715:2424:b6c7 with SMTP id
 006d021491bc7-718a25631ebmr744221eaf.2.1794285734188; Mon, 09 Nov 2026
 20:42:14 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
 <sashiko-outbox-206183@kernel.org>
In-Reply-To: <sashiko-outbox-206183@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 10 Nov 2026 04:42:03 +0000
X-Gm-Features: AclHuK8b0bXERRMbxB4h1nf7ja09xd60YTNUFZCGO3eGicEqv2ygIU4ZDyBl9Fw
Message-ID: <CAG4wq-f7LgXVUu_DpH_Nk1ab1ghistFijw1m2mTxHxN_0hBWxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area
 after the xdp_frame
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Both comments follow the style around them in include/net/xdp.h.
Most block comments in this file start the text on the /* line.
I will keep them as they are.

Cheers,
Tianyi Gao

On Tue, Nov 10, 2026 at 4:18=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] xdp: multi-line comment style violation in include/net/xdp.h
> --
>
> commit c815cea2f0a60c677b6335d7bc98d4ff8c9346df
> Author: Tianyi Gao <tianyi@cloudflare.com>
>
> xdp: reserve an skb core extension area after the xdp_frame
>
> This commit reserves an skb core extension area in the XDP headroom after
> struct xdp_frame and updates XDP head, metadata, and pull-data helpers to
> preserve it.
>
> Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@ke=
rnel.org/
>
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 07231adfb5f82..c888353425d42 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -81,6 +81,9 @@ enum xdp_buff_flags {
> >        * XDP program is not attached.
> >        */
> >       XDP_FLAGS_FRAGS_UNREADABLE      =3D BIT(2),
> > +     XDP_FLAGS_HAS_SKB_EXT           =3D BIT(3), /* skb core extension=
 header
> > +                                                * is valid
> > +                                                */
> >  };
>
> [ ... ]
>
> > @@ -450,6 +464,37 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct=
 xdp_buff *xdp)
> >       return xdp_frame;
> >  }
> >
> > +/* skb core extensions: RX metadata that an XDP program stores in the
> > + * headroom right after the xdp_frame, for the skb that is built later=
.
> > + */
>
> [Severity: Low]
> This isn't a bug, but BPF coding style puts the opening /* of multi-line
> comments on its own line, with the comment text starting on the next line=
,
> for both XDP_FLAGS_HAS_SKB_EXT and the comment above enum xdp_skb_ext_id.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.=
git.tianyi@cloudflare.com?part=3D1
