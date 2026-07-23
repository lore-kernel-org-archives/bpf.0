Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA1369D56
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845009; cv=none; b=iOxr6lTeQ8KBAwHNb5UDwu1GUL0hweC6YfVaE3AWtW9z0nzpel+M46Y2iWLBZgkLfmdkVVq5NWuv+E8Bj6utFHOZVA0itRlceCbO1RL6qE4bbXkn8CYDaHqDiS/Azsax5Mh5d4QCigNLvIxkCbIUKcqjZg378aemTmt46bEQ78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845009; c=relaxed/simple;
	bh=fiOCnGSeEHtF+JqI70hUwqbzJJ8kgPc+0wJINcTuQuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0tnXR/mo1/Be/wPzbUgCWDZERiGylaCnXSi8uNMMY+jROWniwgB0nlW2X9fH1Ffv3JrgsOGDKFoEYCp6BuBJJDprqnaybbBZGHwiHfW0JckO2qV9hON72i8WMs40+ycqIn5hM9yIlobYN2h3dkUNksBWZNf+QgYsANmwQqazjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncLJ8yKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncLJ8yKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56571F00A3A;
	Thu, 23 Jul 2026 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845008;
	bh=xRazIBTwWLCXw6QVslxy58USIQx1ziWdSJZ5zCGFBl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ncLJ8yKnK0uAkDWtlFECzMETjjePfG1JXuvQ+9qqv+iTj3k0SFGppq2Zgpn2e30yv
	 SGLxB3hV1UQqkDqepGH8kFm+ygKwlTO2yggBa7sKJlylgY4LEXQ45mdkly4Bo5F5bV
	 PySm2Ou4WmCeeIAwqUgiwLRQiKYPjsPgcAID5/HPiMiCJ46xSA9NBBWWfGbRW+lVDS
	 NqTdyKmxsXKqIgdrnbBd4ItM1GmuLwPrrShNe7SpIzloe1cajxbiaxirB563SbbTTj
	 g3xEK7Gflyickvc+ATjGQjmdWvyesxNjE6PqDv3tOL3TQ22cg0CKk3Cu4YfeeebdSa
	 Ugd2/RNYIqUTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/2] gve: add XDP metadata support for DQ
 RDA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722221634.186886-3-joshwash@google.com>
References: <20260722221634.186886-1-joshwash@google.com>
 <20260722221634.186886-3-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:16:47 +0000
Message-Id: <20260723221647.C56571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In GVE DQO QPL mode with XDP enabled, `buf_state->page_info.pad` a=
ccumulates XDP head adjustments and drifts unbounded, leading to out-of-bou=
nds hardware DMA.
- [High] Missing fragment drop tracking for multi-descriptor packets in the=
 DQO RX path causes subsequent fragments of a dropped packet to be treated =
as new packets, bypassing XDP and network security filters.
--

--- Patch [2]: [PATCH net-next v3 2/2] gve: add XDP metadata support for DQ=
 RDA ---
commit 7fa79d59c32cc58b133c8b5735d2691860bcdca2
Author: Joshua Washington <joshwash@google.com>

gve: add XDP metadata support for DQ RDA

This commit updates xdp_prepare_buff to set meta_valid to true in
gve_rx_dqo. This enables XDP programs to use metadata in the DQ RDA mode.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
[ ... ]
>  	/* Append to current skb if one exists. */
>  	if (rx->ctx.skb_head) {
>  		if (unlikely(gve_rx_append_frags(napi, buf_state, buf_len, rx,
>  						 priv)) !=3D 0) {
>  			goto error;
>  		}
>  		return 0;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about
fragment drop tracking for multi-descriptor packets in this DQO RX path.

If the first fragment of a multi-descriptor packet is dropped (e.g., by XDP=
),
rx->ctx.skb_head remains NULL. Unlike the GQI path which tracks
rx->ctx.drop_pkt, the DQO path does not seem to track dropped state.

Will subsequent fragments of that dropped packet see rx->ctx.skb_head =3D=
=3D NULL,
bypass this append logic, and fall through to the XDP block below, treating
the fragment as a new packet?

> =20
>  	if (xprog) {
>  		struct gve_xdp_buff gve_xdp;
>  		void *old_data;
>  		int xdp_act;
> =20
>  		xdp_init_buff(&gve_xdp.xdp, buf_state->page_info.buf_size,
>  			      &rx->xdp_rxq);
>  		xdp_prepare_buff(&gve_xdp.xdp,
>  				 buf_state->page_info.page_address +
>  				 buf_state->page_info.page_offset,
>  				 buf_state->page_info.pad,
> -				 buf_len, false);
> +				 buf_len, true);
>  		gve_xdp.gve =3D priv;
>  		gve_xdp.compl_desc =3D compl_desc;
> =20
>  		old_data =3D gve_xdp.xdp.data;
>  		xdp_act =3D bpf_prog_run_xdp(xprog, &gve_xdp.xdp);
>  		buf_state->page_info.pad +=3D gve_xdp.xdp.data - old_data;

[Severity: High]
This is a pre-existing issue, but does accumulating the XDP head adjustment
into buf_state->page_info.pad lead to out-of-bounds hardware DMA?

When XDP programs adjust the packet head, the difference is accumulated into
the pad. When the buffer is recycled, it appears the pad is never reset to
the default headroom.=20

Could this cause subsequent reuses of the buffer to continue accumulating
the offset and eventually calculate an out-of-bounds DMA address in
gve_alloc_buffer():

drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c:gve_alloc_buffer() {
    ...
    desc->buf_addr =3D cpu_to_le64(buf_state->addr +
                                 buf_state->page_info.page_offset +
                                 buf_state->page_info.pad);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722221634.1868=
86-1-joshwash@google.com?part=3D2
