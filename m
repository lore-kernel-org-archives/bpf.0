Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3088BA45;
	Wed, 30 Sep 2026 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743094; cv=none; b=iTQanOZCsBepp5TwdX0q2rvtg4PeI12Rob6dWIvZY84Vu7NqlKeQ5fAXbU+Z2ICf/Y/tTAAm9c8F18EOw49kUdBD5S+S0YUHES3eFY9XBHYCjqq7UXtjbq/AhLmwT1TBW6EjFF43Ds+pODCkVpNEDg0/8oXlrE+Vf18dufetWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743094; c=relaxed/simple;
	bh=qEFP53f4btNmLv12NBiQeAMThArLvU+PP0Zmxeb/dCQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjVoQRNs2v3vZeysHHZOZ39zFLkko2z+4tR/YPp2icN1jr+N+Ss4wS61rdY+7cnMhXc0kJpTgpn8JVW8MPZ1ebzoIncIbVq72+pamDX/d0ANM9Hm+xttvzLNBxvbfL89191Tt0sFyTvAuTu9Sg/OaWuFyaE2bL1lzqjKfHKqfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW87jcJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW87jcJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC301F000FF;
	Wed, 30 Sep 2026 04:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743092;
	bh=5gV1EICpNcOtTm7YOIVswacCxk4MYPetAnJJhFdk5w8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nW87jcJwJHjGYcHI+ygHVHYxMi2J87yi0aVieCG9nBNm1D4uXaN1aKXhI9huWyfFJ
	 nwE25kCkydSpekPVd47DCEy2MaCd8G7a2DsP0Wmj1v26bUQk/0laSRuUegu1kIdgyj
	 kWq/R41MLU4AQpx4WknaC2DyLbNO6T2IrqvZbVtOW8oS0b+BlPyKfFkknpL/cwF1E9
	 +UVKCiNyAsh6bIP0+Ve+F9ZEKbbX7mqO/2fjYbwVqkVuk9HqjPR8U8XBOVfeDQy6gf
	 fJ/Epis4sb0huDCGwIj5JSfkZizrS1gOtJduyoqPEXJeUi9c0F03VuBAmA8WXjFzcF
	 rQrxTq4SefFyA==
Subject:
 Re: [PATCH net-next 1/5] net: record XDP programs propagated to lower devices
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, aleksander.lobakin@intel.com
Date: Wed, 30 Sep 2026 04:38:11 +0000
Message-ID: <179074309130.434549.12675673225689130710@kernel.org>
In-Reply-To: <20260928223648.2739371-2-kuba@kernel.org>
References: <20260928223648.2739371-2-kuba@kernel.org>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 2 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] A new -EBUSY refusal in netif_xdp_propagate()
  (net/core/dev.c:10415) causes a double bpf_prog_put through netvsc's…
- [Critical] netif_xdp_propagate() only refuses a device's own program
  when bpf->prog is non-NULL (net/core/dev.c:10415).
- [Medium] Only two things clear xdp_from_upper: a later
  netif_xdp_propagate() call and dev_xdp_uninstall() at unregister.
- [Medium] dev_xdp_install() treats any non-HW program in xdp_state[mode]
  as a registered XDP dispatcher user: `if (mode != XDP_MODE_HW)…
- [Medium] On netvsc's ndo_bpf path, netvsc_bpf() → netvsc_vf_setxdp() →
  netif_xdp_propagate(vf_netdev) runs with only RTNL held…
- [Low] The commit fixes user-visible bugs but has no Fixes: tag.
- [Low] The patch adds the bitfield `unsigned long xdp_from_upper:1` to
  struct net_device but does not add it to…
- [Low] netvsc_register_vf() ignores the return value of
  netvsc_vf_setxdp(vf_netdev, prog) and returns NOTIFY_OK.

--

net: record XDP programs propagated to lower devices

When an upper device pushes its XDP program down with
netif_xdp_propagate(), this commit records the program in the lower's
xdp_state[] and tags it with a new xdp_from_upper bit. Bonding and
dev_xdp_attach() use the bit to tell a lower's own program apart from the
upper's. netif_xdp_propagate() now also refuses to propagate onto a device
that has a program of its own.

> is refused by dev_xdp_sb_prog_count() for a device running a
> single-buffer XDP program, but not for a bond slave running the bond's,
> even though netif_xdp_propagate() would have refused to install that
> same program had header-data split been on already. Binding a memory
> provider has the same asymmetry.

[Severity: Low]

Should this have a Fixes: tag?

The one-directional HDS check on the propagate side came from commit
2d46e481a9af ("net: disallow setup single buffer XDP when tcp-data-split
is enabled."). The memory provider side dates to the devmem work, for
example commit 170aafe35cb9 ("netdev: support binding dma-buf to
netdevice").

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d037faff7c44b..512e3a21d0bda 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2517,6 +2517,12 @@ struct net_device {
>  	unsigned long		change_proto_down:1;
>  	unsigned long		netns_immutable:1;
>  	unsigned long		fcoe_mtu:1;
> +	/**
> +	 * @xdp_from_upper: the program in @xdp_state was installed by an
> +	 *	upper device with netif_xdp_propagate(); it belongs to the
> +	 *	upper and can't be replaced or removed through this device.
> +	 */
> +	unsigned long		xdp_from_upper:1;

[Severity: Low]

This isn't a bug, but should xdp_from_upper also be added to
Documentation/networking/net_cachelines/net_device.rst?

The comment at the top of struct net_device asks for that document to be
updated when fields are added. It already lists the neighbouring
change_proto_down, netns_immutable and fcoe_mtu bitfields.

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index a8eb382f40caf..5c67e555f82d6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10377,13 +10386,39 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)

[ ... ]

>  int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  {
> +	struct bpf_prog *old_prog;
> +	int err;
> +
>  	if (!dev->netdev_ops->ndo_bpf)
>  		return -EOPNOTSUPP;
>  
> +	/* we have more work to do for setup, bypass for other commands */
> +	if (bpf->command != XDP_SETUP_PROG)
> +		return dev->netdev_ops->ndo_bpf(dev, bpf);
> +
> +	if (bpf->prog && dev_xdp_has_own_prog(dev)) {
> +		NL_SET_ERR_MSG(bpf->extack,
> +			       "unable to propagate XDP to device with an XDP program of its own");
> +		return -EBUSY;
> +	}

[Severity: Critical]

Can this new -EBUSY cause a double bpf_prog_put() through netvsc's error
path?

The VF can easily have a program of its own. dev_xdp_attach() on the VF
only refuses when the upper already has one, and netvsc has none yet:

  ip link set dev $VF xdp obj q.o
  ip link set dev $NETVSC xdp obj p.o

The second command then goes roughly like this:

dev_change_xdp_fd(netvsc)            bpf_prog_get()
  dev_xdp_install()                  bpf_prog_inc()
    netvsc_bpf()
      netvsc_xdp_set(dev, prog)      bpf_prog_add(num_chn - 1)
      netvsc_vf_setxdp()             inc, then put on error
        netif_xdp_propagate()        returns -EBUSY
      netvsc_xdp_set(dev, NULL)      bpf_prog_put() num_chn times
  dev_xdp_install()                  bpf_prog_put() on error
dev_change_xdp_fd()                  bpf_prog_put() on error

The rollback in netvsc_bpf() drops all num_chn chan_table references. That
includes the one dev_xdp_install() moved into the driver:

drivers/net/hyperv/netvsc_bpf.c:netvsc_xdp_set() {
    ...
	if (old_prog)
		for (i = 0; i < nvdev->num_chn; i++)
			bpf_prog_put(old_prog);
    ...
}

Then dev_xdp_install() puts that same reference again:

	err = bpf_op(dev, &xdp);
	if (err) {
		if (prog)
			bpf_prog_put(prog);
		return err;
	}

Wouldn't this free the program while the user's fd still points at it?

The imbalance in netvsc's error path is older. Before this patch, though,
only the HDS, memory provider or driver failure refusals could reach it.
This refusal makes it reachable with two ordinary commands.

[Severity: Low]

Related to the above, netvsc_register_vf() ignores the return value of
netvsc_vf_setxdp():

drivers/net/hyperv/netvsc_drv.c:netvsc_register_vf() {
    ...
	prog = netvsc_xdp_get(netvsc_dev);
	netvsc_vf_setxdp(vf_netdev, prog);

	return NOTIFY_OK;
}

Suppose a VF with its own program joins netvsc while netvsc has a
different one. One way this happens is moving the VF into netvsc's netns,
which keeps XDP state. The new -EBUSY is then dropped without any message.
The VF keeps running its own program, and netvsc's program never applies
to VF traffic.

Should this failure at least be logged?

>  	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> -	    bpf->command == XDP_SETUP_PROG &&
>  	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {

[ ... ]

> @@ -10395,7 +10430,23 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  		return -EBUSY;
>  	}
>  
> -	return dev->netdev_ops->ndo_bpf(dev, bpf);
> +	err = dev->netdev_ops->ndo_bpf(dev, bpf);
> +	if (err)
> +		return err;
> +
> +	/* Record it like a program of our own, so that everything which asks
> +	 * whether XDP is running here gets the right answer. @xdp_from_upper
> +	 * keeps the two apart where it matters.
> +	 */
> +	old_prog = dev_xdp_prog(dev, XDP_MODE_DRV);
> +	if (bpf->prog)
> +		bpf_prog_inc(bpf->prog);
> +	dev_xdp_set_prog(dev, XDP_MODE_DRV, bpf->prog);

[Severity: Medium]

Does recording the upper's program here unbalance the XDP dispatcher
accounting?

dev_xdp_install() assumes every non-HW program in xdp_state[] was
registered with the dispatcher by this device:

	if (mode != XDP_MODE_HW)
		bpf_prog_change_xdp(dev_xdp_prog(dev, mode), prog);

Here the program goes into the lower's xdp_state[XDP_MODE_DRV] without a
matching bpf_prog_change_xdp(). Only the upper's own dev_xdp_install()
registered it.

In unregister_netdevice_many_notify(), dev_xdp_uninstall() runs before the
NETDEV_UNREGISTER notifier that makes bonding or netvsc release the lower.
So deleting an enslaved lower, for example with ip link del on a veth bond
slave, goes:

dev_xdp_uninstall(lower)
  dev_xdp_install(lower, XDP_MODE_DRV, ..., NULL)
    bpf_prog_change_xdp(upper_prog, NULL)
      bpf_dispatcher_remove_prog()

Won't this drop the dispatcher user that the bond added? The program would
lose its direct-call entry while the bond is still running it.

> +	dev->xdp_from_upper = !!bpf->prog;
> +	if (old_prog)
> +		bpf_prog_put(old_prog);

[Severity: Critical]

What happens here when bpf->prog is NULL and the lower has its own program
attached through a bpf_link?

The own-program check above is skipped for NULL requests:

	if (bpf->prog && dev_xdp_has_own_prog(dev)) {

In that case dev_xdp_prog() returns link->link.prog, and this block puts
it. That reference belongs to the link. dev_xdp_uninstall() follows this
rule and never puts a link's prog:

	link = dev_xdp_link(dev, mode);
	if (link)
		link->dev = NULL;
	else
		bpf_prog_put(prog);

dev_xdp_set_prog() also clears xdp_state[XDP_MODE_DRV].link here without
setting link->dev = NULL.

netvsc_register_vf() calls netvsc_vf_setxdp() unconditionally, with a NULL
program whenever netvsc has none. It runs from netvsc_probe() for existing
VFs (hv_netvsc reload) and from NETDEV_REGISTER after a netns move.
__dev_change_net_namespace() keeps XDP state. So a VF with a user-created
XDP link can get here. ndo_bpf() drops the driver's reference and this
bpf_prog_put() drops the link's.

Closing the link fd afterwards runs bpf_xdp_link_release().
dev_xdp_detach_link() returns -EINVAL and trips the WARN_ON, and
bpf_link_free() puts the already freed prog.

If the VF is unregistered first, dev_xdp_uninstall() never sees the link.
link->dev then points at a freed net_device, which later
bpf_xdp_link_release(), fill_link_info, show_fdinfo and
bpf_xdp_link_update() calls would use. bpf_xdp_link_update() would also
bypass the new xdp_from_upper check.

For a plain non-link program the refcounts balance, but the user's program
is still removed without any error. Doesn't that go against refusing to
override a device's own program?

[Severity: Medium]

Is anything serializing these new xdp_state[] and xdp_from_upper writes
against the memory provider bind path on netvsc's VF?

netvsc_bpf()->netvsc_vf_setxdp()->netif_xdp_propagate(vf_netdev) runs with
only RTNL held. netvsc_vf_setxdp() only does ASSERT_RTNL() and never takes
the VF's instance lock.

netif_xdp_propagate() otherwise expects the caller to hold that lock.
dev_xdp_propagate() takes netdev_lock_ops(), and
dev_get_min_mp_channel_count() asserts it.

The bind side, netdev_nl_bind_rx_doit()->__netif_mp_open_rxq(), holds only
the VF instance lock and reads the state this patch writes:

	if (dev_xdp_prog_count(dev)) {
		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
		return -EEXIST;
	}

With no common lock, a concurrent bind and netvsc XDP set could each pass
the other's check. Could that leave an ops-locked VF with both an XDP
program and a memory provider? The commit message says this patch now
prevents that combination.

The unlocked VF ndo_bpf() call from netvsc predates this patch.

> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(netif_xdp_propagate);

[ ... ]

> @@ -10567,6 +10605,11 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>  		NL_SET_ERR_MSG(extack, "XDP_FLAGS_REPLACE is not specified");
>  		return -EINVAL;
>  	}
> +	/* the program belongs to an upper device */
> +	if (dev->xdp_from_upper) {
> +		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an upper device");
> +		return -EBUSY;
> +	}

[Severity: Medium]

Can xdp_from_upper stay set after the upper is gone? If so, this check
would refuse every attach, replace and detach on the lower.

Only a later netif_xdp_propagate() or dev_xdp_uninstall() clears the bit.
netvsc_remove() clears XDP only on the synthetic device:

	netvsc_xdp_set(net, NULL, NULL, nvdev);

Then netvsc_unregister_vf() unlinks the VF without propagating NULL:

	netdev_rx_handler_unregister(vf_netdev);
	netdev_upper_dev_unlink(vf_netdev, ndev);
	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);

After rmmod hv_netvsc, a hot remove or an unbind, the VF still has
xdp_state[XDP_MODE_DRV] set with xdp_from_upper=1. It has no upper and its
driver keeps running the program.

This check then returns -EBUSY for every request, including prog=NULL,
until the VF is unregistered. Before this patch the user could attach a new
program and then detach it to clear the stale one.

Bonding can end up in the same state. In __bond_release_one(), a failed
dev_xdp_propagate(slave_dev, NULL) only warns, and the unlink still
happens:

	if (dev_xdp_propagate(slave_dev, &xdp))
		slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");

dev_xdp_has_own_prog() also returns false for such a device, so a future
upper would propagate over the orphaned program.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928223648.2739371-1-kuba%40kernel.org
