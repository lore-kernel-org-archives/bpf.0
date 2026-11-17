Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926409;
	b=KRd/so4F1B6ygxYv7SOsb9828rQJylTauzdFHKBYEI6sovuVbmdoo4Ve7a/nbahoGzeF
	 gxoGmS2QBCyLPinVkqQ52Qf3IfEtXVNdmJIeheG9d02VMa18sngQVYKZo6SCYue/83GB7
	 S2+iIg6A1mtOBNSdz5gY9IewaX5pVlirTiK1E/lwuR3QPiwz6M6jpI5csEgZDZkMBlWEH
	 3lY/oVYXP1vS6+HlTZ8d1YUfuHAowwBSNKkjTCRQf40/sC+O/wZVNuMOMF9J0UfOaJAK5
	 kpuqs4k0nEbEG5DYTK6I5E07W+7vHIWGdw9ae6+JoTQKHSpVdz6MKjBYiKbR6Fk5sqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926409;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tEgUrtNdmgj90oAjCihso1yrCQ51zxhrpKkf1UMTdM0=;
	b=3jaNB4dSJVkMmN9RWFwzlR7JUMh+ZV6QsGEitaol8wfCh1oT60yXxNJxMVNtCs1RxerE
	 1Gg7p90VMTggdcO2MQLJQskNln0lUK2lG/YrUMJj3NCfqk6IhCfxm1A2y1uANBt5TgVwy
	 RJzsgk09hbWFKLpTamYBMmyUbmCvZ85Wby/NTq4RsM3D8LwRy48XX5l6DTKRpne5g8X3O
	 +d57mahODMVkQLZCfnxnlGLPAfIoe7q8wqfefEQBONd8XaycaDl2zkGiRsXThkxRPN4Ok
	 XAl7RiOyh0xF0gsElVPGqhLKLmctFT0lnbzvMxiUqKeaY6x5CJc9QnUoJbAx0kvrppA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNJKXb3o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71046606A338;
	Tue, 17 Nov 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNJKXb3o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC1B1F000C4;
	Tue, 17 Nov 2026 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926409;
	bh=tEgUrtNdmgj90oAjCihso1yrCQ51zxhrpKkf1UMTdM0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iNJKXb3oK7zPFVzFc8HBqIDgx+nIcAlcaVu2nfN8QvDYySIPBNHmNu185UaEIEIx9
	 EskkBV2VGIy/bjP9vytJW3xF0QKofmxJe3+VrdxmbuHh0xRTvaGmkx2Gm3FxzZVJs9
	 TNY+VbNbI1aZDk3ATmNidndK0bYbhrWfhwW7k4KNdcGw00d27tvBJ07NOJZZlXk9nu
	 O/d94B/v4EZ7qYJi9W8M0lUksLRLFn8eHPszDxWk5By0INPqz6tqQ/qUGNvFtoeStp
	 oXhUFdTjNQnC7c+1RQG2qF1fUxlZC9jlBeaSYa7dnyVB8MEqVhFROEJKeYxLVqYV6y
	 H5raMpu2XFt4Q==
Subject: Re: [PATCH net-next 1/6] bonding: check XDP support before enslaving
 changes state
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Tue, 17 Nov 2026 14:40:07 +0000
Message-ID: <179492640769.3136.3241898567283164730@kernel.org>
In-Reply-To: <20261113-bond_enslave_restruct-v1-1-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-1-364c549e78db@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: a slave without ndo_xdp_xmit can still be
  reached by bond_xdp_xmit() whenever the bond has no XDP program.
- [Low] The commit message presents this as a crash fix ("bond_xdp_xmit()
  may call a NULL ndo_xdp_xmit"), but the commit has no Fixes: tag (and…
- [Low] The commit author (From:) is "Hangbin Liu
  <hangbin.liu@linux.dev>", but the only Signed-off-by line is "Hangbin…

--

bonding: check XDP support before enslaving changes state

This commit moves two XDP checks in bond_enslave() to the validation
section at the top of the function: the ndo_bpf/ndo_xdp_xmit capability
check and the slave XDP program count check. They now run before the slave
is opened, attached and made visible to the datapath. The
dev_xdp_propagate() setup stays where it was.

> In particular
> the slave can become bond->curr_active_slave, or be published via
> bond->slave_cnt, before we verify that slave_dev->netdev_ops->ndo_xdp_xmit
> exists, so bond_xdp_xmit() may call a NULL ndo_xdp_xmit.

[Severity: Low]
The commit message describes this as a fix for a NULL ndo_xdp_xmit call,
but there is no Fixes: tag and no Cc: stable. Should there be a Fixes:
tag?

git blame shows the late capability and prog-count checks came from commit
9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver"), and
commit 6d5f1ef83868 later restructured them.

> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

[Severity: Low]
The author is Hangbin Liu <hangbin.liu@linux.dev>, but the only
Signed-off-by line uses <liuhangbin@kylinos.cn>. checkpatch reports this
as a From:/Signed-off-by: email address mismatch. Could the two addresses
be made to match?

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 9249a79a168e4..340af4c3fa201 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1948,6 +1948,23 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		return -EPERM;
>  	}
>  
> +	/* Check XDP support before any state change, so a slave without
> +	 * XDP can never become visible to bond_xdp_xmit().
> +	 */
> +	if (bond->xdp_prog) {
> +		if (!slave_ops->ndo_bpf || !slave_ops->ndo_xdp_xmit) {
> +			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
> +				     "Slave does not support XDP");
> +			return -EOPNOTSUPP;
> +		}

[Severity: High]
Does the "can never become visible" claim still hold when bond->xdp_prog
is NULL?

bond_xdp_xmit() is the bond's ndo_xdp_xmit. Devmap and bpf_redirect reach
it after only this check:

kernel/bpf/devmap.c:__xdp_enqueue() {
    ...
	if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
		return -EOPNOTSUPP;
    ...
}

bond_xdp_set_features() builds that flag from bond_xdp_check() and the
slaves' xdp_features. It never looks at bond->xdp_prog:

	if (!bond_xdp_check(bond, BOND_MODE(bond)) || !bond_has_slaves(bond)) {
		xdp_clear_features_flag(bond_dev);
		return;
	}

	bond_for_each_slave(bond, slave, iter)
		val &= slave->dev->xdp_features;

Take a round-robin, active-backup, XOR or 802.3ad bond with no XDP
program, where all current slaves advertise NDO_XMIT and another device
redirects XDP frames into the bond. Enslaving a device with a NULL
ndo_xdp_xmit skips this check.

The new slave then becomes visible before bond_xdp_set_features() clears
NDO_XMIT on the bond:

  - the default case of the mode switch in bond_enslave() does
    rcu_assign_pointer(bond->curr_active_slave, new_slave)
  - bond_master_upper_dev_link() puts the slave on the lower list that
    bond_get_slave_by_id() walks
  - slave_cnt++ and bond_update_slave_arr() also run before
    bond_xdp_set_features()

A redirect on another CPU runs under RCU only, without RTNL. It could pick
the new slave, for example through the IGMP path of
bond_xdp_xmit_roundrobin_slave_get():

	if (iph->protocol == IPPROTO_IGMP) {
		slave = rcu_dereference(bond->curr_active_slave);
		if (slave)
			return slave;

bond_xdp_xmit() then makes the call without a NULL check:

	err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);

Can this call a NULL ndo_xdp_xmit in softirq context?

There seems to be a second window as well. __xdp_enqueue() checks
xdp_features when a frame is queued, but the bulk queue is flushed later
without a recheck:

kernel/bpf/devmap.c:bq_xmit_all() {
    ...
	sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_send, bq->q, flags);
    ...
}

No RCU grace period follows xdp_set_features_flag() either.

The later patches in the series don't close this. At the end of the
series:

  - the check is still gated on bond->xdp_prog, now in
    bond_enslave_validate()
  - bond_xdp_xmit() is unchanged
  - bond_xdp_set_features() now runs before bond_publish_slave(), but
    still after the curr_active_slave assignment and the lower-list link

One option is to guard the call in bond_xdp_xmit(), or to select only
slaves that advertise NDO_XMIT. Another is to clear the bond's NDO_XMIT
and wait for in-flight readers before any slave without XDP support
becomes visible, whether or not bond->xdp_prog is set. Would one of these
be a better fit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-bond_enslave_restruct-v1-0-364c549e78db%40kylinos.cn
