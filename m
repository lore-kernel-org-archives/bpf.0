Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E43BBFDE
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507944; cv=none; b=Mzg8EDkhIJ4X9A20kZnLNKxIX31YRQdPrJ3wfWECMWjO+rivWskyevc6VDae404b8K8wP5PBBIo20yxA3eS0fGo6uLMNLzgrSWQlbOxqeKIq/1lccn6an/jq0IpMT9IrXmEGsSE7ySghtdPJcIHgtSMT/FGxiyBOpiSj+efTfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507944; c=relaxed/simple;
	bh=ToszQBcjmnEz2uQaZ9TydQRtREww+YjB2pPthPaFGTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qXJVZigLGD6lNx2lCf1XiNVREmonpExobPOZ9LhBt+mWFmdSv5i5Nj6EH4+k8zGt/6JAiBrzPBwlpzVqUgYWMmNVluFYiD+hTBGczW0Ps5Z8/87310wSVhS4KSksMhypvwIuUsYKaHJUformUHTceFKMDor97SqiM+6HVIyxAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly5pCZ2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly5pCZ2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0671F000E9;
	Mon, 15 Jun 2026 07:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781507943;
	bh=xRqxwDmV+ySIG1pHv3Z1rQ2E17IQj1Xlp6uVgSnrwXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ly5pCZ2iGq6phpwiOBlsTHetB+VHmM3qE2Uqu7k/LXBbshJdDlMmmgiRskQXoCW1U
	 L9BbzBzxFeZlvbZCQsDIh5SQPLPcb7ILI8OFz78mzw0q56lKyypwCX1oAs42zprqMl
	 hb9k/R+T80nZW+5kZpM016QAUY+dqmPJWaaGw9a/vTFi3rHpW8gT7bXdqRa01z7sVC
	 0LWA2da7BPvpHEqSG4GYEHq31dUkZbpoSllBmz9mB0scBctjJRMEwVClHjtkv+f8jD
	 C2BOfRe8IdJwZZYwza91TwKtLqm9NFLij25oGav9KjHHx0YnJd1PfN1sHGb9lutG6y
	 plcgibYI/CMjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:19:02 +0000
Message-Id: <20260615071903.2B0671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BPF programs can cause a kernel panic by passing `mss_now =3D=3D 0=
` to the `bbr_tso_segs` kfunc, leading to a division by zero.
- [Medium] The `tcp_tso_autosize` function is not registered as a BPF kfunc=
, preventing BPF congestion control algorithms from reusing default TSO aut=
osizing logic.
--

commit 39a9bf39a3860ba9dd1b2bed8669b97491df87c6
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

tcp: Replace min_tso_segs() with tso_segs() CC callback for TCP Prague

This patch replaces existing min_tso_segs() with tso_segs() CC callbak
for CC algorithm to provides explicit tso segment number of each data
burst and overrides tcp_tso_autosize().

> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
[ ... ]
> @@ -297,11 +297,19 @@ static void bbr_set_pacing_rate(struct sock *sk, u3=
2 bw, int gain)
>  }
> =20
>  /* override sysctl_tcp_min_tso_segs */
> -__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
> +static u32 bbr_min_tso_segs(struct sock *sk)
>  {
>  	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
>  }
> =20
> +__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
> +{
> +	u32 min_tso;
> +
> +	min_tso =3D bbr_min_tso_segs(sk);
> +	return tcp_tso_autosize(sk, mss_now, min_tso);
> +}

[Severity: High]
Can a buggy BPF program trigger a divide-by-zero panic here?

Since bbr_tso_segs() is exposed as a BPF kfunc, the verifier does not
restrict the value ranges of scalar arguments like mss_now. If mss_now is 0,
it is passed directly to tcp_tso_autosize(), where it is used as a divisor:

tcp_tso_autosize()
    ...
    return max_t(u32, bytes / mss_now, min_tso_segs);

Does this need an explicit check for mss_now =3D=3D 0 to prevent a local de=
nial
of service?

> +
>  static u32 bbr_tso_segs_goal(struct sock *sk)
>  {
>  	struct tcp_sock *tp =3D tcp_sk(sk);
[ ... ]
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
[ ... ]
> @@ -2269,6 +2269,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, =
unsigned int mss_now,
> =20
>  	return max_t(u32, bytes / mss_now, min_tso_segs);
>  }
> +EXPORT_SYMBOL(tcp_tso_autosize);

[Severity: Medium]
Is there a way for out-of-tree BPF congestion controls to reuse the default
autosizing logic?

With the removal of min_tso_segs, BPF congestion control algorithms that
want a custom minimum TSO size must implement tso_segs and handle the
autosizing themselves. However, while tcp_tso_autosize() is exported to C
modules here, it does not appear to be registered as a BPF kfunc (e.g., via
BTF_KFUNCS_START).

Does this force BPF developers to either lose custom minimum TSO sizing
capabilities or duplicate the tcp_tso_autosize() logic within their BPF
programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614071756.2396=
86-1-chia-yu.chang@nokia-bell-labs.com?part=3D1
