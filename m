Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C64CC631
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546616; cv=none; b=F1TUJPRz5QAv5TFWczDwESZrDWnJvIFAOgJ6cL8zTDP6s9QLfGwCPTYYUJIlshGKX3fzZwIxpvL3WOdp9vKC5YAtQrhBPJrNbqXgAM7GqcRg7eNYwrdSiDlC8Bu/p7oOky9ZGYl7f1MDgwuwDbKceQFteYDP/uLFjDi8sr2KZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546616; c=relaxed/simple;
	bh=d8nR3luuKBLoleUauV4pj9tQzZqcgvNJXGWtEGUZ4cs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uLRvYRgcQessjHcI0WA6eDhsM069BQ/YUMuLFBPuJouWVAx+jvHRehk5k5Ht0L1ouQ5wEOWseqcyxSm6avdU/jxq7/NBl5huD9Wc6d464b1t0mWShCDV3vlkfBsUw8MBhP7PJTJLXFSuGf6qjoJoveVBpdXoD3wQX8trX3vw5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqr/1SWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqr/1SWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36581F000FF;
	Fri,  9 Oct 2026 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546606;
	bh=r1ODzEXXfMVfr1ktfAGyu19hoCTaxDYaY5SUiu0ZW6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eqr/1SWthR867DfNvxpK4OFG2UhcFgmnjLJziO4VaoHPG5tnzKKMJK6p7nlzYsDVI
	 K4tSfJBu6PZJnlR2B+hLld1wpb21ErZBZKQjf5X0xIeoAy8HkBx5H++BnToordLM3t
	 eQzPXBlCVOBJECsvyKNgRxlgsinXczLqpN827T7vtn6LFdcQRgF/jUlztfCJXmEJfH
	 5vDrt/hiC/umeNPDmxIJO8m9OD6MueJe8uvHBDhHGzCey2lhz3mqpoozVi8E6AJTt0
	 FHNNFWjOMElsb7Jr3GZDDkCeq48EItOvcON6drYEbvvFDKmnxHbOCP1PFBPbOynufX
	 WNcPUWE8AiQ5w==
Message-ID: <sashiko-outbox-165426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net-next 10/14] selftests: xsk: add a hardware mode
 to xskxceiver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008114909.734364-11-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-11-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:50:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/xsk: hardware ring software state out of sync on reset=
 failure
--

commit b6f9e6a7023dfe76a4790e608f82c3aef2c3cf4a
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
selftests: xsk: add a hardware mode to xskxceiver

This commit adds a hardware testing mode to the xskxceiver selftest, passing
physical interface parameters over UDP/IPv4. It also introduces an early=20
return optimization in hw_ring_size_reset to skip restoring hardware rings
if they are already at their default sizes.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testi=
ng/selftests/net/lib/xsk/test_xsk.c
> index 8d30c39c94c84..542c0579062a4 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
[ ... ]
> @@ -218,6 +291,10 @@ static int set_ring_size(struct ifobject *ifobj)
> =20
>  int hw_ring_size_reset(struct ifobject *ifobj)
>  {
> +	if (ifobj->ring.tx_pending =3D=3D ifobj->set_ring.default_tx &&
> +	    ifobj->ring.rx_pending =3D=3D ifobj->set_ring.default_rx)
> +		return 0;
> +
>  	ifobj->ring.tx_pending =3D ifobj->set_ring.default_tx;
>  	ifobj->ring.rx_pending =3D ifobj->set_ring.default_rx;
>  	return set_ring_size(ifobj);

[Severity: Medium]
Does this early-return optimization leave the software state out of sync if
the ioctl fails?

If set_ring_size() fails (for example, due to EBUSY), the underlying hardwa=
re
retains its previous, non-default ring size. However, because
ifobj->ring.tx_pending and ifobj->ring.rx_pending were updated optimistical=
ly
before the call, they are left permanently reflecting the default values.

With this newly added early return, subsequent attempts to call
hw_ring_size_reset() will read the corrupted software state and immediately
return 0 without attempting to retry the ioctl. Could this leave the network
interface with an incorrect ring size during test case cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008114909.7343=
64-1-maciej.fijalkowski@intel.com?part=3D10
