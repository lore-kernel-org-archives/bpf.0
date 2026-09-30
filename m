Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDB38E5ED;
	Wed, 30 Sep 2026 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743100; cv=none; b=sOOIt/+F0feedYwLEIc1LPjlFSRCLVh5wZXD33FXXS0qYlqJUlHeEOFhnuUkyAI3rgIJWAVODYLJS3eKCf4xMJsCBMsI5/xQuJ26KTQ8brHC5rVYOusIOS9BxfThiYkULXlMYCz+iYRgqT5jqY4xYSl7TJCssZ5Mdr+rFxSSq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743100; c=relaxed/simple;
	bh=Hl4nFr/Va+fR+63IuMlMpTP0/HB7OoF8GMNfxygWygA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ky5u3tYBeraEpd8pH62rMeFlVx4/qq7Gah2/ZADLQlktR7TXb7oUVZUwes8blQ2StC9FN3/TuNHD112oXsTgWbNeRXWzLJs79T7S1tZcgd2iv+jrrTQrXNKQp2zE8Ld/vKZWp5OEl4pr35gKPcRpXNNSdSyo/nDZ5fftBx17iJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgu2XD3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgu2XD3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F081F000FF;
	Wed, 30 Sep 2026 04:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743098;
	bh=GcbSLid+0kIeQoGJyodBytvXj4ILayJre5/BxDEOK9E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lgu2XD3MhJyZNEokLxt7RLvJsVprGevzKmj1l/oejBJIyeNl0IrVeqXqnYxuAL9dd
	 6ysa3+IJYyoV/XIP2SjvLQX+cWh8fAoOyQHF64Q7FUtF6/chkQNAaxodON2K10KY9c
	 6/a7jkLRsDSEl6FC0FA/3v3BoJK0NzaJtyZ5Sp6tCJArHMvDy0Xj5AYT2Nc3VyqpFF
	 v8YkmiWliaLjT5jOTlsYwnf3j2vkAkUQ7T3DMezgLpzbm16XkQNi6QiCfHUVVzMkn1
	 GU5Prt5dKZue2lzqtBmGmeoQvVV6DfMExXEDlT250qcbjUEcIqGzO+Mw0EAItp8bOO
	 uBSp0b7vMh8hQ==
Subject:
 Re: [PATCH net-next 5/5] net: drop GSO skbs instead of handing them to XDP
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, aleksander.lobakin@intel.com
Date: Wed, 30 Sep 2026 04:38:17 +0000
Message-ID: <179074309702.434549.6254450635863004021@kernel.org>
In-Reply-To: <20260928223648.2739371-6-kuba@kernel.org>
References: <20260928223648.2739371-6-kuba@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Regression in tun/tap with native XDP attached: guest and
  vnet_hdr TSO/USO traffic is now silently dropped.
- [Medium] netdevsim with XDP attached now drops TCP TSO traffic from its
  peer.
- [Medium] veth: explicitly dropped GSO packets bypass kfree_skb
  tracepoints
- [Low] The patch describes and fixes a user-visible bug: generic XDP is
  handed GRO-coalesced/GSO skbs, e.g. generic XDP on bond0 over GRO-…
- [Low] In the generic XDP path, the new GSO check sits in
  bpf_prog_run_generic_xdp(), which runs after…

--

net: drop GSO skbs instead of handing them to XDP

This commit adds xdp_skb_feature_check(). It drops GSO skbs, with a
ratelimited warning, before they can reach an XDP program. The check is
called from bpf_prog_run_generic_xdp() and veth_convert_skb_to_xdp_buff().
The motivation is stacked devices such as bonding, and generic XDP on veth,
where GRO-coalesced packets can still get to the program.

> These precautions are not 100% today, and IMHO fixing
> that is impossible. Let's explicitly drop GSO skbs on input to XDP.

[ ... ]

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[Severity: Low]
The commit message describes a bug that exists today: generic XDP on bond0
over GRO-enabled slaves, and generic XDP on veth. There is no Fixes: tag,
though. Should one be added if this is meant for net?

The change also affects callers that send GSO skbs to generic XDP on
purpose, such as tun and netdevsim. An origin reference would help stable
backporters decide where the change applies.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5c67e555f82d6..8c9dcb4126bd3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -5551,6 +5552,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	u32 metalen, act;
>  	int off;
>  
> +	if (unlikely(xdp_skb_feature_check(skb)))
> +		return XDP_DROP;
> +

[Severity: Medium]
Will anyone chasing lost packets be able to see this drop?

The new branch jumps to the existing drop label. That label frees the
skb with consume_skb() and sets *pskb to NULL. consume_skb() fires the
consume_skb tracepoint, not kfree_skb, so dropwatch, perf on
skb:kfree_skb and similar tools never see these packets.

The caller, veth_xdp_rcv_skb(), bumps stats->rx_drops and then calls
kfree_skb(skb) on its drop path. By then skb is already NULL, so that
call is a no-op and the drop is still reported as a normal consume.

The generic XDP call site behaves differently. There the XDP_DROP
returned by bpf_prog_run_generic_xdp() reaches the do_drop label in
netif_receive_generic_xdp(), which uses kfree_skb(). So the two callers
of xdp_skb_feature_check() report the same policy drop in two different
ways. Returning -ENOMEM is also misleading, since nothing failed to
allocate here.

The consume_skb() at the drop label predates this patch; it covers the
skb_pp_cow_data() failure. That is arguably an error path as well.
Would it make sense to free with kfree_skb_reason() for the GSO case?
A dedicated drop reason for GSO skbs reaching XDP could then be used by
both veth and the generic XDP path.

[Severity: High]
Does this break tun/tap when a native XDP program is attached?

tun sends packets whose virtio_net_hdr has a gso_type to the generic XDP
path on purpose, because its native XDP can't handle GSO:

drivers/net/tun.c:tun_build_skb() {
    ...
	if (hdr->gso_type || !xdp_prog) {
		*skb_xdp = 1;
		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
				       pad, metasize);
    ...
}

The comment in tun_get_user() documents this:

		/* For the packet that is not easy to be processed
		 * (e.g gso or jumbo packet), we will do it at after
		 * skb was created with generic XDP routine.
		 */

Once tun_vnet_hdr_tnl_to_skb() has set gso_size, the path becomes:

tun_get_user()
  do_xdp_generic()
    netif_receive_generic_xdp()
      bpf_prog_run_generic_xdp()
        xdp_skb_feature_check() -> XDP_DROP

The vhost-net batched path in tun_xdp_one() does the same:

	if (xdp_prog) {
		if (gso->gso_type) {
			skb_xdp = true;
			goto build;
		}
    ...
	if (skb_xdp) {
		ret = do_xdp_generic(xdp_prog, &skb);
		if (ret != XDP_PASS) {
			ret = 0;
			goto out;

tun treats any result other than XDP_PASS as consumed. tun_get_user()
returns total_len and tun_xdp_one() returns 0. QEMU or vhost therefore sees
success, but every guest TSO/USO frame is dropped. This happens even when
the program only returns XDP_PASS.

Unlike veth_xdp_set(), tun_xdp_set() does nothing to stop the writer from
producing GSO frames. Guest TX TSO is negotiated between the guest and the
VMM, so the admin has no receive offload to turn off. That makes the
"receive offloads are still on" warning misleading here.

The commit message says driver XDP "is not an issue", but tun's native XDP
depends on generic XDP for GSO frames. Would tun need its own handling,
such as segmenting or exempting these skbs?

[Severity: Medium]
Could this also blackhole TCP bulk traffic on netdevsim when XDP is
attached?

nsim_setup() advertises NETIF_F_TSO. nsim_start_xmit() only calls
skb_linearize() before forwarding the skb to the peer, so gso_size is
kept. The peer then runs its program through do_xdp_generic():

drivers/net/netdevsim/netdev.c:nsim_rcv() {
    ...
			if (skb->ip_summed == CHECKSUM_PARTIAL)
				skb_checksum_help(skb);
			ret = do_xdp_generic(xdp_prog, &skb);
			if (ret != XDP_PASS) {
				dev_dstats_rx_add(dev, skblen);
				continue;
    ...
}

netdevsim never clears TSO on the peer when XDP is installed. Every TSO
skb would now get XDP_DROP here and still be counted as received.

For CHECKSUM_PARTIAL GSO skbs, this combination already triggered
skb_warn_bad_offload() via skb_checksum_help() before this patch. The
existing ping.py TCP subtests only send a short string, so they are
unlikely to catch this.

[Severity: Low]
This isn't a bug, but should the check move to the top of
netif_receive_generic_xdp()?

GRO/GSO skbs are almost always nonlinear. By the time
bpf_prog_run_generic_xdp() runs, netif_receive_generic_xdp() has already
done this:

	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
		if (netif_skb_check_for_xdp(pskb, xdp_prog))
			goto do_drop;
	}

If the program lacks xdp_has_frags, or the page pool copy would be too
large, netif_skb_check_for_xdp() falls back to
pskb_expand_head(..., GFP_ATOMIC) plus skb_linearize(). That means a
high-order atomic allocation and a full copy of a 64KB (or BIG TCP sized)
aggregate, and the skb is then dropped right away.

The veth hunk already places the check before skb_pp_cow_data().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928223648.2739371-1-kuba%40kernel.org
