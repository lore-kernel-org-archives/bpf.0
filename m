Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FB4854E7
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281580; cv=none; b=TFs1ZSObSm+oP67b6Pfgpjc33BOMhpofjkcVA99nNOASlfowOIdzBNkBIVcGv5xEVeK2A7mDwGNE7Y4NeVn1YxwUtnLyKl8qDC9GrRiO0ZVQ+AnqAo2PCcSKiZI6zezuTfuqH4vkHzDoBfayaEkQbiTZxDj69srcHxlrUpaEj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281580; c=relaxed/simple;
	bh=l6WvuZO64pxooOGDqlsRjSc2fmSzD79tbCqgqfYnv1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eydBaljrVYqcRx5gQh2sATjAk7uXqoMHAVT6ImcQWVkEaIdoMrbQ24k2zxPQx3dZlBEOcuAwHn+NXgr9rXk3dVRGWmabLr15NcAfvtPxAt921GtpspW7RPcP3y6THRJOo/ZI5tGQF1NqtNrWRg2Mpr87QdSzZCfr77nVDkRbSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp3Tm1E8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp3Tm1E8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445EF1F000E9;
	Tue,  1 Sep 2026 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281578;
	bh=vpTOcU5OmHHnqMdg5jCn6m3ZO2mJ7VIWEQez7NTs0dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cp3Tm1E8AIz1Rooih7KYWMfQAVLOGQMiEc/P5wjVLnVZg0wVMZPN9RbMgnMpJlzvT
	 3uIaZlMk4lBO3+HDi0IdbbNI2mwj4R2oDGEPRNwx1Is+GdNqPGeG4bi1FX7Q0sJaJg
	 rZB2Lae68uozkkkyomgr/6ngWzd6orgBC691eHf2vQLv6nQ3PQGGaaoaozjMMMt2cj
	 qNYHwJSjTWGQWHlXD+QIjfP52zOrLXvyeMP2rw5EJ+AUYc7f1f0K2hks6JCm/OG1DY
	 +3Nftxyn990602NOWaUUtjY0IX4Tf4lowv5HHsXDrbsD/T3KJ/xffuTTKkNTNwL+TT
	 oD00MHjWuuMTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 2/2] bpf: make tcp_tso_autosize() available
 to BPF congestion controls
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831165230.2696893-3-chia-yu.chang@nokia-bell-labs.com>
References: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
 <20260831165230.2696893-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:52:57 +0000
Message-Id: <20260901165258.445EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly exposed kfunc `tcp_tso_autosize` unconditionally casts a=
 generic `struct sock *` to a `struct tcp_sock *`, allowing BPF programs to=
 trigger out-of-bounds reads by passing non-TCP sockets.
--

commit 772ad73b0346c50ea5e65074e40bac4513abf11b
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

bpf: make tcp_tso_autosize() available to BPF congestion controls

This commit exposes tcp_tso_autosize() as a BPF kfunc and registers it in
the TCP congestion-control kfunc set. It also adds sanitization for the
min_tso_segs and mss_now parameters.

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b1b493d46b9cf..b7f2ee5e7a6b1 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c

[ ... ]

> -u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> -		     int min_tso_segs)
> +__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss=
_now,
> +				 int min_tso_segs)
>  {

[Severity: High]
Does exposing this function as a generic kfunc allow BPF programs to pass
non-TCP sockets into it?

Since the kfunc signature accepts a generic struct sock pointer, it appears
a BPF program of type BPF_PROG_TYPE_STRUCT_OPS could extract a non-TCP
socket (for example, a UDP socket from skb->sk) and pass it here.

Because bpf_tcp_ca_kfunc_set is registered without a .filter callback, these
kfuncs might be accessible to all BPF_PROG_TYPE_STRUCT_OPS programs, not
just TCP congestion control programs.

If a non-TCP socket is passed, the function later performs an unconditional
cast and dereference:

net/ipv4/tcp_output.c:tcp_tso_autosize() {
    ...
    r =3D tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tc=
p_tso_rtt_log);
    ...
}

Could this result in an out-of-bounds memory read and potential crash when
tcp_sk() accesses memory beyond the bounds of smaller socket structures?

> +	u32 min_tso =3D max(min_tso_segs, 1);
>  	unsigned long bytes;
>  	u32 r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831165230.2696=
893-1-chia-yu.chang@nokia-bell-labs.com?part=3D2
