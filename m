Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD421CFE0
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775212; cv=pass; b=oQr+1SPzNDK4rLCHznGJu9YTpIraJVACj9kIJwM3C8aVJUYjZv2jx+IoDTA44kr1gBN56pqTqksx8Lze0Gwu8NMTbgqkPF9ByUm1kMSNUOSS+Z+OfS57aqw3EyNrMW3jzuMGUPgJiY98p0oh1bFli9S7IiHybYibrruWCxuKgtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775212; c=relaxed/simple;
	bh=lvdgawJx0ujua+qiUXuRIWl8gU6rTNtB+COcEdCquEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7LVWIB3bGW501dCZ68Kbo2XNN+ykqAwrUhIRDZnktDGKz23EHHVbiVHIegNCbenCi8ShQvzgEAKFMhmboH1CsTfIpDCE/m8+eHsDXfPn3CRvMOeWX7kopxdkMj+hbLIPuo5mWZ5/TXnbM2dd0HJW0tmX/Q8/lYPOuANb8QNjwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UURLU4tg; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UURLU4tg"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a402b2d102so4875860e87.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 05:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776775208; cv=none;
        d=google.com; s=arc-20240605;
        b=Rm5cCwcqZX5cgg+PlbV3cwg2RJh98+3A/j0tgCOt7PTj18DNJDUYbpixkcVJMmVoXp
         kbIkjs24L3r2yAwoRlMQNqtLtzObvhLpKwZLW6b0ZOlmnbAFnsjCL7J5CauRrE2sB2U6
         67hRi9IIGq3aqAbBX+wmObxMv/5BwML7p4wVvDgCMYVtOobeBysjhNZC0lCGXmKzqeFH
         afZWpZr/ufdaxLcmh3QUwhwx6MEs2+rfygGlvyaPKHx9n64V+tMYL4m4K4rACmDpFE2r
         V2tfgKhb63/UU7o1LAktaXKbj61hM5BscWVG0TjcN4eqBLKHemWvSheG5RFBw4FyD5tF
         aC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=APV63OegD/VBoeZuqLkoZ95g/HZtt3yngwmMzUSUz1A=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=XoONqEEEE2Z2ynRUUtkDG5Sx4SxCgjUGt0fzvoGpv22ZQ6sMU0h5Y9dmalvpdiUL7g
         hfynGrf1YpMpFe4adAvzZwJ2gLJqloXLrspCjQDPIwrCYV39ZEIlRt3wCBPH3Rbcp5lw
         9Rgp1VCyPsI/TX1CHSPCaKSoyQnDfHhT2hpd7ig9VtsSh6cOLjjsthA759d6srqgK7g0
         8anHY445ZLZlrep063D3tkLemmXAaLzDrsTg3Tc4/68MJ/djHUawyZ6SeTD08E3NOblO
         Ir6OhfnWWHmCUNi1dF0ii2fCqE8V7KItr6v45jUAsBkNF0jFNtJxWBzHrFAZL2SR/pDn
         Fl7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775208; x=1777380008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APV63OegD/VBoeZuqLkoZ95g/HZtt3yngwmMzUSUz1A=;
        b=UURLU4tgfcVyKyBF++F3tiKOv7xV8wWM0GIKUDnmix8B2i91lbOB9YUGXAkXCTKRYa
         f1IuZCPDXed9Brj57cybr0rM34MkkCPRTyqLeeGSJ2KCqQpZVpBZ0aPtw6cYkakMmErz
         VpJrPD/wEA5hSw/iOsQAEuYQFutoYSJ3EVU8pHEy6z9biZv5P8MSsMfQgF6YoZAJdoV6
         YUoCH8v61752aP3bYIL6P8rl2i9Nu2SVW7MJUsnyHkvUBrATQz6I5TcNONFYc4k5uKkn
         P1LPwORoimdlkffU7tRQZmPIdLqhSlUvjTGKse4KBT4LahT0yCq7oBvO3BUV0GK1UP+R
         ohVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775208; x=1777380008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APV63OegD/VBoeZuqLkoZ95g/HZtt3yngwmMzUSUz1A=;
        b=JRN4XGylUIOfVXK2oKnmZ04Kv2rMYKtZs0rLamJwFY4cytVwVIeTm8lL6ywc6VblM8
         9f4am2LWI6ZsB3O1TTsdvN7kuL6ePkMDW3Jddmwj5TGtgqHtfcZHdnfAav7xl+zdQEGo
         HjwRbcrCgTYrGiqdastyXab05ug3ly+gsphu4wwY3fwE+xTUelLzgw6s3gs+Er4ai730
         5A/tvO6QYbUmPnxaTdzTkh4LVR/y6JejrbaPh+TH04HUzXRWaUWYfdqYWB823ErMHctV
         NRLN0pZZ0CpZTdPqZbgfXD5NPXR0OpPMJ5u1SXehjdV7AScY55Zw3524pjTrZOSb8Z2P
         gnJQ==
X-Gm-Message-State: AOJu0Yy3suPxd3aAEcThEKBYNX49vFYLblfSswXX5bd+K0CGy3YJeRjk
	hwxnEoWpF9WnxYrwvwm+Gi4hZeK7o0mzZo+lcvu9IVt5L7WZieNrgvdeHEdc+EKVkQ6jIGOiX0F
	J+CQsthP2Ai/p1mllg9atr3aNAhg7oMehelGE8YI=
X-Gm-Gg: AeBDievGIvjv7/UEI+3dPnm4HjJJbs+bpfVPMINE2hB8DRE5Ix9X5jWE2HPJ+S9dL9x
	U4muZp3o84MucIG3S0mdDSMLmo4Wwp8SMVrulyTiMp3BBdDk3NhvbNP6y8y2SyrcNg3Aw0Lta8T
	hL2Y8B97TkkX2pprpcd8zEi8kQ1hWjbCpWqE6vzc3aVoZeFdeIXvegqzQlEpWfXHTFlICDOU2Gq
	AZWdT1Y7akfHEbsXQZ1ITrwiFXhWBSmfXmkVdHz7Za0zqxJxOTJEZGR9hGo7ep1EEVN5Phue+J+
	KnGmKGw4ffk5Qt0KEw==
X-Received: by 2002:a05:6512:31d6:b0:5a4:6a5:9904 with SMTP id
 2adb3069b0e04-5a4172e4778mr6776661e87.31.1776775208122; Tue, 21 Apr 2026
 05:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-2-kerneljasonxing@gmail.com> <20260421094022.8D0EAC2BCB0@smtp.kernel.org>
In-Reply-To: <20260421094022.8D0EAC2BCB0@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 20:39:29 +0800
X-Gm-Features: AQROBzC6v5br0D-CBK31naqRqEMmYy5gMertLuz_4WyOh5lkdmYFWJjx8l3cw5M
Message-ID: <CAL+tcoDp2ZgO629J0fw1TBJ=fdf0KmWz3i6mWODdLnSbmLv_sA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch unconditionally rejects pool assignment for devices wi=
th IFF_TX_SKB_NO_LINEAR if tx_sw_csum is enabled, which incorrectly breaks =
native Zero-Copy (ZC) setups on those devices.
> --
>
> commit 5beba1aaed8c200424f98af3c07472ab4da8d451
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
>
> This commit rejects UMEM bindings for devices that advertise
> IFF_TX_SKB_NO_LINEAR when software checksumming (tx_sw_csum) is enabled.
> This prevents a warning and panic in skb_checksum_help() which relies on =
a
> linear skb head.
>
> Link: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.=
org/#t
>
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index cd7bc50872f6b..d981cfdd85357 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >       if (force_zc && force_copy)
> >               return -EINVAL;
> >
> > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> > +             return -EOPNOTSUPP;
> > +
>
> Does this unconditionally reject the pool assignment even for native
> Zero-Copy (ZC) setups?

It's weird. Nobody uses sw csum in zc mode.... If someone uses this
and gets warned, he will surely root cause the reason and finally
adjust the code in application.

>
> In native XDP_ZEROCOPY mode, AF_XDP descriptors are sent directly to the
> hardware. No sk_buff is allocated, so skb_checksum_help() is never called=
,
> making the tx_sw_csum flag irrelevant and safe to ignore.
>
> By placing this check before determining if native ZC is available, does
> this break ZC mode on drivers like virtio_net for applications that pass
> the XDP_UMEM_TX_SW_CSUM flag as a fallback?
>
> Should this check be deferred until we are certain we are using generic
> copy mode, such as when force_copy is true or after native ZC setup fails=
?

It's more complex. I'll keep my code as-is unless someone screams at
me to handle this trivial case.

Thanks,
Jason

>
> >       if (xsk_get_pool_from_qid(netdev, queue_id))
> >               return -EBUSY;
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.14=
844-1-kerneljasonxing@gmail.com?part=3D1
