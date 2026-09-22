Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D0376494;
	Tue, 22 Sep 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040672; cv=none; b=TrV04xh5g1nAi1/W8Cg03U06EGeH4LJjP0kYxPMbJs6cS9tkfLY+fH6zSTA1gabdx3Te1shnwd/4wqdFiJdWi1o3EvTRHbaU5KOMBJYJYPZNKMXfEYjwcsVdZuaRHhP7M7HFfdjxmW9nCuKW3oMWu+geR0tkO1uxm0XTkKu40ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040672; c=relaxed/simple;
	bh=7GC5yRe8PyIt/NwbCIIccyIlO1VmOOozMDE6qL8VYvo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmfXaa+uxpMWJ2yJShuLoj9VgNLIHMSlscQzHR8qdO38CvndjQ4ATMyJwGTpiVeA2dSd2Y73pq+Ns5hNPDXjQeIueblfspb4n1yv7r9/0L5gKfdIjxbjirUSFfmTzwlT1UfOkzpKOcwReu0ZygokGN8sbd+pYVeDlYrwS4xFXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9QMuH98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9QMuH98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B71F1F000FF;
	Tue, 22 Sep 2026 01:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040670;
	bh=b9Y3hCZIHWUXqKo5oIoagaUznFbMB55/cJv2nORwPWk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b9QMuH98fapbOL/4LgMVtlLMoPGT8FxaX2OCcQKUcV4ny6pmD1kkDDQNvs626/4zl
	 8TsCglhJwewKGSohx5uvvmkK5Gf5eMkScnrqpvy5MCcVzoe85ELnfvCI8CYC28ogLb
	 p5iefuionU74vxJv7NWaaYKJH5+9p3QS42E3pz+H3eDEksLmkmA/Kenzjm4eVmw3ZC
	 S91pcC0KAvp7viIKaLujC9T9RMuEwymLc1vOgx9639CQv0XaL6dNEajXewgWANas9e
	 hEqHODb6OnUVrPpX+rdG4yyS2y93KoP8aZ9nMaYbNyDxqdzW2uHFUl8NjYtdjhYtdk
	 Az/UxP/4dAU2w==
Subject: Re: [PATCH net 3/8] i40e: make ring pointers unreachable before
 freeing via rcu
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
Date: Tue, 22 Sep 2026 01:31:08 +0000
Message-ID: <179004066858.2160803.3751100830230297898@kernel.org>
In-Reply-To: <20260918212458.550425-4-anthony.l.nguyen@intel.com>
References: <20260918212458.550425-4-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete RCU teardown: the ring-pointer arrays through which
  RCU readers discover the rings are freed with a plain kfree() and…

--

i40e: make ring pointers unreachable before freeing via rcu

The patch reorders i40e_vsi_clear_rings() so the published slots in
vsi->tx_rings/rx_rings/xdp_rings are cleared before the saved Tx ring
pointer is handed to kfree_rcu(). The Tx pointer is saved first because it
is the base of the per-queue-pair allocation block.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index de4c0737f72e..65aa50330aac 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11693,11 +11693,13 @@ static void i40e_vsi_clear_rings(struct i40e_vsi *vsi)
>  
>  	if (vsi->tx_rings && vsi->tx_rings[0]) {
>  		for (i = 0; i < vsi->alloc_queue_pairs; i++) {
> -			kfree_rcu(vsi->tx_rings[i], rcu);
> +			struct i40e_ring *tx_ring = vsi->tx_rings[i];
> +
>  			WRITE_ONCE(vsi->tx_rings[i], NULL);
>  			WRITE_ONCE(vsi->rx_rings[i], NULL);
>  			if (vsi->xdp_rings)
>  				WRITE_ONCE(vsi->xdp_rings[i], NULL);
> +			kfree_rcu(tx_ring, rcu);

[Severity: High]
The ring objects are now unpublished before kfree_rcu(), but is the array
that readers index through itself RCU protected?

The commit message states that after this change "new readers can no longer
discover the ring through vsi->tx_rings/rx_rings/xdp_rings before the object
is queued for deferred freeing".  Does that hold on the i40e_vsi_reinit_setup()
path, where the arrays are dropped immediately afterwards?

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_vsi_reinit_setup() {
	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
	i40e_vsi_clear_rings(vsi);

	i40e_vsi_free_arrays(vsi, false);
	i40e_set_num_rings_in_vsi(vsi);
	ret = i40e_vsi_alloc_arrays(vsi, false);
	...
}

and i40e_vsi_free_arrays() uses a plain kfree() plus plain stores, with no
grace period:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_vsi_free_arrays() {
	...
	kfree(vsi->tx_rings);
	vsi->tx_rings = NULL;
	vsi->rx_rings = NULL;
	vsi->xdp_rings = NULL;
}

Meanwhile i40e_get_netdev_stats_struct() (ndo_get_stats64, reached from
dev_get_stats() without rtnl) re-evaluates the non-volatile array base on
every iteration inside the RCU section, and never checks the rx_rings or
xdp_rings bases at all:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_get_netdev_stats_struct() {
	if (!vsi->tx_rings)
		return;

	rcu_read_lock();
	for (i = 0; i < vsi->num_queue_pairs; i++) {
		...
		ring = READ_ONCE(vsi->tx_rings[i]);
		...
		if (i40e_enabled_xdp_vsi(vsi)) {
			ring = READ_ONCE(vsi->xdp_rings[i]);
	...
}

i40e_update_vsi_stats() does the same with no base check whatsoever:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_update_vsi_stats() {
	rcu_read_lock();
	for (q = 0; q < vsi->num_queue_pairs; q++) {
		/* locate Tx ring */
		p = READ_ONCE(vsi->tx_rings[q]);
	...
}

So can a reader that is already past the "if (!vsi->tx_rings)" test, or
inside the loop, reload vsi->tx_rings/rx_rings/xdp_rings after
i40e_vsi_free_arrays() nulls them and dereference NULL[i]?

And once the pointer-array slab is recycled, for instance by the
i40e_vsi_alloc_arrays() call two statements later, or by the SLUB freelist
pointer written into the freed object, can the same reader read a non-NULL
wild value out of the freed array and dereference it as struct i40e_ring
(->syncp, ->stats)?

The __I40E_VSI_DOWN test at the top of both readers is evaluated before
rcu_read_lock(), and nothing on this path drains readers that already passed
it, so it does not appear to close the window.  Should the arrays be released
through kfree_rcu() (or after a synchronize_rcu()), with the base loaded once
via rcu_dereference(), for the unpublish ordering established here to actually
take effect?

Separately, both readers bound their loops with vsi->num_queue_pairs, which
i40e_set_num_rings_in_vsi() changes between i40e_vsi_free_arrays() and
i40e_vsi_alloc_arrays().  Can that let a reader index past the end of the
freshly allocated array?

>  		}
>  	}
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
