Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D44496D40
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537429; cv=none; b=fV1r1OfhEKjIZ9pgaL6bpff/TNXl4/fEcGvgrCNJi/6Rfq6TPFdSAHiIpcylIZEpixXM2mk3Kvvvl3+YVo3Ta9hz1bav3hu8MeyRr/AX54C9+Z+OsMoXp4MCU6laTFsNhklZKi5myptymUsJP2gAz31PKMAKiY/2b+pu/MtMwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537429; c=relaxed/simple;
	bh=qChp+PDJMOh8TkwvDqagd1H9qtce8wb62vbPqj/J22I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PuVs6SNKsZDQ8A1aqoWd2LmjIUyj6LCKXKmHwVNpiSxXctx+8LHyq0qRJ2zx4JFtWoGsYBYDfmgrT5k+OTaTutHlaasuzjzSXQwPuR4jSnI3zd7dYwo1j2oJWKrfMHzjZXOzTHtH9L9Pt0VvGp4+jJ9hx+yqunhTtYLfEre6VJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdt3hKf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdt3hKf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E67D1F000FF;
	Fri,  9 Oct 2026 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791537424;
	bh=LNJF2lgSQHUoeuG7aaJHwrCVN+QVB0EKA5lDv57bOZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wdt3hKf4il54FnTgXgABboUXXANOfslYsPoEIIiCVow7i50mUcHcmqKGdbWuBHzq0
	 voyE2l9uGKUhKX1Hz77eilqhyAciPOwjNVEwz4G9vrwUiUb82+eMeQKNPO+/uJT4PR
	 HzFOiHqCzqfc6ruZSEZ8RNOSQoG0lWS2v4bNimoX0wKfCH/aNNSzceZlYgf9q6qaFb
	 R9qBXlJDYbFT7oibZ13BPbNhbREOS1Zak/dYQATGFXXBSfU0D9x3miQFOcFm+SZqBo
	 /uGkgU+uuyKNwJvJDNaNqwwhdwX720VZ9aZSZcgMQeYw+VsIJA9oHvOX40K7kHJp60
	 EnDECn2rVZH1A==
Message-ID: <sashiko-outbox-165144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv10 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <asdfdDIQb7Nhm692@volt-roccet-vm>
References: <asdfdDIQb7Nhm692@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 09:17:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tcp_roccet: struct roccettcp exceeds ICSK_CA_PRIV_SIZE causing BUI=
LD_BUG_ON
- [Medium] tcp_roccet: ca->next_min_rtt_probe type confusion (jiffies vs us=
ecs) on LAUNCH transition
--

commit f0a2d58d971a3f893ec1f1f112a640b906471634
Author: Tim Fuechsel <t.fuechsel@gmx.de>
Subject: tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC that
improves its overall performance in cellular networks. It relies on two
additional metrics (relative increase in RTT from its minimum and
acknowledgment arrival rate) to determine the send rate and avoid bufferblo=
at.
It features a modified slow start and specific minimum RTT probing logic.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781
Link: http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 0000000000000..04b9e52466126
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1408 @@
[ ... ]
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
> +	u32 last_ack_rate_time;	/* Timestamp of the last ACK-rate */
> +	u16 ack_rate_last_rate;	/* Last ACK-rate */
> +	u16 curr_ack_rate;	/* Current ACK-rate */
> +	u16 ack_rate_cnt;	/* Used for counting acks */
> +
> +	enum roccet_state state : 3; /* Current operating state of roccet */
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
[ ... ]
> +static void roccet_orbiter_update(struct sock *sk, u32 acked)
> +{
[ ... ]
> +	/* Enter RTT_PROBE when the "timer" has expired.
> +	 *
> +	 * Since we are in ORBITER, we should have already received at least
> +	 * one RTT sample. However safeguard against it if not.
> +	 *
> +	 * Use double the probing period as a guard space to avoid
> +	 * idle-time locking us out of probing.
> +	 */
> +	if (!time_between32(now, ca->next_min_rtt_probe
> +				 - 2 * ROCCET_NEXT_MIN_RTT_PROBE_MS
> +				 * USEC_PER_MSEC, ca->next_min_rtt_probe) &&
> +	    ca->curr_rtt !=3D U32_MAX) {
> +		ca->state =3D RTT_PROBE_ENTER;
> +		return;
> +	}

[Severity: Medium]
Could this condition falsely trigger a premature RTT probe if the connection
was previously idle?

In roccet_enter_min_rtt_probe(), ca->next_min_rtt_probe is assigned a raw
jiffies timestamp to track the probe epoch. Normal state transitions out of
probing explicitly reinitialize next_min_rtt_probe to a usecs timestamp.

If the connection then enters ORBITER from LAUNCH, this block compares a us=
ecs
timestamp (now) against the residual jiffies timestamp. Since usecs are vas=
tly
larger, won't this check instantly fail and incorrectly re-enter probing?

[ ... ]
> +static void roccet_handle_state_transitions(struct sock *sk,
> +					    enum roccet_state prev_state,
> +					    u32 now)
> +{
[ ... ]
> +	/* Whenever we leave the min RTT probing states (and not just
> +	 * transition between them), we want to reset the probing timers.
> +	 */
> +	if ((prev_state =3D=3D RTT_PROBE_ENTER || prev_state =3D=3D RTT_PROBE ||
> +	     prev_state =3D=3D RTT_PROBE_REFILL) &&
> +	    (ca->state !=3D RTT_PROBE && ca->state !=3D RTT_PROBE_REFILL)) {
> +		ca->probe_min_rtt_until =3D 0;
> +		ca->refill_until =3D 0;
> +		ca->rtt_probe_timers_set =3D false;
> +	}
> +}

[Severity: Medium]
When the connection goes idle during probing, roccet_cwnd_event_tx_start()
forces an immediate transition to LAUNCH. This cleanup logic handles cleari=
ng
the probe timers, but does it miss reinitializing next_min_rtt_probe to use=
cs
for that transition?

[ ... ]
> +static int __init roccet_register(void)
> +{
> +	int param_err;
> +
> +	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);

[Severity: High]
Does this assertion fail unconditionally because the struct exceeds 104 byt=
es?

struct roccettcp contains 24 u32 fields (96 bytes) and 3 u16 fields (6 byte=
s),
consuming 102 bytes. The next field is the enum roccet_state bitfield, which
forces 2 bytes of padding after the u16 fields, placing the bitfield block =
at
offset 104, pushing the total struct size to 108 bytes.

Since ICSK_CA_PRIV_SIZE is exactly 104 bytes, won't this break compilation =
on
standard architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/asdfdDIQb7Nhm692@vo=
lt-roccet-vm?part=3D1
