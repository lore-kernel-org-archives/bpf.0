Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701607;
	b=cyR1HSvEqL+mqGGyKbOmvNQjtOVAPgshXs4VnyRWnS6Wpjdrh37IkMWO7J94/krrn5n8
	 ANiLdI6fZzT8elOsnmO1aGe+Mwyp9Ase5mZkYTNTqmYMqzs9/uOK5n9Vlb7DpAd6ic79c
	 mUt+9XOyPKRBmWfLgKKY4k5K6OchuAqLtEPlTtNxJOjalnZQnETdCACH5XunoH8VdvnFn
	 o0AyWg4cWmE8w8tLWZXcesQgK/LklO/4nLSoI3txJUryRne9m4pLDu3ryBLrkZfbJNs/N
	 U8B/E2CsYI4crHWzv6K/R4QFEzY9P5buW02J4ZcMySd8WbyBDs7BDY/Bm1S3KhD75Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fQBIqLqDncEptdq4UUE09ud9GA7Xy/O0OUGXncKZq8E=;
	b=Yh92mUkqfC6/TXq0YL01bki2WBL2QKsTj3RUh5rx57x5JwCCr2uxteYK5DFczY+sHmI6
	 4+IbaNa+HiPMhgpVMyKrelkG+4yn7Cjiq45j7n413iR1hQqAvvjMEFBorKT1fAF91v7+W
	 8V4xBBgiF9k3RDueNPUv6zkTWeOM7XzrnNSY9sMvzYd/UOn9P1rOrriMG5eG9GrNGxrrn
	 qfRKXRQepNxGC5cqf7H2ykNGDcUUyZPfOG2Bb7KXmUCdU9azmLQBcclglZdsTNf0Nlqar
	 YXQ4SAgpHbgbdndyuqsGANksF6bCtFb5ft+ExNrHkxbFTsL6tBdZqGog/lvas9ipgBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX3j0HE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AD606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX3j0HE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626F81F000C4;
	Thu, 26 Nov 2026 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701606;
	bh=fQBIqLqDncEptdq4UUE09ud9GA7Xy/O0OUGXncKZq8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SX3j0HE5r0poUsAiGl2cw04w464MIdeoxIz11NaF8w4UU/GOJ8UQt2pNtsYXW9KHI
	 +P6s1LAVI5huJqvWPfmVfMZH0AQWLDoNKpg+uU4NXQa3IwO+mdS6GII9x8ttFdjEXP
	 WUtRM7b3+BH6X4kk19HxMOceU3g5tP671R1vu82x3hTFLrIjoJ1fjKWR/PZtLrs/Iv
	 +GO1mneBGz5zKWX3ZPoEKkrPuM44ureujuVQlepMiVGiNe/W90CI958I6+HqXV84z8
	 h+jLOhnVcWml9XDU4CsNycdN7NHeo4dfH7rpYjAxU5NySGOOgGw03isFXkY5kiGobT
	 +qXckLfvMBjOg==
Message-ID: <sashiko-outbox-235667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] bonding: undo enslave state when XDP setup
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125-bond_xdp_rollback-v1-1-35dddaa337ba@kylinos.cn>
References: <20261125-bond_xdp_rollback-v1-1-35dddaa337ba@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:00:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bonding: unbalanced bond_slave_ns_maddrs_del() calls in
  bond_enslave()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] bonding: missing cleanup and 3ad unbind on XDP error in
  bond_enslave() [1]
--

commit 92300beff3942cb3faeff269729a68f96aad2772
Author: Hangbin Liu <hangbin.liu@linux.dev>

bonding: undo enslave state when XDP setup fails

This commit cleans up promiscuity, allmulti, synced hardware addresses, and
NS target multicast addresses on the slave when XDP setup fails in
bond_enslave().

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 776afdb9df43e..a3daf005b444d 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2364,7 +2364,16 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
> =20
>  /* Undo stages on error */
>  err_dec_slave_cnt:
> +	bond_slave_ns_maddrs_del(bond, new_slave);
>  	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
> +	if (!bond_uses_primary(bond)) {
> +		if (bond_dev->flags & IFF_PROMISC)
> +			dev_set_promiscuity(slave_dev, -1);
> +		if (bond_dev->flags & IFF_ALLMULTI)
> +			dev_set_allmulti(slave_dev, -1);
> +		if (bond_dev->flags & IFF_UP)
> +			bond_hw_addr_flush(bond_dev, slave_dev);
> +	}
> =20
>  err_sysfs_del:
>  	bond_sysfs_slave_del(new_slave);

[Severity: Critical]
This problem wasn't introduced by this patch, but in BOND_MODE_8023AD,
bond_enslave() has already called bond_3ad_bind_slave(new_slave) and linked
the slave into the lower device list before reaching these error labels
[1].  While new_slave is linked, bond_3ad_state_machine_handler() can
run concurrently and attach its port to an aggregator's lag_ports list.
Does unwinding without calling bond_3ad_unbind_slave() leave the freed port
linked in the aggregator after kobject_put(&new_slave->kobj), causing a
use-after-free on later 802.3ad state machine ticks or bond teardown?

> @@ -2390,6 +2399,7 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
>  	slave_disable_netpoll(new_slave);
> =20
>  err_close:
> +	bond_slave_ns_maddrs_del(bond, new_slave);

[Severity: Medium]
Does calling bond_slave_ns_maddrs_del() at both err_dec_slave_cnt and
err_close cause an unbalanced extra dev_mc_del() on slave_dev in
active-backup mode?

slave_can_set_ns_maddr() gates NS multicast address addition and deletion on
!bond_is_active_slave(slave) (slave->backup =3D=3D 1), which bond_enslave()=
 sets
via bond_set_slave_inactive_flags() before registering the rx handler:

- If new_slave remained a backup slave when XDP setup fails, new_slave->bac=
kup
  is 1 at both err_dec_slave_cnt and err_close, so bond_slave_ns_maddrs_del=
()
  calls dev_mc_del() twice for one bond_slave_ns_maddrs_add().
- If new_slave became active in bond_select_active_slave(),
  bond_change_active_slave(bond, new_slave) already removed the NS multicast
  addresses in bond_hw_addr_swap() before clearing new_slave->backup.  When
  err_detach then calls bond_change_active_slave(bond, NULL),
  bond_hw_addr_swap(bond, NULL, new_slave) runs while new_slave->backup is
  still 0, before bond_set_slave_inactive_flags() sets new_slave->backup =
=3D 1:

drivers/net/bonding/bond_main.c:bond_change_active_slave() {
	...
	if (bond_uses_primary(bond))
		bond_hw_addr_swap(bond, new_active, old_active);
	...
	if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP) {
		if (old_active)
			bond_set_slave_inactive_flags(old_active,
						      BOND_SLAVE_NOTIFY_NOW);
	...
}

  As a result, bond_hw_addr_swap() never re-adds the NS multicast addresses,
  and the call at err_close runs with new_slave->backup =3D=3D 1 and invokes
  dev_mc_del() a second time.
- If bond_enslave() fails earlier (for example at netdev_rx_handler_registe=
r()
  or bond_master_upper_dev_link()) before bond_slave_ns_maddrs_add() is
  reached, new_slave->backup is already 1 and err_close calls dev_mc_del()
  without a matching add.

Because netdev multicast address entries are reference-counted, the extra
dev_mc_del() decrements and can remove pre-existing matching solicited-node
multicast MAC filters belonging to slave_dev itself.

If err_detach calls bond_set_slave_inactive_flags() before
bond_change_active_slave(bond, NULL) (matching __bond_release_one()), or if
bond_slave_ns_maddrs_del() is called only at err_dec_slave_cnt after
err_detach has already run, the add and delete calls stay balanced.

[1] https://sashiko.dev/#/bug/linux-3afd2f84-c338-4cc9-949c-4bc132bd2f79

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-bond_xdp_r=
ollback-v1-1-35dddaa337ba@kylinos.cn?part=3D1
