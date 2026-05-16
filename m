Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339331C5D72
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934688; cv=none; b=GtCpDZiiyMFNKpNRNssRSjJ2+lCPDQXNuwez+gW7wIbrTkUnCchWP3d1nOp0M2OT2zteqEEA1Np6bCbILGa/yuCsBhP+DN3zYO55nUqL4BmHamOVpPMsFmohxEwsgDri9m2BvDUTBaYEkvMJBMuza66Y5vL5SZeOFgJPQ6khafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934688; c=relaxed/simple;
	bh=3tPY6LDTLWYIrGrmZJjRBDiZWlNvrYAySlgXB/2ZhMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D55EX13poJAVd507hmz84CRui91OJ/sOday2HnDzi9QfQg5RNBWyzJN5gPLrTo7SnJ9QdeoyZlfoMOzFjBXmp6a/REBxCj/5pfpCA1FOd5y3SpQgpiwPVkUkIAZ+U7l1tuSEdKcvp7lglq/SqruSPv/sVF4Rc4XmpypLXCjoBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOMlsw+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOMlsw+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D41C19425;
	Sat, 16 May 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778934687;
	bh=3tPY6LDTLWYIrGrmZJjRBDiZWlNvrYAySlgXB/2ZhMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iOMlsw+fGLTNakoahScW0eg70GtO5gHnNbL/aX9kRRNF+cOn+qVJIYsDm3nWPW9JK
	 xcqBbW6gHMIVJFeQv0fVJyjDrIbpETeJpMMAdh696hS08NX2Mxu5BIMzfnmK9BdNnY
	 drV9R4lzxNBAxDOfEQGFPhnW6IrF3Z329Fc4eSGvifcNXNvNnGF7J6EorA161X1qGr
	 Hvhq+vUp7quJaTBJ8MqjWE/TGJ0Q00Db7AE0E+b7IXs0iexdyMgSQB4dnNPsLIeD4H
	 /F4Hv8KptrLmCUKpRhp6Nh+352mkWYvoRWzA960izpHfzn3JIberekzbi6AxGn9oKf
	 0UzDHauiqPiSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 4/5] xsk: drain continuation descs on invalid
 descriptor in __xsk_generic_xmit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515123018.80147-5-kerneljasonxing@gmail.com>
References: <20260515123018.80147-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 12:31:27 +0000
Message-Id: <20260516123127.C4D41C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] State machine logic flaw causing valid packet drop due to un-clear=
ed drain_cont flag.
--

commit 8841b899f0208ddaf58f3df5eb5feff9db62147f
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()

This commit addresses an issue in the TX loop where an invalid descriptor
mid-packet leaves remaining continuation fragments in the ring, which
corrupts the packet stream. It introduces a drain_cont flag to drain the
remaining fragments on the next iteration.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c51eed6ee99c..ac4884a87a0fb 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1125,6 +1125,8 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		if (xs->skb)
>  			xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
> +		if (xp_mb_desc(&desc))
> +			xs->drain_cont =3D true;

Does this logic inadvertently leave the socket stuck in the drain state?

If xs->drain_cont is already true and the current invalid descriptor is the
final fragment of the packet (meaning XDP_PKT_CONTD is not set), the flag
is not explicitly cleared since there is no else branch.

If xs->drain_cont remains true, could the next invocation of
__xsk_generic_xmit() intercept the first fragment of a completely valid,
unrelated packet in the if (unlikely(xs->drain_cont)) drain loop?=20

It appears the valid packet would then be drained to the completion queue
and silently dropped with -EOVERFLOW.

Would it be safer to unconditionally update the state based on the
descriptor boundary, such as:

xs->drain_cont =3D xp_mb_desc(&desc);

>  	}
> =20
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515123018.8014=
7-1-kerneljasonxing@gmail.com?part=3D4
