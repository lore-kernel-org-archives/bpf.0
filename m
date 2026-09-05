Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50832D94B5
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578203; cv=none; b=Ulyj1uAd0eBEH+0yGH34rzLEC/y54aYXWd72omUMDQEDNjFaiaRfoG5lT8Jku8GQ9olNqs/A0ACxw8vCjjTzwrkJNDUKTzm2SeEwahzdO2Of/EF8MiWYgP+4iMwGaDoNqHN/Ec5JjPqw/WWbTLqygsbhSbRt/sgMQayZSLOQCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578203; c=relaxed/simple;
	bh=K5/82VVA8AJQYw9Uwylu0EEJQcHotFgVBa7ZSC3IQjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kd4+Yh46KSn2dfs1lpyUtynMZ0H8s8ClUgDCOLoX7XJmTUXq6s4i0jMBmCfqRcBONbP6AaObTzgW1gAnxCoQmZtn534We3GzvmcHjSev5yYIVUm1eoqrfVH3GPO8yurRSpOZK//uPGMlhf8vZZIc+iixTjuJNciqjSjPs4unBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJLSihwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJLSihwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C191F00A3D;
	Sat,  5 Sep 2026 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578202;
	bh=aaS3ysF2LUglav1zrk6IpsXDmKjV6D81eJrOCPvwqzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NJLSihwugbcQfKW/bS7Pa4HL14dUjQ5LQ4I6SzwA5zZB+DFm9kkb6LfpWsEJYO753
	 51OrThNGosnfEnCpMnaWwBh3Q6jbkRQs7+4BgiJMTVBSS8YyhjT8QTYPlJk0xIYjF7
	 YG5cqztB3rm9YbyAZ8p6EXpLq1naxOIoAxJVnxvY34z4OFJnApilr3GPtL1AzRt2eA
	 Oy9LqcGqWOUU5A3vO8Hfh9iE416Kr0iTdykO8JCXUQZrICwtkOPgGX33r7xpYRJpBt
	 CM8tuUY9Jm8JWStIrMJxWXLZdGBPDiG093tAD4m99qzRWqZ7t5cQD0se0/QZ9twI+B
	 ikJ6YK5UY3k8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904031553.3196916-1-rkannoth@marvell.com>
References: <20260904031553.3196916-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 03:16:41 +0000
Message-Id: <20260905031641.F3C191F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free of transmit queue structure (qset.sq) due to direct=
 ndo_stop() call without disabling TX
- [High] Non-atomic read-modify-write of `pfvf->flags` causes a lost update=
 of `OTX2_FLAG_INTF_DOWN`, leading to a double free of queue memory and IRQ=
s.

Pre-existing issues:
- [High] Hardware QoS queues are not re-allocated after an interface bounce=
, causing configuration of invalid/unallocated TX schedulers.
--

commit c0352f93e277cb08f3b57890bc0a90ef59777adb
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio
with TC_MQPRIO_SHAPER_BW_RATE. It programs per-queue MDQ CIR/PIR through
the NIX TX scheduler mailbox for each non-QoS transmit queue.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..abd66b366009a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool ra=
te_limit)
> +{
> +	struct otx2_nic *pfvf =3D netdev_priv(netdev);
> +	const struct net_device_ops *ops =3D netdev->netdev_ops;
> +	int err;
> +
> +	/* TODO: Explore live TX scheduler reprogramming to avoid a full
> +	 * ndo_stop()/ndo_open() bounce on every mqprio change.
> +	 */
> +	netdev_info(netdev,
> +		    "mqprio: restarting interface to reprogram TX scheduler; in-flight=
 traffic will be dropped\n");
> +
> +	err =3D ops->ndo_stop(netdev);

[Severity: High]
Could this direct call to ops->ndo_stop() cause a use-after-free on the
transmission hot path?

Unlike the standard dev_close() path, this skips dev_deactivate_many()
and synchronize_net(), meaning the network stack is still actively
transmitting packets. When otx2_stop() calls otx2_free_queue_mem(qset)
and frees the sq array, a concurrent ndo_start_xmit() could dereference
the freed pointer:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_xmit() {
    ...
    sq =3D &pf->qset.sq[sq_idx];
    ...
}

> +	if (err)
> +		return err;
> +
> +	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation.
> +	 * On teardown, drop mqprio software state so ndo_open() does not
> +	 * re-apply bandwidth limits via otx2_mqprio_up() after the kernel
> +	 * removed the qdisc.
> +	 */
> +	if (rate_limit)
> +		pfvf->mqprio.rate_limit =3D true;
> +	else
> +		otx2_mqprio_clear_sw(pfvf);
> +
> +	err =3D ops->ndo_open(netdev);

[Severity: High]
This is a pre-existing issue, but does bouncing the interface here safely
restore HTB QoS configurations?

When the interface is bounced, ndo_stop() destroys the NIX LF and returns
all hardware queues to the hardware. When ndo_open() subsequently creates
a new NIX LF, it calls otx2_qos_config_txschq() which traverses active
HTB software nodes and attempts to configure them.

Because the hardware QoS queues aren't re-allocated after the bounce,
__otx2_qos_txschq_cfg() in drivers/net/ethernet/marvell/octeontx2/nic/qos.c
will send mailbox messages with stale queue indices (node->schq). Is it
possible these queues might now belong to another VF, potentially
corrupting cross-VF state or crashing the firmware?

> +	if (err) {
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d\n",
> +			   err);
> +		/* ndo_open() already freed the TX schedulers on failure while
> +		 * netif_running() may still be true; drop mqprio software state
> +		 * only instead of sending shaper clears to freed queues.
> +		 */
> +		otx2_mqprio_clear_sw(pfvf);
> +		/* ndo_open() rolls back on failure; mark the interface down so
> +		 * netif_close() does not invoke ndo_stop() on freed NAPI/queue
> +		 * state. Caller holds RTNL; dev_close() would deadlock.
> +		 */
> +		pfvf->flags |=3D OTX2_FLAG_INTF_DOWN;

[Severity: High]
Could this non-atomic read-modify-write of the flags field lead to a lost
update and a subsequent double free?

If the asynchronous mailbox workqueue handler updates this same flags field
concurrently (e.g., setting OTX2_FLAG_PORT_UP in
otx2_mbox_up_handler_rep_event_up_notify without holding the RTNL lock),
this OTX2_FLAG_INTF_DOWN update could be lost.

If the flag update is lost, otx2_stop() might bypass its teardown guard
later, proceeding to double-free qset->sq and other queue resources. Would
it be safer to use atomic bit operations like set_bit() for these flags?

> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904031553.3196=
916-1-rkannoth@marvell.com?part=3D1
