Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652778;
	b=xmwl1b4B9/RKP8VanZ9Kq4QRqcn6cRFt/qBQkBNA8w55cqV878UvrzvVX2ww8s68BGGT
	 TcsyuyBu6Og+dgqF4kDgfyfdgX1b7V8/9CO5rqay8r6JLvrGJvAbJJlFaFDNPWrW4BBea
	 rI89m8fS8aYv9OjiXvbAUzeW4MgELOKBRhYH5IpMmehunx0F3dpUhH0pE8WFlNC2TRppI
	 nfOQd1ASqSllPpFPW4zQgDgV2QGXv4BIDl2fGiCtqa9L7lHSgixinPbUyXW0c0EZxJ874
	 Q1wTm9LMCLx2sJYrmQ3v1enkvgwMxt3jq5zzZg/JiUSk1ISjnvssdN6SNZ51LcLKb4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652778;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=pUoz53K599fZhg1OLTYQwz8gx2AgSV9orfVTwiVXc3k=;
	b=ePfxdq0jxTBKciT6tTQJhQQqcJOiUlg+/syqIeBYhpzf7KkMi683FNQIr8WD5d47RcV+
	 XT8IvjNCjgxkJUha9vbigMMWqZ6m4Jwy2NvLPadkn9LuIsjS4wvtfwWcMMOPIzrzFEcaD
	 ldDDr971+yi+dG2hl0g9idH17Ao6Rejg0I90ZSUSWaOf+j8VK2mXx1HHzHPy/iIrIy0ps
	 P2sXQSSNNumTQjVrMpTnlXMi1MqGwXqWDGHn/XgGA+w2PrVOS1/txe5R7lDe2d1xrD6eN
	 3xIRVEpkG+9mWpx5ZTbjDzBjkV5dk/7Q+yZrUfVNGwG1FmBWDuI7ndKm5TlpEQNubaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Efe3Tff6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=YMGU50rg;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1C606A31A;
	Thu, 22 Oct 2026 07:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E1C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Efe3Tff6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=YMGU50rg
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792652776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUoz53K599fZhg1OLTYQwz8gx2AgSV9orfVTwiVXc3k=;
	b=Efe3Tff6ZTEtxF9tszPXm6bbUZ1Lv3XAyKsB4DB9FJk9YGaReK7modBV0WF600PniLUD2X
	lzu82V68WXDSW2XQ6ejJdg2MATbWENz+l81g7jjqTDq5vgfDkop+cr2ns4CpfBrkB7hhnT
	uJCO21+J2ADMMh4YHc3/DlW06RPqrmlGo2pV77KIkeR2aBCdAnXZ9kbtKHmaaljLE6lQ8j
	VddytrVKHagcjzn7Rp8YzAsw78TnYEqJ+o3o70OAmOZpiqbBxlSpOA4h8OOIrGgv1MXJLn
	Xxe4+ECGXupl07drIsjtU1NYE8lCwR5So0VrWuvx1KPUFb+2c50yfSPBRLffQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792652776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUoz53K599fZhg1OLTYQwz8gx2AgSV9orfVTwiVXc3k=;
	b=YMGU50rgv8rAoPhVWhm2yHhmxu47Lc7hl3Gjl8o04pqCgp65LMQoOdWjqHiFfwIhQbJAPO
	d+8k/n5Gz5jFH4DA==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Song Yoong Siang <yoong.siang.song@intel.com>, Mohd
 Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] net: stmmac: Fix XSK crashes on stm32mp2
In-Reply-To: <20261021073306.61972417@kernel.org>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
 <20261020140849.12fc79ef@kernel.org> <874iefjjan.fsf@jax.kurt.home>
 <20261021073306.61972417@kernel.org>
Date: Thu, 22 Oct 2026 09:06:15 +0200
Message-ID: <87fqxymcyg.fsf@jax.kurt.home>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Oct 21 2026, Jakub Kicinski wrote:
> On Wed, 21 Oct 2026 15:05:20 +0200 Kurt Kanzenbach wrote:
>> On Tue Oct 20 2026, Jakub Kicinski wrote:
>> > On Tue, 13 Oct 2026 10:57:20 +0200 Kurt Kanzenbach wrote:=20=20
>> >> while looking at the TBS thingy [1], I've noticed kernel crashes. That
>> >> happens when opening or closing an AF_XDP/ZC socket while parallel Tx
>> >> traffic is going on.=20=20
>> >
>> > Let's respin this against net-next. The merge window has started,
>> > applying this to net would give us an immediate conflict and pain.=20=
=20
>>=20
>> I'll send this against net-next when it opens again. Thank you.
>
> I mean that you can repost it now, just rebase on net-next.
> By the time we apply it net-next will be net so to speak.

I see. Rebased to net-next and posted v4:

 https://lore.kernel.org/all/20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96@=
linutronix.de/

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrZtecTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgrWQD/9Jq7mtMI/GNzuGLA1ndFrh32qOiUHN
N1AsHtaEzUP74uGRgY0nSbO+93zYdhYFkZDMsN2QwU3EVP+TNm47EZ51UpDVFJA5
1OaxBUHcHi538uRGtuMGRjuclxMWFbZ0wJB96V9epyS2QbwiweGRN0qIJcLJ3kiZ
Lh27kMjai9NjlgLwbI8tdbfTrOOgCUK1McL4EDeYVkXw7R7ubgTZq0NpIlxGmppc
bak3br0g0QGMu6AxENEui5LkEb2XnI7UYVWgXdyMkzhYMmkN3106sUP/wfF0GAjd
e1zKcum/vaWgGnaYpf6XVgpVpPcFud7hkiWWAXihmBHrRwaSPCRvPn4HHVg2Yuda
R9lBMW587UybrQI9pO2vH7jJqvj/FLVviT+XsYLr2JR/csfgLrOIxKeTlsCVQTSe
JTML+JiOC2z0mHGnjKJQ67sZ2dX8SoAiyz2k5n/DJegzbONuuSCNt6ZJswpIDglf
l1O7IO5PrmJ3nGyc4rvJev2a+Hi4i6+yj76jeRaFOpESyle258/I7BdpzL4Qq5wp
ll2H2x32dUeoZw+tSY5XNoTUx3YntDAFTcNGuLl+S21rC9GE0k0X4EvN+Lsc3mzE
bx6SyGtX7Qrhzm8JLxcFX9GIZAQj2muF2jd5gs+otuv/FvrPhAU7+XAHToxtMiGQ
a4QEpY65nsgcxw==
=3vSL
-----END PGP SIGNATURE-----
--=-=-=--
