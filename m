Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640068;
	b=dEWexoSAwdpbe2C9R2i8EiZYNTiTRPdhgKkyVfwKd3LKit53xXsRFRPoCo4jeRF+vbTL
	 kQM7+X4RMHzL0UNmejhzqhk6d+eCJ74zKo5eEpJTddTn2G5ZhMqaQqEe9m1GJ40S/GMSW
	 My1D702yT+nLpSSpDQ8JUJ9n6BURBdLpcPftczomdrWAQ6Pxx6/PtfWcEu7oOLM8V9x8t
	 /i+ZOR1TfoGIkabfAtnwB+rM9pi+9FkXr+dDc6qpln8xV2sJfcwf2U4dYRtFnNk4G929H
	 29JOFje78SB3rJq8hNtFUZcZI4zZ0EH1nLqBksK3biXpyg36CLszyYPXywk2uG1AFxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640068;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/lWgmRBYReWyxqE08PCl0qgxEEc+BavdsDtI0OpBtE4=;
	b=KXSotevc9ciAGyW7Ig/JmPC8tXDTuo5HkYKxeMvhIUeEIOtfgpJ0x9wPZrwQNfLcnCDd
	 C/Doo8JKd4kq7HyYxJvI087omGSd+LJpe96xWvw9yJPJpsXpQtjOURZWhh1CeeHDcYli7
	 pNns6yNAFrpoCuIRRYZ4niL9BaNmndqZj8nRdhHKZ1dcdkdJtspxrMZJNUzWSHIkazmh5
	 4LDygsubB5xbK182mNqTYfXtTNNbbESSu4rlzx3cW8kHehu4a5VeJ1FD+qcaz1vQuefHE
	 RZDPo4EKBxhzClrp0Wn1ql/fdCs959MxJBRseipW7NM86Rkqylt2A+0fDpIGsU0DW1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St1z4A6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6160A3801;
	Mon,  2 Nov 2026 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St1z4A6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49B91F00A1A;
	Mon,  2 Nov 2026 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640067;
	bh=/lWgmRBYReWyxqE08PCl0qgxEEc+BavdsDtI0OpBtE4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=St1z4A6rh6NLYmsVZPX6tGvq0QNw9pVzbqQRnIuhmqJh0HO8TrJuJ+L4ld45OKarB
	 ozIfXu0FO4c6Sq8aVSvZdkkwNpQhzzKzmdw9YExNJ9RzhXMrWG1/r2IyyabVdUZQXS
	 joORhYBXbKREbsS4Q6c/uobj2OOx8WcOYgwwsZ1JQS3DXFxzWG/yj3jxTXYUCS7cmo
	 ZxQeAb6YTdPiVnWq5rKvdHAB3krsqqZ81F67DZxLUyMqyGG2NTSBBZvKa3lCE5Lps5
	 WP8sQ8xtq2Kc/gzcenufc92h3pyCRGpVL6DBfwUw1Zzt4nGlZGr+OyVR64J+RBBGai
	 WNl9cjCKyZrXQ==
Subject: Re: [PATCH net 2/2] selftests: net: check TCP IP IDs across tunnels
 after GRO and GSO
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, richardbgobert@gmail.com, willemb@google.com,
 ecree.xilinx@gmail.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 17:21:05 +0000
Message-ID: <179364006548.3131.13475531493993778101@kernel.org>
In-Reply-To: =?utf-8?q?=3C741cdd984b05c2e8bccfe6af5c2596f17b3dcccc=2E1792857?=
 =?utf-8?q?378=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
References: =?utf-8?q?=3C741cdd984b05c2e8bccfe6af5c2596f17b3dcccc=2E17928573?=
 =?utf-8?q?78=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] ipv6: seg6: use-after-free of hdr in ipv6_srh_rcv() after
  iptunnel_pull_offloads()
- [Medium] The test says it checks that "the inner IDs must come out as
  they went in" (tcp_fixedid.sh header, lines 16-18, and the commit…
- [Medium] udp: gso: inner hw_enc_features re-masking clobbers remcsum
  NETIF_F_HW_CSUM
- [Low] In tools/testing/selftests/net/Makefile, the patch adds
  tcp_fixedid.sh to TEST_PROGS at line 109, between tcp_ecmp_failover.sh…
- [Low] The "GRO did not merge" skip in check() (tcp_fixedid.sh lines
  154-156) uses the change in tun0's statistics/tx_packets as its input.
- [Low] run_decap() in tcp_fixedid.sh ignores the return value of `tunnel
  "$NRTR" tun0 ipip 4 10.2.0.1 10.2.0.2` (line 212).
- [Low] tcp_fixedid.sh creates a temporary file with `RESULT=$(mktemp)`
  (line 276).
- [Low] capture() in tcp_fixedid.sh (lines 162-172) starts the receiver
  in the background and polls RESULT for "ready" up to 100 times at 0.1…

--

selftests: net: check TCP IP IDs across tunnels after GRO and GSO

This adds a selftest that sends TCP segments with fixed or incrementing
IPv4 IDs onto a veth with GRO enabled. The merged packets are forwarded
through IPIP, GRE and VXLAN tunnels with software segmentation, and the
inner and outer IP IDs are checked. It also covers VXLAN decapsulation into
IPIP, and a tunnel that is decapsulated without segmentation before
forwarding.

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 9180b9bec5155..dd402814bc748 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -106,6 +106,7 @@ TEST_PROGS := \
>  	srv6_iptunnel_cache.sh \
>  	stress_reuseport_listen.sh \
>  	tcp_ecmp_failover.sh \
> +	tcp_fixedid.sh \
>  	tcp_fastopen_backup_key.sh \

[Severity: Low]
This isn't a bug, but tcp_fixedid.sh is out of alphabetical order here. It
should come after tcp_fastopen_backup_key.sh. The TEST_GEN_FILES and
.gitignore entries in this patch are in the right place.

[ ... ]

> diff --git a/tools/testing/selftests/net/tcp_fixedid.sh b/tools/testing/selftests/net/tcp_fixedid.sh
> new file mode 100755
> index 0000000000000..88f9298174077
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_fixedid.sh
> @@ -0,0 +1,291 @@

[ ... ]

> +cleanup() {
> +	cleanup_all_ns
> +}
> +
> +trap cleanup EXIT

[Severity: Low]
Should cleanup() also remove "$RESULT"?

The file is created with RESULT=$(mktemp) near the end of the script. It is
only removed by the rm -f "$RESULT" on the normal exit path.

If the script is interrupted, for example by Ctrl-C or a kselftest runner
timeout, the EXIT trap only calls cleanup_all_ns. The temp file is then left
in $TMPDIR.

[ ... ]

> +# check <name> <result> <want: fixed|incr> <outer: 0|1> <merged-into-dev>
> +check() {
> +	local name=$1 res=$2 want=$3 outer=$4 sent=$5
> +	local frames outer_ids inner_ids
> +
> +	read -r _ frames _ _ _ outer_ids _ inner_ids <<< "$res"
> +	RET=0
> +	check_err $((frames != TOTAL)) "$frames of $TOTAL segments received"
> +	if [ "$want" = fixed ]; then
> +		check_err $((inner_ids != 1)) "$inner_ids inner IDs, want 1"
> +	else
> +		check_err $((inner_ids != TOTAL)) \
> +			"$inner_ids inner IDs, want $TOTAL"
> +	fi

[Severity: Medium]
The header comment and the commit message say "The inner IDs must come out
as they went in". Does anything compare the received IDs with the values
that were sent?

do_tx() in tcp_fixedid.c writes known values:

    uint16_t id = fixed_id ? FIXED_ID : 0x1000 + i;

do_rx(), though, only records each received ID in a bitmap through
count_id() and prints how many distinct values it saw. check() then only
compares that count with 1 or TOTAL.

A regression that changed every fixed 0x1234 inner ID to some other
constant, such as 0, would still give inner_ids == 1 and pass. The same is
true for a regression that replaced the 0x1000..0x1000+TOTAL-1 sequence with
any other set of TOTAL unique values.

Could the receiver check the actual values instead? For example, fixed IDs
could be required to equal FIXED_ID, and incrementing IDs to fall in the
range the sender used.

> +	if [ "$outer" = 1 ]; then
> +		check_err $((outer_ids != frames)) \
> +			"$outer_ids outer IDs for $frames segments"
> +	fi
> +	if [ "$RET" -eq 0 ] && [ "$sent" -ge "$TOTAL" ]; then
> +		ret_set_ksft_status "$ksft_skip" "GRO did not merge"
> +	fi

[Severity: Low]
The skip decision uses the change in tun0's statistics/tx_packets, which the
comment above calls <merged-into-dev>. Doesn't tx_packets count every skb
sent through tun0, not just the forwarded test stream?

gre, ip6gre and vxlan devices get an IPv6 link-local address from addrconf.
That means MLD reports, router solicitations and, for vxlan, DAD neighbour
solicitations can go out through tun0 between the t0 read and the final
tx_packets read.

If GRO merged only a few segments, this extra traffic could push sent to
TOTAL or above. A run that did merge would then be reported as SKIP. This
can only happen when GRO barely merged anything, and it cannot cause a false
PASS.

The header comment also says "Packets that GRO did not merge are not
tested". In practice the receiver counts every frame and check() looks at
all of them. The only related rule skips the whole run when sent >= TOTAL.
Could the comment be reworded to match what the code does?

> +	log_test "$name"
> +}
> +
> +# capture <ns> <dev>: start the receiver in the background, pid in CAP_PID,
> +# and wait until it is bound
> +capture() {
> +	local i
> +
> +	: > "$RESULT"
> +	ip netns exec "$1" "$TX" -R -i "$2" -c "$TOTAL" -w 3000 > "$RESULT" &
> +	CAP_PID=$!
> +	for i in $(seq 100); do
> +		grep -q ready "$RESULT" && return
> +		sleep 0.1
> +	done
> +}

[Severity: Low]
What happens if the receiver never prints "ready"? After 100 iterations the
loop falls through, and capture() returns success without checking whether
CAP_PID is still running.

The callers start the sender right away and ignore the exit status of:

    wait "$CAP_PID"

Suppose the receiver failed in main() at socket(), if_nametoindex() or
bind(), or took more than 10 seconds to start. Then RESULT has no result
line, and check() reports something like " of 400 segments received" with
empty counts instead of a setup error.

Could capture() fail, or the test skip, when "ready" never appears or the
receiver has already exited?

[ ... ]

> +# run_decap <fixed: inner|outer>: VXLAN from NSRC, decapsulated in NRTR
> +run_decap() {
> +	local fixed=$1 want=incr flags=-F
> +	local r0mac t0
> +
> +	setup || { log_test_skip "decap"; return; }
> +	ip -n "$NRTR" link add vx0 address "$VX_MAC" type vxlan id 42 \
> +		dstport 4789 local 10.1.0.2 nolearning ||
> +		{ log_test_skip "decap"; cleanup_all_ns; return; }
> +	ip -n "$NRTR" addr add 10.3.0.2/24 dev vx0
> +	ip -n "$NRTR" link set vx0 up
> +	tunnel "$NRTR" tun0 ipip 4 10.2.0.1 10.2.0.2
> +	route_into "$NRTR" tun0

[Severity: Low]
Should the return value of tunnel() be checked here, as run_encap() and
run_encap_decap() do?

If the ipip link can't be created, the route add in route_into() fails, but
the function still returns success:

    route_into() {
        ip -n "$1" route add "$INNER_DST/32" dev "$2"
        ...
        return 0
    }

Nothing then reaches m1. The receiver waits 10 * 3000 ms for a first frame
and prints frames 0, and check() reports a FAIL instead of a SKIP.

On such a kernel the ipip encap cases SKIP, while both decap cases FAIL
after about 30 seconds each. The standard selftests config sets
CONFIG_NET_IPIP=y, so this only shows up with other configs.

[ ... ]

> @@ -0,0 +1,291 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Check the IPv4 IDs of a TCP stream that GRO merged and software
> +# segmentation split again across a tunnel. A sender in NSRC writes
> +# segments with fixed or incrementing IDs onto a veth with GRO on in
> +# NRTR, which forwards the merged packets:
> +#
> +#  encap:       into an IPIP, GRE or VXLAN tunnel over IPv4 or IPv6,
> +#               segmented on the underlay towards NMID
> +#  decap:       out of VXLAN, received from NSRC with one header fixed and
> +#               the other incrementing, into an IPIP tunnel towards NMID
> +#  encap+decap: into a tunnel that NMID ends without segmenting, and on
> +#               to NDST, segmented there
> +#
> +# The inner IDs must come out as they went in, and the IDs of a new outer
> +# IPv4 header must be unique. Packets that GRO did not merge are not
> +# tested, so a run where nothing was merged is skipped.
> +
> +source lib.sh
> +
> +NSRC=""
> +NRTR=""
> +NMID=""
> +NDST=""
> +
> +SEGS=40
> +BURSTS=10
> +TOTAL=$((SEGS * BURSTS))
> +INNER_SRC=10.1.0.1
> +INNER_DST=10.9.0.2
> +VX_MAC=02:00:00:00:00:42
> +TUN_MAC=02:00:00:00:00:99
> +MID_MAC=02:00:00:00:00:98
> +TX=./tcp_fixedid
> +
> +NOSEG="tso gso tx-gre-segmentation tx-gre-csum-segmentation
> +       tx-ipxip4-segmentation tx-ipxip6-segmentation
> +       tx-udp_tnl-segmentation tx-udp_tnl-csum-segmentation"

[Severity: Medium]
Also outside this patch, but on the software UDP tunnel segmentation
path that NOSEG forces. With SKB_GSO_CB(skb)->encap_level = 0 removed
from __skb_udp_tunnel_segment(), the inner IP GSO handler now sees
encap_level > 0. That undoes the checksum setup for remote checksum
offload.

__skb_udp_tunnel_segment() masks features with
skb->dev->hw_enc_features. For SKB_GSO_TUNNEL_REMCSUM it then clears
NETIF_F_CSUM_MASK. It sets NETIF_F_HW_CSUM if the outer checksum is
not needed or can be offloaded. That way the inner segmentation does
not compute checksums that remcsum replaces anyway.

gso_inner_segment() then calls inet_gso_segment() or
ipv6_gso_segment(). Both of them do:

    encap = SKB_GSO_CB(skb)->encap_level > 0;
    if (encap)
        features &= skb->dev->hw_enc_features;

This used to be skipped for the inner header. Now features is masked a
second time, after the remcsum adjustment, so NETIF_F_HW_CSUM only
survives if hw_enc_features contains it.

Some devices have hw_enc_features of 0. Others only advertise
NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM, which remcsum already cleared.
On either kind of device no checksum bit is left, and skb_segment()
takes the !csum path. It then computes a software checksum for every
segment and linearizes segments with shared frags. It also can no
longer use GSO_PARTIAL or frag_list splitting.

As far as I can see the packets are still correct. But this is a
performance regression for remcsum users, and the series does not
mention it.

Was the second mask intended? If the goal is only to tell the inner
header that it is encapsulated, for the IP ID handling, could that be
signalled some other way? Or could the remcsum features be preserved
across the inner mask?

The vxlan cases in this test do not enable remcsumtx, so the test
would not notice this.

> +
> +cleanup() {
> +	cleanup_all_ns
> +}
> +
> +trap cleanup EXIT
> +
> +# NSRC s0 - r0 NRTR r1 - m1 NMID m2 - d2 NDST
> +setup() {
> +	setup_ns NSRC NRTR NMID NDST || return "$ksft_skip"
> +
> +	ip link add s0 netns "$NSRC" type veth peer name r0 netns "$NRTR"
> +	ip link add r1 netns "$NRTR" type veth peer name m1 netns "$NMID"
> +	ip link add m2 netns "$NMID" type veth peer name d2 netns "$NDST"
> +
> +	ip -n "$NRTR" addr add 10.1.0.2/24 dev r0
> +	ip -n "$NRTR" addr add 10.2.0.1/24 dev r1
> +	ip -n "$NRTR" addr add fd02::1/64 dev r1 nodad
> +	ip -n "$NMID" addr add 10.2.0.2/24 dev m1
> +	ip -n "$NMID" addr add fd02::2/64 dev m1 nodad
> +	ip -n "$NMID" addr add 10.4.0.1/24 dev m2
> +	ip -n "$NDST" addr add 10.4.0.2/24 dev d2
> +	ip -n "$NSRC" link set s0 up
> +	ip -n "$NRTR" link set r0 up
> +	ip -n "$NRTR" link set r1 up
> +	ip -n "$NMID" link set m1 up
> +	ip -n "$NMID" link set m2 up
> +	ip -n "$NDST" link set d2 up
> +
> +	ip netns exec "$NRTR" sysctl -qw net.ipv4.ip_forward=1
> +	ip netns exec "$NMID" sysctl -qw net.ipv4.ip_forward=1
> +	for ns in "$NRTR" "$NMID"; do
> +		ip netns exec "$ns" sysctl -qw net.ipv4.conf.all.rp_filter=0 \
> +			net.ipv4.conf.default.rp_filter=0
> +	done
> +
> +	# veth passes packets to GRO only if the sender does not do TSO
> +	ip netns exec "$NRTR" ethtool -K r0 gro on >/dev/null ||
> +		return "$ksft_skip"
> +	ip netns exec "$NSRC" ethtool -K s0 tso off >/dev/null ||
> +		return "$ksft_skip"
> +	# release the sender's segments in bursts for GRO to merge
> +	tc -n "$NSRC" qdisc add dev s0 root netem slot 20ms 20ms \
> +		packets "$SEGS" || return "$ksft_skip"
> +}
> +
> +# tunnel <ns> <name> <type> <family> <local> <remote>
> +tunnel() {
> +	local ns=$1 name=$2 type=$3 family=$4 local=$5 remote=$6
> +
> +	case "$type" in
> +	ipip)
> +		if [ "$family" = 4 ]; then
> +			ip -n "$ns" link add "$name" type ipip \
> +				local "$local" remote "$remote"
> +		else
> +			ip -n "$ns" link add "$name" type ip6tnl mode ipip6 \
> +				local "$local" remote "$remote" encaplimit none
> +		fi ;;
> +	gre)
> +		if [ "$family" = 4 ]; then
> +			ip -n "$ns" link add "$name" type gre \
> +				local "$local" remote "$remote"
> +		else
> +			ip -n "$ns" link add "$name" type ip6gre \
> +				local "$local" remote "$remote" encaplimit none
> +		fi ;;
> +	vxlan)
> +		ip -n "$ns" link add "$name" address "$TUN_MAC" type vxlan \
> +			id 7 dstport 4789 local "$local" remote "$remote" \
> +			nolearning ;;
> +	esac || return 1
> +	ip -n "$ns" link set "$name" up
> +}
> +
> +# route_into <ns> <dev>: send INNER_DST into <dev>
> +route_into() {
> +	ip -n "$1" route add "$INNER_DST/32" dev "$2"
> +	ip -n "$1" neigh add "$INNER_DST" lladdr "$TUN_MAC" dev "$2" \
> +		2>/dev/null
> +	return 0
> +}
> +
> +# noseg <ns> <dev>: segment everything in software before <dev>
> +noseg() {
> +	local f
> +
> +	for f in $NOSEG; do
> +		ip netns exec "$1" ethtool -K "$2" "$f" off >/dev/null 2>&1
> +	done
> +}
> +
> +tx_packets() {
> +	ip netns exec "$1" cat "/sys/class/net/$2/statistics/tx_packets"
> +}
> +
> +# check <name> <result> <want: fixed|incr> <outer: 0|1> <merged-into-dev>
> +check() {
> +	local name=$1 res=$2 want=$3 outer=$4 sent=$5
> +	local frames outer_ids inner_ids
> +
> +	read -r _ frames _ _ _ outer_ids _ inner_ids <<< "$res"
> +	RET=0
> +	check_err $((frames != TOTAL)) "$frames of $TOTAL segments received"
> +	if [ "$want" = fixed ]; then
> +		check_err $((inner_ids != 1)) "$inner_ids inner IDs, want 1"
> +	else
> +		check_err $((inner_ids != TOTAL)) \
> +			"$inner_ids inner IDs, want $TOTAL"
> +	fi
> +	if [ "$outer" = 1 ]; then
> +		check_err $((outer_ids != frames)) \
> +			"$outer_ids outer IDs for $frames segments"
> +	fi
> +	if [ "$RET" -eq 0 ] && [ "$sent" -ge "$TOTAL" ]; then
> +		ret_set_ksft_status "$ksft_skip" "GRO did not merge"
> +	fi
> +	log_test "$name"
> +}
> +
> +# capture <ns> <dev>: start the receiver in the background, pid in CAP_PID,
> +# and wait until it is bound
> +capture() {
> +	local i
> +
> +	: > "$RESULT"
> +	ip netns exec "$1" "$TX" -R -i "$2" -c "$TOTAL" -w 3000 > "$RESULT" &
> +	CAP_PID=$!
> +	for i in $(seq 100); do
> +		grep -q ready "$RESULT" && return
> +		sleep 0.1
> +	done
> +}
> +
> +run_encap() {
> +	local type=$1 family=$2 want=$3
> +	local r0mac t0 laddr=10.2.0.1 raddr=10.2.0.2
> +	local f=""
> +
> +	setup || { log_test_skip "encap $type IPv$family"; return; }
> +	if [ "$family" = 6 ]; then
> +		laddr=fd02::1
> +		raddr=fd02::2
> +	fi
> +	tunnel "$NRTR" tun0 "$type" "$family" "$laddr" "$raddr" ||
> +		{ log_test_skip "encap $type IPv$family"; cleanup_all_ns; return; }
> +	route_into "$NRTR" tun0
> +	noseg "$NRTR" r1
> +
> +	r0mac=$(ip -n "$NRTR" -br link show r0 | awk '{ print $3 }')
> +	capture "$NMID" m1
> +	t0=$(tx_packets "$NRTR" tun0)
> +	[ "$want" = fixed ] && f=-f
> +	ip netns exec "$NSRC" "$TX" -T -i s0 -M "$r0mac" -s "$INNER_SRC" \
> +		-d "$INNER_DST" -n "$SEGS" -b "$BURSTS" $f
> +	wait "$CAP_PID"
> +	check "encap $type IPv$family, $want inner IDs" "$(tail -n 1 "$RESULT")" \
> +		"$want" $((family == 4)) $(($(tx_packets "$NRTR" tun0) - t0))
> +	cleanup_all_ns
> +}
> +
> +# run_decap <fixed: inner|outer>: VXLAN from NSRC, decapsulated in NRTR
> +run_decap() {
> +	local fixed=$1 want=incr flags=-F
> +	local r0mac t0
> +
> +	setup || { log_test_skip "decap"; return; }
> +	ip -n "$NRTR" link add vx0 address "$VX_MAC" type vxlan id 42 \
> +		dstport 4789 local 10.1.0.2 nolearning ||
> +		{ log_test_skip "decap"; cleanup_all_ns; return; }
> +	ip -n "$NRTR" addr add 10.3.0.2/24 dev vx0
> +	ip -n "$NRTR" link set vx0 up
> +	tunnel "$NRTR" tun0 ipip 4 10.2.0.1 10.2.0.2
> +	route_into "$NRTR" tun0
> +	noseg "$NRTR" r1
> +
> +	if [ "$fixed" = inner ]; then
> +		want=fixed
> +		flags=-f
> +	fi
> +	r0mac=$(ip -n "$NRTR" -br link show r0 | awk '{ print $3 }')
> +	capture "$NMID" m1
> +	t0=$(tx_packets "$NRTR" tun0)
> +	ip netns exec "$NSRC" "$TX" -T -i s0 -M "$r0mac" -s 10.3.0.1 \
> +		-d "$INNER_DST" -n "$SEGS" -b "$BURSTS" \
> +		-V 10.1.0.1,10.1.0.2 -m "$VX_MAC" $flags
> +	wait "$CAP_PID"
> +	check "decap VXLAN with fixed $fixed IDs, into IPIP" \
> +		"$(tail -n 1 "$RESULT")" "$want" 1 \
> +		$(($(tx_packets "$NRTR" tun0) - t0))
> +	cleanup_all_ns
> +}
> +
> +# run_encap_decap <type>: NRTR encapsulates, NMID decapsulates the GSO
> +# packet without segmenting it and forwards it to NDST
> +run_encap_decap() {
> +	local type=$1
> +	local r0mac t0
> +
> +	setup || { log_test_skip "encap+decap $type"; return; }
> +	if ! tunnel "$NRTR" tun0 "$type" 4 10.2.0.1 10.2.0.2 ||
> +	   ! tunnel "$NMID" tun0 "$type" 4 10.2.0.2 10.2.0.1; then
> +		log_test_skip "encap+decap $type"
> +		cleanup_all_ns
> +		return
> +	fi
> +	route_into "$NRTR" tun0
> +	# VXLAN drops frames from its own address as loops
> +	if [ "$type" = vxlan ]; then
> +		ip -n "$NMID" link set tun0 address "$MID_MAC"
> +		ip -n "$NRTR" neigh replace "$INNER_DST" lladdr "$MID_MAC" \
> +			dev tun0
> +	fi
> +	ip -n "$NMID" route add "$INNER_DST/32" via 10.4.0.2
> +	ip -n "$NDST" addr add "$INNER_DST/32" dev d2
> +	noseg "$NMID" m2
> +
> +	r0mac=$(ip -n "$NRTR" -br link show r0 | awk '{ print $3 }')
> +	capture "$NDST" d2
> +	t0=$(tx_packets "$NRTR" tun0)
> +	ip netns exec "$NSRC" "$TX" -T -i s0 -M "$r0mac" -s "$INNER_SRC" \
> +		-d "$INNER_DST" -n "$SEGS" -b "$BURSTS" -f
> +	wait "$CAP_PID"
> +	check "encap+decap $type, fixed inner IDs" "$(tail -n 1 "$RESULT")" fixed 0 \
> +		$(($(tx_packets "$NRTR" tun0) - t0))
> +	cleanup_all_ns
> +}
> +
> +require_command ethtool
> +require_command tc
> +
> +if [ ! -x "$TX" ]; then
> +	echo "SKIP: $TX not built"
> +	exit "$ksft_skip"
> +fi
> +
> +RESULT=$(mktemp)
> +
> +for type in ipip gre vxlan; do
> +	for family in 4 6; do
> +		run_encap "$type" "$family" fixed
> +		run_encap "$type" "$family" incr
> +	done
> +done
> +run_decap inner
> +run_decap outer
> +for type in ipip gre vxlan; do
> +	run_encap_decap "$type"
> +done
> +
> +rm -f "$RESULT"
> +exit "$EXIT_STATUS"

[Severity: Critical]
This is outside this patch, but the GSO decap path these tests are
about has a use-after-free in ipv6_srh_rcv() in net/ipv6/exthdrs.c,
now that it calls iptunnel_pull_offloads().

hdr is set from skb_transport_header(skb) at the top of the function,
so it points into skb->head. The segments_left == 0 branch handles an
IPv6 or IPv4 next header. It pulls the outer IPv6 header and the SRH,
resets the network and transport headers, and then calls
iptunnel_pull_offloads(skb). After that call, it still reads
hdr->nexthdr to decide whether skb->protocol becomes ETH_P_IP.

For a GSO skb, iptunnel_pull_offloads() calls skb_unclone(). Suppose
the skb is cloned, for example because a packet tap holds another
reference. Then pskb_expand_head() moves the data to a new head and
drops its reference on the old one. If the other clone has already
been consumed, the old head is freed, and the hdr->nexthdr read is a
use-after-free. That can crash, show up as a KASAN report, or give the
decapsulated packet the wrong inner protocol.

The skb_cloned() check later in ipv6_srh_rcv() only runs when
segments_left is non-zero. Nothing on this path makes sure the skb is
unshared first.

Could hdr->nexthdr be saved in a local before the pull? Or could
skb->protocol be set before iptunnel_pull_offloads() is called?

None of the cases in this selftest use SRv6, so it would not catch
this. Would a seg6 decap case be worth adding?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792857378.git.julius%40bairaktaris.de
