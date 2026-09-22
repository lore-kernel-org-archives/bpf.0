Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD73815F0;
	Tue, 22 Sep 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040677; cv=none; b=TW7zxVDVX9H7NyGVb6xgCSvtiMsgp4zL+YSL5HCtnQIZE/++UNQgHkwv+s+aCABPKMB965gdKP+hzE8GN5SUKo9euI77Df30wbNc9y/LsBVv51XSGHBjGqylg7LPo1pcm3kA6VumnMDHTXkTnH55KCyYZ5qTcXiBlUnmNnDtA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040677; c=relaxed/simple;
	bh=xkv02TH/bDJhjyMPnBa6kCv8BSjIxFwhzrgI1VCWRbA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtriG4B9a7g2ZQ4igypbM20A4/+v2YbdYHirAQlCPRE+ZAyoVylHlFdY1ad20ICrda0rYwsTOwZP1hW3VE1GgUkyNdVTO21tCQXYglKQ2cQcs6YYPH3jHtyEytehGRJ/IbI+37dFWeqtx65nDQLvm7UnKqSqaHknVF6zB2BQOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ig3D8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ig3D8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907931F00893;
	Tue, 22 Sep 2026 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040675;
	bh=xLGxRo5jYfXOJDRlPHr+WSnbfWcwjZS4c7D1hiUJ2m8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I6ig3D8iKbV1DnwR6JicxfBal9gn/zCsn88rqF26BcDBuzInBFlOoyXfu4HepcTtu
	 /xQVX1QxTzTIlU2bnw8FGLIIPL5s1YDUKoZjWQAf8WYkzwD4NYfHUdQyb8Xd727kke
	 535Gbsx+P0uX7uGR9PbEvUsqdFz9BNBj9oMXB3y6HLEYDbfjzaofAt1I2P2RUkIHHb
	 MP7Cn2LvdmUJPA9OV2Pm/+gbQ0z98l8iyl0mpUcB+LE2KlQU/ubGL70yYI+Hf2OLzK
	 6ke7Bt97WRiPoVAeQf9tHmNhTG/KqZXV4mNY47+vef4NDFTxgkKH8TpJg+pQjvJg0H
	 7AT2BS5h19u5Q==
Subject: Re: [PATCH net 7/8] i40e: keep q_vectors array in sync with channel
 count changes
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
Date: Tue, 22 Sep 2026 01:31:14 +0000
Message-ID: <179004067414.2160803.14505596092879568183@kernel.org>
In-Reply-To: <20260918212458.550425-8-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-8-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 3 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: for the main VSI, i40e_set_num_rings_in_vsi()
  now sizes vsi->num_q_vectors from vsi->req_queue_pairs (clamp(qps, 1,…
- [Medium] i40e_vsi_reinit_setup() now frees every q_vector
  (i40e_vsi_free_q_vectors() -> i40e_free_q_vector(): netif_napi_del() +…
- [Medium] i40e_vsi_reinit_setup() now calls i40e_vsi_free_q_vectors()
  (netif_napi_del() on a possibly still-enabled NAPI +…
- [Medium] i40e_vsi_alloc_q_vector() now calls
  netif_napi_add_config(vsi->netdev, &q_vector->napi, i40e_napi_poll,…

Pre-existing issues:
- [High] i40e_vsi_reinit_setup() destroys the main VSI on every failure
  path (err_rings/err_netdev: unregister_netdevice()/unregister_netdev()…
- [Low] The kernel-doc block that this patch edits for
  i40e_vsi_free_arrays() (the @free_qvectors line was removed) still…

--

i40e: keep q_vectors array in sync with channel count changes

The main VSI num_q_vectors is now derived from the requested channel count
instead of pf->num_lan_msix, i40e_vsi_reinit_setup() rebuilds the q_vectors
together with the ring arrays, and q_vector NAPIs are registered with
netif_napi_add_config() so the persistent NAPI config survives q_vector
reallocation.

Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 82037faf960f..32c0cb6caa17 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11400,10 +11400,14 @@ static void i40e_service_timer(struct timer_list *t)
>  static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  {
>  	struct i40e_pf *pf = vsi->back;
> +	u16 qps;
>  
>  	switch (vsi->type) {
>  	case I40E_VSI_MAIN:
>  		vsi->alloc_queue_pairs = pf->num_lan_qps;
> +		qps = vsi->req_queue_pairs ?
> +		      min(vsi->req_queue_pairs, pf->num_lan_qps) :
> +		      pf->num_lan_qps;
>  		if (!vsi->num_tx_desc)
>  			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
> @@ -11411,7 +11415,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
>  		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
> -			vsi->num_q_vectors = pf->num_lan_msix;
> +			vsi->num_q_vectors = clamp(qps, 1, pf->num_lan_msix);

[Severity: High]
Can num_q_vectors still end up larger than the effective queue count when
DCB is enabled?

req_queue_pairs is the value the user asked for, but the effective layout is
recomputed later in i40e_vsi_setup_queue_map():

	num_tc_qps = num_tc_qps / numtc;
	num_tc_qps = min_t(int, num_tc_qps, i40e_pf_get_max_q_per_tc(pf));
	...
	if ((vsi->type == I40E_VSI_MAIN && numtc != 1) || ...)
		vsi->num_queue_pairs = offset;

With two enabled traffic classes and "ethtool -L <dev> combined 9", that
gives num_tc_qps = 9 / 2 = 4 and offset = 8, so num_queue_pairs becomes 8
while num_q_vectors is 9.

i40e_vsi_map_rings_to_vectors() then distributes only num_queue_pairs ring
pairs over num_q_vectors vectors, so the surplus vector is left with
rx.ring == tx.ring == NULL, and i40e_napi_enable_all() skips it:

	if (q_vector->rx.ring || q_vector->tx.ring)
		napi_enable(&q_vector->napi);

A NAPI registered by netif_napi_add*() has NAPI_STATE_SCHED set, and with
dev->threaded set a kthread is created for it regardless of the rings.
Disabling threaded afterwards reaches napi_stop_kthread():

	if ((val & NAPIF_STATE_SCHED_THREADED) ||
	    !(val & NAPIF_STATE_SCHED)) {
		...
	} else {
		msleep(20);
		continue;
	}

For that never-enabled vector SCHED is set and SCHED_THREADED is never set,
so this loop has no exit condition. Is this the same threaded-toggle hang
the commit message says is fixed?

i40e_set_channels() only rejects mqprio and caps the request by
i40e_max_channels() == vsi->alloc_queue_pairs (whose comment still says
"TODO: This code assumes DCB and FD is disabled for now"), so nothing
rejects plain DCB or requires the count to be a multiple of the TC count.
Would deriving num_q_vectors from the finalized TC queue layout rather than
req_queue_pairs avoid this?

[ ... ]

> @@ -11487,19 +11490,20 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
>  	}
>  	vsi->rx_rings = next_rings;
>  
> -	if (alloc_qvectors) {
> -		/* allocate memory for q_vector pointers */
> -		size = sizeof(struct i40e_q_vector *) * vsi->num_q_vectors;
> -		vsi->q_vectors = kzalloc(size, GFP_KERNEL);
> -		if (!vsi->q_vectors) {
> -			ret = -ENOMEM;
> -			goto err_vectors;
> -		}
> +	/* allocate memory for q_vector pointers */
> +	size = sizeof(struct i40e_q_vector *) * vsi->num_q_vectors;
> +	vsi->q_vectors = kzalloc(size, GFP_KERNEL);
> +	if (!vsi->q_vectors) {
> +		ret = -ENOMEM;
> +		goto err_vectors;
>  	}
>  	return ret;
>  
>  err_vectors:
>  	kfree(vsi->tx_rings);
> +	vsi->tx_rings = NULL;
> +	vsi->rx_rings = NULL;
> +	vsi->xdp_rings = NULL;
>  	return ret;
>  }

[ ... ]

> @@ -11597,18 +11601,15 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
>  /**
>   * i40e_vsi_free_arrays - Free queue and vector pointer arrays for the VSI
>   * @vsi: VSI pointer
> - * @free_qvectors: a bool to specify if q_vectors need to be freed.
>   *
>   * On error: returns error code (negative)
>   * On success: returns 0
>   **/
> -static void i40e_vsi_free_arrays(struct i40e_vsi *vsi, bool free_qvectors)
> +static void i40e_vsi_free_arrays(struct i40e_vsi *vsi)

[Severity: Low]
This isn't a bug introduced by this patch, but since the kernel-doc block is
already being edited here: i40e_vsi_free_arrays() returns void, so the
"On error: returns error code (negative)" and "On success: returns 0" lines
cannot apply. Would it make sense to drop them in the same hunk?

[ ... ]

> @@ -12042,7 +12043,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
>  	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
>  
>  	if (vsi->netdev)
> -		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
> +		netif_napi_add_config(vsi->netdev, &q_vector->napi,
> +				      i40e_napi_poll, v_idx);

[Severity: Medium]
Is v_idx guaranteed to be within the netdev's napi_config array?

netif_napi_add_config_locked() stores the pointer without any bounds check:

	napi->index = index;
	napi->config = &dev->napi_config[index];

and dev->napi_config[] is sized once in alloc_netdev_mqs() from
max(num_tx_queues, num_rx_queues) and never resized. For i40e that is
vsi->alloc_queue_pairs at alloc_etherdev_mq() time in i40e_config_netdev(),
i.e. pf->num_lan_qps as it was when the netdev was created.

v_idx is bounded only by vsi->num_q_vectors, which for the main VSI is now
clamp(qps, 1, pf->num_lan_msix) recomputed on every reinit from the current
pf->num_lan_qps / pf->num_lan_msix. pf->num_lan_qps is mutated after the
netdev exists, in the limited-resources branch of i40e_init_msix():

	pf->num_lan_msix = min_t(int,
	       (vec - (pf->num_iwarp_msix + pf->num_vmdq_vsis)),
					      pf->num_lan_msix);
	pf->num_lan_qps = pf->num_lan_msix;

and i40e_init_msix() is re-run from i40e_restore_interrupt_scheme() on
resume and on recovery-mode exit. On a part where
hw.func_caps.num_tx_qp < num_online_cpus(), the probe-time num_lan_qps (and
therefore num_napi_configs) is clamped to num_tx_qp while num_lan_msix is
clamped only by the CPU count, so that assignment can raise num_lan_qps
above the netdev's fixed napi_config count. The next reinit, which this
patch makes rebuild q_vectors, would then index past the end of the
kvzalloc()'d napi_config array.

Would bounding v_idx by the netdev's queue count before calling
netif_napi_add_config() be appropriate here? Note the existing
netif_set_real_num_tx_queues() failure at open only fires after the access.

[ ... ]

> @@ -14266,11 +14276,20 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
>  	pf = vsi->back;
>  
>  	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
> +	i40e_vsi_free_q_vectors(vsi);
>  	i40e_vsi_clear_rings(vsi);
> +	i40e_vsi_free_arrays(vsi);

[Severity: Medium]
Should vsi->num_q_vectors be zeroed here?

i40e_vsi_free_q_vectors() frees each q_vector and i40e_vsi_free_arrays()
then does kfree(vsi->q_vectors); vsi->q_vectors = NULL, but num_q_vectors
still describes vectors that no longer exist for the whole reinit window.

The debugfs napi command iterates with no NULL check on the array and does
not hold rtnl:

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:i40e_dbg_netdev_ops_write() {
	...
	for (i = 0; i < vsi->num_q_vectors; i++)
		napi_schedule(&vsi->q_vectors[i]->napi);
	...
}

so "echo 'napi <seid>' > .../command" concurrent with the reinit window
would dereference vsi->q_vectors[i] with vsi->q_vectors == NULL.

The same shape exists in i40e_napi_disable_all():

	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];

		if (q_vector->rx.ring || q_vector->tx.ring)

which is reachable from the err_netdev unregister path below whenever
__I40E_VSI_DOWN is not already set. Before this patch the q_vector objects
and the pointer array deliberately survived reinit
(i40e_vsi_free_arrays(vsi, false) / i40e_vsi_alloc_arrays(vsi, false)), so
this window did not exist.

[Severity: Medium]
Is the VSI always quiesced when reinit reaches this point?

i40e_vsi_free_q_vectors() -> i40e_free_q_vector() does:

	if (vsi->netdev)
		netif_napi_del(&q_vector->napi);

	vsi->q_vectors[v_idx] = NULL;

	kfree_rcu(q_vector, rcu);

while the q_vector is still the dev_id that request_irq() was given, and the
NAPI may still be enabled. The only thing that normally releases the IRQs
and disables the NAPIs first is i40e_prep_for_reset() ->
i40e_pf_quiesce_all_vsi(), and i40e_prep_for_reset() quiesces nothing when
the reset bit is already owned by someone else:

	if (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
		return;
	...
	i40e_pf_quiesce_all_vsi(pf);

The service task performs resets without rtnl (i40e_service_task() ->
i40e_reset_subtask() -> i40e_prep_for_reset() / i40e_reset() /
i40e_rebuild(pf, false, false)), so an rtnl-holding "ethtool -L" can find
the bit already set and walk straight into reinit with vsi->irqs_ready
still true.

In that case i40e_vsi_free_irq() later calls
free_irq(irq_num, vsi->q_vectors[i]) with a dev_id that request_irq() never
saw (or skips the vector entirely because the fresh q_vector has
num_ringpairs == 0), leaving the old handler registered against freed
memory:

	if (!vsi->irqs_ready)
		return;
	vsi->irqs_ready = false;
	for (i = 0; i < vsi->num_q_vectors; i++) {
	...
		free_irq(irq_num, vsi->q_vectors[i]);

Would it be safer for reinit to force the quiesced state (free the IRQs,
disable the NAPIs, clear irqs_ready) before rebuilding vectors?

>  
> -	i40e_vsi_free_arrays(vsi, false);
>  	i40e_set_num_rings_in_vsi(vsi);
> -	ret = i40e_vsi_alloc_arrays(vsi, false);
> +	ret = i40e_vsi_alloc_arrays(vsi);
> +	if (ret)
> +		goto err_netdev;
> +
> +	/* Rebuild q_vectors during VSI reinit because the effective channel
> +	 * count may change num_q_vectors. Keep vector topology aligned with the
> +	 * queue configuration after ethtool's .set_channels() callback.
> +	 */
> +	ret = i40e_vsi_setup_vectors(vsi);
>  	if (ret)
>  		goto err_netdev;

[Severity: High]
This isn't a bug introduced by this patch, but the two new failure points
added here land on an error path that destroys the main VSI while the caller
keeps using it.

err_netdev unregisters and free_netdev()s the netdev, deletes the switch
element and then calls i40e_vsi_clear(vsi), which kfree()s the struct
i40e_vsi and clears pf->vsi[idx], returning NULL. i40e_setup_pf_switch()
turns that into -EAGAIN, but i40e_rebuild() and i40e_reset_and_rebuild()
both return void, so the failure never reaches the caller:

i40e_set_channels()
  i40e_reconfig_rss_queues()
    i40e_reset_and_rebuild(pf, true, true)   /* void */
      i40e_rebuild()                         /* void */
        i40e_setup_pf_switch(pf, true)
          i40e_vsi_reinit_setup()            /* frees vsi, returns NULL */

and i40e_reconfig_rss_queues() then continues with its cached pointer:

	i40e_reset_and_rebuild(pf, true, true);
	...
	if (queue_count < vsi->rss_size) {
		i40e_clear_rss_config_user(vsi);
	...
	qcount = vsi->num_queue_pairs / vsi->tc_config.numtc;
	vsi->rss_size = min_t(int, pf->alloc_rss_size, qcount);

i40e_xdp_setup() has the same pattern, dereferencing vsi->num_queue_pairs,
vsi->rx_rings[i] and vsi->xdp_rings[i] after
i40e_reset_and_rebuild(pf, true, true).

Previously reinit performed no allocation of q_vectors, so an -ENOMEM could
not trigger this. With the q_vector pointer-array kzalloc() now
unconditional in i40e_vsi_alloc_arrays() and the per-vector kzalloc() in
i40e_vsi_alloc_q_vector() reached through i40e_vsi_setup_vectors(), a single
allocation failure under memory pressure destroys the main VSI and the
caller reads and writes freed memory. Could reinit keep the VSI alive on
failure, or propagate the failure so callers stop touching the destroyed
object?

>  
> @@ -14282,7 +14301,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
>  		dev_info(&pf->pdev->dev,
>  			 "failed to get tracking for %d queues for VSI %d err %d\n",
>  			 alloc_queue_pairs, vsi->seid, ret);
> -		goto err_netdev;
> +		goto err_rings;
>  	}
>  	vsi->base_queue = ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
