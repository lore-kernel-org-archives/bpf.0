Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0277327C09
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929362; cv=none; b=Nu1m465EdpLLygEFV44mW7sGKBo2uXaOeMMM4+dqqiszS0YX2ncY33+e3j6w3CFRa7IMhjDovkIRCiYAi+++htYYbabKFAli84yCDM3V4EnudAJ2c3qt0MaffHjoWx6omLRLRQ2HgS4RVJBxrgNXH4z2TmxXbBUrdKYs9uBbzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929362; c=relaxed/simple;
	bh=duCQ2oyN0icFZ59Wur0GYVp220kefMm9dRnJYghhK3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SRHHFr48Qju0yGpK2mfNKh81x6MFIc+s2ZcpT2lULYq0d8pKEQvYGBvw5ofiTVdQKWISRLEiZYzkj+iPlOmwiAB5NzoUC51i6y/KB0zrhvBsdhaQXK3sK+L/DcxvkCzIVanlpYgm6573rcXMdqwD8St+aDAWY0GKFRSu1Te7/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnMV/dDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnMV/dDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199131F00A3A;
	Fri, 24 Jul 2026 21:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784929361;
	bh=RiT/XdatxLecingPczT7crEyGK/tuGxq6eSvuRqCL0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RnMV/dDDJXNQmJsCbltxFYCkNvx8CEGG/prr0XpK30TjOi0+tk83ohjv4VKlykFTm
	 fMjehQRSeuCvh15QEypqpcT7HVynYqceta98Eex+oSlp1j7EPaBN+XlRSgKiP7oNKu
	 v8oiYaim2jFFizzpNZFIZI48qiyohyTaSe4uZ3KPvIocL0+0bYPZwqrlBy4QjyqcJB
	 q3TgXPR55CMK2pcjVwOkdKoJgIT9Mi2ngGYTySBDiNk/vkXW2/lCEuY/0xgrqxKe4k
	 qRB0IwckAk2GJ8C2eWx05MOZJbjU1PcCkF4uDQM+R8XVMlt+D6DOoQ4FA0eIdJ6o8h
	 /1s1yvuwM4Rqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejas Birajdar" <tejasbirajdar@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723214208.3655474-1-tejasbirajdar@meta.com>
References: <20260723214208.3655474-1-tejasbirajdar@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 21:42:40 +0000
Message-Id: <20260724214241.199131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incomplete fix for integer overflow when computing the initial r=
eceive window in tcp_select_initial_window().
--

--- Patch [1]: [PATCH net-next v2] tcp: honor BPF_SOCK_OPS_RWND_INIT on the=
 active connect path ---
commit 49a334daa027598fc715c7e2fdf73a1c1031f8be
Author: Tejas Birajdar <tejasbirajdar@meta.com>
Subject: tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path

This commit enables the BPF_SOCK_OPS_RWND_INIT hook to set the initial TCP
receive window on the active connect path, matching the behavior of the
passive listener path. It also attempts to prevent integer overflow by
computing the inflated space in 64-bit arithmetic and clamping to INT_MAX.

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e304..ffa28c98c2118 100644
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
> =20
> -	tcp_select_initial_window(sk, tcp_full_space(sk),
> +	tcp_select_initial_window(sk, full_space,
>  				  tp->advmss - (tp->rx_opt.ts_recent_stamp ? tp->tcp_header_len - si=
zeof(struct tcphdr) : 0),
>  				  &tp->rcv_wnd,
>  				  &tp->window_clamp,

[Severity: Medium]
This is a pre-existing issue, but does the initial receive window calculati=
on
still overflow inside tcp_select_initial_window() despite the u64 promotion
done here?

When a BPF program returns a very large initial receive window value (for
example, > 2941760 when MSS is 1460), the value is passed as the init_rcv_w=
nd
parameter into tcp_select_initial_window().

Inside net/ipv4/tcp_output.c:tcp_select_initial_window():

    void tcp_select_initial_window(..., __u32 mss, ..., __u32 init_rcv_wnd)
    {
        ...
        if (init_rcv_wnd)
            *rcv_wnd =3D min(*rcv_wnd, init_rcv_wnd * mss);
        ...
    }

Because both init_rcv_wnd and mss are 32-bit types, does this multiplication
overflow and wrap around to a small value? This collapses the offered initi=
al
receive window and appears to completely bypass the u64 overflow protection
this patch aims to introduce.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723214208.3655=
474-1-tejasbirajdar@meta.com?part=3D1
