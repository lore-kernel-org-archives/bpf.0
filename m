Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED33B47D2;
	Fri,  4 Sep 2026 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513599; cv=none; b=f4fpuM3M0ebawwbS8JYcqLvcvy2A6JNFvonglj+lX8MwvePvHMlWi5Bzr/0HsqsRS4wMdU01OKSBpaa6MJIGRU2nJxohTCFTo0uqL0NbbbKeRzisUqiVX40RSZy3ezxlLTEOCWAJw0Gz2ROSTHQDYIeSTvikMJWq2cprWVcOoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513599; c=relaxed/simple;
	bh=/we4o96trO0R5t6PKQwVGx4wal4PKE15RhiGxtE7hsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cew26g8uFI3k4vt4M1LASsy5pmNNa10qKMv85fzRKFVzd9cAfyNxQq7yeYqcjY7JPeGzhb8Gc734VcTvLNVy9jArJgFHp0kd4CFG5tKVTM2ZSZ8GIYVkNlzldpoblxhKeGrbHzdXKfr+S3VO/jIOi19hZ2JnRbXeERmBc++jnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUJIUN4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUJIUN4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D831F00A3D;
	Fri,  4 Sep 2026 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513597;
	bh=ySGxHNWJrB7UzfxPoKzyaL2ylg1x9/Sv8FGV/m2Q+GI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dUJIUN4ZW52SsdwcsJbr749PorqLW2asN0j5rXpCkwSbYtAiXGMr1uUsIUhWDrRGT
	 RAp11rpEKxrZIxTc2wm2x1Wye3XdqkaWqs8ondoIFVyg1Xapd/T4GntYcMZErzYkHB
	 DBEGgjxnuaZXMLTJA85aKT2+TsE2JGNAnjZU7zDVI1aQSjAR0v4D6CiId4iBcPRR4L
	 3ohsDWMvuwaJtv9Q5+KW0Ov5ls2gT2mhQDZsmxpiGjiBlTfXOm9f+LTWHfxHUpjPBz
	 xQV0mIQaBB5VoFh8n5lNQHaiuU/A7gulnF0rutHXImfjXAKAQoKRkFu0KAyhoZnpPW
	 Db/rOMlr7oTPw==
Subject:
 Re: [PATCH net-next 2/4] i40e: add support for bpf_xdp_metadata_rx_hash()
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, kohei.enju@gmail.com, enjuk@amazon.com,
 przemyslaw.kitszel@intel.com, blair.steven@alliedtelesis.co.nz,
 carl.smith@alliedtelesis.co.nz, horms@kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, aleksandr.loktionov@intel.com,
 sx.rinitha@intel.com
Date: Fri, 04 Sep 2026 09:19:55 +0000
Message-ID: <178851359588.4131868.14209764775589320419@kernel.org>
In-Reply-To: <20260901211752.1922993-3-anthony.l.nguyen@intel.com>
References: <20260901211752.1922993-3-anthony.l.nguyen@intel.com>
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

- [Medium] i40e_config_netdev() sets `netdev->xdp_metadata_ops =
  &i40e_xdp_metadata_ops;` unconditionally…

--

i40e: add support for bpf_xdp_metadata_rx_hash()

This adds i40e_xdp_rx_hash() as an xdp_metadata_ops callback, extracting
the RSS hash and hash type from the RX descriptor the same way
i40e_rx_hash() does. A new I40E_RX_DESC_STATUS_FLTSTAT_MASK helper is
added to i40e_type.h and the ops struct is installed on the netdev.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 4b11ae9ed8d53..e487d697a634f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c

[ ... ]

> @@ -13582,6 +13583,34 @@ static int i40e_xdp(struct net_device *dev,
>  	}
>  }
>  
> +static int i40e_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			    enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct i40e_xdp_buff *ctx = (const void *)_ctx;
> +	const union i40e_rx_desc *desc = ctx->desc;
> +	struct libeth_rx_pt rx_ptype;
> +	u8 raw_rx_ptype;
> +	u64 status;
> +
> +	status = le64_to_cpu(desc->wb.qword1.status_error_len);
> +	raw_rx_ptype = FIELD_GET(I40E_RXD_QW1_PTYPE_MASK, status);
> +	rx_ptype = libie_rx_pt_parse(raw_rx_ptype);
> +
> +	if (!libeth_rx_pt_has_hash(ctx->xdp.rxq->dev, rx_ptype) ||
> +	    FIELD_GET(I40E_RX_DESC_STATUS_FLTSTAT_MASK, status) !=
> +		    I40E_RX_DESC_FLTSTAT_RSS_HASH)
> +		return -ENODATA;
> +
> +	*hash = le32_to_cpu(desc->wb.qword0.hi_dword.rss);
> +	*rss_type = rx_ptype.hash_type;
> +
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops i40e_xdp_metadata_ops = {
> +	.xmo_rx_hash		= i40e_xdp_rx_hash,
> +};
> +
>  static const struct net_device_ops i40e_netdev_ops = {
>  	.ndo_open		= i40e_open,
>  	.ndo_stop		= i40e_close,

[ ... ]

> @@ -13784,6 +13813,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>  	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
>  
>  	netdev->netdev_ops = &i40e_netdev_ops;
> +	netdev->xdp_metadata_ops = &i40e_xdp_metadata_ops;

[Severity: Medium]
Should this assignment live inside the I40E_VSI_MAIN branch, next to where
the rest of the XDP capability state is set?

Earlier in i40e_config_netdev() the XDP capabilities are set only for the
main VSI:

	if (vsi->type == I40E_VSI_MAIN) {
		...
		netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
				       NETDEV_XDP_ACT_REDIRECT |
				       NETDEV_XDP_ACT_XSK_ZEROCOPY |
				       NETDEV_XDP_ACT_RX_SG;
		netdev->xdp_zc_max_segs = I40E_MAX_BUFFER_TXD;
	} else {
		/* Relate the VSI_VMDQ name to the VSI_MAIN name ... */

but i40e_config_netdev() also runs for VMDQ2 netdevs, via i40e_vsi_setup():

	switch (vsi->type) {
	/* setup the netdev if needed */
	case I40E_VSI_MAIN:
	case I40E_VSI_VMDQ2:
		ret = i40e_config_netdev(vsi);

Those macvlan-offload "<pf>v%d" netdevs get xdp_features == 0, and
i40e_xdp() rejects every ndo_bpf command on them:

	if (vsi->type != I40E_VSI_MAIN)
		return -EINVAL;

So no native XDP program can be attached there, and xmo_rx_hash can never
be reached on such a netdev.

Does this make the netlink capability report inconsistent?  netdev_nl_dev_fill()
derives the xdp-rx-metadata-features bits purely from the presence of the
callback, with no cross-check against dev->xdp_features:

net/core/netdev-genl.c:netdev_nl_dev_fill() {
	...
#define XDP_METADATA_KFUNC(_, flag, __, xmo)			\
	if (netdev->xdp_metadata_ops && netdev->xdp_metadata_ops->xmo)	\
		xdp_rx_meta |= flag;
	...
}

which means a VMDQ2 netdev advertises NETDEV_XDP_RX_METADATA_HASH ("Device is
capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash()") while
rejecting XDP entirely.

The follow-up patch adding bpf_xdp_metadata_rx_vlan_tag() extends the same
unconditional assignment, so NETDEV_XDP_RX_METADATA_VLAN_TAG ends up reported
on those netdevs too; the assignment is still unconditional at the end of the
series.

>  	netdev->watchdog_timeo = 5 * HZ;
>  	i40e_set_ethtool_ops(netdev);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901211752.1922993-1-anthony.l.nguyen%40intel.com
