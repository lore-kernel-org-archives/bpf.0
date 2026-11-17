Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926412;
	b=l5M4BfNIrIAO1SQiriBfcyIqW02U7X1N5ZC1qxcHNiNYWnb8JIVGB0877X5tnQUI2GvM
	 l35xY2jmebxN3NM0uxxDiVoiMrrBbV+ycVwd6zacA69KQef/i+Z7rJlZK3SqS4bu+jge1
	 pXEiMaavlUYd9N16mAO944OCTrBZK63EmekKvRDidF1rdoQ4Aul0d+f/rf1taEsOzSFGt
	 2cIrLdMpGVwvIlG46YSCMfHtkSmEjq99L/IT4gaJgBMrsr6rdBEnghbG6BCC37eh/g6TV
	 BcZOpF1VsNBFqAzNFu/6cpPfLVlJLcYJZMqMMDishM1FaP4sM+HhOtj07qK64IJqfUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926412;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TWnxaf/P2LbxkzV1C/GOLBHBzl9offsC1DgYq3tjTuU=;
	b=0OjhVMiAZIvmiEKI6mFbTulGMoVtAVk8Xqk93yFpN9VFMVn2sCqOBo2Wl8Yu5A1FxYLI
	 Jp3qHLXKYw6ipDTHqCGlRqbYAh49jMHNJhf/CGOFsNKNqvZcLG7cdOwalb5sS8ChFdBCD
	 6ryEHUH3MHYvz9RRVPorLDf3pOt1cffSKzJrYSv5wl1gDj8F5rXW4Si0BZ9s9GWc7LO16
	 cT4tLvJkMa1j6VN3SVg4cbztPh9kQwF3xOIae0DnIRH11D+LPwnbrWyK5xH7kZjoHqqFN
	 kJ/PIHmKq8BktEngogoWO+/GFOfv3Pc/T0GERdsJ97CfNz4NcYrpU/lsnd4iKfSA8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTWrjZew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F99606A8A9;
	Tue, 17 Nov 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTWrjZew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB9B1F000C4;
	Tue, 17 Nov 2026 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926411;
	bh=TWnxaf/P2LbxkzV1C/GOLBHBzl9offsC1DgYq3tjTuU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RTWrjZew0Pc9G0ciPptxBVLDE8GmsMEu3Ph4bb3YuQutnQ7TM7ACq52ZgOAJLNo4w
	 bcXdP8aRXFzjolvvHJtHdj1CJxxejDbqFFbZzbK9C4R6uHzcePk8qbAwvIsV7mSmKT
	 jy9mD4hxi1AfDByMT7gi9P0VuRXphaz1/cRG8JN5M7MzTEXjXIrYFFTeW7qweoSYC2
	 +/fT1JFL0NzOYIhDBiOkd4ECDV2ODmWjHdqkO4xaI0Y2HhvdPm1t6VWUdYPUKa2KQL
	 t3cnb94uzFHR42QAftI50SI5kIhU/vO0hQCW2jjGXa1izeihg4wdmxqBGzQvGFk95p
	 rSgXLDCxL4gng==
Subject: Re: [PATCH net-next 3/6] bonding: complete rollback of bond_enslave()
 error paths
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Tue, 17 Nov 2026 14:40:10 +0000
Message-ID: <179492641070.3136.17249256302231076989@kernel.org>
In-Reply-To: <20261113-bond_enslave_restruct-v1-3-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-3-364c549e78db@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The bond_enslave() unwind (err_set_xdp → err_sysfs_del →
  err_upper_unlink → err_unregister → err_detach) clears…
- [High] The new bond_alb_deinit_slave() call sits at err_close (line
  2411).
- [Medium] bond_3ad_unbind_slave() discards the 'slave array needs
  update' result of ad_agg_selection_logic().
- [Medium] The commit message says all three added cleanups are ones
  "that the release path (__bond_release_one) already performs".
- [Low] The commit describes its changes as cleanups that are "missing"
  and state "left behind", and it has no Fixes: tag or stable Cc.
- [Low] The commit author address (Hangbin Liu <hangbin.liu@linux.dev>)
  does not match the Signed-off-by address (Hangbin Liu…

--

bonding: complete rollback of bond_enslave() error paths

This patch adds three steps to the bond_enslave() error unwind:
bond_alb_deinit_slave() for TLB/ALB, bond_3ad_unbind_slave() for 802.3ad,
and restoring bond->params.fail_over_mac after it was automatically set to
"active". The goal is to match what __bond_release_one() does on release.

> The bond_enslave() undo labels are missing three cleanups that the
> release path (__bond_release_one) already performs:
>
> - If bond_alb_init_slave() succeeds but a later step fails, the
>   slave is never passed to bond_alb_deinit_slave(), leaving TLB/RLB
>   state and a possibly borrowed MAC address behind.

[ ... ]

> - When fail_over_mac is automatically set to "active" because the
>   first slave cannot change its MAC address, a subsequent failure
>   leaves the modified parameter on the bond.

[Severity: Medium]
Is it accurate that all three cleanups are ones the release path already
performs? __bond_release_one() never writes bond->params.fail_over_mac.
The only writers are the automatic setting in bond_enslave(), the restore
added here, and the module parameter init. So the restore looks like new
behaviour rather than parity with release.

The "possibly borrowed MAC address" part also looks off. In TLB/ALB mode
BOND_MODE() is not BOND_MODE_ACTIVEBACKUP, so err_restore_mac already puts
perm_hwaddr back on the slave:

err_restore_mac:
	slave_dev->priv_flags &= ~IFF_NO_ADDRCONF;
	if (!bond->params.fail_over_mac ||
	    BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
		...
		bond_hw_addr_copy(ss.__data, new_slave->perm_hwaddr,
				  new_slave->dev->addr_len);
		ss.ss_family = slave_dev->type;
		dev_set_mac_address(slave_dev, &ss, NULL);
	}

The message does not mention what the new bond_alb_deinit_slave() call
does change. If the bond already has slaves, it calls
alb_change_hw_addr_on_detach():

drivers/net/bonding/bond_alb.c:alb_change_hw_addr_on_detach() {
	...
	if (perm_curr_diff && perm_bond_diff) {
		found_slave = bond_slave_has_mac(bond, slave->perm_hwaddr);

		if (found_slave) {
			alb_swap_mac_addr(slave, found_slave);
			alb_fasten_mac_swap(bond, slave, found_slave);
		}
	}
}

Can a failed enslave now change the MAC address of an existing slave that
is still enslaved, and send learning packets? Here is how that could
happen in TLB/ALB mode:

- The new slave's MAC matches an existing slave's current MAC, so
  alb_handle_addr_collision_on_attach() gives it a free address.
- vlan_vids_add_by_dev() or bond_sysfs_slave_add() then fails.

Could the commit message be updated to describe what these changes
actually do?

> Add undo steps for these 3 cleanups when error out.
>
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

[Severity: Low]
Should this carry Fixes: tags? The message calls these missing cleanups
and leftover state. At least two of them are dangling pointers to a
struct slave that err_free has already freed through
kobject_put()->slave_kobj_release()->kfree().

In 802.3ad mode, bond_3ad_state_machine_handler() runs under RCU and
mode_lock without RTNL. After bond_master_upper_dev_link() it can link the
new port into an aggregator's lag_ports chain.

In TLB/ALB mode, tlb_get_least_loaded_slave() can cache the new slave in
tx_hashtbl[].tx_slave, and the RLB code can cache it in rx_hashtbl and
rx_slave.

Without Fixes: tags and a mention of the use-after-free, stable tooling
may never pick these fixes up.

[Severity: Low]
This isn't a bug, but the Signed-off-by address (liuhangbin@kylinos.cn)
does not match the author address (hangbin.liu@linux.dev). checkpatch
reports this as FROM_SIGN_OFF_MISMATCH. The other patches in the series
have the same mismatch.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 80b6c18ee9c28..f696a0d150346 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> @@ -2388,6 +2391,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	netdev_rx_handler_unregister(slave_dev);
>  
>  err_detach:
> +	if (BOND_MODE(bond) == BOND_MODE_8023AD)
> +		bond_3ad_unbind_slave(new_slave);

[Severity: Medium]
Does this need a bond_update_slave_arr() call afterwards?

bond_3ad_unbind_slave() ignores the update result from
ad_agg_selection_logic() and leaves the array rebuild to its caller:

drivers/net/bonding/bond_3ad.c:bond_3ad_unbind_slave() {
	...
	bool dummy_slave_update; /* Ignore this value as caller updates array */
	...
}

__bond_release_one() rebuilds the array right after the unbind:

	if (BOND_MODE(bond) == BOND_MODE_8023AD)
		bond_3ad_unbind_slave(slave);

	bond_upper_dev_unlink(bond, slave);

	if (bond_mode_can_use_xmit_hash(bond) ||
	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
		bond_update_slave_arr(bond, slave);

The bond_enslave() unwind never calls bond_update_slave_arr(). Suppose
unbinding the half-enslaved port makes ad_agg_selection_logic() choose a
new active aggregator. Could the usable_slaves and all_slaves arrays then
stay stale until some unrelated event rebuilds them?
bond_slave_arr_work_rearm() from the state machine may cover some of
these cases, but it is not clear that it covers all of them.

The ordering also differs from release. Here the unbind runs after
err_upper_unlink, so the bond_for_each_slave() loops inside
bond_3ad_unbind_slave() no longer see the departing slave's own
aggregator. Is that intended?

>  	vlan_vids_del_by_dev(slave_dev, bond_dev);
>  	if (rcu_access_pointer(bond->primary_slave) == new_slave)
>  		RCU_INIT_POINTER(bond->primary_slave, NULL);

[Severity: High]
Since this patch completes the rollback against __bond_release_one(),
should bond->current_arp_slave also be cleared here? The release path
clears it unconditionally:

	RCU_INIT_POINTER(bond->current_arp_slave, NULL);

The unwind only clears primary_slave and curr_active_slave before
synchronize_rcu().

In active-backup mode with arp_interval set, bond_ab_arp_probe() runs from
arp_work with only rcu_read_lock() held. Once bond_master_upper_dev_link()
has linked new_slave, the probe can publish it while bond_enslave() still
holds RTNL:

bond_activebackup_arp_mon()
  bond_ab_arp_probe()
    curr_arp_slave = bond_first_slave_rcu(bond);
    ...
    rcu_assign_pointer(bond->current_arp_slave, new_slave);

For the first slave there is no curr_active_slave yet, because
bond_select_active_slave() only runs from bond_publish_slave().

If dev_xdp_propagate() or bond_sysfs_slave_add() then fails, err_free
calls kobject_put(&new_slave->kobj) and the slave is freed. But
bond->current_arp_slave still points at it, and later users dereference
it:

bond_ab_arp_commit():
	current_arp_slave = rtnl_dereference(bond->current_arp_slave);
	...
	bond_set_slave_inactive_flags(
		current_arp_slave,
		BOND_SLAVE_NOTIFY_NOW);

bond_arp_rcv():
	else if (curr_arp_slave && (arp->ar_op == htons(ARPOP_REPLY)) &&
		 bond_time_in_interval(bond, slave_last_tx(curr_arp_slave), 1))

Can this cause a use-after-free of the freed struct slave? A received ARP
reply is enough to reach the bond_arp_rcv() read, and bond_na_rcv() and
the netdev_info() print of curr_arp_slave->dev->name in
bond_ab_arp_probe() follow the same pattern.

[ ... ]

> @@ -2402,6 +2407,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	slave_disable_netpoll(new_slave);
>  
>  err_close:
> +	if (alb_initialized)
> +		bond_alb_deinit_slave(bond, new_slave);

[Severity: High]
Does this call come after the grace period it depends on? The only
synchronize_rcu() in the unwind is in err_detach, above this label. After
bond_alb_deinit_slave() clears tx_hashtbl and rx_hashtbl, nothing waits
for readers before err_free calls kobject_put(&new_slave->kobj) and frees
the slave.

In TLB/ALB mode the new slave can transmit once
bond_master_upper_dev_link() has linked it, so
tlb_get_least_loaded_slave() can cache it in tx_hashtbl[].tx_slave.

Suppose bond_sysfs_slave_add() fails. A transmit can start after
synchronize_rcu() returns but before tlb_clear_slave() takes mode_lock.
It picks up the cached pointer and keeps using it after dropping the
lock:

bond_tlb_xmit() / bond_alb_xmit()
  bond_xmit_tlb_slave_get() / bond_xmit_alb_slave_get()
    tlb_choose_channel()
	spin_lock(&bond->mode_lock);
	tx_slave = __tlb_choose_channel(bond, hash_index, skb_len);
	spin_unlock(&bond->mode_lock);
  bond_do_alb_xmit()
	if (tx_slave && bond_slave_can_tx(tx_slave)) {
	...
	if (tx_slave && bond->params.tlb_dynamic_lb) {
		spin_lock(&bond->mode_lock);
		__tlb_clear_slave(bond, tx_slave, 0);

tlb_clear_slave() only takes mode_lock, so it cannot wait for a reader
that has already dropped the lock. dev_close(slave_dev) does not guarantee
a grace period either. dev_deactivate_many() only calls synchronize_net()
when sync_needed is set, and it is not set for noqueue slaves.

__bond_release_one() calls bond_alb_deinit_slave() before its
synchronize_rcu(). Should this call move into err_detach, ahead of the
synchronize_rcu() there, so new_slave cannot be used after it is freed?

>  	if (!netif_is_bond_master(slave_dev))
>  		slave_dev->priv_flags &= ~IFF_BONDING;
>  	dev_close(slave_dev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-bond_enslave_restruct-v1-0-364c549e78db%40kylinos.cn
