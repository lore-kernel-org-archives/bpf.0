Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251303033E6
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772014; cv=none; b=lLjC3c9DlJYCNoZ3vqn1vJSJEM6RwQPPmPDvR6qG/Vp2VDqQFdrIts465W+JHpSpC/JWK8Wprj+jfTL5WO5gn2jBDjrhahLHrGNB8pN3aqzLxIwPccOsnn3Zemyjcm1YVDjoDur9H3p0+KL1MGIOPz0KXheipOVFVP8mNxtcu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772014; c=relaxed/simple;
	bh=ouom49+jOKuKqaRS0tkeRpUDGnjB9bzuMPq3nQF/mlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/J29qy4412+WZyKuWepQsPZGS+n4pJq3vpywSCO4moaCWKAIF/n1ZLrigQKDvzuErACVly7FAX0gq6j2Yl8jUw03NH2T2zQ6iGu5UI09RjEikm1HNsLymDBncJS2qqXv/y+Ge0h4llvXPeXx6U8+shbfqEFdyMK1FZlIIqFk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kznpyH4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kznpyH4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4691F00A3A;
	Mon,  3 Aug 2026 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785772013;
	bh=KjSvkAj4mCThwtr6jf9b4LqRIhrrBrX8VHa1TCJPPFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kznpyH4RwAqRwvJE3pHwDKh8qYhMlA5w2jYYYRZw1whbF8ZSvSM0DxD+9E6bOUydf
	 p0riECmMMDJz9k/58cBB8cRtWWBFGxDq52n9dcxEuxJ8iELwCRl+un+p4d6m7DbeDv
	 zQoCeVV+BBQfaaMdmRdtuf1DT2RDv64ivzLqiKP93ltskbmbelXOLtZaynKKrEpJHb
	 77euCQarRRGILD0du28BGw8aMPGxoGnQgm0OhAQfrTzYBqKnIkETPIHM5bxqNxyhY5
	 V+UIq3/bHkeW6E49g1RFHnWnQW0V376gd2a+siW+4+I8v2S7mw/TRsukh8CHueK7XU
	 0kRK6QP25U47Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: atlantic: free RX pages of consumed but
 not refilled buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_607CBA8237DA438E36B844318B21538DE008@qq.com>
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
 <tencent_607CBA8237DA438E36B844318B21538DE008@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:46:52 +0000
Message-Id: <20260803154652.CD4691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Malformed or oversized RX descriptor chains cause a permanent NAPI=
 polling lockup or hard infinite loop.
--

--- Patch [2]: [PATCH net 2/2] net: atlantic: free RX pages of consumed but=
 not refilled buffers ---
commit f13d9fd8fe93327bbe27469851140df3b966b786
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: free RX pages of consumed but not refilled buffers

aq_ring_rx_deinit() only walks the region posted to hardware. Slots that
were consumed but not yet reposted sit in a gap with a live page, and the
deinit walk never visits them, causing a page and DMA mapping leak. This
patch walks the whole ring instead and releases whatever is still there.

Cc: stable@vger.kernel.org # v5.2+

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 81685a4dc5a6d..e1193c6719d9d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c

[ ... ]

> @@ -950,15 +950,29 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
> =20
>  void aq_ring_rx_deinit(struct aq_ring_s *self)
>  {

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the error handling in
__aq_ring_rx_clean() and __aq_ring_xdp_clean() cause a permanent NAPI polli=
ng
lockup or an infinite loop when processing malformed RX descriptors?

In __aq_ring_rx_clean(), if a descriptor chain is out of bounds or exceeds =
the=20
maximum fragment count, the function exits early without advancing sw_head:

drivers/net/ethernet/aquantia/atlantic/aq_ring.c:__aq_ring_rx_clean() {
    ...
                if (buff_->next >=3D self->size) {
                    err =3D -EIO;
                    goto err_exit;
                }
    ...
                if (unlikely(!is_rsc_completed) ||
                    frag_cnt > MAX_SKB_FRAGS) {
                    err =3D 0;
                    goto err_exit;
                }
    ...
}

Because sw_head is not advanced, wouldn't the next NAPI poll process the
exact same malformed descriptor again, resulting in an infinite NAPI polling
loop?

Additionally, in __aq_ring_xdp_clean(), there is a do-while loop that lacks=
 a
fragment count limit:

drivers/net/ethernet/aquantia/atlantic/aq_ring.c:__aq_ring_xdp_clean() {
    ...
            do {
                if (buff_->next >=3D rx_ring->size) {
                    err =3D -EIO;
                    goto err_exit;
                }
                next_ =3D buff_->next;
                buff_ =3D &rx_ring->buff_ring[next_];
                is_rsc_completed =3D
                    aq_ring_dx_in_range(rx_ring->sw_head,
                                next_,
                                rx_ring->hw_head);

                if (unlikely(!is_rsc_completed))
                    break;

                buff->is_error |=3D buff_->is_error;
                buff->is_cso_err |=3D buff_->is_cso_err;
            } while (!buff_->is_eop);
    ...
}

If the descriptor chain is cyclic and within the valid range, could this
cause a hard infinite loop inside the softirq handler?

Also, if the index is out of bounds in __aq_ring_xdp_clean(), it jumps to
err_exit without advancing sw_head. Could this cause the same NAPI poll sto=
rm
as in __aq_ring_rx_clean()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_29B86031792=
1D68DE77C718242DA418EB608@qq.com?part=3D2
