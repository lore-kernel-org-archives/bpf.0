Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665212;
	b=DiN3yERINxLL/P26Nc5s/h6jwQIwgi3Q18YlZxd4ruvEYiB+SFuqqWEgZbKFeOJjYhx3
	 uw+HHaluY3uMPPw/dCvvPIdxkUGZCKSyfQYWc1TywYFYFc8pjytZriBNlNiYILjyIH4pO
	 be4INN5YGEStIHCqeLNQO3cxt89jDKXTEAf9sgTh+qbIQvWnXwOjmUxQPHIoOq2uClO1+
	 CUIoafRgOKOj5BwFUyOnuKy2/v4n5xN/wEuFssF5fGRtowHirZvetT9Bn34tmrHY2nA8l
	 OYI7/YtuzFALoc+/6rk10+ykGCNy+lkbBuV/ShLOdX4yGhajTZY24JRXWslETRMzw2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zaoTomJKc3TTJ81wKutifFtFTmcAb3EqNlWRHHeURDY=;
	b=yurN6/0G9vcY3Omjr70O5sjM34LbXP4eYQU9YU6ZEtVgQGG8mwQyH4N2iENOGq/aB0Ga
	 w1djup5Xn4858nZH4docGLPrrRbDbLFH0/sJV6Yenwksj1Q6cxu44EezgOCDQ0OyQgt2y
	 /h4hIxejANhRozjrYvdSYbnCbujUoQq/XAez0hgZqT+YiF4NKenTxTz3Kjtb0OUejA82C
	 0kZWHqdh7P/PapJPrXJTzdKsDkcM8ycTLXuJnQ7JCbrqYQKGafiwTyjF5tjPEzwJ2qBzA
	 RfwIjEOaZno8eYZNbbiwtYWTwKuGdyIez2/YauIjo4NBHAh0n6IM44buN2WKb+nKiMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvSfRcnj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC7606A336
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvSfRcnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2711F000C4;
	Sat, 14 Nov 2026 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665212;
	bh=zaoTomJKc3TTJ81wKutifFtFTmcAb3EqNlWRHHeURDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvSfRcnj20TtUVLU9HQTaOgI5fDP+gOwd1/+RBbop5XfvPOnd39LpLOy6mygDk3nE
	 NGaWM1TVG0ebVc3El7dbiUwi/Qc//rEYBczXL4Oaz8uhvHeSyn+zXh9/jGTNb+4bAj
	 ohWfp1UtMB4AqJukodEHQ2zfmSBqT7njoyOXdRoaomEjb5yiwS9BZzIfuTP3+LzpD8
	 Zo26H8FokIbLVHH/TlZ+sCm1LnH9EFIDfJHjPrisuMVLN/jySlqZtlSDHhie/T359p
	 PkQP7bQs9gvesBmZRXZuTD0O7BwNAhA8iuh5y2oop7nCVAV1KXCmP/CHX+VStRCi7b
	 584OgAW21U0HA==
Message-ID: <sashiko-outbox-214605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/6] bonding: complete rollback of
 bond_enslave() error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113-bond_enslave_restruct-v1-3-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
 <20261113-bond_enslave_restruct-v1-3-364c549e78db@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:06:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] bonding: RCU use-after-free of new_slave in bond_enslave()
  ALB/TLB unwind
- [Medium] bonding: bond_alb_deinit_slave() in bond_enslave() corrupts
  MACs and RLB
- [Medium] bonding: wrong bond_3ad_unbind_slave() ordering in
  bond_enslave() unwind
--

commit fe641519a15c6edad3aff89eac3b2de3f443285d
Author: Hangbin Liu <hangbin.liu@linux.dev>

bonding: complete rollback of bond_enslave() error paths

This commit adds rollback steps in bond_enslave() to unbind 802.3ad slaves,
deinitialize ALB/TLB slave state, and restore the fail_over_mac setting on
error.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 80b6c18ee9c28..f696a0d150346 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> @@ -2388,6 +2391,8 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
>  	netdev_rx_handler_unregister(slave_dev);
> =20
>  err_detach:
> +	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
> +		bond_3ad_unbind_slave(new_slave);
>  	vlan_vids_del_by_dev(slave_dev, bond_dev);
>  	if (rcu_access_pointer(bond->primary_slave) =3D=3D new_slave)
>  		RCU_INIT_POINTER(bond->primary_slave, NULL);

[Severity: Medium]
Does calling bond_3ad_unbind_slave() at err_detach run too late when
new_slave was linked, and too early when enslavement failed before
bond_master_upper_dev_link()?

Unlike __bond_release_one(), which calls netdev_rx_handler_unregister() and
bond_3ad_unbind_slave() before bond_upper_dev_unlink(), bond_enslave()
unlinks new_slave from bond_slave_list(bond) at err_upper_unlink first.  If
new_slave is the only slave in an 802.3ad bond and
bond_3ad_state_machine_handler() activates its aggregator and raises
bond_dev's carrier before a later step such as dev_xdp_propagate() fails,
bond_upper_dev_unlink() empties the slave list before
bond_3ad_unbind_slave() runs.  Inside bond_3ad_unbind_slave(),
__get_first_agg(port) then returns NULL, skipping ad_agg_selection_logic()
and bond_3ad_set_carrier() and leaving carrier on with zero slaves.
Unlinking new_slave before netdev_rx_handler_unregister() also leaves the
active aggregator detached from bond_slave_list(bond) while
synchronize_net() sleeps.

Conversely, if bond_enslave() fails before bond_master_upper_dev_link()
(for example at netdev_rx_handler_register()), err_detach still calls
bond_3ad_unbind_slave(), which unconditionally calls ad_lacpdu_send(port)
and transmits an LACPDU on the unenslaved device.

> @@ -2402,6 +2407,8 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
>  	slave_disable_netpoll(new_slave);
> =20
>  err_close:
> +	if (alb_initialized)
> +		bond_alb_deinit_slave(bond, new_slave);
>  	if (!netif_is_bond_master(slave_dev))
>  		slave_dev->priv_flags &=3D ~IFF_BONDING;
>  	dev_close(slave_dev);

[Severity: Medium]
Can calling bond_alb_deinit_slave() after synchronize_rcu() cause a
use-after-free of new_slave?

Once bond_master_upper_dev_link() links new_slave into the bond, concurrent
TLB or ALB transmit paths can place new_slave into tx_hashtbl or
rx_hashtbl.  In __bond_release_one(), bond_alb_deinit_slave() clears those
hash tables before synchronize_rcu().  Here at err_close,
bond_alb_deinit_slave() runs after synchronize_rcu() at err_detach, with no
grace period before kobject_put(&new_slave->kobj) frees new_slave at
err_free:

CPU0                                  CPU1
bond_enslave()
  bond_master_upper_dev_link()
  ...
  goto err_set_xdp;
  bond_upper_dev_unlink()
  synchronize_rcu()
                                      rcu_read_lock()
                                      bond_do_alb_xmit()
                                        tlb_choose_channel()
                                          tx_slave =3D new_slave
  bond_alb_deinit_slave()
  ...
  kobject_put(&new_slave->kobj)
    kfree(new_slave)
                                        __tlb_clear_slave(bond, tx_slave)
                                          <-- use-after-free

[Severity: Medium]
Can calling bond_alb_deinit_slave() on an enslavement failure corrupt an
existing slave's MAC address or put the active slave into promiscuous mode?

bond_alb_init_slave() only updates new_slave->dev->dev_addr (and picks a
free permanent MAC if new_slave->perm_hwaddr collides with an existing
slave), while err_restore_mac already restores new_slave->dev->dev_addr to
new_slave->perm_hwaddr.  Because bond_select_active_slave() is only reached
after all error paths, no existing slave ever borrows new_slave's MAC
during bond_enslave().

When bond_alb_deinit_slave() calls alb_change_hw_addr_on_detach(), a
collision between new_slave->perm_hwaddr and an existing slave found_slave
causes it to swap new_slave's temporary MAC onto found_slave, overwriting
found_slave's legitimate MAC address:

drivers/net/bonding/bond_alb.c:alb_change_hw_addr_on_detach() {
    ...
	if (perm_curr_diff && perm_bond_diff) {
		found_slave =3D bond_slave_has_mac(bond, slave->perm_hwaddr);

		if (found_slave) {
			alb_swap_mac_addr(slave, found_slave);
			alb_fasten_mac_swap(bond, slave, found_slave);
		}
	}
}

In addition, when rlb_enabled is set, bond_alb_deinit_slave() calls
rlb_clear_slave().  Because new_slave is never curr_active_slave during
bond_enslave(), rlb_clear_slave() unconditionally calls
rlb_teach_disabled_mac_on_primary(bond, new_slave->dev->dev_addr), even if
bond_enslave() failed at vlan_vids_add_by_dev() before new_slave was linked
to the bond.  That puts curr_active_slave into promiscuous mode and sends
loopback learning packets with the unenslaved device's MAC address on
curr_active_slave.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-bond_ensla=
ve_restruct-v1-0-364c549e78db@kylinos.cn?part=3D3
