Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613997;
	b=FqDpfsGBUcDhtue7QWI50vXUTZK8FZNTKsznAaLNlNdWmx+q9Sy1JyY88bIoarLRod9e
	 2yMauVnWGv9O3Nud3kHZdpuQOo6RSvYl/fqpZzxpVlMBCSmX1PZ976fnFy9NMKNC4vY84
	 yNEiBC9NOKtHjAuE4ZzLVJH4GOo5i/k42DyJE5QZVXiN/ryMcK8OGGl1/FpjCdRF6mF1G
	 LtmohoUa25Gt5SqHlTFxxzkZjyYP/k338djuB9Z7Z3EluLjSITLktt0gEck6qCzt3J9nP
	 YDiysX31Ya8qQjsngn3ethR4TVifKKN+8+bwuCVZMViX3zbKxt47yaul/OYjMPijccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613997;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=h/mLbiKADvGR7z5YM9SFJJjqhyHQGjb51zVpQkm0VDw=;
	b=DfLLO7QOL1325tGa7sRoDBogb5xwwFgj2nx+FrVdH2LHPQyx5f7hg+fT1n6ntPxEhFC7
	 F4p/Xw80G4CSNoEKKJyc/E+Gx4K2fgi5/NRVepXd4sPOrw8njEHk0K283jqKu7SQf/O3d
	 AyS/ZhESBPNq51L2GuqzvsgpC1/Iv2O2iIDuEQNaVqLu8haEwjum2ZNANnkX+AbI8gbhO
	 PU0s5tpDAjpiIOfsLnkk5Lt1jY0Rgh10zVRh++biVp234mBRqwUiW5XbR9plq/p8ava4Z
	 RURB8+eHfiSmeTOzLP8oGuykbvGSaNtTzC1xtCmrIV9P+/sDZ5PaLqMsDrA5raGZcCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgQcoHvG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDA606A33B;
	Fri, 13 Nov 2026 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgQcoHvG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E171F000C4;
	Fri, 13 Nov 2026 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613997;
	bh=h/mLbiKADvGR7z5YM9SFJJjqhyHQGjb51zVpQkm0VDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EgQcoHvGnYl4z6SVsU2Y2s8g+Rde/TXX4R5fY4/GAKBZvQsswzfxy0r7s/MtVbBFA
	 aQOSVi2OT5NPVlP7fZ1h/qprjgklwPmoCEF08+BkfKdQvp4AWjgRVHhVCPNPvnbLAT
	 rQ1kSzoFxbl5XylTsBxO8DKODiz4A051+IbvJN6KEHP8SLBqFhljIQRhUaoKQ50Esr
	 yuhM3sNGYkg7IurcRmXtkDPnB/GWk0qOvmAyR4xHsWUWw0BGl2ue0vpedMButHPxOb
	 1bcq0n5pQoWzSp8MlaMTya8aEsSw+RC0tm05Xap7rX4mMXUFckARBHpu7Ly6yfgO0t
	 kbSIifCcoea+Q==
Subject:
 Re: [PATCH net-next 3/5] net: record XDP programs propagated to lower devices
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 23:53:16 +0000
Message-ID: <179461399614.2199510.14192155072084970014@kernel.org>
In-Reply-To: <20261112235027.4072149-4-kuba@kernel.org>
References: <20261112235027.4072149-4-kuba@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netvsc_register_vf() (drivers/net/hyperv/netvsc_drv.c) calls
  netvsc_vf_setxdp(vf_netdev, prog) before netvsc_vf_join() has created…
- [Low] The commit fixes a user-visible bug but has no Fixes: tag.
- [Low] dev_xdp_attach() in net/core/dev.c now checks dev->xdp_from_upper
  before the existing 'don't allow if an upper device already has a…
- [Low] The comment on dev_xdp_has_own_prog() in net/core/dev.c says it
  answers 'was it installed directly on the device rather than…

--

net: record XDP programs propagated to lower devices

This commit records XDP programs that an upper device propagates to its
lowers in the lower's xdp_state[], and marks them with a new
xdp_from_upper flag. It adds dev_xdp_has_own_prog() so bonding and netvsc
can tell a lower's own program apart from theirs, and refuses attach on a
lower while the flag is set. The flag is cleared when the master unlinks.

>   ethtool -G $slave tcp-data-split on
>
> is refused by dev_xdp_sb_prog_count() for a device running a
> single-buffer XDP program, but not for a bond slave running the bond's,
> even though netif_xdp_propagate() would have refused to install that
> same program had header-data split been on already. Binding a memory
> provider has the same asymmetry.

[Severity: Low]
This describes a user-visible bug, but there is no Fixes: tag. The
install-direction checks in netif_xdp_propagate() came from these
commits, and neither of them covered the reverse direction:

  2d46e481a9af ("net: disallow setup single buffer XDP when tcp-data-split is enabled.")
  170aafe35cb9 ("netdev: support binding dma-buf to netdevice")

Should the commit carry Fixes: tags for them?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 69ee4342f43ee..3a520c798d4a8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9326,6 +9326,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
>  
>  	__netdev_adjacent_dev_unlink_neighbour(dev, upper_dev);
>  
> +	if (changeupper_info.master)
> +		dev->xdp_from_upper = 0;
> +
>  	call_netdevice_notifiers_info(NETDEV_CHANGEUPPER,
>  				      &changeupper_info.info);
>  

[Severity: Medium]
The commit message says that clearing the flag here lets the device own a
leftover program "rather than leave it with nobody allowed to remove it".
Can a lower end up with xdp_from_upper set when no master link was ever
created, so that this code never runs?

netvsc_register_vf() propagates netvsc's program before it joins:

    ret = netvsc_vf_setxdp(vf_netdev, prog);
    ...
    if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
        ret = prog ? netvsc_vf_setxdp(vf_netdev, NULL) : 0;
        if (ret)
            netdev_warn(ndev,
                        "failed to remove XDP program from VF %s: %d\n",
                        vf_netdev->name, ret);
        return NOTIFY_DONE;
    }

The first call stores the program in vf_netdev->xdp_state[XDP_MODE_DRV]
and sets xdp_from_upper. netvsc_vf_join() can fail in
netdev_rx_handler_register() or in netdev_master_upper_dev_link(). Both
failure paths return without a master link.

If the driver's ndo_bpf() then refuses the NULL program,
netif_xdp_propagate() returns before it touches xdp_state[] or the flag:

    err = dev->netdev_ops->ndo_bpf(dev, bpf);
    if (err)
        return err;

netvsc returns NOTIFY_DONE without storing the VF in
net_device_ctx->vf_netdev, so it never comes back to this VF. No master
was linked, so __netdev_upper_dev_unlink() never clears the flag. Only
dev_xdp_uninstall() at unregister does.

>From then on, every IFLA_XDP set or remove and every BPF link attach on
the VF hits the new -EBUSY check in dev_xdp_attach(). netvsc's program
keeps running on the VF. Before this patch xdp_state[] was empty in this
case, so the user could attach a program and then detach it to clear
things up.

The only way out seems to be linking the VF to some master and then
unlinking it. Should the failed-join path, or netif_xdp_propagate(),
handle this case?

bond_xdp_set() has a smaller version of the same problem. If the unwind
call fails:

    err_unwind = dev_xdp_propagate(slave_dev, &xdp);

the slave keeps the new program with xdp_from_upper set, while
bond->xdp_prog has been reset to old_prog. That slave can't be fixed
directly until it is released from the bond.

> @@ -10561,6 +10564,15 @@ u8 dev_xdp_prog_count(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
>  
> +/* Does the device have an XDP program, and was it installed directly on the
> + * device rather than propagated down by an upper with netif_xdp_propagate()?
> + */
> +bool dev_xdp_has_own_prog(struct net_device *dev)
> +{
> +	return dev_xdp_prog_count(dev) && !dev->xdp_from_upper;
> +}
> +EXPORT_SYMBOL_GPL(dev_xdp_has_own_prog);

[Severity: Low]
This isn't a bug, but does this comment still match what the function
returns? It describes where the program came from. The new kernel-doc in
include/linux/netdevice.h does too:

    @xdp_from_upper: the program in @xdp_state was installed by an
        upper device with netif_xdp_propagate(); it belongs to the
        upper and can't be replaced or removed through this device.

__netdev_upper_dev_unlink() clears xdp_from_upper on any master unlink.
That includes the case where the upper's NULL propagate failed and
bonding or netvsc only warned. After that, dev_xdp_has_own_prog() returns
true for a program that an upper propagated.

Could both comments describe the flag as current ownership, including the
hand-over on master unlink?

[ ... ]

> @@ -10773,6 +10816,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>  	}
>  
>  	mode = dev_xdp_mode(dev, flags);
> +	if (dev->xdp_from_upper) {
> +		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an upper device");
> +		return -EBUSY;
> +	}

[Severity: Low]
This check now runs before the existing loop that refuses an attach when
an upper has a program:

    netdev_for_each_upper_dev_rcu(dev, upper, iter) {
        if (dev_xdp_prog_count(upper) > 0) {
            NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
            return -EEXIST;
        }
    }

For a direct bond slave or a joined netvsc VF, the upper keeps its
program in its own xdp_state[]. Attach, replace and detach on the lower
were therefore already refused, with -EEXIST. They now fail with -EBUSY
and a different extack message.

The commit message says dev_xdp_attach() reads the flag "to keep the
program from being replaced or removed behind the upper's back". However,
that protection is only new for nested lowers and for the netvsc window
before the join.

Is the errno and message change for the common direct-lower case
intended? If so, could the commit message mention it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112235027.4072149-1-kuba%40kernel.org
