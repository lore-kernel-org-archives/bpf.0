Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADF3264D9
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915174; cv=none; b=ITZvsvfnVYBEk+ryMG/Pm+FD4VeuMmfznPcvjeq0KzhiVTIbXWh20TPbglzqmtkg+Utz3Aq3JX3I31xXx/NnY25qMP64XZZRdrNiVXr/RfzKfjlpDH23PkJeu0OdLtCTQz9k+5t1124ciippLb7+hd7tQLvB0s+mJnJ16Nwm0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915174; c=relaxed/simple;
	bh=B6x7JfT/tl+Dml1ouuFy24jxPbAHUC6LStI8xOklhRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KW9+L/uYrJqNjHBszuacd5x0PoDfVWyuQZq2aQmwG0jHmVwb8s66g7j5Tfkr5DtXncIBO/QP2Rnxsbd47hPQFAwZUS7BfP3KGnOqYB/DT0A3lN7mnOUPWjuI/pPGUk/6oenyXwX0zjOA0b0Rp3AmaS6B6OarlxRhl4AGipgILXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF26Bcwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF26Bcwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6E21F00899;
	Sun, 20 Sep 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915168;
	bh=kEdm4ld5ypPnxvlHFVi7JqQB1AqUYJAi6XLjr5MQlHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OF26Bcwf7IJVNMHseHtd993Ffd3wuMlrLYPYxsX9wrNCCGhlFTR+UYdDyfvs+gMJq
	 POCf6pQSoR1eJYHYRM64jHHrqu8ob8Z7Va8XHt28BqTUb7zk6faMXRGVneZzndLOu7
	 IMZWdoUI/YAka8FHP/IXP2PwLFfXpYcyoa179q0soF8i3ZSVU7XGTzWYWPbv+Ye5Ie
	 cm60sSldDtLWYQiMipzp4nexAsHNuRq7rcnY9K356ymF8+/VC+VaZLdTlxAwvl8y4J
	 Jogal/lNid2i9ynUKqA4dMwr7eUcjOYRi75H5R+FXOwM7eptkRSBNhz6bDhc56uLce
	 HDBeYbPscAyQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 7/9] tcp: propagate the start time onto
 every skb in the tx path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-8-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:28 +0000
Message-Id: <20260920143928.BD6E21F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: MPTCP subflows leave sk_start_time uninitialized causing hard=
ware timestamp leak
- [High] net: global pskb_copy performance regression for hardware timestam=
ping
- [Medium] bpf: start_time leaks to receiver as hardware timestamp over loo=
pback
- [Medium] tcp: TFO SYN-data segments bypass sk_start_time assignment
--

commit 1c42878ae739db740438d18e58461996447a2443
Author: Jason Xing <kerneljasonxing@gmail.com>

tcp: propagate the start time onto every skb in the tx path
   =20
Now that sendmsg() records a start time in sk->sk_start_time within
the socket lock protection, copy that value into the shared hwtstamps
of each skb.

The timing is tcp_skb_entail() runs once per newly allocated skb
in the sendmsg() loop, every segment produced by a single sendmsg()
carries the same start time.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index f07abd53ed27f..040f612608476 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -705,6 +705,9 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *=
skb)
>  	tcb->tcp_flags =3D TCPHDR_ACK;
>  	__skb_header_release(skb);
>  	psp_enqueue_set_decrypted(sk, skb);
> +	if (static_branch_unlikely(&bpfts_v2_needed_key) &&
> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TIMESTAMPING_V2))
> +		skb_hwtstamps(skb)->start_time =3D sk->sk_start_time;

[Severity: Medium]
Does this leak the internal timestamp to the receiver as a hardware timesta=
mp
over local virtual interfaces?

When sending traffic over loopback or veth, the SKB enters the receive path.
skb_scrub_packet() clears skb->tstamp but not skb_shinfo(skb)->hwtstamps.

Since start_time and hwtstamp share a union, does the receiving socket
erroneously read the sender's software start_time as a hardware RX timestam=
p?

[Severity: Medium]
Does this code miss assigning sk_start_time for Fast Open segments?

tcp_sendmsg_fastopen() delegates to tcp_connect() to allocate and queue the
SYN segment carrying payload:

net/ipv4/tcp_output.c:tcp_connect() {
    ...
    buff =3D tcp_stream_alloc_skb(sk, sk->sk_allocation, true);
    ...
    tcp_init_nondata_skb(buff, sk, tp->write_seq, TCPHDR_SYN);
    ...
    tcp_connect_queue_skb(sk, buff);
}

Both tcp_connect() and tcp_send_syn_data() bypass tcp_skb_entail().
Will this result in a loss of BPF timestamping functionality for any
application using MSG_FASTOPEN?

[Severity: High]
Can this corrupt the shared SKB in the write queue for MPTCP sockets?

MPTCP bypasses tcp_sendmsg_locked(), which leaves the subflow socket's
sk_start_time uninitialized (0). When __mptcp_alloc_tx_skb() calls
tcp_skb_entail(), the SKB's start_time is set to 0.

Upon TX completion with a hardware timestamp, the callback in
skb_tstamp_tx_report_bpf_timestamping() reads the 0:

net/core/skbuff.c:skb_tstamp_tx_report_bpf_timestamping() {
    ...
    if (static_branch_unlikely(&bpfts_v2_needed_key) && start)
        skb_hwtstamps(skb)->start_time =3D start;
}

Since the check fails when start is 0, does this permanently leak the
hardware timestamp into the shared orig_skb in the transmit queue?

[Severity: High]
Does this series introduce a system-wide performance regression for all
hardware TX timestamping users?

When the static key is enabled, all hardware timestamps fall into this path:

net/core/skbuff.c:__skb_tstamp_tx() {
    ...
    if (static_branch_unlikely(&bpfts_v2_needed_key) && hwtstamps)
        skb =3D pskb_copy(orig_skb, GFP_ATOMIC);
    else
        skb =3D skb_clone(orig_skb, GFP_ATOMIC);
}

Because the static key is globally enabled when BPF timestamping is used,
will unrelated sockets using normal SO_TIMESTAMPING suffer the high overhead
of copying the entire SKB head via pskb_copy() instead of skb_clone()?

>  	tcp_add_write_queue_tail(sk, skb);
>  	sk_wmem_queued_add(sk, skb->truesize);
>  	sk_mem_charge(sk, skb->truesize);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D7
