Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C8388890
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512191; cv=none; b=pbeBdkXA4krLa6Gm3ZmpwTnm+no87Tr5pSowDMFg6PyhqC7DBpAgycp6aswi56GAWncREqtPHWYfbDKNQ06dlC7GBR45eHrIxUFp0Y1jwZkbpLJCKbMWetBKvikF9XlyiQcv/DB2gMPOiJjTIMmVRd92N/FRy/H3fSXgwdOLZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512191; c=relaxed/simple;
	bh=q7J/y4cWvvw0tlFLMCcM7QjhnMc5OCTiRpSqSJ5FBgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrbC9uhtZ+c25GxnOaveqMX1JxR2ZeFmhmBGguR5PgX5AxUNq5DGSBjA4PbIHcMYJ4/9HYhZ9gj99GkeBfocqLUGz0vgVd+I9p+m+Io0MWTB8VYTk7Lst15UGfRfW0Lk1Sj7Vqh5A9rZWALqrMR1s3CS38nVYv8uod3Q5Fq1atA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7qHtKYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7qHtKYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232B01F00A3D;
	Fri,  4 Sep 2026 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512190;
	bh=bmTKZCfagpv0HjGwUME13+GllhVxqqFCtC20ZGfkUdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7qHtKYEKtLTuZJhqtA2eTUWipRXuGHf19+l8oESqXVjL1yIwehIRwHdngQaejZ6E
	 D8PQ3YXcRGjU49+LpN33Io6jDRvUEKENKj2Tl+hnxIeuOfRS1Kle+uU0O0a+sAwamu
	 p2QBb3beaWyuaXAZ76RTBawSbLo6WJ2a0o52T+r74k38jrlFtYXleAVbBXx05VIbFk
	 MSGy/8qTs0ijbHjX+D/hu3i54J3VgZZ0uHAzoBfzzPye3OX0W8mX0pMPZ5EkX0FGWx
	 HjsbDZ1bVtDROl4akDNOHVobArmpkIoRDUUDuH3yJJTVaVqc2+JVRBePb6gLuVWCJQ
	 e0rA63CI9LPRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next V3 07/15] net/mlx5e: macsec: Move RX marker
 from ft_metadata to flow_tag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tariq Toukan" <tariqt@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903085215.3691657-8-tariqt@nvidia.com>
References: <20260903085215.3691657-1-tariqt@nvidia.com>
 <20260903085215.3691657-8-tariqt@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:56:29 +0000
Message-Id: <20260904085630.232B01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel panic in error path of MACsec rx/tx rule addition due to un=
conditional cleanup of uninitialized IDs.
--

commit 427d364a8074fd7354a5aec874b383f2ef24a88c
Author: Cosmin Ratiu <cratiu@nvidia.com>

net/mlx5e: macsec: Move RX marker from ft_metadata to flow_tag

This commit moves the MACsec RX marker from ft_metadata to flow_tag to
avoid conflicts with PSP SPI values. It defines a new marker for MACsec in
flow_tag, updating steering rules while keeping fs_id in ft_metadata.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/dr=
ivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> index efc5167493c12..4ca3a6ded2841 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
[ ... ]
> @@ -1803,6 +1805,11 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macse=
c_fs,
> =20
>  		macsec_fs_rx_setup_fte(spec, &flow_act, attrs, false);
> =20
> +		spec->flow_context.flags |=3D FLOW_CONTEXT_HAS_TAG;
> +		spec->flow_context.flow_tag =3D
> +			FIELD_PREP(MLX5E_ACCEL_FLOW_TAG_PROTO_MASK,
> +				   MLX5E_ACCEL_FLOW_TAG_PROTO_MACSEC);
> +
>  		flow_act.modify_hdr =3D modify_hdr;
>  		flow_act.action =3D MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
>  				  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |

[Severity: High]
This is a pre-existing issue, but does the error path in macsec_fs_rx_add_r=
ule()
have a potential NULL pointer dereference?

If macsec_fs_rx_add_rule() fails before macsec_fs_id_add() is called (for
example, if mlx5_add_flow_rules() fails), the error cleanup path unconditio=
nally
calls macsec_fs_id_del() via macsec_fs_rx_del_rule():

err:
	macsec_fs_rx_del_rule(macsec_fs, rx_rule, macsec_ctx->secy->netdev, fs_id);
	macsec_rule =3D NULL;

If this happens on the very first rule added for a device, the device hasn't
been added to macsec_devices_list yet. In macsec_fs_id_del(), this causes
macsec_device to remain NULL:

	WARN_ON(!macsec_device);
=09
	fs_id_xa =3D (is_tx) ? &macsec_device->tx_id_xa :
			     &macsec_device->rx_id_xa;
	xa_lock(fs_id_xa);
	fs_id_found =3D xa_load(fs_id_xa, fs_id);

This dereferences the NULL macsec_device when generating the address for
fs_id_xa, which is then passed to xa_lock(), leading to a kernel panic.

Could this be triggered under memory pressure or if firmware rejects a rule
creation request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903085215.3691=
657-1-tariqt@nvidia.com?part=3D7
