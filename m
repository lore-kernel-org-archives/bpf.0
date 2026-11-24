Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524577;
	b=Wy+OD1Tv/C04E4o2gD8xdhTvxOZI3fX6rYHfwc00QziwCe7I2uJN9B+E0MrIkG9LmR1q
	 GyXDQzlNNm3/ejQ8ccLJ0gkK4wYr/yxaYVZYTtPdUSyrKWn0ucbtx5qGLp27SVejbxJJh
	 swApTFIVfpTSrm8armvAHK8YjPST+opLF5Jpreyotav3EbY6bwfHGiRHIi26dXEaIPWcJ
	 7tTL6Z8YYU4Pd0IAkiX8WGG+PrTa7jK1aEaprbmvX7q2ZxhehudE9hK5eZjALrjv5DhB1
	 taqpQS5CHYK82r/6D5YlLU/3zcE+i+racPxx1NGVioRxeEaw+eHEOowPrP5RTF8JUwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hPVmscRt3BKLvCkEaDjPIHGXvNAZyfbXnCrhubmsGcU=;
	b=ZQ12oRy3s9638AhCeBOaE95iE9uIzHAd1O3565SLHamh9p9SxU8rkj5asrrTLKIa3ISk
	 OOkk0sv/ZSSiMuecjD6nGCowdSkIZG/LQDhx7qkmUuf71062QZz+5mH/KsZW1tpKCHnxG
	 PolXRzRP8e2rZcY4IH11YZ33mogbGnT9JUpoTw+gmMJCNHW73az2oLiG2HzllYR0lH0fL
	 88A2GD7Zg6tgYRdCWOwIUSNQnPj5qETiPlcZm6V7ibIWqpN7SpEe4s+IPDVNr799TuBNT
	 vldk7ODY32Z9U8L/DcGJA1LIZYCJBQU8rgeU/8aiRPdMHJUq4nyJ17cBRal5hzYSXLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q46t2RAx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17334606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q46t2RAx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D49E1F000C4;
	Tue, 24 Nov 2026 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524576;
	bh=hPVmscRt3BKLvCkEaDjPIHGXvNAZyfbXnCrhubmsGcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q46t2RAx0tLBglnuhgEDqqdG4tH5QR1iA84XGJnTwpNbSUYoD50NekPfpAQc7p2/q
	 Z4GbaNe4GYWF9NT/snZbeNqVivaX9X+ktxXQLoxQDEm21qn4QWQS/acAZqpQao+oLu
	 NzUIlNyN6eh5Yrt1nbqfim4Lwh/LI67Jgsx2akb/AWTARbUIvQz7+thiyNcpce3cSi
	 G2nCUWtHn0nfeFwXl8F7yoAguZ84jYmvJHrlxJHgQLfLLzByAuR5vr9yZ8IffQzgw2
	 qXwGUI4DjwE8vv6gPSgmM6YXXmS22l3iEUBboWzNMB/BIS89UFkQnSH4kjLrELC5oO
	 5DF6UrbmRzFKA==
Message-ID: <sashiko-outbox-231177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/5] vmxnet3: keep the previous XDP program when
 attaching fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Sudakas" <filzador@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123124855.1021-3-filzador@gmail.com>
References: <20261123124855.1021-1-filzador@gmail.com>
 <20261123124855.1021-3-filzador@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:49:35 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] vmxnet3: incomplete error recovery in vmxnet3_xdp_set()
  leaves device broken
- [Medium] vmxnet3: wrong redirect target feature rollback in
  vmxnet3_xdp_set()
--

commit 45dfb991794383051e0025dc90fc6eacbd3d1177
Author: Philipp Sudakas <filzador@gmail.com>

vmxnet3: keep the previous XDP program when attaching fails

This commit defers releasing the old XDP program in vmxnet3_xdp_set() until
queue recreation and device activation succeed, and restores the old program
and redirect target feature on failure.

> diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxn=
et3_xdp.c
> index 5f470499e6002..45259b236ebd7 100644
> --- a/drivers/net/vmxnet3/vmxnet3_xdp.c
> +++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
> @@ -66,11 +66,9 @@ vmxnet3_xdp_set(struct net_device *netdev, struct netd=
ev_bpf *bpf,
>  		vmxnet3_quiesce_dev(adapter);
> =20
>  	vmxnet3_xdp_exchange_program(adapter, new_bpf_prog);
> -	if (old_bpf_prog)
> -		bpf_prog_put(old_bpf_prog);
> =20
>  	if (!running || !need_update)
> -		return 0;
> +		goto out;
> =20
>  	if (new_bpf_prog)
>  		xdp_features_set_redirect_target(netdev, false);
> @@ -84,17 +82,31 @@ vmxnet3_xdp_set(struct net_device *netdev, struct net=
dev_bpf *bpf,
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to re-create rx queues for XDP.");
> -		return -EOPNOTSUPP;
> +		goto err_restore;
>  	}
>  	err =3D vmxnet3_activate_dev(adapter);
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to activate device for XDP.");
> -		return -EOPNOTSUPP;
> +		goto err_restore;
>  	}
>  	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
> =20
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

[Severity: Medium]
Does returning from err_restore leave netdev running while the device is
quiesced and its rx queues are destroyed?

Before vmxnet3_rq_create_all() runs, vmxnet3_quiesce_dev() disables NAPI
and frees IRQs, and vmxnet3_rq_destroy_all() frees rq->buf_info[0].
Returning without either reactivating the device or closing it via
vmxnet3_force_close() (as vmxnet3_change_mtu() and vmxnet3_set_ringparam()
do) leaves netif_running(netdev) true on a torn-down device, so a later
vmxnet3_reset_work() or vmxnet3_resume() dereferences NULL rq->buf_info[0]
in vmxnet3_rq_init(), and vmxnet3_suspend() hangs in napi_disable().

In addition, when a failed detach (new_bpf_prog =3D=3D NULL) restores
adapter->xdp_bpf_prog to old_bpf_prog, a subsequent XDP program
replacement sees need_update =3D=3D false and returns 0 without recreating =
the
destroyed rx queues.  If the failed detach came from
bpf_xdp_link_release() -> dev_xdp_detach_link(), the core only wraps
dev_xdp_install() in WARN_ON() and unconditionally clears the link, so
skipping bpf_prog_put(old_bpf_prog) leaks the reference and leaves a stale
pointer in adapter->xdp_bpf_prog.

> +	if (old_bpf_prog)
> +		xdp_features_set_redirect_target(netdev, false);
> +	else
> +		xdp_features_clear_redirect_target(netdev);
> +	return -EOPNOTSUPP;
>  }

[Severity: Medium]
When attaching the first XDP program (old_bpf_prog =3D=3D NULL) fails, does
err_restore clear NETDEV_XDP_ACT_NDO_XMIT even though it was set before
vmxnet3_xdp_set() ran?

vmxnet3_probe_device() initializes netdev->xdp_features with
NETDEV_XDP_ACT_NDO_XMIT enabled:

drivers/net/vmxnet3/vmxnet3_drv.c:vmxnet3_probe_device() {
    ...
	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
			       NETDEV_XDP_ACT_NDO_XMIT;
    ...
}

Calling xdp_features_clear_redirect_target() when old_bpf_prog is NULL
strips that initial flag on a failed attach.  Updating the redirect target
feature only after vmxnet3_activate_dev() succeeds would avoid mutating
netdev->xdp_features or emitting NETDEV_XDP_FEAT_CHANGE notifications on
failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123124855.1021=
-1-filzador@gmail.com?part=3D2
