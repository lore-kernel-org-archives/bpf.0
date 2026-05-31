Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4E22259F
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 04:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780201643; cv=none; b=SlSRDZe7tbLaVYk2BdtCAFazboMCi1WJtHrg2Sh/S7izSquausTB2OJibakrmDngsFvfDtvOiucv1moz60Jy+JhFnTTweFgNOehdNG5wrlpoKxGoGT9wo6f+IvrXwr55ovUTTaNo0Yj4uQK841WIYZmLS7SstHe16fZaoZo2ldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780201643; c=relaxed/simple;
	bh=WVAZ+vClJ3s33wJQ16gwr0t1B/0nZBez1j7SVNsInfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dAWW4Tk143PJjZ/E82pYdCPgcnKfTo3iulgEOOiyHgmmk7ZYWjqgGuHVbw777A3+4R31wjmapk0wMOE+5iTxvXLzY7nl4xarfPBcHBmzbE+cVE/6Y5fJDwaeay4ENZUExzMtRWljU9GsKB6UGSAIjXbI6Y5Yj2KWke8x6iO978s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT/bdXa7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT/bdXa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD4B1F00893;
	Sun, 31 May 2026 04:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780201642;
	bh=kcok6+HdQsTOVTpPefChU6uGM1leAE9RGlV+nO3NciM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MT/bdXa72T35Huu9lnDRqnQ/XtYB8OuZunra4uCUnjxjpWXK2bzOP/kRPVy1PBnvS
	 NV+LmdXONOXZxjMRSP0X/C+I5POabgQzd8nlViuP6e87QhTC2fxZGxiioolZ0eVRnu
	 4N2Nu2btipuP1IeHnJRfVxbMaxjvebN4Mvr/RelEWL9gbGPAs2lUhhzxh44J/iFojS
	 RZIyrAXo3CtXhuw/t79O6aoZ2EvSY1Ojp8XK87JmY95HDZfX7Sk7eRTCSUx4wApl0J
	 JCvsfF/mpxNRz0mKulqw7ITC8QCMcycimDslILbKmStzMQTTQMyqjMBBFZKd//u1IX
	 zPCiM1Ogf4puQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530042630.80626-1-kerneljasonxing@gmail.com>
References: <20260530042630.80626-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 04:27:21 +0000
Message-Id: <20260531042721.DBD4B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `struct xsk_tx_metadata` UAPI structure has an inconsistent me=
mory layout between 32-bit and 64-bit architectures, breaking compat mode d=
ue to implicit padding.
- [High] Silent 16-bit integer overflow when calculating `skb->csum_start` =
leads to a negative checksum offset and out-of-bounds hardware DMA faults.
--

commit 8339ac65115fadb8d99c0e54d06d57fab30b5e84
Author: Jason Xing <kerneljasonxing@gmail.com>
Subject: xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadat=
a()

This commit addresses a TOCTOU vulnerability where userspace could modify
csum_start and csum_offset between bounds validation and assignment. It fix=
es
this by using READ_ONCE() to cache the values into local variables, ensuring
that the same validated values are used for SKB assignment.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.=
org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support=
")

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5e5786cd9af55..f8c8a8c9dfba5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, vo=
id *buffer,
>  		return -EINVAL;
> =20
>  	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		if (unlikely(meta->request.csum_start +
> -			     meta->request.csum_offset +
> +		csum_start =3D READ_ONCE(meta->request.csum_start);

[Severity: High]
This isn't a bug introduced by this patch, but can the UAPI layout for
xsk_tx_metadata cause issues for 32-bit userspace?

include/uapi/linux/if_xdp.h:
struct xsk_tx_metadata {
	__u64 flags;

	union {
		struct {
			/* XDP_TXMD_FLAGS_CHECKSUM */

			/* Offset from desc->addr where checksumming should start. */
			__u16 csum_start;
			/* Offset from csum_start where checksum should be stored. */
			__u16 csum_offset;

			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
			/* Launch time in nanosecond against the PTP HW Clock */
			__u64 launch_time;
		} request;

Because launch_time is an 8-byte type following two 2-byte types, on 64-bit
architectures there will be 4 bytes of implicit padding inserted after
csum_offset. On 32-bit architectures like x86, __u64 only requires 4-byte
alignment, so there is no padding.=20

Does this mean a 32-bit compat userspace will write launch_time to an offset
4 bytes earlier than where a 64-bit kernel will read it?

> +		csum_offset =3D READ_ONCE(meta->request.csum_offset);
> +
> +		if (unlikely(csum_start + csum_offset +
>  			     sizeof(__sum16) > desc->len))
>  			return -EINVAL;
> =20
> -		skb->csum_start =3D hr + meta->request.csum_start;
> -		skb->csum_offset =3D meta->request.csum_offset;
> +		skb->csum_start =3D hr + csum_start;
> +		skb->csum_offset =3D csum_offset;

[Severity: High]
This is a pre-existing issue, but is it possible for skb->csum_start to sil=
ently
overflow here?

If desc->len is large (e.g. in unaligned_chunks mode or on platforms with
>=3D 64KB PAGE_SIZE) and csum_start is near 65535, could hr + csum_start ex=
ceed
the 16-bit skb->csum_start field?

For example, if hr is 256 and csum_start is 65500, hr + csum_start is 65756
which truncates to 220. Later, skb_checksum_start_offset(skb) calculates
skb->csum_start - skb_headroom(skb) (e.g. 220 - 256 =3D -36).=20

When hardware checksum offload is used, NIC drivers might use this negative
offset to compute header lengths and shift it into the TX descriptor,
potentially causing hardware DMA faults or PCIe completion timeouts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530042630.8062=
6-1-kerneljasonxing@gmail.com?part=3D1
