Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C7511228;
	Wed, 16 Sep 2026 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601760; cv=none; b=M/SW/J0zGaOjaDfCqragQ0uBp2He5Z+EM5AzJTErNhQK+R2oBKMcR8viIAitMdYE7WjxE/IHuABi/YJ7lhLUhySeUCpN6IwzeoJI4YihpbO+R1hzKgmNaA7RLWvHzhCfJguvnjyVvhBHHoqCcfU+9Ioyj4PDTGC0CoCDQiE2fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601760; c=relaxed/simple;
	bh=M3PJ491Ihicf0ZYf92D7Y0h/acg4vUnnMTGTYF+IPSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbtkpDnFDEywk6faQ3+IvUoFP703Id9WdFOCkfKJGM9AhdL9B1TFPE/wlHH6hcEO5aGSjo29OpHZiisK4iXRENTJgcdx5LpWTbzcvnwE7fpOsu5ryUQsg0jCd0zUfYHdL9aJguYO3WmGS3btLqjBwAoqGvZawmB+Zox8ZIpsgvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9wWamPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9wWamPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67821F00893;
	Wed, 16 Sep 2026 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601758;
	bh=J1Yo+mRpBnh/dAo8vukmcIu6MyI2FYZHVhq7UHZsBwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B9wWamPR9GISRswEH5Nc9akYR3WP3l12m+mzl+BkTKPZjERvnSitDASoE83JWqdNR
	 /y63y5ZIofh+yot0wl+lNC0J9Zq+QeC1tPStrzcrWb2+zyW/HL4kf4ABAcuiNoVVno
	 n0nbmJIBsT1vkdWUv2zWU3UrhvMUxquY9UXnNj0ZFsNgFtlRSNPoq3/6/cIvaIohAJ
	 WBS31jQ9eMnhrJthQVgjrQQnWz1UIGJF2NAbaGoApeUpB2/9FS7bKRCy2MjmpFOhFH
	 TRc0REVp/w/SR55GFAWHErUc+pg9ykbcEwBI/UqwP4cOoCWRzdnZFPN0ulHhs8TNYS
	 A5o5YH/GyKYZQ==
Subject:
 Re: [PATCH v3 net 5/7] net: enetc: pad short XDP frames coming from devmap
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, zefir.kurtisi@westermo.com, claudiu.manoil@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, ioana.ciornei@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 16 Sep 2026 23:35:57 +0000
Message-ID: <178960175738.22033.7342785947465842406@kernel.org>
In-Reply-To: <20260915222735.1016937-6-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-6-vladimir.oltean@nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] In enetc_xdp_xmit()
  (drivers/net/ethernet/freescale/enetc/enetc.c), the newly added short-…

--

net: enetc: pad short XDP frames coming from devmap

This adds a generic best-effort xdp_frame_pad() helper and calls it from
enetc_xdp_xmit(), together with a direct check of the head buffer length
against ENETC_MIN_BUFF_SIZE, so that short XDP frames redirected into
ENETC are padded or dropped instead of being transmitted.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index bbad942041f5a..8a9ba168eab1e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1838,15 +1838,23 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
>  
>  	for (k = 0; k < num_frames; k++) {
> -		if (xdp_frame_has_frags(frames[k])) {
> -			shinfo = xdp_get_shared_info_from_frame(frames[k]);
> +		struct xdp_frame *xdpf = frames[k];
> +
> +		if (xdp_frame_has_frags(xdpf)) {
> +			shinfo = xdp_get_shared_info_from_frame(xdpf);
>  			if (unlikely((shinfo->nr_frags + 1) > ENETC_MAX_SKB_FRAGS))
>  				break;
>  		}
>  
> +		if (unlikely(xdp_frame_pad(xdpf) ||
> +			     xdpf->len < ENETC_MIN_BUFF_SIZE)) {
> +			tx_ring->stats.xdp_tx_drops++;
> +			break;
> +		}

[Severity: Medium]
Does this count the rejected frame twice in tx_ring->stats.xdp_tx_drops?

The new branch increments the counter and then breaks with k still pointing
at the frame that was just rejected, and the epilogue of enetc_xdp_xmit()
charges everything from k onwards again:

	tx_ring->stats.xdp_tx += k;
	tx_ring->stats.xdp_tx_drops += num_frames - k;

so the counter grows by 1 + (num_frames - k) rather than num_frames - k.

The other three break sites in this loop (the shinfo->nr_frags overflow
check, the enetc_xdp_frame_to_xdp_tx_swbd() failure and the enetc_xdp_tx()
failure) rely only on the remainder-based accounting added earlier in this
series by "net: enetc: consistenly track dropped frames in
enetc_xdp_xmit()", whose message states that the counter should be
incremented "by the remainder, not just by 1".

Would dropping the explicit increment here keep this site consistent with
the other break paths?

The branch is reachable when xdp_frame_pad() returns -EOPNOTSUPP (frame
shorter than ETH_ZLEN and fragmented) or -ENOMEM (no tailroom before the
shared info), and also when the frame total is at least ETH_ZLEN but the
head buffer is shorter than ENETC_MIN_BUFF_SIZE, which is the
XDP_REDIRECT-from-veth case described in the commit message.

Since xdp_tx_drops is exported to userspace by enetc_get_ethtool_stats()
via ethtool -S, can the reported drop count end up larger than the number
of frames the core passed to ndo_xdp_xmit()?

> +
>  		xdp_tx_bd_cnt = enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
>  							       xdp_redirect_arr,
> -							       frames[k]);
> +							       xdpf);
>  		if (unlikely(xdp_tx_bd_cnt < 0))
>  			break;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915222735.1016937-1-vladimir.oltean%40nxp.com
