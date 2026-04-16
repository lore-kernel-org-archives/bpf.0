Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFA3E1CFA
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368800; cv=none; b=KQN740T7NQcT3w8qIs7PtEuZPIbKCtfijFgLyie5RVaXvd/GfXCsryBZHS42hKz8vXD9CeCjCJ1jFdtRraYRcvH61VXrO+sLJQoTAlcKvkHSUAFxsJkVLhI1HEMnUN7fR67VQcLFHZRfi3INBb89HCQyUy+t3MAJSSKBkhc7gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368800; c=relaxed/simple;
	bh=ON8BLeKRTrXIznLSbHLi1vTM1wRrIvzhVduKk0yuZoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TPM2mr6nW52jVOB3nCv0srf/x79XoR21G8jk/Dss6hHHQSuAc7qsDlQMLHhSxTzOfjaOggrEkibjjmOYcqlbEyt01kPDjectMZKJO/G9nBpWiHY/vcRl7UYidoj4NP5rYyKAzdoqnSDINTyrbAGHTv6hvbs3bkDo9QdqE0h+gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuzIDbzo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuzIDbzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A4C2BCAF;
	Thu, 16 Apr 2026 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776368798;
	bh=ON8BLeKRTrXIznLSbHLi1vTM1wRrIvzhVduKk0yuZoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LuzIDbzoIo54vnuOPDerxFks+Ac+mC0MtfYZL/HRClmyK24xGzYChnKw3idjQiyJa
	 ycb5Io1ciLEb8FPf0WegZy0lSb22nt5ZpEVEfLBRhmJI3glFp3Mtbg7PTIdbMglXQ8
	 E1YyKYssCf3cZCnF+oCNbwSmbqoMAc+nusQVi722DeyRRTVWJfIZAG1eEP5QGvJjs1
	 v3hL/AyWTA1vlT2RJhxq0XjqudQH6QSH/oh+WKHTqb35QeGtz2H4uommYFOzN1xyvW
	 /ASE2h45gSGC9OJku35ipv4xgSp0kjKtOj74e4JsXaJg668CwUM1u1u9B5tmWtOHt1
	 2MeZUPjIkHIuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 5/7] net: bcmgenet: add XDP_REDIRECT and
 ndo_xdp_xmit support
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416054743.1289191-6-nb@tipi-net.de>
References: <20260416054743.1289191-6-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:46:37 +0000
Message-Id: <20260416194637.DA7A4C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Headroom check in `bcmgenet_run_xdp` uses `xdp->data` instead of `=
xdp->data_meta`, causing valid packets with metadata to be dropped.
- [High] Redirected frames are never reclaimed if the interface lacks RX tr=
affic, leading to DoS via page pool starvation.
- [High] Tearing down the XDP TX ring causes a severe out-of-bounds access =
on the `dev->_tx` array during interface close.
- [High] `bcmgenet_xdp_xmit` accesses unclocked hardware registers during s=
ystem suspend, causing an asynchronous external abort/system lockup.
- [Medium] Inconsistent XDP features reporting for XDP redirect support.
--

commit 9f494eaf789828bf8ab38fcd7ac6a3e4b72f5798
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support

This commit adds XDP_REDIRECT support to the bcmgenet driver. It implements
ndo_xdp_xmit to allow receiving redirected frames and updates the RX path
to handle the XDP_REDIRECT action.

> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
[ ... ]
> @@ -2451,11 +2452,25 @@ static unsigned int bcmgenet_run_xdp(struct bcmge=
net_rx_ring *ring,
>  						true);
>  			return XDP_DROP;
>  		}
> -		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
> +
> +		tx_ring =3D &priv->xdp_tx_ring;

Looking at the code just before this in the XDP_TX path, the headroom is
checked using xdp->data - xdp->data_hard_start.

Since this includes any prepended metadata space, if xdp->data and
xdp->data_meta are shifted backwards by 64 bytes for the Transmit Status
Block, could xdp->data_meta underflow data_hard_start or leave insufficient
room for the xdp_frame?

Would it be more correct to check the headroom using xdp->data_meta instead
to avoid unexpectedly dropping valid packets with metadata?

> +		spin_lock(&tx_ring->lock);
> +		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring,
> +						      xdpf, false))) {
> +			spin_unlock(&tx_ring->lock);
>  			xdp_return_frame_rx_napi(xdpf);
>  			return XDP_DROP;
>  		}
[ ... ]
> @@ -3996,10 +4017,16 @@ static int bcmgenet_xdp_setup(struct net_device *=
dev,
>  		return -EOPNOTSUPP;
>  	}
> =20
> +	if (!prog)
> +		xdp_features_clear_redirect_target(dev);
> +

Since the XDP TX ring is always initialized when the interface is brought
up, the device can act as a redirect target even without an RX XDP program
loaded.

If a user attaches and then detaches an XDP program, will this clear call
spuriously stop advertising the device's ability to act as an XDP redirect
target?

>  	old_prog =3D xchg(&priv->xdp_prog, prog);
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
> =20
> +	if (prog)
> +		xdp_features_set_redirect_target(dev, false);
> +
>  	return 0;
>  }
[ ... ]
> @@ -4013,6 +4040,36 @@ static int bcmgenet_xdp(struct net_device *dev, st=
ruct netdev_bpf *xdp)
>  	}
>  }
> =20
> +static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
> +			     struct xdp_frame **frames, u32 flags)
> +{
> +	struct bcmgenet_priv *priv =3D netdev_priv(dev);
> +	struct bcmgenet_tx_ring *ring =3D &priv->xdp_tx_ring;

When bcmgenet_close() tears down the interface, it invokes
bcmgenet_tx_reclaim_all(dev) which unconditionally executes
netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index)).

Since the netdev only allocates GENET_MAX_MQ_CNT + 1 (5) TX queues, and the
XDP TX ring uses ring->index =3D DESC_INDEX (16), will this attempt to
access dev->_tx[16] out of bounds?

> +	int sent =3D 0;
> +	int i;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	if (unlikely(!netif_running(dev)))
> +		return -ENETDOWN;

During system suspend, bcmgenet_suspend() disables device clocks but leaves
__LINK_STATE_START active, so netif_running(dev) remains true.

If a redirect occurs while suspended, could this attempt to write to
unclocked MMIO registers and trigger a hard bus lockup on ARM architectures?

Is it possible to use netif_device_present() to ensure frames are dropped
safely when the hardware is detached?

> +
> +	spin_lock(&ring->lock);
> +
> +	for (i =3D 0; i < num_frames; i++) {
> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
> +			break;
> +		sent++;
> +	}

Ring 16 operates without hardware TX interrupts and relies exclusively on
the RX NAPI polling loop to reclaim its transmitted buffers.

If the interface acts as a redirect target but receives no physical
incoming traffic, its RX NAPI is never scheduled.

Could this cause the XDP TX ring to fill up, dropping all subsequent
redirected frames and indefinitely leaking or starving the source
interface's page pool buffers?

> +
> +	if (sent)
> +		bcmgenet_xdp_ring_doorbell(priv, ring);
> +
> +	spin_unlock(&ring->lock);
> +
> +	return sent;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416054743.1289=
191-1-nb@tipi-net.de?part=3D5
