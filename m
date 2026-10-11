Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229039CCFF;
	Sun, 11 Oct 2026 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717428; cv=none; b=Yo5iwhgTijPHsF7xco0xkD7cXDEclIK0vIMF56JilWRpvELacmdYzdMcHFsuhhJjMiXw8Rsk4L8zo5cgk+WN2rpQgb2znNMqyMlmwMjZ8DgT1t8IPWioefy3KsCfSxiRaxq4F1BV7umObqaNEE96GthXVlSfJd42NWWqNW+cj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717428; c=relaxed/simple;
	bh=4v9z5HmnM7iUnerDJ7YE4yHib/ejht6oQCyqiLzW1ac=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rf6T3OQq6KeDQZE+w206t5mNDPH5b0XGTgqc3gr130mAb1fAIMYZ8GFGzuLA5bN9CWZbhgAsBSz4XVRvpSombealn3U0ROtz3K9eJQd6TkP/VcgZrZ6hJtnesfcDZWRCjVjBjCXBBQtKZgR1YoTkGx44NwczokCC/746jti1dv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiosPhRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiosPhRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C9E1F0089C;
	Sun, 11 Oct 2026 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717426;
	bh=11Zj8U4rxaT/dW6f69pP5q0G42vYOskLttRoqxcbNFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZiosPhRLp8i0YUt/vQiWdPiTLJGjOLYYYzQMwaQOQZLdQg00jcaQi+0bEmlc6SshE
	 ciuV7sIu4DUQqHFgWSOEA95vfX4xU/9EUxUFYI4LYQZi0pNf2g0j3cqAnsJHfw0mcq
	 ceZx004ySRoEigMOErBUrsS6F2zgGHNN4AQ6RoAllw1+OEjSLz3/7L1m+wZ9DA0oLC
	 Bs2Jrc9tyRi9skRnK6cDEODzpc+0J2r1pDmEveyLErXbWPjuBh3fDDTnPck9usp72o
	 LO8fjEPdxq3cDuU13TsUgsebRRk8CpSaMspeLVJCZfqfI26Xmo5laQqI7eG69t3tGR
	 CmCC8HQr1rFbw==
Subject: Re: [PATCH net-next v5 2/5] selftests/bpf: Track XDP test processes
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
Date: Sun, 11 Oct 2026 11:17:04 +0000
Message-ID: <179171742478.434549.466406225427825587@kernel.org>
In-Reply-To: <20261010-xdp-v5-send-20261008-v5-2-de687cb67c40@gmail.com>
References: <20261010-xdp-v5-send-20261008-v5-2-de687cb67c40@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] cleanup() runs `trap - EXIT` (line 61) before `trap '' HUP INT
  QUIT ABRT TERM` (line 62).
- [Medium] The liveness check in wait_for_dut_server() uses `jobs -pr
  %%`.
- [Low] cleanup() deletes a namespace only if peer_created or dut_created
  is true, and each flag is set only after its `ip netns add` returns 0.

Pre-existing issues:
- [Medium] test_xdp_features.sh decides pass or fail only from the
  tester's exit status.
- [Low] Each xdp_features process attaches global tp_btf/xdp_exception
  and tp_btf/xdp_cpumap_kthread programs.

--

selftests/bpf: Track XDP test processes and isolate namespaces

This patch reworks test_xdp_features.sh so the DUT xdp_features server
runs as a tracked shell job in its own network namespace, separate from
the tester's namespace. The pidof based kill in cleanup() is replaced by
job based termination. EXIT and signal traps are added, and signals that
arrive during setup are deferred.

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c05..7b96222b690a6 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh
> @@ -2,105 +2,173 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  readonly NS="ns1-$(mktemp -u XXXXXX)"
> +readonly DUT_NS="dut-${NS}"

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. The
per-run namespaces don't isolate the tracepoint programs that each
xdp_features instance attaches. In
tools/testing/selftests/bpf/progs/xdp_features.c:

SEC("tp_btf/xdp_exception")
int BPF_PROG(xdp_exception, const struct net_device *dev,
	     const struct bpf_prog *xdp, __u32 act)
{
	...
	val = bpf_map_lookup_elem(&dut_stats, &key);
	if (val)
		__sync_add_and_fetch(val, 1);
	...
}

tp_xdp_cpumap_kthread does the same. Neither handler filters by ifindex
or netns. Any XDP exception or cpumap kthread event on the system
therefore increments this instance's dut_stats.

With concurrent runs or other XDP users on the host, can
tester_collect_detected_cap() print the wrong DETECTED or NOT DETECTED
result for a given run? The script's pass/fail doesn't change, because
tester_run() returns err < 0 ? err : 0 whatever detected_cap is.

[ ... ]

>  setup() {
>  	{
> -		ip netns add ${NS}
> +		ip netns add "${NS}"
> +		peer_created=true
> +		ip netns add "${DUT_NS}"
> +		dut_created=true

[Severity: Low]
What happens if a group-directed signal, such as Ctrl-C, kills
ip netns add after it has created and bind-mounted
/var/run/netns/<name> but before it returns?

set -e would exit setup() with peer_created or dut_created still false.
The EXIT trap would then skip the matching delete in cleanup():

	if "$dut_created"; then
		ip netns del "$DUT_NS" 2> /dev/null || true
	fi

Does this leak an empty namespace? The old cleanup() deleted ${NS}
unconditionally.

A later commit in this series, "selftests/net: Move the XDP feature test
to drivers/net/hw", deletes test_xdp_features.sh, so this code is gone by
the end of the series.

[ ... ]

>  cleanup() {
> -	ip link del v1 2> /dev/null
> -	ip netns del ${NS} 2> /dev/null
> -	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
> +	trap - EXIT
> +	trap '' HUP INT QUIT ABRT TERM
> +	terminate_dut_server
> +	if "$dut_created"; then
> +		ip netns del "$DUT_NS" 2> /dev/null || true
> +	fi
> +	if "$peer_created"; then
> +		ip netns del "$NS" 2> /dev/null || true
> +	fi
>  }

[Severity: Medium]
Can a trapped signal still cut this cleanup short? trap - EXIT runs
before the HUP/INT/QUIT/ABRT/TERM traps are set to '', and once setup has
finished handle_signal() always exits:

handle_signal() {
	if "$setup_in_progress"; then
		pending_signal=$1
	else
		exit "$1"
	fi
}

Suppose a signal is already pending when cleanup() is entered from the
EXIT trap. For example, a harness sends INT and then TERM while the shell
waits on the foreground tester. A signal could also arrive just after
set -e starts the exit. Either way, handle_signal() runs exit from inside
the EXIT trap.

Bash then exits at once, and terminate_dut_server and both ip netns del
calls never run. Would that leak the DUT xdp_features process and both
namespaces?

A later commit in this series, "selftests/net: Move the XDP feature test
to drivers/net/hw", deletes test_xdp_features.sh, so this is not in the
final state of the series.

>  wait_for_dut_server() {
> -	while sleep 1; do
> -		ss -tlp | grep -q xdp_features
> -		[ $? -eq 0 ] && break
> +	while true; do
> +		if [ "$(jobs -pr %% 2> /dev/null)" != "$dut_pid" ]; then
> +			echo "xdp_features server $dut_pid exited before readiness" >&2
> +			return 1
> +		fi

[Severity: Medium]
Does this check notice a DUT that has already exited? In bash, the -r
state filter of jobs only applies when no jobspec is given. With an
explicit %% jobspec, bash prints the job's PID whatever its state.

The jobs call also runs in a command substitution subshell. The parent
shell never reports or reaps the finished job, so %% keeps resolving to
it.

Suppose xdp_features exits normally before it starts listening, for
example because xdp_features__load() or xdp_features__attach() fails in
main(). This test then keeps comparing $dut_pid with itself and never
fires. ss never finds a socket with pid=$dut_pid, so the loop sleeps
forever.

Would the selftest then hang until an external timeout? That would not
match this part of the commit message:

  Wait for readiness while the DUT is alive.

The later commit "selftests/net: Move the XDP feature test to
drivers/net/hw" deletes this script. The replacement xdp_features.py uses
bkg(dut_cmd, exit_wait=True, ksft_ready=True) instead.

> +
> +		if ip netns exec "$DUT_NS" ss -tlp 2> /dev/null |
> +		   grep -q "pid=$dut_pid,"; then
> +			return 0
> +		fi
> +
> +		sleep 1
>  	done
>  }

[ ... ]

>  test_xdp_features() {
>  	setup
>  
>  	## XDP_PASS
> -	./xdp_features -f XDP_PASS -D $V1_IP6 -T $V0_IP6 v1 &
> -	wait_for_dut_server
> +	start_dut_server -f XDP_PASS -D $V1_IP6 -T $V0_IP6 v1
>  	ip netns exec ${NS} ./xdp_features -t -f XDP_PASS \
>  					   -D $V1_IP6 -C $V1_IP6 \
>  					   -T $V0_IP6 v0
>  	[ $? -ne 0 ] && exit

[Severity: Medium]
This isn't a bug introduced by this patch, but the script only checks
the tester's exit status. tester_run() in
tools/testing/selftests/bpf/xdp_features.c computes detected_cap and the
advertised state and prints them. It then returns:

out:
	bpf_xdp_detach(env.ifindex, flags, NULL);
	close(sockfd);
	return err < 0 ? err : 0;

So the selftest can pass even when every action is NOT DETECTED, or when
detection doesn't match what the driver advertises.

The later commit "selftests/net: Move the XDP feature test to
drivers/net/hw" fixes this. It replaces the script with
drivers/net/hw/xdp_features.py, which checks
ksft_eq(detected, advertised, ...).

> +	reap_dut_server

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-xdp-v5-send-20261008-v5-0-de687cb67c40%40gmail.com
