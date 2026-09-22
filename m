Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AA37F8B6;
	Tue, 22 Sep 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040673; cv=none; b=Z3OD5bj//M67NzrMAE6xmE1J/9FsqssUf//ZZ7l+s0mBD2JkTgXmICPsY6rVeroiMoHbQJ7mRTp+jFfRz32yV0ZILThIBA6dkuEbZk6RU5P+kIVcelkZDRD6ImB56iGLCfqnWZHmMHDSc/1Nrh32Q7mejB500zxM4t/u2GjHGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040673; c=relaxed/simple;
	bh=uoLGOVgwBogdF69VCBugkWjTqnm+x9t4v+V4vt3bIcM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sF6pBc7x1kAM6vSTH4qbTd6uQgnLUTB/nsM7ZHT1kk8lIvoB9h075EHD+t/QVMhkoDiKhCNQ/tY4bt8uhlOeoMsIBzsnxBq5NRiwNBSnKcdQLntDC+8+0MIwxbPXqhocDcuIlC9HvBJtX+9G2uMkSxewFxFhFZ5xhBdcTQfwE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFXRAK0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFXRAK0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F691F00893;
	Tue, 22 Sep 2026 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040672;
	bh=bDWGwR/NPr1WssQaVehT1pIEJDZprbebaZQr51+3LGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZFXRAK0sXqInpy2FVGHYmmybSUawsZcPeHizG7MPrdS8q9KC8J3IrLZ/bGB6Pbixp
	 v7JUrfO6dC/jSjXR6cB666d2+qiLENdulj4r1aAODhTA5ehvj+OBQTZ2ewVT9tjmYf
	 QLOULjL7Phj/UYu74LQSGV7iqeyyjzx/4Td1ltlKGLajVXLBQ2Sjh15BH2TiUFps/p
	 daSFVoB1SXr/AZDzhkRkFOknGj2YIou6CoU2SNjMtBObrvxLoD0jTYWXAzaIHzHqp3
	 9rv05XVPNji0m+BLkCc3mHDTYI6IbhFujx5+NIjiCG0W2H1UhfyuGew87wnrxutfFv
	 qX82y2KfF5hVg==
Subject:
 Re: [PATCH net 4/8] i40e: avoid deadlock when calling unregister_netdev()
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
Date: Tue, 22 Sep 2026 01:31:10 +0000
Message-ID: <179004067040.2160803.1559812086096525304@kernel.org>
In-Reply-To: <20260918212458.550425-5-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-5-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the RTNL self-deadlock is only removed from the
  i40e_vsi_reinit_setup() arm of i40e_setup_pf_switch().

Pre-existing issues:
- [High] Dangling main-VSI references after a failed VSI reinit.
- [Medium] NULL pointer dereference when the reinit unwind re-enters
  ndo_stop after q_vectors/rings were released.
- [Medium] Memory leak in the asymmetric unwind of
  i40e_vsi_reinit_setup() as it exists at this commit: the two early…

--

i40e: avoid deadlock when calling unregister_netdev()

This adds a lock_acquired parameter to i40e_vsi_reinit_setup() so the
err_netdev unwind uses unregister_netdevice() when RTNL is already held by
the rebuild path, and unregister_netdev() otherwise. The caller in
i40e_setup_pf_switch() forwards its own lock_acquired flag.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 65aa50330aac..5ea8731ece08 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c

[ ... ]

> @@ -14308,7 +14310,10 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
> -		unregister_netdev(vsi->netdev);
> +		if (lock_acquired)
> +			unregister_netdevice(vsi->netdev);
> +		else
> +			unregister_netdev(vsi->netdev);
>  		free_netdev(vsi->netdev);
>  		vsi->netdev = NULL;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but now that this unwind can
actually run to completion instead of deadlocking, what happens to
pf->lan_vsi afterwards?

The tail of this path is:

	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
	i40e_vsi_clear(vsi);
	return NULL;

and i40e_vsi_clear() does:

	pf->vsi[vsi->idx] = NULL;
	...
free_vsi:
	kfree(vsi);

pf->lan_vsi is never reset to I40E_NO_VSI, so i40e_pf_get_main_vsi()
returns NULL from then on.

After i40e_setup_pf_switch() returns -EAGAIN, i40e_rebuild() only clears
__I40E_RESET_FAILED, __I40E_RESET_RECOVERY_PENDING and
__I40E_TIMEOUT_RECOVERY_PENDING; neither __I40E_DOWN nor __I40E_SUSPENDED
is set, so the service task keeps running. Can the next watchdog tick or
link event then oops in i40e_link_event(), which dereferences the main VSI
with no NULL check?

	if (new_link == old_link &&
	    new_link_speed == old_link_speed &&
	    (test_bit(__I40E_VSI_DOWN, vsi->state) ||
	     new_link == netif_carrier_ok(vsi->netdev)))
		return;
	...
	i40e_print_link_message(vsi, new_link);

There is also the ethtool -L caller. i40e_reconfig_rss_queues() caches the
main VSI pointer, calls the void i40e_reset_and_rebuild(pf, true, true) and
then keeps using the pointer:

	i40e_reset_and_rebuild(pf, true, true);
	...
	if (queue_count < vsi->rss_size) {
	...
	qcount = vsi->num_queue_pairs / vsi->tc_config.numtc;

Does that dereference a VSI that this error path already kfree()d, since the
rebuild failure is not reported back to the caller?

[Severity: Medium]
This is a pre-existing issue, but the ordering between err_rings and
err_netdev looks worth a second look now that the unregister actually
proceeds under RTNL.

err_rings calls i40e_vsi_free_q_vectors(vsi), which NULLs every
vsi->q_vectors[i], and then falls through to this unregister. Both
unregister_netdevice() and unregister_netdev() reach
unregister_netdevice_many_notify() -> netif_close_many(), which calls
ndo_stop for any device that still has IFF_UP set:

net/core/dev.c:netif_close_many() {
	list_for_each_entry_safe(dev, tmp, head, close_list)
		if (!(dev->flags & IFF_UP))
			list_del_init(&dev->close_list);

	__dev_close_many(head);
}

IFF_UP is still set because the reset quiesce calls ndo_stop directly rather
than dev_close():

i40e_quiesce_vsi() {
	...
		vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
	...
}

So i40e_close() -> i40e_vsi_close() runs on the already dismantled VSI:

	if (!test_and_set_bit(__I40E_VSI_DOWN, vsi->state))
		i40e_down(vsi);

and i40e_down() -> i40e_napi_disable_all() dereferences the freed vector
array without a NULL check:

		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];

		if (q_vector->rx.ring || q_vector->tx.ring)

__I40E_VSI_DOWN can still be clear here, since i40e_prep_for_reset()
returns early and skips i40e_pf_quiesce_all_vsi() when a reset is already
pending:

	if (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
		return;

Can this combination oops in i40e_napi_disable_all(), or is there something
in the ethtool/ndo entry points that prevents a reinit from starting while
another reset is pending?

[Severity: Medium]
This isn't a bug introduced by this patch either, and it looks already
addressed in this tree, but noting it for completeness: the two early
goto err_netdev paths (i40e_vsi_alloc_arrays() failure and i40e_get_lump()
failure) skip i40e_vsi_free_q_vectors(), which only the err_rings label
performs:

err_rings:
	i40e_vsi_free_q_vectors(vsi);
err_netdev:

With the older shape of this function, which kept the previously allocated
q_vectors alive across the reinit, i40e_vsi_clear() -> i40e_vsi_free_arrays()
would only free the pointer array:

	if (free_qvectors) {
		kfree(vsi->q_vectors);
		vsi->q_vectors = NULL;
	}

leaving each struct i40e_q_vector orphaned, since free_netdev() only unlinks
NAPI instances from dev->napi_list and does not free the containing
q_vector. The commit "i40e: keep q_vectors array in sync with channel count
changes" moves i40e_vsi_free_q_vectors() to the top of
i40e_vsi_reinit_setup() and re-creates the vectors via
i40e_vsi_setup_vectors(), so no live q_vector objects remain when the early
err_netdev paths run and the leak is gone.

> @@ -15030,7 +15035,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
>  			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
>  						  uplink_seid, 0);
>  		else if (reinit)
> -			main_vsi = i40e_vsi_reinit_setup(main_vsi);
> +			main_vsi = i40e_vsi_reinit_setup(main_vsi, lock_acquired);

[Severity: High]
Should the other arm of this if/else get the same treatment? Both branches
are entered with identical lock state:

i40e_rebuild() {
	...
	if (!lock_acquired)
		rtnl_lock();
	ret = i40e_setup_pf_switch(pf, reinit, true);
	...
}

but i40e_vsi_setup() still takes RTNL itself, both on success:

	ret = register_netdev(vsi->netdev);
	if (ret)
		goto err_dl_port;
	vsi->netdev_registered = true;

and on its unwind, which is the exact pattern this patch just replaced:

err_msix:
	if (vsi->netdev_registered) {
		vsi->netdev_registered = false;
		unregister_netdev(vsi->netdev);
		free_netdev(vsi->netdev);
		vsi->netdev = NULL;
	}

Can the !main_vsi branch be reached with RTNL held? The err_netdev path
patched above ends in i40e_vsi_clear(), which sets pf->vsi[vsi->idx] = NULL
and kfree()s the VSI without resetting pf->lan_vsi, so
i40e_pf_get_main_vsi() returns NULL on the next reset. The following
rebuild would then take:

		if (!main_vsi)
			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
						  uplink_seid, 0);

with rtnl_mutex already held, and register_netdev() -> rtnl_lock() would
self-deadlock on the non-recursive mutex, which is the failure mode this
commit describes fixing.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
