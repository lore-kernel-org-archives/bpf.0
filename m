Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871753D0BB
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694759; cv=none; b=X8UliCvDnlvyvwp4djjs3a+HwLHrZjNZ53lN8pesVs5DHzBdA64B5dFjS+mkWzQdVG0uZ+hLfdZbSeJisMc0obkrdIdnXQhAymDJ483ed7u7P09UM41WgFqOLBIMPN0C7O78MzIiWfBChxTxnvHgvNTs4tInPXxK1tNyqqGcPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694759; c=relaxed/simple;
	bh=9wZZWbx8H/BsWoEtAM7iqA4aca7JNV6xe//799RMRqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kce3XI36rPbTiC+uJNX1RMy9tAHMZrX+bp9S5VPrD5csK3Wr2Wk1HUGdlHAGB378dKHcWW/yt9oa5hA7C/5pMjBYCOQMWoSWOW4mOZa4xzdi8QX9gJzHd42oW7hAf9Hr8lmFIMYzScM2dXV9pP8MLaByevD1Ehbo/avP4BN9kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEbNgVuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEbNgVuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A81F00893;
	Tue, 29 Sep 2026 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694739;
	bh=YwoOJ1zNfQNJSl4j1ib8xQKHWTFQcqR8oQgRKfKPtjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mEbNgVuYHAZLock8OIsmrR5HvV5QpTLsRPEcb7u2SKCmhbnVCUI6JdX7xyMXmQdxF
	 KWzjG8cABREGKkqai6lnN7NxqPamSrL7EW5X2sTk9ztn/mgqW3eFhdLuKcoyhuJOTa
	 giIJSgg2v4BXioIIPzxkJd4Hm/jSohjOuhdn04XisQUZG4Nd68+bDFItTfERuwNNGR
	 jadKuwlDJYRP3hBKbuxEctNC9eQpi8Ed55/bC60XptAvopuJ+jMoqdCEcB4TliiLST
	 /00XDu3zpu+S6F7/ECUv/Mm56ASVoafa3/jxpMecG7/1i15YsMopQD8BRlLR+ti2E0
	 Qak9vUXPrf5CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv9 net-next] tcp: Add TCP ROCCET congestion control
 module.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Fuechsel" <t.fuechsel@gmx.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <arqDuiD4Q4GWOFBc@volt-roccet-vm>
References: <arqDuiD4Q4GWOFBc@volt-roccet-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 15:12:18 +0000
Message-Id: <20260929151219.5F0A81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tcp: ROCCET stalls Fast Retransmit by bypassing PRR in TCP_CA_Reco=
very
- [High] tcp: integer promotion bug falsely triggers congestion events on R=
OCCET
- [Low] build: struct roccettcp exceeds ICSK_CA_PRIV_SIZE limit
--

commit 1022dd98954ad71bd010ccb13665b66dd4141109
Author: Tim Fuechsel <t.fuechsel@gmx.de>

tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC that
improves overall performance in cellular networks. It introduces additional
metrics like relative increase in RTT and acknowledgment arrival rate to
address bufferbloat and manage window scaling.

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
> @@ -0,0 +1,1400 @@
[ ... ]
> +struct roccettcp {
> +	u32 cnt;	/* increase cwnd by 1 after ACKs */
[ ... ]
> +	u16 ack_rate_cnt;	/* Used for counting acks */
> +
> +	enum roccet_state state : 3; /* Current operating state of roccet */

[Severity: Low]
Will this bitfield layout cause a compile-time failure?

Because the preceding field is u16 (which ends at offset 102), the compiler
inserts 2 bytes of padding to align the enum allocation unit, which needs
4-byte alignment, at offset 104. This expands the total struct size to 108
bytes.

> +	bool initial_limit_reached: 1;	/* Set to true after the connection
[ ... ]
> +static int __init roccet_register(void)
> +{
> +	int param_err;
> +
> +	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);

Since ICSK_CA_PRIV_SIZE is statically defined as 104 bytes in
include/net/inet_connection_sock.h, it seems this check will unconditionally
fail and break the module build.

[ ... ]
> +static void roccet_orbiter_update(struct sock *sk, u32 acked)
> +{
[ ... ]
> +	/* Check sent and received bytes from the previous interval.
> +	 * Here we use a guard space of 1% of the current cwnd.
> +	 * We do this to avoid a false positive evaluation due
> +	 * to delays caused by jitter or scheduling.
> +	 */
> +	sent_more_than_acked =3D (s32)(sent - received) >
> +			       div_u64((u64)tcp_snd_cwnd(tp) *
> +			       (u64)tp->mss_cache, 100);

[Severity: High]
Does this comparison trigger false congestion events when ACKs outpace outg=
oing
data?

If received exceeds sent, sent - received wraps to a very large u32. When
cast to s32, it correctly represents a negative difference.

However, because div_u64() returns a u64, standard C arithmetic conversions
cause the negative s32 to be sign-extended and promoted to u64.

This results in a huge positive number, making the condition incorrectly
evaluate to true, which freezes congestion window growth.

[ ... ]
> +	/* Terminates this function if cwnd is not fully utilized.
> +	 * In mobile networks like 5G, this termination causes the
> +	 * cwnd to be frozen at an excessively high value. This is
> +	 * because slow start or HyStart massively exceed the available
> +	 * bandwidth and leave the cwnd at an excessively high value.
> +	 * The cwnd cannot therefore be fully utilized because it is
> +	 * limited by the connection capacity.
> +	 *
> +	 * Also avoid cwnd-growth if we are in cwnd reduction phase.
> +	 */
> +	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked ||
> +	    tcp_in_cwnd_reduction(sk))
> +		return;

[Severity: High]
Can returning early here during TCP_CA_Recovery stall Fast Retransmit?

When a socket enters loss recovery, the TCP core delegates all congestion
control processing to the cong_control callback, bypassing the standard
tcp_cwnd_reduction() PRR routine.

If roccet_orbiter_update() always returns early without inflating snd_cwnd
for incoming dupACKs:

[ ... ]
> +static void roccet_state(struct sock *sk, u8 new_state)
> +{
[ ... ]
> +	} else if (new_state =3D=3D TCP_CA_Recovery) {
> +		/* Directly reduce cwnd and rely on pacing */
> +		cwnd =3D roccet_handle_recovery(sk);
> +		tcp_snd_cwnd_set(tp, cwnd);
> +	}

The snd_cwnd is statically reduced upon entering recovery. Because it is
never inflated by dupACKs, tcp_packets_in_flight() will remain above the
reduced snd_cwnd.

When tcp_xmit_retransmit_queue() attempts to fast retransmit, it calculates
available segments as tcp_snd_cwnd(tp) - tcp_packets_in_flight(tp) which
evaluates to <=3D 0, completely preventing retransmissions until an RTO fir=
es.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arqDuiD4Q4GWOFBc@vo=
lt-roccet-vm?part=3D1
