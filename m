Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D536C598;
	Mon,  2 Feb 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042500; cv=none; b=BnsbeX7E9T9aQM5xaCg5hzv7seqv3RXgR4Wkhqo02ul16BKR0Xn803tSlfuE9/4f+rY7czDBj84TZtojWKNgvQCF8SjMiPnI+0YUi/k+w7cU5/NtewZPDv4uy5B6dmLf8GvxJzyA1OuLy8+MYYQ9kdMdS99jSOIpHIOMrdw+6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042500; c=relaxed/simple;
	bh=9GK7c/+ItwHetxr6eJlNOJePzxSiR/TFo01yiisSKV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1E02RG9CubD40nZiLU1F/0MwRljqkrMAIK7yiCVlx9+LaCJEgT/1IFDLPfzpoeZd2EjDJfjYoQH+7XDwNMJzmVYB2ZWMqZzMZK5+8QWKMRL6GkoCTiAXim/7YNb3/Ue2QHjH1BTegsYYZXVXdgD8qVucOMuP/Ues+BLD0UGrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WenBnx0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WenBnx0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A191C19422;
	Mon,  2 Feb 2026 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770042499;
	bh=9GK7c/+ItwHetxr6eJlNOJePzxSiR/TFo01yiisSKV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WenBnx0ThipuTGAaEC1onJkXKqsZQUieHUHYbvUCrtoP6RMH9x2d2nh+Qw/X7+grO
	 MpO9/e4dnTsnyg9/G2yIShTGyrsqigzHVCYwX7tkeEgi2HZ6kUKy87sO9MO3Zsbpwv
	 btliJlexQfREdwUM26ILJ9dePCP2LwZ5fayXXDpdYnVanBOfUpA8WNxEi5ZnsmhqDn
	 +45Vtgi2PxGAU10DNmaX7Bw5Wl8j9agc7o95LtY+2TluU6kBDbvXn6xgl4zzoMjMBN
	 3uV11nowhRsUBQ+HxXAPeUach42vKs3dx+CPNvPtvT6ZvFzuKKOsXTCheczw3lEgNX
	 AApTrw4q5kWrw==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	xiaoning.wang@nxp.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	ast@kernel.org,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	edumazet@google.com,
	kuba@kernel.org,
	hawk@kernel.org,
	davem@davemloft.net,
	daniel@iogearbox.net
Subject: Re: [v5,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Mon,  2 Feb 2026 14:26:55 +0000
Message-ID: <20260202142655.1847932-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129103447.1893129-7-wei.fang@nxp.com>
References: <20260129103447.1893129-7-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add fec_enet_rx_queue_xdp() for XDP path

This commit separates XDP path packet processing from protocol stack
processing by creating a dedicated fec_enet_rx_queue_xdp() function.
The goal is to optimize XDP performance by removing unnecessary code
paths that were interleaved with regular packet processing.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> +static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
> +			 struct xdp_buff *xdp, u32 sync)
> +{
> +	struct page *page = virt_to_head_page(xdp->data);
> +
> +	page_pool_put_page(rxq->page_pool, page, sync, true);
> +}

[ ... ]

> +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
> +				 int budget, struct bpf_prog *prog)
> +{

[ ... ]

> +		switch (act) {
> +		case XDP_PASS:
> +			rxq->stats[RX_XDP_PASS]++;
> +			/* The packet length includes FCS, but we don't want to
> +			 * include that when passing upstream as it messes up
> +			 * bridging applications.
> +			 */
> +			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
> +			if (!skb) {
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_PASS);
> +			} else {
> +				napi_gro_receive(&fep->napi, skb);
> +			}
> +			break;

When fec_build_skb() fails, it already returns the page to the page pool
via page_pool_recycle_direct():

    static struct sk_buff *fec_build_skb(...)
    {
        skb = build_skb(page_address(page), ...);
        if (unlikely(!skb)) {
            page_pool_recycle_direct(rxq->page_pool, page);
            ...
            return NULL;
        }
        ...
    }

Calling fec_xdp_drop() after fec_build_skb() returns NULL will return
the same page to the pool a second time. Can this cause page pool
corruption under memory pressure when build_skb() fails?

[ ... ]
