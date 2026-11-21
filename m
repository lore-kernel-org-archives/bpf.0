Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259475;
	b=MerJrY3jq13uUz1a+vKUIZEDhgqHlKUEojovu9AMCfLGSd+HOHp/f095Z0S+H+MEuabY
	 GBH20r+NCYc49QLCjHc/eqgV9uLPH+2hsGa6t6oqiPWT/utMcg2ZAtyRiCIWxAnVIeemf
	 LLTckGu7QFMso9Of1cWaqzd2NPlWKzp+EBfRF5crHuJXMgISnejHFNoChuu3U6Xd50ZCx
	 ak3WW8XJZPXrdA1gUL8J9A/5BmW5YUtPaknjRSFnQ/NVZoe5n9YuNDMz7R+Dt20fnPhOh
	 2vUDos6pDlsRYJrRbTOdhNVgcj43hN87AFVNVhOsSaybR8qEfGjxR9PJi1w3mDCFOmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cK3JihZerztUyBM2JSM9EgYoPbV4Tqmf9dDJvzkXLF0=;
	b=r9jzsr/76Aa214eIz333LizzdXqfbn1k+hUxIIRutpefKw/bm9R+U/R+c14Wl0rSI/2D
	 BcqjxV+naIVJlKYYmYiqrpi1DF5Yg6pcFxurbmlxbFWhCXZwgLuiTvvtdf+9ygZDDfZpK
	 O5dG09RFKid/74PBCw/mVE1WIzoOKzlLuWdcz5FNIrGbxsaev4pNncFRRacFH0HoYxvBt
	 RGJZndINaG+TvgpQqMGe90pzusTKfpcSJfaeN5lghIbntkXI9d3tW9LE9MFf8ybSxnBIL
	 JHAdRidsMUWPXrHEPrGX4+W1lqIoGCmTJ6zwGQDrFmU2ZA9xoPVRt0oycWeQOb2cYgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dust6dA8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB86606A331
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dust6dA8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE4D1F000D2;
	Sat, 21 Nov 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795259475;
	bh=cK3JihZerztUyBM2JSM9EgYoPbV4Tqmf9dDJvzkXLF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dust6dA8DuNWsx/obqW7RBDFRaN3bBxz+jUK5Fe97tRAfXz/rN87uCgn45EitvIF4
	 mBVBJGuf0XeNoDsVZ5qK14LWsQDRvPSUs/aCRpVAxneFYUckCqnQn+IQKmMhwnrVXj
	 Y+cTpSOJxQrroh2VUWF1MA98ILX07R2jfFT3leYNKWPbgzMFUKvk84Qai2/jpf3kVR
	 M5mXpCuYjdk/wz5fq264NoWqWvofvxG8oW1DT7knInlLMD6gUfqmg682KAXs5Ur+vY
	 3k/regM8tJGSlE7dwN/q17RFCp+gZNtzHtrCwFrqwBw9rWRJ1i9OGGRNDkd4LSzF8/
	 PWIIj6VD/0VMg==
Message-ID: <sashiko-outbox-226971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 1/3] igb: do not let XDP frames span more than
 one Rx buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
 <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:11:14 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] igb: missing IGB_TS_HDR_LEN room in 2 KiB build_skb buffers
  with XDP
--

commit 91c56c1d76e1bd0d76622dd294c28474abad9f0e
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: do not let XDP frames span more than one Rx buffer

This commit limits RLPML and VMOLR to the configured maximum frame size whi=
le
XDP is attached, accounts for the inline Rx timestamp header when checking =
if
a frame fits in one Rx buffer, and prevents rx-all or legacy-rx changes from
bypassing those limits.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index ce91dda00ec0e..5f1a5e2240e64 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c

[ ... ]

> @@ -2886,6 +2946,27 @@ static int igb_setup_tc(struct net_device *dev, en=
um tc_setup_type type,
>  	}
>  }
> =20
> +/* Check that a frame fits in one Rx buffer together with the inline Rx
> + * timestamp header, for the buffer size igb_set_rx_buffer_len() selects.
> + * The ring flags are only updated when the rings are configured, so they
> + * are not used here. For build_skb rings the frame is limited to
> + * IGB_MAX_FRAME_BUILD_SKB, which is below the 2 KiB hardware buffer size
> + * even with the header.
> + */
> +static bool igb_xdp_frame_fits(struct igb_adapter *adapter, int max_fram=
e)
> +{
> +#if (PAGE_SIZE < 8192)
> +	if (!(adapter->flags & IGB_FLAG_RX_LEGACY)) {
> +		if (max_frame <=3D IGB_MAX_FRAME_BUILD_SKB &&
> +		    !IGB_2K_TOO_SMALL_WITH_PADDING)
> +			return true;

[Severity: High]
Can a frame with an inline Rx timestamp overflow into skb_shared_info on a
2 KiB build_skb buffer?

Although IGB_MAX_FRAME_BUILD_SKB + IGB_TS_HDR_LEN fits inside the 2048-byte
hardware buffer size in SRRCTL, DMA on a build_skb buffer starts at
IGB_SKB_PAD and must leave SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
bytes at the end of the 2 KiB slice:

drivers/net/ethernet/intel/igb/igb.h:igb_skb_pad() {
    ...
	else
		rx_buf_len =3D IGB_RXBUFFER_1536;

	/* if needed make room for NET_IP_ALIGN */
	rx_buf_len -=3D NET_IP_ALIGN;

	return igb_compute_pad(rx_buf_len);
}

Because igb_skb_pad() sets IGB_SKB_PAD to
SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048) - IGB_MAX_FRAME_BUILD_SKB without
reserving IGB_TS_HDR_LEN (16 bytes), only IGB_MAX_FRAME_BUILD_SKB bytes are
available between the DMA start offset and skb_shared_info.

When hardware Rx timestamping is enabled (E1000_RXDADV_STAT_TSIP) and RLPML
or VMOLR allows frames up to max_frame_size (or IGB_MAX_FRAME_BUILD_SKB), t=
he
MAC strips the 4-byte FCS and prepends the 16-byte timestamp, writing
wire_len + 12 bytes from IGB_SKB_PAD.  A frame with wire_len between
IGB_MAX_FRAME_BUILD_SKB - 11 and IGB_MAX_FRAME_BUILD_SKB (for example at MTU
1500..1510) pushes xdp.data_end up to 12 bytes past
SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048).  On XDP_PASS, igb_build_skb() ->
napi_build_skb() zeroes skb_shared_info over the end of the payload and
__skb_put() advances skb->tail past skb->end, triggering skb_over_panic() on
a later skb_put() or skb_copy(); on XDP_TX or XDP_REDIRECT,
xdp_update_frame_from_buff() hits XDP_WARN and drops the frame.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-igb-rx-ts-=
fix-v7-0-63b03045978e@aweta.nl?part=3D1
