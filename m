Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703210;
	b=PReeHNmvpcuJLDFhRnJgEZNvenTcJy3T0fC/CMcXnKLXECuE6eKcfg1P6SBYb35MEybG
	 ybnhC1A2bY+PR5C619jLisJVhTb1Jtxts2vpxBgoRSHUNdV8RGvVZNEGEbQ3nsn7qSfzw
	 3MTYDCGpjOSUe/1QoqXzeZo5UWhXcnAZ9AG23Cm8rJrNbFSwJy7ad33u6qBFa6MjXhwX/
	 OCcib5dlXniFcaUAFg0QfnHdxSlDHdzyrhjG/HbMHIPdP7G6uBshhCUIpYt+hP1J2hq83
	 BDpqMv+y1AwRFT22Mg3JDnoHm21ZXU+wMJdGkuXUOaCg+c+RCe1VLrirQK/EgsV+G4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703210;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qr2V+qHU2UOD6fHIZYRQn7qc2o8VFoSQ9/JvWaW4Sns=;
	b=EvZG0UOHgm4YvDa3vrwgwM5Hbc9VtoXeqSwT9Nk3EuHuX7Z4OX1y+KojtjGeEn2ps1pv
	 mZUwnq4MgoCWaqAv+6UxB6U5xd048lWHxnvzqe7XZ5R0BFqin6+xxYbv32Xv88tNpcitp
	 upoenBgkAl4o8irI4RSauRrH+lI76ts1z5tWsSe8gsCCw4LZ4dZEcAE/+qizLso4crtFu
	 SyHyXMmeRxf6YQijwmKoLv+KzSr7knisGDQZy6FUrJm+eUAqdWFoeRyYDJeVJPRl+3Z40
	 cc0vfKhi8D0sKy3t/be8N2EyV08kLmSovNAZeNzGzjAtzfDUqm/8llMjcG4XNcQZ5Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2pme1Sa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2675606BA56
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2pme1Sa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CB1F000C1;
	Tue,  3 Nov 2026 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703209;
	bh=Qr2V+qHU2UOD6fHIZYRQn7qc2o8VFoSQ9/JvWaW4Sns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2pme1Saigz5xM05W/qjk8RHMacnp5EQlxtdFCy3bhW2mQGRq1hIM9RIMUy+qayQs
	 YtlMZq2bjWR8HEodnV7Nndj/hSGLEfsv0vT4OUdx8nt7KZ3MrELAUo7LpCv8agGapX
	 LLkj7Zs4MoRK4Uboz9fuNRZdPGlr2hgOtAF7j1uV6JY3dRe8q19EggANi6M7pus2QS
	 OHANOruOJfWEwBSynk/3GCUFOTUWcZF9ZzMTeXgnPziIZJhshFitAXF4oVp4fUCv6C
	 tymoP6ZQuj0uu6MMMsBcdKA60S1fxWxd092b55LW3lI/6fGVnQxa2bmhFBa2DKZWbR
	 a9054x7uZtwsQ==
Message-ID: <sashiko-outbox-195079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] igb: do not let XDP frames span more than
 one Rx buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
 <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
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
- [High] igb: XDP attach and detach fail at default 1500 MTU in igb_xdp_set=
up()
--

commit 61b7cd576e8dfdc92f82c2f3538eaf2928658b79
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: do not let XDP frames span more than one Rx buffer

This commit limits the maximum receive packet length in RLPML and VMOLR to
adapter->max_frame_size while XDP is enabled so received frames cannot span
multiple Rx buffers. It also accounts for the 16-byte inline Rx timestamp
header (IGB_TS_HDR_LEN) when checking if the frame size fits in igb_rx_bufs=
z()
during XDP setup and MTU changes.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index ce91dda00ec0e..5bf489cd7b066 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2894,11 +2894,13 @@ static int igb_xdp_setup(struct net_device *dev, =
struct netdev_bpf *bpf)
>  	bool running =3D netif_running(dev);
>  	bool need_reset;
> =20
> -	/* verify igb ring attributes are sufficient for XDP */
> +	/* verify igb ring attributes are sufficient for XDP, leaving room
> +	 * for the inline Rx timestamp header
> +	 */
>  	for (i =3D 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring =3D adapter->rx_ring[i];
> =20
> -		if (frame_size > igb_rx_bufsz(ring)) {
> +		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
>  			NL_SET_ERR_MSG_MOD(bpf->extack,
>  					   "The RX buffer size is too small for the frame size");
>  			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame si=
ze %d\n",
> [ ... ]
> @@ -6713,7 +6725,7 @@ static int igb_change_mtu(struct net_device *netdev=
, int new_mtu)
>  		for (i =3D 0; i < adapter->num_rx_queues; i++) {
>  			struct igb_ring *ring =3D adapter->rx_ring[i];
> =20
> -			if (max_frame > igb_rx_bufsz(ring)) {
> +			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
>  				netdev_warn(adapter->netdev,
>  					    "Requested MTU size is not supported with XDP. Max frame size i=
s %d\n",
>  					    max_frame);

[Severity: High]
Does adding IGB_TS_HDR_LEN to the igb_rx_bufsz(ring) check in
igb_xdp_setup() and igb_change_mtu() break XDP at the default MTU of 1500
on systems with PAGE_SIZE < 8192?

In drivers/net/ethernet/intel/igb/igb.h, the constants are:

    IGB_ETH_PKT_HDR_PAD =3D ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2) =3D 26
    IGB_TS_HDR_LEN =3D 16
    IGB_MAX_FRAME_BUILD_SKB =3D IGB_RXBUFFER_1536 - NET_IP_ALIGN (1536 or 1=
534)

At the default MTU of 1500, frame_size (and adapter->max_frame_size) is
1500 + 26 =3D 1526. When the interface is opened via
igb_open() -> igb_configure() -> igb_configure_rx() -> igb_set_rx_buffer_le=
n():

    set_ring_build_skb_enabled(rx_ring);

#if (PAGE_SIZE < 8192)
    if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
        IGB_2K_TOO_SMALL_WITH_PADDING ||
        rd32(E1000_RCTL) & E1000_RCTL_SBP)
            set_ring_uses_large_buffer(rx_ring);
#endif

Because 1526 <=3D IGB_MAX_FRAME_BUILD_SKB, ring_uses_large_buffer(ring) is
not set while ring_uses_build_skb(ring) is set, so igb_rx_bufsz(ring)
returns IGB_MAX_FRAME_BUILD_SKB (1536 or 1534):

static inline unsigned int igb_rx_bufsz(struct igb_ring *ring)
{
#if (PAGE_SIZE < 8192)
    if (ring_uses_large_buffer(ring))
            return IGB_RXBUFFER_3072;

    if (ring_uses_build_skb(ring))
            return IGB_MAX_FRAME_BUILD_SKB;
#endif
    return IGB_RXBUFFER_2048;
}

When igb_xdp_setup() or igb_change_mtu() then checks:

    if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring))

1526 + 16 =3D 1542 > 1536, causing XDP attach at MTU 1500 to fail with
-EINVAL on a running interface.

Furthermore, because igb_xdp_setup() runs this check even when bpf->prog is
NULL, if an XDP program was attached while the interface was down (when
ring->flags is 0 and igb_rx_bufsz(ring) returns 2048) and the interface is
then brought up at MTU 1500, subsequent attempts to detach or replace the
XDP program at MTU 1500 will also fail with -EINVAL.

Also, in 2 KiB build_skb mode, igb_skb_pad() computes the buffer offset as
SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048) - IGB_MAX_FRAME_BUILD_SKB, leaving
only IGB_MAX_FRAME_BUILD_SKB (1536) bytes before skb_shared_info. If a
1526-byte frame arrives with a 16-byte inline timestamp, wouldn't the 1542
bytes written by the DMA engine overflow into skb_shared_info unless 3 KiB
buffers are selected or IGB_MAX_FRAME_BUILD_SKB accounts for
IGB_TS_HDR_LEN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-igb-rx-ts-=
fix-v4-0-8785124c5d23@aweta.nl?part=3D1
