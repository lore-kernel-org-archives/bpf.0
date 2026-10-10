Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A730CD95;
	Sat, 10 Oct 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791654596; cv=none; b=Mcezb5UyRbcXgkn1d5yHqOEOwjBvqpKEboqfjtECzu6cqzgAyBbd27+Ai1qEWupY2q9dPhFcB5eHjqB3m/phSjr30c71D24pXo6ShtxO51dAWWnkuFsOpn4eZYQuT/pXzdDQzhfNFDiqaiVhyEmgEi5QG9TQWCvvEr+orqPtaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791654596; c=relaxed/simple;
	bh=fs5k0pvJgDbTNkExW0JBTz50XVWD538Gkz2Y2kHhfiw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzI/eSj9rwplSHzCjaquXI8T6rbGbn4aCvkpLwsfY33EqIBDv51ss3J5qWQJ69SgMz/SY2cft4IO92PkYsWfizt5yow45gYGxfnIEr8hOhu6aEDYkRHMJ/b7l9fwOZa4qBxBLYiHcwR6YQXDAOyQ//v1y9m9EyNM/d42cm8aTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLZfYyLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLZfYyLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A41B1F000FF;
	Sat, 10 Oct 2026 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791654594;
	bh=+DORvwKAxTHj8vZPkv/MgjfYqRNJlJ7MuPcIfWOckwc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oLZfYyLs+ZNVBIFSYnpTqz36DZDNQcouBC7H3gCXi4j3bhSbHWPE81cJ3hxr3paSw
	 21550auM/hVG8XB1HfYEbAy3TswTQIgxC44c+uKmRNYw51JSrGcJCzvhRHsyarI2Os
	 Ww+kh/7rJQYqrG7grn4qJ726tGIOF8B+dMwrgtHNcLTj8ZSKUnnzCq+F/yUxCdDMqD
	 5p9i2aQL3gUjMV7yhKzloyB4q04pyAII8tfWLQIldMJQUtO9aCrBIDlNQEPWTlBDf1
	 NjlUuzG0J1rAhg6pP0/oDYBIE2T868ZoqQjWq7QfC5QPqeW3sPkIITFUbNkzNyd+pp
	 CBR8ONcA/1Gfg==
Subject: Re: [PATCH net 2/2] selftests: net: veth: test peer ndo-xmit after
 GRO toggle while down
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Date: Sat, 10 Oct 2026 17:49:52 +0000
Message-ID: <179165459278.434549.1711113374323842550@kernel.org>
In-Reply-To: <20261006173241.65945-3-tianyi@cloudflare.com>
References: <20261006173241.65945-3-tianyi@cloudflare.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new ndo-xmit checks in tools/testing/selftests/net/veth.sh
  are only skipped when cli.py is missing.
- [Medium] The new `if [ -f "$YNL" ]` block (veth.sh lines 320-331) is
  inserted between the 'with gro enabled on link down' setup and the…

--

selftests: net: veth: test peer ndo-xmit after GRO toggle while down

This adds chk_xdp_feature() to veth.sh. It reads xdp-features through the
ynl CLI and checks that toggling GRO on a veth device while it is down
updates the peer's ndo-xmit XDP feature once the device comes up. The new
checks are skipped when cli.py is not found.

> diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
> index 9709dd067c728..8b867e0675a7c 100755
> --- a/tools/testing/selftests/net/veth.sh
> +++ b/tools/testing/selftests/net/veth.sh

[ ... ]

> @@ -74,6 +76,37 @@ chk_tso_flag() {
>  	__chk_flag "$1" $2 $3 tcp-segmentation-offload
>  }
>  
> +chk_xdp_feature() {

[ ... ]

> +	ifindex=`ip netns exec $BASE$target cat /sys/class/net/veth$target/ifindex`
> +	out=`ip netns exec $BASE$target "$YNL" --family netdev --do dev-get \
> +		--output-json --json "{\"ifindex\": $ifindex}" 2>&1`
> +	st=$?
> +
> +	printf "%-60s" "$msg"
> +	if [ $st -ne 0 ]; then
> +		echo " fail - ynl cli error: $out"
> +		ret=1
> +		return
> +	fi

[Severity: Medium]
If cli.py is present but can't run, should that be a skip instead of a
failure?

The only checks on the environment just test whether the file exists:

    [ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit tests will be skipped"
    ...
    if [ -f "$YNL" ]; then

The CLI's library always imports PyYAML, in
tools/net/ynl/pyynl/lib/nlspec.py:

    import yaml as pyyaml

The CLI also has to find the netdev spec through specdir.find_spec(). That
raises FileNotFoundError if the spec directory is missing.

Suppose veth.sh runs from a kernel source tree on a host that has no
python3-yaml, no python3, or no spec directory. Each chk_xdp_feature() call
then exits non-zero, prints "fail - ynl cli error" and sets ret=1. Before
this patch, veth.sh needed only iproute2 and ethtool and passed on such a
host.

The commit message says the checks are skipped "if the CLI is not found".
The code does that. Could the script also do a trial run of the CLI before
it enables the ndo-xmit checks, and skip them if that run fails?

[ ... ]

> @@ -283,6 +317,18 @@ chk_gro_flag "        - peer gro flag" $SRC off
>  chk_tso_flag "        - tso flag" $SRC on
>  chk_tso_flag "        - peer tso flag" $DST on
>  ip -n $NS_DST link set dev veth$DST up
> +if [ -f "$YNL" ]; then
> +	chk_xdp_feature "        - peer ndo-xmit" $SRC 1 ndo-xmit
> +	# make sure the peer flag is set before disabling gro while down
> +	ip netns exec $NS_DST ethtool -K veth$DST gro off
> +	ip netns exec $NS_DST ethtool -K veth$DST gro on
> +	chk_xdp_feature "        - peer ndo-xmit re-armed" $SRC 1 ndo-xmit
> +	ip -n $NS_DST link set dev veth$DST down
> +	ip netns exec $NS_DST ethtool -K veth$DST gro off
> +	ip -n $NS_DST link set dev veth$DST up
> +	chk_xdp_feature "        - peer ndo-xmit cleared" $SRC 0 ndo-xmit
> +	ip netns exec $NS_DST ethtool -K veth$DST gro on
> +fi
>  ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
>  ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
>  chk_gro "        - aggregation with TSO off" 1

[Severity: Medium]
Does this block change which code path the chk_gro "aggregation with TSO
off" check below it tests?

Before this patch, the "with gro enabled on link down" section ran link
down, gro on, link up, and then chk_gro. veth_set_features() returns early
when the device is down:

drivers/net/veth.c:veth_set_features() {
    ...
	if (!(changed & NETIF_F_GRO) || !(dev->flags & IFF_UP) || priv->_xdp_prog)
		return 0;
    ...
}

So GRO NAPI was enabled only by veth_open():

drivers/net/veth.c:veth_open() {
    ...
	} else if (veth_gro_requested(dev)) {
		err = veth_napi_enable(dev);
    ...
}

When cli.py exists, the new block ends with link down, gro off, link up.
veth_open() enables no NAPI there. The block then runs ethtool -K veth$DST
gro on while the device is up, so NAPI is enabled in veth_set_features()
instead:

drivers/net/veth.c:veth_set_features() {
    ...
	if (features & NETIF_F_GRO) {
		err = veth_napi_enable(dev);
    ...
}

The final chk_gro now tests the "GRO enabled while up" path, which the
earlier "with gro on" section already covers. The GRO NAPI path in
veth_open() is no longer covered by any aggregation check. Which path is
tested also depends on whether cli.py exists.

The ndo-xmit checks don't fill this gap. veth_set_xdp_features() looks at
veth_gro_requested(), not at whether NAPI actually started.

Could the block end by restoring the down-state setup (link down, gro on,
link up) instead of turning GRO on while the device is up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006173241.65945-1-tianyi%40cloudflare.com
