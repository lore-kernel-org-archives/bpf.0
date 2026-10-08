Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B449E5DE;
	Thu,  8 Oct 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463901; cv=none; b=WyDWHY3orQPLPYW7cl6XN7p/sSnWwsaXzLIUYfwS7D2wepIbxx+wKQXiwCyhtBnkW9WDpDXjcb28GBbVuXG/OzKYQhypul+r/h9mrAz7Iqc1n6bn7d8AcqKgtxEjAdN6GjjSZI2ZRCTPtad3uOSUr/OvHgb3vEzf+M3Hon9VMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463901; c=relaxed/simple;
	bh=aJ9YmxBBm4ORrS2YgmUXD0ShPzanXx/nReB3KypFgIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPu2aUzkSlhzY+XotkOqiRzIh9QWJgsjJ9XsQ+SqkLdpibm4TIa6rL4BMKDcVSYjTCz+ExdvxMHFiDuicNDx98+HUH0kHWV6ZuzJjlkI2u2iioGuowB6DIan3NxrNu98CuqwHqrf/vtjiPR4o6ViqHv55AqzsyuMyGl5n2rbpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqlV/79E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66s1G752; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqlV/79E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66s1G752"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791463896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZHTc2XGNHdP9T9wX+Y/zZCgi5wtLXlmsEo+S/aR7wI=;
	b=oqlV/79ErOldFxJBOdcaqgayLC1WO3eZpEN29TjkzEPG9yeDcs8gdtjc9MkzQWX1rpGAWk
	5vi1xpgk3Vu29SzvFR/YejSai7+xU+PeowDuSFokRn7V/m9fbPhEE8aD+5s7FuhungAkLX
	HbMeJzHdfeFwKXAwhxM9oFyIg9qr6KkOXcTYSQrNU0lGd9Oti6U/PMz4VlLFd7hZ73XuGI
	82EUKS5Vy66VsQFjY+IbiWKRR0dUJir3mAfeslMBlFvb8dnf93cctKMh7opMm7fNgSu+ME
	kQ9P8AjA8Gnw9mHgh0AlA1WbZXK+0MVp25/90RaD4W2RFUdz+FXaeyBjC8xmjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791463896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZHTc2XGNHdP9T9wX+Y/zZCgi5wtLXlmsEo+S/aR7wI=;
	b=66s1G752KnxZk6pqlIIlWCpoYLU30j4kYu9SQMwYjN5bZI5zizQmsN1mZI+ECsY0yN9TCZ
	GNos/tFHRSHOzTDQ==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
In-Reply-To: <asdcORsu7HNfAZBb@boxer>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
 <asdcORsu7HNfAZBb@boxer>
Date: Thu, 08 Oct 2026 14:51:35 +0200
Message-ID: <8733ugqrs8.fsf@jax.kurt.home>
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

Hi Maciej,

On Thu Oct 08 2026, Maciej Fijalkowski wrote:
> On Mon, Oct 05, 2026 at 09:09:33AM +0200, Kurt Kanzenbach wrote:
>> When enabling or disabling XSK pools in parallel to Tx traffic, kernel
>> crashes occur. For VLAN tagged frames that happens in stmmac_xmit() ->
>> dwmac4_set_vlan_tag() and for normal frames in stmmac_xmit() ->
>> dwmac4_set_addr(). Both of these functions access the Tx DMA descriptors.
>>=20
>> The XDP pool (en|dis)ablement frees and reallocates the Tx DMA resources:
>>=20
>>  stmmac_disable_tx_queue:
>>    __free_dma_tx_desc_resources
>>=20
>>  stmmac_enable_tx_queue:
>>    __alloc_dma_tx_desc_resources
>>    __init_dma_tx_desc_rings
>>=20
>> NAPI is disabled during that allocation window, but the Tx queue is not
>> stopped. Therefore, add the stopping of the Tx queue during the enabling
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
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_xdp.c
>> index d7e4db7224b0..883bd3fe8089 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
>> @@ -6,6 +6,16 @@
>>  #include "stmmac.h"
>>  #include "stmmac_xdp.h"
>>=20=20
>> +static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16 queu=
e)
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
>> @@ -36,6 +46,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *=
priv,
>>  	if (need_update) {
>>  		napi_disable(&ch->rx_napi);
>>  		napi_disable(&ch->tx_napi);
>> +		stmmac_xdp_stop_tx_queue(priv, queue);
>
> FWIW you can look at what I did at ice driver (ice_qp_dis()) where I used
> a bigger hammer here; I think updating trans_start is kinda a workaround.
>
> https://lore.kernel.org/netdev/20240708221416.625850-1-anthony.l.nguyen@i=
ntel.com/
>

Actually, trans_start is already updated by netif_tx_stop_queue(). I'd
just remove txq_trans_cond_update() for next version.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrHkdcTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmJBD/oCmsRqLOaLWkOVSVG1QP9cmCBH00WQ
LRmmxbFk4UDutQJxHN4bezt5EZ6eJqvCf5WM/uI9WkyMlA65QMEm96UbHmGYhY/O
2fdXL7X5W2wpY31IcZ15svH39ow99M+z+Qa7bOaZVMrZxaWWvyHEhv+qUESR4ot/
lYvobo99/AorlX8Urfb/e+x3r1NCOXZJz5IIXq+9L4sAby16gJdQtvfvDdmfdN8Y
Fr8DxMII4MoRHHcPjvMYxbYaAaGSDaK/H61e6DODTrRMCHE4322KkjMSqx/KxCBH
zvXeMsqkWlnSTM0srBGuszFy/9kfOKWyk68q44fhuefGOaBv2xB8ZBGt8Xoz4aqq
Mip7UslQqXVVjZCJfbUnH+zwcaJBIJA3QOQT0HebM5unR7YZDCPPc/oCL6q66G0Q
Z61H3lzDorpXGBUUindVQvB4XLWkO6xOagPLN0Nu3fuHDIqirxrPYpSko3K3xKg/
AsLDTMAGIKG29OoSOjlikRm+6gbkXtiH4E82IJWem/IWiQsrtXj27FHPkoWivHKJ
oLhS9/3kWsoqO0VExHQLlh6/HTIH8358JForUyGvFLJzJxGGQVpjzmlKRfXplF9W
th4/Y3yHhPZ16SPgDUFl6oKAQPXlUjbamJqkdbvHCUJ4zKtj2j3x6fDeYh3xN/Bk
8c5IpCJvzgpfJQ==
=3nkW
-----END PGP SIGNATURE-----
--=-=-=--
