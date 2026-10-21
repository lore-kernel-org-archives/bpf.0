Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587927;
	b=jGyPmhSp2d+zfSU/w6yfrG0PLD6KZCkqkUwMVZ64BQ5+eQnwUUQyOelrclwDDobvgQDM
	 z8/pHHnikNYvUxMEPuqBExcr2dJyKPJQg0J8qQpICoNOdcNTPBuUZpORm0APBfGjtPFiw
	 tdJyl3Gceq3OfqawDBQczDEidL7tBToVdimSWxSQ3UaGuXm9QgRkBywL0poP9q1nGJ6Gn
	 xS1AFbTN89UNRR++802g3NR71ynmYR/5rKzu/4vF+ENweHSpsjc6Tw10NST0GyylB0+An
	 t24xnVyTWeH9s2XA7AXbksyUKqduVciqTldNJGR2DiD7XGC/vzTTUpkmD1fjGgdzxZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587927;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=eL9jUC8Gq8PGksHH1scl+B7zay5oD19D22S1KebKPk0=;
	b=Se36D16QJGFwe2cEfmE/315UXAxO1Cz+09PgkHI09cyo2C/69g1LIjpNi9ETHFrSYblo
	 6xbTT7cauGp5iPqpVzXv98fjyGZqNd3bUvLo09k3kyMHYIdLq3uk5Ipv/7kd7tq+TJyO5
	 m6+Xt/shNMZo3BqmpijiDrILxt3Q8iUS9/ZrYxsz0scsERB74i/bYxZP7JWsmDtPXlllx
	 ScDdMRuWtcxCqFMkKlAAnTzTs74kGkga0i5NL/0AK2kpHSAkIzJqSeLfkG0zcItHP0Pz2
	 OVyXzxHM/LspvBp27M6/K9H3f7im09g+5B7yQN/wR6au9xF8sDEI8At9TBhvLxozIFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TSu2ENMF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WjLpN6tb;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80963606A31B;
	Wed, 21 Oct 2026 13:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80963606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TSu2ENMF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WjLpN6tb
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792587922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eL9jUC8Gq8PGksHH1scl+B7zay5oD19D22S1KebKPk0=;
	b=TSu2ENMFGbS5RaQ11d/BnnpxrVNm3N2X8UiWOovvI5xwEFtaFO1NJulQ3JcIhN9mITQEKX
	pLSWJsl4zhf8P/wYD+UDbn66e9o1NCf/AfUbFIKt1FS4L/HcKYnLiLmLWRhf5aJaPineNt
	FZQmpf2J4BTAlFN+9qC12bs4wbdX3hkiHs5SgBGdjosRo10LY0CNnJ/B2TdLMzN0xyen0u
	FkDkZ+RZuDc/UujlUKEhI5DJ4efU0OQLHbb5LSpmqW0iHrgTtVDFARXOwG5+9UZudNV150
	F4fJA90KT0X5yq2ouapvkoi7vOSkgE+g3G2fKk3xLx4sZXcdOF7v7NfxdWDqHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792587922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eL9jUC8Gq8PGksHH1scl+B7zay5oD19D22S1KebKPk0=;
	b=WjLpN6tbt+hrVfLVYI4HvJVtbKNKfyDhc3KgpFNd8bDoZSjTm985oQNPcbuPmpfC2IAdft
	QtPzddvlwNI4DRBg==
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
In-Reply-To: <20261020140849.12fc79ef@kernel.org>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
 <20261020140849.12fc79ef@kernel.org>
Date: Wed, 21 Oct 2026 15:05:20 +0200
Message-ID: <874iefjjan.fsf@jax.kurt.home>
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

On Tue Oct 20 2026, Jakub Kicinski wrote:
> On Tue, 13 Oct 2026 10:57:20 +0200 Kurt Kanzenbach wrote:
>> while looking at the TBS thingy [1], I've noticed kernel crashes. That
>> happens when opening or closing an AF_XDP/ZC socket while parallel Tx
>> traffic is going on.
>
> Let's respin this against net-next. The merge window has started,
> applying this to net would give us an immediate conflict and pain.

I'll send this against net-next when it opens again. Thank you.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrYuJATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgr0qD/9CVSJZZLdINIWpU9XMk/x+nYy9jkIG
e/b4eMmky2Qaigs+Acxvk85WEa/cbWu3GqARO1PCHTogSyoiAMDv8exsgPG9odmF
/vQFfQTSQEnsnIArC1aJfxyifMZacKd4fioQkfXFPiWV+ISTF/RxsxAO+FGaG16V
dYNbWkpfFHg1yWJsXz20mzuQOAQr5/bL5CNDpkgpYH9EHAiDYgRadGTNpVEbQ0Fb
2FBgzNjb1y6cqzqPrlqp36g7Y5ceFE8iGUfCl50aCerXTN4C8X3s2dJHyZte0FyL
PJJcNez98JednomiGBlqlRcK3xV3+mm/O/FGYuV5InI5XrvqPMilUOLjmjHrucAV
6puGa0wtaviD1WjI8puiej6vgavJrZd+AQcKRKyVkvWZNGNhu0oFvon9R/JbTVpL
DmG8GDNCYzP3LdTb5xJCn2b3zq+dvKhqbd9LGRDzWGuHJNGslqFHThoBmewY/e8V
5wY20sP3vx1LQEbjJnqP6ADiX6IJpDNPG+7Xsq8JNSVYUxba5Ryoe4mTR2c9/C4+
tvKWykA0iDmVYSS72swVrEg0NptyMZ1aOx93PpRRoR3G5Ut8GM+3Dtudv5zztR8H
QwRt+6DNPq4x5ce4tqPddOYhL+WTFvevPtArfpO1l5j6BzLyuPGC2Ku98IDuv4Z5
Pnn40jVF8OF2Cw==
=t0X4
-----END PGP SIGNATURE-----
--=-=-=--
