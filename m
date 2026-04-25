Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F94A0C
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777090647; cv=none; b=pf0wWTmxCZVXW5FHsilxyQavOB+iaLghxybYwvav9ZpO4cQuFe8ai2ouM6RO036vY6FXhcgxJ0u+Wu9wdQusf71er40ifnrvNPtU47cfOGwb4Pmx0+xyWsZyI7OjhEOCnsNzJ/PG9ETh59L9ZB+aeCw6igA6TEImqXLzbFzbAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777090647; c=relaxed/simple;
	bh=nr193FrpURgjXIdM8297kwLOb7KbkVJXeDPVpXaefdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZOkigKndQA9mK+MAyU13geyQ8fpy6f1BaMh/lrsVen7peN/uVvi92J2fvXHcCd1nmwUO3n9H2CbB8SzOK2/CrBMn0LUNpKuhq4EVXuq/ddgL1oBlxWJIqOAiJFCkxN9w43EX5xbNKBJ0IEth6XAn2U9C8iLbZJVckg9gZIlEjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myRSUgQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myRSUgQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FB3C2BCB2;
	Sat, 25 Apr 2026 04:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777090646;
	bh=nr193FrpURgjXIdM8297kwLOb7KbkVJXeDPVpXaefdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=myRSUgQV1XvZ8zyH9WwzsDXV/tq+IgrGKtZ+SGNret0Rs6fLp09tjCSsz9MZLo2RY
	 OelPqgoCqGBBTNRNSPEoSoDZAO5+/n7lB2iREkAQhhM5e9xdkUBUa5VfrXqwpzcRFQ
	 GzC49Ths/H/GrYZ1XSvJ2EnFlrKDWvAGmG/fNSxlWTx/DIJqCnXWLwvo1wNBfLI1UW
	 +E6EuCOCjck6DVyZSiz9W6xfGDExDJQCxHv1YateSmrZrRSAN2Gm2eJCkGf0tqRhbb
	 d1Xikx05cH+KKCs2h8hHPj5KmddawbxqmKUYITFqfCZCSuUmtW9Yr0kCw3PPqY5yPf
	 RSF9Tg83QNzcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422033650.68457-4-kerneljasonxing@gmail.com>
References: <20260422033650.68457-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 04:17:25 +0000
Message-Id: <20260425041726.85FB3C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incorrect completion address reporting to user-space and leaked de=
scriptor on `-EOVERFLOW` in multi-buffer packets.
- [High] Packet stream corruption when dropping oversized multi-buffer pack=
ets.
--

commit 38322c7d2a85e9ef029404cbf4ae750b54520d27
Author: Jason Xing <kerneljasonxing@gmail.com>
xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path

This patch fixes a use-after-free in the xsk_build_skb() error path
by ensuring that in-progress multi-buffer socket buffers are not
freed if they are still referenced by the xdp_sock.

Link: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gm=
ail.com/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -969,7 +969,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>  	return skb;
> =20
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb)
>  		kfree_skb(skb);
> =20
>  	if (err =3D=3D -EOVERFLOW) {

I noticed a couple of pre-existing regressions in this error path.

Do the error handling paths for -EOVERFLOW leak the original descriptor
address and submit an invalid address to user-space?

When a continuation descriptor exceeds the fragment limit, the code
jumps to the free_err label before the current descriptor address is
stored in the xsk_addr array.

However, the error path still increments the descriptor count:

        if (xs->skb) {
            /* Drop the packet */
            xsk_inc_num_desc(xs->skb);
            xsk_drop_skb(xs->skb);
        }

When xsk_destruct_skb() loops up to the new descriptor count, could it
read past the initialized entries, find a zero address from the earlier
kmem_cache_zalloc(), and submit address 0 to the completion queue instead
of the actual dropped address?

Does dropping the socket buffer here cause packet stream corruption?

When a multi-buffer packet is dropped due to an -EOVERFLOW error,
the partial packet is discarded and the socket buffer pointer is cleared.

Because there is no state tracking to discard the remaining descriptors
of the dropped packet, will the transmission loop process the next
descriptor (which is just a continuation of the dropped packet) as the
beginning of a completely new packet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422033650.6845=
7-1-kerneljasonxing@gmail.com?part=3D3
