Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8573B14DB
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481003; cv=none; b=a0HOkSNmmrCdxNubHWa+cYmk1scTAW3zZ1VhP1yAMy/IsqrrM2dxyyQQs//8iaNF6zUk34tjjOVPk0FJN0LBuLtw89mh0LrpsmcU+ijOTxWz2/7UmyPCrKqWdEaIsPHTzM2C2CNam9faEE2vpX1HCqD3zj2tMBXBd3IUfu9lfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481003; c=relaxed/simple;
	bh=qPY4/nVuFZiPU488KmJD6UdHlI6WQ9ZxWMihhokiHVg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KJeJl0uKg5khFI+k702nc8NMD600382JoY3bKhXeX3YuMyJvYFyy93onYUZOZTGic1FgPt+4gjayFjkAqNIZrzySduKYKau/aMDGj97edo5jluwaXeDSVHm8V1A7/mDlJATt9rRcwnJG8RLuvZ35E21aqAK1AArbdAowBJL6HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihpJ83O2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihpJ83O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB661F00893;
	Thu,  8 Oct 2026 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481002;
	bh=jwQG4wdjUyu/EtjGzUyxPtfWfp8fpuHv1KTKQFtNSxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihpJ83O2stWeLSjw5ajvvcVYZEI4wM/9gin8RyzYqXIfvz3CL4Va41BZZYNY80XoS
	 CorhqakMUfC0ACeQr0COvVR8JP2M1+dR3gnQfibNYZD4pkm9L6NoOYJcJl4wVB6Tkc
	 jalxKMnnj3JNDlU+WNaIjV+SInZLWEoVfKW2K0xVj1AF1X4xFuzSqJ/atPf+fY70dB
	 Dx3kIjzMtKZIQ5Kzq3uYCZ+sDWdnUq+yNQnUFZy7gL9Fhpfp4F0GOP5/SopNa+ECvQ
	 zB+mGQSLBJIERnUtme5lYqlQYMuqE2xRn0oAMfAJkZgecElnmWbM17X+lXbQSH/CJr
	 qrgC3ZPo1RSZQ==
Message-ID: <sashiko-outbox-164421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/8] net: skbuff: don't BUG() on leftover
 length in skb_copy_and_csum_bits()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-6-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
 <20261007-b4-skbuff-bug-on-v2-6-b9a5f732895b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 17:36:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] skb: negative len from broken caller causes OOB write before mem=
set guard
--

commit b6b3af33d3ca9b0598654f13d4f01d9b22cff285
Author: Josef Bacik <josef@toxicpanda.com>

net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()

This commit removes a BUG_ON(len) check and instead returns 0 after zeroing
any unfilled buffer space. It explicitly aims to avoid a massive memset if
a broken caller passes a negative length.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c896770203f71..7fd2f8142cc41 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3713,7 +3713,13 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff=
 *skb, int offset,
>  		}
>  		start =3D end;
>  	}
> -	BUG_ON(len);
> +	if (unlikely(len)) {

[Severity: Medium]
Will this check ever be reached if a caller passes a negative len?

The commit message mentions avoiding a huge memset if len is negative,
but if len is negative, earlier loops in skb_copy_and_csum_bits() will
clamp their copy size to this negative value:

net/core/skbuff.c:skb_copy_and_csum_bits() {
    ...
    if (copy > 0) {
        if (copy > len)
            copy =3D len;
        csum =3D csum_partial_copy_nocheck(skb->data + offset, to, copy);
    ...
}

This negative copy value causes csum_partial_copy_nocheck() to perform a
massive out-of-bounds access.

Similarly, in the fragment loop, a negative len makes copy negative,
leading to an infinite loop and out-of-bounds writes in
skb_frag_foreach_page() due to unsigned comparisons.

Does this function need an early return for negative lengths at the entry
point to truly protect against broken callers?

> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
> +		return 0;
> +	}
>  	return csum;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-skbuff-=
bug-on-v2-0-b9a5f732895b@toxicpanda.com?part=3D6
