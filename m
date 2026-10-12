Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C81D416C;
	Mon, 12 Oct 2026 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797855; cv=none; b=CnM5/Gn0IT+dgR6fuBBK0Hc5bzucG9JH/dvEUpgJHRy7kNXtMbawxhtEpzAYsQUQfteJwG4bOoMSKdvzoO+UA/sWkgtpl4PuokkFZFszNfciYqXlDczSldCFcRrTXSi+idtz/py0zUek47lj/jbaYPdQBhJuDQ0JIkxWY0J7/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797855; c=relaxed/simple;
	bh=kK0UvBidDgbE97m85kzhShE08Bxv4OAbrll2PPDnhXg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PL4ITqjF5MHt2q899N0vjlMmNNmLtrxUItL2itqhRenTt/p2o/L9BaPv1LNEOnFQ7UQ1pJplLf+wAH5zSPxPD6u+DPp6eBd2XJsWSDUgmCtVYLu2kiXZB8U8m+n1HBuSqi3o/oPGQnaNK4Q+xj9115UaqUHUp5cUBBNQny2SnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPN2kjXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPN2kjXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71EC1F0089C;
	Mon, 12 Oct 2026 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791797853;
	bh=6mITeelcV9vEWKJAq1KN2FstR0M0lotLs+MgL5oFgFg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nPN2kjXOCAZ+0nvBP6s/PcpvA/qYdFz0GmUaA1mrnu6vgx1dbIEF9Y6CUSCwWFkBQ
	 ccZ5/2d9P7aob1pbwlL+dB8gRZ32W9enyw7vAXZDS3aEHXh/wZph5vYoz8Iwc8Qvmh
	 Wky4BtzOc22kFIlden8ZadVhY2FgML/APySUoVYqOf/dVInlXioWf/sfc3RLU0J0Jz
	 H15u8r4WlbSYPzQv8v2eSNlPSFkuOeM4tjFuOI52Nj/erdJWMuE6YFSJRq3lvF0itH
	 9WURFjgFfNo4ZyWWOF6G9XHrGGa3vqGNlRzAvwkwN1N+HD+KyFmTnE2nUhpiFsBIS2
	 ej1wwx6NBjQcQ==
Subject:
 Re: [PATCHv10 net-next] tcp: Add TCP ROCCET congestion control module.
From: netdev-bot+sashiko@kernel.org
To: t.fuechsel@gmx.de
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 fmancera@suse.de, ebiggers@kernel.org, bpf@vger.kernel.org,
 lukas.prause@ikt.uni-hannover.de
Date: Mon, 12 Oct 2026 09:37:32 +0000
Message-ID: <179179785248.434549.16829837649351382748@kernel.org>
In-Reply-To: <asdfdDIQb7Nhm692@volt-roccet-vm>
References: <asdfdDIQb7Nhm692@volt-roccet-vm>
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

Critical: 0 · High: 0 · Medium: 7 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] roccet_acked() copies CUBIC's 'discard delay samples right
  after fast recovery' test, `ca->epoch_start && (s32)(tcp_jiffies32 -…
- [Medium] tcp_slow_start_after_idle_check() returns early when
  ca_ops->cong_control is set, so roccet_cwnd_event_tx_start() is the…
- [Medium] roccet_tcp pairs .undo_cwnd = tcp_reno_undo_cwnd with a
  set_state(TCP_CA_Loss) handler whose effect undo cannot reverse.
- [Medium] roccet_enter_min_rtt_probe() (line 537) stores tcp_jiffies32
  in ca->next_min_rtt_probe, a field that otherwise holds a usec…
- [Medium] roccet_cwnd_event_tx_start() treats the RTO retransmission
  itself as an idle restart and overwrites the ssthresh that…
- [Medium] roccet_enter_min_rtt_probe() computes probe_cwnd = max(cwnd/2
  or cwnd/3, TCP_INIT_CWND) and sets cwnd = min(probe_cwnd, clamp), with…
- [Medium] Example: in RTT_PROBE with cwnd_before_min_rtt_probe = 100 and
  a live cwnd of 50, a fast-recovery event occurs.
- [Low] beta_param_set() validates the string with kstrtoint(val, 10,
  ...) and then stores it with param_set_int(val, kp).
- [Low] In struct roccettcp, curr_rtt is documented as the 'last sample
  rtt of current round' and last_rtt as the 'sample rtt of previous…
- [Low] Because ROCCET has .cong_control, the core idle restart in
  tcp_skb_entail() → tcp_slow_start_after_idle_check() is skipped.
- [Low] roccet_cwnd_event_tx_start() writes tp->snd_ssthresh with a plain
  store (`tp->snd_ssthresh = tcp_snd_cwnd(tp);`).

--

tcp: Add TCP ROCCET congestion control module.

This patch adds TCP ROCCET, a congestion control module based on CUBIC.
It detects bufferbloat in cellular networks from the relative RTT increase
(srRTT) and the ACK arrival rate. It replaces slow start with its own
LAUNCH phase, uses CUBIC growth in ORBITER, and periodically probes for a
new minimum RTT.

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..04b9e52466126
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1408 @@

[ ... ]

> +struct roccettcp {

[ ... ]

> +	u32 curr_rtt;	/* last sample rtt of current round */

[ ... ]

> +	u32 last_rtt;	/* sample rtt of previous round.
> +			 * Used for jitter calculation
> +			 */

[Severity: Low]
This isn't a bug, but these comments describe per-round samples.
roccet_acked() actually shifts curr_rtt into last_rtt on every accepted
ACK sample. It does not look for round boundaries:

	ca->last_rtt = ca->curr_rtt;
	ca->curr_rtt = sample->rtt_us;

So the jitter that roccet_orbiter_update() uses for roccet_xj is the
difference between consecutive ACK samples, not between rounds.

Should the comments be updated, or was a per-round sample intended?

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
Do the two parses here agree? The candidate is checked with
kstrtoint(val, 10, ...). param_set_int() comes from STANDARD_PARAM_DEF()
in kernel/params.c and parses with base 0:

	return strtolfn(val, 0, (type *)kp->arg);

So beta=0717 passes the check as decimal 717 but is stored as octal 463.
beta=0x2cd is rejected, even though param_set_int() would accept it.

The stored value stays in range, but it can differ from the value that
was checked. Could this store beta_candidate directly, or parse with the
same base in both places?

[ ... ]

> +static void roccet_min_rtt_probe_ce(struct roccettcp *ca, u32 cwnd)
> +{

[ ... ]

> +	if (ca->cwnd_before_min_rtt_probe == 0)
> +		pr_warn_once("TCP ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PROBE. This should not happen.\n");
> +	else
> +		cwnd = ca->cwnd_before_min_rtt_probe;
> +
> +	ca->cwnd_before_min_rtt_probe =
> +		max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +}

[Severity: Medium]
Can a spurious recovery during RTT_PROBE leave a lasting reduction
through this saved window?

Take cwnd_before_min_rtt_probe = 100 and a live cwnd of 50 during the
probe. Entering fast recovery then does:

tcp_enter_recovery()
    tcp_init_cwnd_reduction()
        tp->prior_cwnd = 50
        roccet_recalc_ssthresh()   <- uses cwnd_before_min_rtt_probe (100)
    tcp_set_ca_state(sk, TCP_CA_Recovery)
        roccet_state()
            roccet_handle_recovery()
                roccet_min_rtt_probe_ce()
                    cwnd_before_min_rtt_probe = 100 * 717 / 1024 = 70

Suppose DSACK later shows the recovery was spurious.
tcp_undo_cwnd_reduction() calls tcp_reno_undo_cwnd(), which returns
max(cwnd, prior_cwnd) = 50. It never touches cwnd_before_min_rtt_probe.

When the probe ends, roccet_min_rtt_probe() installs the reduced value:

	tcp_snd_cwnd_set(tp, min(ca->cwnd_before_min_rtt_probe,
				 tp->snd_cwnd_clamp));

So cwnd becomes 70 instead of 100. An undo after the probe ends can't
get back to 100 either, because prior_cwnd holds 50.

Should the undo path also restore the saved probe window?

[ ... ]

> +static void roccet_enter_min_rtt_probe(struct sock *sk, u32 now)
> +{

[ ... ]

> +	/* Use field to store when we entered min RTT probing. Here we use
> +	 * jiffies to stay consistent with the epoch_start format.
> +	 */
> +	ca->next_min_rtt_probe = tcp_jiffies32;

[Severity: Medium]
This stores a jiffies value in a field that otherwise holds a usec
deadline. roccet_set_next_min_rtt_probe_ts() won't update it while the
state is RTT_PROBE or RTT_PROBE_REFILL.

roccet_handle_state_transitions() converts it back to a usec deadline in
only two cases: RTT_PROBE or RTT_PROBE_REFILL to ORBITER, and
RTT_PROBE_REFILL to DRAIN.

What happens if the application is idle for longer than an RTO during
the probe or refill window? roccet_cwnd_event_tx_start() then moves
straight to LAUNCH:

		ca->state = LAUNCH;

Only the probe timers are cleared on that transition, so
next_min_rtt_probe keeps the jiffies value.

Later LAUNCH to ORBITER or DRAIN to ORBITER transitions don't take the
prev_state == RTT_PROBE* branch. roccet_orbiter_update() then compares a
usec now against a jiffies deadline:

	if (!time_between32(now, ca->next_min_rtt_probe
				 - 2 * ROCCET_NEXT_MIN_RTT_PROBE_MS
				 * USEC_PER_MSEC, ca->next_min_rtt_probe) &&
	    ca->curr_rtt != U32_MAX) {
		ca->state = RTT_PROBE_ENTER;

This is true for nearly every value of now. Wouldn't ROCCET then enter
RTT_PROBE_ENTER right away and cut cwnd for at least 200 ms with no need
to probe? The only way out seems to be update_min_rtt() finding a new
minimum first.

On the same RTT_PROBE to LAUNCH path, ssthresh is also set from the
reduced probe cwnd, and cwnd_before_min_rtt_probe is never applied. Is
that intended?

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
> +	tcp_snd_cwnd_set(tp, min(probe_cwnd, tp->snd_cwnd_clamp));

[Severity: Medium]
Can this raise cwnd during the drain probe?

In ORBITER, cwnd can be anywhere from 2 to 9 after
roccet_congestion_event() or roccet_handle_recovery() reduce it to
max(cwnd * beta / 1024, 2). probe_cwnd is not limited by the current
cwnd, so it becomes TCP_INIT_CWND (10). The probe then sends more than
before for at least 200 ms.

curr_min_rtt has just been reset to U32_MAX, so the new minimum is
measured with more data in flight than before the probe. That can
inflate curr_min_rtt and lower srRTT for the following probe period.

For 10 < cwnd < 20, the reduction is also smaller than the halving
described in the commit message.

[ ... ]

> +static void roccet_cwnd_event_tx_start(struct sock *sk)
> +{

[ ... ]

> +	/* After idle periods, go into LAUNCH with slow start */
> +	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_slow_start_after_idle) &&
> +	    delta >= inet_csk(sk)->icsk_rto) {
> +		tp->snd_ssthresh = tcp_snd_cwnd(tp);
> +		tcp_snd_cwnd_set(tp, min(TCP_INIT_CWND, tp->snd_cwnd_clamp));
> +		ca->state = LAUNCH;
> +	}

[Severity: Medium]
ROCCET sets .cong_control, so tcp_slow_start_after_idle_check() returns
early:

	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_slow_start_after_idle) ||
	    tp->packets_out || ca_ops->cong_control)
		return;

That makes this the only restart-after-idle logic that runs. Should it
follow what tcp_cwnd_restart() does?

	u32 restart_cwnd = tcp_init_cwnd(tp, __sk_dst_get(sk));
	...
	WRITE_ONCE(tp->snd_ssthresh, tcp_current_ssthresh(sk));
	restart_cwnd = min(restart_cwnd, cwnd);

Compared to that, this code differs in a few ways:

There is no min() against the current cwnd. A cwnd of 2 to 9, which is
common after the beta reductions, is raised to 10 after idle.

The per-route initcwnd from tcp_init_cwnd() is ignored.

ssthresh is set to the old cwnd instead of tcp_current_ssthresh().

The trigger is delta >= icsk_rto, while the core uses delta > icsk_rto.

The comment says this goes into LAUNCH with slow start. But if the old
cwnd is at most 10, ssthresh ends up at or below the new cwnd. Then
tcp_in_slow_start() is false, and roccet_launch_update() leaves LAUNCH
right away through its !tcp_in_slow_start(tp) branch. Is that intended?

[Severity: Medium]
Can this also fire on the RTO retransmission itself, and not only after
a real idle period?

tcp_retransmit_timer()
    tcp_enter_loss()
        tcp_timeout_mark_lost()      <- in_flight drops to 0
        ->ssthresh()
        tcp_set_ca_state(sk, TCP_CA_Loss)
            roccet_state()           <- cwnd = 10, ssthresh = max(ssthresh, 10)
    tcp_retransmit_skb()
        __tcp_transmit_skb()
            tcp_event_data_sent()
                tcp_ca_event(sk, CA_EVENT_TX_START)
                    roccet_cwnd_event_tx_start()

tcp_event_data_sent() fires CA_EVENT_TX_START before it updates
lsndtime:

	if (tcp_packets_in_flight(tp) == 0)
		tcp_ca_event(sk, CA_EVENT_TX_START);

	tp->lsndtime = now;

At that point lsndtime is the previous send, for example the TLP probe
or the previous retransmission. The RTO timer was armed for icsk_rto
from about that time, so delta >= icsk_rto holds.

With the default slow_start_after_idle=1, this replaces the ssthresh
that roccet_state(TCP_CA_Loss) just kept with 10, and sets LAUNCH.

On the next ACK, roccet_launch_update() sees cwnd == ssthresh == 10 and
leaves LAUNCH at once. CUBIC then grows again from 10 with
last_max_cwnd = 0 (cleared by roccet_reset()), instead of slow starting
back toward the old ssthresh.

The core tcp_slow_start_after_idle_check() avoids this case with its
tp->packets_out test. Should this path also check packets_out or
icsk_ca_state?

[Severity: Low]
Does the restart window apply too late for the first skb after idle?

This runs from CA_EVENT_TX_START inside __tcp_transmit_skb(). By that
point, tcp_write_xmit() has already sized the skb using the pre-idle
cwnd:

tcp_write_xmit()
    cwnd_quota = tcp_cwnd_test(tp);
    ...
    limit = tcp_mss_split_point(sk, skb, mss_now, cwnd_quota, nonagle);
    ...
    tcp_transmit_skb(sk, skb, 1, gfp)
        tcp_event_data_sent()
            roccet_cwnd_event_tx_start()   <- cwnd cut to 10 here

The core restart, tcp_skb_entail()->tcp_slow_start_after_idle_check(),
runs before transmission, but it is skipped for cong_control modules.

So the first GSO packet after idle can carry far more than 10 segments.
It is bounded only by tcp_tso_autosize() at the old pacing rate and by
gso_max_segs. The pacing rate is not updated until the next ACK either.

[Severity: Low]
Should the ssthresh store here be
WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp))?

tcp_get_timestamping_opt_stats() reads the field without a lock:

	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, READ_ONCE(tp->snd_ssthresh));

Every other snd_ssthresh store in this module uses WRITE_ONCE(), and
KCSAN would likely report this plain store.

[ ... ]

> +static void roccet_state(struct sock *sk, u8 new_state)
> +{

[ ... ]

> +	if (new_state == TCP_CA_Loss) {
> +		roccet_reset(sk, ca);
> +		tcp_snd_cwnd_set(tp, min(TCP_INIT_CWND, tp->snd_cwnd_clamp));
> +		WRITE_ONCE(tp->snd_ssthresh, max(tp->snd_ssthresh,
> +						 tcp_snd_cwnd(tp)));

[Severity: Medium]
What happens to the ROCCET state if this RTO later turns out to be
spurious?

roccet_reset() clears the private state, including the last_max_cwnd
that roccet_recalc_ssthresh() just computed, and forces state = LAUNCH.

.undo_cwnd is tcp_reno_undo_cwnd. So after F-RTO or tcp_try_undo_loss(),
tcp_undo_cwnd_reduction() restores only cwnd and ssthresh:

	tcp_snd_cwnd_set(tp, icsk->icsk_ca_ops->undo_cwnd(sk));
	if (tp->prior_ssthresh > tp->snd_ssthresh) {
		WRITE_ONCE(tp->snd_ssthresh, tp->prior_ssthresh);

The next set_state(TCP_CA_Open) matches none of the branches in
roccet_state(), so ROCCET stays in LAUNCH.

tcp_fastretrans_alert() runs before tcp_cong_control() in tcp_ack(). So
on the same ACK, roccet_launch_update() sees cwnd >= ssthresh. For a flow
that was in ORBITER, prior_ssthresh is max(ssthresh, 3/4 cwnd), which is
at most cwnd. It then takes the !tcp_in_slow_start(tp) exit:

		new_cwnd = tcp_snd_cwnd(tp) - (tcp_snd_cwnd(tp) / 3);

Doesn't this cut cwnd by a third right after the core undid the
reduction?

[ ... ]

> +static void roccet_acked(struct sock *sk, const struct ack_sample *sample)
> +{

[ ... ]

> +	/* Check if we are right after fast recovery. */
> +	after_fast_recovery = ca->epoch_start &&
> +			      (s32)(tcp_jiffies32 - ca->epoch_start) < HZ;
> +
> +	/* If we are not after fast recovery or we are in RTT_PROBE however,
> +	 * we want to record every new min-sample.
> +	 */
> +	if (!after_fast_recovery || ca->state == RTT_PROBE) {
> +		/* Get valid sample for roccet */
> +		if (sample->rtt_us > 0) {
> +			ca->last_rtt = ca->curr_rtt;
> +			ca->curr_rtt = sample->rtt_us;
> +		}
> +	}

[Severity: Medium]
Does this freeze curr_rtt and last_rtt for one second after every epoch
start, not just after fast recovery?

In cubictcp_acked(), the same test only gates delay_min and HyStart:

	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
		return;

Here it also gates the curr_rtt and last_rtt updates. Only RTT_PROBE is
exempt.

epoch_start is set to 0 on every LAUNCH exit, ROCCET congestion event,
CWR and Recovery. The next bictcp_update() in ORBITER then sets it to
tcp_jiffies32. roccet_cwnd_event_tx_start() also clamps it to now after
idle. Each of these starts a one second window with no new RTT samples.

During that window, roccet_control() still runs the EWMA on every ACK
using the same stale curr_rtt:

	if (rs->acked_sacked > 0) {
		update_min_rtt(ca);
		update_srrtt(ca);
	}

srRTT then converges toward the rRTT of a single stale sample, often the
inflated RTT that caused the reduction. Jitter is frozen as well.

next_srrtt_check_ts is at most one second away. Wouldn't the next srRTT
evaluation and roccet_xj in roccet_orbiter_update() be computed from this
frozen data?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/asdfdDIQb7Nhm692%40volt-roccet-vm
