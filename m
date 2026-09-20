Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2242EEA3;
	Sun, 20 Sep 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907377; cv=none; b=e/oR54qYQsTU9aHezMPuThYNHEiaPXPqY+NA9jrQTTpwLS4TtttehdiFLlnaptyEFEzMCr8ebFgWmEmwNDc2rdHjS3hq1B+iJvgGYCDrvcnupQGUxzN1qt+ZoHPDS2dOjsxygESu8saYObnwKwCKxDPMR9sSsM3NkxModgZA7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907377; c=relaxed/simple;
	bh=CLBb1jFlX8cg9N6g9tguxCwKCARRq8GzLP410qgmU2s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Haszte1PVRFsU5B6cbursHLlRW0kosVYicu1CNfdkq5Poq0DYdX9PeeNz+JanWPJG/1qjcKSx2qAd03ztcE+6Snn/9yXPh4DK7hQO8b8WedgDRnG67M4OhxeOy25HNHu0FCZsqN44o+tDnNwjuY2clUCl1VrqTgwtpBqPh4XWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLCoDLf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLCoDLf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3201F000FF;
	Sun, 20 Sep 2026 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907358;
	bh=SYVGZQaKU7anJ8mroEaNyJpAZ/7hUeAo8GNQI1Lzg0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZLCoDLf7pZz9kVTlCaUXMKGeSv6Ua4Lh7GWxT2ZJk7gqg421mkaCLEEjI5rT7gk1N
	 o2g4BBqXu9XrdNj08BPSjywiluT5bQ0qKydlIBUK0qxTRrgPNcXt/v81PGXmOh4Zbs
	 1HzC+ycQivrsE701t8ZFpar0umTmeg/uzL0qSc9IYUpnrTi0fCaTJShbj6YKKsxIYo
	 UoNRBegnWX4mU1FKMbmiadbPqazIi+hP0kDuSIrH8G3U5pYMZfp+W+NyVv1GgQQGQ4
	 Eyhn2k7/RIdMAsOAzQBYo7Z2KOM/voV+5niw3u3q6pAmjFFQwqCtiHROjPHfC1xRgb
	 pb4b2z6C6iJcA==
Subject: Re: [PATCHv6 net-next] tcp: Add TCP ROCCET congestion control module.
From: netdev-bot+sashiko@kernel.org
To: t.fuechsel@gmx.de
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 fmancera@suse.de, ebiggers@kernel.org, bpf@vger.kernel.org,
 lukas.prause@ikt.uni-hannover.de
Date: Sun, 20 Sep 2026 12:29:17 +0000
Message-ID: <178990735749.2160803.15250336586938909578@kernel.org>
In-Reply-To: <aqqGU0XfcfsI-OGy@volt-roccet-vm>
References: <aqqGU0XfcfsI-OGy@volt-roccet-vm>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 17 potential
issue(s) to consider.

Critical: 0 · High: 6 · Medium: 4 · Low: 7

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On every RTO, roccet_state() (net/ipv4/tcp_roccet.c:1034-1036)
  calls roccet_reset() and then tcp_snd_cwnd_set(tp, TCP_INIT_CWND),…
- [High] In the LAUNCH state ROCCET performs no congestion response to
  loss at all: roccet_recalc_ssthresh() returns the unmodified cwnd…
- [High] DRAIN can become a long-lived (~35.8 minute) or permanent dead
  end.
- [High] A ROCCET (srRTT-triggered) congestion event in ORBITER reduces
  cwnd by beta but never lowers tp->snd_ssthresh:…
- [High] roccet_control() is installed as .cong_control, so
  tcp_cong_control() returns immediately after calling it…
- [High] LAUNCH grows the congestion window without bound for connections
  that are never cwnd-limited.
- [Medium] param_check() (net/ipv4/tcp_roccet.c:173-188) enforces 0 <
  beta < BICTCP_BETA_SCALE and bic_scale > 0, but it runs exactly once…
- [Medium] roccet_enter_min_rtt_probe() computes the probe window as
  max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND) or max(tcp_snd_cwnd(tp) / 2,…
- [Medium] roccet_handle_state_transitions() starts a fresh five-RTT
  evaluation deadline on every transition into ORBITER…
- [Medium] A CWR-to-Recovery transition applies a second multiplicative
  reduction within the same recovery window.
- [Low] param_check() (net/ipv4/tcp_roccet.c:182-188) rejects only non-
  positive bic_scale; there is no upper bound.
- [Low] The header comment of roccet_update_pacing_rate()
  (net/ipv4/tcp_roccet.c:1084-1089) states the 200%/100% pacing choice…
- [Low] Six of the eight printk call sites in the new file omit the
  trailing newline (net/ipv4/tcp_roccet.c:364, 407, 472, 478, 540, 553,…
- [Low] The file header (net/ipv4/tcp_roccet.c:44-45) says "Unless CUBIC
  is enabled and congestion window is large this behaves the same as the…
- [Low] roccet_launch_update() calls tcp_slow_start(tp, acked)
  (net/ipv4/tcp_roccet.c:805) without establishing that precondition…
- [Low] struct roccettcp documents curr_rtt as "last sample rtt of
  current round" and last_rtt as "sample rtt of previous round.
- [Low] The module writes tp->snd_ssthresh with plain (unannotated)
  stores in roccet_congestion_event() (net/ipv4/tcp_roccet.c:449) and…

--

tcp: Add TCP ROCCET congestion control module.

This adds a new congestion control module, roccet, derived from CUBIC. It
adds an srRTT metric and an ACK-arrival-rate metric, replaces HyStart with
its own LAUNCH slow start, and drives everything from a .cong_control
callback plus a small state machine (LAUNCH, ORBITER, DRAIN and three
min-RTT-probe states).

A few questions about the new module below.

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..10ad4748d994d
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1233 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> + * Unless CUBIC is enabled and congestion window is large
> + * this behaves the same as the original Reno.
> + */

[Severity: Low]
This isn't a bug, but this sentence looks carried over from tcp_cubic.c.
TCP_CONG_ROCCET neither depends on nor selects TCP_CONG_CUBIC, and
bictcp_update() is compiled into tcp_roccet.o unconditionally, so nothing
here is affected by whether CUBIC is enabled. Could the sentence be dropped
or reworded?

[ ... ]

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
> +module_param(fast_convergence, int, 0644);
> +MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
> +module_param(beta, int, 0644);
> +MODULE_PARM_DESC(beta, "beta for multiplicative increase");

[Severity: Medium]
param_check() runs exactly once, from roccet_register(), but beta stays
writable at runtime with the generic integer setter, so a write to
/sys/module/tcp_roccet/parameters/beta installs values the module itself
declares invalid. The comment directly above says parameters used for
precomputing scale factors are read-only, yet only bic_scale is 0444 while
beta feeds beta_scale in param_precompute().

With beta >= BICTCP_BETA_SCALE, does every reduction turn into an increase?

	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);

and with a negative beta the u32 product wraps to a large cwnd.
roccet_state() installs that value directly for TCP_CA_Recovery:

		cwnd = roccet_handle_recovery(sk);
		tcp_snd_cwnd_set(tp, cwnd);

with no min(tp->snd_cwnd_clamp, ...) bound, unlike
roccet_congestion_event(). Should the recovery result be clamped, and should
beta be either 0444 or validated in a set() handler?

beta_scale is also derived once from the init-time beta, so after a runtime
write the TCP-friendliness code in bictcp_update() and the reduction paths
use two different generations of beta. roccet_recalc_ssthresh() reads beta
twice in one computation with plain loads.

Module parameter attributes are published by mod_sysfs_setup() before
do_init_module() runs. Can a write of beta == 1024 landing between
param_check() and param_precompute() make (BICTCP_BETA_SCALE - beta) a zero
divisor here?

One more nit: MODULE_PARM_DESC calls beta "beta for multiplicative increase"
while every use multiplies cwnd or ssthresh down.

> +module_param(initial_ssthresh, int, 0644);
> +MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold");
> +module_param(bic_scale, int, 0444);
> +MODULE_PARM_DESC(bic_scale,
> +		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
> +module_param(tcp_friendliness, int, 0644);
> +MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
> +
> +/* Used to check certain roccet parameters used in `param_precompute` in order
> + * to avoid invalid scale-related calculations. This validates the specified
> + * parameters or rejects them.
> + */
> +static int param_check(void)
> +{

[ ... ]

> +	if (bic_scale <= 0) {
> +		pr_err_once("TCP ROCCET: bic_scale must be positive\n");
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +	cube_rtt_scale = (bic_scale * 10); /* 1024*c/rtt */

[ ... ]

> +	/* divide by bic_scale and by constant srtt (100ms) */
> +	do_div(cube_factor, bic_scale * 10);
> +}

[Severity: Low]
param_check() rejects only non-positive bic_scale, with no upper bound. Does
any bic_scale above INT_MAX/10 (214748364) overflow the int expression
bic_scale * 10 in both cube_rtt_scale and the do_div() divisor, so the
module registers with corrupted growth constants (cube_factor collapsing to
0, leaving bic_K always 0)? Would an upper bound match the stated purpose of
avoiding invalid scale-related calculations?

[ ... ]

> +	if (ca->curr_min_rtt == 0) {
> +		pr_err_once("TCP ROCCET: Recorded curr_min_rtt is 0");
> +		return; /* skip srRTT update */
> +	}

[Severity: Low]
This isn't a bug, but this message has no trailing newline, unlike the two
in param_check(). The same applies to the pr_warn_once() calls in
roccet_min_rtt_probe_ce(), roccet_enter_min_rtt_probe() and
roccet_min_rtt_probe(), and to the pr_err_once() in the default case of
roccet_control(). Without a newline the text stays in the log buffer as a
continuation and can be merged with unrelated output. The prefix also
alternates between "TCP ROCCET: " and "ROCCET: " with no pr_fmt() defined.

[ ... ]

> +	/* Reduce cwnd by beta */
> +	tcp_snd_cwnd_set(tp, min(tp->snd_cwnd_clamp,
> +				 max((curr_cwnd * beta)
> +				     / BICTCP_BETA_SCALE, 2U)));
> +
> +	if (ca->state == LAUNCH) {
> +		/* Set ssthresh on ECN, so that roccet is not in slow-start */
> +		tp->snd_ssthresh = tcp_snd_cwnd(tp);
> +		ca->state = ORBITER;

[Severity: Low]
This isn't a behavioural bug, but snd_ssthresh has lockless readers - for
instance tcp.c reads it with READ_ONCE(tp->snd_ssthresh) - and the stack
plus the other CC modules all write it with WRITE_ONCE(). roccet_init()
already uses WRITE_ONCE(); should this store and the one in
roccet_launch_update() do the same?

> +	} else if (ca->state == ORBITER || ca->state == RTT_PROBE_REFILL) {
> +		/* If we are in orbiter or currently refilling the pipe,
> +		 * abort the refill.
> +		 */
> +		ca->state = DRAIN;
> +	}

[Severity: High]
In the ORBITER and RTT_PROBE_REFILL case cwnd is reduced by beta but
tp->snd_ssthresh is left untouched; only the LAUNCH branch above updates it.

100 ms later roccet_drain_update() picks the next state from
tcp_in_slow_start(tp), i.e. cwnd < ssthresh, which is true precisely because
of the 0.7x reduction just applied:

	if (tcp_in_slow_start(tp))
		ca->state = LAUNCH;
	else
		ca->state = ORBITER;

Does this send the flow back into LAUNCH, where tcp_slow_start() grows cwnd
exponentially again and loss is deliberately ignored, undoing within about
half an RTT the reduction that was meant to drain the bottleneck buffer?

The loss and ECN paths do not have this problem, because
tcp_init_cwnd_reduction() and tcp_enter_loss() lower snd_ssthresh via the
.ssthresh callback. Only this internally generated event leaves cwnd and
ssthresh inconsistent.

[ ... ]

> +	if (!tcp_is_cwnd_limited(sk))
> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);
> +	else
> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
> +
> +	ca->probe_min_rtt_until = now + interval;
> +	ca->cwnd_before_min_rtt_probe = tcp_snd_cwnd(tp);
> +
> +	/* Half the cwnd to drain the buffer for probing. */
> +	tcp_snd_cwnd_set(tp, probe_cwnd);

[Severity: Medium]
Both branches floor the probe window at TCP_INIT_CWND, and the result is
installed unconditionally. When the pre-probe cwnd is already below 10, does
this drain probe raise cwnd instead of lowering it?

That case is reachable: roccet_handle_recovery() and
roccet_recalc_ssthresh() floor the window at 2 while the flow stays in
ORBITER, so with cwnd == 2 the probe window becomes max(2/2, 10) == 10, i.e.
five times more segments in flight for at least max(200 ms, RTT) right after
a congestion episode.

[ ... ]

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

[Severity: High]
The application-limited exit requires ca->initial_limit_reached, but that
flag is only ever set while tcp_is_cwnd_limited(sk) is true, at the end of
roccet_control():

	if (tcp_is_cwnd_limited(sk))
		ca->initial_limit_reached = true;

For a flow that never fills the window - request/response or interactive
traffic with gaps shorter than the RTO - can the flag stay false forever, so
neither LAUNCH exit fires on an uncongested path while every ACK still runs
tcp_slow_start() below and raises cwnd by acked toward
TCP_INFINITE_SSTHRESH and snd_cwnd_clamp?

The usual correction is not available here: tcp_cwnd_validate() skips
tcp_cwnd_application_limited() when ca_ops->cong_control is set. Does that
leave cwnd, and the pacing rate that roccet_update_pacing_rate() derives
from it, inflated without any path evidence, allowing a large burst once the
application does have data to send?

[ ... ]

> +	/* If not already exiting LAUNCH, grow cwnd similar to slow-start */
> +	acked = tcp_slow_start(tp, acked);

[Severity: Low]
tcp_slow_start() is documented for the case where cwnd is no greater than
snd_ssthresh, but tcp_in_slow_start() is only checked afterwards.

After roccet_state(TCP_CA_Loss) sets cwnd to TCP_INIT_CWND while
snd_ssthresh keeps the reduced value from roccet_recalc_ssthresh() (as low
as 2), the next ACK arrives with cwnd > ssthresh. tcp_slow_start() then
pulls cwnd down to ssthresh and its leftover-ACK arithmetic

	acked -= cwnd - tcp_snd_cwnd(tp);

underflows in u32, returning roughly acked + (old_cwnd - ssthresh). Does
that inflated credit end up in ca->ack_carry_over and later in ca->ack_cnt
in bictcp_update()?

[ ... ]

> +	/* Enter DRAIN when roccet was recently triggered */
> +	if (ca->roccet_last_event_time_us &&
> +	    time_before32(now, ca->roccet_last_event_time_us +
> +			  100 * USEC_PER_MSEC)) {
> +		ca->state = DRAIN;
> +		return;
> +	}

[ ... ]

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

[Severity: Medium]
These baselines are refreshed only when a deadline expires here, but
roccet_handle_state_transitions() restarts the deadline on every transition
into ORBITER without touching them:

	if (ca->state == ORBITER)
		ca->next_srrtt_check_ts = now + 5 * ca->curr_rtt;

Does that make the deadline and the byte deltas cover different intervals?
The first evaluation after LAUNCH compares snd_nxt/snd_una against the
values captured in roccet_reset() at connection start, where in-flight was
0, so sent - received equals the current in-flight bytes and
sent_more_than_acked is true even on an idle path. That both blocks growth

	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked)
		return;

and can drive a congestion event on stale data. After DRAIN or min-RTT
probing the stale baseline biases the other way and masks real growth.

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
In LAUNCH this returns cwnd unchanged, so tcp_init_cwnd_reduction() and
tcp_enter_loss() store snd_ssthresh == cwnd, i.e. no multiplicative
decrease. roccet_handle_recovery() below also returns cwnd unchanged for
LAUNCH, and because .cong_control is set, tcp_cong_control() returns before
tcp_cwnd_reduction():

	if (icsk->icsk_ca_ops->cong_control) {
		icsk->icsk_ca_ops->cong_control(sk, ack, flag, rs);
		return;
	}

so PRR does not reduce cwnd either. Is the loss event then absorbed
entirely, with tcp_slow_start() in roccet_launch_update() continuing to grow
cwnd through the episode?

This is not confined to connection start: roccet_state(TCP_CA_Loss) calls
roccet_reset(), which re-enters LAUNCH, and roccet_drain_update() can also
return to LAUNCH, so the loss-insensitive window recurs.

The commit message says "In addition, ROCCET reacts to packet loss by
adapting CUBIC's behavior". Could it state that losses are ignored in
LAUNCH, given that the ignore_loss module parameter that used to gate this
was removed?

[ ... ]

> +	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
> +	if (ca->state == LAUNCH) {
> +		ca->state = ORBITER;
> +		return cwnd;
> +	}
> +
> +	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +}

[ ... ]

> +	if (new_state == TCP_CA_Loss) {
> +		roccet_reset(sk, ca);
> +		tcp_snd_cwnd_set(tp, TCP_INIT_CWND);

[Severity: High]
tcp_enter_loss() sets cwnd = tcp_packets_in_flight(tp) + 1 and only
afterwards calls tcp_set_ca_state(sk, TCP_CA_Loss), so this write is the
final value. Does the flow then restart with 10 segments instead of 1 after
every timeout?

With .cong_control set, tcp_cong_control() returns before
tcp_cwnd_reduction(), so nothing re-imposes packet conservation, and
roccet_reset() restores the same state on each consecutive RTO. CUBIC's
set_state only calls bictcp_reset() and never touches cwnd. Should the loss
window installed by the stack be left alone, and should the changelog
describe this deviation?

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

[Severity: Medium]
tcp_enter_recovery() skips tcp_init_cwnd_reduction() when
tcp_in_cwnd_reduction(sk) is already true, but still calls
tcp_set_ca_state(sk, TCP_CA_Recovery). Since this branch is unconditional,
does a CWR to Recovery transition apply a second beta reduction inside the
same recovery window, for instance 100 to about 70 to 49, while
snd_ssthresh stays at about 70?

If the transition happens during RTT_PROBE, roccet_min_rtt_probe_ce()
reduces ca->cwnd_before_min_rtt_probe a second time as well.

The changelog lists "Fix potential double penalty when receiving ECN (ECE)
mark" - is this path covered by that fix?

[ ... ]

> +	/* Get valid sample for roccet */
> +	if (sample->rtt_us > 0) {
> +		ca->last_rtt = ca->curr_rtt;
> +		ca->curr_rtt = sample->rtt_us;
> +	}
> +}

[Severity: Low]
struct roccettcp documents curr_rtt as the "last sample rtt of current
round" and last_rtt as the "sample rtt of previous round", but this shifts
curr_rtt into last_rtt on every accepted sample with no round boundary. With
several samples per RTT, is the jitter term roccet_xj in
roccet_orbiter_update() a per-ACK delta rather than the round-to-round
comparison the comments describe?

> +/* Custom Pacing Rate for ROCCET TCP.
> + * The code here is similar to the pacing rate adjustments in tcp_input.c
> + * tcp_cong_control(). In LAUNCH (slow start) we want a pacing of 200% and
> + * in ORBITER (congestion avoidance) we adjust the pacing to 100% and do not
> + * use the sysctl_tcp_pacing_ca_ratio.
> + */

[ ... ]

> +	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)

[Severity: Low]
This isn't a bug, but the comment describes the 200%/100% choice as
state-based while the function never reads ca->state; it branches on cwnd
versus snd_ssthresh / 2 and multiplies by sysctl_tcp_pacing_ss_ratio rather
than a literal 200.

Since roccet_launch_update() and roccet_congestion_event() set
snd_ssthresh = tcp_snd_cwnd(tp) when leaving LAUNCH, and
roccet_state(TCP_CA_Loss) sets cwnd = TCP_INIT_CWND while leaving a large
snd_ssthresh, a flow can be in LAUNCH and paced at 100%, or in
ORBITER/DRAIN and paced at ss_ratio. Could the comment be brought in line
with the code?

> +static void roccet_drain_update(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	if (ca->roccet_last_event_time_us &&
> +	    time_after32(now, ca->roccet_last_event_time_us +
> +			 100 * USEC_PER_MSEC)) {
> +		if (tcp_in_slow_start(tp))
> +			ca->state = LAUNCH;
> +		else
> +			ca->state = ORBITER;
> +	}
> +}

[Severity: High]
This DRAIN exit and the DRAIN entry in roccet_orbiter_update() are exact
negations of each other over the same timestamp:

roccet_orbiter_update():
	if (ca->roccet_last_event_time_us &&
	    time_before32(now, ca->roccet_last_event_time_us +
			  100 * USEC_PER_MSEC)) {
		ca->state = DRAIN;

roccet_drain_update():
	if (ca->roccet_last_event_time_us &&
	    time_after32(now, ca->roccet_last_event_time_us +
			 100 * USEC_PER_MSEC)) {

ca->roccet_last_event_time_us is refreshed only by
roccet_congestion_event() and by the srRTT exit branch of
roccet_launch_update(). Once now - roccet_last_event_time_us passes 2^31 us
(about 35.8 minutes, with now = jiffies_to_usecs(tcp_jiffies32) wrapping
every ~71.6 minutes), the signed comparison flips.

Does ORBITER then jump unconditionally to DRAIN while DRAIN can never exit,
so cwnd growth is frozen for the rest of the wrap half-period on long-lived
flows that saw one congestion event and then a quiet path?

Separately, jiffies_to_usecs(tcp_jiffies32) is exactly 0 periodically (every
536870912 jiffies at HZ=1000). If roccet_congestion_event() stores that 0,
the ca->roccet_last_event_time_us && guard makes this exit unreachable until
an unrelated RTO or CWR resets the state machine. Is 0 intended to double as
an "unset" sentinel here?

[ ... ]

> +	/* Evaluate roccet state */
> +	switch (ca->state) {
> +	case LAUNCH:
> +		roccet_launch_update(sk, rs->acked_sacked);
> +		break;
> +	case ORBITER:
> +		roccet_orbiter_update(sk, rs->acked_sacked);
> +		break;

[Severity: High]
roccet_control() is installed as .cong_control, so tcp_cong_control()
returns right after calling it, bypassing tcp_cwnd_reduction()/PRR and the
tcp_may_raise_cwnd() gate. This switch dispatches on ca->state only, and
inet_csk(sk)->icsk_ca_state is not read anywhere in the module.

While the socket is in TCP_CA_Recovery, TCP_CA_CWR or TCP_CA_Loss, does
every incoming ACK keep running the growth paths, i.e. tcp_slow_start() in
roccet_launch_update() (and roccet_state(TCP_CA_Loss) explicitly resets the
machine to LAUNCH) and bictcp_update() plus tcp_cong_avoid_ai() in
roccet_orbiter_update()?

tp->is_cwnd_limited is set by tcp_cwnd_validate() during the
retransmissions, so the tcp_is_cwnd_limited() gate in
roccet_orbiter_update() does not block this. BBR handles the same problem
explicitly in bbr_set_cwnd_to_recover_or_restore(); should ROCCET implement
its own packet conservation while in recovery?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aqqGU0XfcfsI-OGy%40volt-roccet-vm
