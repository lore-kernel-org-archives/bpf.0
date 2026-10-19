Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421709;
	b=b4LkGYVvSsvx+SfANkO0I7+L9oa/sxz5EmKbhQu+Do1wBTDWBxC6XodULFGHrs8KOe04
	 RlrEOGxp+EJVDb/YRrRC6trcKMVM7i8vhM3zSghRwjoirEGBtE9I98FrqyJoS66ymPf47
	 BZEDGvuwrYcbvyDpo5EQItAG/XIhx4OuIJ9zASTMCqHVwP0LM9B3P0ouMdKcCVbvtM2vD
	 WSn6L2F5YvfnlaxssDT/KxS7m9qICUmVz9m5CuxTAaFDvPFctS58cODOdfnRi8iNlOHS/
	 zhMoMEDYYBsijSBDXiQ+BO4iUncxheazra7wI+qp8hPU+vngaJNOZ0xqthRh68/iScA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421709;
	h=Received:Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+JUxYD7hsy9+873bVBb64U1eteVVDuAvUhFWgvJelD4=;
	b=FrAWDstoOvfmlccm1mGNB/6jzN2JKvgtNANldHNtFYsrpMWwZ9SSwo7mujIMtb73vR3d
	 Cdhy0fs3pGE9K/ucT3lf1W8isKEUeMWjQjRqIzaGa0nhapfnhtbeqI7g3xVc8VGXh/Hop
	 0sVaaex3RbQgiiw0ns3AFYo4JYXX3e/opm6Jo1OrVyFtuZmcUTWQp7if3zjWsDqo5WbJc
	 LYHl2zlKtw5WbbBO8Unwl9OlUqcl7NuXGKZ/OkZrNlU+BjdJitzo6RXsZukyBtMhXhmc4
	 TXoLs564xQc81pfvVwQHst6WoQUpe1WpWUcxLOoK7y3Skrc3rRk78tgn5Z29mDhrPOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpoWiUhv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E5606EFE9;
	Mon, 19 Oct 2026 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpoWiUhv
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC36513FF;
	Mon, 19 Oct 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421709; cv=none; b=Kx5/sJm6PI9j5E86xXnZIrs+5rYpV6nQbp7hVgKoXvjcn2yieSY6aJx6d82tlKrAfQQmBhe+Jv7MlRpQeIhZiel27RQASaX/2rDovckt5uHP+WQCZyAPZPKHwR+A7an8ZpUyannl5/k0US1/eYymqjRMeGLuBKuc0+T1td1s13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421709; c=relaxed/simple;
	bh=rypUYqt1WxoN40+ku5yahBFpXbOcWjQofkx/7yag5k8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RDhSZ+olmgcyrHGvJ2BbJTtY8eU9BKdNjs+RPfq2ptHG0sDuBY+FVCeuj23dlD4SmGq4fYxNuOhoxgK4nV/xAWDrx39XL/guT3SW4twlmBaFcqSDcv1vA/y0xINjP289ut/KCzhPnzm1bc1feM22uZAqsJpTVYcABKMoAH0GWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpoWiUhv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA241F000C5;
	Mon, 19 Oct 2026 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421707;
	bh=+JUxYD7hsy9+873bVBb64U1eteVVDuAvUhFWgvJelD4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TpoWiUhvlPWuiOAzwQ0+QYp1daD5dXruX/kR2AJHRWNdqmgRTyUwwWwa+sRV+2IrL
	 qdMOqQJf/VKImZ2CmKFbRDxbSpf1mueNlPbW0S0A4JWDzEuu6gIvPdPBwXxAiMJvcS
	 kiA6C8l9qYU76zsFXaLHbH28Rj+nDJXA4kqFjor8LjGmFwpPZBE27OTiVgGPbAOI5p
	 XOmxC3hdmTfeaEkvfoOrttUR+AGgMExhSly0PcfHcVjOQtnPIWNfn9fJzru23dsa9V
	 yqYN4frfKF+YRddnsrOMbfO9x9lyfBw/xJeRQu/KIbKmkHA+4G6Jdjl82mfELlJCgx
	 smIVXBHc809cw==
Subject: Re: [PATCH net-next v6 2/5] selftests/bpf: Track XDP test processes
 and isolate namespaces
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Mon, 19 Oct 2026 14:55:05 +0000
Message-ID: <179242170518.3135.2037803545467217348@kernel.org>
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-2-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-2-7336e1282ca3@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern about a signal race in cleanup() and handle_signal() in
  tools/testing/selftests/bpf/test_xdp_features.sh.
- [Low] Concern about a check-then-create race (TOCTOU) on namespace
  ownership in setup() of…

--

selftests/bpf: Track XDP test processes and isolate namespaces

This commit reworks test_xdp_features.sh so each run gets its own DUT and
tester namespaces. The DUT server is tracked as a shell job with a bounded
readiness wait, and signals are handled during setup and cleanup. It also
filters the tracepoint counters by this run's program and CPU map IDs, and
makes the tester fail when detected and advertised features differ.

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c05..5b68b20d94ac9 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh
> @@ -2,105 +2,179 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  readonly NS="ns1-$(mktemp -u XXXXXX)"
> +readonly DUT_NS="dut-${NS}"

[ ... ]

>  setup() {
>  	{
> -		ip netns add ${NS}
> -
> -		ip link add v1 type veth peer name v0 netns ${NS}
> -
> -		ip link set v1 up
> -		ip addr add $V1_IP4/24 dev v1
> -		ip addr add $V1_IP6/64 nodad dev v1
> +		[ ! -e "/run/netns/${NS}" ]
> +		peer_created=true
> +		ip netns add "${NS}"
> +		[ ! -e "/run/netns/${DUT_NS}" ]
> +		dut_created=true
> +		ip netns add "${DUT_NS}"

[Severity: Low]
Can cleanup() end up deleting a namespace that belongs to a different run?

The existence check and the ip netns add are not atomic. The ownership
flag is also set before the create succeeds.

Suppose a concurrent run creates the same name after the [ ! -e ... ]
check but before ip netns add. The add fails and set -e exits. cleanup()
then sees peer_created=true (or dut_created=true):

cleanup() {
    ...
	if "$peer_created"; then
		ip netns del "$NS" 2> /dev/null || true
	fi
}

and deletes the other run's namespace.

This needs two runs to get the same suffix from mktemp -u XXXXXX and then
hit the window, so it is unlikely. Would setting peer_created and
dut_created only after each ip netns add succeeds close it?

The later patch in this series, "selftests/net: Move the XDP feature test
to drivers/net/hw", deletes test_xdp_features.sh entirely. So this only
affects the intermediate state of the series.

[ ... ]

>  cleanup() {
> -	ip link del v1 2> /dev/null
> -	ip netns del ${NS} 2> /dev/null
> -	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
> +	trap '' HUP INT QUIT ABRT TERM
> +	trap - EXIT
> +	terminate_dut_server
> +	if "$dut_created"; then
> +		ip netns del "$DUT_NS" 2> /dev/null || true
> +	fi
> +	if "$peer_created"; then
> +		ip netns del "$NS" 2> /dev/null || true
> +	fi
>  }

[Severity: Low]
Is there a window where a second signal can cut cleanup() short?

After the first HUP/INT/QUIT/ABRT/TERM, handle_signal() calls exit and
cleanup() starts as the EXIT trap. If a second signal arrives before the
trap '' HUP INT QUIT ABRT TERM line takes effect, handle_signal() still
runs:

handle_signal() {
	if "$setup_in_progress"; then
		pending_signal=$1
	else
		exit "$1"
	fi
}

That exit would then run from inside the EXIT trap. In that case,
terminate_dut_server() and both ip netns del calls would be skipped,
leaving the DUT xdp_features process and both namespaces behind.

The old script had no TERM or EXIT trap, so this is not worse than
before. The later patch "selftests/net: Move the XDP feature test to
drivers/net/hw" also removes this script.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3%40gmail.com
