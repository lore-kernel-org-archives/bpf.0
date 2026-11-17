Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893469;
	b=PoP3t/lPO/V1cIb9z2/lYPgIlehcSzilwnZD8gM060tAn51Pr/MITqsXSKmWT4tQcCML
	 7kufEqPoIxfiO9P6+j4bl82zTAyIe42Gmfm1ZTUhOdn5yQFTpJ1TUpOYWVeo7URwQxbwa
	 nWVWfE6LRBlbJptjWDwfxdETAam1bLKEoxWDYzEyxsoFDd5LL99j9dSnsVjfah81ylknM
	 Y68VVSPaApBDE04mu7x1f0W1gtA769cGJtiFSd6ECcr2FoEaass3pY+2tMbAqYqJgA7Tn
	 +Vc2hwT+w69G/wVqpABvL0qvsZtBEVQB0CY2EsLlJHqQtXtUQyBf874HvSEWsIGpqqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893469;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r/sM/Jj2wdFi16ZrPLUHTMcxBJyo6JeG53yhHl3jZRA=;
	b=LfCn9YpKGf+A+gzZl0CRCuPNrKkCghsfb77BljS/UVexU9mPpJis8qjGKIG17lim7uTR
	 9nVFlA+lgj+IWZk5NUmDDqR8aIfOGkXJNDL5fzaVSJLyUUG5JxJvdKh7qlY9vTENGd8ap
	 AgU/+rt6Y9ul18ouh7hwPhyx0f1Uq/Q0JvpcuwXgHA7lx/tRWHtwna5SYyesigm4IaGxv
	 lc82YSpePb2No+APdve1G7aZccUaV7j9cAUBcxq7YCs3ggxxWk7nAJMko1jXg33OpD0ek
	 zG/nA6aNFefasCF341MExrREiTQ4GprqLvxf7+Ez4/VM9wPYtNYfQ0u2VXtmxvhw7GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vloBbTwU;
	arc=none smtp.remote-ip=91.218.175.136
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE72606A323
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 05:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE72606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vloBbTwU
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=98UK9QsxXUHlPakCW+t0VE/rPI1x7QMlW+6TDMpxSAg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794893465; v=1; x=1795498265;
 b=vloBbTwUM0YKlVtbiS52ZNwbutE0I/I/MkoeRVxNOI3Sf+cyIFSSmK0CvpSYdrLTyzuvzxEw
 4BGLGNMr2NLh24txlfnKzZW91/nig/2ZtKsSjSRiCB0fQJFDz2KizJrV6GuiKYP001Cuz3fDX7v
 5UTJfwo5WBSttF2Wj6PVvFck=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 802b0e247c17ad5c;
	Tue, 17 Nov 2026 05:31:05 +0000
X-Mizu-Trace-ID: 802b0e247c17ad5c
X-Migadu-Flow: FLOW_OUT
Date: Tue, 17 Nov 2026 13:30:55 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] bonding: complete rollback of
 bond_enslave() error paths
Message-ID: <avvmjw8sDcHYoPIU@fedora>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
 <20261113-bond_enslave_restruct-v1-3-364c549e78db@kylinos.cn>
 <sashiko-outbox-214605@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214605@kernel.org>

On Sat, Nov 14, 2026 at 02:06:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] bonding: RCU use-after-free of new_slave in bond_enslave()
>   ALB/TLB unwind
> - [Medium] bonding: bond_alb_deinit_slave() in bond_enslave() corrupts
>   MACs and RLB
> - [Medium] bonding: wrong bond_3ad_unbind_slave() ordering in
>   bond_enslave() unwind
> --
> 
> commit fe641519a15c6edad3aff89eac3b2de3f443285d
> Author: Hangbin Liu <hangbin.liu@linux.dev>
> 
> bonding: complete rollback of bond_enslave() error paths
> 
> This commit adds rollback steps in bond_enslave() to unbind 802.3ad slaves,
> deinitialize ALB/TLB slave state, and restore the fail_over_mac setting on
> error.
> 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 80b6c18ee9c28..f696a0d150346 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> 
> [ ... ]
> 
> > @@ -2388,6 +2391,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  	netdev_rx_handler_unregister(slave_dev);
> >  
> >  err_detach:
> > +	if (BOND_MODE(bond) == BOND_MODE_8023AD)
> > +		bond_3ad_unbind_slave(new_slave);
> >  	vlan_vids_del_by_dev(slave_dev, bond_dev);
> >  	if (rcu_access_pointer(bond->primary_slave) == new_slave)
> >  		RCU_INIT_POINTER(bond->primary_slave, NULL);
> 
> [Severity: Medium]
> Does calling bond_3ad_unbind_slave() at err_detach run too late when
> new_slave was linked, and too early when enslavement failed before
> bond_master_upper_dev_link()?
> 
> Unlike __bond_release_one(), which calls netdev_rx_handler_unregister() and
> bond_3ad_unbind_slave() before bond_upper_dev_unlink(), bond_enslave()
> unlinks new_slave from bond_slave_list(bond) at err_upper_unlink first.  If
> new_slave is the only slave in an 802.3ad bond and
> bond_3ad_state_machine_handler() activates its aggregator and raises
> bond_dev's carrier before a later step such as dev_xdp_propagate() fails,
> bond_upper_dev_unlink() empties the slave list before
> bond_3ad_unbind_slave() runs.  Inside bond_3ad_unbind_slave(),
> __get_first_agg(port) then returns NULL, skipping ad_agg_selection_logic()
> and bond_3ad_set_carrier() and leaving carrier on with zero slaves.
> Unlinking new_slave before netdev_rx_handler_unregister() also leaves the
> active aggregator detached from bond_slave_list(bond) while
> synchronize_net() sleeps.

Hmm, maybe we need to call bond_3ad_unbind_slave() before and after
bond_3ad_unbind_slave().

> 
> Conversely, if bond_enslave() fails before bond_master_upper_dev_link()
> (for example at netdev_rx_handler_register()), err_detach still calls
> bond_3ad_unbind_slave(), which unconditionally calls ad_lacpdu_send(port)
> and transmits an LACPDU on the unenslaved device.
> 
> > @@ -2402,6 +2407,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  	slave_disable_netpoll(new_slave);
> >  
> >  err_close:
> > +	if (alb_initialized)
> > +		bond_alb_deinit_slave(bond, new_slave);
> >  	if (!netif_is_bond_master(slave_dev))
> >  		slave_dev->priv_flags &= ~IFF_BONDING;
> >  	dev_close(slave_dev);
> 
> [Severity: Medium]
> Can calling bond_alb_deinit_slave() after synchronize_rcu() cause a
> use-after-free of new_slave?
> 
> Once bond_master_upper_dev_link() links new_slave into the bond, concurrent
> TLB or ALB transmit paths can place new_slave into tx_hashtbl or
> rx_hashtbl.  In __bond_release_one(), bond_alb_deinit_slave() clears those
> hash tables before synchronize_rcu().  Here at err_close,
> bond_alb_deinit_slave() runs after synchronize_rcu() at err_detach, with no
> grace period before kobject_put(&new_slave->kobj) frees new_slave at
> err_free:
> 
> CPU0                                  CPU1
> bond_enslave()
>   bond_master_upper_dev_link()
>   ...
>   goto err_set_xdp;
>   bond_upper_dev_unlink()
>   synchronize_rcu()
>                                       rcu_read_lock()
>                                       bond_do_alb_xmit()
>                                         tlb_choose_channel()
>                                           tx_slave = new_slave
>   bond_alb_deinit_slave()
>   ...
>   kobject_put(&new_slave->kobj)
>     kfree(new_slave)
>                                         __tlb_clear_slave(bond, tx_slave)
>                                           <-- use-after-free

Yes, we need to call bond_alb_deinit_slave() before synchronize_rcu().

> 
> [Severity: Medium]
> Can calling bond_alb_deinit_slave() on an enslavement failure corrupt an
> existing slave's MAC address or put the active slave into promiscuous mode?
> 
> bond_alb_init_slave() only updates new_slave->dev->dev_addr (and picks a
> free permanent MAC if new_slave->perm_hwaddr collides with an existing
> slave), while err_restore_mac already restores new_slave->dev->dev_addr to
> new_slave->perm_hwaddr.  Because bond_select_active_slave() is only reached
> after all error paths, no existing slave ever borrows new_slave's MAC
> during bond_enslave().
> 
> When bond_alb_deinit_slave() calls alb_change_hw_addr_on_detach(), a
> collision between new_slave->perm_hwaddr and an existing slave found_slave
> causes it to swap new_slave's temporary MAC onto found_slave, overwriting
> found_slave's legitimate MAC address:
> 
> drivers/net/bonding/bond_alb.c:alb_change_hw_addr_on_detach() {
>     ...
> 	if (perm_curr_diff && perm_bond_diff) {
> 		found_slave = bond_slave_has_mac(bond, slave->perm_hwaddr);
> 
> 		if (found_slave) {
> 			alb_swap_mac_addr(slave, found_slave);
> 			alb_fasten_mac_swap(bond, slave, found_slave);
> 		}
> 	}
> }
> 
> In addition, when rlb_enabled is set, bond_alb_deinit_slave() calls
> rlb_clear_slave().  Because new_slave is never curr_active_slave during
> bond_enslave(), rlb_clear_slave() unconditionally calls
> rlb_teach_disabled_mac_on_primary(bond, new_slave->dev->dev_addr), even if
> bond_enslave() failed at vlan_vids_add_by_dev() before new_slave was linked
> to the bond.  That puts curr_active_slave into promiscuous mode and sends
> loopback learning packets with the unenslaved device's MAC address on
> curr_active_slave.

Maybe we only call bond_alb_deinit_slave() once before synchronize_rcu().
Not sure yet, need to debug.

--
pw-bot: cr
