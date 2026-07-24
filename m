Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101138A29A
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880716; cv=none; b=TNv4/yKP3xUGGQsqigYBK31k5oj197z4gh6J/yPeWo/LiaTLMVx3iO1z0bC5jp42uQIViZTJn5DZIFx6C9mXqLef0GCEUowRnNE4nQ+Xrvxz1om+5E8C6EL79dVyjT9TbAUsomJLoxIChwqfwg8QGbJ7+EYoOmEsGT33nZ0dBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880716; c=relaxed/simple;
	bh=LNOucPqHj+IIuYCNxNrl92dO3dY6Bg1RKr298HN1Ouw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HWtLWps9Kx6PBWMF7R/Fx7fP2PyTQCjNdzgYPFjZdhD10e4sHGliMaVI2ZWmIculjPnqp9MSlkrroDA6TBp0h9ILGaAm+Oi4rP9BwzKGSqRYFhJRlyBrKQz28hv3YeTLGLXlDhWUdwe6oqFHoCv6KnappMEjW/8A+P9dEQXdsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ankf9U9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ankf9U9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5911E1F000E9;
	Fri, 24 Jul 2026 08:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784880714;
	bh=L1m2zB8twxbc+xOS9XxkBddPA8mtIsiWMT+QOQR85Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ankf9U9O2X5F42UQtzs86oYjWYZArZvZq5PazSV9L0nv/x+Xbu/pYkakaOfKaApmj
	 IjtULp0gH/oYq29diCi4OyHx+pbxUTq1nzpj8i4WWG2pOVht7wgwC3Osw13B8KQj+/
	 UvrRakTTW9jDUmqfRVuMKF52TQtuguhy5uTJF0J0z4/lUJWVsyaiwdW0B9xPsa7Q3Y
	 vbJs+s8XJEost0NB+lq7swScNxhYoqZIUly2Rb5nxpOsRd8W88mGdzUnykwNsnRSCi
	 qMOrsxnPn5DmCuYU51RX5IVrfisg4OM+PdsTuFLZP+B5rLEw+16On3kEsKG2UtVQsB
	 6wb6cVYM2Z97g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <amHMvwtUk6CocMBr@volt-roccet-vm>
References: <amHMvwtUk6CocMBr@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 08:11:53 +0000
Message-Id: <20260724081154.5911E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] `.cong_control` bypasses core PRR logic and actively increases=
 CWND during loss recovery.
- [High] Incorrect sequence number wrap-around handling using `before()` ca=
uses spurious massive delta values and off-by-one errors.
- [High] Incorrect state machine hooking in `TCP_CA_Recovery` causes double=
 CWND reduction and bypasses Proportional Rate Reduction (PRR).
- [High] ROCCET severely penalizes application-limited flows by actively ha=
lving their congestion window during slow start.
- [High] Stale `ece_received` flag causes subsequent unrelated packet losse=
s to be incorrectly treated as ECN events.
- [High] Packet loss during the `RTT_PROBE` phase causes the congestion win=
dow to restore to its unreduced pre-probe size.
- [High] Deliberately ignores multiplicative decrease on packet loss during=
 Slow Start.
- [Medium] Using 32-bit integers for microsecond timestamps breaks connecti=
on tracking on idle connections due to wrap-around.
- [Medium] Writable module parameters bypass bounds checks at runtime, desy=
nchronizing scale factors and enabling overflows.
- [Medium] The `u16` limit on `ack_rate_cnt` saturates at high speeds (>7.8=
 Gbps), falsely triggering slow-start exits.
- [Medium] Immediate CWND drop on ECN bypasses TCP's graceful CWR drain.
- [Low] Using `0` as a sentinel for uninitialized sequence numbers breaks w=
hen the TCP sequence legitimately wraps to zero.
--

--- Patch [1]: [PATCHv4 net-next] tcp: Add TCP ROCCET congestion control mo=
dule. ---
commit 02eaad1795bcc0571841fb03cecea583c8694e2f
Author: Tim Fuechsel <t.fuechsel@gmx.de>
tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is an new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781
Link: http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..c611e263136b3
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,974 @@
[ ... ]
> +static int fast_convergence __read_mostly =3D 1;
> +static int beta __read_mostly =3D 717; /* =3D 717/1024 (BICTCP_BETA_SCAL=
E) */
> +static int initial_ssthresh __read_mostly;
> +static int bic_scale __read_mostly =3D 41;
> +static int tcp_friendliness __read_mostly =3D 1;
> +
> +static u32 cube_rtt_scale __read_mostly;
> +static u32 beta_scale __read_mostly;
> +static u64 cube_factor __read_mostly;
> +
> +/* Note parameters that are used for precomputing scale factors are read=
-only */
> +module_param(fast_convergence, int, 0644);
> +MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
> +module_param(beta, int, 0644);

[Severity: Medium]
The beta module parameter is registered as writable (0644). Since validation
and generation of dependent statics (like beta_scale) only occur during
initialization, could a privileged user alter beta to a negative value at
runtime to bypass the beta <=3D 0 check?

Would this trigger an unsigned multiplication overflow in
(tcp_snd_cwnd(tp) * beta) inside roccet_congestion_event(), resulting in a
huge CWND while beta_scale remains stale?

[ ... ]
> +/* Update ack rate sampled by 100ms.
> + */
> +static __always_inline void update_ack_rate(struct sock *sk, u32 acked, =
u32 now)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	s32 interval =3D USEC_PER_MSEC * 100;
> +
> +	s32 time_delta =3D (s32)(ca->ack_rate_last_rate_time - now);

[Severity: Medium]
A 32-bit microsecond counter wraps roughly every 71.5 minutes. If a connect=
ion
is idle for over 35.7 minutes, does the subtraction
ack_rate_last_rate_time - now overflow and evaluate to a massive positive
value?

Could this freeze ACK rate tracking, and cause the=20
(s32)now - ca->roccet_last_event_time_us <=3D 100 * USEC_PER_MSEC
check in roccet_control() to remain perpetually true, locking the connection
in the DRAIN state indefinitely?

> +	const s32 idle_threshold =3D USEC_PER_SEC * 2;
[ ... ]
> +	} else {
> +		// Cap the ack count to avoid overflow
> +		ca->ack_rate_cnt =3D min_t(u32, ca->ack_rate_cnt + acked,
> +					 U16_MAX);

[Severity: Medium]
ack_rate_cnt is clamped to U16_MAX (65,535). In a 100ms interval with a
1500-byte MTU, does this limit tracking to approximately 7.8 Gbps?

If a flow runs faster than this, does the count saturate, causing
get_ack_rate_diff() to return 0 and forcing a premature exit from slow start
due to an interpreted bandwidth plateau?

> +	}
> +}
[ ... ]
> +static void roccettcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +	bool evaluate_srrtt =3D false;
> +	bool send_more_than_acked =3D false;
> +	u32 roccet_xj;
> +	u32 jitter;
> +	u32 send, received;
> +
> +	if (ca->state =3D=3D LAUNCH) {
> +		/* LAUNCH: Detect an exit point for tcp slow start
> +		 * in networks with large buffers of multiple BDP
> +		 * Like in cellular networks (5G, ...).
> +		 * Or exit LAUNCH if cwnd is too large for application layer
> +		 * data rate (tcp cwnd validation).
> +		 */
> +		if ((ca->curr_srrtt > sr_rtt_upper_bound &&
> +		     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
> +		    !tcp_is_cwnd_limited(sk)) {

[Severity: High]
In the LAUNCH phase, if the flow evaluates to !tcp_is_cwnd_limited(sk) beca=
use
the application temporarily paused sending data, does ROCCET explicitly for=
ce
an exit from slow start and halve both ssthresh and snd_cwnd?

Could this drastically reduce throughput for bursty or interactive workload=
s by
aggressively punishing applications for not having bulk data queued instant=
ly?

> +			ca->epoch_start =3D 0;
[ ... ]
> +		/* Calculate if more bytes was send than received
> +		 * in the time interval.
> +		 */
> +		if (before(tp->snd_nxt, ca->interval_snd_seq_start)) {
> +			/* We had a wrap around in seq no counter */
> +			send =3D (~0U - ca->interval_snd_seq_start + tp->snd_nxt);
> +		} else {

[Severity: High]
When snd_nxt logically regresses (such as during retransmission or sequence
rewinds), the before() check evaluates to true. Does the mitigation
~0U - start + nxt evaluate to a massive positive number (near 4GB) in this
case, ensuring send_more_than_acked is true and falsely triggering
roccet_congestion_event()?

> +			send =3D (tp->snd_nxt - ca->interval_snd_seq_start);
> +		}
[ ... ]
> +static u32 roccettcp_recalc_ssthresh(struct sock *sk)
> +{
> +	const struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	u32 cwnd =3D tcp_snd_cwnd(tp);
> +
> +	/* If a loss/ECN occurs in the refill phase of min RTT probing
> +	 * we reduce the cwnd and abort the refill.
> +	 */
> +	if (ca->state =3D=3D RTT_PROBE_REFILL)
> +		ca->state =3D ORBITER;
> +
> +	/* If ROCCET is in min RTT probing and a loss/ECN occurs,
> +	 * we use the cwnd before the probing interval to
> +	 * calculate the cwnd reduction and continue probing.
> +	 * After min RTT probing the cwnd is set to the reduced
> +	 * value. During min RTT probing it is very likely that
> +	 * congestion was caused by the cwnd value before min
> +	 * RTT probing.
> +	 */
> +	if (ca->state =3D=3D RTT_PROBE) {
> +		/* Handle ECN as cubic congestion event in min
> +		 * RTT probe.
> +		 */
> +		ca->ece_received =3D false;
> +
> +		ca->epoch_start =3D 0; /* end of epoch */
> +
> +		/* Wmax and fast convergence */
> +		if (cwnd < ca->last_max_cwnd && fast_convergence)
> +			ca->last_max_cwnd =3D
> +				(cwnd * (BICTCP_BETA_SCALE + beta)) /
> +				(2 * BICTCP_BETA_SCALE);
> +		else
> +			ca->last_max_cwnd =3D cwnd;
> +
> +		cwnd =3D ca->cwnd_before_min_rtt_probe;
> +		ca->cwnd_before_min_rtt_probe =3D
> +			max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
> +
> +		return cwnd;

[Severity: High]
If packet loss occurs while in RTT_PROBE, this function reduces
ca->cwnd_before_min_rtt_probe but returns the original, unreduced cwnd as t=
he
new ssthresh. Because cwnd was halved for probing, does this create a state
where cwnd is much lower than ssthresh?

Would PRR then inflate the connection window to try and reach this erroneou=
sly
high ssthresh, disabling loss recovery and risking congestion collapse?

> +	}
> +
> +	/* Handle ECN as ROCCET congestion event. */
> +	if (ca->ece_received) {
> +		ca->ece_received =3D false;
> +		roccet_congestion_event(sk, jiffies_to_usecs(tcp_jiffies32));
> +		return tcp_snd_cwnd(tp);

[Severity: Medium]
When processing an ECN event, roccet_congestion_event() explicitly sets
tp->snd_cwnd to the reduced value via tcp_snd_cwnd_set. RFC 3168 designates
the .ssthresh callback to simply return the new threshold, allowing the CWR
state machine to gracefully drain the window by 1 segment per ACK. By forci=
ng
it down directly, does ROCCET break this pacing?

> +	}
> +
> +	/* On loss in slow start enter congestion avoidance
> +	 * without a cwnd reduction. Additional slow start
> +	 * exit conditions with a cwnd reduction are handled
> +	 * in roccettcp_cong_avoid.
> +	 */
> +	if (tcp_in_slow_start(tp))
> +		return tcp_snd_cwnd(tp);

[Severity: High]
If tcp_in_slow_start(tp) is true, the callback returns the current, unreduc=
ed
cwnd as the new ssthresh. Does this fundamentally prevent cwnd from changing
despite packet loss, violating core TCP safety invariants that require a
multiplicative decrease upon packet loss?

> +
> +	/* CUBIC congestion event */
[ ... ]
> +static void roccettcp_state(struct sock *sk, u8 new_state)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +	if (new_state =3D=3D TCP_CA_Loss) {
> +		roccettcp_reset(ca);
> +	} else if (new_state =3D=3D TCP_CA_Recovery) {
> +		tcp_sk(sk)->snd_ssthresh =3D roccettcp_recalc_ssthresh(sk);
> +		tcp_snd_cwnd_set(tp, tcp_sk(sk)->snd_ssthresh);

[Severity: High]
tcp_enter_recovery in the TCP core invokes the .ssthresh callback immediate=
ly
after set_state. By manually calling roccettcp_recalc_ssthresh(sk) and
explicitly overwriting snd_cwnd here, is roccettcp_recalc_ssthresh invoked
twice consecutively on the already-reduced CWND?

Also, does directly mutating snd_cwnd inside set_state defeat the core PRR
algorithm by instantaneously dropping the window instead of gracefully
pacing it?

> +	}
> +}
[ ... ]
> +static void roccet_in_ack_event(struct sock *sk, u32 flags)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	/* Handle ECE bit.
> +	 * Processing of ECE events is done in roccettcp_recalc_ssthresh()
> +	 */
> +	if (flags & CA_ACK_ECE)
> +		ca->ece_received =3D true;

[Severity: High]
The ca->ece_received flag is set in the in_ack_event hook, which executes at
the end of tcp_ack(). Since the core stack calls the .ssthresh callback much
earlier, is the initial ECN marking treated as standard loss because the fl=
ag
is false at that time?

When a subsequent unrelated packet loss occurs, does .ssthresh see the stale
true flag, clear it, and wrongly delegate to ECN handling, failing to
correctly reduce the window?

> +}
> +
> +static void roccet_control(struct sock *sk, u32 ack, int flag,
> +			   const struct rate_sample *rs)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +	u64 rate;
> +
> +	/* Update roccet parameters */
> +	update_ack_rate(sk, rs->acked_sacked, now);
> +	update_min_rtt(sk);
> +	update_srrtt(sk);
> +
> +	/* Set values for send and receive rate */
> +	if (ca->interval_snd_seq_start =3D=3D 0) {
> +		ca->interval_snd_seq_start =3D tp->snd_nxt;
> +		ca->interval_una_seq_start =3D tp->snd_una;
> +	}

[Severity: Low]
The initialization check treats 0 as a sentinel. If the TCP sequence number
legitimately wraps exactly to 0, does the logic assume the tracking interval
is uninitialized and reset the interval start values unexpectedly?

> +
> +	/* Update roccet state */
> +	if (tcp_in_slow_start(tp)) {
> +		ca->state =3D LAUNCH;
> +	} else if ((s32)now - ca->roccet_last_event_time_us <=3D
> +		   100 * USEC_PER_MSEC) {
> +		ca->state =3D DRAIN;
> +	} else if (after(now, ca->next_min_rtt_probe) ||
> +		   ca->state =3D=3D RTT_PROBE || ca->state =3D=3D RTT_PROBE_REFILL) {
> +		if (ca->state !=3D RTT_PROBE_REFILL)
> +			ca->state =3D RTT_PROBE;
> +		roccet_min_rtt_probe(sk, now);
> +	} else {
> +		ca->state =3D ORBITER;
> +	}
> +
> +	/* If nothing was fully acked do not increase the cwnd */
> +	if (!rs->acked_sacked)
> +		return;
> +
> +	/* Increase the cwnd.
> +	 * Loss recovery is handled in roccettcp_state()
> +	 */
> +	roccettcp_cong_avoid(sk, ack, rs->acked_sacked);

[Severity: Critical]
By implementing the .cong_control hook, ROCCET overrides the TCP core's
tcp_cong_control() and the kernel stops managing PRR. However,
roccet_control() unconditionally calls roccettcp_cong_avoid() without
verifying if the socket is in TCP_CA_Recovery.

During severe packet loss, does every ACK cause ROCCET to continuously
increase its window via the CUBIC growth function, exacerbating the loss?

> +
> +	/* Adjust pacing rate. The code here is similar to the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/amHMvwtUk6CocMBr@vo=
lt-roccet-vm?part=3D1
