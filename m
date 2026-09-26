Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342382BEFF6
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382963; cv=none; b=DuVNiq0Xe2lcbqfXLStnOTdsGkUktVwoIbMwuS1sHhStu69KKUdZ5BrkTeGBSxgdr0hEST3CCAAL7e0uZmp8WyHxqXvHmO2xhr8ubn/WFz+QVf8RFwv+FjZQ27c9elKS8zyoNkGaSZhn765MK/hw5z5Q+mop9O8ZYa7Ly/o3IVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382963; c=relaxed/simple;
	bh=LcahgrFuLBqBYr+xi+Qb3d6YTVU0Ebz+L2R16TDILI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dXuPGjXHyMohXF50p7cgPX0O2lho2GESCNR2Iw25Voi7ag38xXuXxgK5GonCxzqsmyApeX0/QigoFZABMi5xDwxbm0T/1j4+DvxAJEi0qZHEN4N6rm2a1f8bAZB7CDddMckgprOzz6VRFftp6Clltb0L3QK/EOwWGbXsqBeEeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb9aaVbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb9aaVbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A21F00893;
	Sat, 26 Sep 2026 00:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382962;
	bh=3qp+kzXdqkjBSHKPqLt/b9EvAibzHBaFDQlryuxy/oM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wb9aaVbTraknEKDTFRXr+XIvcL7YyfMhl0slOok13CtVsxAI3MRMxnXvYPwX01Uxl
	 3zYalElGKKupj3ht1DjgjzDmdIFpvyRZ/dGmChSep4jD1UTOTUbs1uQQfJGzwkehYe
	 G+1C76pN47Mswuq1zG0rJut7uK+vjzuVNPCqDR9bhfBJJPjBzeI/DvS4/pEHmgleip
	 j0eECUROCg9AB0rV8n+sFLOjj7C7lVeDY+xgESmU4slTvtM+mKg+G2PuER5vDzSoX8
	 P3WiRVc88zPoCZpoPxgJX03Yiwj/341soJg1chICNYUyvpC0b334RXrh0oWILwIbu7
	 V1ouLTa6nJi8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/8] eth: mpnic: implement Tx queue
 allocation and cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-linux-mpnic-v2-4-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
 <20260924-linux-mpnic-v2-4-4badc9b58b9e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:36:01 +0000
Message-Id: <20260926003601.C37A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] net: mpnic: trusting DMA parameters from device-accessible ring
- [High] net: mpnic: missing bounds check on hardware completion head cause=
s NULL deref
- [High] net: mpnic: integer underflow in desc_cnt causes massive out-of-bo=
unds unmaps
- [High] net: mpnic: missing memory barrier before completion queue doorbell
--

commit 92d64496d6b2ec052301fad8882b705af9c36a85
Author: Daniel Zahka <daniel.zahka@gmail.com>

    eth: mpnic: implement Tx queue allocation and cleanup

This commit introduces the allocation and cleanup of the Tx queues for the =
mpnic driver. It sets up triads of work and completion queues per NAPI vect=
or, along with their descriptor memory, interrupts, and completion processi=
ng.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index 0000000000000..853976e11b032
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

[Severity: Critical]
Does this code rely on untrusted DMA parameters?

The descriptor ring memory is device-accessible. If a malicious or buggy
PCIe device overwrites the address and length fields after submission, it
could trick the host into unmapping arbitrary kernel or IOMMU memory. Should
the driver store DMA mapping state in host-only software memory instead?

> +
> +static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
> +{
> +	u64 raw_twd =3D le64_to_cpu(*twd);
> +
> +	dma_unmap_page(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
> +		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
> +}

[Severity: Critical]
Similar to mpnic_unmap_single_twd(), does this code safely handle potential=
ly
spoofed DMA parameters from the hardware ring?

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
Is it possible for hw_head to be spoofed by the device, causing an
out-of-bounds access?

If the completion queue reports an out-of-bounds hw_head, clean_desc might
cover unpopulated slots in the ring buffer. This would result in accessing
ring->tx_buf[head] which is NULL, leading to a NULL pointer dereference when
accessing MPNIC_XMIT_CB(skb)->desc_count. Should the number of completed
descriptors be validated against the number of pending descriptors?

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

[Severity: High]
Can desc_cnt underflow here if desc_cnt is less than 2?

If the completion head is advanced by a malicious device to cover a packet
currently being built (where desc_cnt might be 0), the unconditional double
decrement will underflow desc_cnt to a massive unsigned value. This would
cause the subsequent loop to execute millions of times with out-of-bounds
ring indices and out-of-bounds DMA unmaps.

> +			mpnic_unmap_page_twd(nv->dev, &ring->desc[head]);
> +			head++;
> +			head &=3D ring->size_mask;
> +		}
> +
> +		total_bytes +=3D MPNIC_XMIT_CB(skb)->bytecount;
> +		total_packets++;
> +
> +		napi_consume_skb(skb, napi_budget);
> +	}
[ ... ]
> +static void mpnic_commit_cq_head(struct mpnic_ring *cmpl)
> +{
> +	u32 head =3D cmpl->head;
> +
> +	/* The tail shadows the last value written to the doorbell, so a
> +	 * completion queue which has not moved costs no MMIO write.
> +	 */
> +	if (cmpl->tail !=3D head) {
> +		cmpl->tail =3D head;
> +		writeq(head & cmpl->size_mask, cmpl->doorbell);
> +	}
> +}

[Severity: High]
Does this MMIO write to the doorbell require a memory barrier to guarantee
prior descriptor reads are complete?

On weakly ordered architectures like ARM64, writeq() only provides a
Store-Store barrier (wmb()). Without a read-store barrier (like rmb() or
dma_rmb()), prior memory loads could be reordered after the doorbell write,
potentially allowing the hardware to overwrite descriptors while the CPU is
still reading them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-linux-mpni=
c-v2-0-4badc9b58b9e@gmail.com?part=3D4
