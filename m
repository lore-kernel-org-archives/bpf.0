Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963987;
	b=Nle6jyiJ+FW77W9qQ7/xayOmZjNTxUGa3exgzZHkR0CHHOD9NI9MLGVT4KFAU8yHxH4W
	 WOFV9Cb2HDUN9QTlRItQyGuNsm52IIgNUOmS/Y5OI2fKSJ1EUDqSeFTVJGvYxrY++2aZS
	 lmxiGBjKw9tR79MhEnBGYeRzDmuAJV2QgFZZKoPCT5wkxnKx6L62twoavO5lOtyEYauil
	 7D/PFjDXSlFQ0RLuGmujLq4Z3wDnoy3ba6fSZdlyxbPiEgFEi1VJeIJ73AB7SX+sd5YJm
	 L2pVhJU/NyU+z0E+crGxSHP1ipcYeDNgg+qeDdkHLnwph7aDW0PQmVAHolJoBFeFYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963987;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=60m7KcRIF+636nFMfThPXFQN3d/l9dTK+27x5s5xATE=;
	b=ol7pcskkrh/rWcg65dPmdvS0rpsl5ANKJWUOAG/qE4/0JmBHzOUw7O8hKEqcrI94FZX7
	 WVrlzz7tEl/lGFbJaWF6C8sXHAh2ej6tWwsj2MS5inIaBurEjerrTcNVl0FpCL9HlAhfB
	 k863/M+zAJnUomHj2M7BrfYL9L9NsxaB3JwzKkfWoOPCEVc1+vtulwB0yqE5+GTWHmuvd
	 iaZwgFXB9pjSLMTHikPkw1wTbmEd1St8iJe9YQXrrIoL4V72zVRidSAfcKkyspWi8Dtfg
	 Jo+fV/KxBBmKYWRS12SU5/kEEYHZBPzumn1IzggtV/DYOhlFO1fsgiJXsxfLdYw/5VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G2ShfEuZ;
	arc=none smtp.remote-ip=95.215.58.161
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E54606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 01:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E54606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G2ShfEuZ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P+w583ycCexQeOOWJwBcF8zhG/qFNQ+UKx5LbN5dQA4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794963983; v=1; x=1795568783;
 b=G2ShfEuZTCDHBerSf+ZH5QaosvG2IN7tMAc/GWDm4c8He5RpXlca19ua9UQiSKYAjSCBVpe1
 AEYaTE/Ip/CZ1qUtPdxTdikFMJckbCnUHHZHbHOd54ZaeVj5K0zVGo2jKnkbsVeNTjkxJiDHeYN
 3Sacr8Yu3w5jcEA621NCLyaQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 825b9c48667a5f11;
	Wed, 18 Nov 2026 01:06:22 +0000
X-Mizu-Trace-ID: 825b9c48667a5f11
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 09:06:09 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] bonding: check XDP support before enslaving
 changes state
Message-ID: <avz6AQetwPAY--Mt@fedora>
References: <20261113-bond_enslave_restruct-v1-1-364c549e78db@kylinos.cn>
 <179492640769.3136.3241898567283164730@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179492640769.3136.3241898567283164730@kernel.org>

On Tue, Nov 17, 2026 at 02:40:07PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete: a slave without ndo_xdp_xmit can still be
>   reached by bond_xdp_xmit() whenever the bond has no XDP program.
> - [Low] The commit message presents this as a crash fix ("bond_xdp_xmit()
>   may call a NULL ndo_xdp_xmit"), but the commit has no Fixes: tag (and…
> - [Low] The commit author (From:) is "Hangbin Liu
>   <hangbin.liu@linux.dev>", but the only Signed-off-by line is "Hangbin…
> 
> --
> 
> bonding: check XDP support before enslaving changes state
> 
> This commit moves two XDP checks in bond_enslave() to the validation
> section at the top of the function: the ndo_bpf/ndo_xdp_xmit capability
> check and the slave XDP program count check. They now run before the slave
> is opened, attached and made visible to the datapath. The
> dev_xdp_propagate() setup stays where it was.
> 
> > In particular
> > the slave can become bond->curr_active_slave, or be published via
> > bond->slave_cnt, before we verify that slave_dev->netdev_ops->ndo_xdp_xmit
> > exists, so bond_xdp_xmit() may call a NULL ndo_xdp_xmit.
> 
> [Severity: Low]
> The commit message describes this as a fix for a NULL ndo_xdp_xmit call,
> but there is no Fixes: tag and no Cc: stable. Should there be a Fixes:
> tag?
> 
> git blame shows the late capability and prog-count checks came from commit
> 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver"), and
> commit 6d5f1ef83868 later restructured them.
> 
> > Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> [Severity: Low]
> The author is Hangbin Liu <hangbin.liu@linux.dev>, but the only
> Signed-off-by line uses <liuhangbin@kylinos.cn>. checkpatch reports this
> as a From:/Signed-off-by: email address mismatch. Could the two addresses
> be made to match?
> 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 9249a79a168e4..340af4c3fa201 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -1948,6 +1948,23 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  		return -EPERM;
> >  	}
> >  
> > +	/* Check XDP support before any state change, so a slave without
> > +	 * XDP can never become visible to bond_xdp_xmit().
> > +	 */
> > +	if (bond->xdp_prog) {
> > +		if (!slave_ops->ndo_bpf || !slave_ops->ndo_xdp_xmit) {
> > +			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
> > +				     "Slave does not support XDP");
> > +			return -EOPNOTSUPP;
> > +		}
> 
> [Severity: High]
> Does the "can never become visible" claim still hold when bond->xdp_prog
> is NULL?
> 
> bond_xdp_xmit() is the bond's ndo_xdp_xmit. Devmap and bpf_redirect reach
> it after only this check:
> 
> kernel/bpf/devmap.c:__xdp_enqueue() {
>     ...
> 	if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
> 		return -EOPNOTSUPP;
>     ...
> }
> 
> bond_xdp_set_features() builds that flag from bond_xdp_check() and the
> slaves' xdp_features. It never looks at bond->xdp_prog:
> 
> 	if (!bond_xdp_check(bond, BOND_MODE(bond)) || !bond_has_slaves(bond)) {
> 		xdp_clear_features_flag(bond_dev);
> 		return;
> 	}
> 
> 	bond_for_each_slave(bond, slave, iter)
> 		val &= slave->dev->xdp_features;
> 
> Take a round-robin, active-backup, XOR or 802.3ad bond with no XDP
> program, where all current slaves advertise NDO_XMIT and another device
> redirects XDP frames into the bond. Enslaving a device with a NULL
> ndo_xdp_xmit skips this check.
> 
> The new slave then becomes visible before bond_xdp_set_features() clears
> NDO_XMIT on the bond:
> 
>   - the default case of the mode switch in bond_enslave() does
>     rcu_assign_pointer(bond->curr_active_slave, new_slave)
>   - bond_master_upper_dev_link() puts the slave on the lower list that
>     bond_get_slave_by_id() walks
>   - slave_cnt++ and bond_update_slave_arr() also run before
>     bond_xdp_set_features()
> 
> A redirect on another CPU runs under RCU only, without RTNL. It could pick
> the new slave, for example through the IGMP path of
> bond_xdp_xmit_roundrobin_slave_get():
> 
> 	if (iph->protocol == IPPROTO_IGMP) {
> 		slave = rcu_dereference(bond->curr_active_slave);
> 		if (slave)
> 			return slave;
> 
> bond_xdp_xmit() then makes the call without a NULL check:
> 
> 	err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);
> 
> Can this call a NULL ndo_xdp_xmit in softirq context?
> 
> There seems to be a second window as well. __xdp_enqueue() checks
> xdp_features when a frame is queued, but the bulk queue is flushed later
> without a recheck:
> 
> kernel/bpf/devmap.c:bq_xmit_all() {
>     ...
> 	sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_send, bq->q, flags);
>     ...
> }
> 
> No RCU grace period follows xdp_set_features_flag() either.
> 
> The later patches in the series don't close this. At the end of the
> series:
> 
>   - the check is still gated on bond->xdp_prog, now in
>     bond_enslave_validate()
>   - bond_xdp_xmit() is unchanged
>   - bond_xdp_set_features() now runs before bond_publish_slave(), but
>     still after the curr_active_slave assignment and the lower-list link
> 
> One option is to guard the call in bond_xdp_xmit(), or to select only
> slaves that advertise NDO_XMIT. Another is to clear the bond's NDO_XMIT
> and wait for in-flight readers before any slave without XDP support
> becomes visible, whether or not bond->xdp_prog is set. Would one of these
> be a better fit?
> 

As I mentioned in the previous mail[1], we may need a check like

  if (likely(slave_dev->netdev_ops->ndo_xdp_xmit))
      err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);

On the other hand, should we call bond_xdp_xmit() without a bond->xdp_prog?
I need to check if we should move the bond_xdp_set_features(bond_dev);
inside the if (bond->xdp_prog) checking. So when we build the bond xdp
features, we can make sure there is a bond->xdp_prog set.

[1] https://lore.kernel.org/netdev/aqokD2avF7B7Towi@fedora/

Thanks
Hangbin

---
pw-bot: cr
