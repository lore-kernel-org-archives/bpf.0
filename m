Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926A385D84
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000240; cv=none; b=uQDKJ3sEXMLrnIA56D1pRCgs5VW9hyWxZCtTnd9n22CS7TXZ1kIPhyqofp1EKByNz7DDdFRUMZY3PM8/590F6JJolLaE4s0Z3Vz/cFyp5W5uDtlrFFax66L+H9jmH2dJMhq7aiVrBSVAxVHpt9/BnuU8Vavuk2l//WJdHKfWC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000240; c=relaxed/simple;
	bh=2RNK6V866zyFSUWrXqa/8PvJ54POUPX7+a6pouSpDmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKjvi9jywRsee3ibqu+dg2GCU0OP8EPPKxznZeULVEz4HD4q3KylpXY6RnkwN/JJrGOIpTzf/c58GKcWgm2yfDq86GIC0Zbd7uP3JGJ8VFrzoSI3h7TSSH5M+46sy//KDWRNYR7LPwQiRPoxyhCkPhGAGetjQgfXeaNpWTU2SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1skq34j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1skq34j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5511F00898;
	Tue,  9 Jun 2026 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000238;
	bh=kqrmYv8u+KISERdS7m3IrkJlJj6OwNjxyfCqTI2odh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1skq34jl83JRb/zun/BCSNM6s0o74Jti6xXbjZb9WH13dsBRYJN5RmAb+d9XfCH0
	 wsZzRLYaPyjfjdTmW5eQtF91KMrZeyBVyp/lV7FOF5JcNrHPf9kUo8lxfgby+gMJqD
	 8uCB7dHCC6qJneJBCmfuNliLu0f9bQwpvE9eA3HTCvypEY8lhpysW//Q5j0k6zDNS6
	 z/+h8OnQDxSE8hYrazYy57a8frTCtI6B45lDSBbclQe034MuqHQY1i2aQVLglZtJ6Q
	 hIrYG6Kf7dWwiVECz4bprPWOIQ4r5tPghndedzT74dEmPcSR/0NQMnX5rTL/MWCOYX
	 KUH5npS3McJJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP
 program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:17:18 +0000
Message-Id: <20260609101718.7D5511F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch incompletely fixes shared SKB data corruption in generic=
 XDP devmap redirection. When broadcasting to multiple destinations, the or=
iginal `skb` is used for the final destination (`last_dst`). If `last_dst` =
has an egress XDP program, it runs directly on the original `skb` and modif=
ies its packet data in-place without checking if it is shared. If prior des=
tinations lacked an egress XDP program, their clones were not unshared by t=
he new logic in `dev_map_redirect_clone()`. Consequently, they still share =
the same packet data buffer as the original `skb`, and the final destinatio=
n's egress program will silently corrupt the packet data of the earlier des=
tinations' clones.
--

commit 280ec1e15889a77555ac8877632a39ede4e76d91
Author: Sun Jian <sun.jian.kdev@gmail.com>

bpf: Unshare cloned skb before devmap egress XDP program

This commit modifies dev_map_redirect_clone() to unshare cloned skbs if the
destination devmap entry has an egress XDP program. This prevents modificat=
ions
by the egress XDP program from being observed by other clones sharing the s=
ame
packet data.

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b9..4ae65d44f9d6e 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -730,6 +730,12 @@ static int dev_map_redirect_clone(struct bpf_dtab_ne=
tdev *dst,
>  	if (!nskb)
>  		return -ENOMEM;
> =20
> +	if (dst->xdp_prog) {
> +		nskb =3D skb_unshare(nskb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does this logic still leave the original =
skb
vulnerable to data corruption during broadcast?

In dev_map_redirect_multi(), the loop clones the skb for N-1 destinations,
and then calls dev_map_generic_redirect() on the original skb for the final
destination:

kernel/bpf/devmap.c:dev_map_redirect_multi() {
    ...
    /* consume the first skb and return */
    if (last_dst)
        return dev_map_generic_redirect(last_dst, skb, xdp_prog);
    ...
}

If the earlier destinations lack an egress XDP program, dev_map_redirect_cl=
one()
will not unshare their clones. If the final destination (last_dst) does hav=
e an
egress XDP program, dev_map_bpf_prog_run_skb() will run directly on the ori=
ginal
skb and modify its packet data in-place without ensuring the buffer is unsh=
ared:

kernel/bpf/devmap.c:dev_map_bpf_prog_run_skb() {
    ...
    act =3D bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);
    ...
}

Could this silently corrupt or truncate the packet data for the earlier
clones that still share the same buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609100214.3375=
38-1-sun.jian.kdev@gmail.com?part=3D1
