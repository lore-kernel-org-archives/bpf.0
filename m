Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B24B1295
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646853; cv=none; b=FqjLfv+VESaZzX0o3zrtBKADi1hToYbXuLYspujyYj8ERsEkPkb86MKlAt3uEW6HaTPjJhaHPlzsev+Ff8vOTYCoVT0aDpo4w87mEscL9kdHrMoD2c/94yjonqaEZCrsKe6Rxy0NwIZMAEy6oFq5BMF2mNCfiW5xwN5+09gqmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646853; c=relaxed/simple;
	bh=LRM5/f99QF2mHRC0TmKcikMWSRegXsGsvCrJXGEuQ3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGWCfKakLNcWZ+G+1hTr42ckH2YkOyrL32k/SWbZ67vGAmztZza18z8tUXkTQasnA0qNXXmU/OGZ7XoyL+3uNyR59lRxmkj/xoBXBFHojJvgw3cXCkd/2gr7D+ziCQITkIHfMgUKQc8RJPw1PNyhkRhOKVTbzBABn8JxxtXZTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIdc1/ge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIdc1/ge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEC31F000FF;
	Thu, 17 Sep 2026 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646835;
	bh=r9RJAFcT4R7NSAoIt75F8zlS0N+6XdVsKFVyHvXB+48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIdc1/ge4PPHs730tIDtCN9ZGHrGgxM5i4+eDFA0YjqZEmTjJ++cZASTc+4e/x3q5
	 aN3egIFI9HjUNTJ0MmPLcHPbwpV9Aek2jzqD5BP2lOSJblxpHbaEd3QrevGbQ/AwU0
	 cPsIZ2CARd1e1zld6r268FE04i4Xgn1oflEq6DZPus1y5n9qfz44ahKIydUHvu/Xno
	 rlRjRw2pnOoijB2vEI2DquicZeX7gUD7qF1TbyWZUWcrlovvZgVHub+M45bGmz9Cq1
	 vLAaO07IHRXt8byY4ZbrmJK09Jk7wGeYyUG5gEqKayaXHdBaW/AGDEWRIlttEp89KF
	 Xl1J1UNlTnZSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <aqqGU0XfcfsI-OGy@volt-roccet-vm>
References: <aqqGU0XfcfsI-OGy@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:07:15 +0000
Message-Id: <20260917120715.7BEC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] tcp_roccet: ignores packet loss during LAUNCH slow-start phase
- [High] tcp_roccet: timer wraparound to exactly 0 causes permanent DRAIN s=
tate lockup
- [High] tcp_roccet: double cwnd reduction and last_max_cwnd corruption dur=
ing TCP_CA_CWR
- [High] tcp_roccet: ACK rate metric 16-bit saturation falsely aborts slow =
start
- [High] tcp_roccet: forces TCP_INIT_CWND on RTO, injecting severe bursts
- [Medium] tcp_roccet: ack_carry_over from slow start exit is lost to tcp_c=
ong_avoid_ai
- [Medium] tcp_roccet: 32-bit usecs timestamp wraps after 35 minutes, freez=
ing idle connections
- [Medium] tcp_roccet: zero-microsecond RTT samples are discarded
- [Medium] tcp_roccet: 32-bit sequence tracking wraps in 5 RTT measurement =
window
- [Medium] tcp_roccet: writable sysfs parameters lack runtime bounds valida=
tion
- [Low] tcp_roccet: struct roccettcp exceeds ICSK_CA_PRIV_SIZE limit
--

commit e3cfdf8398561ab8f09dd45039b191e26c9801e8
Author: Tim Fuechsel <t.fuechsel@gmx.de>
Subject: tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC that
improves performance in cellular networks by mitigating bufferbloat. It
adds a modified slow start and monitors RTT and acknowledgment arrival
rates to adjust the send rate.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781
Link: http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..10ad4748d994d
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
[ ... ]
> +struct roccettcp {
> +	u32 cnt;	/* increase cwnd by 1 after ACKs */
[ ... ]
> +	u16 ack_rate_cnt;	/* Used for counting acks */
> +
> +	enum roccet_state state : 3; /* Current operating state of roccet */

[Severity: Low]
Does the transition from u16 to an enum bitfield force a 4-byte alignment
here?

It appears this introduces 2 bytes of padding, expanding the struct beyond
104 bytes and causing the BUILD_BUG_ON(sizeof(struct roccettcp) >
ICSK_CA_PRIV_SIZE) assertion in roccet_register() to fail at compile time.

[ ... ]
> +static int beta __read_mostly =3D 717; /* =3D 717/1024 (BICTCP_BETA_SCAL=
E) */
[ ... ]
> +module_param(beta, int, 0644);

[Severity: Medium]
Since beta is writable by root at runtime (0644), shouldn't there be a
runtime bounds validation check?

The current param_check() is only executed during initialization. If beta
is written to a negative value at runtime, it could cause an unsigned
integer overflow in roccet_congestion_event() during congestion window
scaling calculations.

[ ... ]
> +static void update_ack_rate(struct roccettcp *ca, u32 acked, u32 now)
> +{
[ ... ]
> +		} else {
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
Does artificially capping this measurement to U16_MAX flatten the tracked
rate on high-speed networks?

On networks exceeding ~7.8 Gbps, the connection will receive more than
65535 ACKs per 100ms interval. This saturation would constantly yield a
rate difference of 0, falsely signaling that throughput has plateaued and
causing roccet_launch_update() to prematurely abort slow start.

[ ... ]
> +static void roccet_congestion_event(struct sock *sk, u32 now)
> +{
[ ... ]
> +	ca->epoch_start =3D 0;
> +	ca->roccet_last_event_time_us =3D now;

[Severity: High]
Can this assign a wrapping microsecond timestamp to a field that later
treats 0 as a special uninitialized sentinel?

The 32-bit microsecond timestamp generated in roccet_control() will wrap
to exactly 0 every ~6.2 days. If a congestion event occurs at that precise
millisecond, roccet_last_event_time_us becomes 0.

This would cause roccet_drain_update() to bypass its interval check
permanently, trapping the connection in the DRAIN state.

[ ... ]
> +static void roccet_min_rtt_probe(struct sock *sk, u32 now)
> +{
[ ... ]
> +	if (ca->probe_min_rtt_until =3D=3D 0)
> +		pr_warn_once("ROCCET: Probing time should be set");
> +	else if (time_before32(now, ca->probe_min_rtt_until))

[Severity: High]
Could this sentinel check falsely trigger if the calculated deadline wrapped
to exactly 0?

Similar to the issue above, because it treats 0 as uninitialized, a probe
duration that naturally lands on 0 during wraparound will mysteriously
abort the min RTT probing phase.

[ ... ]
> +static void roccet_launch_update(struct sock *sk, u32 acked)
> +{
[ ... ]
> +	/* If cwnd hits ssthresh, go to ORBITER and if any ACKs are
> +	 * leftover save them for ORBITER.
> +	 * Check via tcp_in_slow_start() in case no ACKs are left.
> +	 */
> +	if (!tcp_in_slow_start(tp)) {
> +		ca->state =3D ORBITER;
> +		ca->epoch_start =3D 0;
> +		ca->ack_carry_over =3D acked;
> +	}
> +}

[Severity: Medium]
When leftover ACKs are saved in ack_carry_over, are they ever applied to
the actual congestion window growth?

Looking at roccet_orbiter_update(), it calls bictcp_update() which adds
the carryover to ack_cnt, but that is only used for TCP friendliness
fallback calculations. The subsequent call to tcp_cong_avoid_ai() only
takes the current round's acked value, meaning the carried-over ACKs are
permanently discarded.

[ ... ]
> +static void roccet_orbiter_update(struct sock *sk, u32 acked)
> +{
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
Will this calculation be subject to catastrophic 32-bit sequence wrap-around
on networks operating at 100+ Gbps?

Since this measures bytes transferred over a 5 RTT measurement window,
transferring more than 4 Gigabytes in that time will wrap the 32-bit
sequence subtraction and break the sent_more_than_acked evaluation.

[ ... ]
> +static u32 roccet_recalc_ssthresh(struct sock *sk)
> +{
[ ... ]
> +	/* In LAUNCH, we want no reduction on loss/ECN.
> +	 * On ECN this is set later on in roccet_state()
> +	 */
> +	if (ca->state =3D=3D LAUNCH)
> +		return cwnd;

[Severity: High]
Does forcing ssthresh to remain at the full congestion window size despite
an active congestion event bypass standard congestion control safeguards?

Ignoring packet loss during the LAUNCH slow-start phase entirely prevents
the sender from backing off during severe congestion, which can lead to
persistent buffer overflow.

[ ... ]
> +static u32 roccet_handle_recovery(struct sock *sk)
> +{
[ ... ]
> +	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
> +	if (ca->state =3D=3D LAUNCH) {
> +		ca->state =3D ORBITER;
> +		return cwnd;
> +	}

[Severity: High]
Does returning the unreduced cwnd intentionally circumvent standard cwnd
reduction upon Fast Recovery during the initial growth phase?

As above, this completely ignores network congestion signals and violates
TCP congestion control safety invariants.

[ ... ]
> +static void roccet_state(struct sock *sk, u8 new_state)
> +{
[ ... ]
> +	if (new_state =3D=3D TCP_CA_Loss) {
> +		roccet_reset(sk, ca);
> +		tcp_snd_cwnd_set(tp, TCP_INIT_CWND);

[Severity: High]
Does explicitly overriding the TCP core's safe cwnd reduction of 1 with
TCP_INIT_CWND cause severe congestion bursts?

Injecting up to 10 packets immediately following a full Retransmission
Timeout violently floods an already deeply congested network.

> +	} else if (new_state =3D=3D TCP_CA_CWR) {
> +		/* Handle CWR as ROCCET congestion event,
> +		 * however afterwards always set Wmax to the current cwnd.
> +		 */
> +		cwnd =3D tcp_snd_cwnd(tp);
> +		roccet_congestion_event(sk, now);
> +		ca->last_max_cwnd =3D cwnd;
> +	} else if (new_state =3D=3D TCP_CA_Recovery) {

[Severity: High]
Is the congestion window getting penalized twice for TCP_CA_CWR?

The TCP core already halves cwnd prior to calling this state callback.
Passing the already-halved cwnd into roccet_congestion_event() triggers a
redundant congestion event.

Additionally, blindly assigning this doubly-penalized value to
last_max_cwnd permanently corrupts CUBIC's target growth metric.

[ ... ]
> +static void roccet_acked(struct sock *sk, const struct ack_sample *sampl=
e)
> +{
[ ... ]
> +	/* Get valid sample for roccet */
> +	if (sample->rtt_us > 0) {
> +		ca->last_rtt =3D ca->curr_rtt;
> +		ca->curr_rtt =3D sample->rtt_us;
> +	}
> +}

[Severity: Medium]
Does discarding valid 0-microsecond RTT samples completely disable ROCCET
on ultra-low latency links?

On loopback or ultra-low latency interfaces, sub-microsecond RTTs are
rounded down to 0. By ignoring them entirely instead of treating them as
1us, curr_rtt is prevented from ever initializing past U32_MAX, permanently
breaking the congestion avoidance logic.

[ ... ]
> +static void roccet_drain_update(struct sock *sk, u32 now)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	if (ca->roccet_last_event_time_us &&
> +	    time_after32(now, ca->roccet_last_event_time_us +
> +			 100 * USEC_PER_MSEC)) {

[Severity: Medium]
Can this condition incorrectly fail if the connection idles for more than
35.7 minutes?

Because now is a 32-bit microsecond timestamp, the subtraction in
time_after32() will exceed its signed boundary if the time elapsed is
greater than 2^31 microseconds. If an application idles and then resumes,
it could be incorrectly trapped in the DRAIN state, freezing window growth
until the timer wraps again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aqqGU0XfcfsI-OGy@vo=
lt-roccet-vm?part=3D1
