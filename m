Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B492449EA9;
	Thu,  8 Oct 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463638; cv=none; b=uhFKhorcqxKvmbR4uFnloMCG1VyPdUuMjjl6RK5+Xsoz0kE5nv6PYCF/nJhReYkTBTItcuc4Bjyeoecq53KpZ6bUAho+FW61sj5XYLka982jw6VtJ66VoskwavYTli9og+7+EzRcdUsgkkDgXN/2yriOYUwrtOjRbhIUTtSMU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463638; c=relaxed/simple;
	bh=oOi/VXoNOdALUepvwqYPwWx1TMwRUCGJ21bll6+qzQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dlo8XsRtEeedltYZIekE/hS5rC1NLTu7XyhKoaz0O9gQK0hGz1ZrM1DV4CyiWwgm6PUtG3K5vbbKDiZsKOGFQlfnaXvrjH9OkFuOrBE5V8GyFny7SXaaDt9CCqBLZugjVYfeejUSltvQWp7oixxQADQrsBym3z6n0/rZCjHMLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehWPA0Ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5ApUaRk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehWPA0Ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5ApUaRk"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791463635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOqoPweHeHU1lzpTjcc24eUYqvraMAoKGPRqZIsy8v8=;
	b=ehWPA0KonNAcuwT7BaWe+3b8O4Tw8YQgX2VztU2/E21SPkgtgdRtoY8cNnaeINNLYYLd8R
	akBpRugjKdAu3nD7ymzBPAh+Jm3i00yC812Rc6XAb8j55zElnIHbT1UYRDu6Pd/25Qmg5X
	yvMGfXrDpamcTHgTRGcTvsDtPfaTR0DCglWSfemDdqI1g4cnT31wOEngpeprQxkkBM59SI
	C5nsP6h9s+lSckBEejksFi1oxQ0DGOldHHInDiIW6mkA7y+kWwRq8eEc6kXxqjtlVyjE6X
	JsqXphRLvigBFiBUclHxuk7BiFLHf1yYQ1DbuI83rpDrCgUYv95wAecZ7UEpBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791463635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOqoPweHeHU1lzpTjcc24eUYqvraMAoKGPRqZIsy8v8=;
	b=Y5ApUaRkm0XMX/e6BXMBb1nMYxVNmT9Xk+7F4kEJIcZIKtt0gdIJdWuodcmDqfM0bDLRmJ
	yZYNkalCPVwDngBQ==
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Noor Azura Ahmad Tarmizi
 <noor.azura.ahmad.tarmizi@intel.com>, Mohd Faizal Abdul Rahim
 <faizal.abdul.rahim@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: Stop Tx queue when
 (en|dis)abling XSK pools
In-Reply-To: <377d56dbc9be2874af7369112d9e49b9@tipi-net.de>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
 <377d56dbc9be2874af7369112d9e49b9@tipi-net.de>
Date: Thu, 08 Oct 2026 14:47:13 +0200
Message-ID: <877bjsqrzi.fsf@jax.kurt.home>
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

Hi Nicolai,

On Thu Oct 08 2026, Nicolai Buchwitz wrote:
> On 5.10.2026 09:09, Kurt Kanzenbach wrote:
>> When enabling or disabling XSK pools in parallel to Tx traffic, kernel
>> crashes occur. For VLAN tagged frames that happens in stmmac_xmit() ->
>> dwmac4_set_vlan_tag() and for normal frames in stmmac_xmit() ->
>> dwmac4_set_addr(). Both of these functions access the Tx DMA=20
>> descriptors.
>>=20
>> The XDP pool (en|dis)ablement frees and reallocates the Tx DMA=20
>> resources:
>>=20
>>  stmmac_disable_tx_queue:
>>    __free_dma_tx_desc_resources
>>=20
>>  stmmac_enable_tx_queue:
>>    __alloc_dma_tx_desc_resources
>>    __init_dma_tx_desc_rings
>>=20
>> NAPI is disabled during that allocation window, but the Tx queue is not
>> stopped. Therefore, add the stopping of the Tx queue during the=20
>> enabling
>> and disabling of XSK pools. Update trans_start when stopping the queue
>> to avoid spurious watchdog timeouts.
>>=20
>> The issue can be easily reproduced by:
>>=20
>>  1. Run iperf
>>  2. Run application which opens an AF_XDP/ZC socket
>>=20
>> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c=20
>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
>> index d7e4db7224b0..883bd3fe8089 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
>> @@ -6,6 +6,16 @@
>>  #include "stmmac.h"
>>  #include "stmmac_xdp.h"
>>=20
>> +static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16=20
>> queue)
>> +{
>> +	struct netdev_queue *nq =3D netdev_get_tx_queue(priv->dev, queue);
>> +
>> +	__netif_tx_lock_bh(nq);
>> +	txq_trans_cond_update(nq);
>> +	netif_tx_stop_queue(nq);
>> +	__netif_tx_unlock_bh(nq);
>> +}
>> +
>>  static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>>  				  struct xsk_buff_pool *pool, u16 queue)
>>  {
>> @@ -36,6 +46,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv=20
>> *priv,
>>  	if (need_update) {
>>  		napi_disable(&ch->rx_napi);
>>  		napi_disable(&ch->tx_napi);
>> +		stmmac_xdp_stop_tx_queue(priv, queue);
>
> Unfortunately XDP_TX and ndo_xdp_xmit() ignore the stopped queue and=20
> still
> hit the freed ring. I can reproduce this on STM32MP215 with a veth=20
> redirect
> into the port while toggling the pool:
>
>    pc : dwmac4_set_addr+0x8/0x18
>    lr : stmmac_xdp_xmit_xdpf+0x1d0/0x3f0
>     stmmac_xdp_xmit+0xe4/0x1a8
>     bq_xmit_all+0xa0/0x208
>     __dev_flush+0x60/0xc0
>     xdp_do_flush+0x134/0x198
>     veth_poll+0x258/0x340
>
> Both go through stmmac_xdp_xmit_xdpf() with the queue lock held, so this
> fixes it for me:
>
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>        dma_addr_t dma_addr;
>        bool set_ic;
>
> +     /* Ring may be torn down for an XSK pool switch */
> +     if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
> +             return STMMAC_XDP_CONSUMED;
> +
>        if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
>                return STMMAC_XDP_CONSUMED;
>
> This is older than your patch, but could you fold it in / add a oatch?

Thanks a lot for testing! I'll fold it in for next version.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrHkNETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgoDpEACZJagFhrsS0hj0gQ84dwHsvaFENP/j
VGQai03xKJ56zto1rCuy7MRYXYAVuvbDAbOHv0l2Yw6g9Edm+/f4F7HK2BiypVBl
TicFgwfl1WodVjT8LqHFjinP3+lDLfV7cAEyBXfMp25PdNUJ6HuTjvxoxvCV+yZB
9dmzUF5mdKhufO2LedIb4mlB6nrWbCrN/4Ozuvox7VhD7IGF2zzmABPnCazEwpjS
UMFMSOYioKvqOgW0pGlaUQVXhK2jo5KQVvOYLTl82usQwMtRYOO3h0wfqeLbQOwg
syNJ8MvoKQN0heQpoekGoVD4uxzjfR3uJpDAC8RaF7eTKQpEWbiPnLyrSDOLTiaD
ncsdGCe2ohs6mnN1doD88hdQzD+lYHrSUXuWnR/2bWxcfcNPZLAEksW0g9o60Wpz
Up+ZQVoezU5u245BqwUpHSqfIWanjrWjQTYI4/IiJWvrPww8yq01KlMu94BrmB8v
zlhcS3GKmDnK3fIUiXhTdBOLiY6zo0fGvDaVrcsc1Xl/ePvYGExqfOyISCTtEo9V
QDnpe6bvOe9qh5lwKhu6ACK2fmihxnqIJ8r064fv6zx5Z2aWb8NONCVB3HjPSzpx
j3hdwrHFsiA3ebLp35ycnRpWeUyzjDBRZh3iG4F5PXyreEAInJI0qjaXF+60YHJR
7DvaKXwxOgFPog==
=dl4i
-----END PGP SIGNATURE-----
--=-=-=--
