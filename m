Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130675;
	b=rS6J/2oHXcUpKEpWuAn+Iu6Tkbq4vutJCQqsEfKuPAH8uq9riAshmzTAQCpifwzlDa1L
	 +VRpujBOjp28gxr3nYr8i9ymqNdg5Ak8BeZn4PXOnIXFLyz2K0lcQ3rZ+J1vRQIMh6X7T
	 eIDlaSn+WrDh2KcBVOABNRUwzbCfaUxDh17VRGb2ZB6fRvs1Kfxsji4+Lp1XsgJma7jle
	 ApPffKige4ZvEULIaK3KJZetM4TvoKpXEbMjZPjL9VI4GIlagiI+mMbYoiD/OKbA9T5hp
	 35A14ST2L1Ix2O2o0VFpjFpzHyPm6tQx3K/yC7Ayr+81aK2CsSk65eMG4wiJ1ChkiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130675;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fQ0xtbNblNC9lliOfl3C3eS6yh5bvQ1utdFCcfnh210=;
	b=jJMsnjnz0TkE41Zli6gJVu/gFWucMDNeCkOeyBXzvIeJ3o4iV/mrMVXBM0WT1kqt+Xsh
	 n57Sqf5i6VDvMaW7qC1PRKfm+abb1MaOvXVCg3g2vUHMuKGutyEXTuFKlueHop/m4ZMqV
	 SnJ/SqHaGtCvEoZirSKMsHuQtnNtoDS2cQkBLyVvOK2os6mnF7MddplI+ddB7vbaGtAKJ
	 Wg5+zkwWKrhm5pA7fVaXhws8m+UnUZ+nOyp6aWygt1LSAB3XCgAdpy7dAWqZMlGUHGhbN
	 Tf3iRxy836tdItAfB37IQD06vt1qSubXcbbTUoV2thwqV9SwhNycbSO+1TAbp3FysFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIzG5d1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43B606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIzG5d1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064931F000C6;
	Thu, 19 Nov 2026 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795130675;
	bh=fQ0xtbNblNC9lliOfl3C3eS6yh5bvQ1utdFCcfnh210=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IIzG5d1paemM+iPyYsKt6q9UqMLmYM09kVcypM7o4MIDwICZUjJIun96YIC45ijhZ
	 5oaGrnHmQt5NqJkgPAamQSexVDAc7L2pmHCJTjiuQ/ecVcYXhBD4I4FY9GWD/UsyxS
	 7U+nsxRiq4ZWKhYxyYN/+tQiujviBKEVWuxbeMiAFzOAonYdf52RMPNGxu0ZVI5YVS
	 mlrUb+LUWLJIDxUZG9poBaZlStn8IgFTyCVXd/Fe/ccCXROEcnuliP7jnv/3cfDdMQ
	 F3FRS/fNm6uRUJNrqtFyqBlgfzvdHDbt3tiSqNQUoitVZaReJ2kBrRVnWI7CTLTYr9
	 pMIb5e6rt3tmA==
Message-ID: <sashiko-outbox-224183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/8] net: state the "XDP excludes LRO" rule in
 the core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261118232315.3593731-5-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
 <20261118232315.3593731-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 23:24:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] net/mlx5e: HDS state desync and NULL pointer dereference in
  mlx5e_fix_features() [1]
--

commit 8d89a545dc54012efb30f6483506602bf2681942
Author: Jakub Kicinski <kuba@kernel.org>

net: state the "XDP excludes LRO" rule in the core

This commit clears NETIF_F_LRO alongside NETIF_F_GRO_HW in the networking
core when an XDP program is attached, and drops netif_disable_lro() from
generic_xdp_install().

> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0bb5eb9fdea0..2b9c7aac09693 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -11431,9 +11439,9 @@ int __netdev_update_features(struct net_device *d=
ev)
>  	/* GRO_HW may be added back in via ndo_fix_features e.g. if driver needs
>  	 * it to honor the HDS config, clear it before the fix features call.
>  	 */
> -	if ((features & NETIF_F_GRO_HW) && dev_xdp_prog_count(dev)) {
> -		netdev_dbg(dev, "Dropping HW-GRO feature since XDP is attached.\n");
> -		features &=3D ~NETIF_F_GRO_HW;
> +	if ((features & NETIF_F_XDP_DISABLES) && dev_xdp_prog_count(dev)) {
> +		netdev_dbg(dev, "Dropping HW-GRO and LRO features since XDP is attache=
d.\n");
> +		features &=3D ~NETIF_F_XDP_DISABLES;
>  	}
> =20
>  	if (dev->netdev_ops->ndo_fix_features)

[Severity: High]
This problem wasn't introduced by this patch, but can mlx5e_fix_features()
re-enabling NETIF_F_GRO_HW for HDS cause an HDS state desync or a NULL
pointer dereference [1]?

Because mlx5e_fix_features() runs before netdev_fix_features() without
enforcing NETIF_F_RXCSUM, disabling NETIF_F_RXCSUM causes
netdev_fix_features() to drop NETIF_F_GRO_HW.  That turns off SHAMPO while
cfg->hds_config stays ETHTOOL_TCP_DATA_SPLIT_ENABLED, blocking subsequent
ring parameter changes.

In addition, mlx5e_fix_features() forces NETIF_F_GRO_HW back on for HDS
even after clearing it earlier for a legacy cyclic RQ:

drivers/net/ethernet/mellanox/mlx5/core/en_main.c:mlx5e_fix_features() {
    ...
	if (!MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_STRIDING_RQ)) {
    ...
		if (features & NETIF_F_GRO_HW) {
			netdev_warn(netdev, "Disabling HW-GRO, not supported in legacy RQ\n");
			features &=3D ~NETIF_F_GRO_HW;
		}
	}
    ...
	if (cfg && cfg->hds_config =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(features & NETIF_F_GRO_HW)) {
		netdev_warn(netdev, "Keeping HW-GRO enabled, TCP header-data split depend=
s on it\n");
		features |=3D NETIF_F_GRO_HW;
	}
    ...
}

If rx_striding_rq is disabled while SHAMPO is off and NETIF_F_RXCSUM is
then re-enabled, SHAMPO is enabled on a cyclic RQ.  mlx5e_open_rq() sets
MLX5E_RQ_STATE_SHAMPO while mlx5e_alloc_rq() skips mlx5_rq_shampo_alloc(),
and mlx5e_create_rq() dereferences rq->mpwqe.shampo while NULL.

[1] https://sashiko.dev/#/bug/linux-5e98dbaa-290f-464e-8d13-a0e3360d73b7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118232315.3593=
731-1-kuba@kernel.org?part=3D4
