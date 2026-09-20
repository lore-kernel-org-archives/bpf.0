Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64636B932
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899565; cv=none; b=mcN5CoPtcjT9AG8J4/0f2zRV46MflpKrXkNpdAd7gRV1Z2E2lY6wTlKnh42KdRqUF7gcJ8D0aJNRZMS0THsu3NK5qs2AKEtNavQGJ/fc+0T9z/reFaKTCmqh4IEXNrgGjZowKt27TGeDnpjkLyhPb6aIIgjWtfeypOBozMxZ91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899565; c=relaxed/simple;
	bh=3lSgNJTq6TkCX7TJccmvCgrIDfrVJvsZxZSea6k4N+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HDWtO9dH6Jco3lEwRxZFfjglOy8+2XctFtAmMXeZgJ7vMB45pK4vSDrFxUkm08GGLs4zO2emexUmRrvmw2KUFXPN9NB972awYVmzAKgcyh+28BxclaYto4L4p+hubGJ7CwGtYLqdQVB6y7WAhkU9z9q6kCEn2z8a7s0FcpioMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/ZYJPLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/ZYJPLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A411F000FF;
	Sun, 20 Sep 2026 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789899563;
	bh=WkWezWAUbTTSglqCsZuyRfBpHxYR2IKTJZM57And5R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/ZYJPLL0DIcNYY6G4HDXDK05aTcZKO2i33pTsuICNaT4p2sWX5EvpisrZbZnG1Rm
	 ckw0GtcR7f85dNDjMzAxXTeH3ps9lp9XqelYg9vNAD3oqI/g8tQYPsPdqXMRAuCuEv
	 IHg+t2H5Jj0KvoQlU8jlejKO82yNoUgr9isqhhuO4JlJu5pQ+n5eawmAdQD1BQujTC
	 mCjAucqCNHMLTBpUuO13/yONrwwDM86BzQs682ffJfod1nFE2NzGTeK+IcyI96c8Aa
	 2gEUJd+AwtOQlc+bn9gEquYyf52Rrmtt3GtECjA7+QMOXSwPu1gsMX7wrc5rcH/oz9
	 1mPpocjsVJTnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <aq5hgNNRLEpZq2YN@volt-roccet-vm>
References: <aq5hgNNRLEpZq2YN@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 10:19:22 +0000
Message-Id: <20260920101923.19A411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] tcp_roccet: u16 cap on ack_rate_cnt breaks congestion control on n=
etworks >7.5 Gbps
- [High] tcp_roccet: manual cwnd overwrite in TCP_CA_Recovery bypasses PRR =
causing transmission stalls
- [High] tcp_roccet: failure to reset CUBIC epoch after min RTT probing cau=
ses massive window explosion
- [High] tcp_roccet: TCP_CA_CWR clobbers last_max_cwnd with probe_cwnd
- [Medium] tcp_roccet: u32 microsecond timestamp wrap-around breaks state m=
achine on long-lived connections
- [Medium] tcp_roccet: missing sequence variable reset causes false congest=
ion event in ORBITER
--

commit d8de274f7707cb0e244064b9be8590436345da92
Author: Tim Fuechsel <t.fuechsel@gmx.de>

tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781
Link: http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..db26fce0c00ed
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1278 @@

[ ... ]

> +	u32 ack_carry_over;	/* Used to carry over leftover acks from
> +				 * LAUNCH to ORBITER
> +				 */
> +
> +	u32 ack_rate_last_rate_time;	/* Timestamp of the last ACK-rate */
> +	u16 ack_rate_last_rate;	/* Last ACK-rate */
> +	u16 ack_rate_curr_rate;	/* Current ACK-rate */

[Severity: High]
Does this u16 type break congestion control on high-speed networks (>7.5 Gb=
ps
at 1500 MSS)?

On high-speed networks, the packet rate can exceed 65,535 packets per 100ms.
Using u16 limits the maximum rate that can be tracked, which causes both
ack_rate_curr_rate and ack_rate_last_rate to saturate at 65535.

When get_ack_rate_diff() returns 0, it falsely triggers a bandwidth plateau
and an immediate exit from slow start, completely limiting throughput on
high-speed connections.

> +	u16 ack_rate_cnt;	/* Used for counting acks */
> +
> +	enum roccet_state state : 3; /* Current operating state of roccet */

[ ... ]

> +/* Update ack rate sampled by 100ms.
> + */
> +static void update_ack_rate(struct roccettcp *ca, u32 acked, u32 now)
> +{
> +	const s32 idle_threshold =3D USEC_PER_SEC * 2;
> +	const s32 interval =3D USEC_PER_MSEC * 100;
> +
> +	s32 time_delta =3D (s32)(ca->ack_rate_last_rate_time - now);
> +
> +	/* Check if the time has arrived in the new interval.
> +	 * Alternatively if the connection was considered to be idle,
> +	 * also treat as a new interval in order to avoid timing-overflow
> +	 * problems.
> +	 */
> +	if (time_delta < -interval || ca->was_idle) {

[Severity: Medium]
Will this arithmetic fail and break the state machine on long-lived connect=
ions
due to u32 microsecond timestamp wrap-around?

The now timestamp is derived by converting tcp_jiffies32 to microseconds
in roccet_control() and storing it in a u32. This causes the 32-bit timesta=
mp
to overflow and wrap around every ~71.5 minutes (at HZ=3D1000).

If the connection is idle for more than ~36 minutes (2^31 microseconds),
time_delta evaluates to a large positive value instead of negative.
This causes the timeout checks (time_delta < -interval and
time_delta < -idle_threshold) to fail.

Failing the check prevents the ACK rate metrics from resetting after a long
idle period, which leads to corrupted bandwidth state and false slow-start
exits.

> +		/* Check if the connection was idle for X seconds
> +		 * (e.g. no ACK for X seconds)
> +		 */

[ ... ]

> +			/* start counting for the new interval */
> +			ca->ack_rate_last_rate_time =3D now;
> +			ca->ack_rate_last_rate =3D ca->ack_rate_curr_rate;
> +			ca->ack_rate_curr_rate =3D ca->ack_rate_cnt;
> +			ca->ack_rate_cnt =3D min_t(u32, acked, U16_MAX);
> +		}
> +
> +		ca->was_idle =3D false;
> +	} else {
> +		/* Cap the ack count to avoid overflow */
> +		ca->ack_rate_cnt =3D min_t(u32, ca->ack_rate_cnt + acked,
> +					 U16_MAX);

[Severity: High]
Does this explicit U16_MAX capping break congestion control on high-speed
networks (>7.5 Gbps)?

Similar to the u16 type issue in struct roccettcp above, capping the
ack_rate_cnt limits the maximum measurable ACK rate. On high-speed
connections, this will falsely trigger a bandwidth plateau.

> +	}
> +}

[ ... ]

> +static void roccet_rtt_probe_refill(struct roccettcp *ca, u32 now)
> +{
> +	/* Once the refill interval is over, we can end the probing phase. */
> +	if (time_after32(now, ca->refill_until)) {
> +		/* End min RTT probing phase. */
> +		ca->state =3D ORBITER;

[Severity: High]
Does returning to ORBITER without resetting the CUBIC epoch_start cause a
massive window explosion?

roccet_enter_min_rtt_probe() enters a probing phase lasting at least 200ms
without resetting the CUBIC epoch_start. During probing, normal CUBIC growth
is paused.

Upon returning to ORBITER here, bictcp_update() resumes and calculates t
based on the un-reset epoch_start. Since t suddenly includes the >200ms
probing duration, the CUBIC target curve calculation (bic_target) spikes
enormously.

This leads to an extremely aggressive and completely unsafe burst in window
growth immediately after probing finishes.

> +	}
> +}

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

[Severity: Medium]
Will these deltas incorrectly evaluate the entire connection's lifetime
during the first ORBITER check, causing a false congestion event?

interval_snd_seq_start and interval_una_seq_start are initialized only at
connection start (roccet_reset()). When transitioning to ORBITER,
roccet_handle_state_transitions() initializes the 5-RTT timer but fails to
reset these sequence tracking variables.

During the very first timer expiration, sent and received are computed
against the connection-start values. Consequently, sent - received equates
to the total unacknowledged bytes in flight.

Since bytes in flight generally mirrors cwnd, the condition
(sent > received + (cwnd * mss / 100)) is almost guaranteed to be true,
falsely triggering an immediate congestion event if jitter is slightly high.

> +
> +	/* Check sent and received bytes from the previous interval.
> +	 * Here we use a guard space of 1% of the current cwnd.
> +	 * We do this to avoid a false positive evaluation due

[ ... ]

> +/* Checks for state roccet-transitions and performs necessary state (re)=
sets.
> + * This is done in order to avoid the possibility of forgetting to corre=
ctly
> + * set a state when entering certain states.
> + *
> + * This is used whenever a state change is possible
> + * (e.g. in roccet_state() or roccet_control()).
> + */
> +static void roccet_handle_state_transitions(struct roccettcp *ca,
> +					    enum roccet_state prev_state,
> +					    u32 now)
> +{
> +	if (ca->state =3D=3D prev_state)
> +		return;
> +
> +	/* When we exit LAUNCH we can be sure that we are no longer in the
> +	 * initial_launch. Even on LAUNCH to LAUNCH transitions (on RTO).
> +	 */
> +	if (prev_state =3D=3D LAUNCH)
> +		ca->is_in_initial_launch =3D false;
> +
> +	/* Whenever we enter ORBITER, we need to schedule the next SRTT check.
> +	 * This will be set before evaluating the next_srrtt_check_ts condition
> +	 * as this is only done in ORBITER.
> +	 */
> +	if (ca->state =3D=3D ORBITER)
> +		ca->next_srrtt_check_ts =3D now + 5 * ca->curr_rtt;

[Severity: Medium]
Does this transition fail to reset the sequence tracking variables for the
upcoming ORBITER phase evaluation?

As mentioned in roccet_orbiter_update(), failing to reset
interval_snd_seq_start and interval_una_seq_start here causes false
congestion events.

> +
> +	/* Whenever we leave the min RTT probing states (and not just

[ ... ]

> +/* Handle different loss-states and perform adequate cwnd reductions.
> + */
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
> +		tcp_snd_cwnd_set(tp, 1);
> +	} else if (new_state =3D=3D TCP_CA_CWR) {
> +		/* Handle CWR as ROCCET congestion event,
> +		 * however afterwards always set Wmax to the current cwnd.
> +		 */
> +		cwnd =3D tcp_snd_cwnd(tp);
> +		roccet_congestion_event(sk, now);
> +		ca->last_max_cwnd =3D cwnd;

[Severity: High]
Does this overwrite the true capacity record with the transient probing win=
dow?

During the RTT_PROBE state, the congestion window is artificially slashed to
probe_cwnd to drain the buffer. If an ECN mark triggers TCP_CA_CWR during
this probing phase, roccet_state() unconditionally executes
ca->last_max_cwnd =3D cwnd using the current (artificially shrunken) cwnd.

This completely overwrites CUBIC's history of the actual link capacity with
the low probing window. When probing concludes and normal operations resume,
CUBIC calculates its curve based on an entirely wrong max capacity origin,
permanently crippling throughput performance.

> +	} else if (new_state =3D=3D TCP_CA_Recovery) {
> +		/* Directly reduce cwnd and rely on pacing */
> +		cwnd =3D roccet_handle_recovery(sk);
> +		tcp_snd_cwnd_set(tp, cwnd);

[Severity: High]
Does this manual cwnd overwrite in TCP_CA_Recovery bypass Proportional Rate
Reduction (PRR) and cause transmission stalls?

When entering TCP_CA_Recovery, roccet_state() directly sets
tcp_snd_cwnd_set(tp, cwnd) to the halved target value.
The standard Linux TCP architecture relies on PRR to smoothly decrease the
actual window in response to ACKs, based on the new ssthresh.

Instantly forcing the window down to its final target value means packets_o=
ut
will suddenly massively exceed cwnd, causing the sender to halt all
transmission until the entire excess drains. This results in a severe burst
of silence and stalled data flow during recovery.

> +	}
> +
> +	roccet_handle_state_transitions(ca, prev_state, now);
> +}

[ ... ]

> +static void roccet_control(struct sock *sk, u32 ack, int flag,
> +			   const struct rate_sample *rs)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	u32 now =3D jiffies_to_usecs(tcp_jiffies32);

[Severity: Medium]
Will this timestamp wrap around every 71.5 minutes and break the state mach=
ine?

As noted in update_ack_rate(), this calculation produces a 32-bit microseco=
nd
timestamp that wraps around, leading to arithmetic failures when the
connection is idle.

> +	enum roccet_state prev_state =3D ca->state;
> +
> +	/* Update ack rate. Even on no new acks/sacks. */
> +	update_ack_rate(ca, rs->acked_sacked, now);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aq5hgNNRLEpZq2YN@vo=
lt-roccet-vm?part=3D1
