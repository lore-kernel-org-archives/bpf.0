Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F239794E
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837769; cv=none; b=kAkHTS8JU8HYAKWGbp8iZHhuod4U1pIQ6FgD3H3w+weBRMOLVnIj59GgNGHDk1biQHnst5voBd1M1HMClrgI5AjO7aS4Qy2oiJTQ4cnhIYYCiOJ9PjYU2tjKjriEhqV8P2rV+Adn3pddNrgVjG9eED4mF1st0ZMYvZP3vDS3WkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837769; c=relaxed/simple;
	bh=Zh8u5vIw/WGoumqQSKwEPD7WQ8Xd1ctgS0c0k40yop4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g3mGpOaI42PNNzhftaPipHQy7ZuI3M9l88eVb9Dy5SqL41P8Dcy9DincMXhQB9d3C8lAhpnv1lt3oGN1ZbFpacDpvoRpIKG9I/kfWLSNa7YJJmN4O8ciAzXfWT2j1W4l/Bd0FKUskMnsyv6jt9MpUnIvDXsHL+235zfy3dR+/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy7UOxGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy7UOxGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21A11F00A3E;
	Sat, 15 Aug 2026 23:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837768;
	bh=23UlLtJgd4Mb65QTz0UCEVgmxAine9JyS/6MQuAS+zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qy7UOxGTJmfH1XtR4HKiKB6BW+1pEaCGap26Grs8TtbT0hFYAzHY9geCCS5JwLHhJ
	 mEgYEcs7xVfUtkTz1rK7CzEJ1bJPCNrZHXRuTawNb108gMVqZTHl+WVxG8CHe3Mzkb
	 xILcIOaB+uDi3r4pXEeOONQK1rWiebdtfw/1gDF+5aRd8vcpk+dKHLw1izcuyVCIFf
	 4r8cr8xns8KT6pTDc/Lp32nO9LWPa0lfO5wOx2Po/0rZSi7DcdbTAdns2NnnIbe8Uz
	 M0Q4QK2WyYc5FokAISMiWf8hkKQxsQENnRF+kxNHkjiLtvkbh2biGnAbSFS9TBFtgA
	 3u2jvE8WYitLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/6] gve: fix XSK buffer leak on error descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814234845.773189-4-joshwash@google.com>
References: <20260814234845.773189-1-joshwash@google.com>
 <20260814234845.773189-4-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:49:27 +0000
Message-Id: <20260815234927.C21A11F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Fragment desynchronization resulting in truncated or malformed=
 packets being incorrectly pushed to the network stack upon intermediate de=
scriptor errors.
- [High] Massive unmitigated leak of AF_XDP zero-copy buffers (`xsk_buff`) =
and XDP frames (`xdpf`) on XDP_TX and XDP_REDIRECT paths.
- [High] `gve_rx_xsk_dqo` unconditionally overwrites `rx->ctx.skb_head` on =
multi-fragment XDP sequences, causing leaks.
- [High] The driver inherently trusts the `packet_len` provided by the devi=
ce DMA completion descriptor without verifying it against the allocated buf=
fer size.
- [High] Missing bounds check on `compl_desc->header_len` allows out-of-bou=
nds reads from the header buffer array.
--

--- Patch [3]: [PATCH net 3/6] gve: fix XSK buffer leak on error descriptor=
 ---
commit 92aa7b2aab7b9d9aa0aed8717f991d9e6e5c13b2
Author: Joshua Washington <joshwash@google.com>

gve: fix XSK buffer leak on error descriptor

When the error bit is set in the RX completion descriptor, the buf_state
and its attached buffer should be freed. In the case of AF_XDP ZC, the
XSK buffer was not freed, leading to a leak.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for A=
F_XDP zero-copy")
Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 2c1ce23d15508..811db42d05c67 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -845,7 +845,12 @@ static int gve_rx_dqo(struct napi_struct *napi, stru=
ct gve_rx_ring *rx,
>  	}
> =20
>  	if (unlikely(compl_desc->rx_error)) {
> -		gve_free_buffer(rx, buf_state);
> +		if (buf_state->xsk_buff) {
> +			xsk_buff_free(buf_state->xsk_buff);
> +			gve_free_buf_state(rx, buf_state);
> +		} else {
> +			gve_free_buffer(rx, buf_state);
> +		}
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue, but does the driver verify the length fields
provided by the device DMA completion descriptor?

In gve_rx_dqo(), the driver reads packet_len and header_len directly from
the untrusted descriptor:

        buf_len =3D compl_desc->packet_len;
        hdr_len =3D compl_desc->header_len;

It then uses hdr_len to copy data:

        rx->ctx.skb_head =3D
                gve_rx_copy_data(priv->dev, napi,
                                 rx->dqo.hdr_bufs.data + offset,
                                 hdr_len);

Could a buggy or malicious device supply a large header length (up to 1023
bytes), causing out-of-bounds memory reads from the header buffer array?
Similarly, could an unchecked packet_len result in out-of-bounds memory
reads being copied into SKBs and pushed to the network stack?

[Severity: High]
This isn't a bug introduced by this patch, but are there other paths where
AF_XDP zero-copy buffers or XDP frames can leak?

In drivers/net/ethernet/google/gve/gve_rx_dqo.c:gve_xsk_done_dqo(), the
XDP_REDIRECT failure path appears to fall through without freeing the
original xsk_buff:

        case XDP_REDIRECT:
                if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
                        goto err;

Also, in drivers/net/ethernet/google/gve/gve_tx_dqo.c:gve_xdp_xmit_one_dqo(=
),
the error path nullifies the packet frame without calling xdp_return_frame(=
):

err:
        pkt->xdpf =3D NULL;
        pkt->num_bufs =3D 0;
        gve_free_pending_packet(tx, pkt);
        return err;

Does this lead to resource exhaustion if XDP_TX or XDP_REDIRECT actions fai=
l?

[Severity: Critical]
This is a pre-existing issue, but does the RX poll loop correctly track
dropped packets across multiple descriptors?

In gve_rx_poll_dqo(), an error causes the skb to be freed:

        if (err < 0) {
                gve_rx_free_skb(napi, rx);

However, if this was the first or intermediate descriptor of a multi-fragme=
nt
packet, there doesn't seem to be a flag (like rx->ctx.drop_pkt) to ignore
the remaining descriptors. As a result, when the next fragment is processed=
 in
gve_rx_dqo(), a new skb is allocated:

        rx->ctx.skb_head =3D napi_get_frags(napi);

Could this fragment desynchronization allow subsequent fragments of the same
packet to be parsed as the start of an entirely new packet?

[Severity: High]
This isn't a bug introduced by this patch, but does gve_rx_xsk_dqo() leak
skbs on multi-fragment XDP sequences?

If a multi-fragment packet arrives while AF_XDP zero-copy is active,
gve_rx_xsk_dqo() unconditionally overwrites rx->ctx.skb_head:

        /* Copy the data to skb */
        rx->ctx.skb_head =3D gve_rx_copy_data(priv->dev, napi,
                                            xdp->data, buf_len);

Could this unconditionally overwrite the globally stored skb_head and
skb_tail without appending to or freeing the existing partial SKB,
causing a permanent leak of SKBs allocated for prior fragments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814234845.7731=
89-1-joshwash@google.com?part=3D3
