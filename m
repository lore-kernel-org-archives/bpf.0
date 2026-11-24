Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526789;
	b=IRBSSbOy4gJtHu/ET2pDjqZHfndF7GUu+pnZmfiZL6kqmGlB8Rpr9H3uhQ4nwg3gKrxO
	 bvB/cZBTb4BZZxSD4vvGsCnOPkkGvXlMr3L+Oqt32iUe3YeWI2bBIpDUq61UpQW4I1sdQ
	 FHNBfBCHKiNL5jz/0fw8VqJRZLfTuubHtW7Q5OowvT/bCqHaRdZdvPZzYF/D59uYPEweD
	 9nGTIUi5MauB6ZILE4CqSSfoVHd88V/o5fHGwi4V8EzS3daDi2tPTohwRFOsEpSjz7csF
	 jfc21eWr7K5+I39eQF89q2WBKQmpIf+/kXKwLouPtFjRfPJSFpatz1fFFvnMTr314IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526789;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+iD7n72HFOyZmZK5XExAtuSfPQKnaovwWr876cE3qyI=;
	b=D1ylVZUrVi0hbjgjLo2ov1fpCciNVKx4omaKoN8QmnQqiwCRMUEFCsQS/bvEO9qvkABJ
	 1nmpBCO6pRLnEIrbTVYBO0RsABudjZp4dZ7CtN1ccI+PJ3tlY8YK1K1PLlND32FN1mFqQ
	 amjUYEaxLxiEVAo2CpFvcMIK5xc1DpCxV/R96rHp5csBuUevxphRABJzKchLMtzgyQAA8
	 SwG+QOVUiHQ2p12zanxImF1RlQ89nBGMVhZjmYhkwDm3+ovQ+HE6S3UqpCLPqXmS81oyk
	 eZB9hFDasFjqRZHsBEoo+NdyybYVmSd53nfrDllNN/QyhTVEHHjRWaA8en1EA4XgZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gbEj/tdd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AC606A31E;
	Tue, 24 Nov 2026 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbEj/tdd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BC31F000C4;
	Tue, 24 Nov 2026 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526788;
	bh=+iD7n72HFOyZmZK5XExAtuSfPQKnaovwWr876cE3qyI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gbEj/tddu9/KzK9pc5AjqNXjxcTmpeMeGVEjHNaX1jtWJDhSBHdrocH2vY9PN9ZuH
	 LsXsAxTza7Xq7VS2UaUJtqOMdProtgDfjvtD6OG0qJKImXysYGJZkxGJoI+uwen1H8
	 wQSbkRfocpQSPQWU/W3gJZdCKBdUFvsfK98iPHm3k3UGOdTyifzhwauOYm8/GmVfdS
	 SqlfCJk3JXQT8txKlnFmAjT/aCmh28hbImBHXu3LY5jXo9BqTrUT5HcEOM02w/u2Q8
	 Ubbl3sWMUG3Wi+t5W5Oq9iJC7i27J8NnW1idyhqBJfRaSH2SsqWtlNdYFwZM8dG/Xu
	 0HxwtjRSQvzkw==
Subject: Re: [PATCH net v2 2/5] vmxnet3: keep the previous XDP program when
 attaching fails
From: netdev-bot+sashiko@kernel.org
To: filzador@gmail.com
Cc: ronak.doshi@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, u9012063@gmail.com
Date: Tue, 24 Nov 2026 13:26:27 +0000
Message-ID: <179552678713.3135.6451619234057473485@kernel.org>
In-Reply-To: <20261123124855.1021-3-filzador@gmail.com>
References: <20261123124855.1021-3-filzador@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new err_restore path in vmxnet3_xdp_set()
  (drivers/net/vmxnet3/vmxnet3_xdp.c:100-109) puts old_bpf_prog back…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the
  err_restore path added here only restores software state:…

--

vmxnet3: keep the previous XDP program when attaching fails

This patch changes vmxnet3_xdp_set() so the old program's reference is
released only after the device has been reactivated. If
vmxnet3_rq_create_all() or vmxnet3_activate_dev() fails, the new
err_restore path puts the old program back in adapter->xdp_bpf_prog and
restores the redirect-target feature.

> diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
> index 5f470499e6002..45259b236ebd7 100644
> --- a/drivers/net/vmxnet3/vmxnet3_xdp.c
> +++ b/drivers/net/vmxnet3/vmxnet3_xdp.c

[ ... ]

> @@ -84,17 +82,31 @@ vmxnet3_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf,
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to re-create rx queues for XDP.");
> -		return -EOPNOTSUPP;
> +		goto err_restore;
>  	}
>  	err = vmxnet3_activate_dev(adapter);
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to activate device for XDP.");
> -		return -EOPNOTSUPP;
> +		goto err_restore;
>  	}
>  	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
>  
> +out:
> +	if (old_bpf_prog)
> +		bpf_prog_put(old_bpf_prog);
>  	return 0;
> +
> +err_restore:
> +	/* On error the core drops its reference to the new program and
> +	 * keeps the old one attached: the driver must keep the old one.
> +	 */
> +	vmxnet3_xdp_exchange_program(adapter, old_bpf_prog);

[Severity: High]
The comment says the core keeps the old program attached on error. Does
that hold for every caller of ndo_bpf?

An XDP link detach goes through bpf_xdp_link_release() or
bpf_xdp_link_detach(), then dev_xdp_detach_link(). That function ignores
the driver's return value:

net/core/dev.c:dev_xdp_detach_link() {
    ...
	bpf_op = dev_xdp_bpf_op(dev, mode);
	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
	dev_xdp_set_link(dev, mode, NULL);
	return 0;
}

On that path, vmxnet3_xdp_set() is called with new_bpf_prog == NULL and
old_bpf_prog == P, so need_update is true on a running device.

Suppose vmxnet3_rq_create_all() or vmxnet3_activate_dev() fails. Then
err_restore puts P back into adapter->xdp_bpf_prog and keeps the
reference. The core, however, has already cleared its record of the
program.

What releases that reference afterwards? vmxnet3 has no other
bpf_prog_put(). At unregister, dev_xdp_uninstall() skips modes that have
no program in the core:

	prog = dev_xdp_prog(dev, mode);
	if (!prog)
		continue;

So ndo_bpf is never called again, and P and its maps stay pinned until
another program is attached.

Can P also keep running on received traffic? QUIESCED stays set, so a
later vmxnet3_close() skips quiesce. On the next open,
vmxnet3_open()->vmxnet3_activate_dev()->vmxnet3_rq_init() would see
vmxnet3_xdp_enabled() and run P, while ip link shows no XDP program.

Before this patch, the driver dropped P and left xdp_bpf_prog NULL on
this path, which matched the core's forced detach.

This looks unchanged later in the series. The later commit "vmxnet3:
keep the XDP program across device resets" does not touch err_restore.

Should a call with new_bpf_prog == NULL always leave the driver without
the program and without its reference, even when it fails?

> +	if (old_bpf_prog)
> +		xdp_features_set_redirect_target(netdev, false);
> +	else
> +		xdp_features_clear_redirect_target(netdev);
> +	return -EOPNOTSUPP;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but
err_restore only restores software state.

By the time err_restore runs, the following has already happened:

- vmxnet3_quiesce_dev() has disabled NAPI on every rx queue, freed the
  IRQs and set QUIESCED.
- vmxnet3_reset_dev() has reset the device.
- The rx rings have been destroyed. If vmxnet3_rq_create_all() is what
  failed, its err_out path destroys them a second time.

The function then returns with netif_running() still true. The interface
stays up with no RX or TX. The restored program does not actually run
until the interface is taken down and brought back up.

vmxnet3_change_mtu() runs the same sequence and closes the device when
these steps fail:

out:
	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
	if (err)
		vmxnet3_force_close(adapter);

Can later operations misbehave on an interface left in this state?

vmxnet3_suspend() sees netif_running() and calls napi_disable() on NAPI
instances that are already disabled:

	for (i = 0; i < adapter->num_rx_queues; i++)
		napi_disable(&adapter->rx_queue[i].napi);

That would loop forever in napi_disable_locked() and hang system suspend.

There is also a failure after vmxnet3_rq_create_all() fails.
vmxnet3_resume() and a pending vmxnet3_reset_work() both call
vmxnet3_activate_dev() without re-creating the rings. vmxnet3_rq_init()
would then write through rq->buf_info[0][i] while buf_info[0] is NULL.

vmxnet3_reset_work() can already be waiting at this point. It sets
RESETTING before rtnl_lock(), so it can be queued (by tx_timeout or a
TQERR/RQERR event) and wait for RTNL while vmxnet3_xdp_set() runs.
vmxnet3_xdp_set() never sets RESETTING itself.

Should vmxnet3_xdp_set() call vmxnet3_force_close() on these failures,
as vmxnet3_change_mtu() does?

>  }
>  
>  /* This is the main xdp call used by kernel to set/unset eBPF program. */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123124855.1021-1-filzador%40gmail.com
