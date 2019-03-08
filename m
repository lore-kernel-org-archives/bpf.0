Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65144C4360F
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326D520811
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw1qz2R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCHKAG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:00:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43384 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHKAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 05:00:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so13787826pfh.10;
        Fri, 08 Mar 2019 02:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvP14gOHcHa8062p/qKH3Dp0cYGLNiTOGkrHEH8tfl0=;
        b=kw1qz2R41uZ873qKzdSIRi+wkmZoSAtQr1w3mEKVomd+r8ibQsW/1HAJE+XTNFJ/nJ
         vqrZz2j5nvSrB4jo8MwkIPWJCA2QxzDkilsDLBR9owLapTpfCfyTh+fLzsj8CCPG9wb2
         Op0vyqU/lePDTDVEWRX2Klm5OqwHoFyBk859xh0nYuJzUBWIRG8+doEhN9+Cl8LAxnzo
         mx/tT+4rJurh5wF51Q2bjrQoSzosc8szAZNHDMxmSXuajK4v+ylWqNqpy5Vg/r8ssX3x
         iSIiRYvj60yxrFJNnh0FQdfKQQy3yZs0l+BpTqJPT4KaysyajhnUs2FCwnFEvtn9FPC7
         gHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvP14gOHcHa8062p/qKH3Dp0cYGLNiTOGkrHEH8tfl0=;
        b=K2qbknA7H0NLqVSAD/LM50wquuinnRnpg20HAHBKqy8TbfcC64Ld8Y9cMTf/fK1Bac
         RmvKX3QFxXZ4qgzB6UCncKF/NeaY9sMJ2KL713VNVsG/j6uQZkxnohMhf6Itm5rNGYmw
         YCb+BibSJSAEmECteS3w2xWWDQl2CKWKx2L/B1Zy+4SKVslMyKEleSHZPjeoLCYrB3uw
         sNBTWrW722+pC8ipz55ALU26tYCKO4shriwc8S50DbNaVsyEzr8+BzsosW5qeGWEZyI5
         Z00aCk+CVqZFpT0iPOF4AHJ7bbW+tjhQrotHQgZ2Kj41nD/JmNfVIDW6NXhchO5oT0DR
         G4cQ==
X-Gm-Message-State: APjAAAWPzumt6XkfDXaaTRQ6rwuekXV6VhhJyMfP8IbE3IoNj/mJ2eAz
        mf1uhoBxSQKp7+VXvtaMeXM20Fwvf6U=
X-Google-Smtp-Source: APXvYqxg7k3KILml/dsg7QDmHVmyO2YSJ3Y3CvlGhII5v6uwzd7wryhy8iAiFKhJN+m9EvBtg7vMfQ==
X-Received: by 2002:a65:6497:: with SMTP id e23mr15462333pgv.21.1552039205530;
        Fri, 08 Mar 2019 02:00:05 -0800 (PST)
Received: from localhost (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id m20sm24540054pfj.142.2019.03.08.02.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 02:00:05 -0800 (PST)
Date:   Fri, 8 Mar 2019 10:59:44 +0100
From:   Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] xsk: fix to reject invalid flags in xsk_bind
Message-ID: <20190308105907.00000518@gmail.com>
In-Reply-To: <20190308075727.19358-2-bjorn.topel@gmail.com>
References: <20190308075727.19358-1-bjorn.topel@gmail.com>
        <20190308075727.19358-2-bjorn.topel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  8 Mar 2019 08:57:26 +0100
Bj=F6rn T=F6pel <bjorn.topel@gmail.com> wrote:

> From: Bj=F6rn T=F6pel <bjorn.topel@intel.com>
>=20
> Passing a non-existing flag in the sxdp_flags member of struct
> sockaddr_xdp was, incorrectly, silently ignored. This patch addresses
> that behavior, and rejects any non-existing flags.
>=20
> We have examined existing user space code, and to our best knowledge,
> no one is relying on the current incorrect behavior. AF_XDP is still
> in its infancy, so from our perspective, the risk of breakage is very
> low, and addressing this problem now is important.
>=20
> Fixes: 965a99098443 ("xsk: add support for bind for Rx")
> Signed-off-by: Bj=F6rn T=F6pel <bjorn.topel@intel.com>
> ---
>  net/xdp/xsk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6697084e3fdf..a14e8864e4fa 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -407,6 +407,10 @@ static int xsk_bind(struct socket *sock, struct sock=
addr *addr, int addr_len)
>  	if (sxdp->sxdp_family !=3D AF_XDP)
>  		return -EINVAL;
> =20
> +	flags =3D sxdp->sxdp_flags;
> +	if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
> +		return -EINVAL;
> +

What about setting more than one flag at a time? Is it allowed/make any sen=
se?
After a quick look it seems that they exclude each other, e.g. you can't fo=
rce
a zero copy and copy mode at the same time. And for XDP_SHARED_UMEM two
remaining flags can't be set.

So maybe check here also that only one particular flag is set by doing:

if (hweight32(flags & (XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY)) > 1)
	return -EINVAL;

just like we do it for IFLA_XDP_FLAGS in net/core/rtnetlink.c?

>  	mutex_lock(&xs->mutex);
>  	if (xs->dev) {
>  		err =3D -EBUSY;
> @@ -425,7 +429,6 @@ static int xsk_bind(struct socket *sock, struct socka=
ddr *addr, int addr_len)
>  	}
> =20
>  	qid =3D sxdp->sxdp_queue_id;
> -	flags =3D sxdp->sxdp_flags;
> =20
>  	if (flags & XDP_SHARED_UMEM) {
>  		struct xdp_sock *umem_xs;

