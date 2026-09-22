Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CB23ED6A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067542; cv=none; b=JqX0d7ztZEewD+GXZmAmiu0U5ILZtWbQvpNSR1BviCqNed/H+mcMnBrDyNhYC5woE5NIf3ilY4b/eSRsQdcy5etFF83vYhXuXRBcB76Df1cH/cSdaUNrQWIn++eQt8syOlS/Q5SAKGnD+AKuxW9FSvT4a3gfvP1pv/i+vxYcE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067542; c=relaxed/simple;
	bh=VVv2kDJFKReIrqp9pGYKuq9Wml1yMmmsjdn494SXU+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CyJrMAxfB90J+/60nhru5PvcRf6uh6F6IQjgc7MusjdssyZIEwcKMFch3hLevHH6BcsXmzdEVapNteDWbfvuGgilBi7KLQdK5v8R3/TWKHyC/HRsAhNmTdlRDIQDEEP20QLbgwTj8x+aKqWIuvGaOKUoD0Z9qsliRrD4BybCyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahsjZ24a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahsjZ24a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1195F1F000FF;
	Tue, 22 Sep 2026 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067541;
	bh=57Fe0R4HbaOrWlQHd5p7lQyWokwH9WcFtjpHtgiS9CU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahsjZ24ahMvhGP3ILjwfj+xlwIWQsaYAbjGOQ3QUdjhoTyG9UQq7Zc/lmiTRVcosC
	 0oh7TFbsYIqGULgL+AuqHObcD/VDBvqNZ9ss2zquSVoW2pwePBVwYJuknfGsNoUj4M
	 ccZAl9QOwZQW8iRDHfuvlRru/RYB9NBoclwwkN9cnKvaOEec8OWPiR2mPwnYPSfsTu
	 QEKTzvKHu2EnEMebdWS5YvWeY49Px9vSQQHZH5IoDeb+F4wmrABXzi7VHqymhWlhIa
	 Aflk0u0TAx/0XgHNpBpIxsrZQORoMsKkRdkwx7UbjXPvX77N30hKsMFhUiPJYqiRZA
	 o+IvepRJ9GYsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com>
References: <20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:59:00 +0000
Message-Id: <20260922085901.1195F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: stmmac: missing drop accounting when XDP fragment addition =
fails
--

commit ec049e650a3e45a0def65bd264e60d42d99ff7f9
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This commit builds the xdp_buff by accumulating descriptors so the XDP
program runs on the full packet. It saves the state in rx_q->state across
NAPI poll boundaries and builds the skb from the head buffer and fragments.

Link: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss=
.qualcomm.com

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c31..7d1149511c55d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5866,6 +5932,33 @@ static int stmmac_rx(struct stmmac_priv *priv, int=
 limit, u32 queue)
>  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);
> +			first_desc =3D false;
> +			buf->page =3D NULL;
> +		} else if (buf1_len) {
> +			error |=3D !stmmac_build_xdp_frags(priv, rx_q, buf1_len,
> +							 buf->page,
> +							 buf->page_offset,
> +							 dma_dir, &ctx.xdp);

[Severity: Medium]
When stmmac_build_xdp_frags() returns false, the error flag is set.

This could happen when receiving large frames (e.g. Jumbo frames) on hardwa=
re
configured with small DMA buffers, leading to many descriptors per frame.

Will this cause the packet to be silently dropped without updating
rx_dropped or rx_errors?

> +			buf->page =3D NULL;
> +		}
> +
> +		if (buf2_len) {
> +			error |=3D !stmmac_build_xdp_frags(priv, rx_q, buf2_len,
> +							 buf->sec_page,
> +							 buf->page_offset,
> +							 dma_dir, &ctx.xdp);
> +			buf->sec_page =3D NULL;
> +		}
> +
> +		if (likely(status & rx_not_ls))
> +			goto read_again;
> +
> +		if (unlikely(error))
> +			goto error_free_frag;

[ ... ]

> @@ -5989,13 +6036,24 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
>  		rx_packets++;
>  		rx_bytes +=3D len;
>  		count++;
> +		continue;
> +error_free_frag:
> +		if (!first_desc) {
> +			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> +			first_desc =3D true;
> +		}
> +		dev_kfree_skb(skb);
> +		skb =3D NULL;
> +		count++;

[Severity: Medium]
If we reach this teardown path due to an error, the frame is consumed and
the polling count is incremented, but no interface drop statistics appear to
be updated.

Could this make debugging MTU or fragmentation issues difficult, since drops
(such as exceeding MAX_SKB_FRAGS) would be invisible to monitoring? Should
rx_dropped or rx_errors be incremented here?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-stmmac-rx-=
mb-v2-1-6e826e1ff306@oss.qualcomm.com?part=3D1
