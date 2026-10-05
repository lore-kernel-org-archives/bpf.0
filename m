Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1E3955F1
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233001; cv=none; b=JdtzVBwTkLCITXZ53tZsDeOZagOAffigrcp8iFk9lazwa1qKno7Qc2vZNSFw1bURNrkxVZuUM04Uh2rXh6tnT1a3iRJBe2XgaCQUm+a7VG8xk1lud1zvYUwabYLE6xTnDsudas27dWt4z4L3YGf5dcrHq/dqy+CWj5a+YhE0T3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233001; c=relaxed/simple;
	bh=FKc8ed9nPc4gmTtz6KW6uP7AXjWWzKsdoSanm6Z+TI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dFbkOw3QaZ6vu1Q7OYGGg3GN3046sEECOsy2ywtvtvZZ2BMOc4W8xMVndGw/z8T7HqG8e02IHLw+tq53PMcfT9hKtyA2G+HLMeQ2aw0sLeqk7KxCbeFCsCZf8UzbabqZXpB6vhHxJS6BcVEu+MRc2mNnb6l5Jyojnf3Rm+knZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl7+RbGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl7+RbGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86361F00893;
	Mon,  5 Oct 2026 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791232999;
	bh=7/hQpODJNUK8VeBPwN5Ns+5YYdd3PdjcrvQVgls7OlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bl7+RbGrfbtDllw4xzSBEOgHaa1JT6g5BGbHBAu6KGxb/06czF1p8UGJZ6xX5bmAG
	 R6kExljYhqcjObJd8lnKWZu+WEnl2BcQNFB8DhbIFU0gSwHyaM/OSN2u3rwYeI2vnK
	 JPa/U8yRucwN1ox2WUD3qJGa7IPneUK2r3LXGNskXzKMM19bS0SWYFxUk4+uQcuYmX
	 ZkNVSCdGkxWmzl+Ufm0p+A4FvWruFsXo8zXLDOf3VzTX83eiD/FcTxFpu43A8fyKrS
	 DzMun1S5/RK0guyVpchrNUQeV87LslqfIjFv3R6qjpEjZlDSV8KiG486lNKqKIq23y
	 L1B8aP34eJrZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: rework stmmac_rx to
 support XDP rx multi-buff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-stmmac-rx-mb-v3-2-50fa171af9ec@oss.qualcomm.com>
References: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
 <20261004-stmmac-rx-mb-v3-2-50fa171af9ec@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:43:19 +0000
Message-Id: <20261005204319.B86361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: XDP_TX and XDP_REDIRECT silently truncate fragmented =
multi-buffer frames
--

commit 88d6b2e1e748cc0cbaefcc8f5a91d160e92c0cf4
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This patch accumulates descriptors that make up a frame to build an xdp_buff
so the XDP program runs on the full fragmented packet. If not consumed by t=
he
program, it constructs the skb from the head buffer and collected fragments.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5874,135 +5996,94 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)

[ ... ]

> +		/* For Not XDP_PASS verdict */
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res =3D -PTR_ERR(skb);
> +
> +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len,
> +						    true);
> +				rx_dropped++;
> +			} else if (xdp_res & (STMMAC_XDP_TX |
> +					      STMMAC_XDP_REDIRECT)) {
> +				xdp_status |=3D xdp_res;
> +			}

[Severity: High]
Does this silently truncate fragmented multi-buffer frames when the XDP pro=
gram=20
returns XDP_TX or XDP_REDIRECT?

Looking at the transmit path in stmmac_xdp_xmit_xdpf(), it maps and prepares
only the linear data of the xdp_frame:

	if (dma_map) {
		dma_addr =3D dma_map_single(priv->device, xdpf->data,
					  xdpf->len, DMA_TO_DEVICE);

It does not appear to check xdp_frame_has_frags() or map the fragments stor=
ed
in skb_shared_info.

Since this patch allows stmmac_rx() to build and process fragmented xdp_buf=
fs,=20
if the program forwards a fragmented packet, won't the hardware transmit on=
ly
the linear portion and drop the rest?

> +
> +			/* Clear skb as it was set as status by
> +			 * the XDP program
> +			 */
> +			frames =3D 0;
>  			count++;
>  			continue;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-stmmac-rx-=
mb-v3-0-50fa171af9ec@oss.qualcomm.com?part=3D2
