Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073C47012D;
	Wed, 23 Sep 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159949; cv=none; b=s57yACe+9ykoFC8eGswZgDHbCHfPVkTx4W7uoIjasg06XKGeLln17pazJHtUCyRQDJsA1f6PAk9C/QE84gx1pV4V/oJEZih0QHRVDpy80wgrWnQi198JPkDwOCmjMcwsrwt01426hbjpEaRi15780xhUJFJpu3GgPPhbcPCsKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159949; c=relaxed/simple;
	bh=AeGvuGG9LWIPlwzkzOo9EtESZDPhmf6GDHFfGNztMWA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbPnokWpy9fRb+hYE6Bo6S2qNgkkJ+dfzRJduYVFZ6eeRbanyrP2f1Pdm6BwnVNKMmdwJJRvqC7gJek2cwpZAEvEDE/LiNC8DtQ2qUJZyBQ787lU7hbCrRr+uoHmaKTvyKeuj1w54UmdU92s/ccaymMxqczuY+Xz1k21KBAvXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA5uJMVb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA5uJMVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0341F000FF;
	Wed, 23 Sep 2026 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790159934;
	bh=6gjxeUdv7tREnoEFGT0pMJhT5frN9qOvVbvJb3EH9ww=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eA5uJMVbHXtmUK+W9StgXqqEQlF6NZsIes1RNLK8fPOEq52So4qFFOjJyA0v5RE9D
	 lF4+0CdpvcDmAtIvtPobiOzmNi35I0Vx6cnTNaWPx8sYOWsoonjVDqR5wdt/UNXqBn
	 KMiNiqvqFvivDW5DRPydpA1cvjhuwANuqPCwjfhvwrMzb1ySgwISZodcsZo1GosTBK
	 WLz2k28UHJEqLqamnUbSUm4RhQHt+WfTip0RggXiRdyzmSN4eyeeQu8nSQ8RZHmJ5y
	 t9eZo7r8FkTqGN0aIKxKORW8xsmt8ff0gLvVrxsPsSS6Qg+xvdOnYsdnCryp0abtcg
	 4cf10LprNTrfQ==
Subject: Re: [PATCHv7 net-next] tcp: Add TCP ROCCET congestion control module.
From: netdev-bot+sashiko@kernel.org
To: t.fuechsel@gmx.de
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 fmancera@suse.de, ebiggers@kernel.org, bpf@vger.kernel.org,
 lukas.prause@ikt.uni-hannover.de
Date: Wed, 23 Sep 2026 10:38:53 +0000
Message-ID: <179015993329.2160803.9511216560746700566@kernel.org>
In-Reply-To: <aq5hgNNRLEpZq2YN@volt-roccet-vm>
References: <aq5hgNNRLEpZq2YN@volt-roccet-vm>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 20 potential
issue(s) to consider.

Critical: 0 · High: 5 · Medium: 8 · Low: 7

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] No multiplicative decrease on loss while in the LAUNCH state,
  including on repeated retransmission timeouts.
- [High] ORBITER and DRAIN ping-pong on every ACK, with congestion-window
  growth completely frozen, once `ca->roccet_last_event_time_us` becomes…
- [High] Plain packet loss (TCP_CA_Recovery) reduces cwnd once but does
  not gate the ROCCET state machine: `roccet_handle_recovery()` returns…
- [High] tcp_roccet: failure to reset CUBIC epoch after min RTT probing
  causes massive window explosion
- [High] tcp_roccet: TCP_CA_CWR clobbers last_max_cwnd with probe_cwnd
- [Medium] `roccet_state()` treats *every* entry into TCP_CA_Loss as a
  full algorithm restart (`roccet_reset()` wiping curr_min_rtt,…
- [Medium] The function comment of `roccet_update_pacing_rate()`
  documents state-machine-driven pacing ("In LAUNCH (slow start) we want…
- [Medium] `roccet_launch_update()` calls `tcp_slow_start(tp, acked)`
  *before* testing `tcp_in_slow_start(tp)`, so the helper can be invoked…
- [Medium] The min-RTT probing states can remain stuck with the probe-
  reduced congestion window for up to ~35 minutes.
- [Medium] RTT-derived metrics are recomputed whenever packets were
  delivered, even when `roccet_acked()` rejected the corresponding RTT…
- [Medium] A CWR→Recovery transition applies a second multiplicative
  reduction inside the same recovery window.
- [Medium] Unclamped, peer-influenced RTT values are used in 32-bit
  arithmetic.
- [Medium] tcp_roccet: missing sequence variable reset causes false
  congestion event in ORBITER
- [Low] The new file's header comment carries over CUBIC boilerplate that
  is factually wrong for ROCCET: it documents HyStart as part of this…
- [Low] The `beta` module parameter is registered writable (0644 via
  `module_param_cb(beta, &beta_param_ops, &beta, 0644)`) but its…
- [Low] Two writes to `tp->snd_ssthresh` in the new module use plain
  stores instead of `WRITE_ONCE()`: `tp->snd_ssthresh =…
- [Low] `struct roccettcp` documents `curr_rtt` as "last sample rtt of
  current round" and `last_rtt` as "sample rtt of previous round" (used…
- [Low] The user-visible module parameter description is inverted:
  `MODULE_PARM_DESC(beta, "beta for multiplicative increase")` while…
- [Low] `beta_param_set()` validates the candidate with `kstrtoint(val,
  10, &beta_candidate)` but then stores it by delegating to…
- [Low] `sr_rtt_upper_bound` (uint, 0644) and `ack_rate_diff_ss` (int,
  0644) are runtime-writable with no validation at all, in contrast to…

--

tcp: Add TCP ROCCET congestion control module.

This adds a new congestion control module derived from CUBIC that replaces
HyStart with its own slow start (LAUNCH), adds srRTT and ACK-rate based
congestion events in congestion avoidance (ORBITER), and performs periodic
minimum RTT probing. The module implements .cong_control, so it owns the
congestion window on every ACK.

References given in the commit message:
[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://doi.org/10.1109/WMNC.2016.7543932
[3] https://doi.org/10.23919/WONS68803.2026.11501781
[4] http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 301b47660305..3545fb0a045b 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -663,6 +663,18 @@ config TCP_CONG_CDG
>  	    delay gradients." In Networking 2011. Preprint:
>  	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-preprint.pdf
>  
> +config TCP_CONG_ROCCET
> +	tristate "ROCCET TCP"
> +	default n

[ ... ]

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 000000000000..db26fce0c00e
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1278 @@

[ ... ]

> + * CUBIC integrates a new slow start algorithm, called HyStart.
> + * The details of HyStart are presented in
> + *  Sangtae Ha and Injong Rhee,
> + *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
> + * Available from:
> + *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
> + *
> + * All testing results are available from:
> + * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
> + *
> + * Unless CUBIC is enabled and congestion window is large
> + * this behaves the same as the original Reno.
> + */

[Severity: Low]
This isn't a bug, but these two paragraphs look like leftover CUBIC
boilerplate that does not describe this module.

The commit message says ROCCET deliberately does not use HyStart, and
there is no HyStart code in the file (no hystart fields, no ack-train or
delay detection, no round tracking), yet the header tells the reader that
"CUBIC integrates a new slow start algorithm, called HyStart".

Likewise, what does "Unless CUBIC is enabled and congestion window is
large this behaves the same as the original Reno" refer to here?  There
is no CUBIC enable switch in this file, and TCP_CONG_ROCCET has no
dependency on TCP_CONG_CUBIC.

[ ... ]

> +	u32 curr_rtt;	/* last sample rtt of current round */

[ ... ]

> +	u32 last_rtt;	/* sample rtt of previous round.
> +			 * Used for jitter calculation
> +			 */

[Severity: Low]
Are these really per-round values?  The only writer is roccet_acked(),
which updates both on every accepted sample:

	if (sample->rtt_us > 0) {
		ca->last_rtt = ca->curr_rtt;
		ca->curr_rtt = sample->rtt_us;
	}

In tcp_cubic.c these fields are per-round only because
bictcp_hystart_reset()/hystart_round() reset them at round boundaries,
and HyStart was dropped here.  The jitter that feeds roccet_xj in
roccet_orbiter_update() is therefore a per-ACK delta, not a per-round
one, which the comments could say.

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

[Severity: Low]
Should these two writable parameters get the same bounds checking that
beta and bic_scale received?

In roccet_orbiter_update() the value is added into a u32:

	roccet_xj = div_u64((u64)jitter * 100, ca->curr_min_rtt) +
			sr_rtt_upper_bound;

so a value close to U32_MAX wraps the sum to a small number and
ca->curr_srrtt > roccet_xj becomes true on every evaluation, cutting
cwnd repeatedly on all ROCCET sockets.

For ack_rate_diff_ss, get_ack_rate_diff() never returns a negative
value, so a negative setting makes

	get_ack_rate_diff(ca) <= ack_rate_diff_ss

permanently false in roccet_launch_update() and silently disables the
srRTT based LAUNCH exit.

[ ... ]

> +/* Note parameters that are used for precomputing scale factors are read-only */
> +
> +static int beta_param_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops beta_param_ops = {
> +	.set = beta_param_set,
> +	.get = param_get_int,
> +};
> +module_param_cb(beta, &beta_param_ops, &beta, 0644);

[Severity: Low]
beta is an input to param_precompute(), so does the comment above about
precompute inputs being read-only still hold with mode 0644?

param_precompute() is only called from roccet_register(), and it derives:

	beta_scale =
		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);

After a runtime write, roccet_congestion_event(),
roccet_recalc_ssthresh() and roccet_handle_recovery() use the new beta
for the multiplicative decrease, while bictcp_update() keeps using the
stale beta_scale in its TCP friendliness loop:

	u32 scale = beta_scale;

	delta = (cwnd * scale) >> 3;

Would making beta 0444 like bic_scale, or recomputing the derived values
in the setter, be preferable?

> +MODULE_PARM_DESC(beta, "beta for multiplicative increase");

[Severity: Low]
Is "multiplicative increase" the right description?  beta is used as the
retained-window factor of a multiplicative decrease in
roccet_congestion_event(), roccet_recalc_ssthresh(),
roccet_handle_recovery() and roccet_min_rtt_probe_ce(), all of the form
max((cwnd * beta) / BICTCP_BETA_SCALE, 2U), so a larger beta gives a
gentler reduction.  The wording comes from tcp_cubic.c but is new in
this file.

[ ... ]

> +static int beta_param_set(const char *val, const struct kernel_param *kp)
> +{
> +	int beta_candidate;
> +	int ret = kstrtoint(val, 10, &beta_candidate);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (beta_candidate <= 0 || beta_candidate >= BICTCP_BETA_SCALE) {
> +		pr_err_once("TCP ROCCET: beta must be between 0 and %d\n",
> +			    BICTCP_BETA_SCALE);
> +
> +		return -EINVAL;
> +	}
> +
> +	return param_set_int(val, kp);
> +}

[Severity: Low]
Can the validated value differ from the stored value here?  The check
parses with base 10, but param_set_int() is generated by
STANDARD_PARAM_DEF(int, int, "%i", kstrtoint) in kernel/params.c and
parses with base 0:

	return strtolfn(val, 0, (type *)kp->arg);

So "01000" is validated as 1000 but stored as 512, "01777" is rejected
even though the standard setter would store the legal value 1023, and
"0x2c0" is rejected outright.  Parsing once with base 0 and storing the
validated candidate would keep the two consistent.

[ ... ]

> +	rrtt = div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
> +		       ca->curr_min_rtt);
> +
> +	/* (1 - alpha) * srRTT + alpha * rRTT */
> +	ca->curr_srrtt = ((100 - ROCCET_ALPHA_TIMES_100) * (u64)ca->curr_srrtt +
> +			  ROCCET_ALPHA_TIMES_100 * rrtt) /
> +			 100;
> +}

[Severity: Medium]
The EWMA is computed in u64 but stored into the u32 ca->curr_srrtt with
no clamp.  curr_min_rtt is only floored at 1 us, while curr_rtt is an
unclamped sample->rtt_us, so for very large ratios the assignment
truncates and an inflated RTT can end up producing a small srRTT,
making the ca->curr_srrtt > roccet_xj test stop reflecting queueing
delay.  Would clamping rrtt (or curr_srrtt) help here?

Related, in roccet_orbiter_update() and roccet_handle_state_transitions():

	ca->next_srrtt_check_ts = now + 5 * ca->curr_rtt;

is 32-bit arithmetic, and roccet_reset() leaves curr_rtt == U32_MAX.  On
the first entry to ORBITER before any sample has been accepted the
product is -5 modulo 2^32, so the deadline is 5 us in the past and
evaluate_srrtt becomes true on every ACK (also resetting the sent and
received interval every ACK) instead of once per 5 RTTs.

[ ... ]

> +	if (ca->state == LAUNCH) {
> +		/* Set ssthresh on ECN, so that roccet is not in slow-start */
> +		tp->snd_ssthresh = tcp_snd_cwnd(tp);
> +		ca->state = ORBITER;

[Severity: Low]
Should this store use WRITE_ONCE()?  tp->snd_ssthresh has lockless
readers, for example in net/ipv4/tcp.c:

	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, READ_ONCE(tp->snd_ssthresh));

which is why tcp_cubic.c, tcp_enter_loss() and
tcp_non_congestion_loss_retransmit() annotate the store.  The same plain
store appears in roccet_launch_update() on the LAUNCH exit path, while
roccet_init() in this patch already uses
WRITE_ONCE(tcp_sk(sk)->snd_ssthresh, initial_ssthresh).

[ ... ]

> +	if (!ca->rtt_probe_timers_set)
> +		pr_warn_once("ROCCET: Probing time should be set");
> +	else if (time_before32(now, ca->probe_min_rtt_until))
> +		/* No state change if we are in the probing interval. */
> +		return;

[ ... ]

> +static void roccet_rtt_probe_refill(struct roccettcp *ca, u32 now)
> +{
> +	/* Once the refill interval is over, we can end the probing phase. */
> +	if (time_after32(now, ca->refill_until)) {
> +		/* End min RTT probing phase. */
> +		ca->state = ORBITER;
> +	}
> +}

[Severity: High]
Does ca->epoch_start have to be reset when the probing phase ends?
roccet_enter_min_rtt_probe() drops cwnd to cwnd/2 or cwnd/3 and the
RTT_PROBE/RTT_PROBE_REFILL states hold it there for at least
2 * max(200 ms, ca->curr_rtt), but nothing on this path clears
ca->epoch_start the way roccet_congestion_event() and
roccet_recalc_ssthresh() do on every other cwnd reduction.

So when ORBITER resumes, bictcp_update() skips the epoch
initialisation and computes

	t = (s32)(tcp_jiffies32 - ca->epoch_start);

with an epoch_start that predates the probe, while ca->bic_K and
ca->bic_origin_point still describe the pre-probe epoch.  t has jumped
by the whole probe plus refill interval, so delta = c/rtt * (t-K)^3 is
large, bic_target ends up far above the cwnd that
roccet_min_rtt_probe() just restored, and

	ca->cnt = cwnd / (bic_target - cwnd);

falls to the floor of 2, i.e. one packet per two ACKs, the fastest
growth this function allows.  That is the opposite of the careful
refill the commit message describes, and it happens every 5 seconds
because ROCCET_NEXT_MIN_RTT_PROBE schedules probing that often.

roccet_cwnd_event_tx_start() already shifts ca->epoch_start forward for
idle periods for exactly this reason.  Should the probe exit here zero
epoch_start, so K and the origin are recomputed for the restored
window, or shift it by the probe duration like the idle path does?

[Severity: Medium]
Can the probe states get stuck here?  time_before32()/time_after32()
only order deltas below 2^31 us (about 35.8 minutes), and now is
jiffies_to_usecs(tcp_jiffies32), a u32 microsecond counter.

If the application goes idle just after roccet_enter_min_rtt_probe()
reduced cwnd to cwnd/2 or cwnd/3 and resumes roughly 40 minutes later,
the delta lands in the wrap window, so:

	else if (time_before32(now, ca->probe_min_rtt_until))
		return;

reports "still probing" again, cwnd is never restored from
cwnd_before_min_rtt_probe, and RTT_PROBE has no growth path.
roccet_handle_state_transitions() cannot clear the timers because its
reset branch only runs once the state has already left the probe
states.  The same applies to the single exit condition in
roccet_rtt_probe_refill(), where cwnd likewise never grows.

The in-code claim that "Wrap-arounds of these values are handled by the
relevant if-conditions" in roccet_enter_min_rtt_probe() seems to assume
deltas always stay below 2^31 us.

[ ... ]

> +		tp->snd_ssthresh = tcp_snd_cwnd(tp);
> +		ca->roccet_last_event_time_us = now;
> +		ca->last_event_time_set = true;
> +		ca->state = ORBITER;
> +		return;
> +	}
> +
> +	/* If not already exiting LAUNCH, grow cwnd similar to slow-start */
> +	acked = tcp_slow_start(tp, acked);
> +	/* If cwnd hits ssthresh, go to ORBITER and if any ACKs are
> +	 * leftover save them for ORBITER.
> +	 * Check via tcp_in_slow_start() in case no ACKs are left.
> +	 */
> +	if (!tcp_in_slow_start(tp)) {
> +		ca->state = ORBITER;
> +		ca->epoch_start = 0;
> +		ca->ack_carry_over = acked;
> +	}
> +}

[Severity: Medium]
Can tcp_slow_start() be called here with cwnd already above ssthresh?
The tcp_in_slow_start() test runs only after the call, and
tcp_slow_start() in net/ipv4/tcp_cong.c assumes cwnd <= ssthresh:

	u32 cwnd = min(tcp_snd_cwnd(tp) + acked, tp->snd_ssthresh);

	acked -= cwnd - tcp_snd_cwnd(tp);
	tcp_snd_cwnd_set(tp, min(cwnd, tp->snd_cwnd_clamp));

With cwnd > ssthresh the subtraction has the opposite sign, so cwnd is
pulled down to ssthresh and acked grows by (old_cwnd - ssthresh).  That
inflated value is then stored in ca->ack_carry_over and later handed to
tcp_cong_avoid_ai() in ORBITER, which with ca->cnt as low as 2 can add
tens of packets to cwnd in one ACK.

The precondition looks reachable: tcp_reinit_congestion_control() keeps
cwnd and ssthresh when a connection switches to ROCCET via
setsockopt(TCP_CONGESTION), and roccet_reset() always starts in LAUNCH,
where a connection in congestion avoidance normally has cwnd > ssthresh.
An initial_ssthresh below the current cwnd gives the same situation.  On
the first ACK the LAUNCH exit conditions are false (curr_srrtt is 0 and
initial_limit_reached is false), so the helper does run.  Would testing
tcp_in_slow_start() before the call avoid this?

[ ... ]

> +	/* Enter DRAIN when roccet was recently triggered */
> +	if (ca->last_event_time_set &&
> +	    time_before32(now, ca->roccet_last_event_time_us +
> +			  100 * USEC_PER_MSEC)) {
> +		ca->state = DRAIN;
> +		return;
> +	}

[Severity: High]
Can ORBITER and DRAIN alternate forever once the recorded event
timestamp gets old?  With E = ca->roccet_last_event_time_us, N = now and
d = (u32)(N - E), this check expands to (s32)(d - 100000) < 0, which is
true again for every d in [2^31 + 100000, 2^32), so ORBITER sets DRAIN
and returns before bictcp_update()/tcp_cong_avoid_ai().

roccet_drain_update() then leaves DRAIN immediately for the same d:

	if (!time_between32(now, ca->roccet_last_event_time_us
				- 100 * USEC_PER_MSEC,
				ca->roccet_last_event_time_us
				+ 100 * USEC_PER_MSEC)) {

expands to 200000 >= (u32)(d + 100000), which is false there.

Neither handler refreshes E, so for the remainder of the ~35.8 minute
wrap window the connection ping-pongs between the two states with no
cwnd growth, and min RTT probing is skipped too because this DRAIN check
precedes the next_min_rtt_probe check.  E is only written by
roccet_congestion_event() and the LAUNCH exit, so a long-lived transfer
on a clean path (no ECN, no detected bufferbloat) reaches this simply by
running about 36 minutes.  The changelog lists "Fix DRAIN-state stuck due
to idle-periods & wrap arounds"; is this case covered?

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

[Severity: High]
Does this remove the multiplicative decrease on retransmission timeout?
tcp_enter_loss() stores this return value:

	WRITE_ONCE(tp->snd_ssthresh, icsk->icsk_ca_ops->ssthresh(sk));
	...
	tcp_set_ca_state(sk, TCP_CA_Loss);

so on an RTO taken in LAUNCH, ssthresh becomes exactly the window that
timed out.  roccet_state() then calls roccet_reset(), which sets
ca->state = LAUNCH again and wipes min RTT, Wmax and the ACK-rate
history, and sets cwnd to 1.  The flow slow-starts straight back to the
window that caused the timeout, and because the reset returns to LAUNCH,
a further timeout during that ramp again yields ssthresh == cwnd.

The fast recovery side is symmetric in roccet_handle_recovery():

	if (ca->state == LAUNCH) {
		ca->state = ORBITER;
		return cwnd;
	}

Since .cong_control is implemented, tcp_cong_control() returns before
tcp_cwnd_reduction()/PRR, so the core supplies no compensating backoff
and rs->losses is never consulted in roccet_control().  Could the commit
message explain the intended behaviour on repeated timeouts?

[ ... ]

> +	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
> +	if (ca->state == LAUNCH) {
> +		ca->state = ORBITER;
> +		return cwnd;
> +	}
> +
> +	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +}

[Severity: High]
Plain loss reduces cwnd once here, but does anything keep the state
machine from growing the window again while retransmissions are still
outstanding?

Unlike the TCP_CA_CWR branch, which goes through
roccet_congestion_event() and forces a 100 ms DRAIN, this path does not
set ca->roccet_last_event_time_us/last_event_time_set and leaves the
state at ORBITER.  roccet_control() does not look at icsk_ca_state:

	switch (ca->state) {
	case LAUNCH:
		roccet_launch_update(sk, rs->acked_sacked);
		break;
	case ORBITER:
		roccet_orbiter_update(sk, rs->acked_sacked);

so the next ACK runs roccet_orbiter_update(), which with no recent event
recorded, sent_more_than_acked false (in-flight shrinking) and
tcp_is_cwnd_limited() true calls bictcp_update() and
tcp_cong_avoid_ai().  If next_min_rtt_probe has expired it can instead
enter RTT_PROBE_ENTER during active recovery and halve the
already-reduced window.

Because .cong_control is provided, tcp_cong_control() returns before
tcp_cwnd_reduction() and tcp_end_cwnd_reduction(), so PRR is not
holding the window down either.  Compare bbr_set_cwnd(), which handles
recovery explicitly via bbr_set_cwnd_to_recover_or_restore().

[ ... ]

> +	if (new_state == TCP_CA_Loss) {
> +		roccet_reset(sk, ca);
> +		tcp_snd_cwnd_set(tp, 1);

[Severity: Medium]
Should every TCP_CA_Loss entry be treated as a full algorithm restart?
TCP_CA_Loss is also entered for reasons that are explicitly not
congestion: tcp_v4_mtu_reduced()/tcp_v6_mtu_reduced() on ICMP
fragmentation-needed call tcp_simple_retransmit(), which ends in
tcp_non_congestion_loss_retransmit():

	if (icsk->icsk_ca_state != TCP_CA_Loss) {
		tp->high_seq = tp->snd_nxt;
		WRITE_ONCE(tp->snd_ssthresh, tcp_current_ssthresh(sk));
		...
		tcp_set_ca_state(sk, TCP_CA_Loss);
	}

whose comment says it retransmits without reducing cwnd, and
tcp_set_ca_state() always invokes .set_state.  Here that collapses cwnd
to one segment and discards curr_min_rtt, delay_min, last_max_cwnd and
the ACK-rate history, where CUBIC loses nothing.  Failed TFO and SACK
reneging reach the same branch.

> +	} else if (new_state == TCP_CA_CWR) {
> +		/* Handle CWR as ROCCET congestion event,
> +		 * however afterwards always set Wmax to the current cwnd.
> +		 */
> +		cwnd = tcp_snd_cwnd(tp);
> +		roccet_congestion_event(sk, now);
> +		ca->last_max_cwnd = cwnd;
> +	} else if (new_state == TCP_CA_Recovery) {
> +		/* Directly reduce cwnd and rely on pacing */
> +		cwnd = roccet_handle_recovery(sk);
> +		tcp_snd_cwnd_set(tp, cwnd);
> +	}

[Severity: High]
Should this branch look at ca->state before recording Wmax?  In
RTT_PROBE the live window is the deliberately reduced probe window that
roccet_enter_min_rtt_probe() installed (tcp_snd_cwnd(tp)/2 or /3), and
roccet_congestion_event() takes its early RTT_PROBE return, so the only
lasting effect of a CWR taken during probing is
ca->last_max_cwnd = cwnd, which replaces the recorded capacity with the
drain window.

The rest of the file is careful here: roccet_recalc_ssthresh()
substitutes ca->cwnd_before_min_rtt_probe "to not undershoot", and
roccet_min_rtt_probe_ce() applies beta to that stored value rather than
to the probing cwnd.  This is the one place that uses tcp_snd_cwnd(tp)
unconditionally.

The consequence outlives the probe.  roccet_min_rtt_probe() restores
ca->cwnd_before_min_rtt_probe, which after a beta reduction is still
larger than the probe window now stored in last_max_cwnd, so the next
bictcp_update() takes the ca->last_max_cwnd <= cwnd branch, sets
bic_K = 0 and re-anchors bic_origin_point at the current cwnd.  The
pre-probe capacity estimate is gone and growth is convex from the
restored window instead of concave towards Wmax.

Would skipping the last_max_cwnd assignment in the probe states, or
using ca->cwnd_before_min_rtt_probe there as the other paths do, be the
intended behaviour?

[Severity: Medium]
Can a CWR to Recovery transition apply beta twice in the same recovery
window?  tcp_enter_cwr() reduces cwnd through roccet_congestion_event()
(cwnd -> cwnd*beta/1024, ORBITER -> DRAIN).  If loss is then detected
before high_seq is acknowledged, tcp_enter_recovery() skips the core
bookkeeping but still switches the CC state:

	if (!tcp_in_cwnd_reduction(sk)) {
		if (!ece_ack)
			tp->prior_ssthresh = tcp_current_ssthresh(sk);
		tcp_init_cwnd_reduction(sk);
	}
	tcp_set_ca_state(sk, TCP_CA_Recovery);

roccet_handle_recovery() has no check for the previous TCP congestion
state, so DRAIN falls through to the beta reduction: with the default
beta, cwnd 100 becomes 70 on CWR and 49 on Recovery while ssthresh stays
at 70.

[ ... ]

> +	/* Some calls are for duplicates without timestamps */
> +	if (sample->rtt_us < 0)
> +		return;
> +
> +	/* Discard delay samples right after fast recovery */
> +	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
> +		return;

[Severity: Medium]
These early returns leave ca->curr_rtt unchanged, but roccet_control()
recomputes the RTT metrics anyway whenever packets were delivered:

	if (rs->acked_sacked > 0) {
		update_min_rtt(ca);
		update_srrtt(ca);
	}

so the same stale curr_rtt is fed repeatedly into the srRTT EWMA and
into min RTT tracking.  roccet_cwnd_event_tx_start() keeps advancing
ca->epoch_start on every idle restart, so a bursty sender can keep the
epoch young and have its samples discarded for long stretches.

Around probing this looks more damaging: roccet_enter_min_rtt_probe()
resets curr_min_rtt to U32_MAX but keeps curr_rtt, so the first delivery
with a suppressed sample reinstalls the pre-probe RTT as the new minimum
via update_min_rtt() and reschedules next_min_rtt_probe as if the probe
had succeeded, while a genuinely higher minimum can never be adopted
because update_min_rtt() only lowers the value.  Would gating the
metric update on a freshly accepted sample fix this?

[ ... ]

> + * Custom Pacing Rate for ROCCET TCP.
> + * The code here is similar to the pacing rate adjustments in tcp_input.c
> + * tcp_cong_control(). In LAUNCH (slow start) we want a pacing of 200% and
> + * in ORBITER (congestion avoidance) we adjust the pacing to 100% and do not
> + * use the sysctl_tcp_pacing_ca_ratio.
> + */
> +static void roccet_update_pacing_rate(struct sock *sk)

[ ... ]

> +	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)
> +		rate *= READ_ONCE
> +			(sock_net(sk)->ipv4.sysctl_tcp_pacing_ss_ratio);

[Severity: Medium]
The comment describes pacing selected by the ROCCET state (200% in
LAUNCH, 100% in ORBITER), but the body never reads inet_csk_ca(sk) or
ca->state.  It keys off cwnd versus ssthresh/2 as copied from
tcp_update_pacing_rate() and multiplies by the tunable
sysctl_tcp_pacing_ss_ratio rather than a fixed 200%.

The two selectors diverge in states created by this patch: after
roccet_state(TCP_CA_Loss) sets cwnd to 1, and after
roccet_enter_min_rtt_probe() sets cwnd to cwnd/2 or cwnd/3 while
snd_ssthresh keeps its larger value, cwnd < ssthresh/2 holds, so the
slow-start ratio (200% by default) is applied precisely in the states
where the intent is to drain the bottleneck buffer.  Which of the two
descriptions is the intended behaviour?

[ ... ]

> @@ -0,0 +1,1278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
> + * Extension for 5G and Beyond Networks
> + *
> + * TCP ROCCET is a new TCP congestion control
> + * algorithm suited for current cellular 5G NR beyond networks.
> + * It extends the kernel default congestion control CUBIC
> + * and improves its performance, and additionally solves an
> + * unwanted side effects of CUBIC’s implementation.
> + * ROCCET uses its own Slow Start, called LAUNCH, where loss
> + * is not considered as a congestion event.
> + * The congestion avoidance phase, called ORBITER, uses
> + * CUBIC's window growth function and adds, based on RTT
> + * and ACK rate, congestion events.
> + *
> + * A peer-reviewed paper on TCP ROCCET will be presented
> + * at the WONS 2026 conference.
> + * A draft of the paper is available here:
> + *		https://arxiv.org/abs/2510.25281
> + *
> + *
> + * Further information about CUBIC:
> + * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
> + * Home page:
> + *	http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
> + * This is from the implementation of CUBIC TCP in
> + * Sangtae Ha, Injong Rhee and Lisong Xu,
> + *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
> + *  in ACM SIGOPS Operating System Review, July 2008.
> + * Available from:
> + *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
> + *
> + * CUBIC integrates a new slow start algorithm, called HyStart.
> + * The details of HyStart are presented in
> + *  Sangtae Ha and Injong Rhee,
> + *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
> + * Available from:
> + *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
> + *
> + * All testing results are available from:
> + * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
> + *
> + * Unless CUBIC is enabled and congestion window is large
> + * this behaves the same as the original Reno.
> + */
> +
> +#include <linux/time.h>
> +#include <linux/printk.h>
> +#include <linux/math64.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <net/tcp.h>
> +
> +/* Scale factor beta calculation (max_cwnd = snd_cwnd * beta) */
> +#define BICTCP_BETA_SCALE 1024
> +
> +#define BICTCP_HZ 10 /* BIC HZ 2^10 = 1024 */
> +
> +/* Alpha value for the srRTT  multiplied by 100.
> + * Here 20 represents a value of 0.2
> + */
> +#define ROCCET_ALPHA_TIMES_100 20
> +
> +/* min RTT probe period in ms */
> +#define ROCCET_NEXT_MIN_RTT_PROBE 5000
> +
> +/* State in which roccet currently operates */
> +enum roccet_state {
> +	LAUNCH,
> +	ORBITER,
> +	RTT_PROBE_ENTER,
> +	RTT_PROBE,
> +	RTT_PROBE_REFILL,
> +	DRAIN
> +};
> +
> +/* TCP ROCCET struct based on the original BICTCP struct with
> + * additions specific to the ROCCET-Algorithm.
> + */
> +struct roccettcp {
> +	u32 cnt;	/* increase cwnd by 1 after ACKs */
> +	u32 last_max_cwnd;	/* last maximum snd_cwnd */
> +	u32 last_cwnd;	/* the last snd_cwnd */
> +	u32 last_time;	/* time when updated last_cwnd */
> +	u32 bic_origin_point;	/* origin point of bic function */
> +	u32 bic_K;	/* time to origin point from the
> +			 * beginning of the current epoch
> +			 */
> +	u32 delay_min;	/* min delay (usec) */
> +	u32 epoch_start;	/* beginning of an epoch */
> +	u32 ack_cnt;	/* number of acks */
> +	u32 tcp_cwnd;	/* estimated tcp cwnd */
> +	u32 curr_rtt;	/* last sample rtt of current round */
> +
> +	u32 roccet_last_event_time_us;	/* The last time ROCCET was triggered */
> +	u32 curr_min_rtt;	/* The current observed minRTT */
> +	u32 next_min_rtt_probe;	/* Next time to probe the minRTT */
> +	u32 probe_min_rtt_until;	/* End of minRTT probing period.
> +					 * Set while in RTT_PROBE states
> +					 */
> +	u32 refill_until;	/* End of pipe refill after minRTT probe.
> +				 * Set while in RTT_PROBE states
> +				 */
> +	u32 cwnd_before_min_rtt_probe;	/* cwnd before min RTT probing. */
> +	u32 curr_srrtt;	/* srRTT calculated based on the latest ACK */
> +	u32 next_srrtt_check_ts;	/* Next check for srRTT */
> +	u32 last_rtt;	/* sample rtt of previous round.
> +			 * Used for jitter calculation
> +			 */
> +
> +	u32 interval_snd_seq_start;
> +	u32 interval_una_seq_start;
> +
> +	u32 ack_carry_over;	/* Used to carry over leftover acks from
> +				 * LAUNCH to ORBITER
> +				 */
> +
> +	u32 ack_rate_last_rate_time;	/* Timestamp of the last ACK-rate */
> +	u16 ack_rate_last_rate;	/* Last ACK-rate */
> +	u16 ack_rate_curr_rate;	/* Current ACK-rate */
> +	u16 ack_rate_cnt;	/* Used for counting acks */
> +
> +	enum roccet_state state : 3; /* Current operating state of roccet */
> +	bool was_idle : 1;	/* Tracks whether the connection was idle
> +				 * (had no in-flight packets)
> +				 */
> +	bool initial_limit_reached: 1;	/* Set to true after the connection
> +					 * initially gets cwnd-limited
> +					 */
> +	bool is_in_initial_launch: 1;	/* true if the connection is in
> +					 * the initial launch phase.
> +					 */
> +	bool last_event_time_set: 1;	/* true if the last event time
> +					 * has been set/initialized.
> +					 */
> +	bool rtt_probe_timers_set: 1;	/* true if refill_until and
> +					 * probe_min_rtt_until are currently
> +					 * set.
> +					 */
> +};
> +
> +/* Parameters that are specific to the ROCCET-Algorithm */
> +static uint sr_rtt_upper_bound __read_mostly = 100;
> +static int ack_rate_diff_ss __read_mostly = 10;
> +
> +module_param(sr_rtt_upper_bound, uint, 0644);
> +MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
> +module_param(ack_rate_diff_ss, int, 0644);
> +MODULE_PARM_DESC(ack_rate_diff_ss,
> +		 "ROCCET's threshold to exit slow start if ACK-rate differs by given amount of segments.");
> +
> +static int fast_convergence __read_mostly = 1;
> +static int beta __read_mostly = 717; /* = 717/1024 (BICTCP_BETA_SCALE) */
> +static int initial_ssthresh __read_mostly;
> +static int bic_scale __read_mostly = 41;
> +static int tcp_friendliness __read_mostly = 1;
> +
> +static u32 cube_rtt_scale __read_mostly;
> +static u32 beta_scale __read_mostly;
> +static u64 cube_factor __read_mostly;
> +
> +/* Note parameters that are used for precomputing scale factors are read-only */
> +
> +static int beta_param_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops beta_param_ops = {
> +	.set = beta_param_set,
> +	.get = param_get_int,
> +};
> +module_param_cb(beta, &beta_param_ops, &beta, 0644);
> +MODULE_PARM_DESC(beta, "beta for multiplicative increase");
> +
> +module_param(fast_convergence, int, 0644);
> +MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
> +module_param(initial_ssthresh, int, 0644);
> +MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold");
> +module_param(bic_scale, int, 0444);
> +MODULE_PARM_DESC(bic_scale,
> +		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
> +module_param(tcp_friendliness, int, 0644);
> +MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
> +
> +/* Check & set the new beta parameter candidate value.
> + */
> +static int beta_param_set(const char *val, const struct kernel_param *kp)
> +{
> +	int beta_candidate;
> +	int ret = kstrtoint(val, 10, &beta_candidate);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (beta_candidate <= 0 || beta_candidate >= BICTCP_BETA_SCALE) {
> +		pr_err_once("TCP ROCCET: beta must be between 0 and %d\n",
> +			    BICTCP_BETA_SCALE);
> +
> +		return -EINVAL;
> +	}
> +
> +	return param_set_int(val, kp);
> +}
> +
> +/* Used to check certain roccet parameters used in `param_precompute` in order
> + * to avoid invalid scale-related calculations. This validates the specified
> + * parameters or rejects them.
> + */
> +static int param_check(void)
> +{
> +	if (beta <= 0 || beta >= BICTCP_BETA_SCALE) {
> +		pr_err_once("TCP ROCCET: beta must be between 0 and %d\n",
> +			    BICTCP_BETA_SCALE);
> +
> +		return -EINVAL;
> +	}
> +
> +	if (bic_scale <= 0) {
> +		pr_err_once("TCP ROCCET: bic_scale must be positive\n");
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Precompute some values based on the provided params.
> + * These are only precomputed during module initialization and are not updated
> + * during runtime. Parameter changes at runtime will only affect the next uses
> + * of the parameters, but not the precomputed values.
> + */
> +static void param_precompute(void)
> +{
> +	/* Precompute a bunch of the scaling factors that are used per-packet
> +	 * based on sRTT of 100ms.
> +	 */
> +	beta_scale =
> +		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
> +
> +	cube_rtt_scale = (bic_scale * 10); /* 1024*c/rtt */
> +
> +	/* calculate the "K" for (wmax-cwnd) = c/rtt * K^3
> +	 *  so K = cubic_root( (wmax-cwnd)*rtt/c )
> +	 * the unit of K is bictcp_HZ=2^10, not HZ
> +	 *
> +	 *  c = bic_scale >> 10
> +	 *  rtt = 100ms
> +	 *
> +	 * the following code has been designed and tested for
> +	 * cwnd < 1 million packets
> +	 * RTT < 100 seconds
> +	 * HZ < 1,000,00  (corresponding to 10 nano-second)
> +	 */
> +
> +	/* 1/c * 2^2*bictcp_HZ * srtt */
> +	cube_factor = 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
> +
> +	/* divide by bic_scale and by constant srtt (100ms) */
> +	do_div(cube_factor, bic_scale * 10);
> +}
> +
> +static void roccet_reset(struct sock *sk, struct roccettcp *ca)
> +{
> +	memset(ca, 0, sizeof(struct roccettcp));
> +	ca->next_srrtt_check_ts = 0;
> +
> +	/* Initialize all RTT values to U32_MAX, so that any lower samples
> +	 * will be accepted.
> +	 */
> +	ca->curr_min_rtt = U32_MAX;
> +	ca->curr_rtt = U32_MAX;
> +	ca->last_rtt = U32_MAX;
> +
> +	ca->roccet_last_event_time_us = 0;
> +	ca->last_event_time_set = false;
> +	ca->ack_rate_last_rate = 0;
> +
> +	/* Initialize to current time to avoid an
> +	 * overflow in the ack rate calculation
> +	 */
> +	ca->ack_rate_last_rate_time = jiffies_to_usecs(tcp_jiffies32);
> +	ca->ack_rate_curr_rate = 0;
> +	ca->ack_rate_cnt = 0;
> +
> +	ca->interval_snd_seq_start = tcp_sk(sk)->snd_nxt;
> +	ca->interval_una_seq_start = tcp_sk(sk)->snd_una;
> +
> +	/* Start state is LAUNCH */
> +	ca->state = LAUNCH;
> +	ca->probe_min_rtt_until = 0;
> +	ca->refill_until = 0;
> +	ca->rtt_probe_timers_set = false;
> +
> +	ca->initial_limit_reached = false;
> +	ca->is_in_initial_launch = false;
> +}
> +
> +static void roccet_init(struct sock *sk)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	roccet_reset(sk, ca);
> +
> +	/* Reset here, so it is only set during init */
> +	ca->is_in_initial_launch = true;
> +
> +	if (initial_ssthresh)
> +		WRITE_ONCE(tcp_sk(sk)->snd_ssthresh, initial_ssthresh);
> +
> +	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
> +}
> +
> +static void update_min_rtt(struct roccettcp *ca)
> +{
> +	/* Check if new lower min RTT was found. If so, set it directly.
> +	 * If no valid RTT sample has been received yet, the check will fail,
> +	 * since the rtt values are initialized to U32_MAX.
> +	 */
> +	if (ca->curr_rtt < ca->curr_min_rtt) {
> +		ca->curr_min_rtt = max(ca->curr_rtt, 1);
> +		/* Probe for the min RTT in ROCCET_NEXT_MIN_RTT_PROBE ms
> +		 * if no other update occurs.
> +		 */
> +		ca->next_min_rtt_probe =
> +			jiffies_to_usecs(tcp_jiffies32) +
> +			ROCCET_NEXT_MIN_RTT_PROBE * USEC_PER_MSEC;
> +	}
> +}
> +
> +/* Return difference between last and current ack rate.
> + */
> +static s32 get_ack_rate_diff(struct roccettcp *ca)
> +{
> +	if (ca->ack_rate_curr_rate < ca->ack_rate_last_rate)
> +		return 0;
> +	return (s32)(ca->ack_rate_curr_rate - ca->ack_rate_last_rate);
> +}
> +
> +/* Update ack rate sampled by 100ms.
> + */
> +static void update_ack_rate(struct roccettcp *ca, u32 acked, u32 now)
> +{
> +	const s32 idle_threshold = USEC_PER_SEC * 2;
> +	const s32 interval = USEC_PER_MSEC * 100;
> +
> +	s32 time_delta = (s32)(ca->ack_rate_last_rate_time - now);
> +
> +	/* Check if the time has arrived in the new interval.
> +	 * Alternatively if the connection was considered to be idle,
> +	 * also treat as a new interval in order to avoid timing-overflow
> +	 * problems.
> +	 */
> +	if (time_delta < -interval || ca->was_idle) {
> +		/* Check if the connection was idle for X seconds
> +		 * (e.g. no ACK for X seconds)
> +		 */
> +		if (time_delta < -idle_threshold) {
> +			/* Reset ack counting as if a new
> +			 * connection was created
> +			 */
> +			ca->ack_rate_last_rate = 0;
> +			ca->ack_rate_last_rate_time =
> +				jiffies_to_usecs(tcp_jiffies32);
> +			ca->ack_rate_curr_rate = 0;
> +			ca->ack_rate_cnt = 0;
> +		} else {
> +			/* start counting for the new interval */
> +			ca->ack_rate_last_rate_time = now;
> +			ca->ack_rate_last_rate = ca->ack_rate_curr_rate;
> +			ca->ack_rate_curr_rate = ca->ack_rate_cnt;
> +			ca->ack_rate_cnt = min_t(u32, acked, U16_MAX);
> +		}
> +
> +		ca->was_idle = false;
> +	} else {
> +		/* Cap the ack count to avoid overflow */
> +		ca->ack_rate_cnt = min_t(u32, ca->ack_rate_cnt + acked,
> +					 U16_MAX);
> +	}
> +}
> +
> +/* Compute srRTT.
> + */
> +static void update_srrtt(struct roccettcp *ca)
> +{
> +	u64 rrtt;
> +
> +	/* Avoid integer overflow in the calculation below.
> +	 * This could occur in cases where we have not yet
> +	 * received an RTT sample after a min_rtt reset.
> +	 * In these cases, set the rtt to a safe value.
> +	 */
> +	if (ca->curr_rtt < ca->curr_min_rtt) {
> +		ca->curr_rtt = max(ca->curr_rtt, 1);
> +		ca->curr_min_rtt = ca->curr_rtt;
> +	}
> +
> +	/* ca->curr_min_rtt can never be 0. For completeness, we check for this
> +	 * anyways in order to avoid division by zero errors.
> +	 */
> +	if (ca->curr_min_rtt == 0) {
> +		pr_err_once("TCP ROCCET: Recorded curr_min_rtt is 0");
> +		return; /* skip srRTT update */
> +	}
> +
> +	/* Calculate the new rRTT (Scaled by 100).
> +	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
> +	 *
> +	 * curr_min_rtt is always <= than curr_rtt,
> +	 * since this is the minimum of the rtt.
> +	 *
> +	 * 0 is a valid value for rrtt.
> +	 *
> +	 * If we have no valid RTT sample yet, curr_rtt and curr_min_rtt will
> +	 * be U32_MAX. This ultimately results in no srrtt increase, which
> +	 * is ok.
> +	 */
> +	rrtt = div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
> +		       ca->curr_min_rtt);
> +
> +	/* (1 - alpha) * srRTT + alpha * rRTT */
> +	ca->curr_srrtt = ((100 - ROCCET_ALPHA_TIMES_100) * (u64)ca->curr_srrtt +
> +			  ROCCET_ALPHA_TIMES_100 * rrtt) /
> +			 100;
> +}
> +
> +/* Handle ROCCET loss/ECN during min RTT probing.
> + */
> +static void roccet_min_rtt_probe_ce(struct roccettcp *ca, u32 cwnd)
> +{
> +	/* This should only be called in RTT_PROBE state */
> +	if (ca->state != RTT_PROBE)
> +		return;
> +
> +	/* If ROCCET is in min RTT probing and a loss/ECN occurs,
> +	 * we use the cwnd before the probing interval to
> +	 * calculate the cwnd reduction and continue probing.
> +	 * After min RTT probing the cwnd is set to the reduced
> +	 * value. During min RTT probing it is very likely that
> +	 * congestion was caused by the cwnd value before min
> +	 * RTT probing.
> +	 */
> +
> +	if (ca->cwnd_before_min_rtt_probe == 0)
> +		pr_warn_once("ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PROBE. This should not happen.");
> +	else
> +		cwnd = ca->cwnd_before_min_rtt_probe;
> +
> +	ca->cwnd_before_min_rtt_probe =
> +		max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +}
> +
> +/* Do a ROCCET congestion event.
> + */
> +static void roccet_congestion_event(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	u32 curr_cwnd = tcp_snd_cwnd(tp);
> +
> +	ca->epoch_start = 0;
> +	ca->roccet_last_event_time_us = now;
> +	ca->last_event_time_set = true;
> +
> +	if (ca->state == RTT_PROBE) {
> +		/* In case we are in RTT_PROBE, continue with this state, as
> +		 * the CE was likely caused by the cwnd before probing.
> +		 * However do react to the CE.
> +		 */
> +		roccet_min_rtt_probe_ce(ca, curr_cwnd);
> +		return;
> +	}
> +
> +	ca->cnt = 100 * curr_cwnd;
> +
> +	/* Set W_max only if the current cwnd is larger */
> +	if (ca->last_max_cwnd < curr_cwnd)
> +		ca->last_max_cwnd = curr_cwnd;
> +
> +	/* Reduce cwnd by beta */
> +	tcp_snd_cwnd_set(tp, min(tp->snd_cwnd_clamp,
> +				 max((curr_cwnd * beta)
> +				     / BICTCP_BETA_SCALE, 2U)));
> +
> +	if (ca->state == LAUNCH) {
> +		/* Set ssthresh on ECN, so that roccet is not in slow-start */
> +		tp->snd_ssthresh = tcp_snd_cwnd(tp);
> +		ca->state = ORBITER;
> +	} else if (ca->state == ORBITER || ca->state == RTT_PROBE_REFILL) {
> +		/* If we are in orbiter or currently refilling the pipe,
> +		 * abort the refill.
> +		 */
> +		ca->state = DRAIN;
> +	}
> +	/* Other states (e.g. DRAIN or RTT_PROBE_ENTER) not handled as
> +	 * we don`t want any action there.
> +	 */
> +}
> +
> +static void roccet_enter_min_rtt_probe(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	u32 interval, probe_cwnd;
> +
> +	/* If probing is already set, there was a mix up.
> +	 * Continue anyway so we can recover.
> +	 */
> +	if (ca->rtt_probe_timers_set)
> +		pr_warn_once("ROCCET: Probing time should not be set when entering RTT Probe");
> +
> +	/* Safeguard for an "infinite" probe. This should logically never
> +	 * happen but still safeguard it.
> +	 */
> +	if (ca->curr_rtt == U32_MAX) {
> +		pr_warn_once("ROCCET: curr_rtt is U32_MAX, cannot enter RTT_PROBE");
> +		ca->state = ORBITER;
> +		return;
> +	}
> +
> +	/* Start min RTT probing */
> +	/* Probe 1*RTT or at least 200ms */
> +	interval = max(200 * USEC_PER_MSEC, ca->curr_rtt);
> +
> +	/* This is to handle deep shared buffers with loss-based
> +	 * congestion control like CUBIC. If the cwnd is not limited
> +	 * by the application but falsely detected (see ROCCET paper),
> +	 * we have to empty the pipe more.
> +	 * If the limit detection is correct this will cause no harm
> +	 * to the tcp flow because the cwnd is not fully utilized and
> +	 * we set the cwnd to its previous value after probing.
> +	 */
> +	if (!tcp_is_cwnd_limited(sk))
> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 3, 1);
> +	else
> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 2, 1);
> +
> +	ca->probe_min_rtt_until = now + interval;
> +	ca->cwnd_before_min_rtt_probe = tcp_snd_cwnd(tp);
> +
> +	/* Half the cwnd to drain the buffer for probing. */
> +	tcp_snd_cwnd_set(tp, probe_cwnd);
> +
> +	/* Reset current min RTT to allow probing for
> +	 * a new lower and higher minimum RTT.
> +	 */
> +	ca->curr_min_rtt = U32_MAX;
> +
> +	/* Refill the pipe after probing.
> +	 * For this we use the previous cwnd for another probing interval.
> +	 */
> +	ca->refill_until = ca->probe_min_rtt_until + interval;
> +	ca->rtt_probe_timers_set = true; /* Now both timers are set. */
> +
> +	/* Now we know that ca->probe_min_rtt_until < ca->refill_until
> +	 * and we advance to the next state of the probing phase.
> +	 *
> +	 * Wrap-arounds of these values are handled by the relevant
> +	 * if-conditions.
> +	 */
> +	ca->state = RTT_PROBE;
> +}
> +
> +/* Do minimum RTT probing.
> + */
> +static void roccet_min_rtt_probe(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	/* Here we are in RTT_PROBE, so the probing time should be set.
> +	 * If not just continue and enter refill phase.
> +	 *
> +	 * probe_min_rtt_until wrap-arounds are handled by the time_before32
> +	 * check.
> +	 */
> +	if (!ca->rtt_probe_timers_set)
> +		pr_warn_once("ROCCET: Probing time should be set");
> +	else if (time_before32(now, ca->probe_min_rtt_until))
> +		/* No state change if we are in the probing interval. */
> +		return;
> +	else if (time_after32(now, ca->refill_until))
> +		/* If the probe_min_rtt_until interval has passed we likely
> +		 * just entered the refill interval, so go into
> +		 * RTT_PROBE_REFILL. If we are not in the refill_until
> +		 * interval, something went wrong and we should quickly exit
> +		 * the probing phase.
> +		 *
> +		 * Wraps-arounds of refill_until are caught by the time_after32
> +		 * check.
> +		 */
> +		pr_warn_once("ROCCET: Skipped refill interval.");
> +
> +	/* Reset cwnd to refill the pipe and consequently clear the stored
> +	 * window.
> +	 * Also perform sanity check. This should never happen.
> +	 */
> +	if (ca->cwnd_before_min_rtt_probe == 0)
> +		pr_warn_once("ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PROBE.");
> +	else
> +		tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
> +
> +	ca->cwnd_before_min_rtt_probe = 0;
> +
> +	/* Exit the RTT_PROBE state */
> +	ca->state = RTT_PROBE_REFILL;
> +}
> +
> +static void roccet_rtt_probe_refill(struct roccettcp *ca, u32 now)
> +{
> +	/* Once the refill interval is over, we can end the probing phase. */
> +	if (time_after32(now, ca->refill_until)) {
> +		/* End min RTT probing phase. */
> +		ca->state = ORBITER;
> +	}
> +}
> +
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
> +
> +	ca->was_idle = true;
> +}
> +
> +/* calculate the cubic root of x using a table lookup followed by one
> + * Newton-Raphson iteration.
> + * Avg err ~= 0.195%
> + */
> +static u32 cubic_root(u64 a)
> +{
> +	u32 x, b, shift;
> +	/* cbrt(x) MSB values for x MSB values in [0..63].
> +	 * Precomputed then refined by hand - Willy Tarreau
> +	 *
> +	 * For x in [0..63],
> +	 *   v = cbrt(x << 18) - 1
> +	 *   cbrt(x) = (v[x] + 10) >> 6
> +	 */
> +	static const u8 v[] = {
> +		/* 0x00 */ 0,	54,  54,  54,  118, 118, 118, 118,
> +		/* 0x08 */ 123, 129, 134, 138, 143, 147, 151, 156,
> +		/* 0x10 */ 157, 161, 164, 168, 170, 173, 176, 179,
> +		/* 0x18 */ 181, 185, 187, 190, 192, 194, 197, 199,
> +		/* 0x20 */ 200, 202, 204, 206, 209, 211, 213, 215,
> +		/* 0x28 */ 217, 219, 221, 222, 224, 225, 227, 229,
> +		/* 0x30 */ 231, 232, 234, 236, 237, 239, 240, 242,
> +		/* 0x38 */ 244, 245, 246, 248, 250, 251, 252, 254,
> +	};
> +
> +	b = fls64(a);
> +	if (b < 7) {
> +		/* a in [0..63] */
> +		return ((u32)v[(u32)a] + 35) >> 6;
> +	}
> +
> +	b = ((b * 84) >> 8) - 1;
> +	shift = (a >> (b * 3));
> +
> +	x = ((u32)(((u32)v[shift] + 10) << b)) >> 6;
> +
> +	/* Newton-Raphson iteration
> +	 *                         2
> +	 * x    = ( 2 * x  +  a / x  ) / 3
> +	 *  k+1          k         k
> +	 */
> +	x = (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
> +	x = ((x * 341) >> 10);
> +	return x;
> +}
> +
> +/* Compute congestion window to use.
> + */
> +static void bictcp_update(struct roccettcp *ca, u32 cwnd,
> +			  u32 acked)
> +{
> +	u32 delta, bic_target, max_cnt;
> +	u64 offs, t;
> +
> +	ca->ack_cnt += acked; /* count the number of ACKed packets */
> +
> +	if (ca->last_cwnd == cwnd &&
> +	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
> +		return;
> +
> +	/* The CUBIC function can update ca->cnt at most once per jiffy.
> +	 * On all cwnd reduction events, ca->epoch_start is set to 0,
> +	 * which will force a recalculation of ca->cnt.
> +	 */
> +	if (ca->epoch_start && tcp_jiffies32 == ca->last_time)
> +		goto tcp_friendliness;
> +
> +	ca->last_cwnd = cwnd;
> +	ca->last_time = tcp_jiffies32;
> +
> +	if (ca->epoch_start == 0) {
> +		ca->epoch_start = tcp_jiffies32; /* record beginning */
> +		ca->ack_cnt = acked; /* start counting */
> +		ca->tcp_cwnd = cwnd; /* syn with cubic */
> +
> +		if (ca->last_max_cwnd <= cwnd) {
> +			ca->bic_K = 0;
> +			ca->bic_origin_point = cwnd;
> +		} else {
> +			/* Compute new K based on
> +			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*bictcp_HZ)
> +			 */
> +			ca->bic_K = cubic_root(cube_factor *
> +					       (ca->last_max_cwnd - cwnd));
> +			ca->bic_origin_point = ca->last_max_cwnd;
> +		}
> +	}
> +
> +	/* cubic function - calc */
> +	/* calculate c * time^3 / rtt,
> +	 *  while considering overflow in calculation of time^3
> +	 * (so time^3 is done by using 64 bit)
> +	 * and without the support of division of 64bit numbers
> +	 * (so all divisions are done by using 32 bit)
> +	 *  also NOTE the unit of those variables
> +	 *	  time  = (t - K) / 2^bictcp_HZ
> +	 *	  c = bic_scale >> 10
> +	 * rtt  = (srtt >> 3) / HZ
> +	 * !!! The following code does not have overflow problems,
> +	 * if the cwnd < 1 million packets !!!
> +	 */
> +
> +	t = (s32)(tcp_jiffies32 - ca->epoch_start);
> +	t += usecs_to_jiffies(ca->delay_min);
> +
> +	/* change the unit from HZ to bictcp_HZ */
> +	t <<= BICTCP_HZ;
> +	do_div(t, HZ);
> +
> +	if (t < ca->bic_K) /* t - K */
> +		offs = ca->bic_K - t;
> +	else
> +		offs = t - ca->bic_K;
> +
> +	/* c/rtt * (t-K)^3 */
> +	delta = (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);
> +	if (t < ca->bic_K) /* below origin*/
> +		bic_target = ca->bic_origin_point - delta;
> +	else /* above origin*/
> +		bic_target = ca->bic_origin_point + delta;
> +
> +	/* cubic function - calc bictcp_cnt*/
> +	if (bic_target > cwnd)
> +		ca->cnt = cwnd / (bic_target - cwnd);
> +	else
> +		ca->cnt = 100 * cwnd; /* very small increment*/
> +
> +	/* The initial growth of cubic function may be too conservative
> +	 * when the available bandwidth is still unknown.
> +	 */
> +	if (ca->last_max_cwnd == 0 && ca->cnt > 20)
> +		ca->cnt = 20; /* increase cwnd 5% per RTT */
> +
> +tcp_friendliness:
> +	/* TCP Friendly */
> +	if (tcp_friendliness) {
> +		u32 scale = beta_scale;
> +
> +		delta = (cwnd * scale) >> 3;
> +		if (delta > 0) {
> +			while (ca->ack_cnt > delta) { /* update tcp cwnd */
> +				ca->ack_cnt -= delta;
> +				ca->tcp_cwnd++;
> +			}
> +		}
> +
> +		if (ca->tcp_cwnd > cwnd) { /* if bic is slower than tcp */
> +			delta = ca->tcp_cwnd - cwnd;
> +			max_cnt = cwnd / delta;
> +			if (ca->cnt > max_cnt)
> +				ca->cnt = max_cnt;
> +		}
> +	}
> +
> +	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
> +	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
> +	 */
> +	ca->cnt = max(ca->cnt, 2U);
> +}
> +
> +static void roccet_launch_update(struct sock *sk, u32 acked)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	u32 now = jiffies_to_usecs(tcp_jiffies32);
> +
> +	/* LAUNCH: Detect an exit point for tcp slow start
> +	 * in networks with large buffers of multiple BDP
> +	 * Like in cellular networks (5G, ...).
> +	 *
> +	 * Or exit LAUNCH if cwnd is too large for application layer
> +	 * data rate (tcp cwnd validation).
> +	 */
> +	if ((ca->curr_srrtt > sr_rtt_upper_bound &&
> +	     get_ack_rate_diff(ca) <= ack_rate_diff_ss) ||
> +	    (!tcp_is_cwnd_limited(sk) && ca->initial_limit_reached)) {
> +		ca->epoch_start = 0;
> +
> +		/* Handle initial LAUNCH. Most bufferbloat occurs here */
> +		if (ca->is_in_initial_launch) {
> +			/* Halving the cwnd will undo the previous step of slow
> +			 * start. Which is fine since the pipe is already full.
> +			 */
> +			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2, 1));
> +		} else {
> +			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) -
> +						 (tcp_snd_cwnd(tp) / 3), 1));
> +		}
> +		tp->snd_ssthresh = tcp_snd_cwnd(tp);
> +		ca->roccet_last_event_time_us = now;
> +		ca->last_event_time_set = true;
> +		ca->state = ORBITER;
> +		return;
> +	}
> +
> +	/* If not already exiting LAUNCH, grow cwnd similar to slow-start */
> +	acked = tcp_slow_start(tp, acked);
> +	/* If cwnd hits ssthresh, go to ORBITER and if any ACKs are
> +	 * leftover save them for ORBITER.
> +	 * Check via tcp_in_slow_start() in case no ACKs are left.
> +	 */
> +	if (!tcp_in_slow_start(tp)) {
> +		ca->state = ORBITER;
> +		ca->epoch_start = 0;
> +		ca->ack_carry_over = acked;
> +	}
> +}
> +
> +static void roccet_orbiter_update(struct sock *sk, u32 acked)
> +{
> +	/* ORBITER: Increase the cwnd by using the CUBIC cwnd growth function,
> +	 * if no roccet congestion event is detected.
> +	 */
> +
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	u32 now = jiffies_to_usecs(tcp_jiffies32);
> +	bool evaluate_srrtt = false;
> +	bool sent_more_than_acked = false;
> +	u32 roccet_xj, jitter, sent, received;
> +
> +	/* Enter DRAIN when roccet was recently triggered */
> +	if (ca->last_event_time_set &&
> +	    time_before32(now, ca->roccet_last_event_time_us +
> +			  100 * USEC_PER_MSEC)) {
> +		ca->state = DRAIN;
> +		return;
> +	}
> +
> +	/* Enter RTT_PROBE when the "timer" has expired.
> +	 *
> +	 * Since we are in ORBITER, we should have already received at least
> +	 * one RTT sample. However safeguard against it if not.
> +	 */
> +	if (time_after32(now, ca->next_min_rtt_probe) &&
> +	    ca->curr_rtt != U32_MAX) {
> +		ca->state = RTT_PROBE_ENTER;
> +		return;
> +	}
> +
> +	/* Calculate jitter.
> +	 * Since we are in ORBITER, we should have already received at least
> +	 * one RTT sample. Even if not, ca->curr_rtt and ca->curr_min_rtt
> +	 * (the divisor later on) are U32_MAX, so they cancel each other out.
> +	 * And if ca->last_rtt is U32_MAX, roccet_xj will be very large, so
> +	 * the srRTT will not exceed it.
> +	 */
> +	if ((s32)(ca->curr_rtt - ca->last_rtt) < 0)
> +		jitter = ca->last_rtt - ca->curr_rtt;
> +	else
> +		jitter = ca->curr_rtt - ca->last_rtt;
> +
> +	/* Calculate if more bytes were sent than received
> +	 * in the time interval.
> +	 *
> +	 * Handle wrap arounds by relying on unsigned subtraction.
> +	 * e.g. if snd_nxt wraps to 10 and seq_start is U32_MAX - 10,
> +	 * the subtraction will result in the value of 21.
> +	 */
> +	sent = tp->snd_nxt - ca->interval_snd_seq_start;
> +	received = tp->snd_una - ca->interval_una_seq_start;
> +
> +	/* Check sent and received bytes from the previous interval.
> +	 * Here we use a guard space of 1% of the current cwnd.
> +	 * We do this to avoid a false positive evaluation due
> +	 * to delays caused by jitter or scheduling.
> +	 */
> +	sent_more_than_acked =
> +		sent >
> +		received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);
> +
> +	/* Check if it's time to evaluate the srRTT */
> +	if (time_after32(now, ca->next_srrtt_check_ts)) {
> +		evaluate_srrtt = true;
> +
> +		/* reset struct and set next end of period */
> +		ca->next_srrtt_check_ts = now + 5 * ca->curr_rtt;
> +
> +		/* Reset Rate calculation */
> +		ca->interval_snd_seq_start = tp->snd_nxt;
> +		ca->interval_una_seq_start = tp->snd_una;
> +	}
> +
> +	/* Respects the jitter of the connection and add it on top of
> +	 * the upper bound for the srRTT.
> +	 */
> +	roccet_xj = div_u64((u64)jitter * 100, ca->curr_min_rtt) +
> +			sr_rtt_upper_bound;
> +
> +	/* The srRTT exceeds the upper bound if bufferbloat happens.
> +	 * Here, we want to reduce the cwnd and drain the buffer.
> +	 */
> +	if (ca->curr_srrtt > roccet_xj && evaluate_srrtt &&
> +	    sent_more_than_acked) {
> +		roccet_congestion_event(sk, now);
> +		return;
> +	}
> +
> +	/* Terminates this function if cwnd is not fully utilized.
> +	 * In mobile networks like 5G, this termination causes the
> +	 * cwnd to be frozen at an excessively high value. This is
> +	 * because slow start or HyStart massively exceed the available
> +	 * bandwidth and leave the cwnd at an excessively high value.
> +	 * The cwnd cannot therefore be fully utilized because it is
> +	 * limited by the connection capacity.
> +	 */
> +	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked)
> +		return;
> +
> +	/* In case there are any ACKs left over from LAUNCH,
> +	 * apply them now.
> +	 */
> +	if (ca->ack_carry_over) {
> +		acked += ca->ack_carry_over;
> +		ca->ack_carry_over = 0;
> +	}
> +
> +	bictcp_update(ca, tcp_snd_cwnd(tp), acked);
> +	tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
> +}
> +
> +/* The Cubic ssthresh calculation is also used for ROCCET.
> + * Called before TCP-CC state changes to TCP_CA_Recovery, TCP_CA_CWR or
> + * TCP_CA_Loss. cwnd reduction is then handled in the roccet_state() callback.
> + */
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
> +
> +	/* In min RTT probe, use the cwnd before the probe to not undershoot */
> +	if (ca->state == RTT_PROBE)
> +		cwnd = ca->cwnd_before_min_rtt_probe;
> +
> +	ca->epoch_start = 0;	/* end of epoch */
> +
> +	/* Wmax and fast convergence */
> +	if (cwnd < ca->last_max_cwnd && fast_convergence)
> +		ca->last_max_cwnd = (cwnd * (BICTCP_BETA_SCALE + beta))
> +			/ (2 * BICTCP_BETA_SCALE);
> +	else
> +		ca->last_max_cwnd = cwnd;
> +
> +	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +}
> +
> +/* Handle a recovery event and return the new cwnd.
> + */
> +static u32 roccet_handle_recovery(struct sock *sk)
> +{
> +	const struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	u32 cwnd = tcp_snd_cwnd(tp);
> +
> +	/* If a loss occurs in the refill phase of min RTT probing
> +	 * we reduce the cwnd and abort the refill.
> +	 */
> +	if (ca->state == RTT_PROBE_REFILL)
> +		ca->state = ORBITER;
> +
> +	/* In RTT_PROBE we don`t want to change state or immediately reduce
> +	 * the cwnd.
> +	 */
> +	if (ca->state == RTT_PROBE) {
> +		roccet_min_rtt_probe_ce(ca, cwnd);
> +		return tcp_snd_cwnd(tp);
> +	}
> +
> +	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
> +	if (ca->state == LAUNCH) {
> +		ca->state = ORBITER;
> +		return cwnd;
> +	}
> +
> +	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +}
> +
> +/* Checks for state roccet-transitions and performs necessary state (re)sets.
> + * This is done in order to avoid the possibility of forgetting to correctly
> + * set a state when entering certain states.
> + *
> + * This is used whenever a state change is possible
> + * (e.g. in roccet_state() or roccet_control()).
> + */
> +static void roccet_handle_state_transitions(struct roccettcp *ca,
> +					    enum roccet_state prev_state,
> +					    u32 now)
> +{
> +	if (ca->state == prev_state)
> +		return;
> +
> +	/* When we exit LAUNCH we can be sure that we are no longer in the
> +	 * initial_launch. Even on LAUNCH to LAUNCH transitions (on RTO).
> +	 */
> +	if (prev_state == LAUNCH)
> +		ca->is_in_initial_launch = false;
> +
> +	/* Whenever we enter ORBITER, we need to schedule the next SRTT check.
> +	 * This will be set before evaluating the next_srrtt_check_ts condition
> +	 * as this is only done in ORBITER.
> +	 */
> +	if (ca->state == ORBITER)
> +		ca->next_srrtt_check_ts = now + 5 * ca->curr_rtt;
> +
> +	/* Whenever we leave the min RTT probing states (and not just
> +	 * transition between them), we want to reset the probing timers.
> +	 */
> +	if ((prev_state == RTT_PROBE_ENTER || prev_state == RTT_PROBE ||
> +	     prev_state == RTT_PROBE_REFILL) &&
> +	    (ca->state != RTT_PROBE && ca->state != RTT_PROBE_REFILL)) {
> +		ca->probe_min_rtt_until = 0;
> +		ca->refill_until = 0;
> +		ca->rtt_probe_timers_set = false;
> +	}
> +}
> +
> +/* Handle different loss-states and perform adequate cwnd reductions.
> + */
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
> +		tcp_snd_cwnd_set(tp, 1);
> +	} else if (new_state == TCP_CA_CWR) {
> +		/* Handle CWR as ROCCET congestion event,
> +		 * however afterwards always set Wmax to the current cwnd.
> +		 */
> +		cwnd = tcp_snd_cwnd(tp);
> +		roccet_congestion_event(sk, now);
> +		ca->last_max_cwnd = cwnd;
> +	} else if (new_state == TCP_CA_Recovery) {
> +		/* Directly reduce cwnd and rely on pacing */
> +		cwnd = roccet_handle_recovery(sk);
> +		tcp_snd_cwnd_set(tp, cwnd);
> +	}
> +
> +	roccet_handle_state_transitions(ca, prev_state, now);
> +}
> +
> +/* Update RTT samples and min RTT.
> + */
> +static void roccet_acked(struct sock *sk, const struct ack_sample *sample)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	u32 delay;
> +
> +	/* Some calls are for duplicates without timestamps */
> +	if (sample->rtt_us < 0)
> +		return;
> +
> +	/* Discard delay samples right after fast recovery */
> +	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
> +		return;
> +
> +	delay = sample->rtt_us;
> +
> +	if (delay == 0)
> +		delay = 1;
> +
> +	/* first call or link delay decreases */
> +	if (ca->delay_min == 0 || (s32)(delay - ca->delay_min) < 0)
> +		ca->delay_min = delay;
> +
> +	/* Get valid sample for roccet */
> +	if (sample->rtt_us > 0) {
> +		ca->last_rtt = ca->curr_rtt;
> +		ca->curr_rtt = sample->rtt_us;
> +	}
> +}
> +
> +/* Custom Pacing Rate for ROCCET TCP.
> + * The code here is similar to the pacing rate adjustments in tcp_input.c
> + * tcp_cong_control(). In LAUNCH (slow start) we want a pacing of 200% and
> + * in ORBITER (congestion avoidance) we adjust the pacing to 100% and do not
> + * use the sysctl_tcp_pacing_ca_ratio.
> + */
> +static void roccet_update_pacing_rate(struct sock *sk)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	u64 rate;
> +
> +	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
> +	rate = (u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
> +
> +	/* current rate is (cwnd * mss) / srtt
> +	 * In slow-start [1], set sk_pacing_rate to 200% the current rate.
> +	 * Otherwise, set it to 100% the current rate.
> +	 *
> +	 * [1]: Normal Slow Start cond is (tp->snd_cwnd < tp->snd_ssthresh)
> +	 *	 If snd_cwnd >= (tp->snd_ssthresh / 2), we are approaching
> +	 *	 end of slow start and should slow down.
> +	 */
> +	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)
> +		rate *= READ_ONCE
> +			(sock_net(sk)->ipv4.sysctl_tcp_pacing_ss_ratio);
> +	else
> +		/* Pacing rate of 100%
> +		 * (instead of ipv4.sysctl_tcp_pacing_ca_ratio)
> +		 */
> +		rate *= 100;
> +
> +	rate *= max(tcp_snd_cwnd(tp), tp->packets_out);
> +
> +	if (likely(tp->srtt_us))
> +		do_div(rate, tp->srtt_us);
> +
> +	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
> +	 * without any lock. We want to make sure compiler won't store
> +	 * intermediate values in this location.
> +	 */
> +	WRITE_ONCE(sk->sk_pacing_rate,
> +		   min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate)));
> +}
> +
> +static void roccet_drain_update(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	/* If we are in DRAIN, ca->roccet_last_event_time_us has to be set.
> +	 * If more than 100 ms have passed after a roccet event, exit DRAIN.
> +	 * The between check is here to handle idle-times and timer-wraps.
> +	 * It is ok if we "accidentally" exit DRAIN in such an occasion.
> +	 */
> +	if (!time_between32(now, ca->roccet_last_event_time_us
> +				- 100 * USEC_PER_MSEC,
> +				ca->roccet_last_event_time_us
> +				+ 100 * USEC_PER_MSEC)) {
> +		if (tcp_in_slow_start(tp))
> +			ca->state = LAUNCH;
> +		else
> +			ca->state = ORBITER;
> +	}
> +}
> +
> +static void roccet_control(struct sock *sk, u32 ack, int flag,
> +			   const struct rate_sample *rs)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	u32 now = jiffies_to_usecs(tcp_jiffies32);
> +	enum roccet_state prev_state = ca->state;
> +
> +	/* Update ack rate. Even on no new acks/sacks. */
> +	update_ack_rate(ca, rs->acked_sacked, now);
> +	/* Only update RTT metrics if we have new acks/sacks in order to keep
> +	 * EWMA from running multiple times for no new acks.
> +	 */
> +	if (rs->acked_sacked > 0) {
> +		update_min_rtt(ca);
> +		update_srrtt(ca);
> +	}
> +
> +	/* Evaluate roccet state */
> +	switch (ca->state) {
> +	case LAUNCH:
> +		roccet_launch_update(sk, rs->acked_sacked);
> +		break;
> +	case ORBITER:
> +		roccet_orbiter_update(sk, rs->acked_sacked);
> +		break;
> +	case DRAIN:
> +		/* In DRAIN the cwnd should not be increased */
> +		roccet_drain_update(sk, now);
> +		break;
> +	case RTT_PROBE_ENTER:
> +		roccet_enter_min_rtt_probe(sk, now);
> +		break;
> +	case RTT_PROBE:
> +		roccet_min_rtt_probe(sk, now);
> +		break;
> +	case RTT_PROBE_REFILL:
> +		roccet_rtt_probe_refill(ca, now);
> +		break;
> +	default:
> +		pr_err_once("TCP ROCCET: Invalid state %d", ca->state);
> +	}
> +
> +	roccet_handle_state_transitions(ca, prev_state, now);
> +
> +	roccet_update_pacing_rate(sk);
> +
> +	if (tcp_is_cwnd_limited(sk))
> +		ca->initial_limit_reached = true;
> +}
> +
> +static struct tcp_congestion_ops roccet_tcp __read_mostly = {
> +	.init = roccet_init,
> +	.ssthresh = roccet_recalc_ssthresh,
> +	.set_state = roccet_state,
> +	.undo_cwnd = tcp_reno_undo_cwnd,
> +	.cwnd_event_tx_start = roccet_cwnd_event_tx_start,
> +	.pkts_acked = roccet_acked,
> +	.cong_control = roccet_control,
> +	.owner = THIS_MODULE,
> +	.name = "roccet",
> +};
> +
> +static int __init roccet_register(void)
> +{
> +	int param_err;
> +
> +	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
> +
> +	/* Check for valid parameter ranges and then precompute factors */
> +	param_err = param_check();
> +
> +	if (param_err)
> +		return param_err;
> +
> +	param_precompute();
> +
> +	return tcp_register_congestion_control(&roccet_tcp);
> +}
> +
> +static void __exit roccet_unregister(void)
> +{
> +	tcp_unregister_congestion_control(&roccet_tcp);
> +}
> +
> +module_init(roccet_register);
> +module_exit(roccet_unregister);
> +
> +MODULE_AUTHOR("Lukas Prause, Tim Füchsel");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ROCCET TCP");
>

[Severity: Medium]
Should ca->interval_snd_seq_start and ca->interval_una_seq_start be
re-armed here as well?  This helper resets the 5-RTT deadline whenever
ORBITER is entered, but the two sequence counters are only initialised
in roccet_reset() and then refreshed inside roccet_orbiter_update()
when the deadline fires.

So the first evaluation after entering ORBITER, from LAUNCH, from DRAIN
or from RTT_PROBE_REFILL, measures

	sent = tp->snd_nxt - ca->interval_snd_seq_start;
	received = tp->snd_una - ca->interval_una_seq_start;

over everything since the last interval reset rather than over the
intended 5 RTTs.  For a connection that just left LAUNCH that is the
whole slow start; for one returning from a probe it also covers the
period where sending was throttled.  Since sent - received is
essentially the bytes in flight, roughly cwnd * mss, the 1% guard in

	sent > received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100)

is trivially exceeded, so sent_more_than_acked is true on that first
check.  That both suppresses the bictcp_update()/tcp_cong_avoid_ai()
growth path and, together with a srRTT above roccet_xj, hands
roccet_congestion_event() a reduction that was not derived from the
last 5 RTTs at all.

Setting the two interval starts next to ca->next_srrtt_check_ts on the
ORBITER transition would keep the window and the timer consistent; is
there a reason to keep them spanning the earlier states?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aq5hgNNRLEpZq2YN%40volt-roccet-vm
