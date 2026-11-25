Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615922;
	b=eZJniYsr1Oj/81b85xfqVpSaQn1Zoy4cJBuN+mbECGOuVRjN0oNtmPUi2iWZl+vULvL+
	 6h/PF7OBfzPbriL2Ryv1ibtckrpuFgH12wqMM4RDA4uaFVqBHSq/nttvrjhVwoywJ006q
	 zOO+ar7RxoqCAdRqWN69cO8ExdcT08KINV/o/O9q+JFtOx+6h0sfVrmo3v0NDHoiE/EVY
	 fYXiePTft9AJWVCkF+5EPpi9ALZDAbKilYTeft7PEcEAiXVBX+Pz2qmbhz1XByU3NAed/
	 23CgifUnkJLxMwC7yRxiRRDvHYBsGZ5AYL/ueXPSYjeEc/tEep98R1/erMMEzrD9NgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615922;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LYxEbOksYcx+mF8Gq0+65bD+OszdX0B7sFSHcrKxVdU=;
	b=OP79rsTCWeDMIuDXJWTyiBxC20Y3kMzdfgPBg6LO/lX2yEiu8bxrGr9xnLjWSPWsyTx2
	 7ZjguIPKyTEjDJcDqwfP1aEXpUZ6A6UF+MhQbUA550WfFXceGgVbTG/j9YJ6dyiv+LRlG
	 llzYZ0QYEXGkc3y78YkVbEUvXdd8YJ24NBm7ZMrfgCmukKLsD4y8dkWmxjs5eZ3YxyS51
	 brfjN08EzB0jplNvlRvYu8CWNaSMW8BophzyKqb8Gq5w/HNTpGGoti3lqhlfB94WN12UN
	 gWWKT6/5C81zWjEsuys2N5phd3mDtaVtZarFM/3FZiTw16zfbh1BsxNX9htKxEdcraQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkYe1sXm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B21606A31E;
	Wed, 25 Nov 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkYe1sXm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD76C1F000C4;
	Wed, 25 Nov 2026 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615921;
	bh=LYxEbOksYcx+mF8Gq0+65bD+OszdX0B7sFSHcrKxVdU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FkYe1sXm8PvorudUmAXkkBmfhu2nv0CM2YdcEbCckWukguuRhcXiI4NCGK07CesS0
	 8Pf1JiBDGlzvTkVxxy9zsPKGqaNd3WT4PfchMnP0swyjTIpaEi4A3P/zjQhOBS48cv
	 pGA3oT5iJYjmP68pfjz8sVC0GXdPjHqQe3+cSg2SvBCL1TRAvY4oj2cHnPQrZ990X8
	 c2dI5M76YKYZUcqpXDJRch8RHk3pMinNslU44cC2JaPdP3y3s7T/ZIMOlGkKKds06k
	 KE13CH71ZgEsSS7cyLYThaLKdogG06r+Cq8w3A/0m602pLUm65yhNRLHfmcmeonPK1
	 +c9fb+T64wlZw==
Subject: Re: [PATCH net-next] bonding: check XDP support before enslaving
 changes state
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Wed, 25 Nov 2026 14:12:00 +0000
Message-ID: <179561592046.3135.4020262152427481394@kernel.org>
In-Reply-To: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
References: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bonding: bond_xdp_xmit() checks ndo_xdp_xmit instead of
  xdp_features
- [Medium] This patch fixes a kernel oops that is self-contained and goes
  back years, but it has no Fixes: tag and it is mixed in with changes…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the XDP
  propagate failure it keeps on the late path can leave freed memory…

--

bonding: check XDP support before enslaving changes state

This patch moves the ndo_bpf/ndo_xdp_xmit and dev_xdp_has_own_prog() checks
in bond_enslave() to the validation section, before any state is changed.
It also checks the selected slave's ndo_xdp_xmit in bond_xdp_xmit(). Frames
then fail with -ENXIO instead of calling a NULL pointer.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 776afdb9df43e..0149bd7764e7c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> @@ -2330,13 +2336,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			.extack  = extack,
>  		};
>  
> -		if (dev_xdp_has_own_prog(slave_dev)) {
> -			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
> -				     "Slave has XDP program loaded, please unload before enslaving");
> -			res = -EOPNOTSUPP;
> -			goto err_dec_slave_cnt;
> -		}
> -
>  		res = dev_xdp_propagate(slave_dev, &xdp);
>  		if (res < 0) {
>  			/* ndo_bpf() sets extack error message */

[Severity: High]
This isn't a bug introduced by this patch, but the dev_xdp_propagate()
failure path that stays here looks like it can leave freed memory linked
into live 802.3ad state.

In BOND_MODE_8023AD, bond_enslave() calls bond_3ad_bind_slave(new_slave) and
then publishes the slave through bond_master_upper_dev_link(). If
dev_xdp_propagate() fails, the unwind runs through err_dec_slave_cnt,
err_sysfs_del, err_upper_unlink, err_unregister, err_detach and err_free.
None of those labels call bond_3ad_unbind_slave(). Its only caller is
__bond_release_one().

bond_3ad_state_machine_handler() runs from ad_work under mode_lock and RCU,
not RTNL, and walks bond_for_each_slave_rcu(). That means it can run while
the new slave is published. In that window ad_port_selection_logic() can
attach the new port to another slave's aggregator:

drivers/net/bonding/bond_3ad.c:ad_port_selection_logic() {
    ...
			port->next_port_in_aggregator = aggregator->lag_ports;
			aggregator->num_of_ports++;
			aggregator->lag_ports = port;
    ...
			free_aggregator->lag_ports = port;
    ...
}

The unwind then reaches slave_kobj_release() through kobject_put():

	if (BOND_MODE(bond) == BOND_MODE_8023AD)
		kfree(SLAVE_AD_INFO(slave));

However, the other slave's aggregator->lag_ports still points at the freed
port. On a later tick, ad_agg_selection_logic()->__agg_active_ports() walks
that list:

	for (port = agg->lag_ports; port;
	     port = port->next_port_in_aggregator) {
		if (READ_ONCE(port->is_enabled))

Can this read a freed struct port? When ports join or leave,
ad_port_selection_logic() can also write through
last_port->next_port_in_aggregator.

dev_xdp_propagate() can fail here when ndo_bpf refuses the program, for
example veth with a large MTU, or when it returns -EBUSY.

The note under the commit message only covers the promiscuity, allmulti and
ns maddrs leaks, so this one seems to be a separate issue.

Does the unwind need a bond_3ad_unbind_slave() call in 802.3ad mode?

[ ... ]

> @@ -5681,7 +5680,7 @@ static int bond_xdp_xmit(struct net_device *bond_dev,
>  		xdp_convert_frame_to_buff(frame, &xdp);
>  
>  		slave_dev = bond_xdp_get_xmit_slave(bond_dev, &xdp);
> -		if (!slave_dev) {
> +		if (!slave_dev || unlikely(!slave_dev->netdev_ops->ndo_xdp_xmit)) {
>  			err = -ENXIO;
>  			break;
>  		}

[Severity: High]
Is checking the ndo_xdp_xmit pointer enough here? Most XDP capable
drivers fill in .ndo_xdp_xmit unconditionally in their static
net_device_ops. They only advertise NETDEV_XDP_ACT_NDO_XMIT in
dev->xdp_features once their XDP TX queues have been set up. For those
slaves the pointer is never NULL, so the new check doesn't stop the
call the commit message is worried about.

When bond->xdp_prog is NULL, bond_enslave() makes the new slave
selectable through bond->curr_active_slave, bond->slave_cnt and
bond_update_slave_arr(). All of that happens before
bond_xdp_set_features() recomputes bond_dev->xdp_features.
__xdp_enqueue() in kernel/bpf/devmap.c only checks the bond's flags,
and only at enqueue time:

	if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
		return -EOPNOTSUPP;

bq_xmit_all() then hands the queued frames to bond_xdp_xmit()
without rechecking anything. A slave whose XDP TX path isn't ready
can be picked by bond_xdp_get_xmit_slave() and have its
ndo_xdp_xmit called.

In gve, gve_xdp_xmit_dqo() takes smp_processor_id() modulo
priv->tx_cfg.num_xdp_queues, which is 0 when XDP isn't enabled on the
device. That is a divide by zero in softirq context.

In mvpp2, mvpp2_xdp_xmit() derives txq_id from port->ntxqs / 2. The
driver only advertises NETDEV_XDP_ACT_NDO_XMIT when port->ntxqs >=
num_possible_cpus() * 2, so port->txqs[txq_id] looks like it can be
indexed out of bounds otherwise.

Multi-buffer frames have the same problem. Suppose the existing
slaves support NETDEV_XDP_ACT_NDO_XMIT_SG and the new slave only does
linear XDP. Frames with xdp_frame_has_frags() that were enqueued
before bond_xdp_set_features() drops the SG bit can still be handed
to the new slave.

The commit message says the xmit time check covers frames enqueued
before the flag is cleared, and the bulk-queue flush path. That only
holds for slaves with a NULL ndo_xdp_xmit.

Would it be better to test READ_ONCE(slave_dev->xdp_features) for
NETDEV_XDP_ACT_NDO_XMIT here? It could also test
NETDEV_XDP_ACT_NDO_XMIT_SG when xdp_frame_has_frags(frame) is true,
the same way __xdp_enqueue() does for the bond itself.

[Severity: Medium]
This check seems to fix a NULL ndo_xdp_xmit call in softirq context. The
unguarded call goes back to commit 9e2ee5c7e7c3 ("net, bonding: Add XDP
support to the bonding driver"). Should this have a Fixes: tag?

On the net vs net-next question in the notes: as far as I can tell, this
one-line check doesn't depend on f564749b3b26 ("net: record XDP programs
propagated to lower devices"). Only the dev_xdp_has_own_prog() check that
moved to the top of bond_enslave() needs that commit.

When bond->xdp_prog is NULL, bond_enslave() publishes the new slave before
bond_xdp_set_features() recomputes the bond's flags:

bond_enslave()
    bond_master_upper_dev_link()
    WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
    ...
    bond_update_slave_arr()
    bond_xdp_set_features()

During that window the bond can still advertise NETDEV_XDP_ACT_NDO_XMIT, so
__xdp_enqueue() in kernel/bpf/devmap.c accepts frames. The roundrobin,
active-backup or XOR selectors in bond_xdp_get_xmit_slave() can then pick
the new slave. Frames already sitting in a devmap bulk queue never recheck
xdp_features.

Could this hunk be split out into its own patch with a Fixes: tag for net,
so it can reach stable? The enslave check reordering could stay in
net-next.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-bond_xdp_fix-v1-1-e67983924324%40kylinos.cn
