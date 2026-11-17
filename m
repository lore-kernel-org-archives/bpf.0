Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926410;
	b=nGtVSZlRxyQMpBCtBk8cjrw+Wp1jMkiUiBs7YMsrAIT0hoXXHn016xzxCTcszPdWC0C0
	 E5OcPbdmCVV159ze4f2oDOSGJuG8A8XeRfksPHYqHzxa88avWVS5SvyxbnhMr7rKNTANy
	 Vgwi5EtextdmmD8rhUasezKEqSjxaWUFwdD96EMRSELo8bw4OpKVfZBV2B9eOBrGQzyKv
	 UjAaT6xwzczkN/BufGhsfaoMOTjrsdTYNjnQCdg5h4mzVuYZMq0IuojybrrpCLxA4eCne
	 lf2TkDNHF3/KWPhANffqRzt5mBOmStnRV6jQOcKuP/MTWx7YCcjIHs0V8ni/keb4UFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926410;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lZSCPDEbsG1aPYaCkUI/AIdDTXYmLwooFXwBj9p0HvU=;
	b=Vwbigs2EcIdDEhLFY3enlcksScbJjJs0I3+nBHRCCkp9tFVp6Uhh0Z0df3dhZ9shSEK8
	 5PKR1KL8uDmSSwxhzbiueKBqM4dJ7xnzuK9IxrPpwMnYSDF9zbDjAF4QYbs6joEM14VYH
	 ccDqiwIKpFt2FaL769RtrsiBtgegMDSPcDbZ3zWNfIQbQOE6SelAHIxRnp/X5JvM/QoQE
	 vWBDnPgMZ0bwd6Ld/BP6MAP6wCxr7UynmqG9slJaCMsbgCXM9nIWV7mmKNYtfKJPAg/5h
	 b/cXbFWb1G/mGvlyDbM3hiVc1vEYmPCoHMQqKyXZxdDOJh7/hAe1WDxdRrL0Vmx2UAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxNEC23f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAD606A88E;
	Tue, 17 Nov 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxNEC23f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD441F000C4;
	Tue, 17 Nov 2026 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926410;
	bh=lZSCPDEbsG1aPYaCkUI/AIdDTXYmLwooFXwBj9p0HvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hxNEC23fHYZDqJfT3SMMuD5CLBLG66XenrVq1PBhDZObQarbaFxsXeFUYb8RjELwQ
	 NLfkalxCwNWM4DrCZD2gpQB/TX37a4thEIPZ9wehFrbOiHeBsds8eB+QCpYVLUpAdu
	 leKskZZ+DCOU+BqBVXPjNcKEkN/QpX2JZWutM7M9ed20dYgisWlIuN+KD5jhyzacha
	 EGgQbunYPwWtZPAfpQLyc6OzDCodF8hPw+Of5+jsGG9qRBF2SO59QpAYttM3ldMJhQ
	 bTEDl8qZSvPlsODt+WRuY6Q2yx8I4vjeRBFAcBcYe96TZBW8/sKj/gzDuWSKk+C8hQ
	 XKWUPM1rlT6Cw==
Subject: Re: [PATCH net-next 2/6] bonding: finish XDP setup before publishing
 the slave
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Tue, 17 Nov 2026 14:40:09 +0000
Message-ID: <179492640916.3136.15521805995964497359@kernel.org>
In-Reply-To: <20261113-bond_enslave_restruct-v1-2-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-2-364c549e78db@kylinos.cn>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Heap out-of-bounds write in bond_update_slave_arr(),
  introduced by moving the XDP setup ahead of the slave_cnt increment.
- [Low] The commit fixes real, user-visible leaks on the bond_enslave()
  XDP-failure path but has no Fixes: tag.
- [Low] The commit message describes a stale version of the error path.

--

bonding: finish XDP setup before publishing the slave

This patch moves dev_xdp_propagate() in bond_enslave() ahead of the
slave_cnt increment, the ns maddr setup and active slave selection, so the
XDP setup becomes the last fallible step. It also moves
bond_xdp_set_features() earlier. It replaces err_dec_slave_cnt with a new
err_set_xdp label that undoes the promiscuity, allmulti and address sync.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 340af4c3fa201..80b6c18ee9c28 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2313,22 +2313,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		}
>  	}
>  
> -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> -	netdev_compute_master_upper_features(bond->dev, true);
> -	bond_set_carrier(bond);
> -

[ ... ]

> -	/* XDP capability and prog-count were already validated above */
>  	if (bond->xdp_prog) {
>  		struct netdev_bpf xdp = {
>  			.command = XDP_SETUP_PROG,
> @@ -2341,19 +2330,35 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		if (res < 0) {
>  			/* ndo_bpf() sets extack error message */
>  			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
> -			goto err_dec_slave_cnt;
> +			goto err_set_xdp;
>  		}
>  		if (bond->xdp_prog)
>  			bpf_prog_inc(bond->xdp_prog);
>  	}
>  
> +	bond_xdp_set_features(bond_dev);
> +
> +	/* Must called before bond_update_slave_arr() or bond_select_active_slave() */
> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);

[Severity: Critical]
After this reordering, dev_xdp_propagate() runs the slave driver's ndo_bpf
when the new slave is already on the bond's lower list
(bond_master_upper_dev_link() ran earlier) but slave_cnt has not been
incremented yet. If a notifier fires from inside ndo_bpf, can it rebuild
the slave arrays using the old slave_cnt?

For example, dpaa2_eth_setup_xdp() closes and reopens a running device:

drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:dpaa2_eth_setup_xdp() {
    ...
	up = netif_running(dev);
	...
	if (up)
		dev_close(dev);
    ...
	if (up) {
		err = dev_open(dev, NULL);
    ...
}

Take balance-xor or 802.3ad mode (802.3ad once there is an active
aggregator) with an XDP program attached to the bond. The call chain
looks like this:

bond_enslave()
  dev_xdp_propagate()
    dpaa2_eth_xdp()
      dpaa2_eth_setup_xdp()
        dev_close()                    /* NETDEV_DOWN */
          bond_netdev_event()
            bond_slave_netdev_event()
              bond_update_slave_arr(bond, NULL)

bond_update_slave_arr() sizes the arrays from slave_cnt (N). It then walks
all N+1 slaves on the list with no bound:

	usable_slaves = kzalloc_flex(*usable_slaves, arr, bond->slave_cnt);
	all_slaves = kzalloc_flex(*all_slaves, arr, bond->slave_cnt);
	...
	bond_for_each_slave(bond, slave, iter) {
		...
		all_slaves->arr[all_slaves->count++] = slave;

Does this write one struct slave pointer past the end of all_slaves->arr[]
and usable_slaves->arr[]? The arrays are then published with a count
larger than their allocation, so the xmit hash path could read past them
too. dev_open() then raises NETDEV_UP, which would do the same thing again.

For the second slave, struct_size() comes to 32 bytes, which fills a
kmalloc-32 object exactly. The write to arr[1] would then hit the
neighbouring object.

The same applies to any other slave driver whose ndo_bpf synchronously
raises NETDEV_UP, NETDEV_DOWN or NETDEV_CHANGE.

Before this patch, slave_cnt was incremented before dev_xdp_propagate(),
so these rebuilds saw the right count. The new comment above says slave_cnt
must be updated before bond_update_slave_arr(), but calls that come in
through notifiers from ndo_bpf now break that rule.

This still seems to be there at the end of the series.
bond_publish_slave(), added in "bonding: factor out slave publication",
still runs after the XDP setup.

> +	netdev_compute_master_upper_features(bond->dev, true);
> +	bond_set_carrier(bond);

[ ... ]

> @@ -2363,8 +2368,15 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	return 0;
>  
>  /* Undo stages on error */
> -err_dec_slave_cnt:
> -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);

[Severity: Low]
The commit message says:

    If XDP setup then fails, the error path
    jumps to err_sysfs_del and leaks:

and:

    follows the publication of the slave and a failure can no longer
    leak slave_cnt or ns maddrs.

Does this match the parent commit? There, a dev_xdp_propagate() failure
already does goto err_dec_slave_cnt, which decrements slave_cnt. That
label came from a978095699641d ("bonding: fix slave_cnt leak on XDP
enslave failure").

In this hunk the patch actually removes err_dec_slave_cnt, which the
reorder makes unnecessary. Could the commit message say so and reference
a978095699641d?

Separately, there's a typo in the new comment:

	/* Must called before bond_update_slave_arr() or bond_select_active_slave() */

"Must called" should be "Must be called". The typo is carried into
bond_publish_slave() by "bonding: factor out slave publication".

> +err_set_xdp:
> +	if (!bond_uses_primary(bond)) {
> +		if (bond_dev->flags & IFF_PROMISC)
> +			dev_set_promiscuity(slave_dev, -1);
> +		if (bond_dev->flags & IFF_ALLMULTI)
> +			dev_set_allmulti(slave_dev, -1);
> +		if (bond_dev->flags & IFF_UP)
> +			bond_hw_addr_flush(bond_dev, slave_dev);
> +	}

[Severity: Low]
This block fixes leaks that users can actually hit, but the commit has no
Fixes: tag.

In non-primary modes, the parent code jumped from a dev_xdp_propagate()
failure to err_sysfs_del without undoing any of these:

- the promiscuity/allmulti increments
- the addresses added by dev_mc_sync_multiple()/dev_uc_sync_multiple()
  and the LACPDU dev_mc_add()
- the ns target maddrs added by bond_slave_ns_maddrs_add()

The XDP setup placement comes from 9e2ee5c7e7c3 ("net, bonding: Add XDP
support to the bonding driver"). That is also the Fixes: target of
a978095699641d. Placing the ns maddrs before the XDP setup comes from
8eb36164d1a6 ("bonding: add ns target multicast address to slave
device").

This failure can really happen. For example, dpaa2_eth_setup_xdp() returns
-EINVAL when the MTU is not valid for XDP:

	if (prog && !xdp_mtu_valid(priv, dev->mtu))
		return -EINVAL;

Should this carry Fixes: 9e2ee5c7e7c3 and/or Fixes: 8eb36164d1a6?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-bond_enslave_restruct-v1-0-364c549e78db%40kylinos.cn
