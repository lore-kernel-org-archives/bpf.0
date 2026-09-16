Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FA4B04BD;
	Wed, 16 Sep 2026 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597698; cv=none; b=eboslloMc+MzOz1F6tvdvlWmWuOkgImsQzUInpY+YvCQJzsK/wC/Lz9wjULNQljUnTcsn25/ZMxDc/MP0TIWRdGTlJFNQjzMG1VkvCRPRMdX17E41zgbrgAGnTYd6BfCZpNQikDkOKK116M+D67ibMhehz4RjlOqoKbxWo6ONng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597698; c=relaxed/simple;
	bh=3gwwOwU+/gSmqPexfz+eDYVtMsVqv+VY/BY883ampSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZHndnXqu4WzEKiutc/hxiZT06zztVYHB8ttgsCi50R4HMNfmLejU+MXv1qQgf29viIx5G4Nl8E+2Ylv0dOp5sBJ333BlwEup3Fym64dIslUf6ol8dPu1o+JTynWPmBdEmWjYmYpaxSRrlrfJo+T8TEXBxIF9onh2KIxK1ROZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4ZNPyoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4ZNPyoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2EC1F00898;
	Wed, 16 Sep 2026 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789597687;
	bh=8WCQ9KEoQUjpSM7YAhXP/SdY6Ame84DY/QL87U2z2tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4ZNPyoH2oNpL+cJKuaMoBvvsMaaZWqoHR9WKgbJeLcn80ZlA0VkDEtMYyDNzy0qM
	 94JeeFBlGEhDt+Xs/yHcPxJAtaZUXyGNIH33RHlwPo45EkiRVHgM+mTDZ6YX6AwdL3
	 TrtOxOzIzj33cZthoQd+pXcY+MbLRdFVU4WvcdarHxE6s1/4ZMZxJpBxt6+oIyZzLq
	 a11EC8PuDEn7EvIHMTUan00cgA/mZP+HFtHaq3Kkey9Skeimcp5t8C84vchHNw9Uqz
	 79xJnbpf15Eem0l/YrQe3nVghBf8kV4IpJ4PApu0c7LfH0ep+4ca5MogXdwGvUjLfx
	 GdogJP2zZBaeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net 6/7] net: enetc: linearize PTP event packets with
 one-step TX timestamping
Reply-To: sashiko-reviews@lists.linux.dev
To: vladimir.oltean@nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260915222735.1016937-7-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-7-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:28:06 +0000
Message-Id: <20260916222807.2A2EC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net/enetc: data corruption due to skb_linearize instead of skb_lin=
earize_cow
--

commit 4e574e48c7ebf46bd9831e2efa9f6f3ac1500c3d
Author: vladimir.oltean@nxp.com <vladimir.oltean@nxp.com>

net: enetc: linearize PTP event packets with one-step TX timestamping

This commit addresses parsing issues with fragmented PTP headers in
enetc_ptp_parse() by linearizing packets with one-step timestamping request=
s.
The commit message states that it uses skb_linearize_cow() to also solve a
secondary issue where enetc_update_ptp_sync_msg() modifies the packet data
in-place later in the TX path, which requires the SKB to be exclusively own=
ed.

Link: https://sashiko.dev/#/patchset/20260401172246.1075883-1-vladimir.olte=
an%40nxp.com

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/e=
thernet/freescale/enetc/enetc.c
> index 8a9ba168eab1e..62cdcaab3f3fb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1099,6 +1099,11 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> =20
>  	/* Fall back to two-step timestamp if not one-step Sync packet */
>  	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		if (unlikely(skb_linearize(skb))) {

[Severity: High]
Does this code use skb_linearize() instead of the intended
skb_linearize_cow()?

The commit message and v2->v3 changelog explicitly mention using
skb_linearize_cow() to ensure the packet is exclusively owned and writable.
However, the code uses skb_linearize(), which only unshares the buffer if
it is nonlinear. A linear cloned SKB (e.g., from AF_PACKET, tc mirred, or
bridging) will bypass the copy.

Since enetc_update_ptp_sync_msg() modifies the originTimestamp field direct=
ly
in the SKB buffer later in the TX path:

    *(__be16 *)(data + tstamp_off) =3D new_sec_h;
    *(__be32 *)(data + tstamp_off + 2) =3D new_sec_l;
    *(__be32 *)(data + tstamp_off + 6) =3D new_nsec;

Could this corrupt the buffer for other users if the SKB was linear and
cloned?

> +			dev_kfree_skb_any(skb);
> +			return NETDEV_TX_OK;
> +		}
> +
>  		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
>  				    &offset1, &offset2) ||
>  		    msgtype !=3D PTP_MSGTYPE_SYNC || twostep !=3D 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915222735.1016=
937-1-vladimir.oltean@nxp.com?part=3D6
