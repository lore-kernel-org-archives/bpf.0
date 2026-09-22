Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CD360EDC;
	Tue, 22 Sep 2026 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040668; cv=none; b=S3HeCbBCSzknHl1KlWTvlW9jTjH3fQVGm5Eb58wjQ2ELt237QvuRYTmw+SwIt00f6dkPjlUyIXCb/Mpmxeb9AZtHOUU9St4yZYtFg90r/mjPOYDt/qW6S+VoNti9JA9OClBGKAoqHqq4sSwJmWdf7RK5VnevxlaNNiU9xIiZbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040668; c=relaxed/simple;
	bh=+rkddy0RhmhcRAt1UMxrT5TPVMqEYBx9mqrfWdm+nXY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbfrYI555A7uP/APxxtMF3OzCr0DZsx4QLYlIMJLom22Wm8+NG47aTbKZ3oOtjHTiYpBCNq9cQNlPz6yjWSA4+Ec0+VIK7BT/mdV+eIBqDILySlSTwWqT0+8NLOz/8hwGuBWB3UFHExGulWt2JV0xBK4yZVcqp82+cPXxNcl8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB+T4b63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB+T4b63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F691F000FF;
	Tue, 22 Sep 2026 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040666;
	bh=KSk5mOz8ZwuQKW/QjdVg3wHec6HorPnKVu5+d/2lJbE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mB+T4b63AXmYGfQpu2jYBsA1kDueECHFxG/C3IN3wMzsk/1bU+dI8i8TL8Dm9i4pc
	 iEtTI+aRr0Vztn1wu8g2JP0Pwq8E7NF7dUPOkmnsOelImTyav93eS5j8dvCE5S1OuY
	 hC5E4Ny7Rv1h4Ad267iw9vg4S6QQuCaCKO5UQXXIFVdJdR3A1iD0IaUMBIXgEoaKX0
	 beLNA49x0/KUqtOElhoSlC2LVLxTI0AZotk/AkBjx9ZPbERQRihtMEOiiNdYfde/OQ
	 x95UG9IxzNJfp7p/SMMOTMolMiBTHI61+6Go0pYEThv/sfwSbM5ONUGsiglIn5JFi6
	 qGQ5Fy6d4BvMg==
Subject: Re: [PATCH net 1/8] i40e: unregister netdev before clearing VSI on
 reinit failure
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
Date: Tue, 22 Sep 2026 01:31:05 +0000
Message-ID: <179004066503.2160803.6283752728775415263@kernel.org>
In-Reply-To: <20260918212458.550425-2-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch makes the two early allocation failures in
  i40e_vsi_reinit_setup() jump to the new err_netdev label, which calls…
- [Medium] At this commit the reinit teardown at the top of
  i40e_vsi_reinit_setup() deliberately keeps the existing per-vector…

Pre-existing issues:
- [High] When i40e_vsi_reinit_setup() fails it ends in i40e_vsi_clear(),
  which does kfree(vsi) and sets pf->vsi[vsi->idx] = NULL, and returns…

--

i40e: unregister netdev before clearing VSI on reinit failure

The patch splits the error path of i40e_vsi_reinit_setup() so that the two
early allocation failures (i40e_vsi_alloc_arrays() and i40e_get_lump())
reach a new err_netdev label which unregisters and frees the netdev before
calling i40e_vsi_clear().

A few questions about the new error path below.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 0cd0e5597c90..de4c0737f72e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14268,7 +14268,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	i40e_set_num_rings_in_vsi(vsi);
>  	ret = i40e_vsi_alloc_arrays(vsi, false);
>  	if (ret)
> -		goto err_vsi;
> +		goto err_netdev;

[Severity: Medium]
Can these two new gotos leak the struct i40e_q_vector allocations?

The teardown at the top of i40e_vsi_reinit_setup() intentionally keeps the
per-vector objects alive:

	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
	i40e_vsi_clear_rings(vsi);

	i40e_vsi_free_arrays(vsi, false);

With free_qvectors == false, both vsi->q_vectors and every individual
struct i40e_q_vector are still allocated at this point.

The new err_netdev label is placed below i40e_vsi_free_q_vectors(), so the
i40e_vsi_alloc_arrays() and i40e_get_lump() failures skip the per-vector
destructor i40e_free_q_vector(), which is what does netif_napi_del() and
kfree_rcu(q_vector, rcu).

The final i40e_vsi_clear() then calls i40e_vsi_free_arrays(vsi, true),
which frees only the q_vectors pointer array, and kfree(vsi) — so
num_q_vectors vector objects, each with an embedded NAPI, are never freed.

Would "goto err_rings" be the intended target here, since it falls through
into the same netdev teardown block that this patch wants to reach?

For the record, the leak is gone at the end of the series: "i40e: keep
q_vectors array in sync with channel count changes" adds
i40e_vsi_free_q_vectors() to the top-of-function teardown and reroutes the
i40e_get_lump() failure to err_rings, so nothing per-vector remains
allocated when err_netdev is taken. It only exists in this intermediate
commit.

>  
>  	alloc_queue_pairs = vsi->alloc_queue_pairs *
>  			    (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> @@ -14278,7 +14278,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  		dev_info(&pf->pdev->dev,
>  			 "failed to get tracking for %d queues for VSI %d err %d\n",
>  			 alloc_queue_pairs, vsi->seid, ret);
> -		goto err_vsi;
> +		goto err_netdev;
>  	}
>  	vsi->base_queue = ret;
>  
> @@ -14303,6 +14303,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  
>  err_rings:
>  	i40e_vsi_free_q_vectors(vsi);
> +err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);

[Severity: High]
Is RTNL already held when the two newly redirected failures land here?

i40e_vsi_reinit_setup() is only reached from i40e_setup_pf_switch() with
reinit == true:

	else if (reinit)
		main_vsi = i40e_vsi_reinit_setup(main_vsi);

and i40e_rebuild() wraps that call in RTNL:

	if (!lock_acquired)
		rtnl_lock();
	ret = i40e_setup_pf_switch(pf, reinit, true);

unregister_netdev() takes the lock itself:

net/core/dev.c:unregister_netdev() {
	rtnl_net_dev_lock(dev);
	unregister_netdevice(dev);
	rtnl_net_dev_unlock(dev);
}

So a kzalloc failure in i40e_vsi_alloc_arrays() or an exhausted
pf->qp_pile in i40e_get_lump(), reached via ethtool -L or an XDP attach
going through i40e_reset_and_rebuild(pf, true, true) -> i40e_rebuild() ->
i40e_setup_pf_switch(), would recursively acquire RTNL. Does that hang the
task in D state while holding RTNL, blocking further network configuration
system-wide?

Before this patch those two failures went to err_vsi and never touched
RTNL, so the exposure is new here.

This is addressed later in the same series by "i40e: avoid deadlock when
calling unregister_netdev()", which adds a lock_acquired parameter and
selects unregister_netdevice() on the RTNL-held path, so the final state of
the series is fine. Could the label split and the lock_acquired plumbing be
folded into one patch so this commit is not broken on its own?

> @@ -14312,7 +14313,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	if (vsi->type == I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
> -err_vsi:
>  	i40e_vsi_clear(vsi);
>  	return NULL;
>  }

[Severity: High]
This isn't a bug introduced by this patch — the pre-patch err_vsi path also
ended in i40e_vsi_clear() — but while the error path is being reworked, can
the callers still use the freed struct i40e_vsi after a failed reinit?

i40e_vsi_clear() does kfree(vsi) and sets pf->vsi[vsi->idx] = NULL, and
i40e_vsi_reinit_setup() returns NULL. i40e_setup_pf_switch() converts that
into -EAGAIN:

	if (!main_vsi) {
		dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
		i40e_cloud_filter_exit(pf);
		i40e_fdir_teardown(pf);
		return -EAGAIN;
	}

but i40e_rebuild() and i40e_reset_and_rebuild() both return void, so the
failure never reaches the operation that started the rebuild.

i40e_reconfig_rss_queues() keeps using its cached pointer after the reset,
including a write:

	i40e_reset_and_rebuild(pf, true, true);
	...
	if (queue_count < vsi->rss_size) {
	...
	vsi->rss_size = min_t(int, pf->alloc_rss_size, qcount);

i40e_xdp_setup() does the same, and writes through the ring array:

	i40e_reset_and_rebuild(pf, true, true);
	...
	for (i = 0; i < vsi->num_queue_pairs; i++)
		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);

Is this a use-after-free read and write on the freed VSI? It still looks
present at the end of the series, so would a complete fix either propagate
the failure out of i40e_rebuild()/i40e_reset_and_rebuild() or keep the VSI
alive until these callers are done with it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
