Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCF313E10
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558509; cv=none; b=rOLrOLEvGFK6ICuM3aGgZXiwJIpBX2oIJOnNpe1NgXfhsX2MXJWPEjGaZuifcnLjvp8C5/0hWAXQ0nDdfKBjMluHk/UMrmnnxcr4ftIjlWeVZQ95K0y08H4avtXNfGMTP+lXyMW96OTX7Xpib8HKD9T6uXp021pQzuzGCIPyjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558509; c=relaxed/simple;
	bh=AIGRcFqNzD9l89SF2UgMxsDi7bqo1DsH2fefJwOdbjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YzpN8ROmRziJ9yWVGj0BujzDfu8I1tOuDI+t0hlodS+vcmOySN6je+wQNgnKmpzG2+IS75ZlEcNmpuFKlkae3wmfV/tHwO7vo0d6U80jnWU2ivt0KikO7j7RBAPClU7gwoqtknK/hho5xLZww466kgb4NFvVaiYzBvNGxZBT6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK8fIDRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK8fIDRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579441F00893;
	Thu,  4 Jun 2026 07:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780558506;
	bh=wapcqrdl72H5bFuqI7hYwusxMUrm/Zw2wBShuuPxU/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dK8fIDRweJrW7QovZ6XXR/uA8WXc5lzsjWzo+y0vuYYG6uadyROULoaCANEtImyTQ
	 iJpwYCjLXcaTz9iqBvCYGdQ8c271usxce0xcNOyY4n9HGhB8IhPlv29JPaqfAgUeBe
	 WMuZ9APq60bthVCIvBqUCSCd52h+sJgMBHr1MYv7vTsKkGhm5IhRD6To6Jwcw300/R
	 fKH5HV9V6XEUDBm6uhEg+aKkhlwTKJf+S+XZBzR/Oh6D7w3asyL1UIRxHkGc2iORox
	 XRIpbGuPEiHhRUA4/sfa0/t4ZtcEQ76U73W15+ZXGZ7RwpyzT7k71xKw1llNsQnM+G
	 /KAsFg1KsSN8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <ah_ZFYB_tiw45_fg@volt-roccet-vm>
References: <ah_ZFYB_tiw45_fg@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 07:35:05 +0000
Message-Id: <20260604073506.579441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Division by zero occurs in `roccettcp_cong_avoid` when an ACK =
arrives without an RTT sample, causing a guaranteed kernel panic.
- [High] Double multiplicative decrease of congestion window and ssthresh u=
pon receiving ECN (ECE) marks.
- [High] Initialization of time tracking variables to 0 causes the `after()=
` macro to fail, breaking ACK rate tracking.
- [High] Loading the module with specific module parameter values causes a =
division by zero panic during initialization.
- [High] ROCCET aggressively halves cwnd and exits slow start simply when t=
he socket is not cwnd limited.
- [High] ROCCET completely ignores packet loss during slow start, violating=
 fundamental TCP congestion control principles.
- [High] Permanent tracking of absolute minimum RTT causes perpetual conges=
tion window reduction on network handover.
- [Medium] Static functions are incorrectly decorated with `__bpf_kfunc` an=
d registered as BTF kfuncs, violating BPF subsystem rules.
- [Medium] Missing zero-filling in ACK rate sampling causes stale rate comp=
arisons and spurious slow-start exits.
- [Medium] The acknowledgment arrival rate is sampled over a fixed 100ms in=
terval, not 5 RTT intervals.
--

commit bedc1f2efa75e431179c08512e7b18a28104cd5a
Author: Tim Fuechsel <t.fuechsel@gmx.de>

tcp: Add TCP ROCCET congestion control module.

This commit introduces TCP ROCCET, a sender-side extension of CUBIC
optimized for cellular networks. It relies on RTT measurements and ACK
arrival rates to address bufferbloat during the slow start and congestion
avoidance phases.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781

> The second metric is the acknowledgment arrival rate sampled over 5 RTT
> intervals.

[Severity: Medium]
Is this description accurate? The commit message specifies that the
acknowledgment arrival rate is sampled over 5 RTT intervals, but the
implementation in the code uses a static 100ms interval instead.

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
[ ... ]
> +static __always_inline void update_min_rtt(struct sock *sk)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	/* Check if new lower min RTT was found. If so, set it directly */
> +	if (ca->curr_rtt < ca->curr_min_rtt)
> +		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
> +}

[Severity: High]
Does this code handle network handovers correctly? Since curr_min_rtt only
updates downwards and is never expired, if a connection moves from a
low-latency network (like Wi-Fi) to a higher-latency network (like 5G Edge),
could curr_min_rtt remain locked to the lower latency? This might cause
curr_srrtt to constantly exceed sr_rtt_upper_bound on the new network,
potentially triggering endless congestion window reductions.

[ ... ]
> +static __always_inline void update_ack_rate(struct sock *sk, u32 acked)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
> +	u32 interval =3D USEC_PER_MSEC * 100;
> +
> +	if (after(now, ca->ack_rate.last_rate_time + interval)) {

[Severity: High]
Could the after() macro fail here upon system boot? Since
ca->ack_rate.last_rate_time is statically initialized to 0 in
roccettcp_init(), and tcp_jiffies32 is initialized to a large negative
offset that evaluates to a massive positive 32-bit timestamp in usecs, the
difference between now and last_rate_time might exceed 2^31. Would this cau=
se
after() to incorrectly evaluate to false for a large portion of the system's
uptime cycle and break ACK rate tracking?

[Severity: Medium]
Is this hardcoded 100ms interval intentional? As mentioned earlier, the
commit message specifies sampling over 5 RTT intervals, but this code
uses a static 100ms interval that is completely disconnected from the actual
RTT.

> +		ca->ack_rate.last_rate_time =3D now;
> +		ca->ack_rate.last_rate =3D ca->ack_rate.curr_rate;
> +		ca->ack_rate.curr_rate =3D ca->ack_rate.cnt;
> +		ca->ack_rate.cnt =3D acked; // start counting for the new interval

[Severity: Medium]
Does this logic safely handle long idle periods? If a connection is idle
for several seconds, update_ack_rate() isn't called. When a new burst
arrives, this shifts the interval directly adjacent to the previous burst's
intervals without zero-filling the idle time. Could this trick ROCCET into
spuriously exiting slow start on the first ACK after an idle period because
last_rate still reflects traffic from before the idle period?

[ ... ]
> +static __always_inline void update_srrtt(struct sock *sk)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	/* Avoid integer overflow in the calculation below.
> +	 * This could occur in cases where we have not yet
> +	 * received an RTT sample.
> +	 */
> +	if (ca->curr_rtt < ca->curr_min_rtt)
> +		ca->curr_min_rtt =3D ca->curr_rtt;
> +
> +	/* avoid division by zero */
> +	if (ca->curr_min_rtt =3D=3D 0)
> +		return;

[Severity: Critical]
Can this sequence cause a division by zero panic in roccettcp_cong_avoid()?

If an ACK arrives without an RTT sample (e.g., for a retransmitted packet),
ca->curr_rtt remains 0. update_min_rtt() sets it to max(0, 1) =3D 1. Then
update_srrtt() executes the condition above:

    if (ca->curr_rtt < ca->curr_min_rtt)
        ca->curr_min_rtt =3D ca->curr_rtt;
       =20
Because curr_rtt (0) is less than curr_min_rtt (1), this resets curr_min_rtt
back to 0. update_srrtt() then correctly returns early, but execution
continues in roccettcp_cong_avoid() where it calculates:

    roccet_xj =3D ((jitter * 100) / ca->curr_min_rtt) + sr_rtt_upper_bound;

Since ca->curr_min_rtt is exactly 0, wouldn't this calculation trigger a
kernel panic?

[ ... ]
> +__bpf_kfunc static void roccettcp_init(struct sock *sk)

[Severity: Medium]
Is it supported to mark static functions as __bpf_kfunc? The BPF subsystem
requires kfuncs to be global functions so they can be properly resolved by
resolve_btfids. Also, does a native TCP congestion control module need to
expose its internal functions as BPF kfuncs to operate?

> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	roccettcp_reset(ca);
> +
> +	if (initial_ssthresh)
> +		tcp_sk(sk)->snd_ssthresh =3D initial_ssthresh;
> +
> +	/* Initial roccet parameters */
> +	ca->roccet_last_event_time_us =3D 0;
> +	ca->ack_rate.last_rate =3D 0;
> +	ca->ack_rate.last_rate_time =3D 0;

[Severity: High]
As noted above, initializing last_rate_time to 0 here causes issues with
the after() macro check in update_ack_rate() due to the initial negative
offset of tcp_jiffies32.

[ ... ]
> +__bpf_kfunc static void roccettcp_cong_avoid(struct sock *sk, u32 ack,
> +					     u32 acked)
> +{
[ ... ]
> +	/* LAUNCH: Detect an exit point for tcp slow start
> +	 * in networks with large buffers of multiple BDP
> +	 * Like in cellular networks (5G, ...).
> +	 * Or exit LAUNCH if cwnd is too large for application layer
> +	 * data rate (tcp cwnd validation).
> +	 */
> +
> +	if ((tcp_in_slow_start(tp) && ca->curr_srrtt > sr_rtt_upper_bound &&
> +	     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
> +	    (!tcp_is_cwnd_limited(sk) && tcp_in_slow_start(tp))) {
> +		ca->epoch_start =3D 0;

[Severity: High]
Does this cause severe throughput degradation for interactive applications?
The condition !tcp_is_cwnd_limited(sk) indicates the application is not
currently sending enough data to fill the window, such as during small
bursts or brief idle periods. Using this condition to aggressively halve
cwnd and ssthresh during slow start seems like it would heavily penalize
bursty applications.

[ ... ]
> +	/* Respects the jitter of the connection and add it on top of
> +	 * the upper bound for the srRTT.
> +	 */
> +	roccet_xj =3D ((jitter * 100) / ca->curr_min_rtt) +
> +		    sr_rtt_upper_bound;
> +	if (roccet_xj < sr_rtt_upper_bound)
> +		roccet_xj =3D sr_rtt_upper_bound;

[Severity: Critical]
As discussed in update_srrtt(), if an ACK arrives without an RTT sample,
ca->curr_min_rtt can be 0 here, which will cause a division by zero panic.

> +	/* The srRTT exceeds the upper bound if bufferbloat happens.
> +	 * Here, we want to reduce the cwnd and drain the buffer.
> +	 */
> +	if ((ca->curr_srrtt > roccet_xj && evaluate_srrtt) ||
> +	    ca->ece_received) {
> +		if (ca->ece_received)
> +			ca->ece_received =3D false;
> +		ca->epoch_start =3D 0;
> +		ca->roccet_last_event_time_us =3D now;
> +		ca->cnt =3D 100 * tcp_snd_cwnd(tp);
> +
> +		/* Set Wmax if cwnd is larger than the old Wmax */
> +		if (tcp_snd_cwnd(tp) > ca->last_max_cwnd)
> +			ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
> +
> +		tcp_snd_cwnd_set(tp, min(tp->snd_cwnd_clamp,
> +					 max((tcp_snd_cwnd(tp) * beta) /
> +					     BICTCP_BETA_SCALE, 2U)));
> +		tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
> +		return;
> +	}

[Severity: High]
Could this result in a double penalty for a single ECE event?

When an ECE flag is seen, roccet_in_ack_event() sets ca->ece_received to
true. The core TCP stack handles this by entering the CWR state, adjusting
ssthresh, and lowering cwnd via PRR. During this time, roccettcp_cong_avoid=
()
is bypassed.

When the stack returns to the Open state and resumes calling
roccettcp_cong_avoid(), ca->ece_received is still true. Does this cause
an unintended second multiplicative decrease of the congestion window and
ssthresh?

[ ... ]
> +__bpf_kfunc static u32 roccettcp_recalc_ssthresh(struct sock *sk)
> +{
> +	const struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	/* On loss in slow start enter congestion avoidance
> +	 * without a cwnd reduction.
> +	 */
> +	if (tcp_in_slow_start(tp))
> +		return tcp_snd_cwnd(tp);

[Severity: High]
Does ignoring packet loss during slow start violate standard TCP congestion
control safety principles (like RFC 5681)? Refusing to back off in response
to dropped packets can lead to network congestion collapse and unfairly
starve competing flows.

[ ... ]
> +static int __init roccettcp_register(void)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
> +
> +	/* Precompute a bunch of the scaling factors that are used per-packet
> +	 * based on SRTT of 100ms
> +	 */
> +
> +	beta_scale =3D
> +		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
> +
> +	cube_rtt_scale =3D (bic_scale * 10); /* 1024*c/rtt */
> +
> +	/* calculate the "K" for (wmax-cwnd) =3D c/rtt * K^3
[ ... ]
> +	/* 1/c * 2^2*bictcp_HZ * srtt */
> +	cube_factor =3D 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
> +
> +	/* divide by bic_scale and by constant Srtt (100ms) */
> +	do_div(cube_factor, bic_scale * 10);

[Severity: High]
Can a user panic the kernel during module initialization by passing specific
module parameters?

The beta and bic_scale variables are module parameters that are not bounded
or validated. If a user loads the module with beta=3D1024 or bic_scale=3D0,
the expressions (BICTCP_BETA_SCALE - beta) and bic_scale * 10 will
evaluate to 0, leading to a division by zero panic here.

> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					&tcp_roccet_kfunc_set);

[Severity: Medium]
As mentioned earlier, static functions cannot be reliably registered as BPF
kfuncs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ah_ZFYB_tiw45_fg@vo=
lt-roccet-vm?part=3D1
