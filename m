Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587D0372ED5
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574705; cv=none; b=lKO7A8Dqi42gJ13jBgdnXkVG8IVpQz4+l44VAEZQZIYVHnVniI/W1e8D7CF5c6zce/3bB5+vfWv4RrTJJG6PWehxlQaGW8mS1LW7AL4F9mXCFUxQGV/TVRtPIUIoPjd4uORYZqhuzl1M07pthrcZ8u6QF0VETPd/LUEboDnfII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574705; c=relaxed/simple;
	bh=VcbjKBaSVOqcrY0XslqDSCY4Jc7GWrsL6mrJa2J7ROs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RuGy4fG+usLGVzJpbQGFP1xPBNbkmsDkNCpBf0kzcssbU17Bz2Y8yr7AVDU8ilgA02qpkdWatihHJBPPhUUeJ8j/2060SWO1vgpdDzRcg80+BNJz2jOMaFgHY/ee44onHy7XdgJlucdsdy/q4soZ/5F6Xo/w6lYXmKfN5TiQujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQvFKnJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQvFKnJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E5EC2BCAF;
	Sun, 19 Apr 2026 04:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776574705;
	bh=VcbjKBaSVOqcrY0XslqDSCY4Jc7GWrsL6mrJa2J7ROs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MQvFKnJoBPyEA77k8iyjwVWfA5TfDcDearrEa3X43j3heklTEqjhRtrB8k0Su5i95
	 iG7AGPWuY7Owfwf6CCtfJ7KEhafZjg9OCjWOe22MAMNRHaOs4MejeGpZXSt7gURNhy
	 5K4tTcGVWlZf0wRlZRMFQ9qtasKRASun266VKSShcpgI2Lpd/zvs4Bx+92fXoPJZAx
	 anOdg47LNh7PEQq1R84uEb66UoBrGhQwhBdbO9e19zWnkGQqSsAru/a3DGy6aViXKD
	 lHh3A4oApSJhsX6etcES8q/QTxjsztmyWTYmh0LS/q889txEOpIsh+tuC17Sspd8yn
	 y/4S4xcZsyHaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/4] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418045644.28612-5-kerneljasonxing@gmail.com>
References: <20260418045644.28612-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 04:58:24 +0000
Message-Id: <20260419045824.D9E5EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Calling `kfree_skb(skb)` in `free_err` after `xsk_skb_init_misc()`=
 triggers premature CQ submission and corrupts Queue invariants.
- [High] Memory leak of `xsk_addr` when `alloc_page()` fails during multi-b=
uffer packet processing.
- [High] On 32-bit architectures, `xsk_skb_destructor_set_addr()` truncates=
 the 64-bit UMEM offset, corrupting the Completion Queue address.
--

commit e60e7fb34b1c59698d11da732db02bb3302ab41a
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding any
frags. If a continuation descriptor fails, the error path frees the skb
while xs->skb still points to it. This patch adds a check to ensure we
only free skbs that were freshly allocated in this call.

Link: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gm=
ail.com/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 2f00f188533c1..470f6d25ddb93 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -974,7 +974,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>  	return skb;
> =20
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
>  		kfree_skb(skb);

This isn't a regression introduced by this patch, but could calling
kfree_skb() here trigger a premature completion queue submission?

If xsk_skb_metadata() fails earlier in the function, the skb destructor
is already set to xsk_destruct_skb by xsk_skb_init_misc().

Freeing the skb here synchronously invokes xsk_destruct_skb(), which
submits the completion to user space and increments the queue producer.
The error path then executes xsk_cq_cancel_locked(), which decrements the
cached producer.

Will this permanently desync the completion queue invariants and report a
successful completion for a failed transmission? Would it be safer to
clear the skb destructor before freeing it?

Also, is there a potential memory leak of the xsk_addr struct when
alloc_page() fails during multi-buffer packet processing?

When processing a continuation descriptor, an xsk_addr struct is
dynamically allocated and stored in skb_shinfo(skb)->destructor_arg
with num_descs set to 1. If the subsequent alloc_page() fails, the code
jumps here to free_err and returns -EAGAIN, leaving the partial packet
in xs->skb for a retry.

If the socket is closed instead of retrying, xsk_drop_skb() is called on
xs->skb, which calls xsk_consume_skb(). Inside xsk_consume_skb(), the
cleanup logic uses this condition:

    if (unlikely(num_descs > 1))

Since num_descs is exactly 1, the condition fails. Does this permanently
leak the xsk_addr memory?

Finally, does xsk_skb_destructor_set_addr() truncate the 64-bit umem
offset on 32-bit architectures?

The inline storage attempts to cast the address to uintptr_t:

    skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1UL);

On 32-bit architectures, uintptr_t is 32 bits, which drops the upper 32
bits of the u64 addr. In af_xdp unaligned mode, the chunk offset is
stored in bits 48-63.

Could this truncation lose the offset entirely, causing
xsk_skb_destructor_get_addr() to retrieve a truncated address and
submit it to the user-space completion queue?

> =20
>  	if (err =3D=3D -EOVERFLOW) {
>  		if (xs->skb) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.2861=
2-1-kerneljasonxing@gmail.com?part=3D4
