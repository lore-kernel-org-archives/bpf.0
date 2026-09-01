Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AB367B73
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282246; cv=none; b=f4sBLHWVskPplfpnPkh+JegvhdAtyk8d8famupqqFhykLnyqN2PekE0waP7k4nwBur8eG022BOXpArnNhaFtMLTHp5K/CHckD34a2I96x4x5tAQ5Y09+edBXooj6XkNVkGSZ8PrtJ2ly/AJwf7KFtS3DvyhieZuzuJwwAGrPH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282246; c=relaxed/simple;
	bh=iXhO00asyFTTm+Zk2u8wH4kk+nyMNDg1cVyvfu1WssE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sNjWwTzFwTlbnAfnM8WuAMOgCL/lHNA6YsOugkn/wTffdkNJwZtoOMIxXx8iOsce3CIa7S98qusGGAmW8wM7RFadIdzyXLSdzB9nvLenO5RY6HQnUk15SwmQWIQZUQgob0934SzDApBSBuVScAnRDxPL8VlEojfU8sN694oQOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leVSWIkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leVSWIkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7371F00A3A;
	Tue,  1 Sep 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282244;
	bh=uKYHe5qFPEmjFyofuoleaoyjMtAzfb/elwMbRfbjV7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=leVSWIkbARDleUWotvxAf9UGOLv53jM8d1xP5ypBi5/pS7nCBHSN6ubkBDyjbGW7G
	 0ZcreR0r8b9Joaft9tgdh2cozhAoZQd/8ln9UnqR9P5y1IhKFIQPlUmMM1OEebhKhq
	 +S1ofSvUDeqTLXPBPYSSXXD8va1k6tqQbiXsWczSvWksIJPTwNJUsUI/sU/3OCy6Rr
	 SP4I3OtVwk031MChBu5lqU1lY9w5I56iZFoWebWga3zD6MHag/wk9JsiNDNqLw7t31
	 l57grjGOl06nM70V6G0KOf/rkuRqMkZOOTgXTmgVpIzOD8YFyq+g6LxEGB8oMTGgYn
	 xvWplQc2ositA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <apWz9rPcGMgYCKOR@volt-roccet-vm>
References: <apWz9rPcGMgYCKOR@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:04:04 +0000
Message-Id: <20260901170404.8D7371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Concurrent socket initialization mutates global configuration =
parameters without synchronization, leading to severe data races and corrup=
tion of `cube_factor`.
- [Critical] The `curr_rtt` field is implicitly initialized to 0, which per=
manently corrupts the `curr_min_rtt` calculation if evaluated before a vali=
d RTT sample is received.
- [High] The `.ssthresh` callback erroneously returns the unmodified thresh=
old, bypassing TCP's standard Retransmission Timeout (RTO) backoff and caus=
ing congestion floods.
- [High] ROCCET completely fails to reduce its congestion window upon recei=
ving Explicit Congestion Notification (ECN) CE marks, violating RFC 3168.
- [High] ROCCET bypasses and breaks TCP's Proportional Rate Reduction (PRR)=
 fast recovery by blindly overriding `cwnd` assignments during `TCP_CA_Reco=
very`.
- [High] Fast convergence logic incorrectly calculates `last_max_cwnd` usin=
g the artificially slashed probe window instead of the true network capacit=
y.
- [Medium] Integer truncation of the acknowledged packet count allows attac=
kers to spoof a low ACK rate and bypass congestion control.
--

commit 8c2a501e71c2cbc59259d9d2e53dda94d869cfdb
Author: Tim Fuechsel <t.fuechsel@gmx.de>
Subject: tcp: Add TCP ROCCET congestion control module.

This commit adds TCP ROCCET, a new congestion control algorithm based
on TCP CUBIC. It aims to improve overall performance and reduce bufferbloat
in cellular networks by utilizing srRTT and acknowledgment arrival rates.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781
Link: http://go.lu-h.de/roccet-2026-07-21

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
[ ... ]
> +static void roccettcp_reset(struct roccettcp *ca)
> +{
> +	memset(ca, 0, sizeof(struct roccettcp));
> +	ca->next_srrtt_check =3D 0;
> +	ca->curr_min_rtt =3D ~0U;
[ ... ]
> +	ca->initial_round_completed =3D false;
> +}
> +
> +static void update_min_rtt(struct sock *sk)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +
> +	/* Check if new lower min RTT was found. If so, set it directly */
> +	if (ca->curr_rtt < ca->curr_min_rtt) {
> +		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);

[Severity: Critical]
Does this initialization logic safely handle early ACKs without valid RTT
samples?

roccettcp_reset() initializes the struct with zeroes, making curr_rtt =3D 0
and curr_min_rtt =3D ~0U. If an early ACK lacks a valid RTT sample (for
example, a pure duplicate ACK where sample->rtt_us < 0), curr_rtt remains
0. The comparison 0 < ~0U will succeed in update_min_rtt(), locking
curr_min_rtt to 1. Future valid RTTs will never be smaller than 1.

[ ... ]
> +	} else {
> +		ca->ack_rate_last_rate_time =3D now;
> +		ca->ack_rate_last_rate =3D ca->ack_rate_curr_rate;
> +		ca->ack_rate_curr_rate =3D ca->ack_rate_cnt;
> +		ca->ack_rate_cnt =3D
> +			acked; // start counting for the new interval
> +	}

[Severity: Medium]
Could this direct assignment truncate the 32-bit acked parameter?

The struct definition restricts ack_rate_cnt to only 16 bits. Without a
bounding check like min_t(u32, acked, U16_MAX) here, a malicious receiver
utilizing large windows or LRO/GRO aggregation could acknowledge more than
65535 packets at once. This would cause the counter to silently wrap
around and spoof a low ACK rate.

[ ... ]
> +static void roccet_min_rtt_probe(struct sock *sk, u32 now)
> +{
[ ... ]
> +	} else if (before(now, ca->refill_until)) {
> +		/* Reset cwnd and refill the pipe. */
> +		if (ca->state !=3D RTT_PROBE_REFILL) {
> +			tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
> +			tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp);
> +			ca->state =3D RTT_PROBE_REFILL;
> +		}

[Severity: High]
What happens if this min_rtt probe timer expires while the connection is
mid-recovery?

Abruptly inflating the cwnd back to the pre-probe value during fast
recovery would bypass the PRR pacing mechanism and inflate the window.

[ ... ]
> +static void param_precompute(void)
> +{
[ ... ]
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

[Severity: Critical]
Does calling param_precompute() per socket initialization create a data
race on the global cube_factor variable?

Since roccettcp_init() is invoked dynamically for every newly created
socket, the unprotected in-place division do_div(cube_factor, ...) mutates
shared global state. If concurrent sockets are created, threads will
subject the variable to multiple divisions, resulting in a miscalculation
of the cwnd target in bictcp_update().

[ ... ]
> +static u32 roccettcp_ssthresh(struct sock *sk)
> +{
> +	return tcp_sk(sk)->snd_ssthresh;
> +}

[Severity: High]
Does returning the unmodified snd_ssthresh bypass TCP's required threshold
reductions?

When a severe congestion event like an RTO timeout occurs, or during an
ECN CE-mark response in TCP_CA_CWR, the core stack queries the .ssthresh
callback to shrink the slow-start threshold. Returning the current
threshold unmodified prevents PRR from pacing properly and allows the
window to exponentially grow back to massive sizes.

[ ... ]
> +static u32 roccettcp_recalc_ssthresh(struct sock *sk)
> +{
[ ... ]
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

[Severity: High]
Is this fast convergence calculation using the correct window size?

The active cwnd is artificially halved during the min_rtt probe. By
calculating the new last_max_cwnd using this slashed probe window before
restoring the true cwnd, the historical maximum window (which anchors the
CUBIC curve origin) would become permanently understated.

[ ... ]
> +	/* Handle ECN as ROCCET congestion event. */
> +	if (ca->ece_received) {
> +		ca->ece_received =3D false;
> +		roccet_congestion_event(sk, jiffies_to_usecs(tcp_jiffies32));
> +		return tcp_snd_cwnd(tp);
> +	}

[Severity: High]
Is this ECN handling code unreachable?

This intended ECN handling code sits inside roccettcp_recalc_ssthresh(),
which appears to only be invoked by roccettcp_state() during
TCP_CA_Recovery. Since ECN marks normally trigger TCP_CA_CWR (which
roccettcp_state() ignores), this logic will never execute during actual
ECN events, violating protocol requirements.

[ ... ]
> +static void roccettcp_state(struct sock *sk, u8 new_state)
> +{
> +	struct roccettcp *ca =3D inet_csk_ca(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +	ca->is_in_recovery =3D false;
> +
> +	if (new_state =3D=3D TCP_CA_Loss) {
> +		roccettcp_reset(ca);
> +	} else if (new_state =3D=3D TCP_CA_Recovery) {
> +		ca->is_in_recovery =3D true;
> +
> +		/* Here we set the cwnd and ssthresh to the same value so
> +		 * the TCP state machine knows we are in cong. avoid and
> +		 * not in slow start.
> +		 */
> +		tcp_sk(sk)->snd_ssthresh =3D roccettcp_recalc_ssthresh(sk);
> +		tcp_snd_cwnd_set(tp, tcp_sk(sk)->snd_ssthresh);
> +	}
> +}

[Severity: High]
Does instantly setting the cwnd here bypass TCP's Proportional Rate
Reduction (PRR) fast recovery?

Blindly overriding the cwnd assignment upon entering TCP_CA_Recovery
instantly shrinks the window and destroys the core stack's PRR pacing
mechanism, which leads to retransmission bursts.

Additionally, the TCP_CA_Loss branch misses the manual ssthresh reduction
applied to Recovery, cementing the RTO backoff bypass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apWz9rPcGMgYCKOR@vo=
lt-roccet-vm?part=3D1
