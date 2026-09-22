Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C63815D3;
	Tue, 22 Sep 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040675; cv=none; b=W0rduIw6njYBidWUXdu7kW3iRPL71uXvwbSko+1U2f7vAK6+oyocDCUN9ovOG7VGjT6ax2VWI2Jn83GnxEMiwwB9IoY9coG88SX7eFcnq40EIcpOG4op+l7AwTeTY8BsOOegkLGuEqyJ6uYgF+Pyemk6WokBWCpE7BDzxc6ai2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040675; c=relaxed/simple;
	bh=V9SpNQbsgfkzyv2k/+hD8cRjEpWWrBexPTwRYfHYimE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRiaLmQlB2b/Ev3aofuPJfOSvnKM9KszFdhqLg3r2b0XSZqvQ+bj6q7mB2+8Q3zKB9cD4eNmoGgMyJ/VQN3k/NvinlTM6H3GuqZTaVW7UoC5GV0ROGR3gGvxSqea/FFd6qKnzFw+4l55Nu6qPHYlAn+n60brFh7E2a7PapV+uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax1dYJsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax1dYJsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FCC1F00899;
	Tue, 22 Sep 2026 01:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040674;
	bh=xewNfa1Hs/ZoeGXM8ztNZJZxmuT8z51qUI+OT+vlhDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ax1dYJsW/jY7P3xTpx5+FlRRGeLHPZOfzQmexaxAuLRIdmdnb0w3Uj4XlHU0pC5xf
	 hxhRbufW0m9PYzR7q0hiGTMohlaudJ3fPBNOzlNPfKWIoURMzC3AGlWKEVFVzoysmN
	 FhNc5CKMkNrq27QTcBrbXwm3BAv66LZqW0sqvibW6AV3uWjQVVKZdQ35wyVP5hlYEB
	 XWXSOdVH5lirx+wpLNa/VABICTyDGR495wokT5k7J7nJKD1S0o+Bug8sIkilynG6KM
	 BYQn4ThLF+snW/QPhCVSFgsFhGVR92DNZ9wM75AKUYz10axbCmRTa1TA72C7ZrnY62
	 vmP8aUAVoWKFQ==
Subject: Re: [PATCH net 6/8] i40e: do not expose netdev too early
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, zhaochenguang@kylinos.cn,
 magnus.karlsson@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, horms@kernel.org,
 kerneljasonxing@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org, sunithax.d.mekala@intel.com
Date: Tue, 22 Sep 2026 01:31:12 +0000
Message-ID: <179004067224.2160803.5016911027685852459@kernel.org>
In-Reply-To: <20260918212458.550425-7-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-7-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch narrows but does not close the window it claims to
  close for the driver's primary netdev.
- [Low] Dead error-path code left behind by the reordering: the block at
  i40e_main.c:14498-14502 (`err_rings: if (vsi->netdev_registered) {…
- [Low] Two pieces of externally visible netdev state are still installed
  after registration, contradicting the 'publish late' invariant the…

--

i40e: do not expose netdev too early

This moves register_netdev() in i40e_vsi_setup() from the middle of the
netdev setup case to the end of the function, after ring and q_vector
allocation, ring-to-vector mapping and VMDQ2 RSS configuration.  The
error path is reworked so an allocated but unregistered netdev is still
freed.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2b4b061302db..82037faf960f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14449,15 +14449,6 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  				goto err_netdev;
>  			SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
>  		}
> -		ret = register_netdev(vsi->netdev);
> -		if (ret)
> -			goto err_dl_port;
> -		vsi->netdev_registered = true;
> -		netif_carrier_off(vsi->netdev);
> -#ifdef CONFIG_I40E_DCB
> -		/* Setup DCB netlink interface */
> -		i40e_dcbnl_setup(vsi);
> -#endif /* CONFIG_I40E_DCB */
>  		fallthrough;
>  	case I40E_VSI_FDIR:
>  		/* set up vectors and rings if needed */
> @@ -14485,6 +14476,19 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  		if (ret)
>  			goto err_config;
>  	}
> +
> +	if (vsi->netdev) {
> +		ret = register_netdev(vsi->netdev);
> +		if (ret)
> +			goto err_config;
> +		vsi->netdev_registered = true;

[Severity: High]
For the MAIN VSI, does this really close the window described in the
commit message?  register_netdev() is still called from inside
i40e_vsi_setup(), which runs from
i40e_probe() -> i40e_setup_pf_switch() -> i40e_vsi_setup().

After i40e_vsi_setup() returns for the MAIN VSI, i40e_setup_pf_switch()
still programs PF-wide state the datapath depends on:

	i40e_vlan_stripping_disable(main_vsi);
	i40e_fdir_sb_setup(pf);
	ret = i40e_setup_pf_filter_control(pf);
	...
	if (test_bit(I40E_FLAG_RSS_ENA, pf->flags))
		i40e_pf_config_rss(pf);
	i40e_link_event(pf);
	i40e_ptp_init(pf);

Note that only VMDQ2 gets RSS configured inside i40e_vsi_setup():

	if (test_bit(I40E_HW_CAP_RSS_AQ, pf->hw.caps) &&
	    vsi->type == I40E_VSI_VMDQ2) {
		ret = i40e_vsi_config_rss(vsi);

so the MAIN netdev is published before PFQF_HENA/HKEY/HLUT, PFQF_CTL_0 and
the VLAN strip configuration are written.  Back in i40e_probe(),
__I40E_DOWN is cleared and i40e_setup_misc_vector() arms the ICR0 admin
queue vector only after i40e_setup_pf_switch() has returned.

i40e_open() gates on:

	if (test_bit(__I40E_TESTING, pf->state) ||
	    test_bit(__I40E_BAD_EEPROM, pf->state))
		return -EBUSY;

which does not test __I40E_DOWN or any probe-complete state, and
register_netdev() drops RTNL before returning while probe holds no lock
that blocks rtnetlink.  Can a concurrent "ip link set up" (udev or
NetworkManager reacting to the freshly published ifindex) therefore reach
i40e_vsi_open() -> i40e_up_complete() while the PF's global hardware state
is still being programmed and while i40e_intr() still refuses to service
ICR0 because __I40E_DOWN is set?

There is also the probe failure case.  i40e_setup_pf_switch() returns the
(otherwise non-fatal) i40e_setup_pf_filter_control() error, and a
i40e_setup_misc_vector() failure jumps to err_vsis:

	err_vsis:
		set_bit(__I40E_DOWN, pf->state);
		i40e_ptp_stop(pf);
		i40e_clear_interrupt_scheme(pf);
		kfree(pf->vsi);

with no unregister_netdev() anywhere on that path, and err_switch_setup
then frees the PF itself.  Does this leave an already registered, possibly
already opened netdev in the system whose netdev_priv()->vsi->back points
at freed memory, so a later ndo_open, ndo_get_stats64, ethtool or close
touches freed q_vectors and a freed struct i40e_pf?

Would registering the netdev only once i40e_probe() has completed, or
gating ndo_open on a "PF ready" state, be a more complete fix than moving
registration a few statements later inside i40e_vsi_setup()?

> +		netif_carrier_off(vsi->netdev);
> +#ifdef CONFIG_I40E_DCB
> +		/* Setup DCB netlink interface */
> +		i40e_dcbnl_setup(vsi);
> +#endif /* CONFIG_I40E_DCB */
> +	}

[Severity: Low]
Since the commit declares the "publish late" invariant, should these two
steps move ahead of register_netdev() as well?

register_netdev() emits NETDEV_REGISTER/RTM_NEWLINK and drops RTNL before
returning, while alloc_etherdev_mq() leaves __LINK_STATE_NOCARRIER clear.
Can the initial link notification therefore advertise IFF_LOWER_UP, with a
carrier-down linkwatch event following immediately once
netif_carrier_off() runs?  netif_carrier_off() sets the bit before its
early return:

net/sched/sch_generic.c:netif_carrier_off() {
	if (!test_and_set_bit(__LINK_STATE_NOCARRIER, &dev->state)) {
		if (dev->reg_state == NETREG_UNINITIALIZED)
			return;
	...
}

so it looks intended to be callable before registration.

Similarly, i40e_dcbnl_setup() installs the ops and only then populates the
state:

drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c:i40e_dcbnl_setup() {
	dev->dcbnl_ops = &dcbnl_ops;

	/* Set initial IEEE DCB settings */
	i40e_dcbnl_set_all(vsi);
}

Does a DCB request arriving between register_netdev() and the dcbnl_ops
assignment get -EOPNOTSUPP from dcb_doit() on a DCB-capable port:

net/dcb/dcbnl.c:dcb_doit() {
	if (!netdev->dcbnl_ops)
		return -EOPNOTSUPP;
	...
}

and is there a second window where dcbnl_ops is live but
i40e_dcbnl_set_all() has not run yet?  Assigning dcbnl_ops and clearing
carrier before register_netdev(), leaving only i40e_dcbnl_set_all()
afterwards, would avoid both windows.

> +
>  	return vsi;
>  
>  err_config:
> @@ -14495,13 +14499,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
> -		free_netdev(vsi->netdev);
> -		vsi->netdev = NULL;
>  	}

[Severity: Low]
Is this err_rings block still reachable after the reordering?

i40e_vsi_mem_alloc() sets vsi->netdev_registered = false for every VSI, and
after this patch the only assignment of true sits after every
goto err_config/err_qvec/err_rings/err_netdev in i40e_vsi_setup(), followed
only by netif_carrier_off(), i40e_dcbnl_setup() and "return vsi".  If
register_netdev() itself fails the flag is still false, so the condition
looks always false when the unwind path runs.

Would dropping it be clearer, so a later patch adding a step after
registration does not assume the unwind already deregisters the netdev?

> -err_dl_port:
>  	if (vsi->type == I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  err_netdev:
> +	if (vsi->netdev) {
> +		free_netdev(vsi->netdev);
> +		vsi->netdev = NULL;
> +	}
>  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
>  err_vsi:
>  	i40e_vsi_clear(vsi);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
