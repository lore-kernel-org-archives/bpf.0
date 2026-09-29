Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1E568FD3
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710517; cv=none; b=Mx7L2ps+SJBZ8ZWGrs6PjYaJDoUKzjCFkfmDYDAWNoG8eDudxpP/yiJMZOp6dYbbPHQVDiCgTHGvYLGrLkDhpw2lTSb9KqUp3ANch0ioy6iluvwxoQG0gy4Meb+2T+7CymTaOrcEfOmg5hHkZnjt6RdBMb6bI8TWegSfAwgXC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710517; c=relaxed/simple;
	bh=7fko1rE2yAPGOLIFQEpcyNj8KZdCgfK9yVxmV41IFLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SlEmzCqwlEqnAnooCdVjRVrkOkdIDIyeG8mhHnU9wcpE1gEHXSA6WdVnbOFIdlzodu/kTk0fmEqhZk99zaWixzzOhRmWtlLngxTTuIvqp4CTSgAv7U8EMbVOU+YIL7/AqrOG+OSr5At7DVG19pkB6z3wj0VN/18N5PhLJZcW0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR7u3F1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR7u3F1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30FA1F00898;
	Tue, 29 Sep 2026 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710515;
	bh=Kh+ipMfbAf7yBHSYUFuHiiKyuzpU5L0fW1TndwPvCNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kR7u3F1fadDXDvequajOr4s00aUa9nS7AIGo2z7Igdxc3/Xr9p9N7RUC+yV6zZQxO
	 WeBCAIsV3tS0IaETDteRM10y2eJGMYa7VCk9BDWXZWBSKQijIQDrxNt1bBPNG50udz
	 c8JamC8BlecmjnqJ55EkebfAqfmlhzHzuVp1gBqkI/UFS+UkGZpDGvcOp+F+Ow+SHo
	 i2Xvq/5LU+qGx1XIvmZRloPLAnRKPm4mKQCiOjEGHx2zFgcMa7rysY2+3CCrYOOrsA
	 nDcrInn4a61XRTw1FWgzgCbYoDGMnx+eSkJ7fi3FK8N4YXqe7g5qHigi/pDmNJ8qmL
	 NbxREjUQ8oo6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 13/15] net: lan966x: add PCIe FDMA XDP
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-lan966x-pci-fdma-v9-13-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
 <20260928-lan966x-pci-fdma-v9-13-a17caf60f89a@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:35:15 +0000
Message-Id: <20260929193515.B30FA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: lan966x: missing RX stats update for packets consumed by XDP
--

commit c200183575cbdbcd07153d60fe18b2c59693c034
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA XDP support

Add XDP support for the PCIe FDMA path. The implementation operates on
contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike the
platform path which uses page_pool.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 758554c951c52..949994874ed96 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -349,8 +466,17 @@ static int lan966x_fdma_pci_napi_poll(struct napi_st=
ruct *napi, int weight)
>  			 */
>  			fdma_dcb_advance(fdma);
>  			continue;
> +		case FDMA_TX:
> +			fdma_dcb_advance(fdma);
> +			continue;
> +		case FDMA_DROP:
> +			fdma_dcb_advance(fdma);
> +			continue;

[Severity: Medium]
Will this result in missing RX statistics for packets handled by XDP?

Because the loop continues immediately on FDMA_TX and FDMA_DROP verdicts, it
skips lan966x_fdma_pci_rx_get_frame() entirely. Since
lan966x_fdma_pci_rx_get_frame() is the only place where rx_packets and
rx_bytes are updated, does this mean packets dropped or transmitted by XDP
are not counted as received on the interface?

For example, lan966x_fdma_pci_rx_get_frame() updates these stats:

        skb->dev->stats.rx_bytes +=3D skb->len;
        skb->dev->stats.rx_packets++;

Could these statistics be updated when the packets are processed in
lan966x_fdma_pci_napi_poll(), even if they are consumed by XDP?

>  		}
> -		skb =3D lan966x_fdma_pci_rx_get_frame(rx, src_port);
> +		skb =3D lan966x_fdma_pci_rx_get_frame(rx,
> +						    src_port,
> +						    data,
> +						    data_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-lan966x-pc=
i-fdma-v9-0-a17caf60f89a@microchip.com?part=3D13
