Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553D53160D;
	Thu,  1 Oct 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878466; cv=none; b=Xr/dLO3PJl4ibTtlX/+cafbpsvqZIh3bkcjrRJBXN/GhzpX6hyQtGoGUxTK6SuXDIH3MMaalikBnPovVR7SVL7EjLja0xAi3hQcQEq7qFInTFUnIafalgKB/yqc9sS0co8TPbFYBQTj663Ujys17sJtiOVNO8c71pptK2i/d6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878466; c=relaxed/simple;
	bh=8l9HWqcsCEEOb4kDKmJhKlKHVbY6rkxoBwHIcudYZaA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gokJ9FarHl13Jkm4uXzndBoPdiwEOvy5YRnXY9mDzSKb8TNQ/YrzBXDMcqqXh3hVedvD7Ng7jI0qq44TI71FigMZrUloLEv2l2Pcf4kFUgsMTqlcLPruPtCaD4Xgj7WzXm6fiEl8LrHVkpyur+3VpRI/Nl4dUAFfAXK8VKWeHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvdhAB1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvdhAB1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1711F000FF;
	Thu,  1 Oct 2026 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790878459;
	bh=eH3tlN3GiHdfukPIWaIJ7ujP/cUxS0ztGAALMsR/SjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VvdhAB1ge8hsZ/QOYUP616VWSyh5AA4nlz+I+ndhqI7tkSEuys6MMG64HLyXbaW4W
	 MIjw8HQxyQFqsyTDsICHhrpycT3TLMVuBnxpLkiSkIk0Q+Nb+1iDqdbqnAqbFMFqda
	 qjKBCQTMz+Zj4XYjMn/ir2xyscBEfoCxlAJP22PQnEzP2mM71lfqC+v+9z2yT4X1+3
	 ZWOf9N8EdFDx7B6hYxxwDApvDzWWtpqZ2EwrAVRcJ4SstNk4E7IpvpFpjB533IRqYL
	 D5MGdIrQBJv8hg92ts/qJAsWmVzFkacR44cMmAQYTtIQbTIpHdpT46IiUL5BCEUjFK
	 dpEIKoyzlXh1A==
Subject: Re: [PATCHv9 net-next] tcp: Add TCP ROCCET congestion control module.
From: netdev-bot+sashiko@kernel.org
To: t.fuechsel@gmx.de
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 fmancera@suse.de, ebiggers@kernel.org, bpf@vger.kernel.org,
 lukas.prause@ikt.uni-hannover.de
Date: Thu, 01 Oct 2026 18:14:17 +0000
Message-ID: <179087845776.434549.18417418117404438718@kernel.org>
In-Reply-To: <arqDuiD4Q4GWOFBc@volt-roccet-vm>
References: <arqDuiD4Q4GWOFBc@volt-roccet-vm>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 8 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says only that ROCCET "reacts to packet
  loss by adapting CUBIC's behavior".
- [Medium] roccet_acked() keeps CUBIC's early return `if (ca->epoch_start
  && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ) return;`, and it sits…
- [Medium] Spurious-RTO undo is partly reversed.
- [Medium] ROCCET uses .cong_control, so the core skips
  tcp_cwnd_reduction() (PRR).
- [Medium] ROCCET's only idle handling is roccet_cwnd_event_tx_start(),
  copied from CUBIC, which just shifts epoch_start.
- [Medium] In roccet_orbiter_update(), `sent_more_than_acked = (s32)(sent
  - received) > div_u64((u64)tcp_snd_cwnd(tp) * (u64)tp->mss_cache,…
- [Medium] Several places intended to reduce cwnd apply a TCP_INIT_CWND
  floor, which can raise cwnd instead and also ignores…
- [Medium] A loss-detecting ACK, or any later ACK during Recovery, can
  reduce cwnd twice.
- [Low] Several in-code comments are stale or contradict the code next to
  them.
- [Low] Two module parameter descriptions shown by modinfo/sysfs do not
  match the code.
- [Low] Every ROCCET 'now' timestamp comes from
  jiffies_to_usecs(tcp_jiffies32) and is compared with u32 modular…
- [Low] update_srrtt() does a plain C division of a u64 by a constant:
  `ca->curr_srrtt = ((100 - ROCCET_ALPHA_TIMES_100) *…

--

tcp: Add TCP ROCCET congestion control module.

This adds ROCCET, a new TCP congestion control module based on CUBIC.
It detects bufferbloat from the relative RTT increase (srRTT), the ACK
arrival rate and the sent/received bytes. It replaces HyStart with its own
slow start (LAUNCH), adds periodic min RTT probing, and uses the
cong_control callback instead of cong_avoid.

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 000000000000..cd8c44490117
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1400 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
> + * Extension for 5G and Beyond Networks

[ ... ]

> + * A peer-reviewed paper on TCP ROCCET will be presented
> + * at the WONS 2026 conference.
> + * A draft of the paper is available here:
> + *		https://arxiv.org/abs/2510.25281

[ ... ]

> + * Unless CUBIC is enabled and congestion window is large
> + * this behaves the same as the original Reno.
> + */

[Severity: Low]
This isn't a bug, but some comments in this file don't match the code.

The header says the paper "will be presented at the WONS 2026
conference", but the commit message already cites the published WONS 2026
DOI.

The sentence "Unless CUBIC is enabled and congestion window is large this
behaves the same as the original Reno" was copied from tcp_cubic.c. It
doesn't describe ROCCET.

In roccet_handle_state_transitions(), the comment says the LAUNCH
bookkeeping also happens "Even on LAUNCH to LAUNCH transitions (on RTO)".
The function returns before it gets there:

	if (ca->state == prev_state)
		return;

In roccet_init(), the comment says initial_limit_reached and
is_in_initial_launch are reset "so they only get set during init".
However, roccet_reset() memsets them again on every TCP_CA_Loss. After an
RTO, initial_limit_reached is false again. That turns off the
!tcp_is_cwnd_limited() LAUNCH exit until roccet_control() sets the flag
again.

In roccet_min_rtt_probe(), the comment refers to "the time_before32
check", but the code uses time_between32().

The comment above roccet_update_pacing_rate() says the code is similar to
tcp_cong_control() and paces at 200% in slow start. The logic actually
follows tcp_update_pacing_rate(), and the slow start ratio comes from
sysctl_tcp_pacing_ss_ratio.

[ ... ]

> +/* Parameters that are specific to the ROCCET-Algorithm */
> +static uint sr_rtt_upper_bound __read_mostly = 100;
> +static int ack_rate_diff_ss __read_mostly = 10;
> +
> +module_param(sr_rtt_upper_bound, uint, 0644);
> +MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
> +module_param(ack_rate_diff_ss, int, 0644);
> +MODULE_PARM_DESC(ack_rate_diff_ss,
> +		 "ROCCET's threshold to exit slow start if ACK-rate differs by given amount of segments.");

[ ... ]

> +module_param_cb(beta, &beta_param_ops, &beta, 0644);
> +MODULE_PARM_DESC(beta, "beta for multiplicative increase");

[Severity: Low]
This isn't a bug, but both of these parameter descriptions disagree with
how the parameters are used.

beta is only used as the multiplicative decrease factor
(cwnd * beta / BICTCP_BETA_SCALE) in roccet_congestion_event(),
roccet_recalc_ssthresh() and roccet_handle_recovery(). Should the text say
"multiplicative decrease"?

For ack_rate_diff_ss, roccet_launch_update() exits LAUNCH when the ACK
rate increase is at most this value, and only if srRTT is also above
sr_rtt_upper_bound:

	if ((ca->curr_srrtt > sr_rtt_upper_bound &&
	     get_ack_rate_diff(ca) <= ack_rate_diff_ss) ||

get_ack_rate_diff() clamps decreases to 0. A negative value written to
this 0644 int therefore permanently disables the srRTT based LAUNCH exit.
Should it be bounds checked the same way beta is?

[ ... ]

> +/* Compute srRTT.
> + */
> +static void update_srrtt(struct roccettcp *ca)
> +{
> +	u64 rrtt;

[ ... ]

> +	rrtt = div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
> +		       ca->curr_min_rtt);
> +
> +	/* (1 - alpha) * srRTT + alpha * rRTT */
> +	ca->curr_srrtt = ((100 - ROCCET_ALPHA_TIMES_100) * (u64)ca->curr_srrtt +
> +			  ROCCET_ALPHA_TIMES_100 * rrtt) /
> +			 100;
> +}

[Severity: Low]
Will this link on 32-bit architectures? This divides a u64 by 100 with a
plain '/'. The compiler turns that into a libgcc call (__udivdi3 on i386,
__aeabi_uldivmod on arm), and the kernel doesn't provide those. The module
link would then fail with an undefined reference.

TCP_CONG_ROCCET has no architecture dependency, so 32-bit allmodconfig
builds will enable it. The rest of the file already uses div_u64() and
do_div(). Would div_u64(..., 100) work here?

[ ... ]

> +static void roccet_enter_min_rtt_probe(struct sock *sk, u32 now)
> +{

[ ... ]

> +	if (!tcp_is_cwnd_limited(sk))
> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);
> +	else
> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
> +
> +	ca->probe_min_rtt_until = now + interval;
> +	ca->cwnd_before_min_rtt_probe = tcp_snd_cwnd(tp);
> +
> +	/* Reduce the cwnd to drain the buffer for probing. */
> +	tcp_snd_cwnd_set(tp, probe_cwnd);

[Severity: Medium]
Can this raise cwnd instead of lowering it?

roccet_congestion_event() and roccet_handle_recovery() let cwnd drop as
low as 2, so a cwnd between 2 and 9 is reachable in ORBITER. With cwnd 4,
probe_cwnd becomes TCP_INIT_CWND (10). That adds queueing right after
curr_min_rtt has been reset to U32_MAX, while the new minimum is being
measured.

The same TCP_INIT_CWND floor is used for the LAUNCH exit in
roccet_launch_update():

	tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
				 TCP_INIT_CWND));

and in roccet_state() for TCP_CA_Loss:

	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);

None of these writes applies tp->snd_cwnd_clamp, unlike
roccet_congestion_event() and tcp_cong_avoid_ai(). A locked route cwnd
metric can set the clamp below 10 in tcp_init_metrics():

	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);

BPF can do the same. Is that clamp then exceeded on probe entry, LAUNCH
exit and RTO?

[ ... ]

> +static void roccet_cwnd_event_tx_start(struct sock *sk)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	u32 now = tcp_jiffies32;
> +	s32 delta;
> +
> +	delta = now - tcp_sk(sk)->lsndtime;
> +
> +	/* We were application limited (idle) for a while.
> +	 * Shift epoch_start to keep cwnd growth to cubic curve.
> +	 */
> +	if (ca->epoch_start && delta > 0) {
> +		ca->epoch_start += delta;
> +		if (after(ca->epoch_start, now))
> +			ca->epoch_start = now;
> +	}
> +}

[Severity: Medium]
Is this enough idle handling for a .cong_control module? CUBIC can get
away with only shifting epoch_start, because the core restarts cwnd after
idle and applies RFC 7661 validation for it. Both of those core paths are
skipped when cong_control is set:

include/net/tcp.h:tcp_slow_start_after_idle_check() {
	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_slow_start_after_idle) ||
	    tp->packets_out || ca_ops->cong_control)
		return;
	...
}

net/ipv4/tcp_output.c:tcp_cwnd_validate() {
	...
		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_slow_start_after_idle) &&
		    (s32)(tcp_jiffies32 - tp->snd_cwnd_stamp) >= inet_csk(sk)->icsk_rto &&
		    !ca_ops->cong_control)
			tcp_cwnd_application_limited(sk);
	...
}

As a result, net.ipv4.tcp_slow_start_after_idle has no effect for ROCCET.
After an idle period longer than RTO, the connection resumes with its full
stale cwnd, paced only over the old srtt.

No other ROCCET path lowers cwnd based on idle time. The idle reset in
update_ack_rate() only clears counters.

[ ... ]

> +static void roccet_orbiter_update(struct sock *sk, u32 acked)
> +{

[ ... ]

> +	sent = tp->snd_nxt - ca->interval_snd_seq_start;
> +	received = tp->snd_una - ca->interval_una_seq_start;
> +
> +	/* Check sent and received bytes from the previous interval.
> +	 * Here we use a guard space of 1% of the current cwnd.
> +	 * We do this to avoid a false positive evaluation due
> +	 * to delays caused by jitter or scheduling.
> +	 */
> +	sent_more_than_acked = (s32)(sent - received) >
> +			       div_u64((u64)tcp_snd_cwnd(tp) *
> +			       (u64)tp->mss_cache, 100);

[Severity: Medium]
Does this comparison do what's intended? (s32)(sent - received) is
compared with the u64 that div_u64() returns. The usual arithmetic
conversions turn the s32 into a u64, so any negative difference becomes a
value near 2^64 and sent_more_than_acked comes out true.

sent - received is the in-flight bytes now minus the in-flight bytes at
the start of the interval. It goes negative whenever the flight shrinks:

  - after a cwnd reduction (DRAIN lasts only 100ms, but the flight keeps
    shrinking for about an RTT)
  - during Recovery, when snd_nxt stalls
  - when the sender is application limited

In those cases, can the srRTT branch below fire another
roccet_congestion_event() while the queue is actually draining?

The growth check has the same input:

	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked ||
	    tcp_in_cwnd_reduction(sk))
		return;

Does it then block CUBIC growth right when growth should resume?

[ ... ]

> +	/* The srRTT exceeds the upper bound if bufferbloat happens.
> +	 * Here, we want to reduce the cwnd and drain the buffer.
> +	 */
> +	if (ca->curr_srrtt > roccet_xj && evaluate_srrtt &&
> +	    sent_more_than_acked) {
> +		roccet_congestion_event(sk, now);
> +		return;
> +	}

[Severity: Medium]
Can a single ACK reduce cwnd twice when Recovery starts? tcp_ack() runs
tcp_fastretrans_alert() before tcp_cong_control(). For a flow in ORBITER:

tcp_fastretrans_alert()
  tcp_enter_recovery()
    tcp_set_ca_state(sk, TCP_CA_Recovery)
      roccet_state()
        roccet_handle_recovery()   /* cwnd = beta * cwnd */
tcp_cong_control()
  roccet_control()
    roccet_orbiter_update()
      roccet_congestion_event()    /* cwnd = beta * cwnd again */

roccet_state() makes the first cut. tcp_set_ca_state() calls set_state
before it updates icsk_ca_state, so tcp_in_cwnd_reduction() is still
false there. The Recovery path doesn't change the ROCCET state, set
roccet_last_event_time_us, or push out next_srrtt_check_ts.

Suppose the srRTT deadline has passed, curr_srrtt is above roccet_xj, and
sent_more_than_acked is true. It is often true in Recovery because of the
signed/unsigned comparison above. Then roccet_congestion_event() runs
here. The tcp_in_cwnd_reduction() check in roccet_orbiter_update() comes
after this branch and only guards growth. Later ACKs during Recovery can
hit the same branch.

With the default beta, cwnd 100 would go to 70 and then to 49. The v9
changelog item "Avoid double-cwnd-reduction via tcp_in_cwnd_reduction
check" covers the roccet_state() path, but not this one.

[ ... ]

> +static u32 roccet_recalc_ssthresh(struct sock *sk)
> +{
> +	const struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	u32 cwnd = tcp_snd_cwnd(tp);
> +
> +	/* In LAUNCH, we want no reduction on loss/ECN.
> +	 * On ECN this is set later on in roccet_state()
> +	 */
> +	if (ca->state == LAUNCH)
> +		return cwnd;

[ ... ]

> +static u32 roccet_handle_recovery(struct sock *sk)
> +{

[ ... ]

> +	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
> +	if (ca->state == LAUNCH) {
> +		ca->state = ORBITER;
> +		return cwnd;
> +	}

[Severity: Medium]
On loss, the commit message only says that ROCCET "reacts to packet loss
by adapting CUBIC's behavior". Is it intended that a loss in LAUNCH never
reduces cwnd?

When Recovery starts in LAUNCH, roccet_recalc_ssthresh() returns the
unreduced cwnd. roccet_handle_recovery() then switches to ORBITER and
keeps the same cwnd. roccet_last_event_time_us isn't set, so no DRAIN
follows. roccet_orbiter_update() only blocks growth during Recovery, so
the slow start overshoot window survives the first recovery episode.
Since .cong_control is set, tcp_cong_control() returns before the core
reduction runs, so nothing else lowers it either.

On RTO, tcp_enter_loss() sets cwnd to packets_in_flight + 1, normally 1,
which is the RFC 5681 loss window. roccet_state(TCP_CA_Loss) then
overwrites it with TCP_INIT_CWND. If the RTO happens in LAUNCH, ssthresh
also stays at the full overshoot cwnd. roccet_recalc_ssthresh() returned
cwnd, and roccet_state() only applies max(ssthresh, TCP_INIT_CWND). Does
the flow then slow start straight back to the window that caused the
timeout?

These deviations are only described in two places. One is the file
header ("LAUNCH, where loss is not considered as a congestion event").
The other is the changelog below the --- line ("Increase cwnd back to
TCP_CWND_INIT on RTO"), which is dropped when the patch is applied.
These are departures from RFC 5681 and RFC 9438. Could the commit
message describe them?

[ ... ]

> +static void roccet_state(struct sock *sk, u8 new_state)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	u32 cwnd;
> +	u32 now = jiffies_to_usecs(tcp_jiffies32);
> +	enum roccet_state prev_state = ca->state;
> +
> +	if (new_state == TCP_CA_Loss) {
> +		roccet_reset(sk, ca);
> +		tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
> +		WRITE_ONCE(tp->snd_ssthresh, max(tp->snd_ssthresh,
> +						 TCP_INIT_CWND));

[Severity: Medium]
What happens here if the RTO turns out to be spurious? roccet_reset()
puts ROCCET into LAUNCH and clears last_max_cwnd and delay_min. Suppose
F-RTO later undoes the loss:

tcp_process_loss()
  tcp_try_undo_loss()
    tcp_undo_cwnd_reduction()            /* cwnd and ssthresh restored */
    tcp_set_ca_state(sk, TCP_CA_Open)    /* ignored by roccet_state() */

tcp_reno_undo_cwnd() restores cwnd to max(cwnd, prior_cwnd), and ssthresh
goes back to prior_ssthresh. In congestion avoidance that leaves
cwnd >= ssthresh while ROCCET is still in LAUNCH.

On the same ACK, roccet_control()->roccet_launch_update() sees
!tcp_in_slow_start(tp) and takes the exit branch:

	tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) -
				 (tcp_snd_cwnd(tp) / 3),
				 TCP_INIT_CWND));
	WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));

Does this cut the restored window by about a third, and lose the CUBIC
Wmax and delay history, even though the RTO was spurious?

> +	} else if (tcp_in_cwnd_reduction(sk)) {

[ ... ]

> +	} else if (new_state == TCP_CA_Recovery) {
> +		/* Directly reduce cwnd and rely on pacing */
> +		cwnd = roccet_handle_recovery(sk);
> +		tcp_snd_cwnd_set(tp, cwnd);
> +	}

[Severity: Medium]
Because .cong_control is set, the core skips tcp_cwnd_reduction() (PRR).
That includes the fast retransmit PRR forces when recovery starts.
tcp_rack_reo_timeout() also leaves this to the module:

	if (!inet_csk(sk)->icsk_ca_ops->cong_control)
		tcp_cwnd_reduction(sk, 1, tp->lost - lost, 0);

Here cwnd is set straight to about 0.7 * cwnd, with no packet
conservation step (BBR uses in_flight + acked). roccet_orbiter_update()
then blocks growth while tcp_in_cwnd_reduction() is true. Can this delay,
or stall, the first retransmission?

tcp_xmit_retransmit_queue() stops while in_flight >= cwnd:

	segs = tcp_snd_cwnd(tp) - tcp_packets_in_flight(tp);
	if (segs <= 0)
		break;

tcp_schedule_loss_probe() only arms TLP in Open or CWR.

With a single loss, the first retransmit waits until SACKs bring
in_flight below 0.7 * cwnd, roughly 30% of an RTT.

With heavy tail loss that isn't marked lost yet, it stalls completely.
For example: cwnd 100, packet 10 lost, 11..30 SACKed, 31..100 lost, so
in_flight == 70 == cwnd. Then no retransmission or probe goes out until
the RTO, which also resets all ROCCET state. PRR would have sent one
forced retransmit in this case.

> +
> +	roccet_handle_state_transitions(sk, prev_state, now);
> +}
> +
> +/* Update RTT samples and min RTT.
> + */
> +static void roccet_acked(struct sock *sk, const struct ack_sample *sample)
> +{

[ ... ]

> +	/* Discard delay samples right after fast recovery */
> +	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
> +		return;

[ ... ]

> +	/* Get valid sample for roccet */
> +	if (sample->rtt_us > 0) {
> +		ca->last_rtt = ca->curr_rtt;
> +		ca->curr_rtt = sample->rtt_us;
> +	}
> +}

[Severity: Medium]
This early return comes from CUBIC, but here it also skips the curr_rtt
and last_rtt updates below. Is that intended?

bictcp_update() starts a new epoch on the first ORBITER growth after any
reduction: DRAIN to ORBITER, Recovery, CWR, Loss, or LAUNCH exit.
roccet_cwnd_event_tx_start() can also clamp epoch_start to now after
idle. For one second after that, curr_rtt and last_rtt stay frozen.

Meanwhile, roccet_control() keeps calling update_min_rtt() and
update_srrtt() on every ACK with acked_sacked > 0. The srRTT EWMA and the
jitter term then converge on RTT data up to a second old. That could
trigger or suppress srRTT congestion events.

The min RTT probe looks affected too. roccet_enter_min_rtt_probe() resets
curr_min_rtt to U32_MAX but leaves epoch_start alone. If the probe starts
less than a second after an epoch start, every probe sample is discarded.
update_min_rtt() then copies the stale, pre-probe curr_rtt into
curr_min_rtt. Would the probe record an inflated minimum RTT in that
case?

[ ... ]

> +static void roccet_control(struct sock *sk, u32 ack, int flag,
> +			   const struct rate_sample *rs)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	u32 now = jiffies_to_usecs(tcp_jiffies32);

[Severity: Low]
Is jiffies_to_usecs(tcp_jiffies32) safe as a wrapping timestamp for
time_between32() and time_after32()? It is only linear mod 2^32 when HZ
divides USEC_PER_SEC. For HZ values such as 300, it uses the out-of-line
version in kernel/time/time.c:

#if BITS_PER_LONG == 32
	return (HZ_TO_USEC_MUL32 * j) >> HZ_TO_USEC_SHR32;
#else
	return (j * HZ_TO_USEC_NUM) / HZ_TO_USEC_DEN;
#endif

That result is not congruent mod 2^32. tcp_jiffies32 wraps 5 minutes after
boot (because of INITIAL_JIFFIES) and then every 2^32 jiffies. At each
wrap, now jumps by about 1.43e9 us.

Wouldn't all of ROCCET's time windows then misfire at once, for every
socket? That covers the DRAIN exit, the ack rate idle reset, the
next_min_rtt_probe expiry (a spurious probe that halves cwnd), the
next_srrtt_check_ts evaluation, the probe and refill timers, and the
500ms initial limit check.

BBR avoids this by using tp->tcp_mstamp.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/arqDuiD4Q4GWOFBc%40volt-roccet-vm
