Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502081;
	b=EcALosc3lIVVqLb1cnNpjDB3MYP9BXY7ScJqf58DljKc8GOt5OgmVCMZ4Y4HvX2/gsmD
	 bLEhV44PwVF1VqZb7/hYo3qupyRYb+yRkB3f6fvx/faJW6DRHBoVOiJJtcyuSiwIp8oC4
	 aaSn7FXfg198a80jdq+hC9vDT+BBuBlMh4Ii0CzRyhfqqSzE7fFGyjVOfZxo2T7GrMTA0
	 2jB7bJjTg4Z2TZEmSDB+Pf3BL2qWQgbYizmO8u/iFvee+pQoLyUXkeVulX02ZRH0CYlIf
	 eh8vcOGqLgzhvrLfn5mpuNaC4Nq8BJq2MhLy+wlV7majFnV/O+SAXa0uk261a3rASbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kq4yy3Fy39OMKwcapZBYgK8WTCrAQBImmzG/TKA4W2M=;
	b=Jln5K8QBpKlssHefQWj9L16IiZiqf4bkl9K7maRFmis6+uDaPgj1gmlY7xevFph+RUFV
	 PNJHz4s21eu8aJpZwKtoq8ZeZyu3f7r0Z3sIpPNroK+7ltgpssFo+v+jEx+zQKkGDGCHj
	 ZYdDlLm4fy2ZNN/LjM1s1ddeQXivA5Z3JOP2mrA16OhNtlhS27emLd8t9JG4gM6ymjCPU
	 HWHaTjU9XBQoDEXJ8DW/LrqtfiWOchcQNaOLvPlpaNyiAqndkdcabzEp1KAoiYfyswsjd
	 jFsxeKAOTfdgRiWre11sUZWaCVkvL/r9dOKK8FTws8Klvuap2+SCW6PcHaJROVHdvqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRS+VBDw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786C606A331
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRS+VBDw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642CF1F000E0;
	Tue, 24 Nov 2026 06:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795502080;
	bh=kq4yy3Fy39OMKwcapZBYgK8WTCrAQBImmzG/TKA4W2M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nRS+VBDwR7suB3N+UmxdNRnaYAtWBgMsTVVtlHeWW/uEw1152w/4XRc+gLC7cmMzT
	 cc90f6t41s/h7u4wcRvsBWKX2JDYNWRGf85upbGphFvOZD3sqazalpnNdjlcYVVFsh
	 SCt3nxx1qS8OvTkdXTPDtjKDBo+H4lx9Opq9jSxLRoRM1oOPxD2qaoGnV1kOI602k6
	 B/nzUASqVkaMQLyOMxGrM54qfIeGPfeMVjXKUYCpvk4N1jI2miomGW2Rd0NOc+sZfT
	 TUIrcdlJDO+Z0R8imVHvfykkupr4KHk9ZZsJBYOzt5n9K0of9/NfOaIM+OxmBWkkKz
	 L5lqia2wbXNjw==
Message-ID: <sashiko-outbox-230603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, lsm: fix bpf_setsockopt() on a half set up
 child in inet_csk_clone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261124061544.254586-1-jiayuan.chen@linux.dev>
References: <20261124061544.254586-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:34:39 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] bpf: NULL deref in bpf_sk_clone_setsockopt() via MPTCP
  subflow_write_space()
- [Medium] bpf: unnecessary rejection of IPV6_AUTOFLOWLABEL in
  bpf_sk_clone_setsockopt()
- [Low] bpf: multi-line comment style violation in bpf_lsm.c and
  filter.c
--

commit 9470b8f4e13b2c8be2cf5cc10f852d869dbb6f7c
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, lsm: fix bpf_setsockopt() on a half set up child in inet_csk_clone

This commit introduces a dedicated bpf_setsockopt() helper for the
bpf_lsm_inet_csk_clone hook that rejects socket options unsafe to set on
a partially initialized cloned child socket.

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index ae23511fd811b..fa71f52a055c5 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -79,6 +79,15 @@ BTF_ID(func, bpf_lsm_inet_conn_established)
>  #endif
>  BTF_SET_END(bpf_lsm_locked_sockopt_hooks)
> =20
> +/* List of LSM hooks that trigger on a locked child socket which is not
> + * set up yet, bpf_setsockopt is restricted there.
> + */

[Severity: Low]
This isn't a bug, but BPF multi-line comments place the opening /* on
its own line (here and above bpf_sk_clone_setsockopt() in
net/core/filter.c).

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 53c042b267ab6..77abc4cb9db51 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5938,6 +5938,43 @@ const struct bpf_func_proto bpf_sk_setsockopt_prot=
o =3D {
>  	.arg5_type	=3D ARG_MEM_SIZE,
>  };
> =20
> +/* security_inet_csk_clone() runs at the end of inet_csk_clone_lock(), t=
he
> + * child is locked but not set up yet: its timers are not initialized, it
> + * holds no reference on icsk_ca_ops and an IPv6 child still points to t=
he
> + * ipv6_pinfo of the listener.
> + */
> +BPF_CALL_5(bpf_sk_clone_setsockopt, struct sock *, sk, int, level,
> +	   int, optname, char *, optval, int, optlen)
> +{
> +	switch (level) {
> +	case SOL_SOCKET:
> +		if (optname =3D=3D SO_KEEPALIVE)
> +			return -EOPNOTSUPP;
> +		break;
> +	case SOL_TCP:
> +		if (optname =3D=3D TCP_KEEPIDLE || optname =3D=3D TCP_CONGESTION)
> +			return -EOPNOTSUPP;
> +		break;

[Severity: High]
Should bpf_sk_clone_setsockopt() also reject SO_SNDBUF and
TCP_NOTSENT_LOWAT?

When an incoming MPTCP subflow is cloned in inet_csk_clone_lock(),
inet_clone_ulp() -> subflow_ulp_clone() allocates a new
mptcp_subflow_context with new_ctx->conn still NULL while newsk inherits
sk_write_space =3D subflow_write_space (new_ctx->conn is only populated
later in subflow_syn_recv_sock()).  Both SO_SNDBUF in sk_setsockopt()
and TCP_NOTSENT_LOWAT in do_tcp_setsockopt() invoke
sk->sk_write_space(sk):

net/mptcp/subflow.c:subflow_write_space() {
	struct sock *sk =3D mptcp_subflow_ctx(ssk)->conn;

	mptcp_propagate_sndbuf(sk, ssk);
	mptcp_write_space(sk);
}

Passing sk =3D=3D NULL into mptcp_write_space() ->
mptcp_stream_memory_free() causes a NULL pointer dereference.

> +	case SOL_IPV6:
> +		if (optname =3D=3D IPV6_TCLASS || optname =3D=3D IPV6_AUTOFLOWLABEL)
> +			return -EOPNOTSUPP;
> +		break;

[Severity: Medium]
Does IPV6_AUTOFLOWLABEL need to be rejected here?

Since commit 5121516b0c47 ("ipv6: lockless IPV6_AUTOFLOWLABEL
implementation"), do_ipv6_setsockopt() handles IPV6_AUTOFLOWLABEL via
inet6_assign_bit(AUTOFLOWLABEL, sk, valbool) and
inet6_set_bit(AUTOFLOWLABEL_SET, sk), which modify
inet_sk(sk)->inet_flags on the child socket rather than the listener's
ipv6_pinfo.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124061544.2545=
86-1-jiayuan.chen@linux.dev?part=3D1
