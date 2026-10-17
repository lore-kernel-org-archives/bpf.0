Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459B13B293;
	Sat, 17 Oct 2026 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206367; cv=none; b=J6GHiIcjagKXuTs7YrbbsHsB3pPUpWHlJhQX2LCk4b1eOmBnbIlsSv+IzKrbXv/KyJFHbcpctdi9matgHlg9qJCxJcoPWxxpYx/T08+/bWRrCTA4rnaQMKOMs9iUJ6/q7r0fIey4jZ6Wz45K1RpvGvFuylkDGgphZa/4qbChXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206367; c=relaxed/simple;
	bh=TxsrQoeReuVkkJcppcYZgfKFM9i+zHch/GwTbDaqao0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlzcTTtAiJ8T6MtaWjQDMHBqqycDY2UUqpHM3W1A53dpqiRdqqxth67jnPnba5yO28+sq+d5uUmtrSTnGQzeZLN+pjfuY0eZSP2YCiwdxGm5vtFxBAmZYGNiuA8Oh6K+YobXfP9b9cvmHLq6ulzI4fmZlM26vnsOaUm5yuiUlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5UAUUCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5UAUUCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826E51F000C5;
	Sat, 17 Oct 2026 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206366;
	bh=QiNpr66aF8Jt67mP0DHy47o/5RmozCu5BZxGXMVE/fM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S5UAUUCWFv52Bsf5xD9FJeNkgo/GRdraPw89vUcgXL1BNbBlmTu9dnvLYYVWK28uy
	 sA2Q5ydPFAyR+A9AWngFKezoINX+Y491QcX5cA7/zH2t5Wp7Zy1lqWgt9h0fxwL5/1
	 3eJuR4FKb8etVmXz31LhW5PdOvnbScEq/DEsl3IdAc/HLSgEVrkIFgkEmZAZ7Oj/Qj
	 2cneDR8OKyFezDhbpLJh92WgF1qlTtMH/dOFUvDQfwIZ0pdq24ySekuFZ+KtZNs4+a
	 aDn8qYoTXOJJrjq9ltuAbwVJ54arOxEzt/1DkyuObqLEtjhTpHEfPZlRaID80SR0TH
	 ZDRWAWazGuwDQ==
Subject: Re: [PATCH v3 net-next 03/15] selftests: xsk: drop the
 single-interface loopback mode
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:05 +0000
Message-ID: <179220636510.434549.7705519903366245411@kernel.org>
In-Reply-To: <20261014184539.774708-4-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-4-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Old single-interface invocations are now misread instead of
  being rejected.

--

selftests: xsk: drop the single-interface loopback mode

This commit removes the xskxceiver mode where the TX and RX sockets were
bound to queue 0 of one interface with a shared UMEM. It also removes the
split UMEM addressing and the POLL_TXQ_FULL workaround that mode needed.
The -i IFACE option of test_xsk.sh is dropped as well.

> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 62db060298a4a..69fac65f073c5 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh

[ ... ]

> @@ -88,14 +85,11 @@
>  
>  . xsk_prereqs.sh
>  
> -ETH=""
> -
> -while getopts "vi:dm:lt:h" flag
> +while getopts "vdm:lt:h" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
>  		d) debug=1;;
> -		i) ETH=${OPTARG};;
>  		m) MODE=${OPTARG};;
>  		l) list=1;;
>  		t) TEST=${OPTARG};;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 7dad8556a722e..24109dd7264e2 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c

[ ... ]

> @@ -388,10 +387,6 @@ int main(int argc, char **argv)
>  		ksft_exit_xfail();
>  	}
>  
> -	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
> -	ifobj_tx->shared_umem = shared_netdev;
> -	ifobj_rx->shared_umem = shared_netdev;
> -
>  	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
>  		print_usage(argv);

[Severity: Medium]
Now that shared_netdev is gone, what rejects the old
"xskxceiver -i ethX -i ethX" invocation?

parse_command_line() still sets ifobj_tx and ifobj_rx from the first two
-i options. validate_interface() only rejects an empty name. As a result,
TX and RX can use the same ifindex and nothing reports it.

When that happens, each endpoint binds its own UMEM to queue 0 of the same
netdev, because xsk_configure() now does:

	bool shared = !!i;

The TX bind cannot succeed without XDP_SHARED_UMEM. xsk_configure()
retries SOCK_RECONF_CTR times, and then every test fails. Nothing tells
the user that the mode was removed.

xsk_attach_xdp_progs() has also lost its early return for a shared-netdev
TX side, so the TX attach replaces the RX program on the same ifindex.

Should main() exit with a usage error when
ifobj_tx->ifindex == ifobj_rx->ifindex?

test_xsk.sh has a related problem. 'i' is no longer in the getopts string,
and the case statement has no '?' arm. Running "test_xsk.sh -i ethX"
prints an illegal option warning and then runs the veth suite, which could
be mistaken for a hardware result.

Later patches in this series look like they resolve this:

- "selftests: xsk: run one test case per xskxceiver invocation" removes
  test_xsk.sh and xsk_prereqs.sh in favour of test_xsk.py.

- "selftests: xsk: run the RX and TX endpoints in separate processes"
  makes parse_command_line() take a single interface. It calls
  print_usage() when the role, peer host, peer port, test or mode is
  missing.

So the problem seems limited to this commit, for example while bisecting.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
