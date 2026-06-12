Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913433932C0
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290709; cv=none; b=MHpLWpeUGes30FVqqoXLyi3yqa8yNIsO07v76uMuVASwGO7MRAuZCrBAHeYjvfXb/zhzCyDuKxZCQHC7SDCl4AA+FHjj9zKL92z/pZYJnq2OcLVUXoXsX48Czf9JZDreetKkDFXbhhfk/O6R7qW4g+shRxBfjQamZHbDjrXBjUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290709; c=relaxed/simple;
	bh=D+4fZSeJosbC6uI5cv9gICKAntgatlQMjQZwk2D3s7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmcJZNrKCsDbWqeAIY5ovgO/qhDczyJh7wLI0wie8+Jk6EC8QtUJOD0raSwFfmQw+BnMmJqxJyiOKPV/vo3Wr29OGWf19qjpQmP0v1lOl6oim1WIvs27amufbTdHi2uqXZS3QRC+9/8gxdrbBLzBv2a997bSoz+SDIIQWGNeY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZMYXkko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZMYXkko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E9E1F000E9;
	Fri, 12 Jun 2026 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781290708;
	bh=QMvt72SwsKGI63FyvIBX4WQbnhB2MStuE+rrHtiJYlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZMYXkkoTqc0oPZwGDISbTblH5vzfEGXZF6ols+rNz84/mlqthcuTv8Gft/o6LDfV
	 aIh+HBneHvrlOH7IuvkGKVI08KcOBYj7yzOSZcoKLpBlp5rfg8HvXM8BIJ3hJ9JzZp
	 IoMW11toEk2HYG3Qsh956vczX6rFVx+EqrFQYym0jdUTaS8NiH+3vO4wQf9+AACsGo
	 TEph4E5nHbuOs9JUXTQy0yjyomrv7amvwzBxtxN/WlkU3Z5SlgVz/yqF8YdbcV+J8c
	 EOOkphL2fvUFZSJPfhjTcykoOHqrr0u5OqbCFkVKb/Bwia2Ah2kYFqYQ0aIIFWv+zj
	 pXoCq1VqKJpCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/4] net: ti: icssg: Use undirected TX tag for XDP
 zero copy in HSR offload mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611185744.2498070-4-m-malladi@ti.com>
References: <20260611185744.2498070-4-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:58:27 +0000
Message-Id: <20260612185828.43E9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] AF_XDP UMEM buffer and Completion Queue (CQ) slot leak due to =
unhandled completion for dropped descriptors.
- [Critical] Double-free of zero-copy buffer and memory leak of xdp_frame u=
pon XDP_TX failure.
--

commit e244d2327204d5a8a195243fec7c3ad5c3b5cf36
Author: Meghana Malladi <m-malladi@ti.com>

net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload mode

This patch updates emac_xsk_xmit_zc() to set the correct destination tags
when operating in HSR offload mode. It ensures that XSK XDP_TX frames are
duplicated to both ports when NETIF_F_HW_HSR_DUP is set, and handles HSR
sequence tag insertion.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index ede32f266729e..82ddef9c17d54 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
[ ... ]
> @@ -137,9 +138,17 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
>  		epib[0] =3D 0;
>  		epib[1] =3D 0;
>  		cppi5_hdesc_set_pktlen(host_desc, pkt_len);
> -		cppi5_desc_set_tags_ids(&host_desc->hdr, 0,
> -					(emac->port_id | (q_idx << 8)));
> +		dst_tag_id =3D emac->port_id | (q_idx << 8);
> +
> +		if (emac->prueth->is_hsr_offload_mode &&
> +		    (ndev->features & NETIF_F_HW_HSR_DUP))
> +			dst_tag_id =3D PRUETH_UNDIRECTED_PKT_DST_TAG;
> +
> +		if (emac->prueth->is_hsr_offload_mode &&
> +		    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
> +			epib[1] |=3D PRUETH_UNDIRECTED_PKT_TAG_INS;
> =20
> +		cppi5_desc_set_tags_ids(&host_desc->hdr, 0, dst_tag_id);
>  		k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &dma_buf);
>  		cppi5_hdesc_attach_buf(host_desc, dma_buf, pkt_len, dma_buf,
>  				       pkt_len);

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at the failure paths
in emac_xsk_xmit_zc() further down in this loop:

		if (ret) {
			ndev->stats.tx_errors++;
			k3_cppi_desc_pool_free(tx_chn->desc_pool, host_desc);
			break;
		}

Does this code leak UMEM buffers and Completion Queue (CQ) slots?

The driver peeks an AF_XDP descriptor using xsk_tx_peek_desc(), which
reserves a slot in the CQ ring. If pushing to the DMA queue fails and the
loop breaks, the peeked descriptor is dropped without reaching the hardware.

Since xsk_tx_completed() will never be called for this descriptor, does this
leave a permanently reserved but un-submitted slot in the CQ ring,
potentially desynchronizing it and leaking slots?

[Severity: Critical]
This is another pre-existing issue in this file, but looking at XDP_TX
handling in emac_run_xdp():

	xdpf =3D xdp_convert_buff_to_frame(xdp);
	if (unlikely(!xdpf)) {
		ndev->stats.tx_dropped++;
		goto drop;
	}
	...
	if (result =3D=3D ICSSG_XDP_CONSUMED) {
		ndev->stats.tx_dropped++;
		goto drop;
	}

And then in emac_rx_packet_zc():

	case ICSSG_XDP_CONSUMED:
		xsk_buff_free(xdp);
		break;

Could this sequence trigger a double-free of the zero-copy buffer and leak
the xdp_frame page?

If the XDP program returns XDP_TX, xdp_convert_buff_to_frame() (which calls
xdp_convert_zc_to_xdp_frame() for zero-copy pools) allocates a new page and
completely frees the original xdp_buff via xsk_buff_free().

If the transmit then fails, it returns ICSSG_XDP_CONSUMED but doesn't free
the newly allocated xdpf page. When ICSSG_XDP_CONSUMED is passed back to
emac_rx_packet_zc(), it explicitly calls xsk_buff_free(xdp) on the original
buffer that was already freed during conversion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611185744.2498=
070-1-m-malladi@ti.com?part=3D3
