Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E631AA1F4
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101857; cv=none; b=VjEYr4TPzZcBYcOOGep64OAY157QEPbQT68xLkZ6BhA4WuJZXxOSjG3ns3d+XBffm4t3u2sJRBGqRYAOTHyX2i8neCHRKScjV8rxBpKBtMvUQWW8zYXTJ5Pq3hYsxCoSFJju9TeM2pT7R9ectBAUb3OULaAp7455YXQDU+omUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101857; c=relaxed/simple;
	bh=nBWqLtQZ4OeBuRHKodylnr4htrKy7L6WwAOVmjOBGyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4YA3mfo3YMnSntVpjbmpSNH72Hj5V51VTrfm6CHmlcLV6w9JORbuTpdTkI7YP/Cu4t16veXD52QH+hCT9Xih6obJTb8t1K6ErY8HmnD2Qr1ahl/Qflw6B/Ulo21UmkNDggNh4hKZAAEZ+ADkHLCW2QBTI+ErKcR8y0LWGEmR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA+X0V6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA+X0V6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702751F00893;
	Sat, 30 May 2026 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101856;
	bh=4sqDsq5cS8CI9/1F1qM6PSZn2RXJE/mOT4eoDbO91i0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZA+X0V6Bz6ii70OxbE7RP4TTPb/2OMN/jv9xXEKTeC+os5q3EmB/okbY3z/wYWUkl
	 15KvpTwKR7Ojk8AeHaaXuyUaY1zzq/cqbkWwDf7R+oGwMvw3Pzhes9zfLG002OfiZd
	 tLbRRkTTPLCGkSInPKDp++r3KaUKreF3o+3o/qvkV2MruE2BEZi9mM9/jsQPglIYnJ
	 5dRlBPMtnvqQCDTBw7brO8GXNS54BsDZDxhtmcQs2CTLww0ap8fEa9LtuDr0JzTwoy
	 Jtn8WumFLQqkPx0ZmHjGMT24fT4T5Rrxj1MuSy53bfmeYAdrIXMJ4a7W6imY3nUurz
	 5qX8LMm9ZM2NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/5] xsk: cache csum_start/csum_offset to fix
 TOCTOU in xsk_skb_metadata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520004244.55663-2-kerneljasonxing@gmail.com>
References: <20260520004244.55663-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:16 +0000
Message-Id: <20260530004416.702751F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Truncation of `hr + csum_start` to a 16-bit unsigned integer on sy=
stems with large pages (e.g., 64KB) leads to a negative checksum offset, ca=
using out-of-bounds memory accesses and potential hardware DMA faults.
--

commit 7a5d0ad0065df9dde9ff7b2ebb8561268805c4e9
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
   =20
This commit fixes a TOCTOU vulnerability in XSK TX metadata processing. It
reads csum_start and csum_offset from shared memory into local variables
once, then uses the local copies for both validation and assignment.
   =20
Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.=
org/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5e5786cd9af55..f8c8a8c9dfba5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void=
 *buffer,
[ ... ]
>  	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		if (unlikely(meta->request.csum_start +
> -			     meta->request.csum_offset +
> +		csum_start =3D READ_ONCE(meta->request.csum_start);
> +		csum_offset =3D READ_ONCE(meta->request.csum_offset);
> +
> +		if (unlikely(csum_start + csum_offset +
>  			     sizeof(__sum16) > desc->len))
>  			return -EINVAL;
> =20
> -		skb->csum_start =3D hr + meta->request.csum_start;
> -		skb->csum_offset =3D meta->request.csum_offset;
> +		skb->csum_start =3D hr + csum_start;

[Severity: High]
This is a pre-existing issue, but does this addition risk overflowing the
16-bit skb->csum_start on systems with large pages?

If the AF_XDP chunk size and desc->len are large (e.g. up to 65536 on syste=
ms
with 64KB pages), csum_start can be near 65535. When headroom (hr) is added,
the result could overflow the 16-bit skb->csum_start and be truncated.

If this truncates to a smaller value, skb_checksum_start_offset(skb) could
subtract the headroom and produce a negative offset. In skb_checksum_help(),
this negative offset would be implicitly cast to an unsigned integer,
evaluating to true in the offset >=3D skb_headlen(skb) check and triggering=
 a
WARN_ONCE while dropping the packet.

Additionally, if hardware checksum offload is used, drivers might pass this
wrapped negative offset to the hardware, instructing it to perform DMA
accesses massively out-of-bounds from the packet buffer. Could this result
in IOMMU faults or memory corruption?

> +		skb->csum_offset =3D csum_offset;
>  		skb->ip_summed =3D CHECKSUM_PARTIAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520004244.5566=
3-1-kerneljasonxing@gmail.com?part=3D1
