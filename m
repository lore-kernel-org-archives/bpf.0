Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF52DECBF;
	Sat, 10 Oct 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623573; cv=none; b=avtcuS+K1En80aB1s4X9g+MHiwf10vbIX0+jYA3ov2hIuuaW011lt+WnGVaaW5ou37hLlwHAI3CllqYfCQcBTSgnDBOdcI/V5gpxXyfes4uPR4dPVcJrN3d3/HhSYWEJbYrMazs3+vx+ryUhkLDc2Ts6IjuWpejXQKqk0SK3zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623573; c=relaxed/simple;
	bh=ESx+wOsSwAkFTsu7/2rkU2635ZUQFumEzakJg4MWSOQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3fTCkugwTIR34XJYSgKlmY4O7rSMb/C6lmQ/cv+rd3XJfkJ4eagVha7xC0rKGcRcqrysxyN+dtSM0EXM+5fhVqpPonSju821uT2R2t3l4czsmhoQMS+6faVZ16NPvsevEHV0rswlhsRVXKCFCi5EC9nnrVqhZwmWFOB23fyolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1NuFwfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1NuFwfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2AD1F000FF;
	Sat, 10 Oct 2026 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791623571;
	bh=LxQcqkgepHngPEMm5i4F/BPaAna/2NbVXxMS3TiZSEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P1NuFwfYKgsU/i3+ikr/MT5Fag8gHWINknS9qCmd58m3PyMDA2aD2+76g2F+iP78o
	 FG6JQTfzonc1iXoHOsdRwbv4MNfM5Xb8vmVMujm+FWLsybt5uzMLRZNFwxMKME8Zp6
	 ewageeZPEzy9qHRxyKRiIHdKYpBd5/kh0Zzy/jg7j8txGEdc5jq0paEtYZo62Bnn7C
	 mYPsqO1T0OD81OqgDRduRXko07pWK3jm/8OJUVv9vv1Jq3dEsNnCo0yCllIznVVd8S
	 LywPYt0LBEhx+2SSMpv8WKZ8gKeBJ2geUvdPcGLma3a1lRoNQgsHGZHTNt8k7EDqTt
	 UpalwrRNBZwuw==
Subject: Re: [PATCH net-next v2 1/7] ipv6: treat a negative optlen as 4 in
 do_ipv6_getsockopt()
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
Date: Sat, 10 Oct 2026 09:12:49 +0000
Message-ID: <179162356933.434549.9128206075467468309@kernel.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-1-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-1-8ac08c469ecb@debian.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This commit's message says a negative optlen is answered as 4
  'for every option', and its new comment says 'take it as 4 everywhere'.
- [Low] The commit fixes old behaviour where do_ipv6_getsockopt() treated
  a negative optlen as a huge buffer: IPV6_2292PKTOPTIONS wrote control…

--

ipv6: treat a negative optlen as 4 in do_ipv6_getsockopt()

This patch makes do_ipv6_getsockopt() treat a negative optlen as 4. The
int options already behaved this way through their unsigned min_t()
clamp. Sticky headers and the IPV6_2292PKTOPTIONS control buffer are now
cut to 4 bytes, and IPV6_PATHMTU and IPV6_FLOWLABEL_MGR now fail with
-EINVAL, as preparation for the sockopt_t conversion.

> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

[Severity: Low]
The commit message describes old behaviour that this patch fixes:

- IPV6_2292PKTOPTIONS writes control messages without a limit.
- IPV6_PATHMTU and IPV6_FLOWLABEL_MGR pass their size checks.
- Sticky headers are copied in full.

There is no Fixes: tag or stable guidance, though. Should one be added,
or a note saying this is not meant for stable?

The code involved predates git (1da177e4c3f4). The old behaviour only
wrote to buffers that userspace supplied. This patch also changes results
that userspace can see. For example, IPV6_PATHMTU with a negative optlen
now returns -EINVAL.

Another patch in this series, "net: cap sockopt_expand_out() at
MAX_RW_COUNT", does carry a Fixes: tag.

> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 4b3536571c980..4091d1521cc09 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -1002,6 +1002,11 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
>  
>  	if (copy_from_sockptr(&len, optlen, sizeof(int)))
>  		return -EFAULT;
> +	/* Historic bug compatibility: the int options have always taken a
> +	 * negative optlen as 4, so take it as 4 everywhere.
> +	 */
> +	if (len < 0)
> +		len = 4;

[Severity: Low]
Is "take it as 4 everywhere" accurate at this commit? The commit message
also says a negative optlen is answered as 4 "for every option".

The mroute dispatch at the top of do_ipv6_getsockopt() returns before
the new clamp runs:

net/ipv6/ipv6_sockglue.c:do_ipv6_getsockopt() {
    ...
	if (ip6_mroute_opt(optname))
		return ip6_mroute_getsockopt(sk, optname, optval, optlen);
    ...
}

ip6_mroute_getsockopt() then reads optlen again and rejects a negative
value:

net/ipv6/ip6mr.c:ip6_mroute_getsockopt() {
    ...
	olr = min_t(int, olr, sizeof(int));
	if (olr < 0)
		return -EINVAL;
    ...
}

So on a raw ICMPv6 socket, MRT6_VERSION, MRT6_PIM and MRT6_ASSERT still
fail with len = -1, even though they are int options. IPV6_TCLASS
answers 4 bytes in the same case.

This also seems to contradict the part of the comment that says "the int
options have always taken a negative optlen as 4". The MRT6_* int options
have always returned -EINVAL.

The clamp also only changes the local len. When do_ipv6_getsockopt()
returns -ENOPROTOOPT, ipv6_getsockopt() reads the raw optlen again before
it calls nf_getsockopt():

net/ipv6/ipv6_sockglue.c:ipv6_getsockopt() {
    ...
		if (get_user(len, optlen))
			return -EFAULT;

		err = nf_getsockopt(sk, PF_INET6, optname, optval, &len);
    ...
}

The ip6_tables and conntrack handlers reached from there seem to reject a
negative length themselves. So this looks like a mismatch in wording, not
a functional problem.

A later patch in this series, "ipv6: convert do_ipv6_getsockopt() to
sockopt_t", moves the clamp into ipv6_getsockopt(). There it runs before
both the mroute dispatch and the netfilter fallback, which closes the gap.

Could the comment and commit message here be changed to describe what
this commit actually does?

>  	switch (optname) {
>  	case MCAST_MSFILTER:
>  		if (in_compat_syscall())

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb%40debian.org
