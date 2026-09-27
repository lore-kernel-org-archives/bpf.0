Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EE23BAD92
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790552968; cv=pass; b=ZDCBjZhtKCruhARLTduivhYip9Jl6TQuOnJfMNdpZ+xx0ON0ExkNNam942jbvyf/tSPLPkpcORunh5JTSos6FW7T5UHiPSxGYpTkdGzgm0dLekzfxH3cwmc/zwDHjG9oB/Us2HTZrwTtqioVpiPFj/xKOJK6XyH4T8Zp2nwG3Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790552968; c=relaxed/simple;
	bh=aj5nUGzscZlYh9Hwnq0OGDa+XHJvROniWRXccwlok3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9Ba2s4cWkPnFODT7NU4RpfmE7szisyWKCMxWXN0YbXwxX3SIENtnlms6DSp8wQjJQ6Z4zUWRNVBasfKKJMtY4iCh+/kdySnsSsbFeK6kcbYlHWW9l8WMDvGIyKl3wZ44emVaKTB4MrAqvBgwryoOSZSaxzReTY6P7QEbYOd0jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzA9Nri7; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzA9Nri7"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c83fbd23a5so3158923e0c.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 16:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790552965; cv=none;
        d=google.com; s=arc-20260327;
        b=jZROU4PnqVbvO8CspPpbNopGN2xrZiYMXThWv7T2Cqe88AF30u9/lDu2n3Dct6lf51
         /8riHpI9bP50S9fjZmbXIMuoVetkTaqEIUJq1JQMOivdq2T0znM34rpBQ7Imgq3R7vEH
         2+w8M1yIKz3oH/8FeX/x0f4zT3+1irbE53Y2TO/M+4b2mXPMnXccLnECMSpCCPOAp2cI
         aCJ7/QNtysRYpAih+Dh5bNRgS3uhwosooqCb0gNbQm8DVbccv859K6ljmdyyFGF9WH9U
         yFwqHhea19UVJRz88/eXzS8v8DsuywGJg7oOly+d82ughlr+fHTDdq1p29qmnhy+STjt
         gM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aj5nUGzscZlYh9Hwnq0OGDa+XHJvROniWRXccwlok3k=;
        fh=nasXWaU4HGNnbLIiFLI+Bz2dDf+u9kIfDIxNvn2KYAM=;
        b=lvTTOzi9oAfSE56uOUWaVa+2CjJZbtLvwS/Tv9qKxLocxegLe6WYOQ6JVe1qGcDx7Q
         TDJ2zzO3gDCSSqLYowGdjK0h7kC/IYFlmLyLCliDFP25B8ITprro75aEQUfINu7QRAOl
         VrD1q4FhbD9iJVCAtslbFbRbkEGFhzatfR6NZZP3hb/OkNGOC3wzwfhOYErQFymYZD1e
         Pe1EkQRNwsIksQu4RlyBCmQ/3gQBa5GSywWV7VRjPF4eHnSsNQDgXfzAfqPPtONTUSrL
         JBu9SqTWag7ERYdxTue2gtMgNoORUg1+lT+fX9go5LPzG1CJH0KNAnn0PB3g8vZtv+RX
         F0ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790552965; x=1791157765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aj5nUGzscZlYh9Hwnq0OGDa+XHJvROniWRXccwlok3k=;
        b=FzA9Nri7T4U3IebPd848HcP6cigfKerJRhb7sIEg1ErKjSZH0l+K+urJn3jmHecBom
         IVWYc4Oj8iXJpHYPVCdheYnpGSSquFASMnrHIJRkLnlKVI/QYY95QgrpOP2EmMgHb50L
         TzIpfayItHXkuKymhDFfR+lPSTOVzNj+kyYsrkib4TAohTyKVsTtiqSOhkfGuWkXOz1H
         RbTYzok96Z2U5FI6K1ffqxl19gHUJD3jLV5Tn5MmADV5cv0gA23qJSzQQ8J36oo1tm1P
         baGYda1HJzLfB90K4O0fzC3RhCbk3hMoFS0rs89K02Zn1DavNTDqpBDos9dhRRnksjD5
         sLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790552965; x=1791157765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aj5nUGzscZlYh9Hwnq0OGDa+XHJvROniWRXccwlok3k=;
        b=VDFK5XT8Ht5m9yuHLTOgRZOM4wXb4VFbg6JXRc31mYpgcI2B64+UmUJEMHWsp9yOLf
         ZFArnoxRBi1L/hQAuHbmxOUsdTXBOWObFGbMdtwu37yHyE0sM7w6GAjYQRnGu/tIEM1E
         Yfz0XMCnJXqHbyD62Cpk/fBn0ofyG7T5LJ8E0rOsPzSGDEvICuSToZAJJr16lSCHBNdj
         t7gXHy52yXEjREXZIMOmRdjmBAWCNUS8QM6+K52y5AZHqlBxHThg+Trlcm2ujTOFtHok
         5XW9p/s07adYE3tGnDCFCyJgQwvovMuDSvLL19exoygJSsZv5aER1FfcQ+Lsat7XZGnA
         fmOA==
X-Forwarded-Encrypted: i=1; AKwUvBwVvf2vE/6XTLwDFpstLbYXdlF7IJYSHI9MAJfgvuI4bLFBGC6yBYFX/PynKVNvt0lOjMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYICzk3eIk2JWqlH2ci0lImkkNinCRi0cajsIham8H35sZx+D2N/
	SixryL34uO6/2PeMCPEGBMsfVK1Ms6YMsHbm1QKfMrNPiUQaQn+eOZ9jm17w97ul+kCk7yi3Fqf
	K6pA4EOo97pYOLJ775xPflO/yDcuiqYo=
X-Gm-Gg: AYBFou26Gln5tOanS0rX7xooeBp3vAdeHFWd4svZdDstUv2nZc7h2xcGm5IOopz9+3u
	w2eJktd2CWldAOlfG3NLeRq8ib/FMaD3zGaNbpqWe+NBi1r6JauuPpmzgX9Y772WMSBD1GB1qu2
	31MyzCTsXjDegfz+S9J/7niVWeERvWLpeN4hc9l76K1uAfGD7PRoN0u1OmYUpeDk9Od3nuV9aVp
	9uYBwZtg3Ou5CFLq5VQPGgnPhOm+MFucMOAypDI7HcK8Dvn+1n4EUee3iPcpMf/G0B83NxrHBqX
	Q4b1H6q7drLghz2W6EEatcSpwdM98fQLmFkU9dOBwitPGuuJRaI/nHqSWBxizwSwSiBKaiKFork
	+gdko6XCL4QcjTMWlvEqtzchWUDJ3TZX76mX7SClwdury66uXX4s81CWkH2RCEGNOJPEmWeE4gW
	4S/yn/TrdmNimz4bje8mELTFm2YAiHK+bQxNZgySw+5Ipr
X-Received: by 2002:a67:f24b:0:b0:784:a925:3f0c with SMTP id
 ada2fe7eead31-7af19524bedmr2659589137.0.1790552965528; Sun, 27 Sep 2026
 16:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-2-feec6c14dd06@gmail.com> <CAD++jL=6Ov5BPK1naX6orzMsrJPm_g6SkdRaU6Ji+okXMFaZdQ@mail.gmail.com>
In-Reply-To: <CAD++jL=6Ov5BPK1naX6orzMsrJPm_g6SkdRaU6Ji+okXMFaZdQ@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 17:49:14 -0600
X-Gm-Features: AclHuK-WcfEa6FiZhcRlahLtNjX_NT7F91zfb25DNSpArVL9Tas2WI3NpVSANt4
Message-ID: <CADvTj4pU6EXgx1-dupQoQBm8OrrvAeR5NyCk4of7zya2V=yvEw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/19] net: stmmac: request the MDIO reset
 GPIO only once
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Serge Semin <fancer.lancer@gmail.com>, Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
	Richard Cochran <richardcochran@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Ong Boon Leong <boon.leong.ong@intel.com>, 
	Voon Weifeng <weifeng.voon@intel.com>, "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, Yao Zi <me@ziyao.cc>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	"Alastair D'Silva" <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	ZhaoJinming <zhaojinming@uniontech.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Ding Hui <dinghui1111@163.com>, 
	Linkui Xiao <xiaolinkui@kylinos.cn>, Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 5:35=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi James,
>
> On Sun, Sep 27, 2026 at 11:59=E2=80=AFPM James Hilliard
> <james.hilliard1@gmail.com> wrote:
>
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> >
> > stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
> > A GPIO line can only be requested once, so from the second call on
> > gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
> > turns -ENOENT into NULL, hence the error is passed straight back and
> > stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
> > running the STE101P MDC workaround.
> >
> > The first call, made by of_mdiobus_register(), succeeds, so the failure
> > is only visible later on: every resume that does not use WoL goes
> > through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
> > the return value, so the PHY silently stays un-reset.
> >
> > The descriptor used to be requested exactly once: stmmac_mdio_reset()
> > resolved "snps,reset-gpio" itself and cached the GPIO number in
> > stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
> > PHY reset during resume") relies on that cache to reuse the line on
> > every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
> > stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
> > caches nothing, so the request is repeated on every call and fails from
> > the second one on.
> >
> > Parse the whole reset description, the GPIO and "snps,reset-delays-us",
> > in stmmac_mdio_register() at probe time, and keep it in struct
> > stmmac_priv. This is where devm-gpiod is meant to be used: the line is
> > acquired with the device and released with it, and any failure to
> > acquire it is reported during probe instead of being ignored by
> > stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line,
> > with the delays that were read once and for all at probe time.
> >
> > Cache the request and delays for DT devices regardless of
> > mdio_bus_data->needs_reset. That flag controls the registration-time
> > bus reset callback, but system resume calls stmmac_mdio_reset()
> > directly. The reset routine no longer looks at the device tree: where
> > the description is absent the cached descriptor is NULL and the delays
> > are zero, so the pulse remains a no-op.
> >
> > Keep acquisition conditional on CONFIG_STMMAC_PLATFORM, matching the
> > reset callback, so non-platform configurations do not request an unused
> > GPIO. Also skip acquisition for a disabled MDIO child: registering that
> > bus returns -ENODEV without calling its reset callback, and the driver
> > must retain the existing disabled-bus success path even if the unused
> > GPIO is unavailable. Remove the unnecessary gpio_desc forward declarati=
on.
> >
> > Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_=
reset")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> > Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> Dostoyevsky commit message, I didn't read it. Ask the agent
> to be terse.

That commit message style mostly just came from the imported patch,
I'll change it to be more terse in the next revision:
https://lore.kernel.org/all/20260921015727.2643540-1-xiaolinkui@126.com/

> I looked at the code and from a GPIO PoV it does the right
> thing: use 1 as asserted and 0 as de-asserted RESET line.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Yours,
> Linus Walleij
