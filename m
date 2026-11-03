Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703210;
	b=4fTUOTKUGXgZm6QsqIt1GOt/mhtBk2JSJo6yL8nGH6e6R7eusyQHaqGV9jzamXTkWSIn
	 OD29KmWNkpCcw4f6H1ZTN7yUDNc9/zV+fxNWTPpU8at/k/3MFN0EsXSYMGEgxn9oYtWth
	 YZ8wUy54ZRGsf2k2XMq5RYhTqLxV4bQyui6ePb10mZUPKhIJI2BSIWAXWZRyOCho/Q0/9
	 VlnzazVkshppSyqCz31ozaV4EXhFIUtmsHgEtmU5gjXSXbnchQyD1VEDkw5huZFPaK7VS
	 xk/vVWLhr38nKNDjP1E3kODY+/7J9U98P3bng8MsEdBJI3hGUUCcAFiI6VpafHTGgQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703210;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uy8eIkiJKg3oRBVIjw8Q2X3xsmWMv209WoPw23/maKo=;
	b=sHsIYJVlFiafafP7GrloLYaBf44leU73qyc/bn0hcbACYyqQeR2S0GOTJn0f67MYAdh0
	 jN40bZ8S7yh7JcgkL2TiZPQ6WcvJVp4Mu0K3ep4Hvw92SujprVsZrSufCqNwmYi0BC6KZ
	 cM3ymabK6vZ2ovZE1SBQY4Mn4x5sOPsxONgFa0oMv/kve7nqN/idVYGeaPjPyhpPNiISo
	 aqHMDJu5mtLM5QgNU9vI3JffIbeywMuQdLNX3f6A8cMTBx/qk6d5MuL6pK31J4MKT9b8n
	 QLAuZSRnRwKfNFWCaqPEw6ZTTADk5Cuzn6TN/ZbX/N4brzqmskrm5mqWNe/6cmu7VKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSpLMQ82;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96789606BA5E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSpLMQ82
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C2F1F00919;
	Tue,  3 Nov 2026 10:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703210;
	bh=uy8eIkiJKg3oRBVIjw8Q2X3xsmWMv209WoPw23/maKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSpLMQ82v9lHFdiTjyXMcXTHfNHX3dhb92kOt/m3OBn2l5uxjdZfuWZUB1ojhg3+A
	 Y4WONi6kdRrY0r6lGP1d+7wcnfbHIj/t+vRycv2diSiSU9/W3fCeA5KWKvbgr4jjpI
	 WApLCgVcsCKxZE8foZ5sqmokZr3FlsZIQ51cxgz2RVfduZwLb+kcWhsoYiZPxfkLYl
	 KtofsaFfIje45BV8CcvMISab6hwJe/nA0ZAVsUcmACRDHyV82wMUFCwb42FQTS5eMR
	 nVrgbWcsUpAYhC0yH1iGPwZCKU8+IWeIaAsPcY8HdtXKtbRbebd1/WTPNI+N7appWn
	 uPiFh4s8Yk0ww==
Message-ID: <sashiko-outbox-195080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/2] igb: only strip Rx timestamp header on the
 first buffer of a frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
 <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:53:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] igb: XDP setup and MTU checks in igb_xdp_setup() reject default MT=
U 1500
--

commit e6fdd6185a160da19639b21242c6743c31579ab8
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: only strip Rx timestamp header on the first buffer of a frame

This commit guards the Rx hardware timestamp header strip in
igb_clean_rx_irq() with !skb so that continuation buffers of multi-buffer
frames do not have payload bytes stripped when their payload starts with 8
zero bytes. It relies on the preceding commit in the series to prevent
multi-buffer frames from reaching the XDP path.

Link: https://lore.kernel.org/all/20261028083344.3047350-2-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index 5bf489cd7b066..c4eb9f589fbe7 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9072,8 +9072,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q=
_vector, const int budget)
>  		rx_buffer =3D igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
> =20
> -		/* pull rx packet timestamp if available and valid */
> -		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +		/* pull rx packet timestamp if available and valid; it is only
> +		 * present on the first buffer of a frame
> +		 */
> +		if (!skb &&
> +		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {

[Severity: High]
Does the prerequisite buffer size check in the series break attaching and
detaching XDP programs at the default MTU of 1500 on systems with 4 KiB
pages?

When the interface is opened at the default MTU of 1500
(adapter->max_frame_size =3D 1526), igb_open() -> igb_configure() ->
igb_configure_rx() -> igb_set_rx_buffer_len() enables build_skb without
setting the 3 KiB buffer flag:

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_rx_buffer_len() {
	...
	set_ring_build_skb_enabled(rx_ring);

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
	    IGB_2K_TOO_SMALL_WITH_PADDING ||
	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
		set_ring_uses_large_buffer(rx_ring);
#endif
}

Because adapter->max_frame_size (1526) is not greater than
IGB_MAX_FRAME_BUILD_SKB (1536 - NET_IP_ALIGN, i.e. 1536 or 1534) and
IGB_2K_TOO_SMALL_WITH_PADDING is false with 4 KiB pages, igb_rx_bufsz()
returns IGB_MAX_FRAME_BUILD_SKB:

drivers/net/ethernet/intel/igb/igb.h:igb_rx_bufsz() {
#if (PAGE_SIZE < 8192)
	if (ring_uses_large_buffer(ring))
		return IGB_RXBUFFER_3072;

	if (ring_uses_build_skb(ring))
		return IGB_MAX_FRAME_BUILD_SKB;
#endif
	return IGB_RXBUFFER_2048;
}

However, igb_xdp_setup() checks whether frame_size + IGB_TS_HDR_LEN fits in
igb_rx_bufsz(ring):

drivers/net/ethernet/intel/igb/igb_main.c:igb_xdp_setup() {
	int i, frame_size =3D dev->mtu + IGB_ETH_PKT_HDR_PAD;
	...
	for (i =3D 0; i < adapter->num_rx_queues; i++) {
		struct igb_ring *ring =3D adapter->rx_ring[i];

		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
			...
			return -EINVAL;
		}
	}
}

At MTU 1500, frame_size + IGB_TS_HDR_LEN is 1526 + 16 =3D 1542, which excee=
ds
IGB_MAX_FRAME_BUILD_SKB (1536 or 1534) and causes igb_xdp_setup() to reject
attaching XDP with -EINVAL. In addition, because igb_xdp_setup() runs this
check even when bpf->prog is NULL, if an XDP program was attached before the
interface was first opened (when ring->flags is 0 and igb_rx_bufsz() returns
2048) or at MTU 3000 before lowering the MTU to 1500, detaching the XDP
program at MTU 1500 also fails with -EINVAL.

Similarly, igb_change_mtu() checks max_frame + IGB_TS_HDR_LEN against
igb_rx_bufsz(ring) using the current ring flags before adapter->max_frame_s=
ize
is updated and igb_set_rx_buffer_len() reconfigures the rings:

drivers/net/ethernet/intel/igb/igb_main.c:igb_change_mtu() {
	...
	if (igb_xdp_is_enabled(adapter)) {
		int i;

		for (i =3D 0; i < adapter->num_rx_queues; i++) {
			struct igb_ring *ring =3D adapter->rx_ring[i];

			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
				...
				return -EINVAL;
			}
		}
	}
}

If XDP is attached at MTU <=3D 1494 (where 1536-byte build_skb buffers are
used), raising the MTU to 1500..3030 is rejected even though MTUs above 1510
would switch the rings to 3072-byte buffers, whereas lowering the MTU from
3000 to 1500 succeeds and leaves XDP active on 1536-byte build_skb buffers
where it can no longer be detached.

Should igb_set_rx_buffer_len() account for IGB_TS_HDR_LEN (or select 3 KiB
buffers when needed for XDP/PTP), and should igb_xdp_setup() skip the frame
size check when detaching (bpf->prog =3D=3D NULL)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-igb-rx-ts-=
fix-v4-0-8785124c5d23@aweta.nl?part=3D2
