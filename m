Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281592;
	b=PDTqjTJJ48rIBHR48EtkuzzUVaiw7OqK7vF1pqzgWxzukU56HojlnqkiH2ZGvZ8Gviqi
	 poeeT/F0Lvkk6FsImkf0AxfepWhh1hUUzMcrh17R+nRRHEwWm4ffQDR8F4ic/6h7JfHD+
	 8PK8cDzaXSablgeQDX4QfaoQfyM+2vPfkf40sBwRjFQlh+5rmZB2r8OI/EEQRobeNuzIr
	 wUB7b+Py6bt9U9Re0J862eEEG+Rds4+zp4J1TH9oNeFFkhGflO2QafFWXiBYi90oe4w+y
	 9Ry5gb3dJksLpJanof0LoJgipy3NFTWSsZdLcvYiN29SkDVwwYYP/WaavFY4ZoFc9Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Av9BpIfaoxPoWdVxO+gAf42jrdXfuS5IaVdX090P+RU=;
	b=rKPmGXytS7DBZHoHXTCwtaDF45zvymALNSy5vskYBxZq2UkJrWmnubs63wA29mixJ1HX
	 wXXspMGbw9PtWh1D1gu9baHZ50/GAdbJp+vPcv1SYI1NR0a1kAw2ZA/9/qZNtkEevqher
	 TKwEOl+pxscCyM4zG4+GQnvJPig4UwQGnSlvfP/i4VoBABILqx90GvrAmg59sus3kvBGK
	 ySEbVwalLqBj1Ha2o6OaQ5P+VIqp6lx6ewvwC8z0RorO+pIwkdyDreLpXieZNZGz4bb1u
	 L2vhoaWX4ibXzRBz7u8kM0aE9hOgv2dZxkkdyXpEnkmYTgr/EYD4zJAvNuX0SsNwwiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m78H2cIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA2606A326
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m78H2cIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7932A1F0089F;
	Tue, 10 Nov 2026 03:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281591;
	bh=Av9BpIfaoxPoWdVxO+gAf42jrdXfuS5IaVdX090P+RU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m78H2cIHikrl58HRrTcEgVLn8m3HvvOj5bi1GreOqehpz6LMeSIt3Z0KW5MkePE2a
	 xQ003cvcn3CC3+VHEw4cLgxwA+sCjqhiYHDG372lOJ9a8er/AeUESPrBwjyOPtOJAn
	 vHYK/Qi6k+Br3q0ISSAm+sflcWJ5IplaiB9lTUOIyQKhca1jyKe1IJemh02hdQ5c2l
	 UCyOK/wrO2IpYyrVFpUJI0B7frpiqm6iaE9KKWmilsb88OwT761DdlU/9mQ/6pOQF+
	 YUVHW2oMedziIacvbSzbFaRknsAY30aAvUSsQgwavb7FH9h5xUkvCdjQxSvu9l4PsV
	 WsdPiH2/ryhBA==
Message-ID: <sashiko-outbox-206122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, bpf@vger.kernel.org
In-Reply-To: <20261109033154.2161803-2-rkannoth@marvell.com>
References: <20261109033154.2161803-1-rkannoth@marvell.com>
 <20261109033154.2161803-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:33:11 +0000
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
- [High] net: octeontx2: non-atomic RMW in otx2_sync_flags_from_rep()
  clobbers flags
--

commit d48d79ca17214bd041428c7ee5971241f58dd157
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

This commit converts the PF/VF and representor flags from u64 bitmasks to
unsigned long bitmaps manipulated with atomic bitops, and adds
otx2_sync_flags_from_rep() to copy representor flags onto the PF context.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 8417af94a02a0..f3158e293d864 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
[ ... ]
> @@ -593,6 +607,32 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };
> =20
> +static inline void otx2_set_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	set_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_clear_flag(struct otx2_nic *nic, unsigned int fl=
ag)
> +{
> +	clear_bit(flag, &nic->flags);
> +}
> +
> +static inline bool otx2_test_flag(struct otx2_nic *nic, unsigned int fla=
g)
> +{
> +	return test_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned long src =3D READ_ONCE(*src_flags);
> +	unsigned long new_flags;
> +
> +	new_flags =3D (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
> +		    (src & OTX2_REP_SYNC_FLAGS_MASK);
> +	WRITE_ONCE(dst->flags, new_flags);
> +}

[Severity: High]
Can the non-atomic read-modify-write in otx2_sync_flags_from_rep() clobber
concurrent atomic updates to dst->flags?

All representor netdevs share a single struct otx2_nic *priv (rep->mdev).
rvu_rep_setup_tc_cb() calls otx2_sync_flags_from_rep(priv, &rep->flags)
without holding the devlink lock, while otx2_devlink_eswitch_mode_set() ->
rvu_rep_destroy() runs under the devlink lock without rtnl_lock and sets
OTX2_FLAG_INTF_DOWN before unregistering the representor netdevs:

CPU0                                CPU1
rvu_rep_setup_tc_cb()               otx2_devlink_eswitch_mode_set()
  otx2_sync_flags_from_rep()          rvu_rep_destroy()
    READ_ONCE(dst->flags)
    /* OTX2_FLAG_INTF_DOWN is 0 */
                                        otx2_set_flag(priv,
                                          OTX2_FLAG_INTF_DOWN)
    WRITE_ONCE(dst->flags, new_flags)
    /* clears OTX2_FLAG_INTF_DOWN */
                                        ...
                                    rvu_rep_remove()
                                      if (!otx2_test_flag(priv,
                                            OTX2_FLAG_INTF_DOWN))
                                        rvu_rep_destroy(priv)
                                          /* double teardown / free */

Because OTX2_FLAG_INTF_DOWN is overwritten back to 0, otx2_napi_handler()
can re-enable CQ interrupts during teardown, and rvu_rep_remove() will call
rvu_rep_destroy() a second time, causing a NULL pointer dereference on
qset->napi and a double free of priv->reps and the representor netdevs.

Similarly, because cls_fl_ops sets TCF_PROTO_OPS_DOIT_UNLOCKED, concurrent
TC flower operations on sibling representors can lose updates to
OTX2_FLAG_TC_MARK_ENABLED on priv->flags.

Using a try_cmpxchg() loop (or atomic_long_andnot() / atomic_long_or()) to
update the masked bits in dst->flags would preserve concurrent bit updates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033154.2161=
803-1-rkannoth@marvell.com?part=3D1
