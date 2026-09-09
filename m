Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D023859C3;
	Wed,  9 Sep 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939994; cv=none; b=EcSmRwEPLsT9P12BaTq9FYhYNp9EW3O2OdI/HB9X13MqellbkLsfJ6ReStbcH6s6NUg7bTsQfdMa7mErRlg/yc3pjRq4BjJsifmy58syf7baKP7Cx0Fai3lbpzeZnpgpeUiUns73/RFDjaU55R2YEvSW+M+g6xxnzI32+HoCYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939994; c=relaxed/simple;
	bh=yXMrT6IzEUhWBRPcUDnQRqXLpg95d8PdeoBh6GLSwvw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzKm59nixZVi3pm0p8cskghhfEyk8RK66bt9lC4pfcfDYA/V/yyYqYXReAiL2X7c65tuyVAKOxVVzkjj+ZnoG5RcJ+ZSg3AmwqZbXOpWi+6ACb/6rfcSdkMxb4hJ+Is58ppxXqNUZE2FBwKK0IYkuJHXLonPsyGAcg1wf/Gp+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF0qvh/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF0qvh/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA1A1F00A3A;
	Wed,  9 Sep 2026 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939992;
	bh=d7GagPEcixH3H5MMbvg8ksiBnC47o3JwyIOR1AMzKr0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RF0qvh/evHvX6JzdJI41FraeMCyq5G2qVA8W4tpKSdpG0HbMuQjaAfjIOUcK3hbar
	 kuVMz3lFyxAQ8RLc1IUIN+lI9QCOzC6Wajl0DV9+k3T+rK6kbWAwOQkXyngbvXl24N
	 FKo/UirZGLJyOFuXey9WzNOAamOLHAx+HxZtNcnlHrAXrcpqqfQjrvdT+N6C3/L1LE
	 RIzdudnvfLZhWrAGp0TpLJpEl/QShLkZh+Q4B3Thi4bf7ZuJJ/KZDt7eFMELnKRNoQ
	 dPmEJyL7FRRTCmr4q/8+A46NofdTYpzTkadEJJLJSQAg6bZT1rZJG7TIm8OAWl54+j
	 AXHx2D7YqyRig==
Subject:
 Re: [PATCH net-next v3] selftests/bpf: Track test_xdp_features DUT processes
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: daniel@iogearbox.net, kuba@kernel.org, alexis.lothore@bootlin.com,
 emil@etsalapatis.com, lorenzo@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Wed, 09 Sep 2026 07:46:31 +0000
Message-ID: <178893999152.219967.3747368704885781101@kernel.org>
In-Reply-To:
 <20260904-xdp-dut-process-lifecycle-gmail-v3-1-5b7eee4f7009@gmail.com>
References:
 <20260904-xdp-dut-process-lifecycle-gmail-v3-1-5b7eee4f7009@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

- [Medium] The commit message justifies part of the rewrite with a
  failure mode that cannot occur in the pre-patch script: "The readiness…
- [Medium] Signal coverage regression that contradicts the commit
  message.
- [Low] Trap race on partially published DUT state in start_dut_server()
  (tools/testing/selftests/bpf/test_xdp_features.sh, lines 72-76): the…

Pre-existing issues:
- [Medium] The selftest's pass/fail verdict cannot observe an XDP feature
  regression.

--

selftests/bpf: Track test_xdp_features DUT processes

This reworks test_xdp_features.sh so that the DUT xdp_features instance is
tracked by PID and shell job instead of by process name, waits for that
exact PID to appear in ss output with a bounded retry loop, and reaps it
after each subtest.  The old signal traps are replaced with an EXIT trap
plus HUP/INT/TERM handlers.

A few questions below.

> The readiness loop also has no timeout,
> so a DUT that exits before listening leaves the test hung indefinitely.

[Severity: Medium]
Is this description of the pre-patch behaviour accurate?  In the baseline
script, set -e is in effect before test_xdp_features is invoked, and the
readiness probe sits in the body of the while loop, not in its condition:

	wait_for_dut_server() {
		while sleep 1; do
			ss -tlp | grep -q xdp_features
			[ $? -eq 0 ] && break
		done
	}

Bash exempts only the command list immediately following the while or until
keyword from errexit, which here is sleep 1.  The grep -q in the loop body
is not exempt, so the first failing probe terminates the script with status
1.  Wouldn't that mean the loop can never reach a second iteration, and the
observable pre-patch symptom is a spurious failure about a second after the
DUT is started (plus a leaked netns and veth, since there was no EXIT trap),
rather than an indefinite hang?

Since the patch carries a Fixes: tag, could this sentence be reworded to
describe the failure mode that actually occurs?  The other two motivations
in the message, name-wide ss matching and pidof killing unrelated
xdp_features processes, do match the baseline code.

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c05..35ce0d4e24180 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh

[ ... ]

> @@ -30,77 +31,118 @@ setup() {
>  	} > /dev/null 2>&1
>  }
>  
> +terminate_dut_server() {
> +	[ -z "$dut_pid" ] && return
> +
> +	# Use the shell job instead of a PID which may have been reused.
> +	if [ "$(jobs -pr %% 2> /dev/null)" = "$dut_pid" ]; then
> +		kill -KILL %% 2> /dev/null || true
> +	fi
> +
> +	wait "$dut_pid" 2> /dev/null || true
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

[ ... ]

> +start_dut_server() {
> +	./xdp_features "$@" &
> +	dut_pid=$!
> +	wait_for_dut_server
> +}

[Severity: Low]
Can a trap serviced between these two commands orphan the DUT?  The child is
forked by the background command, but its identity becomes visible to the
cleanup path only when the separate assignment dut_pid=$! runs.  Bash runs
pending trap handlers at command boundaries.

A directed signal in that window, for example kill -TERM on the script pid,
which does not reach the async child, runs the new TERM handler and then the
EXIT trap:

	trap 'exit 143' TERM
	  -> trap cleanup EXIT
	     -> cleanup()
	        -> terminate_dut_server()

and terminate_dut_server() starts with:

	[ -z "$dut_pid" ] && return

dut_pid is still empty here, since it is initialised to "" at the top of the
script and cleared again by reap_dut_server() after each subtest, so the
just-forked xdp_features is never signalled.  cleanup() then continues into
ip link del v1 and ip netns del, leaving an xdp_features process behind with
its XDP program still attached and its device and netns removed underneath
it.  The removed pidof sweep used to cover this window.

Would signalling the job whenever jobs -pr reports one, rather than keying
off the variable assignment having completed, close this?

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
This isn't an issue introduced by this patch, but while the ret=$? contract
is being touched here, can this script actually observe an XDP feature
regression?  The script's verdict comes only from the tester exit status,
via ret=$? here and exit $ret at the end.

On the tester side, tester_run() in xdp_features.c collects the result and
only prints it:

	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));

	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(), ...);
out:
	bpf_xdp_detach(env.ifindex, flags, NULL);
	close(sockfd);
	return err < 0 ? err : 0;

detected_cap never reaches the return value, and main() collapses anything
non-negative:

	return err < 0 ? -err : 0;

So a NOT DETECTED result for XDP_PASS, XDP_DROP, XDP_ABORTED, XDP_TX,
XDP_REDIRECT or XDP_NDO_XMIT still exits 0 and the harness records a pass;
only infrastructure failures such as socket, attach or protocol errors can
fail the test.  Is that intended?

>  set -e
> -trap cleanup 2 3 6 9
> +trap cleanup EXIT
> +trap 'exit 129' HUP
> +trap 'exit 130' INT
> +trap 'exit 143' TERM

[Severity: Medium]
The old trap covered signals 2, 3, 6 and 9, that is INT, QUIT, ABRT and
KILL.  The new set covers HUP, INT and TERM, so QUIT and ABRT are no longer
handled.  A shell killed by an untrapped fatal signal does not run its EXIT
trap, so does kill -QUIT on the script, or a terminal Ctrl-\, now skip
cleanup() entirely and leave the v1 veth and the ns1-XXXXXX netns behind?

The background DUT looks affected too.  A non-interactive shell sets
SIGINT and SIGQUIT to ignored in asynchronous children, so a process-group
SIGQUIT does not reach the child started by:

	./xdp_features "$@" &

and the catch-all sweep that used to collect it has been removed from
cleanup():

	-	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null

That leaves an xdp_features process holding an XDP program plus stale
network state, and the next run then fails in setup() at ip link add v1.

The commit message says "Install an EXIT trap and signal handlers so failure
paths also remove network setup" -- would adding trap 'exit 131' QUIT and
trap 'exit 134' ABRT match that claim?

>  
>  test_xdp_features
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-xdp-dut-process-lifecycle-gmail-v3-1-5b7eee4f7009%40gmail.com
