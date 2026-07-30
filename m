Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525B3F0777
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406070; cv=pass; b=M0ax83J6IC95r0JgQzKvNY6Au/5Ly5BnMm6svtsUHBRgdS0+aYiar/CqCulvjudLYQhLBnQ7uQNJ/h5r4lcBhhZLSIM4pazU9jHNjpd3bJEM8Kn3zvp16tv1DkB318wtZHecGlyO9KmF++8fpeq3cadnGW5A/8SP29aP32E7RVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406070; c=relaxed/simple;
	bh=NNB2/eQ5qtlsKJHPSYzxMSi668Tr5nSHjwyWDulI2PA=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiJZdlyttHp6SJIixik4YAfIF/jDSfJCbs0uQlg66y1BNkl2GnZz0WSZ0wMErlIM9vDXTRlNSDxq37JugldgrpQTJQGGOVnb8rhKN9m0qQX/NYrvlsNmUtT9DI+5utHc1kdcq0SyXEBP3o3N3t+DADuIve05dkvOaFdI8rMBGaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKKbuM3D; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKKbuM3D"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6689402c7bfso2194284d50.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 03:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785406065; cv=none;
        d=google.com; s=arc-20260327;
        b=oIkb4Z44y/J1V6a2jyHXZDQpbHAZoTu3jkAqvL398JrOBqucuTsNGrNUDUVf9HUBPd
         nXOHXO3XWpez72x/Vw3tuRVOT1XjGvtKkYN5BTP9D7LW3P2PzYgwqCh5Z2Vx+q2HwR5k
         EJjSrWj3b7epcw2bSTmm7v/7L5u8xG59q5XhXKe9l2cZue3Ej5NTw4BQRXP3b30VVv23
         YQsMlpNNaQxJ72kGoXpP67LeOGeegQA/TjXAGr2AguAsbDErs35s8VeU2pXP9Alxl69w
         G1LX4SGeaTCzo20gw+N3+1FIMEjawte/bwNcBCQZNDghz5NRy0ph2Y72sV331q39c5PS
         SJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=NNB2/eQ5qtlsKJHPSYzxMSi668Tr5nSHjwyWDulI2PA=;
        fh=obbJOSQTNrWpNAq0DaPubzw17oEYHp61ikwpn/Mep5A=;
        b=O8gRu3pIy18djzLg3iesYDZXLcmF9zE7131+xY7B0Va7UecowHPokBCdJ+VeTV+d/G
         khNneUbwy2bpAPOLZrc/q4qXEux232ObeVnWIXzCYRjCPaVyqUVTnolU9hhPwxtDY3jV
         mkbPj0815pfANsnjHqVGEB4tT+qO2i7WgOy2vsFlu1DXZA8kBQ2G6yIDsFZQdGFj2e8v
         vUxWYiK2PhfdJlwCGGuGB6W/vG6d+gNSylACDvHCMTdMp78EHXSTxrMON8yjLK0B0wSI
         IjGiQR/QbpAcXAMPmKWsht9zklpTKO/QmjPnlAwZSvQz3+ucRgbaQDKJ6EAQcA5iWyjl
         pOtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785406065; x=1786010865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NNB2/eQ5qtlsKJHPSYzxMSi668Tr5nSHjwyWDulI2PA=;
        b=IKKbuM3D5vbZ3fc1MhSfndH7ukvwzepK3VpvfkVIpOR/X9i7yQH0KwXcMIjK9+x0ia
         m51kZcD55Cnvz1qCIRQbDV56QkQU3c1AwG2zbeL4mJm82wpu1B75Yw6j3Bi/4zl+WnyC
         5iRFVD7adIVBwKDU98Xv9A9rJT9D+o8DNjTKLxsj5bl04Dl8IpqNEJ0rgMGfAcGqbY8N
         uk4so3zBFUdNPiNOpRud/cIKRrU1n+8wXhhut0YKVBXn4m4Y6cZKYF4Im+7mSZk49Uxe
         HauBWyUAD1Co+jpWGFyVKbFLuesBuAABdD8ZKNB8qXfFYs7u9uAsWT9DcQJknj/jdMPH
         fsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785406065; x=1786010865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNB2/eQ5qtlsKJHPSYzxMSi668Tr5nSHjwyWDulI2PA=;
        b=JyNwuABJ/TjzqznToqsyf16qLX5pvuUSpdI0qKjp5SZOEx3D/w5PGU3JNbOx29DtnO
         TyJdd93usDb+4Y9n6btGe18gss+E/JCZSUbSOBfbRrZ7BOvBSrDmR5KfkjlnqDU8Nqnk
         eSH+klhiHIA04szkvGDph3VsrfMfoc8p5RnEBRO3Kby9n9zl8zlNWGdvaj8dRvGGJSHm
         lcdyET8R9WhPvdAy0tgjKK4E4qQ27LFTtUUTkGvTqFQ9wWsqgcNx0PoFmALdX33UaOaF
         AjRRtDAPGVFEogoss6VaXppjmfzAegyz4OddJS454YlzS/h+x/DejfLfiDLcldMvu0Hc
         qiKw==
X-Gm-Message-State: AOJu0YynqOeKDIkksWGPqRjdGda+7t8YqCxR7juuV8ty1SC3dZPobKMK
	neg3kHFH+lQA9zWhdTEDcCIn15ov/JJR9NuGIObnZCjf6nKv5U4KY0YJ9n7j/D4rayQDRGeRYzJ
	f7dq8UTbL0ls43MDnLjXBX38eCwMHp/Y=
X-Gm-Gg: AR+sD10BJh8P2kF07pkwFxWCj7qzSiCJHoHm/juP9qhBTFVyOZeFPsWtxYgo8QPA6o2
	T2gSm+6Ms6Kw/aup60ubKfTMejtFobkGxF+0QWTwkRF8cYOI001IOboUI0F0E+bDUJTNv083wlT
	CyIpgM3A2nmDHQNcJyj52hnIimh208ZUMfWX0SB9YqafaXm/9iBss9B5CND4Bd5FjRZmYzNRWgb
	EPLSrIhD+UCowrHh/Xdy2KIg+orzZ5aJBjEDCzG6ByPwctmzdDtHwraEymr3gbuuBLgCyEWl2Lp
	GKju4KUIuhStq99q8MjnCkoTn5ff+Cp98xFz1tlG3y2cfVY/7GlwXxOwIr4qhYWiUAl+hFI8ibm
	Bs3oMB+0wwJhUAoY=
X-Received: by 2002:a05:690e:191d:b0:668:89d3:27dd with SMTP id
 956f58d0204a3-6692f202b94mr1358252d50.0.1785406065229; Thu, 30 Jul 2026
 03:07:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Jul 2026 06:07:44 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Jul 2026 06:07:44 -0400
In-Reply-To: <20260728032611.3F6FD1F00A3A@smtp.kernel.org>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-2-sun.jian.kdev@gmail.com> <20260728032611.3F6FD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 30 Jul 2026 06:07:44 -0400
X-Gm-Features: AUfX_mzOw7ZMmowzx6kRcDMPfDlJnl8jeV3FWRNX-tuAH0gdhzdnBALEqlNTces
Message-ID: <CABFUUZH=Tqi6UfQ=AkbsotX7hTfTRqxK5KEf-+X9kCPbc9SvFg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: fix skb length accounting after generic XDP
 frag adjustment
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sashiko,

Thanks for the report.

The scenario here combines a tail adjustment which removes all fragments
with a head adjustment. I have not reproduced that combined case, so I
cannot confirm the __skb_pull() BUG_ON claim yet. It is outside the case
addressed in v2.

For v2, I am keeping 1/2 unchanged. In the generic path the final tail is
updated with skb_set_tail_pointer(), which does not consume the skb length
relationship, and the length accounting is reconciled immediately
afterwards. I will investigate the combined head/tail case separately
rather than claim that this series fixes it.

Thanks,
Sun Jian

On Tue, 28 Jul 2026 03:26:10 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] A generic XDP program can trigger a kernel panic via BUG_ON() in=
 __skb_pull() by dropping all fragments and then manipulating head and tail=
 lengths.
> --
>
> --- Patch [1]: [PATCH net 1/2] net: fix skb length accounting after gener=
ic XDP frag adjustment ---
> commit 553adb7b7f41a20f63d7c32e81ef98469247c00c
> Author: Sun Jian <sun.jian.kdev@gmail.com>
>
> net: fix skb length accounting after generic XDP frag adjustment
>
> This commit fixes skb length accounting after generic XDP fragment
> adjustments by keeping skb->len and skb->data_len synchronized. It
> subtracts the old data_len before replacing it and adds the new
> data_len afterwards.
>
> Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.o=
rg
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> [ ... ]
> > @@ -5497,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *sk=
b, struct xdp_buff *xdp,
> >
> > /* check if bpf_xdp_adjust_head was used */
> > off =3D xdp->data - orig_data;
> > if (off) {
> > if (off > 0)
> > __skb_pull(skb, off);
>
> [Severity: High]
> This is a pre-existing issue, but can this sequence trigger a kernel pani=
c
> via BUG_ON() in __skb_pull()?
>
> If an XDP program drops all fragments via bpf_xdp_adjust_tail() with a
> negative offset, grows the linear tailroom, and shrinks the linear head b=
y
> consuming the newly added space, it seems __skb_pull() is called while
> skb->data_len still holds the original large fragment size.
>
> Since the fragment adjustments to skb->data_len are synchronized further =
down
> in this function, could skb->len drop below skb->data_len during this pul=
l
> and trigger the BUG() inside __skb_pull()?
>
> > else if (off < 0)
> > __skb_push(skb, -off);
> >
> > skb->mac_header +=3D off;
> > skb_reset_network_header(skb);
> > }
> [ ... ]
> > /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > - * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > + * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> > */
> > + skb->len -=3D skb->data_len;
> > if (xdp_buff_has_frags(xdp))
> > skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > else
> > skb->data_len =3D 0;
> > + skb->len +=3D skb->data_len;
> >
> > /* check if XDP changed eth hdr such SKB needs update */
> > eth =3D (struct ethhdr *)xdp->data;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727032535.13=
469-1-sun.jian.kdev@gmail.com?part=3D1
