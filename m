Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEB318EDA
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853700; cv=none; b=fI8vBsDBQBJb/5ANBjacmADHbU5jYwLK5omkBjvINAtjCZlU5w4nQUmhhUSDMBxxeG5tZmAifdJnRSUlBMkyEFAhVrZG6hcXk9Ekpw7Pt9AipuBS2+gtYBBU+finr8hkWTOoVBChbzm6R+lkT3ptoC5ZXThPNnxDshWhYkGJz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853700; c=relaxed/simple;
	bh=n1jrvRHdDjtNcqvMRxqiQxrZCn026n71jfklfB00IRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=seYwKQ7NADMTWQCfRAcYEE6NQjyTkqx+rf0nqvm22Zqh8xGBZMpwpSw0NHEBbav0wT+VSfSc6Zqo5VGcl8ax6boPcy3AOphNMnX82w2DGcF2z6tFeCAYOKhIA860aanw679vHybbGKyvwYo0dQc8unf1jgAO7PA+isi7a/NYb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0zur7D0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0zur7D0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD6A1F000E9;
	Tue, 30 Jun 2026 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782853697;
	bh=TsLc3UORcc7krVpZGtn/ZlPAL+jHqnIle3rSf/xm3yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0zur7D04s+XxasbMKhb8hPMr07u1+mhMgPYGtoMCN24aKBjY9L/VIFthHXky9+LZ
	 EMJh55s/ci9FJiz3IQ1rHT75GFqmTkuMDh3yR2wGQb+rm+5ub5rRpwwTxaXLZkIyH7
	 mZGGayIWZuth+Fj5ist9ICV45WuzSFdbaEjcZyTj7TguplPzhXw8+5hk0x5K6w+8qu
	 CprDIHNjQORQElIsc+td1jxgA8p+DRKrraMXsI8xj3LcwMj7hG9qizZs4Ed+79PSeZ
	 zPVTCxvLgFjLPYOm3sghmdqyDNjP/9kro36VO2A2aI1D3wm5xikp5wcXBJTiSuri7V
	 9Zw/wNAJ3Zdhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: settle copied_seq when a stream
 parser is removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630205043.184894-2-rhkrqnwk98@gmail.com>
References: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
 <20260630205043.184894-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 21:08:17 +0000
Message-Id: <20260630210817.7BD6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Modifying `tcp_sk(sk)->copied_seq` in `tcp_bpf_update_proto` witho=
ut holding `lock_sock(sk)` introduces a data race with concurrent TCP opera=
tions.

Pre-existing issues:
- [High] The patch only settles `copied_seq` for sockets using a stream par=
ser, but sockets using `skb_verdict` suffer from the identical trailing `co=
pied_seq` bug.
- [High] `tp->copied_seq` is incorrectly updated in `tcp_bpf_strp_read_sock=
()`, double-counting bytes if userspace partially reads data.
--

commit 75c8f708aa799c9c48eb6ff6ab39fc06c1f80d27
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: settle copied_seq when a stream parser is removed

tcp_bpf_strp_read_sock() rolls tp->copied_seq back by the SK_PASS bytes
parked on the psock ingress_msg queue; tcp_bpf_recvmsg_parser() repays it
as those bytes are delivered. When the socket leaves the sockmap they are
purged undelivered and nothing repays the rollback, so copied_seq is left
behind sk_receive_queue and the native tcp_recvmsg() warns.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..918f8da02c394 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -715,6 +715,15 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_=
psock *psock, bool restore)
>  	}
> =20
>  	if (restore) {
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +		/*
> +		 * Settle the copied_seq rollback for the now-discarded
> +		 * ingress_msg data so it cannot trail the receive queue
> +		 */
> +		if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED) &&

[Severity: High]
This is a pre-existing issue, but does checking SK_PSOCK_RX_STRP_ENABLED
leave skb_verdict programs vulnerable to the exact same TCP recvmsg sequence
bug?

If a sockmap is configured with BPF_SK_SKB_VERDICT, passes packets to SK_PA=
SS,
and then the socket is deleted from the sockmap before all data is read,
copied_seq will still trail sk_receive_queue since the stream parser is not
enabled.

> +		    before(tcp_sk(sk)->copied_seq, psock->copied_seq))
> +			WRITE_ONCE(tcp_sk(sk)->copied_seq, psock->copied_seq);

[Severity: High]
Does modifying tcp_sk(sk)->copied_seq here without holding lock_sock(sk)
introduce a data race?

If a user-space program deletes an element from a sockmap (e.g., via
bpf_map_delete_elem) concurrently while another thread receives data from t=
he
same socket using recvmsg(), the map deletion calls sock_map_unref inside an
RCU/spinlock section without acquiring lock_sock(sk).

This lockless write to copied_seq could race with non-atomic read-modify-wr=
ite
operations in tcp_recvmsg_locked() (such as WRITE_ONCE(*seq, *seq + used)),
leading to lost updates or sequence jumps that corrupt the TCP stream state.

> +#endif
>  		if (inet_csk_has_ulp(sk)) {
>  			/* TLS does not have an unhash proto in SW cases,
>  			 * but we need to ensure we stop using the sock_map

[Severity: High]
This is a pre-existing issue, but is tp->copied_seq incorrectly updated in
tcp_bpf_strp_read_sock()?

net/ipv4/tcp_bpf.c:tcp_bpf_strp_read_sock() {
    ...
    tp->copied_seq =3D psock->copied_seq - psock->ingress_bytes;
    ...
}

If userspace partially consumes data from ingress_msg via recvmsg(), leaving
some bytes in the queue, and then the stream parser wakes up and reads anot=
her
batch of packets into ingress_msg, this calculation ignores the older, unre=
ad
bytes.

Could this double-count older bytes when they are later read, causing
copied_seq to exceed rcv_nxt and permanently corrupting the TCP sequence st=
ate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630205043.1848=
94-1-rhkrqnwk98@gmail.com?part=3D1
