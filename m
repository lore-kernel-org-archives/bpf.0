Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687023CAE95;
	Tue,  6 Oct 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275062; cv=none; b=gWXh76PH9ZTnd2ZGIhMKW1AP94CXWF8FNqnUiUvdG0uAd1Thc5CT405T+Lt3pKW0yKCyxRA7R7l/Ah4IgqM40drbYEoPqn6kUsAVpbMhCIe7aWgMMtoaqRTyu5GROTsUMpV8vKt6d2KA/K4ySf719h7F1wIfvXK2JTLYiYV1ybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275062; c=relaxed/simple;
	bh=CH4D7PR/Xp8IznzdajCb8YV6AqWaVYRmKa6unDJutn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rO3ZmgMUoGIY6uz/56pKrslKjHIQYeQlm7Mq9ytehH8gUzlAQWpPUl48481NfVEiE8V+GZSx7CaeAu8de/EdOHFx1LV97TGMKch0tikmoFniq8mC83qzyycsWpMm+33P9TWSyizuKDc3ncuiGk8NkdBiKwvP51CtfKFQ/Nfh7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ef4jOMuh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3DPDroz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ef4jOMuh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3DPDroz"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791275058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr0ojwKxzexz1gExyMgKbrvTBCOsN+vgkQEaK1X+gfo=;
	b=Ef4jOMuhmhoSFMKFG0YA+V7FibBdFdmjvO8xmHqtHDyuPnhG4nQ073ISZIF6WprthnNgEr
	TaiKfTB18JScFG5iU9YW7N01zXVx0TLoLiOdJXZEp1ARTsCEmNOR6kHjMMAcgbxWb+1Q2t
	lrecWJjebICUu/2e0favuozPuny81n/ScFIxOEkasul+3tZUpiljj9VLGpYoEHZfq8ZnXK
	4AbsTWO0/uzf+LLKspG+zxRuKl106KR0woRnpuqr7a5527y8T9APXE1Dq3ZWZ64f+SfwTJ
	Q/ZKOjFCpJZUqGCaedEJd0aTDoxy4jAXYdDoPbded4U1OupSplByd3G7gIq4MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791275058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr0ojwKxzexz1gExyMgKbrvTBCOsN+vgkQEaK1X+gfo=;
	b=b3DPDroz9fgG0Wn+7bA4SyufMD4jrNVOnLCp0/8vX8KYsMRpd1f8g6oSJFQ8XZ+bJ9fY2l
	T5hw9Yl6bLxfHIDQ==
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Song Yoong Siang <yoong.siang.song@intel.com>,
 Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>, Mohd Faizal
 Abdul Rahim <faizal.abdul.rahim@intel.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
In-Reply-To: <6bb85939-ff35-46e1-88cc-1bed0034e787@bootlin.com>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
 <6bb85939-ff35-46e1-88cc-1bed0034e787@bootlin.com>
Date: Tue, 06 Oct 2026 10:24:17 +0200
Message-ID: <87tsmzjky6.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Mon Oct 05 2026, Maxime Chevallier wrote:
> On 10/5/26 09:09, Kurt Kanzenbach wrote:
>> Attaching an XDP program while Tx traffic is running results in kernel
>> crashes in stmmac_xmit() -> dwmac4_set_addr().
>>=20
>> Loading an XDP program tears down and reallocates all DMA resources via
>> stmmac_xdp_release() and stmmac_xdp_open(). stmmac_xdp_release() stops
>> the Tx queues before disabling NAPI:
>>=20
>>  stmmac_xdp_release:
>>    netif_tx_disable
>>    stmmac_disable_all_queues
>>    ...
>>    free_dma_desc_resources
>>=20
>> A Tx NAPI poll may still be in flight at that point. stmmac_tx_clean()
>> takes the Tx queue lock, reaps completed descriptors and wakes the queue
>> again when it observes it stopped with enough descriptors available.
>> Nothing stops the queue afterwards, so the Tx path resumes while
>> free_dma_desc_resources() releases the descriptor rings underneath it.
>>=20
>> On non-coherent platforms dma_free_coherent() tears down the vmalloc
>> mapping of the descriptors, so the subsequent stmmac_xmit() faults on an
>> unmapped address instead of corrupting memory silently.
>>=20
>> Disable NAPI first and stop the Tx queues afterwards, which is the order
>> already used by __stmmac_release().
>>=20
>> The issue can be easily reproduced by:
>>=20
>>  1. Run iperf
>>  2. Run application which opens an AF_XDP/ZC socket
>>=20
>> Assisted-by: Claude:claude-opus-5
>> Fixes: 77711683a504 ("net: stmmac: ensure tx function is not running in =
stmmac_xdp_release()")
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> This now matches the non-xdp case, great :)

Thanks for the review! Yes, it does match now. We could also collapse
the common teardown code between __stmmac_release() and
stmmac_xdp_release() into a helper function now and reduce code
duplication.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrEsDETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgrM5EACSIYb78xr0ciukoJSgoO8fP1If2Enw
ngrIFKLHJPoEehs4zxQzcdBscw9KwtDbn1J4E2fgh2oBRA0H2Nv3Q4LFMhBcU/5M
mVgXmqnj1gLoag8cs685ZTB4J2w6pfLvth5iKx5dDXg3XL9B32sQBlDhuarXElBE
GCxxAowpQ+f31D1lFINRgIXkxvPujvjFDHDDbYvKCC2w9Zz8UAV5nYElkdQkT9Ii
NP9clvFTr1ydjR6qPF8PAd2zsvPp9yq97GtQ0eM04JZINSVD/vF1kslb1XziRMZ/
5TPWFQi44ttkdFnJiiTltYkO6+KXEwHKU1+sbRdikXHHnN662pSvwyKBGuuF2pOt
gCktw9KNbGmEpa5qzpa5LICsWBPfBOar5D2zXdt5PKszUKsYs10f8S5E6SZhsDQ7
cQj++6A+gYhf9QT8jWWvlhQmTmOqXEvfT0c1uzM390avpjuS2wdKjj5gDjcZE2ow
UWzxLEgBm+VGbnNgxtGoL8Jj4h489CTIIdjEhHJmQVjMvWw5q0wSNnnHRsEjCPGd
cY4XTkVZqSD0dO7LV2ZUj79pBpMGI7a70ASHhpIekxwdMhfinAkZCnBUIt+/sMDH
ILxZapVvLT5dES437m0FEFQBMgYrptMo+fDbpHa7uYpywYrS2BoLif2sF6sGmJSr
YPglKi12wAOWgA==
=O+RA
-----END PGP SIGNATURE-----
--=-=-=--
