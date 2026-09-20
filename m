Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C83A9620
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915174; cv=none; b=kZkr4iI3jeyT5gIf5T9zd12Bzn2J7mHJ2KPCbE+8yJtEpuSoI6oo4VxKUOeJ5X3d38GQBmxvJOAJaBupatyoiNva+l0wRVmppZ4hbHyhHCEsQKmfEJp1lapX8CQGaRxnleFpoAqs7Klv6AdnDDtQerlqa/RPEWm6laxD2Dtpi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915174; c=relaxed/simple;
	bh=wu5rRdCgcxYKLUZUJJCr2AKw8xH3ntkIWhDgjlmqQ8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLZxhqjsPWRGxGpAGS2z/UoIOQPWRBFVaL1+TkM0NP2SexywG4lLJ/kZ0iCARbAw7d/dBgEbOAK7VR5vxwesThHXxULR8dNMc3smVm/xaq+PEYR7f1bMWDwU5waLxOjhxLxAVi6E0A5Lfwosx9Ykh3QhEfajYaCiAb/070vUYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLK8LVBV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLK8LVBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262241F0089B;
	Sun, 20 Sep 2026 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915170;
	bh=GFqU0NOOdLUcfkSRuPc48wiNDY08rguvrP1uObKlbCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLK8LVBV6e532sFIek5X0kvUt1DHoS4mEifwHXRjpjziTVlmof45NtpJU6mlHATn9
	 8mYnF0zJ8gL/FOL+2L1wDxKTBoqLvUFp46ZT9bxQQYzhJM8dMaHzMFfMlKUfI9y2/0
	 bXNVzndhPVNJnr1PvF6fyTaChuUiARkpNtCs+DwN8RVtIk5oEH/iOUHmIC9Y5OXXLm
	 1e4CcUo6LgY0/jAG55tb04vpIBQ6d1EAoDS0/gl5IdHCMluXDqZsK7uKNy3X+9oFsN
	 9+xVhyFMQp3M93wMDxnfoqJN1aEjtDkJd98lFTSLCm2hQF5Yt7tlbmqWBMPQBTVc20
	 FNkwi0u+G/TdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 1/9] net: add bpf_setsockopt for
 SK_BPF_CB_TIMESTAMPING_V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-2-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:29 +0000
Message-Id: <20260920143930.262241F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: TOCTOU race in sk_bpf_set_get_cb_flags() corrupts global stat=
ic key
--

commit 1e7a759ab84f855625d2d275769f450b5e750f84
Author: Jason Xing <kerneljasonxing@gmail.com>

net: add bpf_setsockopt for SK_BPF_CB_TIMESTAMPING_V2

Introduce a per-socket bit SK_BPF_CB_TIMESTAMPING_V2 for BPF Timestamping
V2, that allows a socket opt into recording a "start time" on every
skb it produces or receives.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..3486c5c2d1703 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5468,6 +5468,13 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk=
, char *optval, bool getopt)
>  	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
>  		return -EINVAL;
> =20
> +	if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_TIMESTAMPING_V2=
) {
> +		if (sk_bpf_cb_flags & SK_BPF_CB_TIMESTAMPING_V2)
> +			bpfts_v2_enable();
> +		else
> +			bpfts_v2_disable();
> +	}
> +
>  	sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
> =20
>  	return 0;

[Severity: High]
Does this unprotected compare-and-branch allow concurrent threads to trigger
unmatched global enable/disable calls, permanently corrupting the reference
state?

If multiple threads concurrently call bpf_unlocked_sk_setsockopt(SK_BPF_CB_=
FLAGS)
on a shared socket, they evaluate (sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags)
without locks. Both threads could observe the same initial state and invoke
bpfts_v2_enable() twice, but the socket will only decrement it once during
__sk_destruct().

Could this permanently degrade system-wide performance by leaking the static
key, or underflow it and break the feature for other active users?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D1
