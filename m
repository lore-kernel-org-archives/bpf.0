Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDB37BE8B
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086048; cv=none; b=OTmO8UICxDqUhe7soXpkx277CdWHhkIEk9ZoIsTg2BZG77dzQtHu3x6ogPKp1rRWDYeexhSiAqQVCP6pZTcJ5Guv0GmmVAzlfKWlW/glZ6yWyFWUH89KEp4+oWnu8lpHebBIF7uAl65qLUNvfqkD9VpKRwrA3L6CgynXsAuW4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086048; c=relaxed/simple;
	bh=aSP8XnusnvOkAjzcWgEIdImBXWZ0dyH3B/ZmCJbrbhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkaQmohXzQhsdVUU7yzwNf+URwEfzLftDgBVoO57mNN+N/olY0k8Q47/vqdf/pB2MqV4RnjZ2pBZyJ0i8MZSIXhqRp5/d/hy9ye7I23vAU/f6JbBR0aXz5r/VAOSymyPCUK/tiyfnhOzjFIIGacpAfkvGOradE+QcZhvJbvLkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkHoyQ6x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkHoyQ6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B99C2BCB7;
	Mon, 18 May 2026 06:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779086047;
	bh=aSP8XnusnvOkAjzcWgEIdImBXWZ0dyH3B/ZmCJbrbhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gkHoyQ6x+XtYMgenSbyfcJiayvf9/ZZNWt+QZu5VqxUNnFv4EVPeSqg36wvF2quVk
	 jaGFuqIe6hfhNZQ20YaY2Lw5HILi7vtx/M8f/CekEywbuOayMEtQf2RQl3BEvqvcVO
	 Sn7BPB9i5IlJikt358qKmRFl7e8B6I4fSGzJrMCB29qYrSkn7sbaWirhJeDVZ/cvI1
	 my1K+SchGHA2Me+SFGHwI1nifnV/TKSmPlCs5861JnUjvsdwcPyea2sAYFlTOlvwe7
	 hzSkmgyD0VZrf8vmBKBcG27YbbYGvZzmfaKYvIaBR+AFhF9Ej6jXRr/LpyJgTH8mmp
	 qouBOerTQCm0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/5] xsk: cache csum_start/csum_offset to fix
 TOCTOU in xsk_skb_metadata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517063311.28921-2-kerneljasonxing@gmail.com>
References: <20260517063311.28921-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 06:34:07 +0000
Message-Id: <20260518063407.C3B99C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The `skb->csum_start` assignment in `xsk_skb_metadata` can sil=
ently wrap around 16 bits on architectures with large page sizes (e.g., 64K=
B), leading to negative checksum offsets and hardware descriptor corruption.
- [High] Software checksum fallback (`skb_checksum_help`) in `xsk_build_skb=
_zerocopy()` operates on an empty linear SKB, unconditionally failing and d=
ropping packets.
- [High] Returning `-EINVAL` from `xsk_skb_metadata` permanently wedges the=
 AF_XDP TX queue, causing a local Denial of Service.
--

commit a101fbe76c494016d6edebf7d5d5e0dc173c0af5
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. This commit fixes a TOCTOU
race by reading these values into local variables once.

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
> +		csum_offset =3D READ_ONCE(meta->request.csum_offset);
> +
> +		if (unlikely(csum_start + csum_offset +
>  			     sizeof(__sum16) > desc->len))
>  			return -EINVAL;

Does returning -EINVAL here wedge the AF_XDP TX queue?

If xsk_skb_metadata() rejects invalid metadata and returns -EINVAL,
xsk_build_skb() appears to propagate this error without advancing the
consumer pointer via xskq_cons_release(xs->tx).

When __xsk_generic_xmit() receives the -EINVAL error, it bypasses
the post-loop cleanup and the invalid descriptor is never consumed.

Could this put the socket into an infinite loop on subsequent sendmsg() cal=
ls?

> -		skb->csum_start =3D hr + meta->request.csum_start;
> -		skb->csum_offset =3D meta->request.csum_offset;
> +		skb->csum_start =3D hr + csum_start;
> +		skb->csum_offset =3D csum_offset;

Could this addition overflow skb->csum_start on architectures with large pa=
ge
sizes?

Since desc->len can be up to PAGE_SIZE (e.g., 65536 bytes on ARM64 or
PowerPC), csum_start could be as large as 65534. Adding the driver headroom
(hr) could cause the sum to exceed 65535, truncating when assigned to the
16-bit skb->csum_start field.

When the driver later computes skb_checksum_start_offset(skb), could this
result in a negative integer and cause out-of-bounds offsets to be programm=
ed
into the hardware?

>  		skb->ip_summed =3D CHECKSUM_PARTIAL;
> =20
>  		if (unlikely(pool->tx_sw_csum)) {
>  			int err;
> =20
>  			err =3D skb_checksum_help(skb);
>  			if (err)
>  				return err;
>  		}

Does skb_checksum_help() unconditionally fail here for zero-copy AF_XDP
sockets?

xsk_build_skb_zerocopy() creates a non-linear SKB where data is stored in
fragments, meaning skb_headlen(skb) is 0.

Inside skb_checksum_help(), it checks if the offset is greater than or equal
to skb_headlen(skb). Since skb_headlen() is 0, this check always evaluates
to true, triggering a WARN_ONCE and returning -EINVAL.

Could this cause all checksummed packets to be dropped when hardware offload
is unsupported and pool->tx_sw_csum is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517063311.2892=
1-1-kerneljasonxing@gmail.com?part=3D1
