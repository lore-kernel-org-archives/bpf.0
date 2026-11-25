Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614115;
	b=tBw4iu+6tcdgJSdwOAGTw3XlMjEFbB0H72BwVDhUAezz6Ub/W5BZHph/60lXDxbU6TNG
	 cmdYuMjq4iQ8cAIpT3Xei6kXIyMpEmCODeK2XBObpWKfrunwa8PjIiX3FRueDK8+HHeiZ
	 5eAKxEdByBUCR2ViEU3JbAiHaBLh0Q4yIv/xHjK9A2rN/vQ3aNfhhRdPNeLMdt0CdMSJn
	 W6NeO0NCM4Gl1KWCcTDacm7EHkk9XtWXhpEJK0xv1CFTyuzhONR5tGyieLMDOsE0h4XkG
	 FM/aIELNXaDD1AwFq+RX8UEuK5SUqhECvrSgC+bQp6Mh7Mqx9RAtdWC1SRUiJ/uXxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KlLzNAVDXKHkT7t8/IGZPiFqPxiYiACpkcm3Z5phyN8=;
	b=GoMv3ZIEYCt07pmV2iYcVq6IgQWVSjTKV3CTk1NCmLkojElNRuV2EdhZ6mkfqg87ZTUF
	 zONhsgUSaHWwNbyb7LQR5GZ3qnzGHhlBaO27ydjl/u8Qc3h3MWfFDAfHt+e+iBtFbxG+3
	 6SzJULgw7iGrMvBKQlSmxsmui4RoIKRX2av51nhIGTmLqtaE3DIUBAo2oBoAbUhssPcuA
	 fVEVOGMKhDhnTjZ5kNQafggVj1oyqRBhJ6kGT/gW7l6YIyf8gsP9QniY4q9llal6SdWa7
	 oEvZBp/+AXoUcqiKK8AFIet7Ua3isEnan9wMFzwhFlFKg6dS8IFi28uv1OKERrCcqyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENDJyjOr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C87606A332
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENDJyjOr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F991F000C4;
	Wed, 25 Nov 2026 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795614115;
	bh=KlLzNAVDXKHkT7t8/IGZPiFqPxiYiACpkcm3Z5phyN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENDJyjOr0Lk+ILBxJ/lnHg432yAYVR/C1upxipTX2CjO+hgvpmOcR5CfyZ4AJ6Qwc
	 qjoYw3JZ4D7uyWGM2l1h0udXOGgwoFMpzMVHNti8dOeyZi9LEL16KlaTcRzVH0IYG5
	 IRmh7VyK8QVofMBKVuBOdSziIDnMlOUJFE6CRa3y8GRkyFnDzz+Omsppdpk80domxl
	 z6vP1o8YtUna8+AXTZR2iy+56gK+Qo8zcZ99P+Rb80cLurgXruA0dNwZ4BfgXvsN1Z
	 ylr+QswFaSXD7Wpmxn3aPe0r+VSRifHj3KDkQj7jc3WE1iHINUAInWdpysNZNRAwIn
	 pKV6lymUqXRpw==
Message-ID: <sashiko-outbox-233496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] bonding: check XDP support before enslaving
 changes state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
References: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:41:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bonding: bond_xdp_xmit() checks ndo_xdp_xmit instead of
  xdp_features
- [Low] bonding: missing Fixes trailer for NULL ndo_xdp_xmit dereference
  fix
--

commit 4e12b56c05de5cd18169514e7abb34d8e38f9fd6
Author: Hangbin Liu <hangbin.liu@linux.dev>

> bonding: check XDP support before enslaving changes state
>
> The XDP capability checks in bond_enslave() - ndo_bpf/ndo_xdp_xmit
> presence and the slave XDP program count - run only after the slave
> has been opened, linked and published to the datapath. On failure the
> slave may already be bond->curr_active_slave or reachable through
> bond->slave_cnt and the upper device list, so a lot of state has to be
> undone, and bond_xdp_xmit() can observe the slave before its
> capability was ever verified.
>
> Move both checks to the validation section at the top of
> bond_enslave(), before the first state change, so a rejected slave
> returns directly with nothing mutated. The dev_xdp_propagate() setup
> stays in place and still uses the err_dec_slave_cnt error path.
>
> Moving the checks alone is not enough. Without a bond xdp_prog they
> are skipped, and a slave without ndo_xdp_xmit can be enslaved while
> the bond still advertises NETDEV_XDP_ACT_NDO_XMIT built from the
> other slaves. __xdp_enqueue() then accepts frames and the bulk-queue
> flush hands them to bond_xdp_xmit(), which may pick the new slave and
> call a NULL ndo_xdp_xmit in softirq context.
>
> Check the selected slave in bond_xdp_xmit() and fail the frame with
> -ENXIO instead. The check happens at xmit time, so it also covers
> frames enqueued before bond_xdp_set_features() clears the flag, and
> the bulk-queue flush path that never rechecks xdp_features.
>
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

[Severity: Low]
Since this fixes a NULL ndo_xdp_xmit dereference and the enslavement check
ordering from the original bonding XDP support, should it include a Fixes:
tag?

  Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver=
")

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 776afdb9df43e..0149bd7764e7c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
[ ... ]
> @@ -5681,7 +5680,7 @@ static int bond_xdp_xmit(struct net_device *bond_de=
v,
>  		xdp_convert_frame_to_buff(frame, &xdp);
> =20
>  		slave_dev =3D bond_xdp_get_xmit_slave(bond_dev, &xdp);
> -		if (!slave_dev) {
> +		if (!slave_dev || unlikely(!slave_dev->netdev_ops->ndo_xdp_xmit)) {
>  			err =3D -ENXIO;
>  			break;
>  		}

[Severity: High]
Should bond_xdp_xmit() check slave_dev->xdp_features for
NETDEV_XDP_ACT_NDO_XMIT (and NETDEV_XDP_ACT_NDO_XMIT_SG when
xdp_frame_has_frags(frame) is true), mirroring __xdp_enqueue(), instead of
only checking whether ndo_xdp_xmit is non-NULL?

Many drivers (such as gve and mvpp2) always set a non-NULL .ndo_xdp_xmit
pointer in their static net_device_ops and only enable
NETDEV_XDP_ACT_NDO_XMIT in dev->xdp_features when XDP TX queues are
allocated.  Because bond_enslave() publishes new_slave to the TX selection
paths before dev_xdp_propagate() and bond_xdp_set_features() run,
bond_xdp_xmit() can pick a newly enslaved device whose ndo_xdp_xmit pointer
is non-NULL while its XDP queues are uninitialized:

drivers/net/ethernet/google/gve/gve_tx_dqo.c:gve_xdp_xmit_dqo() {
	...
	qid =3D gve_xdp_tx_queue_id(priv,
				  smp_processor_id() % priv->tx_cfg.num_xdp_queues);
	...
}

In gve, priv->tx_cfg.num_xdp_queues is 0 when NETDEV_XDP_ACT_NDO_XMIT is
unset, causing a divide-by-zero panic in softirq context.  Similarly, a
multi-buffer frame enqueued while existing slaves advertised
NETDEV_XDP_ACT_NDO_XMIT_SG can be handed to a newly enslaved slave that only
supports linear XDP xmit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-bond_xdp_f=
ix-v1-1-e67983924324@kylinos.cn?part=3D1
