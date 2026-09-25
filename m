Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28E2F30;
	Fri, 25 Sep 2026 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294533; cv=none; b=kcvLEJ2sgfT+lPt3gD+jhH7uvkstDrl9aSScvs4PB6UfvxpSr82DPiNofek6EiFGZubAMXEQIBsTqJCITtjBFyy8DWPrSE2ZpQB/EPuJcoFZIZNckFyg71tQIwBsaG0h2+VnmYzzDxoggfIqRlO4fw7+VKCYT9g6cGm8S6Bz85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294533; c=relaxed/simple;
	bh=M0qqUhExflkBpJdQXFREW4nc8VekqNfpY/O8LodQ24Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GosoUfqyQqY/MzjlqCg7tPDdpGRDcbLSddvEvc+17hUQPt1EMZqVQKCNmCsc9hh9cFlGrOiiuDWq6FuB8sS1PI3cUM29+HmxGQDYTbHh3Ia+PXPW+sdoYh9Qj+eHsi4UPSlXeD673t7P/UdsDParbEQu2AuJM3oUOat5SghfqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZLwBTiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZLwBTiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA181F000FF;
	Fri, 25 Sep 2026 00:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790294531;
	bh=+n+g/iryFmlJRzPkc8R8xL++KcDJ3FmwydzBcRCRH5k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MZLwBTiYFNeQvwU4HHYggPa17e6xZ3/srx9TwQW79alxJyb0uP38yvC/RuhQnDaPz
	 wld+W0D0EpfrKB22mKp4I6GhoKmokpeN8QD6o/qE+hQVosllJQuR3q64+NC/ltcLD9
	 UGq0PH8JGCkTOHxnVUs9aMsfFgvhgEmKna6bmBkLmKSVqrNVSrllHwphRXTmWqai6u
	 pBJqV14NGORtl7RAcXod/DPJ7ByZE+pTIx6QVLtV7RMlwJbhm8S5nU+hBk4bDnsKBY
	 cpMPJWOoIWHTy/XAJjXoUtKAyprAKw/Zs2cIZwLhBf8ub7e7txqKfi2R64axuNXCUF
	 PYVX6MMoeDYXw==
Subject: Re: [PATCH net-next v4 1/2] selftests/bpf: Track test_xdp_features
 DUT processes
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 00:02:09 +0000
Message-ID: <179029452919.2160803.5159362643144415417@kernel.org>
In-Reply-To: <20260921-xdp-features-v4-send-v4-1-a0d4ec392cb7@gmail.com>
References: <20260921-xdp-features-v4-send-v4-1-a0d4ec392cb7@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `wait_for_dut_server()` replaces the previously unbounded
  readiness wait with at most 10 one-second polls and turns a timeout…
- [Medium] `cleanup()` unconditionally runs `ip link del v1` and, via the
  newly added `trap cleanup EXIT`, is now reachable on every exit path…
- [Low] Missing `Fixes:` tag.
- [Low] The signal traps stay armed while the EXIT trap (`cleanup`)
  executes.

Pre-existing issues:
- [Medium] The shell selftest reports success even when the detected XDP
  capability disagrees with the capability advertised by the driver:…

--

selftests/bpf: Track test_xdp_features DUT processes

This reworks test_xdp_features.sh so the device-under-test xdp_features
server is tracked by pid and job spec instead of being matched by name with
pidof, replaces the readiness poll loop with a bounded retry loop, and moves
teardown to an EXIT trap plus explicit signal traps.

A few questions on the new shell logic below.

> selftests/bpf: Track test_xdp_features DUT processes
>
> Track the DUT process instead of matching processes by name to avoid
> interference between concurrent tests. Fix readiness retries under
> set -e and clean up the DUT and network state on exit or interruption.
>
> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>

[Severity: Low]
Should this carry a Fixes: tag?  Both defects repaired here came in with
the original script.

In the baseline, wait_for_dut_server() ran the failing command in the body
of the loop:

	while sleep 1; do
		ss -tlp | grep -q xdp_features
		[ $? -eq 0 ] && break
	done

errexit exempts only the loop condition, so with set -e a DUT that is not
yet listening after one second aborted the script instead of retrying.

Also, trap cleanup 2 3 6 9 never trapped EXIT (and signal 9 cannot be
trapped), while cleanup was only reached at the end of a fully successful
run, so every [ $? -ne 0 ] && exit path left the netns, the v1 veth and a
live xdp_features process behind, and the leftover v1 then makes the next
run's ip link add v1 fail.

git blame attributes both constructs to 4dba3e7852b7 ("selftests/bpf:
introduce XDP compliance test tool"), so a
Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool")
trailer would let this be selected for the affected history.

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c0..a78e0fb9ed63 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh

[ ... ]

> @@ -30,77 +31,124 @@ setup() {
>  	} > /dev/null 2>&1
>  }
>  
> +terminate_dut_server() {
> +	local pid
> +
> +	# Use the shell job instead of dut_pid, which may not have been assigned
> +	# yet if a signal arrived immediately after the server was started.
> +	pid=$(jobs -pr %% 2> /dev/null) || true
> +	if [ -z "$pid" ]; then
> +		dut_pid=""
> +		return
> +	fi
> +
> +	kill -KILL %% 2> /dev/null || true
> +	wait "$pid" 2> /dev/null || true
> +	dut_pid=""
> +}
> +
>  cleanup() {
> -	ip link del v1 2> /dev/null
> -	ip netns del ${NS} 2> /dev/null
> -	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
> +	terminate_dut_server
> +	ip link del v1 2> /dev/null || true
> +	ip netns del "${NS}" 2> /dev/null || true
>  }

[Severity: Medium]
Can this cleanup() tear down a veth pair that belongs to a different
instance of the script?

The host side name in setup() is fixed:

	ip link add v1 type veth peer name v0 netns ${NS}

If instance A is mid-test and instance B starts, B's ip link add v1 fails
because the name is taken.  With set -e that exits B, which now fires the
newly added trap cleanup EXIT and runs:

	ip link del v1 2> /dev/null || true

deleting A's interface while A is still using it.  The baseline never ran
cleanup on that path, since the old trap covered only signals 2/3/6/9.

Since the commit message gives "avoid interference between concurrent
tests" as the motivation, should teardown only remove interfaces this
invocation actually created, and should the veth name (and the fixed DUT
control/echo ports) become per-invocation like ${NS} already is?

Note the follow-on patch "selftests/net: Move XDP feature test to driver
framework" deletes this script and moves the test to the NetDrvEpEnv
framework, which does not create a fixed v1 veth, so this may only matter
for the intermediate state of the series.

>  
>  wait_for_dut_server() {
> -	while sleep 1; do
> -		ss -tlp | grep -q xdp_features
> -		[ $? -eq 0 ] && break
> +	local i
> +
> +	for ((i = 0; i < 10; i++)); do
> +		if [ "$(jobs -pr %% 2> /dev/null)" != "$dut_pid" ]; then
> +			echo "xdp_features server $dut_pid exited before accepting connections" >&2
> +			return 1
> +		fi
> +
> +		if ss -tlp 2> /dev/null | grep -q "pid=$dut_pid,"; then
> +			return 0
> +		fi
> +
> +		sleep 1
>  	done
> +
> +	echo "Timed out waiting for xdp_features server $dut_pid" >&2
> +	return 1
> +}
> +
> +start_dut_server() {
> +	./xdp_features "$@" &
> +	dut_pid=$!
> +	wait_for_dut_server
> +}

[Severity: Medium]
Is a ten second budget enough here, and should exceeding it kill the whole
run?

wait_for_dut_server() is the last command of start_dut_server(), so its
return 1 becomes that function's status, and with set -e in effect the
script terminates at the first feature case, skipping XDP_DROP,
XDP_ABORTED, XDP_TX, XDP_REDIRECT and XDP_NDO_XMIT.

The loop also sleeps after its last observation (check at i=9, then
sleep 1, then return 1), so readiness is only sampled over roughly the
first nine seconds and the tenth second is dead time.  The DUT only reaches
listen() after xdp_features__open()/__load() has verified all the XDP
programs, which on KASAN/lockdep kernels or a busy CI host can take longer
than that.

The changelog mentions only "Fix readiness retries under set -e", with no
mention of the new deadline.  Could the retry budget be documented in the
changelog, and could a timeout fail just the current case rather than the
whole script?

The later patch "selftests/net: Move XDP feature test to driver framework"
removes this loop in favour of the framework's
bkg(..., ksft_ready=True) handshake, so this too is limited to the
intermediate state of the series.

[ ... ]

>  	## XDP_NDO_XMIT
> -	./xdp_features -f XDP_NDO_XMIT -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
> -	wait_for_dut_server
> +	start_dut_server -f XDP_NDO_XMIT -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1
>  	ip netns exec ${NS} ./xdp_features -t -f XDP_NDO_XMIT \
>  					   -D ::ffff:$V1_IP4 \
>  					   -C ::ffff:$V1_IP4 \
>  					   -T ::ffff:$V0_IP4 v0
>  	ret=$?
> -	cleanup
> +	reap_dut_server
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but while the result handling is
being reshuffled: does this script ever notice a mismatch between the
detected and the advertised XDP capability?

Every case in test_xdp_features(), including this last one, derives its
result purely from the exit status of the tester process.  In
tester_run() in xdp_features.c the two values only reach stdout:

	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(),
		detected_cap ? GREEN("DETECTED") : RED("NOT DETECTED"),
		env.feature.drv_feature & advertised_feature ? ...

detected_cap and advertised_feature are never compared and never influence
the returned status, so a driver that advertises a feature it does not
implement still passes.

The follow-on patch "selftests/net: Move XDP feature test to driver
framework" closes this by adding xdp_features.py with
ksft_eq(detected, advertised, ...), so at the end of the series the gap is
gone.

>  
>  set -e
> -trap cleanup 2 3 6 9
> +trap cleanup EXIT
> +trap 'exit 129' HUP
> +trap 'exit 130' INT
> +trap 'exit 131' QUIT
> +trap 'exit 134' ABRT
> +trap 'exit 143' TERM

[Severity: Low]
Should cleanup() disarm the traps on entry, for example with
trap - EXIT HUP INT QUIT ABRT TERM?

The signal traps stay armed while the EXIT trap runs, and bash does not
block signals during a trap handler.  cleanup() starts with
terminate_dut_server(), which can block in wait "$pid", so a second
Ctrl-C or SIGTERM in that window dispatches the signal trap's exit and
bash terminates without resuming or re-entering the EXIT trap:

	cleanup() {
		terminate_dut_server      <-- second signal arrives here
		ip link del v1 ...        <-- never runs
		ip netns del "${NS}" ...  <-- never runs
	}

That leaves the v1 veth and the netns behind, which is the state the new
trap machinery is meant to avoid.

As with the other comments, the following patch deletes this script, so
this only applies to the intermediate state of the series.

>  
>  test_xdp_features
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7%40gmail.com
