Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412428688C
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535286; cv=none; b=nsx4/WS7oqNeTvS1lCqPNrqMJr3MCZ+/9SXpP1NR1hyy3ae7m40QCxK3LBP8ESbN507lcJAvn+/5+6qVp7xOdQiemWhH1GHbYA8qANIoH60gVm+Rhsn0fUvlS0nSHjWBXuCDzDMS3lznblT//KRDdRSucC137dVsnlZe2V1Cask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535286; c=relaxed/simple;
	bh=YHdzbdCfRFxrnJIKaOhwK+XYyNfYDnIAMQD+J+AJu2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BLHCxtowbDv99SzLL+tNJ9NVP4oNtaGt58CPajvcRjQIU4GVvbu+J6oeTn4YJ2cwNe4/4E6fJZErkpEbXGdTfCsiV72bUry+/MCEjb9S88kR66SGEvX78QLPnSfM8cpkqRq47hsTUcUeIfXYFASbbEsKklrLJAxEAw1hUcIATjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfnjopwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfnjopwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C621F00AC4;
	Fri, 31 Jul 2026 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785535284;
	bh=IM0p5m+H0KOnconCpF1L7N+mqRoTQLmTMYosxAt3Ehg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfnjopwv2deAG3sZlYIarpO/sTdBbN3j3AjXdQp9avW68Fbx4nMSRX4VzDfCu3fbW
	 SX+MBq7RRrEWhjhA1bVpRoipIJqI24aZ3RTaOr5IcPydXn+drqrqYzSlVCye8ltiGY
	 Ec8+LsRCE2Edh94XF05u2wAMZwIMqGAoRvDfZN+36wel2huIb1kYIZSnpPbYrt5MSQ
	 qTWaL/rS6f9JNTWVjAgeuHRRKldEOr0R4S2rYZMnIJhdTzj4ISRQN3Q1njJvjlwdUv
	 XJ/P9HxCGV7O1ZyRGj6Obn2GvZLuj8L80YrB2jJQ/vonPLwK1M1f9qF+eJYJYjZywJ
	 VI0GXS5Y34kRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejas Birajdar" <tejasbirajdar@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730220055.2946171-1-tejasbirajdar@meta.com>
References: <20260730220055.2946171-1-tejasbirajdar@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:01:24 +0000
Message-Id: <20260731220124.B0C621F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The `SOCK_RCVBUF_LOCK` check executes before the BPF program run=
s and before `full_space` is inflated, silently defeating BPF-requested win=
dows and bypassing dynamic `SO_RCVBUF` adjustments.
--

--- Patch [1]: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the=
 active connect path ---
commit 2cf5d1d17ae1c7488533ecaa0fcbb83ae4591ec8
Author: Tejas Birajdar <tejasbirajdar@meta.com>

tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path

This commit updates tcp_connect_init() to honor the initial TCP receive
window requested by a BPF_SOCK_OPS_RWND_INIT program on the active connect
path. It inflates full_space if the program returns a non-zero window,
matching the listener path's behavior, and uses u64 arithmetic to prevent
overflows.

Link: https://lore.kernel.org/netdev/20260723214208.3655474-1-tejasbirajdar=
@meta.com/
Link: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbirajdar=
@meta.com/

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e304..fcaa04e65189b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c

[ ... ]

> @@ -4137,10 +4138,13 @@ static void tcp_connect_init(struct sock *sk)
>  		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
> =20
>  	rcv_wnd =3D tcp_rwnd_init_bpf(sk);
> +	full_space =3D tcp_full_space(sk);
>  	if (rcv_wnd =3D=3D 0)
>  		rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
> +	else if (full_space < (u64)rcv_wnd * tp->advmss)
> +		full_space =3D min_t(u64, (u64)rcv_wnd * tp->advmss, INT_MAX);

[Severity: Medium]
This is a pre-existing issue, but does the SOCK_RCVBUF_LOCK check happening
before the BPF program runs defeat the purpose of allowing BPF to adjust
the receive window?

If an application sets SO_RCVBUF prior to connect(), SOCK_RCVBUF_LOCK is
set. In tcp_connect_init(), this caps tp->window_clamp to the old
tcp_full_space() before tcp_rwnd_init_bpf() is invoked.

When the BPF program returns a large requested window and full_space is
inflated, tcp_select_initial_window() bounds space by
min(window_clamp, space).

This caps it right back to the pre-BPF full_space and discards the BPF
request.

Conversely, if the application did not set SO_RCVBUF but the BPF program
adjusts it dynamically (which sets SOCK_RCVBUF_LOCK), the enforcement
check has already passed. This means window_clamp may remain 0 and bypass
the lock's constraints, resulting in an unconstrained window.

The same behavior appears to occur in the listener path in
tcp_openreq_init_rwin() in net/ipv4/tcp_minisocks.c, where
req->rsk_window_clamp is capped to the pre-BPF full_space before the BPF
program executes.

Should the SOCK_RCVBUF_LOCK checks be moved after tcp_rwnd_init_bpf() so
that dynamically adjusted SO_RCVBUF values are properly accounted for?

> -	tcp_select_initial_window(sk, tcp_full_space(sk),
> +	tcp_select_initial_window(sk, full_space,
>  				  tp->advmss - (tp->rx_opt.ts_recent_stamp ? tp->tcp_header_len - si=
zeof(struct tcphdr) : 0),
>  				  &tp->rcv_wnd,
>  				  &tp->window_clamp,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730220055.2946=
171-1-tejasbirajdar@meta.com?part=3D1
