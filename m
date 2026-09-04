Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0F531B0E;
	Fri,  4 Sep 2026 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560741; cv=none; b=TWoD7ExWzJOmaVXXNOZGE2Ieo9nhDTd1TyEDKX8tFK27JcA72gnsEsSpWC3PTIcJhXhalPnv6/nfchJLDIaPz0wkLU9urPHtqJone2JcEqot6fb3/XnPrvfQ/qzINcxCPACcW1X2xRBEBk8LnyWDVSVREgZAZUVN5QUtrmCtGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560741; c=relaxed/simple;
	bh=D7Q93e7tAxRjm3A8LdbQVBFraFL1HZJScuJ1h+OMf/g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffK7pXAEmBiWVrhLyhY8IdgmADpBxZ5y2xNI65kpkY2JQlgivJ7HhfW0+NvGBXwYEo0z4Ie0ndeej9WzGi3OshqUiktwU2WQkLd2zvvL/rblvZYhQHoNRVtelwkB1vfjPH0+u3y86Qyk5VfveY7dlMr0UY4fNzoOX2lRTJ/OHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsbybDjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsbybDjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EA51F00A3E;
	Fri,  4 Sep 2026 22:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560736;
	bh=TbAwKJV6ijbYc/6liLW0a5cWqlnu7fqVEBLbb5hfXtQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PsbybDjLzHWGHnZWbXcHc1zTUv/OAOiJRaEP/iNAXnAauu1uPmxFxwuWzZzTM/CYY
	 6h3EctywKXLntUiK/rnwnKgf3RTSy+BB/aiY/oqKRpARSzc6GQIvmz7/vSoNvq2caf
	 9I/kloWhQ+XumRilpvTd1OlQ5C2EkkduRTY9Wp1MjUqR9R3r1rikaW+pnvgB7zV4up
	 4GTHqlJEQwI0W7V4T8lT+bIQPXopAWMBd0ohkbZU3idB6tTO6/3vkaN2CGiJacSvMR
	 QI18lMrUDO5W3kgC+gi0zYZ5UzYYSiE27dran57n1gjCf4SHxf82HkKNr/a9BH6uIJ
	 4nPfRGNjiLRig==
Subject: Re: [PATCHv5 net-next] tcp: Add TCP ROCCET congestion control module.
From: netdev-bot+sashiko@kernel.org
To: t.fuechsel@gmx.de
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 fmancera@suse.de, ebiggers@kernel.org, bpf@vger.kernel.org,
 lukas.prause@ikt.uni-hannover.de
Date: Fri, 04 Sep 2026 22:25:35 +0000
Message-ID: <178856073560.219967.3774715096969805562@kernel.org>
In-Reply-To: <apWz9rPcGMgYCKOR@volt-roccet-vm>
References: <apWz9rPcGMgYCKOR@volt-roccet-vm>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 21 potential
issue(s) to consider:

Critical: 0 · High: 5 · Medium: 8 · Low: 8

- [High] ROCCET performs no congestion response to ECN.
- [High] ROCCET removes the standard congestion response to loss/RTO, and
  the commit message does not disclose it.
- [High] `update_min_rtt()` (net/ipv4/tcp_roccet.c:191-206) treats an
  absent RTT sample (`ca->curr_rtt == 0`) as a valid measurement and…
- [High] `param_check()` only rejects `beta_param` outside (0, 1024).
- [High] `roccettcp_init()` (net/ipv4/tcp_roccet.c:457-463) — called for
  every new TCP socket that selects ROCCET, i.e. by any unprivileged…
- [Medium] `param_check(true)` is invoked from `roccettcp_init()`
  (net/ipv4/tcp_roccet.c:462) for every new socket, and it emits…
- [Medium] The writable `beta_param` interface
  (net/ipv4/tcp_roccet.c:144, `module_param(beta_param, int, 0644)` at…
- [Medium] `roccettcp_reset()` (net/ipv4/tcp_roccet.c:168) memsets the
  whole per-socket CA state, zeroing…
- [Medium] `initial_round_completed` is documented as a full-round guard
  ('Set to true after the initial roccet-control round has completed',…
- [Medium] The LAUNCH exit path in `roccettcp_cong_avoid()` computes
  `tcp_sk(sk)->snd_ssthresh = tcp_snd_cwnd(tp) / 2`…
- [Medium] `roccet_min_rtt_probe()` reduces cwnd and relies on a later
  call, while `ca->state` is still RTT_PROBE/RTT_PROBE_REFILL and while…
- [Medium] In `roccettcp_recalc_ssthresh()`, the RTT_PROBE branch updates
  `ca->last_max_cwnd` from the local `cwnd`, which at that point still…
- [Medium] `update_srrtt()` truncates the 64-bit rRTT result into a u32
  and then evaluates the EWMA entirely in 32-bit arithmetic: `u32 rrtt =…
- [Low] Unfinished-submission artifacts in the new file: leftover
  commented-out code `//WRITE_ONCE(sk->sk_pacing_rate, 0);` in…
- [Low] The main commit description omits ROCCET's periodic forced
  congestion-window reduction for minimum-RTT probing.
- [Low] Two comments describe artifacts that do not exist or state the
  wrong unit: `update_srrtt()` explains its invariant in terms of…
- [Low] `param_check()`'s comment (net/ipv4/tcp_roccet.c:382-385) claims
  it exists 'to check the roccet params in advance in order to avoid…
- [Low] In `update_ack_rate()`, the 'new interval' branch assigns the u32
  parameter `acked` directly into the u16 field `ca->ack_rate_cnt`…
- [Low] In `roccettcp_cong_avoid()`, the LAUNCH branch does `acked =
  tcp_slow_start(tp, acked); if (!acked) return;`…
- [Low] The ORBITER send/received monitoring interval cannot account for
  more than 4 GiB of data: `send = tp->snd_nxt -…
- [Low] `sr_rtt_upper_bound` and `ack_rate_diff_ss` are
  `module_param(..., 0644)` and are read from the packet-processing hot…

--

tcp: Add TCP ROCCET congestion control module.

This adds a new loadable congestion control module, ROCCET, which builds on
the CUBIC window growth function and adds an srRTT metric, an ACK arrival
rate metric and a send/receive byte comparison to detect bufferbloat.  It
replaces HyStart with its own slow start (LAUNCH) and drives everything from
a .cong_control callback.

A few questions about the new file follow.

The commit body describes the congestion avoidance phase as purely passive:

  "For the congestion avoidance phase, ROCCET relies on the srRTT and
   monitoring the send and received Bytes to detect the filling of the
   bottleneck buffer."

[Severity: Low]
Could the commit message also describe the active minimum RTT probing?
roccet_min_rtt_probe() cuts cwnd to max(cwnd/2, TCP_INIT_CWND), or
max(cwnd/3, TCP_INIT_CWND) when tcp_is_cwnd_limited() is false, pins
snd_ssthresh to that value for at least 200ms or one RTT, resets
curr_min_rtt and later restores the previous window.  It is armed every time
the five second deadline in ca->next_min_rtt_probe expires.  Only the
revision history mentions it ("Add minimum RTT probing"), while the body
reads as if no forced window reduction happens.

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..18925a79bd8d3
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1050 @@

[ ... ]

> +/* min RTT probe period in ms */
> +#define ROCCET_NEXT_MIN_RTT_PROBE 5000

[ ... ]

> +/* Parameters that are specific to the ROCCET-Algorithm */
> +
> +// = 717/1024 (BICTCP_BETA_SCALE)
> +#define BETA_PARAM_DEFAULT 717
> +#define BIC_SCALE_PARAM_DEFAULT 41
> +
> +static uint sr_rtt_upper_bound __read_mostly = 100;
> +static int ack_rate_diff_ss __read_mostly = 10;
> +
> +module_param(sr_rtt_upper_bound, uint, 0644);
> +MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
> +module_param(ack_rate_diff_ss, int, 0644);
> +MODULE_PARM_DESC(ack_rate_diff_ss,
> +		 "ROCCET's threshold to exit slow start if ACK-rate defer by given amount of segments.");

[ ... ]

> +/* Note parameters that are used for precomputing scale factors are read-only */
> +module_param(fast_convergence, int, 0644);
> +MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
> +module_param(beta_param, int, 0644);
> +MODULE_PARM_DESC(beta_param, "beta for multiplicative increase");

[Severity: Medium]
The comment above says precompute parameters are read-only, but beta_param
is registered with mode 0644 while bic_scale_param uses 0444.  Since there
is no module_param_cb setter, a write to beta_param goes straight into the
global with no validation and no recomputation of beta, beta_scale or
cube_factor.  Those are refreshed only later, when some unrelated socket
runs roccettcp_init().

If the written value is out of range, param_check(true) puts the default
into the hidden beta but leaves beta_param reporting the rejected value, so
/sys/module/tcp_roccet/parameters/beta_param permanently disagrees with the
beta actually in use.  Should beta_param be 0444 like bic_scale_param, or
use a setter that validates and recomputes at write time?

[ ... ]

> +static void roccettcp_reset(struct roccettcp *ca)
> +{
> +	memset(ca, 0, sizeof(struct roccettcp));

[Severity: Medium]
The memset also zeroes ca->interval_snd_seq_start and
ca->interval_una_seq_start.  roccettcp_init() seeds them explicitly:

	ca->interval_snd_seq_start = tcp_sk(sk)->snd_nxt;
	ca->interval_una_seq_start = tcp_sk(sk)->snd_una;

but the TCP_CA_Loss branch of roccettcp_state() calls roccettcp_reset()
without re-seeding them.  Does ORBITER then compare absolute sequence
numbers?

	send = tp->snd_nxt - ca->interval_snd_seq_start;
	received = tp->snd_una - ca->interval_una_seq_start;

With both baselines at 0 this reduces to "bytes in flight > 1% of
cwnd * mss", which looks true for as long as the flow is sending, so the
later

	if (!tcp_is_cwnd_limited(sk) || send_more_than_acked)
		return;

blocks all window growth until the first srRTT evaluation re-seeds the
baselines, and that same evaluation can authorize a congestion event.

> +static void update_min_rtt(struct sock *sk)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	/* Check if new lower min RTT was found. If so, set it directly */
> +	if (ca->curr_rtt < ca->curr_min_rtt) {
> +		ca->curr_min_rtt = max(ca->curr_rtt, 1);

[Severity: High]
Can this latch a 1us minimum RTT when no RTT sample has been taken yet?

After roccettcp_reset() or roccettcp_init(), ca->curr_rtt is 0 and
ca->curr_min_rtt is ~0U.  roccettcp_acked() returns early for invalid
samples:

	/* Some calls are for duplicates without timestamps */
	if (sample->rtt_us < 0)
		return;

and tcp_clean_rtx_queue() calls pkts_acked unconditionally with
sample.rtt_us taken from rate->rtt_us, which is -1 when no RTT could be
measured.  roccet_control() then still runs update_min_rtt() and
update_srrtt() with curr_rtt == 0, so 0 < ~0U is true and curr_min_rtt
becomes max(0, 1) == 1.

Reachable cases would be a SACK-only or duplicate first ACK when the first
packet of the initial window is lost, and the first ACK after an RTO on a
connection without TCP timestamps.

Once curr_min_rtt is 1, update_srrtt() computes
rrtt = 100 * (curr_rtt - 1) / 1, i.e. millions, so curr_srrtt stays far
above sr_rtt_upper_bound (default 100) and the bufferbloat detector fires
continuously until the next minimum RTT probe five seconds later.  Would it
help to distinguish "no sample yet" from a real 1us RTT here?

> +		/* Probe for the min RTT in ROCCET_NEXT_MIN_RTT_PROBE seconds
> +		 * if no other update occurs.
> +		 */

[ ... ]

> +			ca->ack_rate_curr_rate = ca->ack_rate_cnt;
> +			ca->ack_rate_cnt =
> +				acked; // start counting for the new interval
> +		}
> +
> +		ca->was_idle = false;
> +	} else {
> +		// Cap the ack count to avoid overflow
> +		ca->ack_rate_cnt = min_t(u32, ca->ack_rate_cnt + acked,
> +					 U16_MAX);
> +	}

[Severity: Low]
The new-interval branch assigns the u32 argument acked straight into the u16
ca->ack_rate_cnt with no clamp, while the sibling branch a few lines below
saturates with min_t(u32, ..., U16_MAX).  Should the first assignment
saturate too?  An ACK covering more than 65535 segments at an interval
boundary truncates (70000 becomes 4464) and feeds a wrong value into
get_ack_rate_diff().

[ ... ]

> +	/* Calculate the new rRTT (Scaled by 100).
> +	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
> +	 *
> +	 * curr_min_rtt_timed.rtt is always <= than curr_rtt,
> +	 * since this is the minimum of the rtt.

[Severity: Low]
There is no curr_min_rtt_timed member in struct roccettcp; the field is the
flat u32 curr_min_rtt.  Same kind of thing in update_min_rtt(), where the
comment says the next probe happens "in ROCCET_NEXT_MIN_RTT_PROBE seconds"
while the macro is documented as milliseconds and is multiplied by
USEC_PER_MSEC, i.e. five seconds and not 5000 seconds.

> +	 *
> +	 * 0 is a valid value for rrtt.
> +	 */
> +	u32 rrtt = div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
> +			   ca->curr_min_rtt);
> +
> +	// (1 - alpha) * srRTT + alpha * rRTT
> +	ca->curr_srrtt = ((100 - ROCCET_ALPHA_TIMES_100) * ca->curr_srrtt +
> +			  ROCCET_ALPHA_TIMES_100 * rrtt) /
> +			 100;
> +}

[Severity: Medium]
The div_u64() numerator is widened to 64 bits, but the result is stored in a
u32 and the EWMA below is evaluated entirely in 32-bit arithmetic.  Does
80 * ca->curr_srrtt wrap once curr_srrtt exceeds roughly 53.6M?

With curr_min_rtt floored to 1us (see the update_min_rtt() question above),
a 540ms RTT sample already gives rrtt above 53.6M, and curr_srrtt converges
toward it.  curr_srrtt is the only bufferbloat signal gating
roccet_congestion_event() and the LAUNCH exit, so a wrap there either
defeats the reaction or fires it spuriously.

The v2/v3 changelog says "Fix potential integer overflow in rRTT
calculation" and "Fix potential overflow in rRTT calculation by using 64-bit
arithmetic", but only the numerator was widened.

[ ... ]

> +		probe_cwnd = max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
> +		if (!tcp_is_cwnd_limited(sk))
> +			probe_cwnd = max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);

[ ... ]

> +		ca->refill_until = ca->probe_min_rtt_until + interval;
> +	} else if (before(now, ca->refill_until)) {
> +		/* Reset cwnd and refill the pipe. */
> +		if (ca->state != RTT_PROBE_REFILL) {
> +			tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
> +			tcp_sk(sk)->snd_ssthresh = tcp_snd_cwnd(tp);
> +			ca->state = RTT_PROBE_REFILL;
> +		}
> +	} else {
> +		/* End min RTT probing phase. */
> +		ca->probe_min_rtt_until = 0;
> +		ca->state = ORBITER;
> +	}
> +}

[Severity: Medium]
The cwnd restore depends on ca->state still being RTT_PROBE or
RTT_PROBE_REFILL and on an ACK landing inside the refill window.  Can other
code paths clear the state and leave the reduced window in place?

roccettcp_recalc_ssthresh() starts with:

	if (ca->state == RTT_PROBE_REFILL)
		ca->state = ORBITER;

and roccet_control() overwrites ca->state in the two higher priority
branches:

	if (tcp_in_slow_start(tp)) {
		ca->state = LAUNCH;
	} else if ((s32)now - ca->roccet_last_event_time_us <=
		   100 * USEC_PER_MSEC) {
		ca->state = DRAIN;

In all of these, probe_min_rtt_until and refill_until stay non-zero, so the
restore branch is never taken.  The sender then keeps the 2x-3x reduced cwnd
with snd_ssthresh pinned to it, and when the deadline finally passes the
terminal else only clears probe_min_rtt_until, making that probe round a
no-op.  The same skip happens if no ACK arrives inside the refill window.

> +/* Used to check the roccet params in advance in order to avoid
> + * invalid-param-attacks. This validates the provided params and
> + * then saves valid copies of the params.
> + */

[Severity: Low]
This describes all of the parameters, but only beta_param and
bic_scale_param are validated and copied.  sr_rtt_upper_bound,
ack_rate_diff_ss, initial_ssthresh, fast_convergence and tcp_friendliness
are all 0644 and are read live with no bounds check and no validated copy,
including initial_ssthresh which is assigned directly to tp->snd_ssthresh in
roccettcp_init().  Could the comment be narrowed to what is actually
checked?

> +static int param_check(bool use_defaults)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Validate parameters to avoid division by zero errors.
> +	 */
> +	if (beta_param <= 0 || beta_param >= BICTCP_BETA_SCALE) {
> +		pr_err("roccet: beta must be between 0 and %d\n",
> +		       BICTCP_BETA_SCALE);
> +
> +		if (use_defaults) {
> +			pr_info("Using default value of %d for beta.\n",
> +				BETA_PARAM_DEFAULT);
> +			beta = BETA_PARAM_DEFAULT;
> +		} else {
> +			ret = -EINVAL;
> +		}
> +	} else {
> +		beta = beta_param;
> +	}

[Severity: Medium]
param_check(true) is called from roccettcp_init(), i.e. once per socket.
Can this flood the log?  The out-of-range path never rewrites beta_param
itself, only the hidden beta, so once an invalid value is stored every
subsequent connection that selects roccet prints two to four lines,
indefinitely.  Would pr_*_once() or ratelimited variants, or moving the
diagnostics to module init and a param setter, avoid that?

[ ... ]

> +static void param_precompute(void)
> +{
> +	/* Precompute a bunch of the scaling factors that are used per-packet
> +	 * based on SRTT of 100ms
> +	 */
> +	beta_scale =
> +		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
> +
> +	cube_rtt_scale = (bic_scale * 10); /* 1024*c/rtt */

[ ... ]

> +	/* 1/c * 2^2*bictcp_HZ * srtt */
> +	cube_factor = 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
> +
> +	/* divide by bic_scale and by constant Srtt (100ms) */
> +	do_div(cube_factor, bic_scale * 10);
> +}
> +
> +static void roccettcp_init(struct sock *sk)
> +{
> +	/* Check & precompute on `init` in order to use the newest
> +	 * available params.
> +	 */
> +	param_check(true);
> +	param_precompute();

[Severity: High]
Is it safe to write the module-wide globals from a per-socket callback?
roccettcp_init() runs for every new socket that selects roccet, and
param_check()/param_precompute() write beta, bic_scale, beta_scale,
cube_rtt_scale and cube_factor with no lock, RCU or atomic annotation, while
every other live flow reads them locklessly from the ACK path
(bictcp_update(), roccet_congestion_event(), roccettcp_recalc_ssthresh()).

cube_factor is also published in an intermediate state:

	cube_factor = 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
	do_div(cube_factor, bic_scale * 10);

so a concurrent bictcp_update() can multiply the undivided 2^40, and two
initializers racing here can apply do_div() twice to the same variable,
shrinking cube_factor by another factor of ~410 for the rest of the module's
life.

param_check() also reads beta_param twice, once for the range test and once
for "beta = beta_param;".  If the second read picks up a concurrently
written 1024, param_precompute() divides by (BICTCP_BETA_SCALE - beta) == 0.

Upstream CUBIC does this precomputation once in __init cubictcp_register()
and keeps bic_scale read-only.  Could ROCCET do the same?

> +
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	roccettcp_reset(ca);

[ ... ]

> +	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
> +	//WRITE_ONCE(sk->sk_pacing_rate, 0);
> +}

[Severity: Low]
This isn't a bug, but the commented-out WRITE_ONCE() looks like leftover
debug code and should probably be dropped.  There are also several C99 //
comments in the file (next to BETA_PARAM_DEFAULT, in update_ack_rate() and
in update_srrtt()) which checkpatch flags as errors.

And in roccet_control() the pacing comment contradicts both the code and the
comment right below it:

	 * In Congestion Avoidance phase, set it to 120 % the current rate.
	...
		/* Pacing rate of 100%
		 * (instead of ipv4.sysctl_tcp_pacing_ca_ratio)
		 */
		rate *= 100;

[ ... ]

> +tcp_friendliness:
> +	/* TCP Friendly */
> +	if (tcp_friendliness) {
> +		u32 scale = beta_scale;
> +
> +		delta = (cwnd * scale) >> 3;
> +		while (ca->ack_cnt > delta) { /* update tcp cwnd */
> +			ca->ack_cnt -= delta;
> +			ca->tcp_cwnd++;
> +		}

[Severity: High]
Can this loop spin forever when delta is 0?  ca->ack_cnt is non-zero here
because "ca->ack_cnt += acked;" runs at the top of bictcp_update(), and
subtracting 0 never changes it, so there is no exit condition.

param_check() only rejects beta_param outside (0, 1024), and the surviving
values truncate beta_scale down far enough that (cwnd * scale) >> 3 is 0 for
small cwnd:

	beta_param = 300 -> beta_scale 4 -> delta 0 at cwnd 1
	beta_param = 200 -> beta_scale 3 -> delta 0 at cwnd <= 2
	beta_param = 1   -> beta_scale 2 -> delta 0 at cwnd <= 3

cwnd of 2 is reachable because roccet_congestion_event() clamps to a floor
of 2.  This runs in softirq context on the ACK path, so the CPU would stop
processing softirqs.

Unlike upstream CUBIC, which computes beta_scale once in
__init cubictcp_register(), this module recomputes it from beta_param on
every new socket, so a runtime write to the 0644 parameter reaches live
traffic.  Should the accepted range be tightened, or delta == 0 guarded?

[ ... ]

> +		if ((ca->curr_srrtt > sr_rtt_upper_bound &&
> +		     get_ack_rate_diff(ca) <= ack_rate_diff_ss) ||
> +		     (!tcp_is_cwnd_limited(sk) &&
> +		      ca->initial_round_completed)) {
> +			ca->epoch_start = 0;
> +
> +			/* Handle initial slow start.
> +			 * Most bufferbloat occurs here
> +			 */
> +			if (tp->snd_ssthresh == TCP_INFINITE_SSTHRESH) {
> +				tcp_sk(sk)->snd_ssthresh = tcp_snd_cwnd(tp)
> +								/ 2;
> +				/* since this is the initial slow start,
> +				 * the min cwnd won't be 1, so the window
> +				 * can't be set to 0 by accident.
> +				 * Halfing the cwnd will undo the previous step
> +				 * of slow start. Which is fine since the pipe
> +				 * is already full.
> +				 */
> +				tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
> +							 TCP_INIT_CWND));

[Severity: Medium]
Is the assumption in that comment always true?  cwnd == 1 together with
snd_ssthresh == TCP_INFINITE_SSTHRESH looks reachable:

tcp_enter_loss()
    WRITE_ONCE(tp->snd_ssthresh, icsk->icsk_ca_ops->ssthresh(sk));
        -> roccettcp_ssthresh() returns the unchanged TCP_INFINITE_SSTHRESH
    tcp_snd_cwnd_set(tp, tcp_packets_in_flight(tp) + 1);  /* == 1 */
tcp_set_ca_state(sk, TCP_CA_Loss)
    roccettcp_state() -> roccettcp_reset() -> state = LAUNCH

Taking this branch with cwnd == 1 stores snd_ssthresh = 0 while cwnd is
raised to TCP_INIT_CWND.  After that tcp_in_slow_start() can never be true
again (cwnd is never < 0), so roccet_control() never selects LAUNCH,
tcp_slow_start() is unreachable for the rest of the connection, and the
pacing branch "tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2" is dead.  cwnd of 2
or 3 gives snd_ssthresh 1.  Should there be a floor here?

> +			} else {

[ ... ]

> +		acked = tcp_slow_start(tp, acked);
> +		if (!acked)
> +			return;
> +
> +	} else if (ca->state == ORBITER) {

[Severity: Low]
The non-zero leftover returned by tcp_slow_start() means cwnd just reached
snd_ssthresh and the remaining credit should be applied in congestion
avoidance, which is what stock CUBIC does with bictcp_update() plus
tcp_cong_avoid_ai().  Here the LAUNCH branch just falls out of the if/else
chain, and ca->state only becomes ORBITER on the next roccet_control() call,
so the credit is dropped.  Was that intended?

[ ... ]

> +		send = tp->snd_nxt - ca->interval_snd_seq_start;
> +		received = tp->snd_una - ca->interval_una_seq_start;

[Severity: Low]
These are 32-bit sequence deltas, and the interval is five RTTs
(ca->next_srrtt_check = now + 5 * ca->curr_rtt).  If a flow advances more
than 4GiB within that interval the modulo totals invert the
send_more_than_acked comparison.  That needs roughly 34Gbit/s at a 200ms
RTT, so it is an extreme case, but should the totals be accumulated in u64?

[ ... ]

> +		roccet_xj = div_u64((u64)jitter * 100, ca->curr_min_rtt) +
> +			    sr_rtt_upper_bound;
> +		if (roccet_xj < sr_rtt_upper_bound)
> +			roccet_xj = sr_rtt_upper_bound;

[Severity: Low]
sr_rtt_upper_bound is a 0644 module parameter read here twice as a plain
load, and the second read is the wrap guard for the first.  Since sysfs
writes only take the module param mutex, which this softirq-context reader
does not hold, the compiler is free to reload it and defeat the guard.
Would a single READ_ONCE() snapshot into a local be better?  The LAUNCH exit
test reads sr_rtt_upper_bound and ack_rate_diff_ss the same way.

[ ... ]

> +static u32 roccettcp_ssthresh(struct sock *sk)
> +{
> +	return tcp_sk(sk)->snd_ssthresh;
> +}

[Severity: High]
With .ssthresh pointing at this getter, is there any multiplicative decrease
left on loss or RTO?

tcp_enter_loss() does:

	WRITE_ONCE(tp->snd_ssthresh, icsk->icsk_ca_ops->ssthresh(sk));

which stores the same value back, so snd_ssthresh is never reduced on RTO.
roccettcp_state() then calls roccettcp_reset() for TCP_CA_Loss, which
memsets the state, wiping ca->last_max_cwnd (CUBIC's W_max) and returning
the flow to LAUNCH.  roccettcp_recalc_ssthresh() returns cwnd unchanged
while tcp_in_slow_start(), and because .cong_control is provided
tcp_cong_control() returns before tcp_cwnd_reduction(), so PRR does not run
either.

After an RTO the flow slow-starts straight back to the same unreduced
ssthresh.  On a lossy or shallow-buffered path, where RTT never inflates and
the srRTT heuristic never fires, that leaves no back-off on loss at all.
Only the file header mentions that LAUNCH ignores loss; could the commit
message describe the RTO and ORBITER behaviour as well?

> +static u32 roccettcp_recalc_ssthresh(struct sock *sk)
> +{
> +	const struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +	u32 cwnd = tcp_snd_cwnd(tp);

[ ... ]

> +	if (ca->state == RTT_PROBE) {

[ ... ]

> +		/* Wmax and fast convergence */
> +		if (cwnd < ca->last_max_cwnd && fast_convergence)
> +			ca->last_max_cwnd =
> +				(cwnd * (BICTCP_BETA_SCALE + beta)) /
> +				(2 * BICTCP_BETA_SCALE);
> +		else
> +			ca->last_max_cwnd = cwnd;
> +
> +		cwnd = ca->cwnd_before_min_rtt_probe;

[Severity: Medium]
At this point cwnd still holds tcp_snd_cwnd(tp), which during a probe is the
deliberately deflated probe window; the assignment from
ca->cwnd_before_min_rtt_probe happens only afterwards and is used just to
recompute cwnd_before_min_rtt_probe.  Doesn't that contradict the comment
above ("we use the cwnd before the probing interval to calculate the cwnd
reduction ... it is very likely that congestion was caused by the cwnd value
before min RTT probing")?

With last_max_cwnd taken from the small probe window, once probing ends and
cwnd is restored to the larger pre-probe value, bictcp_update() sees
ca->last_max_cwnd <= cwnd and takes the

			ca->bic_K = 0;
			ca->bic_origin_point = cwnd;

path, skipping the concave region and growing convexly right after a
congestion event.

[ ... ]

> +static void roccet_in_ack_event(struct sock *sk, u32 flags)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	/* Handle ECE bit.
> +	 * Processing of ECE events is done in roccettcp_recalc_ssthresh()
> +	 */
> +	if (flags & CA_ACK_ECE)
> +		ca->ece_received = true;
> +}

[Severity: High]
Is roccettcp_recalc_ssthresh() actually reachable from the ECE path?  It is
only called from the TCP_CA_Recovery branch of roccettcp_state(), while a
pure ECN mark goes through:

tcp_try_to_open()
    tcp_enter_cwr()
        tcp_init_cwnd_reduction()
            WRITE_ONCE(tp->snd_ssthresh, ca_ops->ssthresh(sk));
        tcp_set_ca_state(sk, TCP_CA_CWR);

ca_ops->ssthresh is roccettcp_ssthresh(), which returns snd_ssthresh
unchanged, and roccettcp_state() has no TCP_CA_CWR branch.  Since
.cong_control is set, tcp_cong_control() also returns before
tcp_cwnd_reduction(), so PRR does not reduce cwnd either.

On an ECN-marked path without loss, does anything reduce ssthresh or cwnd?
The latched ece_received then appears to be applied much later as a stale
reduction at an unrelated Recovery event.  The v3 changelog says "Always
react to ECE bits and reset flag".

[ ... ]

> +	/* current rate is (cwnd * mss) / srtt
> +	 * In Slow Start [1], set sk_pacing_rate to 200 % the current rate.
> +	 * In Congestion Avoidance phase, set it to 120 % the current rate.

[ ... ]

> +	ca->initial_round_completed = true;
> +}

[Severity: Medium]
This is set unconditionally at the end of the first roccet_control() call
that has rs->acked_sacked != 0, but the field is documented as "Set to true
after the initial roccet-control round has completed" and
roccettcp_cong_avoid() relies on that meaning:

		 * This condition is checked only after the initial round of
		 * LAUNCH has completed. This is done in order to avoid false
		 * positives, which can occur when the tracked outstanding
		 * packets have not yet caught up to the initial cwnd.

Since there is no RTT or sequence-space round boundary test, the
"!tcp_is_cwnd_limited(sk) && ca->initial_round_completed" term can fire from
the second ACK onwards.  With cwnd 10 and only three packets in flight,
tcp_is_cwnd_limited() is false in slow start (10 < 2 * 3), so the exit runs
and leaves the flow permanently out of slow start at cwnd 10, growing only
via the cubic path afterwards.  Should the flag be set on a round boundary
instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/apWz9rPcGMgYCKOR%40volt-roccet-vm
