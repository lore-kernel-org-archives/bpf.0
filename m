Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD572D5412
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214275; cv=none; b=svQI+mE5M2sIdSWBiVkQTlupFfizygK9JhoGxXLW3M80cW61T58P3veSMd8nkIWKMFxRPdxlQkP1+1mnq40p9VJd2G1nV8uVFIC8h8FKWxf6cKEVxAlNzOile1kynsIQfEFhNCyd/tvEbiwcAYS4MKQzRdDHAB7ipOmwUeWUoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214275; c=relaxed/simple;
	bh=K/iVaKi9LgVkL1h6qTwY7ePdhbfMAVL/ey30klLhH6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IMA7Um0SIpAd4nQ8WhP/DqcfaUe5Ne3Zf/1S+p/ylBKbxpk2UBCxN30MBLYQUKF/YozpzN/+sD2Qly2MrJx/ZizM5MyxMvJOBp95B9+8QCp+aH6yXeLgArKad3x/s97ozfG8kI5Sidsk2t0YZUKT5kzP54irIsh230Tkgyg5yJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW5Cfq9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW5Cfq9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829931F000FF;
	Thu, 24 Sep 2026 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214273;
	bh=mr7+dFnisMGyi67TaqvVrox3zoLvYh4i4peaTM/ZywM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nW5Cfq9h5zrhucses6E9IAJSTuOOJFHQsAf6q3nLLxjn8R5BqRVQmszrIQln5vhVW
	 UgJuBP/CIJqxhVEao4APQxlDfRI5NVcRFpj6lJ2lxqljw0JQdFxS/HQU6M11rzTH4u
	 X3+VjJZFZeoCkR216FcT2rsKXg2hJuymEbEyQ9fG5T96JO1fsaLl6y/cBm+qdnm5NE
	 PYPMXqfEJdFWpCo2cWst8TDpKd2r4FZncoPvIKG5oO5GxvIss8KeU6Tqp31xmbyuLp
	 oKAETB+zhwWCpBohgYRJvXE9LytZUxcXYLK2nuZIwer8eX+C2lnwGxVG6AOhgXc0Pq
	 kAR3tbo1kF/HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/8] eth: mpnic: implement Tx queue allocation
 and cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-linux-mpnic-v1-4-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
 <20260922-linux-mpnic-v1-4-236844f53072@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:44:33 +0000
Message-Id: <20260924014433.829931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] eth: mpnic: TOCTOU IOMMU bypass when unmapping Tx descriptors
- [High] eth: mpnic: missing bounds check on hardware completion head
--

commit 154e61c52ca2706a8f945c1575f31b7f328f5529
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: implement Tx queue allocation and cleanup

Queues come in triads of two work queues and one completion queue. The
Tx triad only uses the first work queue for now, the second one will be
used for the XDP ring later.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index 0000000000000..fe360a26a27be 100644
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
[ ... ]
> +static void mpnic_unmap_single_twd(struct device *dev, __le64 *twd)
> +{
> +	u64 raw_twd =3D le64_to_cpu(*twd);
> +
> +	dma_unmap_single(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
> +			 FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
> +}
> +
> +static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
> +{
> +	u64 raw_twd =3D le64_to_cpu(*twd);
> +
> +	dma_unmap_page(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
> +		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
> +}

[Severity: Critical]
Can a malicious PCIe device corrupt host memory by rewriting these descript=
ors?

During Tx completion, the DMA address and length are read directly from the
device-accessible descriptor ring in mpnic_clean_twq0() and passed to
dma_unmap_single() and dma_unmap_page() here. Because the descriptor memory
is coherent DMA memory, the device could change the addresses between
submission and completion, bypassing IOMMU protections.

Could we store the DMA metadata in host-private memory (like the tx_buf
array) instead of reading it back from the ring?

> +
> +static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budg=
et,
> +			     struct mpnic_ring *ring, bool discard,
> +			     unsigned int hw_head)
> +{
> +	u64 total_bytes =3D 0, total_packets =3D 0;
> +	unsigned int head =3D ring->head;
> +	struct netdev_queue *txq;
> +	unsigned int clean_desc;
> +
> +	clean_desc =3D (hw_head - head) & ring->size_mask;
> +
> +	while (clean_desc) {
> +		struct sk_buff *skb =3D ring->tx_buf[head];
> +		unsigned int desc_cnt;
> +
> +		desc_cnt =3D MPNIC_XMIT_CB(skb)->desc_count;

[Severity: High]
Is it possible for a malfunctioning or malicious device to cause a NULL poi=
nter
dereference here?

The loop boundary clean_desc is calculated from the untrusted hw_head witho=
ut
validating it against the software-maintained tail that tracks actually
submitted descriptors. If the hardware reports an out-of-bounds hw_head, the
loop will access unpopulated slots in ring->tx_buf, returning a NULL skb th=
at
gets immediately dereferenced.

> +		if (desc_cnt > clean_desc)
> +			break;
> +
> +		ring->tx_buf[head] =3D NULL;
> +
> +		clean_desc -=3D desc_cnt;
> +
> +		/* Step over the metadata descriptor */
> +		head++;
> +		head &=3D ring->size_mask;
> +		desc_cnt--;
> +
> +		mpnic_unmap_single_twd(nv->dev, &ring->desc[head]);
> +		head++;
> +		head &=3D ring->size_mask;
> +		desc_cnt--;
> +
> +		while (desc_cnt--) {
> +			mpnic_unmap_page_twd(nv->dev, &ring->desc[head]);
> +			head++;
> +			head &=3D ring->size_mask;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-linux-mpni=
c-v1-0-236844f53072@gmail.com?part=3D4
