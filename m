Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9082EAB6F
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562569; cv=none; b=FTadk0b7vnmGr3AMvym7tpLb5zt6q2vdLiUtLgS+KYU4kvzf1DYCC0vbOrsyhlIUgIxh0ZrwwsiRTwI2NZCV0kIypcKdmQ668/fiYsDfQVsB5DdnuLu0/EilkBrDAiI8yKWBO3La+4EgtMu05cn1JVOPazHEn44RRQwH15MNsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562569; c=relaxed/simple;
	bh=iGa5q2DY3IgnWeLGtaTBNECpkf+/qwVvLBItC8bNAnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=roQrVZBfabqOhtzH2troKxRDL0CmIHyN/qgO7NSxgQ75tMUgEvrLrbDvk0vh/2rdkSALyVCscmdMVoL40rs/cz6hkEyZxYjNz9LmWOygCbgCiB1/2rpGccsi1VKC2l3KPOBG4dEaDaHTH3okLCDqG6yzuW2PM9mwJOGZtHs7QEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrNEHM0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrNEHM0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C201F00AC4;
	Sat,  1 Aug 2026 05:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785562567;
	bh=B1CbNG378RzIsRSb5eIiV+R1axwejY4ys5aIEIgXRo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrNEHM0Wom4YK/s4NykKDYYJagPUiZyzyWO0BTTmwiYtmfxO2Z+SWLUwkANjCNG6R
	 0alXmVAx8dzVifgtzqO0KyaOXDblxUGZBJLh/O2kxDvQzbhxvZ6OoQZ/V7V3DuwSpI
	 3Ue98R9Z+iBbXf618K3/+k9dkav58rXLJ+hLvYSWLxC2050hFZeHhs8I8K2o1Ovppp
	 XznehRX3H2TJ2fsM/vi5d5nCmuneDxe15p3e37jVIB9qWB2JIe9/CBOGIkA4CuvBa+
	 v+K9ZPuLALpnSGtU0vCivohuRrmNgxS8gGv14fZ8gLs+UkvevE14nOI0wYFU6Og3ZL
	 W/2RTaTVHaTgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow IP_TRANSPARENT and
 IPV6_TRANSPARENT in bpf_{set,get}sockopt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivaji Kant" <shivajikant@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801051307.478469-1-shivajikant@google.com>
References: <20260801051307.478469-1-shivajikant@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 05:36:07 +0000
Message-Id: <20260801053607.71C201F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf_setsockopt() bypasses MPTCP subflow synchronization for IP_T=
RANSPARENT and IPV6_TRANSPARENT.
--

--- Patch [1]: [PATCH bpf-next v2 1/2] bpf: Allow IP_TRANSPARENT and IPV6_T=
RANSPARENT in bpf_{set,get}sockopt() ---
commit c5ad31eb12f337883443730bb1839d63112c725e
Author: Shivaji Kant <shivajikant@google.com>

bpf: Allow IP_TRANSPARENT and IPV6_TRANSPARENT in bpf_{set,get}sockopt()

This commit allows IP_TRANSPARENT and IPV6_TRANSPARENT socket options to be
used with bpf_setsockopt() and bpf_getsockopt().

> diff --git a/net/core/filter.c b/net/core/filter.c
> index c21c1daecf9d1..04a9f9d8d07b4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5645,6 +5645,7 @@ static int sol_ip_sockopt(struct sock *sk, int optn=
ame,
> =20
>  	switch (optname) {
>  	case IP_TOS:
> +	case IP_TRANSPARENT:
>  		if (*optlen !=3D sizeof(int))
>  			return -EINVAL;
>  		break;

[Severity: Medium]
Does bypassing the protocol-specific sk->sk_prot->setsockopt() handler here
break MPTCP subflow synchronization?

Since sol_ip_sockopt() calls do_ip_setsockopt(sk) directly, it appears that
IP_TRANSPARENT settings applied via bpf_setsockopt() will not be synchroniz=
ed
to existing MPTCP subflows. Could this cause the underlying subflows to lack
the transparent attribute after they are instantiated?

[ ... ]

> @@ -5671,6 +5672,7 @@ static int sol_ipv6_sockopt(struct sock *sk, int op=
tname,
>  	switch (optname) {
>  	case IPV6_TCLASS:
>  	case IPV6_AUTOFLOWLABEL:
> +	case IPV6_TRANSPARENT:
>  		if (*optlen !=3D sizeof(int))
>  			return -EINVAL;
>  		break;

[Severity: Medium]
Will this introduce the same synchronization issue for IPV6_TRANSPARENT on =
IPv6
MPTCP sockets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801051307.4784=
69-1-shivajikant@google.com?part=3D1
