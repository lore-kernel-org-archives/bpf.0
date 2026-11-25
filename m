Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570690;
	b=zayn+QhZBMBGxVqIrfmYRTwgyzI9qYfyCiWe6KwbLWKMqxYwZsqUHw05S9zHd//CPlq7
	 m52Cfi6QnVCluu+oUqQI58x0SvEmplnU1b23vTrMmXLnXZTJYSVDHMvRIiz4LZTtwKu1S
	 XTp0mPjRxjuLIHh+PHbU/4GIOUsVdrit4vPf0tPSerfX79Y0nRiHXa3YvdsJ0FyaEKAcj
	 X0nQuq3TL+VouPKTlb3JfgA9n5iePF7m65N7zqNiMFcLuVqe+wdKQkm1SlT96cbo2WJ7L
	 PXiCBxVeGYkAyvxCviqDexYr9375HbmS1zS8uTpwcMpn9EIFpfKHSS3ZjgO0WFtNhHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570690;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/i4jNdS1y5p3R3vSDLsBxb1ySs5NP+dCuDhMtJTNlqs=;
	b=SgWR+gYtFRFuuxQj7RSryhRsNYOYrFM0bmpbX2msRqPQIqMxp6rekRK+COV16nrAcp+b
	 eLyvrg/OqzwAeigij3w2wL+H9sTUZluFOOa26SdbfFlX8xOp5RdYUewgsoGCupBMzRT48
	 kPGdCrdRQTtOmRtqqwxK+WJ/NfRr5sbgOMJ0xWZWPK4xJ8talbiTtcILeyisMxHiP4det
	 jPUmw4E0dFHpsgJw4gtkrAJo8/gdnPk/vC2TkSWGEzorkpbQ/7GHQBnYyc4Cpaz/IIAae
	 on3z3WNRCkxPNEqVKvn97wiwJjD+CPOofMLJ+SdemuRUXSI69IkQxOYImaXCT95rNig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUOKGAh8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F025606A31E;
	Wed, 25 Nov 2026 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUOKGAh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C621F000C6;
	Wed, 25 Nov 2026 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795570689;
	bh=/i4jNdS1y5p3R3vSDLsBxb1ySs5NP+dCuDhMtJTNlqs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kUOKGAh8l/KAFUNWyQrKSsmQsU5/wiBnVMWq7tCCQrQ1RNWNl3dsHK4WquJ/Rzg78
	 iahk5s+iSvj1Q00iJtc9XsjwSv3gCyL0KR+70Dg7RrVuch4PiPR1mtIF1wdFhy8oy6
	 8DzeiJXdQ8rJQRPnDb+VZla9K5yrA01RtP3o7ps1lIQUN1k1miZaw7khbV5eL06yHY
	 sTeGkj7r2grUauDXeHHv3b+iQaGv9O6vSwZeAbK55pHIEtbNplousCGwVuBoQPnE21
	 qEHVOQt33tc/2FzgOpYMMAucQ5YlINnfzvEy41YpXN3SjwmxlHzmqLK2gcvHzdop/4
	 bAdX4j5k9jwlg==
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, paul.greenwalt@intel.com, alice.michael@intel.com,
 eric.joyner@intel.com, jbrandeb@kernel.org, lorenzo@kernel.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com, tianyi.gao@linux.dev
Date: Wed, 25 Nov 2026 01:38:08 +0000
Message-ID: <179557068810.3135.17964087549504688357@kernel.org>
In-Reply-To: <20261121012402.84848-1-tianyi@cloudflare.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On E830 with an XDP program attached, ice_rx_csum()
  (drivers/net/ethernet/intel/ice/ice_txrx_lib.c) now skips ice_rx_gcs()…
- [Low] ice_rx_csum() decides whether to use GCS/CHECKSUM_COMPLETE by
  reading ring->xdp_prog again with `!READ_ONCE(ring->xdp_prog)`…

--

ice: do not report CHECKSUM_COMPLETE when an XDP program is attached

This patch stops ice_rx_csum() from using the E830 generic checksum (GCS)
to report CHECKSUM_COMPLETE when the rx ring has an XDP program attached,
because an XDP_PASS program may have modified the frame. Such packets now
take the L3L4P/XSUM_* descriptor status path, as on E810.

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d1..ad22d855436eb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
>  	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
>  
>  	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
> +	    !READ_ONCE(ring->xdp_prog) &&

[Severity: Medium]
With an XDP program attached, E830 packets now go to the L3L4P/XSUM_*
status path further down in ice_rx_csum(). Can that path mark a modified
packet CHECKSUM_UNNECESSARY based on how the hardware parsed the original
frame?

ice_rx_csum() runs after XDP has already run:

ice_clean_rx_irq()
    ice_run_xdp()             /* returns XDP_PASS */
    ice_process_skb_fields()
        ice_rx_csum()

The same thing happens in ice_clean_rx_irq_zc() via ice_run_xdp_zc().

Take the load balancer case from the commit message. The program strips
a UDP encapsulation with bpf_xdp_adjust_head() and returns XDP_PASS.

If the outer UDP port is not a configured VXLAN/GENEVE port, the parser
does not treat the frame as a tunnel. The L4 status bits then describe
only the outer UDP checksum. A zero outer UDP checksum over IPv4 ends up
here:

	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
		skb->csum_level = 1;

	skb->ip_summed = CHECKSUM_UNNECESSARY;

After decapsulation, the outermost L4 header is the inner TCP/UDP header.
The stack skips that checksum, and nothing has verified it. If the parser
did recognise the tunnel, csum_level = 1 is applied to a packet that is
no longer tunnelled.

Before this patch, the stale CHECKSUM_COMPLETE value made the stack
recompute the checksum in software. Good packets passed with a
netdev_rx_csum_fault() warning, and corrupted ones were dropped.

The commit message says:

    E830 also sets the L3L4P and checksum error bits, so the packet gets
    CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810.

E810 already behaves this way, and so does mlx5, where
MLX5E_RQ_STATE_NO_CSUM_COMPLETE leads to csum_unnecessary. On E830,
though, corrupted packets on these rings used to be caught in software.

Would CHECKSUM_NONE be a safer fallback here until the pending XDP
checksum hint series land? If not, could the commit message describe
this trade-off?

[Severity: Low]
Should this use the per-poll snapshot instead of reading ring->xdp_prog
a second time? The program that actually ran comes from:

ice_clean_rx_irq():
	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
	...
	xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);

ice_clean_rx_irq_zc() takes the same kind of snapshot for
ice_run_xdp_zc(). Neither function passes the snapshot to
ice_process_skb_fields().

The commit message already mentions the window this opens.
ice_prepare_for_reset() sets ICE_VSI_REBUILD_PENDING before calling
ice_pf_dis_all_vsi(). ice_dis_vsi() then has to take rtnl_lock before
ice_vsi_close() can stop NAPI. An XDP detach that holds rtnl during that
window gets here:

ice_xdp_setup_prog():
	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
		ice_vsi_assign_bpf_prog(vsi, prog);
		return 0;
	}

ice_vsi_assign_bpf_prog() writes NULL to rx_ring->xdp_prog while NAPI
is still running. Suppose a poll runs the old program on a packet and
gets XDP_PASS. ice_rx_csum() then reads NULL here and reports the stale
GCS value as CHECKSUM_COMPLETE.

Both callers of ice_process_skb_fields() already know whether a program
ran. Would passing that down close this window and also save a
per-packet load?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121012402.84848-1-tianyi%40cloudflare.com
