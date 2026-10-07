Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D83B8D7B
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393072; cv=none; b=J0im1rz07dxph1NEUvOxTvVJtqS+MpbZUgK3b7tU49L49np7LGvHL5+NBnqjV9eE2x72UmuS6XBGaVtBoZakMjHzwjbA5yJQOJfD0FsqGVcBjWLk9W3WoTb3x+/vF2GvtqmKnfTgNHnytdBhD3LJ3BnyhLSvJPuwiSBYPjrA7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393072; c=relaxed/simple;
	bh=3z7yCnKFENycmyBo5iRzyxwty0CPpvVlmaKfHUo3hdc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UwFkR4hdJEjgmFTdDWe4eRiNxguufxmfqLeMMo7Pc59XZJsyt59gydKzEMPvO5r6vv60N5AESFjT9iwikft+zbJhEbJLBcF0nnFzFcPlHpZLk7H2bqM7Ona07SedHSogEm+oA271cH4fsCNQv4GoMqltI1WH571tqfXrDCdvU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiupFnf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiupFnf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B911F000FF;
	Wed,  7 Oct 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791393071;
	bh=m+F0y8B6vyVgb8b7flYwu3ULp4CJvWkENnlIcgkFIvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RiupFnf53HqHdvKSmsbOVOHEmsfPSnb0unywdksWA2INKDfyXqkmFeYq9Srt2clRA
	 1nIIiEdbDH22nYCO6f04DNCZ5CHTQL2nkFcVmJFICZZCkCsIc4f3+ga4NeffNLUq2q
	 eK+9Z97XZPleOcI4jvdYBSNCBd2Gkqug+UqowGPr4mvjrmNWFBdRcqK5pXLzvpZy25
	 sAWNZavA3B6K3Op3Wu3RjwLoQprKcbXhum1jrG2FJR1emnXyOCEAaL1vpAg42/Fj4U
	 M9SsLnxh1tbKnwVrow1cLD9ejjZPMDC5LM9iTSyKvPqyHq0dBmz2bvZ32IOaSKR+ir
	 0XlEXV/ZYCgVA==
Message-ID: <sashiko-outbox-163218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/9] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 17:11:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] skbuff: skb_copy_and_csum_bits() discards linear part csum on un=
readable frags
--

commit 554d4ec9904f25474f32c877a62ca154d0b20324
Author: Josef Bacik <josef@toxicpanda.com>

net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

This commit zeroes out the remainder of a caller's buffer when
skb_copy_and_csum_bits encounters unreadable fragments. This prevents
stale uninitialized memory from being leaked when the buffer is
transmitted on the wire.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 5c4024a03e105..512ff9cfa269f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff=
 *skb, int offset,
>  		pos	=3D copy;
>  	}
> =20
> -	if (!skb_frags_readable(skb))
> +	if (!skb_frags_readable(skb)) {
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
>  		return 0;

[Severity: Medium]
By returning 0 here instead of the accumulated csum, does this discard
the checksum computed for the successfully copied linear part of the packet?

When icmp_push_reply() uses skb_copy_and_csum_bits() via icmp_glue_bits()
to quote an offending packet with unreadable fragments, the offending
packet typically has its headers in the linear part. Returning 0 discards
this partial checksum.

Since the ICMP payload contains the non-zero linear part, returning 0
causes the ICMP packet's overall checksum to be computed incorrectly,
resulting in the error packet being silently dropped by the destination.

Would it be better to return csum here instead of 0, so that the checksum
is mathematically correct for the zero-padded buffer and allows the ICMP
error to be successfully delivered?

> +	}
> =20
>  	for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
>  		int end;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-skbuff-=
bug-on-v1-0-1b4434c5357c@toxicpanda.com?part=3D1
