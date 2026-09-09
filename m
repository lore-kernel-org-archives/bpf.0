Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739A2EFD9B;
	Wed,  9 Sep 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966381; cv=none; b=rUxskgT3VEyBNghNt+6/kLgDRYiEwu5Ra9qlh81JbqiV2KMwOObsjK6wdbXf4rw1EkTkjJuBKseTm2dBETfbAm16TgQbPw+VPXnbd1ZfSFMfJvPekvW9NyqZTMUPbJentLiJXMrQC3lrGc/f9ToNDnDwZ4iiOUf4u4uehVYli74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966381; c=relaxed/simple;
	bh=yabihiRtc+OyrJ4wRyvigDmme4CVUHpQrO3pHMwLN3s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UHg1X8wUPjGwUXQMfS3GX0sq0wFBIBeBG4HNJ3n8sesTMq0H/Lz/uCdvpHerA26tHDQ5UN0dFCvv6oINtGaN2Q3+P4hru5zI91Xeiw0E+gjZ1+I5jdDbX3HBPim4C2LtHhPD0/8LHXJIckqwo8MbM3yw3o1vuXExnHOjg6/ffCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACFPLCrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACFPLCrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9825F1F00A3A;
	Wed,  9 Sep 2026 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966379;
	bh=UENA8jCUZQAc8iZ7vC/BLUZox9hbgrKC9gfsqY1wUAk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ACFPLCrGYE0DWlpQcP5pNBwyL11aVApKadPScZz0wTGKUf5nJQBRap00SQ8OSknSI
	 9XHfMiRouE2IPF+P8/cJKPJ/XhnPf2yqD9psJEvStksoSKRQyrC4L22aIsB28nW443
	 MG0Q6TQcxOvgliNMcPgfHR+nouzaiy7B8NJD5MLbpzgB+0ujNQ0msg1XxpozMn/gWR
	 ha9pQZwqzXVU2myczZCGWrE6KTTypo5FOtqzbvXIbP7w6KFnW0nJZMBUtQp6OPXC5/
	 cJqxpHHhOc+usRL/tD7ZLrvAVThBb72x3+pn5GKGjPhnYnmf8c92wWte3shLJ7pVd8
	 Dv1kblFwOn3Mg==
Subject:
 Re: [PATCH v2] bpf, sockmap: Fix self-redirect copied_seq double-counting
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, tanggeliang@kylinos.cn,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 09 Sep 2026 15:06:18 +0000
Message-ID: <178896637807.219967.17814650555231944505@kernel.org>
In-Reply-To: =?utf-8?q?=3C1d2370f4c81f10834b8dd77524924575c629a464=2E1788591?=
 =?utf-8?q?198=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C1d2370f4c81f10834b8dd77524924575c629a464=2E17885911?=
 =?utf-8?q?98=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1 (1)

- [Medium] sk_psock_verdict_apply() is the verdict path for every sockmap
  protocol that implements ->read_skb (TCP, AF_UNIX, vsock, UDP), not…
- [Low] The changelog names a function that does not exist.

Pre-existing issues:
- [Medium] psock->ingress_bytes is a plain non-atomic u32 that is
  incremented in sk_psock_skb_ingress_enqueue() (net/core/skmsg.c:575)…
- [Low] Reported concern: routing an ingress self-redirect through `case
  __SK_PASS` only balances copied_seq when the inline…

--

bpf, sockmap: Fix self-redirect copied_seq double-counting

The patch rewrites an ingress self-redirect verdict into __SK_PASS at the
top of sk_psock_verdict_apply() so the skb goes to the psock ingress queue
instead of through the __SK_REDIRECT arm. The intent is that copied_seq is
advanced only once, by the copied_from_self accounting in
tcp_bpf_recvmsg_parser().

A few questions on the changelog and on the scope of the new check.

The changelog says:

  "This bypasses the __SK_REDIRECT case entirely (which calls
   sk_psock_eat_skb), letting the __SK_PASS path queue the skb to the
   psock ingress queue."

and:

  "Cross-socket redirects continue through __SK_REDIRECT with
   sk_psock_eat_skb() unchanged."

[Severity: Low]
Is sk_psock_eat_skb() the intended name here? A grep of the tree finds no
such symbol. The helper actually invoked in the __SK_REDIRECT arm of
sk_psock_verdict_apply(), and in the drop arm, is tcp_eat_skb() from
net/ipv4/tcp_bpf.c, which the first paragraph of the same changelog names
correctly. Since this carries a Fixes: tag and will likely be backported,
could the name be corrected to tcp_eat_skb()?

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05d..df385a5a961e8 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
>  	int err = 0;
>  	u32 len, off;
>  
> +	if (verdict == __SK_REDIRECT && skb_bpf_ingress(skb) &&
> +	    skb_bpf_redirect_fetch(skb) == psock->sk)
> +		verdict = __SK_PASS;
> +

[Severity: Medium]
Should this remap be gated on sk_is_tcp(psock->sk)?

sk_psock_verdict_apply() is reached from every protocol that implements
->read_skb, not only TCP: unix_read_skb() and the vsock/UDP equivalents all
funnel into sk_psock_verdict_recv() -> sk_psock_verdict_apply(). For those
protocols there is no copied_seq to fix, since tcp_eat_skb() returns
immediately for !sk_is_tcp(sk).

For AF_UNIX the skb owner is the sender socket (set by
sock_alloc_send_pskb()), so before this patch a self-redirect took:

  __SK_REDIRECT
    sk_psock_skb_redirect()      -> psock->ingress_skb
      sk_psock_backlog()
        sk_psock_skb_ingress()

and there the "if (unlikely(skb->sk == sk))" shortcut is not taken, so
sk_psock_create_ingress_msg() ran its admission test:

net/core/skmsg.c:sk_psock_create_ingress_msg() {
	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
		return NULL;

	if (!sk_rmem_schedule(sk, skb, skb->truesize))
		return NULL;
	...
}

With the remap, the same traffic enters case __SK_PASS and, whenever
psock->ingress_skb is empty (now the steady state, since nothing is queued
there any more), goes straight to sk_psock_skb_ingress_self(), which only
does skb_set_owner_r() and performs no sk_rcvbuf or sk_rmem_schedule()
check.

Can psock->ingress_msg then grow past SO_RCVBUF for AF_UNIX/vsock
self-redirect traffic, with the sender un-throttled once skb_orphan() inside
skb_set_owner_r() drops its wmem charge?

The changelog describes the change as TCP copied_seq accounting only, so the
non-TCP behaviour change is not mentioned anywhere. Could the condition be
scoped to the protocol that actually has the defect?

[Severity: Low]
This is a pre-existing issue rather than something introduced here, but the
remap newly routes self-redirected data into it, so it may be worth a note.

Routing the self-redirect through case __SK_PASS only balances copied_seq
when the inline sk_psock_skb_ingress_self() enqueue succeeds. When
psock->ingress_skb is non-empty the skb is merely queued and
psock->ingress_bytes is not incremented during the read pass, while
tcp_bpf_strp_read_sock() still commits:

net/ipv4/tcp_bpf.c:tcp_bpf_strp_read_sock() {
	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
	...
	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
}

That common deferral looks balanced, because sk_psock_strp_read() clears the
owner before applying the verdict:

net/core/skmsg.c:sk_psock_strp_read() {
		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
		skb->sk = NULL;
	}
	sk_psock_verdict_apply(psock, skb, ret);

so the worker later misses the "skb->sk == sk" shortcut in
sk_psock_skb_ingress(), msg->sk stays NULL, and "from_self = msg_rx->sk ==
sk" in __sk_msg_recvmsg() is false.

The one case that does not balance is when sk_psock_skb_ingress_self() has
already run skb_set_owner_r() (making skb->sk == psock->sk) and then fails
in sk_psock_skb_ingress_enqueue() because skb_to_sgvec() exceeds
MAX_MSG_FRAGS and skb_linearize() returns -ENOMEM. The deferred skb then
does take the self branch, msg->sk is set, and copied_from_self advances
bytes that tp->copied_seq already covers, giving the same warnings quoted in
the changelog. The identical window exists for ordinary __SK_PASS strparser
traffic today.

[Severity: Medium]
This isn't a bug introduced by this patch either, but since the remap makes
the socket's own data depend on this counter in strparser mode, is the
accounting of psock->ingress_bytes safe?

It is a plain u32 with a non-atomic increment in
sk_psock_skb_ingress_enqueue():

net/core/skmsg.c:sk_psock_skb_ingress_enqueue() {
#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
	psock->ingress_bytes += len;
#endif
}

That site is reached both with the socket lock held (strp_read_sock() ->
tcp_bpf_strp_read_sock() -> sk_psock_strp_read() ->
sk_psock_verdict_apply()) and from sk_psock_backlog(), which runs on the
workqueue holding only psock->work_mutex and never takes lock_sock().

CPU1 (socket lock held)
tcp_bpf_strp_read_sock()
    psock->ingress_bytes = 0;
    tcp_read_sock_noack(...);
    tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
    __tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);

CPU0 (work_mutex only), draining an skb another socket redirected in via
sk_psock_skb_redirect(), whose bytes were never part of psock->copied_seq:

sk_psock_backlog()
    sk_psock_handle_skb()
        sk_psock_skb_ingress_enqueue()
            psock->ingress_bytes += len;

If the worker increment lands inside that window, does tp->copied_seq end up
subtracting foreign bytes, and can "copied - psock->ingress_bytes" go
negative? There is no lock, atomic, or READ_ONCE/WRITE_ONCE pairing on this
field at any of its three access sites.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1d2370f4c81f10834b8dd77524924575c629a464.1788591198.git.tanggeliang%40kylinos.cn
