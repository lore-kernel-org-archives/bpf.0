Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93934BA9EF;
	Wed, 16 Sep 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597698; cv=none; b=QK9BicWMQ5KNpuC/9AXp+vDDvx9vGooUGIoxOMLnO2eWanwcvM75UjfZ4+Tuihaljlg1yEeIRl5U6pbjRd1QJ/u02mm0cO/0GiTmAY4SB5yug0CSC8JBXnWwZBPEiSEfVOFvkOakubCP4ixw+BkJqqxrSwRccBi3YBef5X3IzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597698; c=relaxed/simple;
	bh=TC+861pk9TyK0PXzAtqsX8G6QL+Ez51AgaWQSsljq0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FLp+Lta67aSqR5cpKjVKptQyKqYCVuw8z9XFgQW2dpWJuYBNpSCoyA1ANYTKGCc3PZVr/lKbQlmGWeLjYxlhbhIwkrYZzfPIwp3MaJ/9LofFcQbVacL05wQiKNA8WNGibSIfn71CJgWImmQ4zjHHKccah//tqxSAQnBqYpjxDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7V4E9eL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7V4E9eL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCBB1F000FF;
	Wed, 16 Sep 2026 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789597685;
	bh=QBEqGjEOYrktXow/XUf5ohly5wMs6PFsVwa4molD5Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7V4E9eLqTj/WmLKuAodw4RwUsQVxIjFdmua0J+TYdbCcOHBKbh4yjNXsdn64pss+
	 tbiz1s6cM9GjwMgkAnTlXj5Ryw43gwUEJwqZsOso5myZlFoxf6IJufZKYf2dYWPaa8
	 xQT5NTN/UUk6aGNjH6sKMs3kU20faLyBkuu/76+BSPPKWNZmYIbcjtPcIdJdrOLs5J
	 H0OVYmt3LnLPm5x14V+ouXMtvMu9fcxHf71vDtyT8uJyYFa6d4JWIV1I+f2vMorMMj
	 WPnvYtgfWAl8GOQajO6q1JTJwN1t7u9K9DsnyenxqNghdwJx5ky+2O96n+deWJdoqx
	 rGeRYmpFsWYmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net 5/7] net: enetc: pad short XDP frames coming from
 devmap
Reply-To: sashiko-reviews@lists.linux.dev
To: vladimir.oltean@nxp.com
Cc: bpf@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260915222735.1016937-6-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-6-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:28:05 +0000
Message-Id: <20260916222805.9CCBB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: double counting of dropped XDP frames
--

commit eb0b831b4274ed0cdbc903bad8f5a21c4a5499be
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

net: enetc: pad short XDP frames coming from devmap

This patch adds length checks and padding for short XDP frames transmitted
through enetc_xdp_xmit(). It introduces xdp_frame_pad() to pad frames to
the minimum Ethernet size and drops frames that cannot be expanded.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/e=
thernet/freescale/enetc/enetc.c
> index bbad942041f5a..8a9ba168eab1e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1838,15 +1838,23 @@ int enetc_xdp_xmit(struct net_device *ndev, int n=
um_frames,
>  	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
> =20
>  	for (k =3D 0; k < num_frames; k++) {
[ ... ]
> +		if (unlikely(xdp_frame_pad(xdpf) ||
> +			     xdpf->len < ENETC_MIN_BUFF_SIZE)) {
> +			tx_ring->stats.xdp_tx_drops++;
> +			break;
> +		}
> +
>  		xdp_tx_bd_cnt =3D enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,

[Severity: Medium]
Will this cause the dropped frame at index k to be counted twice?

When xdp_frame_pad() fails or the length is still below ENETC_MIN_BUFF_SIZE,
the drop counter is explicitly incremented before breaking out of the loop
in enetc_xdp_xmit().

However, looking at the end of enetc_xdp_xmit(), the function=20
unconditionally evaluates the remainder of the frames:

    tx_ring->stats.xdp_tx +=3D k;
    tx_ring->stats.xdp_tx_drops +=3D num_frames - k;

Since k is the index of the frame that just failed, num_frames - k includes
this same frame again. As a result, the frame at index k appears to be
counted once inside the loop, and a second time at the end of the function.

Could we simply break out of the loop here and let the end of the function
handle adding it to the drop count, similar to how it handles the other
failure paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915222735.1016=
937-1-vladimir.oltean@nxp.com?part=3D5
