Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBA4A1DF3;
	Wed, 16 Sep 2026 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597695; cv=none; b=JaLeL4o28JyAGAaxJl86UBCKKMjygLBHjeJc6/2ByfTUGuk1OcxOZC0JqYyqohvg/j+ukxOoxJ9hu66Pn5v8XLm1/2J3hZdfcDayvGxxFcAnh++HqnbWSm2mAOhqlpVKh8GgZtF7i2NlRtl99BXLZBtW5aadBMWjADj3HQHQB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597695; c=relaxed/simple;
	bh=HHKQ6CBtvJDmqbgQ6t8Hb0cGsRqcpDUTFidk8ov9ZA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jtCz+o6vUL3k/UZK3qayRk38OPNNrEARaDVzafGtKd6bZTyu4kU3ryuhAp30bI6SUJaNk5l+ZecZskssy4gTk9imbJyQ8B7xAmRPNr3Cb5pUkn2+0zX8ouYqP6l0eSn9g1PsQmyfzqjsGy5lYdrIekH8gFYBeZRKzWe3lQGwYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1Vphd3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1Vphd3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6011F1F00893;
	Wed, 16 Sep 2026 22:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789597686;
	bh=SA6eiXyyw9ug5Q9Uaa3JLyoTAoBrERjeBPO1IJBNWnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1Vphd3WfGqLxx3Bnq/8z5X77duw5bb8+9VnhEv6wqoTs5f3ENENpqkjZn+YGvSVG
	 pAXXS4cWd8/y4GosX4mDuG+rn8NtI+2HTk3Qi/lu9mtislCG5MJtUA0dRoeJ0GzKzu
	 iWawR70xz217d9AO+D4ggFmPdEgt6ttYY+PJV+8TfTAvkxrvDI5JbcmGhSDqQtzNZ+
	 umk0r5h8q0S/WzrHNZd//KFPI/jtsSyFYH1XUElXM+dtSRI5Kj2LSYK5fp7T+X7fm/
	 /GnxZJSo00/zE7zCVisc/6dN+3x4sxpv5uK/E4+vpmwiQfbeYya9BbCf8N/7/e30GL
	 LlD4QfWzIJAvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net 2/7] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
Reply-To: sashiko-reviews@lists.linux.dev
To: vladimir.oltean@nxp.com
Cc: bpf@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260915222735.1016937-3-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:28:06 +0000
Message-Id: <20260916222806.6011F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: enetc: missing XDP_XMIT_FLUSH doorbell when k=3D0
--

commit d8271163a46118cc9a3212492775857b3ece7ba0
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()

This commit modifies enetc_xdp_xmit() to fix the condition that triggers
the TX doorbell. It removes the redundant xdp_tx_frm_cnt variable and
updates the check to verify if at least one frame was sent along with
flush requests.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/e=
thernet/freescale/enetc/enetc.c
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
[ ... ]
> @@ -1845,19 +1844,17 @@ int enetc_xdp_xmit(struct net_device *ndev, int n=
um_frames,
>  						    &xdp_redirect_arr[i]);
>  			break;
>  		}
> -
> -		xdp_tx_frm_cnt++;
>  	}
> =20
> -	if (unlikely((flags & XDP_XMIT_FLUSH) || k !=3D xdp_tx_frm_cnt))
> +	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))

[Severity: High]
Does the addition of the k && condition block the mandatory XDP_XMIT_FLUSH
doorbell if the current transmission call fails to enqueue any frames?

If the devmap subsystem enqueues a full batch of frames with flags=3D0
(no flush), enetc_xdp_xmit() successfully enqueues them but skips the
doorbell because k =3D=3D num_frames and flags=3D0.

Subsequently, devmap calls __dev_flush() which invokes enetc_xdp_xmit()
with flags=3DXDP_XMIT_FLUSH to ring the doorbell. If the hardware TX ring
is now full, this call fails to enqueue its pending frames, resulting in
k=3D0.

Since the modified condition evaluates to false when k=3D0, wouldn't this
skip the doorbell entirely and leave the previously enqueued XDP frames
permanently stuck in the hardware TX ring?

>  		enetc_update_tx_ring_tail(tx_ring);
> =20
> -	tx_ring->stats.xdp_tx +=3D xdp_tx_frm_cnt;
> -	tx_ring->stats.xdp_tx_drops +=3D num_frames - xdp_tx_frm_cnt;
> +	tx_ring->stats.xdp_tx +=3D k;
> +	tx_ring->stats.xdp_tx_drops +=3D num_frames - k;
> =20
>  	enetc_unlock_mdio();
> =20
> -	return xdp_tx_frm_cnt;
> +	return k;
>  }
>  EXPORT_SYMBOL_GPL(enetc_xdp_xmit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915222735.1016=
937-1-vladimir.oltean@nxp.com?part=3D2
