Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47B2F49FD
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518991; cv=none; b=l7DxZZpgVL/fnualQ1pLKqDBK/aA/EJo/UMp6+Z6BUdnbuDnU6r3bAGCUWmJrum5OsFcG30+hxOKjraNt+5E4tVVV+589neanL0qaIm7wsxVSlt29Uvw7R0y5NNF+xC/G8Gue+kuUXS4jHEFhDvG4FU1RGWqmFwzv+ujONlWTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518991; c=relaxed/simple;
	bh=othpS6jRdDjfEow7X28OpsLAoYZS+lP3dgBC1KefD0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZIsoNUmRt0ulm7ZG7NP02xvQr8XGtXyCET9K/UhFnIic1qekR1ndREBRy28pAdAHqsJhMWFHl3L86B8lDCVQpvWUQkYwsTwB/xG7y0auzrUqz2VuXoLJRvGBF41HdLDkO5BC3unikExwnBL1FgnzXizOusrmqR+ag7RObcr93dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YllbsZLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YllbsZLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F84F1F000E9;
	Wed,  8 Jul 2026 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518989;
	bh=givFSYQw3NKYs+YXBcUw13bvfmhwb13JL39rC4y5ZBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YllbsZLWcM3HV8P+wj8NRcubLa8II0BN6c8FDC09IJID4i9OS8ND9EBLcmeK258OP
	 wyvgV8Zen8hOdcbhyJcRiCtKaua5bqVnmuC3rXUpRXSN12Ov2NuDmug89VO3vZ8MWg
	 797TYRoHhKBg4Fz05CEn9o1sAqKGv+N/eqA5aPEGB8gRepvJkbOQMBqBB3rVRR5DKX
	 3o26DnO/uInjOy9TPMv7dlkw1msVT68CJR68AcTi2E7v8vpDObwoCkgE+bHIo7dNYy
	 TIrZ502S01jztVvhOcQh09/I84xRr0Dp8RBM4WojHDn61CFHGiL+5vZ1mchb1/9dWW
	 uFixb4We0BZ8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattia Meleleo" <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-fionread-no-verdict-v2-1-29dd293621c7@coralogix.com>
References: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
 <20260708-fionread-no-verdict-v2-1-29dd293621c7@coralogix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:56:29 +0000
Message-Id: <20260708135629.9F84F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function sk_psock_msg_inq() is now dead code and should be remo=
ved.
--

--- Patch [1]: [PATCH bpf v2 1/2] bpf, sockmap: Account for receive queue i=
n FIONREAD without a verdict program ---
commit c5a219566b06af42fd341fd941447a9a448fa4f0
Author: Mattia Meleleo <mattia.meleleo@coralogix.com>

bpf, sockmap: Account for receive queue in FIONREAD without a verdict progr=
am

This commit fixes SIOCINQ reporting for tcp_bpf_ioctl() when no verdict
program is attached. It accounts for bytes remaining in the sk_receive_queue
by adding tcp_inq() to the reported value.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..8e905b50deadb 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, i=
nt *karg)
>  		return -EINVAL;
> =20
>  	slow =3D lock_sock_fast(sk);
> -	*karg =3D sk_psock_msg_inq(sk);

[Severity: Low]
Does replacing this call to sk_psock_msg_inq() leave the function as
dead code?

Looking at include/linux/skmsg.h, it appears this patch removes the only
caller of sk_psock_msg_inq() in the tree. Should the function definition=20
be removed alongside this change to clean up the unused code?

> +	psock =3D sk_psock_get(sk);
> +	if (unlikely(!psock)) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-fionread-n=
o-verdict-v2-0-29dd293621c7@coralogix.com?part=3D1
