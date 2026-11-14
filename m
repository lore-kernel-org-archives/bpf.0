Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615392;
	b=Md81zYC/Vp/dHFvAgfhIOZwiXTxBe89HIsnGDbmqVkUuwiVim8bfhnSHejjNNaL2ROEx
	 g3QVqwC3k6VnHLX6ipUIGrzBxkRATcUF4x8ZizZf518OGG/svVEw4NPK7P09FUQPxD6/I
	 KP9Z5fLBQNxGajPwQOFebTSleIjPzlMB8IDp2HPItnyF4d4QkGpK3iI+IVBnpKeihtl0t
	 7RzW+g5BhsGs8nTSXpnwDnfZEmCJhRRVSwzoU54Pnkzmi/A2Bouf9YeBbK6EyNFuLAq7Z
	 qvGZg6juJW1WLtfT2kg8qeWA4BvHRYxTrS+o6BCvGc1MOnZJ4ohw0SOAemjZx5Z+H0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615392;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Guk0aJMCD2cOZJhykYYMTeDOfM6tQhjRyfXxpDWH01I=;
	b=upWD3+FxpJvHjCR03zBPqTuTz4gIVr6xIvub7AM794Kgc0+vmto1eYcyCDpg2qmxf6/o
	 mnL7dRYWESIEss3iab5BlseLjzgZtiFPQHalwEU2h01+ZI+CqYYQtBpvedoE77OZlF6Q6
	 5vcmB6b+2qeQQphm8CDEJYO/MZyXa5hzzrQz/tM3ncWxQ8RgYd8BfKtVmTXoM5yhwvNmN
	 9X1h8awB9GI8QvNjr0zaBteza5C69PVIhdYKoNKggDzXfcM4KiNPck2TqHs+pOJH2Vl2N
	 W5RQPS/PJD6nmgg4H9b4XjPlnB3/LtlZnVKHlau8cVmOw1DKmtwn2RN/oJN4T9Fx3oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKkgEkh3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3D606A33D;
	Sat, 14 Nov 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKkgEkh3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE491F000C4;
	Sat, 14 Nov 2026 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615391;
	bh=Guk0aJMCD2cOZJhykYYMTeDOfM6tQhjRyfXxpDWH01I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iKkgEkh3nvdGULC2ZH+VcEtVMwdO+VZ+VnYroH3Q+w1lRH8EiUx402lll70mN6Gfm
	 zJkLi3ycoK/tsL46xyXOqMR/e2H94PCOO734dfUwwWEpT4jTv6bDfAt6pth1/SK1u3
	 TkkiUsTuPn0bU8sN41QYFi2u1ft7e/6+TZIE1mLmP/R+AI44v0n6sRoRHBZ1bheKke
	 0pFQhdpd13uSFMHAbqsSyav7VmAL8GVaNZhd07As4jNjMLar8r6VsH5cZkIZ/KNKUd
	 Le+cXA3JjWxxPMJGjK0qfbqOmjtD/e9HmsVdG7v91NW5elgkAJsIz6VttARL2WR6kj
	 EMeFD2jVQU3AA==
Date: Fri, 13 Nov 2026 16:16:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jv@jvosburgh.net, haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: record XDP programs propagated to
 lower devices
Message-ID: <20261113161629.23d3d67a@kernel.org>
In-Reply-To: <179461399614.2199510.14192155072084970014@kernel.org>
References: <20261112235027.4072149-4-kuba@kernel.org>
	<179461399614.2199510.14192155072084970014@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 23:53:16 +0000 netdev-bot+sashiko@kernel.org wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 69ee4342f43ee..3a520c798d4a8 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -9326,6 +9326,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
> >  
> >  	__netdev_adjacent_dev_unlink_neighbour(dev, upper_dev);
> >  
> > +	if (changeupper_info.master)
> > +		dev->xdp_from_upper = 0;
> > +
> >  	call_netdevice_notifiers_info(NETDEV_CHANGEUPPER,
> >  				      &changeupper_info.info);
> >    
> 
> [Severity: Medium]
> The commit message says that clearing the flag here lets the device own a
> leftover program "rather than leave it with nobody allowed to remove it".
> Can a lower end up with xdp_from_upper set when no master link was ever
> created, so that this code never runs?
> 
> netvsc_register_vf() propagates netvsc's program before it joins:
> 
>     ret = netvsc_vf_setxdp(vf_netdev, prog);
>     ...
>     if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
>         ret = prog ? netvsc_vf_setxdp(vf_netdev, NULL) : 0;
>         if (ret)
>             netdev_warn(ndev,
>                         "failed to remove XDP program from VF %s: %d\n",
>                         vf_netdev->name, ret);
>         return NOTIFY_DONE;
>     }
> 
> The first call stores the program in vf_netdev->xdp_state[XDP_MODE_DRV]
> and sets xdp_from_upper. netvsc_vf_join() can fail in
> netdev_rx_handler_register() or in netdev_master_upper_dev_link(). Both
> failure paths return without a master link.
> 
> If the driver's ndo_bpf() then refuses the NULL program,
> netif_xdp_propagate() returns before it touches xdp_state[] or the flag:
> 
>     err = dev->netdev_ops->ndo_bpf(dev, bpf);
>     if (err)
>         return err;
> 
> netvsc returns NOTIFY_DONE without storing the VF in
> net_device_ctx->vf_netdev, so it never comes back to this VF. No master
> was linked, so __netdev_upper_dev_unlink() never clears the flag. Only
> dev_xdp_uninstall() at unregister does.
> 
> From then on, every IFLA_XDP set or remove and every BPF link attach on  
> the VF hits the new -EBUSY check in dev_xdp_attach(). netvsc's program
> keeps running on the VF. Before this patch xdp_state[] was empty in this
> case, so the user could attach a program and then detach it to clear
> things up.
> 
> The only way out seems to be linking the VF to some master and then
> unlinking it. Should the failed-join path, or netif_xdp_propagate(),
> handle this case?
> 
> bond_xdp_set() has a smaller version of the same problem. If the unwind
> call fails:
> 
>     err_unwind = dev_xdp_propagate(slave_dev, &xdp);
> 
> the slave keeps the new program with xdp_from_upper set, while
> bond->xdp_prog has been reset to old_prog. That slave can't be fixed
> directly until it is released from the bond.

I guess AI semi-randomly anchored this comment here, it's basically
saying that since netvsc is buggy the state may get out of sync.
Yes, as mentioned in the netvsc series I didn't manage to cover all
the error paths there. And also that's the reason why I added the
clearing of "from upper" on unlink, to make the bad state recoverable.

IOW patch is working as intended. We're going from "no safety checks"
to "some already buggy driver error path may fail to clean up".

> > @@ -10561,6 +10564,15 @@ u8 dev_xdp_prog_count(struct net_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
> >  
> > +/* Does the device have an XDP program, and was it installed directly on the
> > + * device rather than propagated down by an upper with netif_xdp_propagate()?
> > + */
> > +bool dev_xdp_has_own_prog(struct net_device *dev)
> > +{
> > +	return dev_xdp_prog_count(dev) && !dev->xdp_from_upper;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_xdp_has_own_prog);  
> 
> [Severity: Low]
> This isn't a bug, but does this comment still match what the function
> returns? It describes where the program came from. The new kernel-doc in
> include/linux/netdevice.h does too:
> 
>     @xdp_from_upper: the program in @xdp_state was installed by an
>         upper device with netif_xdp_propagate(); it belongs to the
>         upper and can't be replaced or removed through this device.
> 
> __netdev_upper_dev_unlink() clears xdp_from_upper on any master unlink.
> That includes the case where the upper's NULL propagate failed and
> bonding or netvsc only warned. After that, dev_xdp_has_own_prog() returns
> true for a program that an upper propagated.
> 
> Could both comments describe the flag as current ownership, including the
> hand-over on master unlink?

No, it's a failure mode / de-sync case. We shouldn't document it.

> > @@ -10773,6 +10816,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
> >  	}
> >  
> >  	mode = dev_xdp_mode(dev, flags);
> > +	if (dev->xdp_from_upper) {
> > +		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an upper device");
> > +		return -EBUSY;
> > +	}  
> 
> [Severity: Low]
> This check now runs before the existing loop that refuses an attach when
> an upper has a program:
> 
>     netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>         if (dev_xdp_prog_count(upper) > 0) {
>             NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>             return -EEXIST;
>         }
>     }
> 
> For a direct bond slave or a joined netvsc VF, the upper keeps its
> program in its own xdp_state[]. Attach, replace and detach on the lower
> were therefore already refused, with -EEXIST. They now fail with -EBUSY
> and a different extack message.
> 
> The commit message says dev_xdp_attach() reads the flag "to keep the
> program from being replaced or removed behind the upper's back". However,
> that protection is only new for nested lowers and for the netvsc window
> before the join.
> 
> Is the errno and message change for the common direct-lower case
> intended? If so, could the commit message mention it?

Intended / doesn't matter.
