Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DCC8CE
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934687; cv=none; b=hJdRVjEJEywKd4m1hrbI2XywrHs6TkSNpGpcmxz6Tw1YT/wJXIEd2MOSNpwTcTRqfl3a5TXceIXjwnABnQuPiRDkFGSHPzO5JFCSUYgXmrIQKSNUmcqUZJqCbUlA6KBOM21Oyxs/Uvq/AsL88RtSXsroyRp3GJ2WLMqWK+ppzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934687; c=relaxed/simple;
	bh=8D5UushKBSnK0ZYAfhKAaC4/5v0NbtOI9Jk/J9k7w8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9aOXALFyjBuFgch9+zNfpCpuQO57KNkr7Sh7nijCjReHnMqTee83drPzpGjsP/g2MUJRmYgjFA9euvL0ueCtsvKMGqRS/3IFfEQsVnNj42btKQBgYQvomgM8Iz8km3ZdeCaxp5Dhm4N1SRoNeblRwlDvnprWxft9VbTffX9aBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXhSR3nj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXhSR3nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A234C19425;
	Sat, 16 May 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778934687;
	bh=8D5UushKBSnK0ZYAfhKAaC4/5v0NbtOI9Jk/J9k7w8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EXhSR3njSEhKIKvo4BxdlgVXgmZ+H6iqchB76C6ELcXtsOVpyjsZEx7Bd3tqV209f
	 AVDqJ6RY2bbsMqX0ocjaw4UxH7IkfxxC77fb0yu8nQlX9Wwa+AjS4cTKP+KBjzz9KT
	 rNFRnUWeielYacXozMvFUAc3Xmnc10idvH8Zc4P8ks5RjCoqk/fWFtYqriL8IMjC5U
	 lOFsvW4ixhxpxQOVTvDeF5BnhUSc7AZJeC00Ge2N6QmDoNPXuKSVmzBr8QmpJVz1bx
	 TgFK7pLD9UKXNRRzCkEhMbSwdf7JCWb7tAjsFSeZ4ZVzfwOLw/bQvvLwlORe/R95H4
	 5RyDIf46UYlsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515123018.80147-4-kerneljasonxing@gmail.com>
References: <20260515123018.80147-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 12:31:26 +0000
Message-Id: <20260516123127.1A234C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] UAPI breakage and transmission batch abortion due to returning -EO=
VERFLOW to userspace
--

commit 1d238b3786b35997fb62e781dd7528f204ca8b34
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs after overflow in xsk_build_skb()

When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
only the current descriptor is released from the TX ring. This patch
introduces a drain_cont flag to properly handle the remaining continuation
descriptors, preventing them from being misinterpreted as the beginning
of a new packet.

Link: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.or=
g/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 0a6203c425766..9c51eed6ee99c 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -1062,6 +1064,26 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
> =20
> +		if (unlikely(xs->drain_cont)) {
> +			unsigned long flags;
> +			u32 idx;
> +
> +			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> +			idx =3D xskq_get_prod(xs->pool->cq);
> +			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> +			xskq_prod_submit_n(xs->pool->cq, 1);
> +			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			if (!xp_mb_desc(&desc)) {
> +				xs->drain_cont =3D false;
> +				err =3D -EOVERFLOW;
> +				goto out;

Does returning -EOVERFLOW to userspace break the expected UAPI here?

The original code suppressed the -EOVERFLOW error to silently drop the inva=
lid
packet and continue processing the batch:

		if (IS_ERR(skb)) {
			err =3D PTR_ERR(skb);
			if (err !=3D -EOVERFLOW)
				goto out;
			err =3D 0;
			continue;
		}

By using goto out with err =3D -EOVERFLOW, doesn't this abort the transmiss=
ion
batch prematurely? Any valid packets queued immediately behind the malformed
packet would not be processed during the current system call.

Additionally, if the batch is aborted before any valid packets are transmit=
ted
(when sent_frame =3D=3D false), the __xsk_tx_release(xs) call at the out la=
bel
will be skipped. Will this cause the global TX consumer index to remain
un-updated for the dropped descriptors, leading to a ring slot leak from the
userspace perspective?

Note that a later patch in the series ('selftests/xsk: fix multi-buffer
invalid desc tests for drain_cont') acknowledges this behavior by modifying
the selftests to tolerate the early return, but does this actually fix the
underlying ABI breakage in the kernel?

> +			}
> +			continue;
> +		}
> +
>  		skb =3D xsk_build_skb(xs, &desc);
>  		if (IS_ERR(skb)) {
>  			err =3D PTR_ERR(skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515123018.8014=
7-1-kerneljasonxing@gmail.com?part=3D3
