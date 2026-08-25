Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E636308D
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675521; cv=none; b=cnr3ETKdwaYnQObAmtVdsF7wY9cGevcuvOqOvFxz3l7trlG+d+fb6xoNy5q0dj2Vkxl5fN90aR5xe7QiHewDmx+W064C5QgO1OP2xuy46zRqCalobTKYloP/uYjH2XzpRDS+CsmY9bMNVGIqaRcuOxTcexgxBWjPRnGmEbA9N38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675521; c=relaxed/simple;
	bh=XmIVUC1ZqxYYijnxnm0/yUFBOq8T+tjlXsadYac0Smc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gip91gcDe8+ikGezTzG1Y59xcADY5kffUb0wfaxa8If80JVIJ1uFwRf48x4I1w0WbP0WL7zyzVvdt3bacSdH9hrr3g2nBWM6bmyIibigIclSIvhiVNq8Ts3ANXW80vz5WlvDGDd6FKw0ia79bRhP2XFtdHnPZutqeu4KceaHxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1N3/oH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1N3/oH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D128E1F000E9;
	Tue, 25 Aug 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787675514;
	bh=qyAKGeYuRKrtd21IpL0YoRBLHp2+QgQ2UfO2SiA/6AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1N3/oH77f5UpTs3ypb3RtIuaPeNbx9MzNlQ0l61GbZAm7qBPv6Ew+CNwuVPJPwlg
	 k7Ms+vaNcHxZQvabi2EG6FQ17u+zkMwAVRLAKIgY0WnYj3GNtuES0YlVyDIcEMv/D5
	 yxUY51eBnW2+esKS1iTgCZdI4v7kW5q+WTQ8ThPOeox8YLughwoo1lBSqc8E4v+brm
	 KDSabCUQEYyrZEFuR9o0v42uNfWFkDXya/mjPuE/TriR9GxOWbwptxG6Xi1g6Hx7cK
	 Ww1tuCCkX1qgMusK9fly5SwSwyhYHY0nvtAms+eJY4kYLsUbcfG60oLsktzUeVKrZq
	 AXzRbWPucIuyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() available
 to BPF congestion controls
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824163139.990734-3-chia-yu.chang@nokia-bell-labs.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
 <20260824163139.990734-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 16:31:53 +0000
Message-Id: <20260825163153.D128E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Type confusion in `tcp_tso_autosize` leading to out-of-bounds read=
 when called with a non-TCP socket from BPF.
--

--- Patch [2]: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() availab=
le to BPF congestion controls ---
commit 6f535d3aed5d0c1f1117963d858318f7f63354f5
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

bpf: make tcp_tso_autosize() available to BPF congestion controls

Expose tcp_tso_autosize() as a BPF kfunc and register it in the TCP
congestion-control kfunc set. This allows BPF congestion controls to
reuse the kernel TSO autosizing logic while applying their own
minimum TSO segment policy.

> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index ed4fea98dfde1..9deed2244c2de 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c

[ ... ]

> @@ -194,6 +194,7 @@ BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
>  BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
>  BTF_ID_FLAGS(func, tcp_slow_start)
>  BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
> +BTF_ID_FLAGS(func, tcp_tso_autosize)
>  BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)
> =20
>  static const struct btf_kfunc_id_set bpf_tcp_ca_kfunc_set =3D {

[Severity: High]
Does this allow non-TCP struct_ops programs to call tcp_tso_autosize()?

Because bpf_tcp_ca_kfunc_set lacks a .filter callback, it appears this kfunc
becomes callable by any BPF program that can access a generic struct sock,
such as a bpf_qdisc program.

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 7d3e0e715c4bf..a98036bcd987e 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c

[ ... ]

> @@ -2252,13 +2252,21 @@ static bool tcp_nagle_check(bool partial, const s=
truct tcp_sock *tp,
>   * in bigger TSO bursts. We we cut the RTT-based allowance in half
>   * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowan=
ce
>   * is below 1500 bytes after 6 * ~500 usec =3D 3ms.
> + *
> + * The min_tso_segs is floored to 1 to avoid surprising conversion. Also,
> + * BPF callers may pass mss_now =3D=3D 0. In that case the function retu=
rns the
> + * sanitized min_tso_segs value and skips autosizing.
>   */
> -u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> -		     int min_tso_segs)
> +__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss=
_now,
> +				 int min_tso_segs)
>  {
> +	u32 min_tso =3D max(min_tso_segs, 1);
>  	unsigned long bytes;
>  	u32 r;
> =20
> +	if (unlikely(!mss_now))
> +		return min_tso;
> +
>  	bytes =3D READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shif=
t);
> =20
>  	r =3D tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tc=
p_tso_rtt_log);

[Severity: High]
If a non-TCP BPF program passes a generic struct sock to this kfunc, can th=
is
lead to an out-of-bounds read?

The tcp_sk() macro casts the generic struct sock to a struct tcp_sock witho=
ut
validating the socket type. If a smaller socket structure (like struct udp_=
sock)
is passed, accessing tp->rtt_min in tcp_min_rtt() could read past the end of
the allocated socket structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824163139.9907=
34-1-chia-yu.chang@nokia-bell-labs.com?part=3D2
