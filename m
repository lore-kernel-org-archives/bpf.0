Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8F38DC60
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366308; cv=none; b=QsBZnw0o19BFVfXFA2QRr0+hiv1b3gakaAkC2vStDxQpf2oU26v191d/IXO3G7/0amYMZNOvh2oAZzmoWWtNcjY5S3kHsOMYNcmnMgVSZk9upN52ifDYHoTzxoWF8BVNZov7lPc8Rxvf1mpJbyezt9qjW9QP1HsxngP+VFJPWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366308; c=relaxed/simple;
	bh=olZaaaQM7hMKbV/U3u9Mkb6ms63aUXfPQSjnLoJbYpI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sr3eay7jaLLmL4sGmED375XqvEcFtV6y2QbFlzdJtYoMG6LWYxSmegFBHKoI0Sf8Q1SA7IUI6npcaKv58BIjOau+MhqjSTzBZ/Z0FzyFMDDIZ+qC2e46tjqEbd6r6wezVeoMhPVLPHtFeyD4UBu9gu8SiFqe244NkhXiJUXf2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItB4TcjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItB4TcjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F511F0089B;
	Wed,  7 Oct 2026 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791366300;
	bh=WdMAOqu6uhL6c+EANrvjmePVCE3/z1cP2F7fGc1NyJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItB4TcjBwbgSFi/AAeisHIvPypZkNN5yCHFM1iGvHdbnQT09Ne75rfAch0E8wHZHg
	 /k3nfQ52KL3FzKRyAfLhu6R2S7S/e4wFmcElo60pav/VmkzwsCw4JEjuSWmaAaMbjD
	 mxoZVdz2dtSyE/7xoN/u1gydKglv2ZktJl6XSEyX1huh5ZOiq9Jb1y/G2mfZJyPeAF
	 VComXGF1oUrHiuOrrDyJoxQrn4ERrxw4Eeqp91323In8c69wUx0MB7ZIyo2RV6AGgN
	 8Pm6bN5AlKRHxvMX7Iewyx8UfK/RAVJmG3F8rwx6iqC9VVWhs4GSBWSdTNnfeJuSmA
	 TNF2fneyUsXOQ==
Message-ID: <sashiko-outbox-162816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006094357.840823-2-rkannoth@marvell.com>
References: <20261006094357.840823-1-rkannoth@marvell.com>
 <20261006094357.840823-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 09:44:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net/octeontx2: Data race losing atomic flags in otx2_sync_flags_fr=
om_rep()
--

commit 17bb449e59bb6b8b6eb031b22fd6154b7b7c7de9
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

This commit switches PF/VF and representor flags from non-atomic u64 masks
to unsigned long bitmaps. It also introduces otx2_sync_flags_from_rep to
sync representor-owned flags onto the PF mailbox context locklessly.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
[ ... ]
> @@ -593,6 +607,32 @@ struct otx2_nic {
[ ... ]
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
Does this non-atomic read-modify-write risk overwriting and losing
concurrent atomic bit operations?

If a concurrent thread sets a flag asynchronously using atomic bitops,
such as OTX2_FLAG_PORT_UP in otx2_mbox_up_handler_rep_event_up_notify():

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_mbox_up_handler_r=
ep_event_up_notify() {
    ...
    if (info->evt_data.port_state) {
        otx2_set_flag(pf, OTX2_FLAG_PORT_UP);
        netif_carrier_on(netdev);
    ...
}

or OTX2_FLAG_INTF_DOWN in rvu_rep_destroy():

drivers/net/ethernet/marvell/octeontx2/nic/rep.c:rvu_rep_destroy() {
    ...
    rvu_eswitch_config(priv, false);
    otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
    ...
}

it appears the atomic change will be permanently lost if it occurs between
the READ_ONCE() and WRITE_ONCE() in otx2_sync_flags_from_rep().=20

Can losing state transitions like OTX2_FLAG_INTF_DOWN allow async routines
like otx2_napi_handler() to continue executing on teardown queues that
have already been freed, leading to a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006094357.8408=
23-1-rkannoth@marvell.com?part=3D1
