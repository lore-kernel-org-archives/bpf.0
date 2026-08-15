Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022830B529
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815063; cv=none; b=nFnBDa6F+49AwHF6uAL/bZ81pAYQVzPZ08IBJAHG++6zcviyHav57j+CVUK3o2jZ7QOEY87ZtYhVxPaXC03WfA6indCUQrm/K5QnGK+WngqHKBz6Ymes65dG+5de/du5LNJsFEPyKP6xEYSgjhNtHbphApglkKApRAuJJb9jaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815063; c=relaxed/simple;
	bh=etebojYQIKHZixQefJVFM6JJ0ZIGte5QgN2QD+B51DM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIO7/LY+nH+UKL87lsBk1rpuj8OE9FjXODLX7VcV3Uiygp05ep4CnTyzizuFYyq2s35mpouYmFF5v9ovX3JM8OIaGVQ1euGY6zeZK3CMX1nZEXR0Sc+kVN1+7v0xLS+85IccPzzxK/2h4qxmX2J5QrEhj8okJxFRMvTHX1cxJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyDZvRv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyDZvRv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC91F00A3A;
	Sat, 15 Aug 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786815061;
	bh=QPj1TwyXbHXNYmo/ORFBXzMVC7Zht7cgF70a/Nao1IE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyDZvRv6GKUfmEqe7Ru0zRv0RSk5v/15cI5Vwmv4HqnUL/XqZxvw1jqvIolt32Znf
	 HHSur7Z049NMbUjFm5kWP+87msW8KDpM3LWFcXUNqzHF17YQmOVMJhiODl+N+9czPs
	 tvEmyIZdIFq7mwmjh3FdOddD/wQI3LFFLYOhRTM3kLYX+VRuAdUtmJl8G1PSRUEmwz
	 0k7k2vwCtkLZ2L87J0AKsLG+wGU9CYbf6L+urSAD2BnEDCOqQk/H1rzFgdq+4EWtLF
	 SoyR/t5F3SnM/Fg+AoyixzxnThY35pSO87w89Fc1RIb5aZyEFKg7lCd1bnRH0zy8ul
	 GC0djIK8x2XXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 net-next 2/2] bpf: make tcp_tso_autosize() available
 to BPF congestion controls
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814173034.749151-3-chia-yu.chang@nokia-bell-labs.com>
References: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
 <20260814173034.749151-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 17:31:00 +0000
Message-Id: <20260815173101.5BDC91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Exposing `tcp_tso_autosize` as a BPF kfunc allows a BPF program to=
 trigger a kernel panic via division by zero by passing `mss_now =3D 0`.
- [Low] The selftest `tcp_ca_kfunc.c` fails to compile due to function rede=
finition and an invalid return type.

Pre-existing issues:
- [High] The already exposed kfunc `tcp_cong_avoid_ai` is vulnerable to a d=
ivide-by-zero kernel panic if a BPF program passes `w =3D 0`.
--

--- Patch [2]: [PATCH v7 net-next 2/2] bpf: make tcp_tso_autosize() availab=
le to BPF congestion controls ---
commit 8757143027760bc7421911e55324877a61cb35ac
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

bpf: make tcp_tso_autosize() available to BPF congestion controls

Expose tcp_tso_autosize() as a BPF kfunc and register it in the TCP
congestion-control kfunc set. This allows BPF congestion controls to
reuse the kernel TSO autosizing logic while applying their own
minimum TSO segment policy. Add a selftest exercising tcp_tso_autosize()
from a BPF congestion control through the tso_segs() callback.

> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index ed4fea98dfde1..9deed2244c2de 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -194,6 +194,7 @@ BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
>  BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
>  BTF_ID_FLAGS(func, tcp_slow_start)
>  BTF_ID_FLAGS(func, tcp_cong_avoid_ai)

[Severity: High]
This is a pre-existing issue, but since tcp_cong_avoid_ai() is already
exposed as a kfunc, is it vulnerable to a divide-by-zero kernel panic?

If a BPF program passes w =3D 0 to tcp_cong_avoid_ai() in net/ipv4/tcp_cong=
.c,
the condition tp->snd_cwnd_cnt >=3D w will evaluate to true, leading to:

    u32 delta =3D tp->snd_cwnd_cnt / w;

Since the BPF verifier does not enforce value range constraints on plain
scalar arguments, could a privileged user load a BPF program that crashes t=
he
kernel this way?

> +BTF_ID_FLAGS(func, tcp_tso_autosize)
>  BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)

[ ... ]

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 7d3e0e715c4bf..7914287dd5710 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
[ ... ]
> @@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const str=
uct tcp_sock *tp,
>   * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowan=
ce
>   * is below 1500 bytes after 6 * ~500 usec =3D 3ms.
>   */
> -u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> -		     int min_tso_segs)
> +__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss=
_now,
> +				 int min_tso_segs)

[Severity: High]
Similarly, does exposing tcp_tso_autosize() as a kfunc introduce a new
divide-by-zero risk?

Inside tcp_tso_autosize(), there is an unchecked division by mss_now:

    return max_t(u32, bytes / mss_now, min_tso_segs);

Could a BPF congestion control program pass 0 for mss_now, bypassing the
verifier's checks since it is an unconstrained scalar, and trigger a
divide-by-zero kernel panic?

>  {
>  	unsigned long bytes;
>  	u32 r;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/tes=
ting/selftests/bpf/progs/tcp_ca_kfunc.c
> index 58262e4903364..c0f8f20f3052c 100644
> --- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
[ ... ]
> @@ -109,6 +111,12 @@ void BPF_PROG(pkts_acked, struct sock *sk, const str=
uct ack_sample *sample)
>  	cubictcp_acked(sk, sample);
>  }
> =20
> +SEC("struct_ops")
> +void BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
> +{
> +	return tcp_tso_autosize(sk, mss_now, 1);
> +}

[Severity: Low]
Does this selftest compile correctly?

It looks like tso_segs is defined with a void return type, but then returns=
 a
value from tcp_tso_autosize(), which violates C constraints. Additionally,
could this cause a function redefinition error if u32 BPF_PROG(tso_segs...)
is already defined earlier in this file?

> +
>  SEC(".struct_ops")
>  struct tcp_congestion_ops tcp_ca_kfunc =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814173034.7491=
51-1-chia-yu.chang@nokia-bell-labs.com?part=3D2
