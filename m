Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A92DC765
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847652; cv=none; b=nDJYlL05FOg6FocVNycfLts4vVsrwCYqIZSMNNw1EN4weOmH4xuvAcvZPtrIgQMN4ZxlsTP6/67GCAwgr8SULjwcZVUGW+cN84JpkzLDvidhH1hf/dtqwqM+xSsRo3DqOBO2oe05fpEGPvQd2M3etexmu6CUpxnkDF6qVI1+Ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847652; c=relaxed/simple;
	bh=pAaaZ1iWfporPIsKd2D2ma8ZHnJxXHPu3PmBVuv6wqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=slh7IsaDb+mI235m5GUk1w26uK4vtey6/c30W23HTS21yInvDnGeYhh68wzBfvBqaadWKMkmkOi1eGNDG5qLDiQGErK2z3YnAUw7/K0uMNxnY3pT1e3u+251nDZ+p7KKfhKZVT6XTFpgWH7ekrfVtiS7h81EOqxyDBJKMRzXcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzTCNraN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzTCNraN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63461F000E9;
	Tue, 30 Jun 2026 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847650;
	bh=szT46Yn0WqYeGxjXzLVaey6a+Ul7Ju7viQC/SN9LmXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RzTCNraNZRfoz6YAYChqwmrr41n5nn2//idwpOT6ao6IlFDabXxILEv+36PxFKfj8
	 8UctfABDCgGu4EX75CTs0DKB5CcPCfgCqsyOEqGEp6j76lYE2OfyWdfYl/BqiGHB/c
	 pIbC6/fI8P8uQUdFW8etNLCWr6Q0UYZE/gvbuz0Ga1xmD6dcIJlo6wpaLvWfp5nQQq
	 8QuSWO2sGQyGlxWw1J4JAuBzXKp+++EfYsmLfpy933/PxGvuYo9vKnNcCKm6l59X6b
	 c1pVXrVWutAI4qt9OpYNwtpW7bCrEUDuemiiNU8dbegY5DcIOu00CybIVK7O6OzRCq
	 oRBknkRtlcdXA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 5/7] ice: support the rx_csum XDP
 metadata hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630191510.81402-6-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <20260630191510.81402-6-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:27:30 +0000
Message-Id: <20260630192730.B63461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete checksum validation logic improperly reports `XDP_CSUM_=
VERIFIED` for packets with IP or outer header checksum errors.
- [Low] Dereferencing a `void *` pointer causes a compilation error.
--

commit 3569f119a8bc81475b62415df37c17d04819a768
Author: Vladimir Vdovin <deliran@verdict.gg>

ice: support the rx_csum XDP metadata hint

This commit implements the xmo_rx_csum XDP metadata hint for the ice driver
by reading the Rx flex descriptor status bits. It mirrors ice_rx_csum()
and returns -ENODATA when hardware checksum offload is disabled.

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/=
ethernet/intel/ice/ice_txrx_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c

[ ... ]

> +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> +			   enum xdp_csum_status *csum_status)
> +{
> +	const struct libeth_xdp_buff *xdp_ext =3D (void *)ctx;
> +	struct ice_rx_ring *rx_ring;
> +	u16 status0;
> +
> +	rx_ring =3D libeth_xdp_buff_to_rq(xdp_ext, typeof(*rx_ring), xdp_rxq);
> +	if (!(rx_ring->netdev->features & NETIF_F_RXCSUM))
> +		return -ENODATA;
> +
> +	status0 =3D le16_to_cpu(xdp_ext->desc->wb.status_error0);

[Severity: Low]
Does this code compile? Looking at include/net/libeth/xdp.h,=20
libeth_xdp_buff->desc is defined as const void *. Attempting to access=20
the wb member directly on a void pointer will cause a compilation error.

> +	if ((status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)) &&
> +	    !(status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S)))
> +		*csum_status =3D XDP_CSUM_VERIFIED;

[Severity: High]
Does this code improperly report XDP_CSUM_VERIFIED for packets with outer
header or IP checksum errors?

Unlike ice_rx_csum() which validates IP and outer header errors, this
condition only checks that L3/L4 are present and that there is no inner L4
checksum error (XSUM_L4E_S). If a packet has a corrupted IP checksum or a
corrupted outer UDP checksum in a tunnel (XSUM_EUDPE_S or XSUM_IPE_S), it
appears this will bypass the error flags and still return XDP_CSUM_VERIFIED.

> +	else
> +		*csum_status =3D XDP_CSUM_NONE;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630191510.8140=
2-1-deliran@verdict.gg?part=3D5
