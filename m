Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679611;
	b=B4AsDA+H+VCfXGHnR4K8X+zIxTegbjrEANvgWki5Y9DtjKb3vMish+oOBxDZF57/vC+8
	 I+16SLGR6+4mfjXoqkhcpQeRT4xZKUK3pzvyOQjWsreFHEGRwlysomuUKMTBOMlGdHRWz
	 r5ByknGylC0u35XmPGOaPXZgbcQVzZ3/NuicseJc6FwkLa+cXFg1D3CVtT4hhyFpEVJp5
	 S5KwUYz9VubXWkjhBERzGfcbROltYxikaxqaW2qmAzABt8ofPmcHrE9vs19C7MBABg1D3
	 2vIyuKyAgAShVLFiW5T6ocM2xyng0N0QGdzJpVNmqJPtyx6JAj2zDIDJvpBHJ/KSLxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679611;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y8pQkHSHjKzzBsWJDIR+/U3YAnJbZoUs6stomKR/JeM=;
	b=YFKEbTlVdz+azq1I8gvzGIaHqWgn2bn6VXftJd/VWvWOKrlJWQS2zhiHSIDRFRX/PGhd
	 ZznJYDlyNDSwmfdrUNkVdoVzPwG3BFvLyarX7Xf3VDe0mi7IRkxXIqOwzX3sNv4oQOmqg
	 QyUOPnWm+IveMDU4aQM7/m40FA0VMb2gEgEuAg2ezfNgPz626p+PNK3XuyelBRQOsm1vG
	 do8iZwCXy07qJNF2K7w1sxG6cZJK0LsGcP+e31UonqanSbRyrPcblLifKFGudZQWmioGo
	 9CH8DMtdfuj5mT6sxumZdwbG9WvU+ItatLzHEfyA9063F8KExw6qLprcZyN1y4D0lxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQM7aUf5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED0606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQM7aUf5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAD41F000C4;
	Thu, 26 Nov 2026 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795679610;
	bh=y8pQkHSHjKzzBsWJDIR+/U3YAnJbZoUs6stomKR/JeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQM7aUf5FVg6P4Sxwj6kNeZEmKy7QkjBjmqcehLH5XTnsN7SUQE5n0Lf1waIvbJD5
	 t3EpgPYMbroxPXmKqZO81c3VCvpkhLh9tmBEqaNLTKta8pxwt+DtnDr2WH+2chVhTs
	 9I8Gf/XTAA0z486N8et7MchD/C/tGshKMVMcjGudsGICzWlf5dnpysbnv4D4BclLHU
	 V+f5vsPur3wMCURUKWVKAan1Esx55zWDKnlAaUoifZMz/trnmrWQpBiIos6ExcvtmX
	 VRYFgzXABisKgchQKPVz6EWsgcMeHiV/fQ8/diciALd5j0bRAQa6UMmBJLQ5gPdJHt
	 radd5G+CAMyvg==
Message-ID: <sashiko-outbox-234974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/5] vmxnet3: fix the error path of XDP program
 setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Sudakas" <filzador@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125075255.1517-3-filzador@gmail.com>
References: <20261125075255.1517-1-filzador@gmail.com>
 <20261125075255.1517-3-filzador@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:53:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vmxnet3: RTNL deadlock and missing RESETTING bit in
  vmxnet3_xdp_set()
--

commit 584df80e321cf69400a7b01cc8f4da9b076182a5
Author: Philipp Sudakas <filzador@gmail.com>

vmxnet3: fix the error path of XDP program setup

This commit reworks vmxnet3_xdp_set() to recover or close the interface when
recreating the RX queues or reactivating the device fails during XDP attach=
 or
detach.

> diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxn=
et3_xdp.c
> index 5f470499e6002..a57866753d0fb 100644
> --- a/drivers/net/vmxnet3/vmxnet3_xdp.c
> +++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
[ ... ]
> @@ -55,46 +72,61 @@ vmxnet3_xdp_set(struct net_device *netdev, struct net=
dev_bpf *bpf,
>  		adapter->netdev->features &=3D ~NETIF_F_LRO;
>  	}
> =20
> -	old_bpf_prog =3D rcu_dereference(adapter->xdp_bpf_prog);
> +	old_bpf_prog =3D rtnl_dereference(adapter->xdp_bpf_prog);
>  	if (!new_bpf_prog && !old_bpf_prog)
>  		return 0;
> =20
>  	running =3D netif_running(netdev);
>  	need_update =3D !!old_bpf_prog !=3D !!new_bpf_prog;
> =20
> -	if (running && need_update)
> -		vmxnet3_quiesce_dev(adapter);
> +	if (!running || !need_update) {
> +		vmxnet3_xdp_exchange_program(adapter, new_bpf_prog);
> +		goto done;
> +	}
> =20
> +	vmxnet3_quiesce_dev(adapter);
>  	vmxnet3_xdp_exchange_program(adapter, new_bpf_prog);
> -	if (old_bpf_prog)
> -		bpf_prog_put(old_bpf_prog);
> -
> -	if (!running || !need_update)
> -		return 0;
> -
> -	if (new_bpf_prog)
> -		xdp_features_set_redirect_target(netdev, false);
> -	else
> -		xdp_features_clear_redirect_target(netdev);
> -
> -	vmxnet3_reset_dev(adapter);
> -	vmxnet3_rq_destroy_all(adapter);
> -	vmxnet3_adjust_rx_ring_size(adapter);
> -	err =3D vmxnet3_rq_create_all(adapter);
> -	if (err) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "failed to re-create rx queues for XDP.");
> -		return -EOPNOTSUPP;
> +	err =3D vmxnet3_xdp_restart_dev(adapter);
> +	if (err && new_bpf_prog) {
> +		/* Attach failed (old_bpf_prog is NULL here): the core drops
> +		 * its reference to the new program and keeps nothing
> +		 * attached. Bring the device back up without XDP.
> +		 */
> +		NL_SET_ERR_MSG_MOD(extack, "failed to restart device for XDP");
> +		vmxnet3_xdp_exchange_program(adapter, NULL);
> +		if (vmxnet3_xdp_restart_dev(adapter))
> +			goto err_close;
> +		return err;
>  	}
> -	err =3D vmxnet3_activate_dev(adapter);
>  	if (err) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "failed to activate device for XDP.");
> -		return -EOPNOTSUPP;
> +		/* Detach failed. The core may ignore an error here (XDP link
> +		 * release), so complete the detach on a closed device.
> +		 */
> +		netdev_err(netdev, "XDP removal failed to restart, closing\n");
> +		goto err_close;
>  	}
>  	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
> =20
> +done:
> +	if (need_update) {
> +		if (new_bpf_prog)
> +			xdp_features_set_redirect_target(netdev, false);
> +		else
> +			xdp_features_clear_redirect_target(netdev);
> +	}
> +	if (old_bpf_prog)
> +		bpf_prog_put(old_bpf_prog);
>  	return 0;
> +
> +err_close:
> +	/* The device is left quiesced, with IRQs freed and NAPI disabled,
> +	 * as vmxnet3_close() expects after a quiesce: close the interface.
> +	 * vmxnet3_force_close() would quiesce it and free the IRQs again.
> +	 */
> +	dev_close(netdev);
> +	if (new_bpf_prog)
> +		return err;
> +	goto done;
>  }

[Severity: Medium]
Can jumping to err_close deadlock on VMXNET3_STATE_BIT_RESETTING and
rtnl_lock?

vmxnet3_xdp_set() runs under rtnl_lock and clears VMXNET3_STATE_BIT_RESETTI=
NG
on the success path, but unlike vmxnet3_change_mtu() and
vmxnet3_set_ringparam() it never waits to acquire VMXNET3_STATE_BIT_RESETTI=
NG
before quiescing the device, nor clears it before calling dev_close():

CPU0                                  CPU1 (kworker)
vmxnet3_xdp_set()                     [rtnl_lock held]
  vmxnet3_quiesce_dev()
                                      vmxnet3_reset_work()
                                        test_and_set_bit(..._RESETTING)
                                        rtnl_lock()  <-- blocks
  vmxnet3_xdp_restart_dev() fails
  goto err_close
  dev_close()
    ...
      vmxnet3_close()
        while (test_and_set_bit(..._RESETTING))
          usleep_range(1000, 2000);  <-- spins forever

 *** DEADLOCK ***

Because vmxnet3_xdp_set() does not set VMXNET3_STATE_BIT_RESETTING on entry,
it also lacks serialization against paths such as vmxnet3_shutdown_device()
that rely on that bit without holding rtnl_lock, and can clear the bit on
the success path while another thread owns it.

Should vmxnet3_xdp_set() acquire VMXNET3_STATE_BIT_RESETTING with a
test_and_set_bit() loop before vmxnet3_quiesce_dev() and clear it on the
rollback and err_close paths before dev_close(), matching
vmxnet3_change_mtu()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125075255.1517=
-1-filzador@gmail.com?part=3D2
