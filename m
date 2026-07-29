Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE093AAF40
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338706; cv=none; b=alRVhiw2BWWVAPYNmwSfz6s5EYeBZ0n3LfnfyPKBPYfp7ZKa+hmcFaivpRlwvbG9iasSukXJANbwRfknrbufXbsdmq0cT6KHoEo8cckNQ6i+8KCEbxTNpFdWC0a8iZhSNJrpkUUWI08iP4nhGdHWE/mcIs7fsSux2lARkyFzZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338706; c=relaxed/simple;
	bh=/GwVqYjCrMfINxoN+h9JAqBTc9JLZl2Dxr062Uy3dW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ab+AxCt3EPp2/DUdB7WUYQCvdxU6mqRxMR2Lrmn//U0Eb8MHmItGKVY3lcngDov4gJrqOVWoG5Z2pgTa3HTwjoceLE8XgOHqCaxBdh1Um30U98A4ewqbHjVhVD1TK7PI/swNKJ7I5TJL/xkgZ0MMlM1gRsBFv4cMcR/W1A76o7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG+/1X6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG+/1X6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99031F000E9;
	Wed, 29 Jul 2026 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338704;
	bh=pL6UpxxVY7TMdnwZe+YSSrFCVcZF0dvMuRv6bBu27dM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QG+/1X6QyP2exlampJy9lfsDNUyP0PDqngG4aWr4utR9LlYXEI070uW40uHvEZwtC
	 ggYGeg8xpneWtdNH4I2IZWUYKSGJIh0Suf+p/wkdKtfJzwlwPFeSuYdNK3wg+A4IX1
	 3ADyZiitaJ+uIar1GEBROfjclFHcbgB5elSXyMlg69ec/ERq/WezazdhGEN1sEfE0u
	 LApbfvNmGd/MmLjPrQeBzNxVmo4jOcIV4FpbD7Q7olubnXSRhvoy4pNhPaZgJtAUnO
	 yZJdwGXZJmmmul7cF4g/LZCdQadYXgwIhrPoBI+7DcLGuFFPSNdMKvK6EqxRsQ6i6+
	 KE9uNL1nEklRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728152425.649600-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260728152425.649600-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:25:04 +0000
Message-Id: <20260729152504.A99031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing bounds check on `ca_ops->tso_segs()` return value causes a=
n infinite loop and soft lockup
- [Medium] Exported function `tcp_tso_autosize` lacks BPF kfunc registration
--

--- Patch [1]: [PATCH v5 net-next 1/1] tcp: Replace min_tso_segs() with tso=
_segs() CC callback ---
commit 459bb4a577e547baf34fbc452c0b63bca5545c92
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

tcp: Replace min_tso_segs() with tso_segs() CC callback

This commit replaces the min_tso_segs() congestion control callback
with tso_segs(), passing the mss_now argument to allow the algorithm
to return an explicit TSO segment number. It bypasses tcp_tso_autosize()
when the callback is provided, pushing the sizing logic into the CC.

> As a result, BPF programs shall be updated, because retuning a small
> constan will now directly limit tso_segs instead of the minimum.

This isn't a bug, but there are typos in the commit message here: "retuning"
and "constan".

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e304..101ca765a7a92 100644
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
Is this missing a BTF_ID_FLAGS entry for BPF congestion control algorithms?

The commit notes that BPF programs need to be updated to directly limit
tso_segs, which implies they might need to call tcp_tso_autosize() to
replicate the original behavior. While this EXPORT_SYMBOL makes it available
for loadable kernel modules, without adding it to the
bpf_tcp_ca_check_kfunc_ids BTF set, the BPF verifier will reject programs
attempting to use it.

>  /* Return the number of segments we want in the skb we are transmitting.
>   * See if congestion control module wants to decide; otherwise, autosize.
> @@ -2278,11 +2279,11 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned=
 int mss_now)
>  	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
>  	u32 min_tso, tso_segs;
> =20
> -	min_tso =3D ca_ops->min_tso_segs ?
> -			ca_ops->min_tso_segs(sk) :
> -			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> +	min_tso =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> =20
> -	tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +	tso_segs =3D ca_ops->tso_segs ?
> +			ca_ops->tso_segs(sk, mss_now) :
> +			tcp_tso_autosize(sk, mss_now, min_tso);
>  	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
>  }

[Severity: High]
What happens if the custom congestion control or BPF program returns 0 here?

If ca_ops->tso_segs() returns 0, tcp_tso_segs() will return 0, which gets
passed back to tcp_write_xmit() as max_segs.

In tcp_write_xmit(), this sets cwnd_quota to 0. When tcp_mss_split_point()
is called with a 0 cwnd_quota, it returns a limit of 0. This causes
tso_fragment() to chop 0 bytes off the SKB, resulting in a 0-byte packet
being sent.

Because the outer loop in tcp_write_xmit() doesn't re-evaluate max_segs,
won't this get stuck in an infinite loop chopping 0 bytes off the remainder
SKB, leading to a CPU soft lockup? Does this need a bounds check to clamp
the minimum return value to 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728152425.6496=
00-1-chia-yu.chang@nokia-bell-labs.com?part=3D1
