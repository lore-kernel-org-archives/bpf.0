Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AF37D10F
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468206; cv=none; b=JQRGGBjTclc7tdM+2rKFbYlld2NjhgQDBWVsEgx/ioxEDHCul0ddH/ErdUiJG2jUPo0F4MVL//7KV6jFPS2BoyG4tPOFzvAf48jZsd4+dulTyTuv4djlG2SRYOWScy+v39ujG47GxjxAECxhfS7jdh3mO38TWgaOtBYRGkjgwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468206; c=relaxed/simple;
	bh=SKqtidt9BxHjS5faWF55Hq2ikLsdWP1uwz3B50Nx9WU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VjfrAH8lDspaOuEK0AL5H7Q/paOD+FYp3OD3M40S9TOxhZlCDW6rwV+kxM/YUwgzCIkHL5dmzMptRvDZpivtCdjT7/KjesAhWbQmhDfIGfdSNNlJqvhIsjgctRrwnQ5dg/NwPHoPHMNH1ZysiVdlfaKkDd0F/SnyDMZSeiDxsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+7iPY0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+7iPY0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C52C2BCB8;
	Wed, 29 Apr 2026 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468206;
	bh=SKqtidt9BxHjS5faWF55Hq2ikLsdWP1uwz3B50Nx9WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D+7iPY0XUQZX+dEr2qIWRQ1KpP5UNPvgLwt7/ozmqbqorIqSX3/QxOueKe+HfA9n9
	 mwZACxfhp4lREy1YUvLcqq9YBKyr7puRgRC4mObi3LZTyrvHuSlu2N9TxSRNT9rSw0
	 jnuSWxSfPgYa6PQMsN4PImYchPenpH7wIo+RLdY6lJ4Za+fxW7P0etObw7qpY30g4N
	 eZXevXRhmz8mqyw5OfHhiZZurB5cfgqSOhxBulGAYQGlaKix9YBaUaB/zErVmM+A8A
	 IV/1kp3Ypz6H+a02Z+a6TlG623gcsJbR59PsToRD6qLi6yMS5uCEgsi1tv0sYlIc3H
	 Jdofdo3SjgnJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 09/13] net: lan966x: add PCIe FDMA support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-lan966x-pci-fdma-v2-9-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-9-d3ec66e06202@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:10:05 +0000
Message-Id: <20260429131006.12C52C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Use-After-Free of `skb` in the RX path due to `skb_vlan_untag` fre=
eing the buffer.
- [High] Prematurely exiting the NAPI poll loop on errors causes permanent =
RX queue stalls.
- [High] Unvalidated hardware-provided `data_len` in the RX path leads to o=
ut-of-bounds reads and kernel panics.
- [High] Unchecked access to potentially NULL `lan966x->ports[src_port]` in=
 the RX path.
- [Medium] Missing DMA memory barriers (`dma_wmb()` / `dma_rmb()`) leading =
to potential data corruption on TX and RX.
--

Note: The format of this review has been altered to use a free-form summary
rather than inline quoting due to recitation restrictions.

commit 1dd886c56293690d145dbdf9f5bbd880c45747cf
Author: Daniel Machon <daniel.machon@microchip.com>
Subject: net: lan966x: add PCIe FDMA support

This commit adds PCIe FDMA support for lan966x, utilizing contiguous DMA
buffers mapped through the endpoint's ATU with memcpy-based frame transfers
instead of per-page DMA mappings.

I have a few questions about potential regressions introduced by this patch.

When lan966x_fdma_pci_rx_get_frame() calls lan966x_hw_offload() with the skb
passed by value, and lan966x_hw_offload() calls skb_vlan_untag(), could this
result in a use-after-free if skb_share_check() frees the original skb? The
caller continues to use the old pointer to update statistics and offload
marks.

In lan966x_fdma_pci_napi_poll(), if an individual frame has an error or
napi_alloc_skb() fails, the code jumps to the allocate_new label outside the
while loop. Does this prematurely exit the polling loop and leave remaining
completed frames unprocessed, potentially causing a permanent RX stall since
hardware interrupts won't re-trigger?

Is it safe to unconditionally trust the data_len extracted from the hardware
descriptor in lan966x_fdma_pci_rx_get_frame()? If a corrupted descriptor
returns a length larger than the mapped db_size, could this cause an
out-of-bounds read during the memcpy?

Furthermore, if the length from the descriptor is smaller than IFH_LEN_BYTES
or ETH_FCS_LEN, could the subsequent skb_pull() and skb_trim() operations
underflow and cause panics when the networking stack processes a wildly
oversized packet?

In lan966x_fdma_pci_rx_get_frame(), the code assigns the skb dev directly
from lan966x->ports[src_port]->dev. Since ports can fail to probe or be
intentionally disabled (which is explicitly checked for in functions like
lan966x_fdma_wakeup_netdev()), could a malformed IFH with an uninitialized
port index cause a NULL pointer dereference here?

The PCIe FDMA datapath uses contiguous coherent memory for descriptors and
frames, but operations like lan966x_fdma_pci_xmit() and
lan966x_fdma_pci_napi_poll() seem to lack dma_wmb() and dma_rmb() barriers.
Could weakly-ordered CPUs reorder the payload copies and descriptor status
updates, leading to the hardware transmitting uninitialized memory or the
CPU reading incomplete frames?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-lan966x-pc=
i-fdma-v2-0-d3ec66e06202@microchip.com?part=3D9
