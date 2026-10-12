Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777D46D571;
	Mon, 12 Oct 2026 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795029; cv=none; b=su5tpy2lcsuQvyzCrOIIVu/M00/DvnbBA//MORXpu3cC6sjuAGicX0Yiu/uUgDeR4Wc7Zb39rzjGz91+qE2DDhkmE0i1J1IynH6uGRaVhl5R0qDuM0kGBe8PLCcrA28SZDBXcZJl2tuj1X8bx7dGhtD7eqVElruYZ6PLk3wthfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795029; c=relaxed/simple;
	bh=ENh+bEBXCb2wicXorSfQOfUQbP4dEARaMFlUcZKABU8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TG09igM+rafwp7oEncRJlPMu3CpjMxofEQI2NL1ky7EJeMeQ2cLXmnRUNsfx5rhBhkKjU/B6B93GEAohxKOGAgNYMLojyu28lplKYRUop8v7iE3eJu/dB9BsaCnENEdzaD6zD0nUv+Xrwn64KSxKaGXePgoAbK1A34CH7rvWwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2+zgDBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2+zgDBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3951D1F0089C;
	Mon, 12 Oct 2026 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795026;
	bh=BpxoXkvv9yLg88Yg8+pdMemjkmyn1aMs3zlzpxIzz64=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q2+zgDBM58iwFf/sSPT0QJ4+cq4uuisiq/UU4DJOIZDAxcdhicXsI6nny+JtFW9OQ
	 7wdtEDepMlcdUz1DPckt1bbIiwj6U9wmgi52aLNSFkayL/diyHhcTXhx+EEO5LL6oe
	 LA2PHD/PUZL54WNz7eIdjXkzjhKfAFkEBRfU0owvxVtNBnwf2pLUq5cIanMWWuQ0i2
	 GO72SCPPvONTl3lkoBSWUU9F/IRuwGkHeRX5RdS6rAHz8rKTJQi08EVnGy8FhkgdI6
	 bp3I3WV9tvDFyaLgfk5yK4kHdMVCa1ioxvq3npcuLHWeAblG/FxMABW9h/B2FKtJB8
	 Hq3oq01KuHSRw==
Subject: Re: [PATCH v2 net-next 09/14] selftests: xsk: run the RX and TX
 endpoints in separate processes
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:25 +0000
Message-ID: <179179502581.434549.6329350256667378198@kernel.org>
In-Reply-To: <20261008114909.734364-10-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-10-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] exec_xskxceiver() in
  tools/testing/selftests/net/xsk_prereqs.sh merges the two endpoint…
- [Medium] The new rendezvous helpers in xsk_prereqs.sh,
  wait_port_listen() and random_port(), depend on iproute2's `ss` and…
- [Medium] exec_xskxceiver() gives the background TX endpoint a fixed
  budget of about 5 s (50 × `sleep 0.1` in wait_port_listen()) to reach…
- [Medium] The launcher's rendezvous checks the port and then uses it
  later, with nothing in between to hold it.
- [Medium] The new TX/RX control channel is an unauthenticated TCP socket
  on 127.0.0.1 in the root network namespace, and both ends run as root.
- [Low] The commit message says the endpoints "no longer have to share a
  process or a host".
- [Low] xskxceiver's usage text documents `-P, --peer-port Control TCP
  port (1-65535)`, but parse_command_line() stores optarg without…
- [Low] test_xsk.sh `-d` is documented as leaving the veths up "so
  xskxceiver can be launched in a debugger", and it now prints two…
- [Low] exec_xskxceiver() now starts the TX endpoint as a background job
  (`... > ${tx_log} 2>&1 &`) and creates a mktemp log.
- [Low] In xsk_peer_rx_progress(), a peer_send() failure with -EPIPE or
  -ECONNRESET sets peer->closed.
- [Low] The concern: xsk_peer_tx_sync() returns the u32 peer->acked as an
  int.

--

selftests: xsk: run the RX and TX endpoints in separate processes

This splits xskxceiver so that each process drives one endpoint, selected
with -e rx|tx. The two processes synchronize over a small TCP control
channel using READY, PROGRESS and ABORT messages, and the remote side is
represented by a shadow ifobject. test_xsk.sh starts TX in the background
on a 127.0.0.1 control port and runs RX once TX is listening.

> Run the two endpoints of a test case in separate xskxceiver processes,
> so that they no longer have to share a process or a host. A process

[Severity: Low]
Is "or a host" accurate for this commit on its own? As far as I can tell,
only the same-host veth setup works here.

test_xsk.sh hard-codes PEER_HOST=127.0.0.1, and the generic data path uses
the synthetic g_mac. setup_peer() also assumes the remote side matches
the local one:

    shadow->caps = local->caps;

Later patches in the series add --hw, --peer-mac, --listen and
drivers/net/hw/xsk.py to run the endpoints on separate hosts. Those
patches are "selftests: xsk: add a hardware mode to xskxceiver" and
"selftests: drv-net: test AF_XDP zero-copy with an SKB peer". Could the
wording say that separate hosts arrive later in the series?

> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> new file mode 100644
> index 0000000000000..faec74aae3794
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> @@ -0,0 +1,275 @@

[ ... ]

> +static int peer_drain(struct xsk_peer *peer)
> +{
> +	struct pollfd pfd = { .fd = peer->fd, .events = POLLIN };
> +	int ret;
> +
> +	while (!peer->closed) {

[ ... ]

> +int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts)
> +{
> +	int err;
> +
> +	if (pkts && !peer->closed) {
> +		err = peer_send(peer, XSK_PEER_PROGRESS, pkts);
> +		if (peer_gone(err))
> +			peer->closed = true;
> +		else if (err)
> +			return err;
> +	}
> +	return peer_drain(peer);
> +}

[Severity: Low]
Can an ABORT from TX get lost here?

Suppose TX fails, sends XSK_PEER_ABORT, and exits while unread PROGRESS
messages are still in its receive queue. Its kernel then resets the
connection.

If the RST arrives between the pacing_rx_progress(0) drain at the top of
__receive_pkts() and the later pacing_rx_progress(pkts_sent), this
peer_send() fails with -ECONNRESET or -EPIPE and sets peer->closed.

peer_drain() then skips its loop because of while (!peer->closed). The
ABORT already queued on the RX socket is never read, so -ECANCELED is
never returned.

The RX side never checks xsk_peer_closed(), so receive_pkts() keeps going
until THREAD_TMOUT and reports "Receive loop timed out". The result is
still a failure, but it shows up late and points at the wrong cause.
Could pending data be drained before the connection is treated as
closed?

[ ... ]

> +/* Return the packets RX reported consumed since the last call, or -errno. */
> +int xsk_peer_tx_sync(struct xsk_peer *peer)
> +{
> +	int err = peer_drain(peer);
> +	u32 acked = peer->acked;
> +
> +	if (err)
> +		return err;
> +	peer->acked = 0;
> +	return acked;
> +}

[Severity: Low]
This returns the u32 peer->acked as an int. A value of 2^31 or more would
look like -errno to pacing_tx_sync(), which then calls strerror(-acked).
Inflated counts would also push pkts_in_flight negative.

With the in-tree peers, acked is reset at every READY and never exceeds
the packets in one step (DEFAULT_PKT_CNT). This only matters if something
other than the real RX endpoint is on the other end of the channel; see
the accept_tmout() comment below. Is it worth bounding the value that
peer_recv_one() adds to peer->acked?

> +static int accept_tmout(int lfd)
> +{
> +	struct pollfd pfd = { .fd = lfd, .events = POLLIN };
> +	int ret;
> +
> +	do {
> +		ret = poll(&pfd, 1, XSK_PEER_ACCEPT_TMOUT_MS);
> +	} while (ret < 0 && errno == EINTR);
> +	if (!ret)
> +		errno = ETIMEDOUT;
> +	return ret > 0 ? accept(lfd, NULL, NULL) : -1;
> +}

[Severity: Medium]
Can an unprivileged local user take over this control channel?

Both endpoints run as root, but the channel is a plain TCP socket on
127.0.0.1 in the root network namespace:

- accept_tmout() accepts the first connection from anyone.
- peer_open_tcp() then closes the listener.
- peer_recv_one() only checks the public XSK_PEER_MAGIC constant.

random_port() picks PEER_PORT once, any user can see it with ss -ltn,
and it is reused for every case. An unprivileged user can either:

  - connect to the TX listener before the real RX does, or
  - bind 127.0.0.1:PEER_PORT between cases, so that the next TX bind()
    fails and wait_port_listen() treats the squatter as TX.

>From there, injected READY, PROGRESS and ABORT frames can abort cases or
skew the pacing. They can also stall the root RX process indefinitely in
xsk_peer_ready(), which reads with no timeout.

Would checking SO_PEERCRED after accept(), or passing a per-run token
from the launcher, address this?

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index b8a52846eaf86..e66625810a9d8 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -177,16 +193,18 @@ static void print_usage(char **argv)
>  		"  -m, --mode           Run only mode skb, drv, or zc\n"
>  		"  -l, --list           List all available tests\n"
>  		"  -t, --test           Run a specific test. Enter number from -l option.\n"
> +		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
> +		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
> +		"  -P, --peer-port      Control TCP port (1-65535)\n"
>  		"  -h, --help           Display this help and exit\n";

[ ... ]

> @@ -261,17 +274,30 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj

[ ... ]

> +		case 'P':
> +			opt_peer_port = optarg;
> +			break;

[Severity: Low]
The usage text gives the range 1-65535, but the value is stored without
any check. peer_open_tcp() then passes it to getaddrinfo() without
AI_NUMERICSERV, so service names like "ssh" and the value "0" are
accepted.

With "0", TX binds an ephemeral port, but the launcher's
wait_port_listen 0 looks for sport = :0. A healthy run then fails with
"TX endpoint did not listen on ...". test_xsk.sh -p also forwards the
value without checking it.

Should -P be parsed as a number in 1-65535, the way -t is checked here
and --udp-port is checked with parse_u32() later in the series?

[ ... ]

> diff --git a/tools/testing/selftests/net/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
> index e476556eb05bb..2ef9ce7e1b27d 100755
> --- a/tools/testing/selftests/net/test_xsk.sh
> +++ b/tools/testing/selftests/net/test_xsk.sh

[ ... ]

> @@ -181,6 +186,13 @@ if [ ${#CASES[@]} -eq 0 ]; then
>  	exit 1
>  fi
>  
> +if [ -z "$PEER_PORT" ]; then
> +	PEER_PORT=$(random_port) || {
> +		echo "Could not find an unused TCP port" >&2
> +		exit 1
> +	}
> +fi
> +
>  validate_root_exec
>  validate_veth_support ${VETH0}
>  validate_ip_utility

[Severity: Medium]
What happens on a system that has ip but no usable ss?

random_port() and wait_port_listen() both depend on iproute2's ss and
send its stderr to /dev/null. Only ip is checked, through
validate_ip_utility(), and that check runs after random_port() here.

If ss is missing, or too old to accept -H, random_port() treats every
port as free. This test in wait_port_listen() then never succeeds:

    if [ -n "$(ss -Hltn "sport = :$1" 2>/dev/null)" ]; then

Every case would report FAIL with "TX endpoint did not listen on ..."
instead of being skipped. Each case also waits out the 30s accept timeout
in TX, because the background process is not killed.

Should there be a check for ss next to validate_ip_utility()?

> @@ -225,7 +237,8 @@ RUN_VARIANT=SOFTIRQ
>  
>  if [[ $debug -eq 1 ]]; then
>      ARGS="${BASE_ARGS} -m ${MODES[0]} -t ${CASES[0]}"
> -    echo "./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}"
> +    echo "./${XSKOBJ} -i ${VETH0} -e tx -p ${PEER_HOST} -P ${PEER_PORT} ${ARGS}"
> +    echo "./${XSKOBJ} -i ${VETH1} -e rx -p ${PEER_HOST} -P ${PEER_PORT} ${ARGS}"
>      exit
>  fi

[Severity: Low]
Does the -d workflow still work when these two commands are run by hand,
for example under a debugger?

The control channel assumes the scripted launcher, as the comment above
peer_open_tcp() says:

/*
 * The launcher starts the listener and waits for its port before starting
 * the connector, so connect() needs no retry. accept() is bounded in case
 * the connector exits before it gets that far.
 */

connect() is tried only once, so starting RX first fails at once with
ECONNREFUSED. Starting RX more than XSK_PEER_ACCEPT_TMOUT_MS (30s) after
TX reaches accept() makes TX fail with ETIMEDOUT.

Should the printed commands mention the required order and time limit,
or should connect() retry?

> diff --git a/tools/testing/selftests/net/xsk_prereqs.sh b/tools/testing/selftests/net/xsk_prereqs.sh
> index 30173db12c567..82cd7839d77d9 100755
> --- a/tools/testing/selftests/net/xsk_prereqs.sh
> +++ b/tools/testing/selftests/net/xsk_prereqs.sh
> @@ -69,16 +69,63 @@ validate_ip_utility()
>  	[ ! $(type -P ip) ] && { echo "'ip' not found. Skipping tests."; test_exit $ksft_skip; }
>  }
>  
> +wait_port_listen()
> +{
> +	local i
> +
> +	for i in $(seq 50); do
> +		if [ -n "$(ss -Hltn "sport = :$1" 2>/dev/null)" ]; then
> +			return 0
> +		fi
> +		kill -0 $2 2>/dev/null || return 1
> +		sleep 0.1
> +	done
> +	return 1
> +}

[Severity: Medium]
Can this pick up a listener that is not the TX endpoint?

wait_port_listen() returns success as soon as ss shows any listener on
the port. It only looks at $2 (tx_pid) when nothing is listening.

random_port() checks the port only once, before the veth setup. Nothing
reserves it, and the same PEER_PORT is used for every case.

If another process holds the port, or -p is given a busy port, TX's
bind() fails with EADDRINUSE and TX exits. wait_port_listen() still
succeeds, and RX connects to the foreign listener and ends up in:

xsk_peer_ready()
  peer_recv_one()
    io_full()
      read()      <- no timeout

A listener that never sends anything hangs the case indefinitely. One
that does send data makes RX fail with -EPROTO. Either way, the verdict
comes from an unrelated process.

> +
> +random_port()
> +{
> +	local i port
> +
> +	for i in $(seq 50); do
> +		port=$((32768 + RANDOM))
> +		if [ -z "$(ss -Hltn "sport = :$port" 2>/dev/null)" ]; then
> +			echo "$port"
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
> +# The TX endpoint listens on the control port and runs in the background,
> +# the RX endpoint connects to it and reports; both print the same verdicts.
>  exec_xskxceiver()
>  {
> -	local run_args="${ARGS}"
> +	local tx_log tx_pid tx_ret run_args="${ARGS}"
>  
>          if [[ $busy_poll -eq 1 ]]; then
>  		run_args+=" -b"
>  	fi
>  
> -	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${run_args}
> -	retval=$?
> +	tx_log=$(mktemp)
> +	./${XSKOBJ} -i ${VETH0} -e tx -p ${PEER_HOST} -P ${PEER_PORT} ${run_args} > ${tx_log} 2>&1 &
> +	tx_pid=$!

[Severity: Low]
What happens to this background TX process and to tx_log on Ctrl-C?

The only signal handler is ctrl_c() in test_xsk.sh:

trap ctrl_c INT

function ctrl_c() {
        cleanup_exit ${VETH0} ${VETH1}
	exit 1
}

In a non-interactive bash script, background jobs ignore SIGINT, so only
the foreground RX is killed.

The TX xskxceiver keeps running with its AF_XDP socket, UMEM and XDP
program while the trap deletes the veths under it. It stops only when it
sees EOF or hits its accept timeout.

The mktemp file is also left behind, because rm -f ${tx_log} only runs
on the normal path.

> +
> +	if wait_port_listen ${PEER_PORT} ${tx_pid}; then
> +		./${XSKOBJ} -i ${VETH1} -e rx -p ${PEER_HOST} -P ${PEER_PORT} ${run_args}
> +		retval=$?
> +	else
> +		echo "TX endpoint did not listen on ${PEER_HOST}:${PEER_PORT}"
> +		retval=1
> +	fi
> +
> +	wait ${tx_pid}
> +	tx_ret=$?

[Severity: Medium]
Is about 5 seconds (50 x sleep 0.1) enough time for TX to reach
listen()?

In xskxceiver main(), listen() happens only in
setup_peer()->xsk_peer_open(). Before that, TX runs:

  bind_iface()             skeleton open_and_load, capability detection
  detect_mode_caps()       is_xdp_supported() attach/detach, and
                           ifobj_zc_avail() UMEM mmap plus XDP_ZEROCOPY bind
  pkt_stream_generate()    twice, with DEFAULT_PKT_CNT
  xsk_load_xdp_programs()  a second skeleton load for the shadow

On a slow machine (KASAN, lockdep, nested virtualization) this could miss
the window.

If it does, retval is set to 1 and RX is never started. tx_pid is not
killed, so wait ${tx_pid} blocks until accept_tmout() gives up after
XSK_PEER_ACCEPT_TMOUT_MS (30s). A healthy pair is then reported as a
failure after a stall of about 35 seconds.

Should TX be killed in the else branch, and should the two timeouts be
aligned?

Separately, random_port() draws ports from 32768 + RANDOM, which overlaps
the default ephemeral port range, and the port is reused for every case.
Can a later ephemeral bind on 127.0.0.1 or the wildcard address make
TX's bind() fail for all remaining cases?

> +	if [[ $tx_ret -ne 0 || $verbose -eq 1 ]]; then
> +		sed 's/^/tx| /' ${tx_log}
> +	fi
> +	rm -f ${tx_log}
> +	[[ $retval -eq 0 ]] && retval=$tx_ret

[Severity: Medium]
Can a TX failure be hidden here?

TX's status is used only when RX returned 0. As a result, RX SKIP (4)
with TX FAIL (1) is recorded as SKIPPED, while TX SKIP with RX FAIL is
recorded as FAIL.

The comment above exec_xskxceiver() says "both print the same verdicts",
but test_spec is no longer shared between the endpoints.

For the XDP_ADJUST_TAIL* cases, testapp_adjust_tail() sets
adjust_tail_support in both processes. Only the RX process can clear it,
in testapp_validate_rx_endpoint():

	if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
		return TEST_FAILURE;
	if (!supported) {
		test->adjust_tail_support = false;
		return TEST_PASS;
	}

testapp_adjust_tail() then picks its verdict from that per-process flag:

	if (!test->adjust_tail_support) {
		ksft_print_msg("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
			       mode_string(test), busy_poll_string(test));
		return TEST_SKIP;
	}

So when the helper is unsupported, TX prints PASS and RX prints SKIP.

Now suppose TX also fails after packets have reached
xsk_xdp_adjust_tail on the RX side. The RX error, including -ECANCELED
from the ABORT, is turned into TEST_PASS above. testapp_adjust_tail()
then returns TEST_SKIP, and the case is recorded as SKIPPED.

Before this patch, the TX thread set test->fail and the same case was
reported as FAIL.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
