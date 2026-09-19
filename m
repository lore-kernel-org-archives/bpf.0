Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D742B9B7
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789783218; cv=none; b=jUScxMlXWn6H6m80SsdWLuz+11RNW2CGkRvwfseSRgVNfkFbo2pMtymxmCZhRKkVY0tbXxg//Gp1XfFiQ4kfuZ+LsiYNpjfYhNaT8QwXQfWJ1QLSWcC71Sonqe8wloIkPCCZdLUdyNl9ua4PIDJJMckMk28IazQy3Lx8h04A/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789783218; c=relaxed/simple;
	bh=RHHJxAb+oyOI47sZtMFmJQbYzwtwV5TsFMCsXymgz1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fc+jI3CA+OotY14WC+aDI8GbsoXR1yGeZR7eEI4As8V1lfZi8beeuRl1merDJ6zE/5RI3MP0E6Ms5TCJa8LTtQwA8/vxAcHljyDq3PknyrWS4ga3rdLErQJ+A8tcLThQfzIMVbgHlTOvFfNWqwmA5piWnvnC/bPx1ZNmiaY1uUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llKHCFxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llKHCFxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556051F00898;
	Sat, 19 Sep 2026 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789783216;
	bh=Av7i0UGNUQ5YBNY/3RLwQeC6cAAEofVM1vPX8pOnjDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llKHCFxxjx0FfTpeH/d/ySUq1bdYgndka0fcZKt/edl8NCTOxwIczMhUEUmZWeVhB
	 aUdeMdpbe+vL/0sAR6KGwRcEmTI84UOmm4beJQAgU5iIhPt1aTSnH+DFuX/K1IcNzJ
	 WDkFcs2AiQ20/qmpP5uVLunFFPR6kW/w/agcVLJ+/YT0baZJnN5dctDYonWQWyZ4/f
	 pIGmRIzeXkiihprUpE/n+GQ221fjngya1+RH7N5MOUh9rnZ04iphewEVyzDXkOubDU
	 IGmyIQrppTNoBm7k3I7loQJwLrFzuE5H9t8Eo5iNJ5LbBLqX4LEQclpvszojST9D3e
	 XHjh0FXDbQPSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918015906.1255204-2-rkannoth@marvell.com>
References: <20260918015906.1255204-1-rkannoth@marvell.com>
 <20260918015906.1255204-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 02:00:15 +0000
Message-Id: <20260919020016.556051F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: torn state race condition in otx2_sync_flags_from_rep()
--

commit efc39444848abda6ed3d0dfe8f808dc182225903
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

Replace non-atomic u64 flag read-modify-write with unsigned long bitmaps
and set_bit/clear_bit/test_bit access across the NIC driver. Add otx2 flag
helpers and representor state sync functionality.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

[ ... ]

> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned int flag;
> +
> +	for (flag =3D 0; flag < OTX2_FLAG_MAX; flag++) {
> +		if (test_bit(flag, src_flags))
> +			set_bit(flag, &dst->flags);
> +		else
> +			clear_bit(flag, &dst->flags);
> +	}

[Severity: Medium]
Could this bit-by-bit synchronization cause a torn state for concurrent
readers?

When this loops over OTX2_FLAG_MAX bits, executing set_bit() or clear_bit()
individually, it breaks a single mask synchronization into multiple separate
atomic operations.

Concurrent fast-path readers executing otx2_tx_napi_handler() or
otx2_rcv_pkt_handler() might check pfvf->flags concurrently (for example,
OTX2_FLAG_REP_MODE_ENABLED or OTX2_FLAG_TC_MARK_ENABLED). Might they observe
an inconsistent combination of old and new flags during this loop?

This seems reachable if userspace configures TC rules on representors while
traffic is actively flowing, triggering rvu_rep_setup_tc_cb() to update the
shared structure.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918015906.1255=
204-1-rkannoth@marvell.com?part=3D1
