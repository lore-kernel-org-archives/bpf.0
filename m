Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C73E7635
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184062; cv=none; b=uXg8MdaVf5d8NerGmByj0QwCfYNmpIYqPtyjOnF/AzXhyPLsRkyLpJgzNaNXVyeRUK+HzVTsgW0npoev1gpbsgkyTOlX+QQnm6mpnAMyBnfsBCmHiul8mjyQ8c0dxchn45FIq/CqHtkk73bMo8L+Cgh7CLY3LtfN0ej2B2a4rTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184062; c=relaxed/simple;
	bh=sKms44Jz7nYWU3WWESN0uAuguLUQfpH6u69uHptIacc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=te/XuzJ2DsGHnzVI7RluiYereNpcpRdFnjbZrvY7A7k8L50Jqwlp0ay/zvZsy9vfKs/cZAibss5K6ibJTVpWEezTkI3MDPhqiS/XqpP33wgfOCV9YTr//F3xUFyhXy8FFJT5EGxtZvig7BuI+zA6QYcUqbH0EH69ibtqFnqrB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv8qt/I5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv8qt/I5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E154C1F00898;
	Wed, 23 Sep 2026 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790184057;
	bh=3e2YEzFEJIWLIMFbB+hKcP/dJcz3rgnd6r526CkNl/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uv8qt/I5BXqnlKoBveSiZlLyJgINAWzAYSno1w03xEJrnOSk7FUhpd58e5rGy8Txy
	 I14csKycLuoej6xYuKti2/Oi6rs1UDk2mZCUDpLsUKKjpzeC1/OJXTO8blv9C/RBe5
	 p0m/M5BGNfaMJxTmj7P29X9b8q/9o1EipIe7uAxh0DldANu4bLkERo+zToRaXN+pvg
	 wFodcyiKb69g0/dhVztAqgdSRgV/e3724CI8rFag+DdVguj1vMmtydwjxxvKGbfeu5
	 tT+tbH3hbOQ7tpGPjY6/WIHKVDMM5VssepUsjmm82Nu5l0UPEc8E868lrg1qJRQHff
	 V0ELofo9P3K8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv8 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <arK46Rr0cB7gJ7JS@volt-roccet-vm>
References: <arK46Rr0cB7gJ7JS@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:20:56 +0000
Message-Id: <20260923172056.E154C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] tcp_roccet: jiffies_to_usecs wrap-around traps state machine in DR=
AIN
- [High] tcp_roccet: unhandled DRAIN transition leaves jiffies in usecs fie=
ld
- [High] tcp_roccet: ignoring packet loss in LAUNCH phase violates RFC 5681
- [High] tcp_roccet: direct snd_cwnd assignment bypasses PRR pacing on reco=
very
- [Medium] tcp_roccet: idle period recovery discards first ACK burst in rat=
e tracking
- [Medium] tcp_roccet: 32-bit integer overflow in guard space limits throug=
hput
- [Low] tcp_roccet: struct roccettcp size exceeds ICSK_CA_PRIV_SIZE
--

commit d642a91b63f63d245583e8b6f4edc513976b1e3f
Author: Tim Fuechsel <t.fuechsel@gmx.de>

tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path. This is particularly a problem
with large buffers in mobile networks.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781
Link: http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..801b575e231aa
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1320 @@

[ ... ]

> +static void update_ack_rate(struct roccettcp *ca, u32 acked, u32 now)
> +{
> +	const s32 idle_threshold =3D USEC_PER_SEC * 2;
> +	const s32 interval =3D USEC_PER_MSEC * 100;
> +
> +	/* Check if the last interval has elapsed.
> +	 *
> +	 * Check via time_between32, so that idle connections
> +	 * (for more than U32_MAX/2 usecs), also trigger a new update
> +	 * and don't stall the ack-counting.
> +	 */
> +	bool interval_elapsed =3D !time_between32(now, ca->last_ack_rate_time
> +						  - interval,
> +						  ca->last_ack_rate_time
> +						  + interval);
> +
> +	if (interval_elapsed) {
> +		/* Check if the connection was idle for *idle_threshold*
> +		 * seconds (e.g. no ACK for X seconds). If so, reset the ack
> +		 * counting as if a new connection was created.
> +		 */
> +		if (!time_between32(now, ca->last_ack_rate_time
> +					- idle_threshold,
> +					ca->last_ack_rate_time
> +					+ idle_threshold)) {
> +			ca->ack_rate_last_rate =3D 0;
> +			ca->last_ack_rate_time =3D
> +				jiffies_to_usecs(tcp_jiffies32);
> +			ca->curr_ack_rate =3D 0;
> +			ca->ack_rate_cnt =3D 0;

[Severity: Medium]
Are the newly received ACKs lost during idle period recovery?

When recovering from an idle period, the ack_rate_cnt is zeroed, but the ac=
ked
parameter is completely ignored. This appears to incorrectly calculate the =
ACK
rate as zero for the first 100ms interval by discarding the first burst of
ACKs.

> +		} else {
> +			/* start counting for the new interval */
> +			ca->last_ack_rate_time =3D now;
> +			ca->ack_rate_last_rate =3D ca->curr_ack_rate;

[ ... ]

> +static void roccet_enter_min_rtt_probe(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	u32 interval, probe_cwnd;
> +
> +	/* If probing is already set, there was a mix up.
> +	 * Continue anyway so we can recover.
> +	 */
> +	if (ca->rtt_probe_timers_set)
> +		pr_warn_once("TCP ROCCET: Probing time should not be set when entering=
 RTT Probe\n");
> +
> +	/* Safeguard for an "infinite" probe. This should logically never
> +	 * happen but still safeguard it.
> +	 */
> +	if (ca->curr_rtt =3D=3D U32_MAX) {
> +		pr_warn_once("TCP ROCCET: curr_rtt is U32_MAX, cannot enter RTT_PROBE\=
n");
> +		ca->state =3D ORBITER;
> +		return;
> +	}
> +
> +	/* Use field to store when we entered min RTT probing. Here we use
> +	 * jiffies to stay consistent with the epoch_start format.
> +	 */
> +	ca->next_min_rtt_probe =3D tcp_jiffies32;

[Severity: High]
Could an interrupted state transition leave a jiffies timestamp permanently
stranded in the next_min_rtt_probe field?

In roccet_enter_min_rtt_probe(), next_min_rtt_probe is overloaded with a
tcp_jiffies32 value. If a packet loss or ECN triggers roccet_congestion_eve=
nt()
while in RTT_PROBE_REFILL, the state shifts directly to DRAIN.

When transitioning from DRAIN to ORBITER, roccet_handle_state_transitions()
fails to rewrite this timestamp (since prev_state is DRAIN, not a probe
state). Could this trap the connection in an infinite RTT_PROBE_ENTER loop
when ORBITER compares a large microsecond now against this small jiffies
value?

> +
> +	/* Start min RTT probing */

[ ... ]

> +static void roccet_orbiter_update(struct sock *sk, u32 acked)
> +{
> +	/* ORBITER: Increase the cwnd by using the CUBIC cwnd growth function,
> +	 * if no roccet congestion event is detected.
> +	 */
> +
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +	bool evaluate_srrtt =3D false;
> +	bool sent_more_than_acked =3D false;
> +	u32 roccet_xj, jitter, sent, received;
> +
> +	/* Enter DRAIN when roccet was recently triggered */
> +	if (ca->last_event_time_set &&
> +	    time_before32(now, ca->roccet_last_event_time_us +
> +			  100 * USEC_PER_MSEC)) {
> +		ca->state =3D DRAIN;
> +		return;
> +	}

[Severity: High]
Can jiffies_to_usecs() overflow and trap the connection in DRAIN?

At HZ=3D1000, jiffies_to_usecs(tcp_jiffies32) wraps around 32 bits every ~7=
1.58
minutes. If a connection lives for more than 35.79 minutes (2^31 microsecon=
ds)
without a congestion event, the time delta flips sign, causing time_before3=
2()
to erroneously evaluate to true on every subsequent packet.

> +
> +	/* Enter RTT_PROBE when the "timer" has expired.

[ ... ]

> +	/* Calculate if more bytes were sent than received
> +	 * in the time interval.
> +	 *
> +	 * Handle wrap arounds by relying on unsigned subtraction.
> +	 * e.g. if snd_nxt wraps to 10 and seq_start is U32_MAX - 10,
> +	 * the subtraction will result in the value of 21.
> +	 */
> +	sent =3D tp->snd_nxt - ca->interval_snd_seq_start;
> +	received =3D tp->snd_una - ca->interval_una_seq_start;
> +
> +	/* Check sent and received bytes from the previous interval.
> +	 * Here we use a guard space of 1% of the current cwnd.
> +	 * We do this to avoid a false positive evaluation due
> +	 * to delays caused by jitter or scheduling.
> +	 */
> +	sent_more_than_acked =3D
> +		sent >
> +		received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);

[Severity: Medium]
Can the multiplication of tcp_snd_cwnd(tp) and tp->mss_cache overflow here?

Since both are 32-bit unsigned integers, connections with high
bandwidth-delay products or large MTUs (e.g., Loopback with 64KB MSS) can
easily exceed 4.29 billion before the division by 100 occurs. This overflow
could falsely trigger a ROCCET congestion event and needlessly limit
throughput.

> +
> +	/* Check if it's time to evaluate the srRTT */

[ ... ]

> +static u32 roccet_recalc_ssthresh(struct sock *sk)
> +{
> +	const struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	u32 cwnd =3D tcp_snd_cwnd(tp);
> +
> +	/* In LAUNCH, we want no reduction on loss/ECN.
> +	 * On ECN this is set later on in roccet_state()
> +	 */
> +	if (ca->state =3D=3D LAUNCH)
> +		return cwnd;

[Severity: High]
By returning cwnd unchanged instead of scaling it down during fast recovery,
does this ignore packet drops in the initial slow start phase? Refusing to
back off when router buffers overflow appears to violate RFC 5681 and could
risk severe congestion collapse.

> +
> +	/* In min RTT probe, use the cwnd before the probe to not undershoot */

[ ... ]

> +static void roccet_state(struct sock *sk, u8 new_state)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	u32 cwnd;
> +	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +	enum roccet_state prev_state =3D ca->state;
> +
> +	if (new_state =3D=3D TCP_CA_Loss) {
> +		roccet_reset(sk, ca);
> +		tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
> +	} else if (new_state =3D=3D TCP_CA_CWR) {
> +		/* Handle CWR as ROCCET congestion event,
> +		 * however afterwards always set Wmax to the current cwnd
> +		 * except during min RTT probing.
> +		 */
> +		cwnd =3D tcp_snd_cwnd(tp);
> +		roccet_congestion_event(sk, now);
> +		if (ca->state !=3D RTT_PROBE_ENTER && ca->state !=3D RTT_PROBE &&
> +		    ca->state !=3D RTT_PROBE_REFILL)
> +			ca->last_max_cwnd =3D cwnd;
> +	} else if (new_state =3D=3D TCP_CA_Recovery) {
> +		/* Directly reduce cwnd and rely on pacing */
> +		cwnd =3D roccet_handle_recovery(sk);
> +		tcp_snd_cwnd_set(tp, cwnd);
> +	}

[Severity: High]
Does instantly halving the congestion window here bypass the internal
Proportional Rate Reduction (PRR) pacing mechanisms? By directly mutating
snd_cwnd inside the state machine callback, it appears the sender could be
artificially blocked from transmitting until a full half-window of ACKs
drains, causing large transmission stalls.

> +
> +	roccet_handle_state_transitions(sk, prev_state, now);

[ ... ]

> +static int __init roccet_register(void)
> +{
> +	int param_err;
> +
> +	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);

[Severity: Low]
Will this compile-time assertion fail deterministically?

The struct roccettcp requires 108 bytes of storage (24 u32s =3D 96 bytes,
3 u16s =3D 6 bytes, 2 bytes padding to align the 4-byte enum bitfield, maki=
ng
108 bytes). The BUILD_BUG_ON() enforces a 104-byte limit for
ICSK_CA_PRIV_SIZE, which would cause a build failure on all platforms.

> +
> +	/* Check for valid parameter ranges and then precompute factors */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arK46Rr0cB7gJ7JS@vo=
lt-roccet-vm?part=3D1
