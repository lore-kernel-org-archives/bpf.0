Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC539099B
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837767; cv=none; b=YYhHmd852UNdcUNxU74W9D+80eqHRc0jZ66o/U0ktKijfwUcKwHxeYMUOJtiTQDzgnwZsB3+3TymVffeGzcTJtBljAbDkPJb+FZDhS1YsKZAyRd9eNr1iOhKbE4Xmwbr0ao0Ka4N41KQ6qMjC5gRzUZxIhBIYnlEHjqohMEkvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837767; c=relaxed/simple;
	bh=+C0jmk1ruvCSJ4SUVbXGSxBiyDYYl4NNk9LGyDgq7mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aj1ssKq7BP7fQnqDNuCkLKmSc8IwYO5KcQ2ioyAfEMDQjUzRPnedq1UQO30VkjVyzaX5nNbAzxa5V2JSgc/VThiLmcrKOFGkPaIbFd+z5KlFGctxWp6SMBpgC85Xj856vRxohvQymfGU99EAz1VzYocYCy8PWzlXXGd3sEVWfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9DpfEqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9DpfEqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE61F00A3A;
	Sat, 15 Aug 2026 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837766;
	bh=ds8WPpJ5aOBUkhNQC3sbjTQmtChMoCXwpJ4m16E7yK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9DpfEqrjqscLH04oXAzKaoqIMAs082zhPwxBPG0qL1b0ooJTb7R5h+aEaB+ZPLQW
	 nYUygqUGSVclIAu4vsN0l7fScCkDenjc1sV4GvG+rOiGaL2pL83FwINiwCz4u+YpX5
	 PpHX3g/2yWxeDpqYE/55mr37OhYwuSHXHHFeQEtTRFQ/3rqiiYXNU0ZG/7emPwOooA
	 yvlh5lrcFLIjDTgmc0/LX+BQebRlenA/nBamqwlv+IEt7JkaH2QIx+kVQsWZ+olVWm
	 kLIu8V1HLeVDZbHivNVR0ZcyJjwuakxwI7C8rmJsRPMcZ5PlnDQ/mPMZpXyP0kMnAQ
	 yghmXqO2/Icbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/6] gve: fix XSK buffer leak when rings are stopped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814234845.773189-3-joshwash@google.com>
References: <20260814234845.773189-1-joshwash@google.com>
 <20260814234845.773189-3-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:49:25 +0000
Message-Id: <20260815234926.25BE61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] XSK buffers are permanently leaked during runtime when the receive=
d packet descriptor indicates an rx_error.
- [High] Calling `dev_consume_skb_any()` on an XDP frame and incorrectly un=
mapping DMA for AF_XDP zero-copy buffers during pending packet cleanup.
- [Medium] AF_XDP (XSK) TX buffers are permanently leaked from the user-spa=
ce application when the TX queue is stopped.
--

--- Patch [2]: [PATCH net 2/6] gve: fix XSK buffer leak when rings are stop=
ped ---
commit 68d9940f45b02ca459717266e19904c11302ff2d
Author: Joshua Washington <joshwash@google.com>

gve: fix XSK buffer leak when rings are stopped
   =20
GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.
   =20
Free XSK buffers attached to an allocated buf_state when stopping rings.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index db38bc6452969..2c1ce23d15508 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *p=
riv, int idx)
>  				gve_free_to_page_pool(rx, bs, false);
>  			else
>  				gve_free_qpl_page_dqo(bs);
> +
> +			if (gve_buf_state_is_allocated(rx, bs) &&
> +			    bs->xsk_buff) {
> +				xsk_buff_free(bs->xsk_buff);
> +				bs->xsk_buff =3D NULL;
> +			}

[Severity: High]
This is a pre-existing issue, but does this cleanup loop miss leaked XSK
buffers if they were previously freed due to an rx_error?

When a packet is received with compl_desc->rx_error set (such as a CRC erro=
r),
gve_rx_dqo() calls gve_free_buffer() before checking for the XSK buffer:

drivers/net/ethernet/google/gve/gve_rx_dqo.c:gve_rx_dqo() {
    ...
    if (unlikely(compl_desc->rx_error)) {
        gve_free_buffer(rx, buf_state);
        return -EINVAL;
    }
    ...
}

gve_free_buffer() returns the buffer state to the free list without calling
xsk_buff_free(), leaving bs->xsk_buff still set.=20

Since this cleanup loop checks gve_buf_state_is_allocated(), which evaluates
to false for buffers in the free list, will it completely skip these leaked
buffers?

>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while looking at queue stop
cleanups, is there a type confusion issue when cleaning up pending TX packe=
ts?

During interface down or MTU changes, gve_tx_clean_pending_packets() and
remove_miss_completions() iterate over pending TX packets and unconditional=
ly
treat them as SKBs:

drivers/net/ethernet/google/gve/gve_tx_dqo.c:gve_tx_clean_pending_packets()=
 {
    ...
    gve_unmap_packet(tx->dev, cur_state);

    if (cur_state->skb) {
        dev_consume_skb_any(cur_state->skb);
        cur_state->skb =3D NULL;
    }
    ...
}

struct gve_tx_pending_packet_dqo uses a union for skb and xdpf. If the pack=
et
is an XDP frame, cur_state->skb will evaluate to true, passing the XDP frame
to dev_consume_skb_any(). Can this cause a crash?

Additionally, for AF_XDP (XSK) packets, gve_xsk_tx_dqo() does not initialize
dma[0] because XSK uses pre-mapped DMA. Will the unconditional call to
gve_unmap_packet() pass uninitialized or stale dma[0] values to
dma_unmap_single() and corrupt DMA mappings?

[Severity: Medium]
This is a pre-existing issue, but do AF_XDP TX buffers get permanently leak=
ed
from the userspace application when the TX ring is stopped?

The gve_tx_clean_pending_packets() loop traverses and discards all pending
packets:

drivers/net/ethernet/google/gve/gve_tx_dqo.c:gve_tx_clean_pending_packets()=
 {
    ...
    for (i =3D 0; i < tx->dqo.num_pending_packets; i++) {
        struct gve_tx_pending_packet_dqo *cur_state =3D
            &tx->dqo.pending_packets[i];
    ...
}

Unlike the normal completion path in gve_tx_process_xsk_completions(), this
cleanup path doesn't appear to call xsk_tx_completed() for XSK packets befo=
re
dropping them.=20

Since the pending packets array is zeroed and freed shortly after, are these
buffers lost permanently from the perspective of the AF_XDP socket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814234845.7731=
89-1-joshwash@google.com?part=3D2
