Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A452C21DF
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947661; cv=none; b=m/8L1Y5S5Rb/B0sNipMqs6VCGrTyoMSiokiUKd6pybKowlriGrdzzUFyt98+dRJ88IWfqfOWL/v/KgSz/0GgSjzyPxbQK87M+0YVfDx1ZOKpzVM1J0n/bOoya3ZrBY8vmyHKHIzhyKYcL7e70jIOK6XnrMZi92q5I/K7dX7rabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947661; c=relaxed/simple;
	bh=6cblTvA9vicmoxQpyU47r+ZLsqNrbBYhPu8AgtpPDb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LbC460CIQ3wM6/ZERlGwej06TqJzD5uIgJ7+PF0Lbq8UZ4MSflOCNtAU96Nbqg+bfYqZB9bFp6q2fIFzLneGIWNVOpS3pr0ljcWGhbqB0zfXgB2GSjAOhtYjyxvG6M9m1Hhofvz0GUz80aFhIpMzLube7ZtkN0blVXUbhYHcf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAWuzS3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAWuzS3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C0F1F000FF;
	Fri,  2 Oct 2026 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790947660;
	bh=SkSliecVUNU+2gOO522ibmOu8d13PAMdSTDIPmpFCSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAWuzS3pP+LAPLbxRQhXic7Hd+BOA4xYbxZoT64leb6k5ZLSKvxR9KYgbPl8cAP9+
	 GdrH/zQZoas0FRcwir809SYDP00azLGFBcaG3KROJ5aQvEsXEp7dGg7t0R43TimaXy
	 PkU6WAUnktfrwnKacZdJPBP+luGTi0vn/Jh0eaCsEYihRGMuTSh7hA/ersBwoW5Dba
	 bclgcSyPMAj4KUpf6VzMmKUGGgyweAbf4jrtLMnWK6tvRRZ/kN2B/2ghvfbI52m4sa
	 duxFGoHkfTqtCJ6MfFpJEKricOOJNVPFkw6iYGmM2VEz2/dB0D0nIFtzj0H0TS5xoo
	 7AJy0relXehTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from
 the response descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:27:39 +0000
Message-Id: <20261002132739.B6C0F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: conflated -ENOSPC causes silent MAC filter drop on queue full
--

commit 5b00f3f5a2fd8517b295e1041c4e6854bbdcfd81
Author: Petr Oros <poros@redhat.com>

ice: take the switch rule AQ error from the response descriptor

This commit modifies how the driver extracts switch rule AQ errors by direc=
tly
reading the return code from the descriptor that ice_aq_send_cmd() copies b=
ack,
rather than from hw->adminq.sq_last_status. This avoids races when other
commands complete and overwrite the shared last status variable.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
[ ... ]
> @@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  		 * should go into promiscuous mode. There should be some
>  		 * space reserved for promiscuous filters.
>  		 */
> -		if (hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC &&
> +		if (err =3D=3D -ENOSPC &&
>  		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
>  				      vsi->state)) {
>  			promisc_forced_on =3D true;

[Severity: High]
Does this change unintentionally catch transient software queue exhaustion
errors?

If ice_sq_send_cmd() returns a native software -ENOSPC because the control
send queue is temporarily full (e.g., under heavy administrative queue load=
),
this fallback block will now catch it.

Previously, this block was gated behind the hardware-specific
hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC check. By changing it to
check err =3D=3D -ENOSPC, a temporary queue-full condition could be misiden=
tified
as a permanent hardware MAC filter limit.

This would cause the driver to erroneously set the overflow state bit and
return success, dropping MAC filters and leaving the hardware permanently o=
ut
of sync with the OS.

> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/et=
hernet/intel/ice/ice_switch.c
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
[ ... ]
> +	if (status) {
> +		enum libie_aq_err aq_err =3D le16_to_cpu(desc.retval) & 0xff;
> +
> +		if (opc !=3D ice_aqc_opc_add_sw_rules &&
> +		    aq_err =3D=3D LIBIE_AQ_RC_ENOENT)
> +			status =3D -ENOENT;
> +		else if (opc =3D=3D ice_aqc_opc_add_sw_rules &&
> +			 aq_err =3D=3D LIBIE_AQ_RC_ENOSPC)
> +			status =3D -ENOSPC;
> +	}

[Severity: High]
Will this translation ignore hardware MAC filter exhaustion during rule
updates?

Because the error translation is strictly gated behind
opc =3D=3D ice_aqc_opc_add_sw_rules, if a rule update command (e.g., expand=
ing
a VSI list) triggers hardware exhaustion, it appears it will return a gener=
ic
-EIO rather than -ENOSPC.

Additionally, native software -ENOSPC errors returned directly by
ice_sq_send_cmd() will pass through unchanged, leading to the conflation
issue mentioned above in ice_vsi_sync_fltr().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002130752.2597=
259-1-poros@redhat.com?part=3D7
