Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259093;
	b=TsBPdbmFTWH0oGkWos9MHgirrmd4mrJHUh0qN/nc/g0XOgLRk8VIPrIeo3DtuZdbzFbG
	 ADg/d06HwKbop/SmIj4qSpkCQ+njUpLZRKryPabTLiCzlqWdZQvtmmmH406HA22usbDHo
	 Sj8SzSSmyaT/2uLfcfwb5rRxIdlwhW/FTpyOV1s5fq5I7tqU3IKTvWGKYj8Dy6naue3IA
	 7wvbdJNgIf3Ln1Rr3Nq7o9ucn0mCQbMfZdsGKfaiUhQA6SdYZTk5gUi6x2a1Kg5/ZJ7bo
	 ZD8GACCrf0D334ji2nx1noi7rf29oRQztMbT+zjaSCZscVmH+mx2ui6kVELmVMyfhVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m463tzKA+DuHeJBtXClyGFjn71rbwahVEUeLdtNrPSA=;
	b=fCdQCMAJP4bWXTMubW57ZC6jv5Cuirh8XPIRZiV/cZgpgtejTWPiitDbPHD0Kp9qu3p4
	 8b4amg27GhvpFQ0qYqKiL+Dcq/67znqlFtK11TcP8t2+tn3RGx1aLHX5iN9sED4GJBiet
	 ZajmMQL3KkYU6IdQ1w6FXuao0Aoc2ccCVEsOyhkMHbtP32BAeaB7r1uLW8VOgTSfLvQ1e
	 ayobDGpYHoiHbxTyzgp4WaPGCJW8QFVusAjnmN9/Ux/ebAUdQeuTnc7y+k6Hv0ImWCfFM
	 B+aRrTqsGBStlD2gv/9VWPBFPvG1ZtyvXMmvxZKSM5gLnwSI8TBvhvm6dxQuYIdLW8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSRxXu3b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C7606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSRxXu3b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702791F000C0;
	Sat, 21 Nov 2026 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795259092;
	bh=m463tzKA+DuHeJBtXClyGFjn71rbwahVEUeLdtNrPSA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eSRxXu3bqnppyde8BAFoUSBqdIGibB2WGKwLs2j9OEBeALdhWLb137vZBUh4tKK73
	 NeCPnbYAtVoUsiAdIU1S5W/8hoQ3Jy/tpDnqHbb+DiteNAenBL1iTsrR7HFYRpJwoU
	 6HDZPABkv19H5gHRtt5qqsJYL+A7WXplEdJDf02VziT5CQjYFOi0IKvzUySCPGCgG5
	 CUZppMvT04/xaySAqvn4+EKFpn9FJfDM+fJ3Aknz3lBfbisA/f6T1VbNP26w96Ne1H
	 i+N5P3YSRByx7kuuqH/EHvi9FJESDGjlcTZWFaOs2taQHQRKeI0ocDW3IYpSUpgaXO
	 1KqV8E2U/SZPg==
Message-ID: <sashiko-outbox-226969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 03/11] bpf, sockmap: Fix strparser reinit after the
 parser link is removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261121103222.88209-4-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
 <20261121103222.88209-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:04:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] bpf, sockmap: active work_struct reinit on psock->rwork in
  skmsg
- [High] bpf, sockmap: sk_psock_init_strp() rewinds psock->copied_seq
- [High] bpf, sockmap: softirq livelock in sock_map_destroy() on rwork
  put
- [Medium] bpf, sockmap: race and missing wait in
  sock_map_strp_done_wait()
--

commit d7a98bf12f6088d3395a10dfb32d450db8554b49
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, sockmap: Fix strparser reinit after the parser link is removed

This commit tears down the strparser asynchronously via psock->rwork when
a parser link is removed while other sockmap links keep the psock alive,
and blocks attaching a new parser until teardown finishes.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 16f84dcb5acd9..43dc128841e98 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -879,6 +879,18 @@ static void sk_psock_destroy(struct work_struct *wor=
k)
>  {
>  	struct sk_psock *psock =3D container_of(to_rcu_work(work),
>  					      struct sk_psock, rwork);
> +
> +	if (sk_psock_test_state(psock, SK_PSOCK_STRP_DONE_PENDING)) {
> +		/* Parser link gone, other links keep the psock alive */
> +		sk_psock_done_strp(psock);
> +		write_lock_bh(&psock->sk->sk_callback_lock);
> +		sk_psock_clear_state(psock, SK_PSOCK_RX_STRP_ENABLED);
> +		sk_psock_clear_state(psock, SK_PSOCK_STRP_DONE_PENDING);
> +		write_unlock_bh(&psock->sk->sk_callback_lock);
> +		sk_psock_put(psock->sk, psock);
> +		return;
> +	}
> +
>  	/* No sk_callback_lock since already detached. */
> =20
>  	sk_psock_done_strp(psock);

[Severity: High]
Does calling sk_psock_put() with bottom halves enabled here risk a
softirq livelock in sock_map_destroy()?

When the removed parser link was the last link on the socket,
sk_psock_queue_strp_done() holds a psock reference until rwork runs.  If
the socket is closed in the meantime, sock_map_close() does not wait for
rwork and calls saved_close() while sk->sk_prot->destroy is still
sock_map_destroy.  When rwork drops the last psock reference with BH
enabled, a softirq destroying the socket on the same CPU can interrupt
between refcount_dec_and_test() and sk_psock_restore_proto():

sk_psock_destroy()
  write_unlock_bh(&sk->sk_callback_lock)
  sk_psock_put(sk, psock)
    refcount_dec_and_test(&psock->refcnt) -> true
    <softirq>
      tcp_v4_rcv()
        ...
          sock_map_destroy()
            sk_psock_get(sk) -> NULL
            READ_ONCE(sk->sk_prot)->destroy =3D=3D sock_map_destroy
            goto retry;  <-- spins forever
    sk_psock_drop()
      sk_psock_restore_proto()

The interrupted kworker cannot resume to restore sk->sk_prot, so the CPU
hard-locks in the retry loop.

> @@ -1208,6 +1220,18 @@ void sk_psock_stop_strp(struct sock *sk, struct sk=
_psock *psock)
>  	strp_stop(&psock->strp);
>  }
> =20
> +/* Called with sk_callback_lock held while a link still holds the psock =
*/
> +void sk_psock_queue_strp_done(struct sk_psock *psock)
> +{
> +	if (!sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED) ||
> +	    test_and_set_bit(SK_PSOCK_STRP_DONE_PENDING, &psock->state))
> +		return;
> +
> +	refcount_inc(&psock->refcnt);
> +	INIT_WORK(&psock->rwork.work, sk_psock_destroy);
> +	schedule_work(&psock->rwork.work);
> +}
> +
>  static void sk_psock_done_strp(struct sk_psock *psock)
>  {
>  	/* Parser has been stopped */

[Severity: High]
Can re-initializing psock->rwork here and in sk_psock_drop() corrupt the
work item while it is still executing or being flushed?

When sk_psock_destroy() finishes the SK_PSOCK_STRP_DONE_PENDING path and
calls sk_psock_put(), dropping the last reference calls sk_psock_drop() ->
INIT_RCU_WORK(&psock->rwork, sk_psock_destroy) from inside the running
psock->rwork.work callback.  If another link kept the psock alive, a
concurrent parser attach and detach on another CPU can likewise call
sk_psock_queue_strp_done() -> INIT_WORK(&psock->rwork.work, ...) as soon
as sk_callback_lock is released, while the first worker is still in
process_one_work() or while another task is in flush_work():

CPU0 (kworker)                    CPU1
process_one_work(rwork.work)
  sk_psock_destroy()
    clear SK_PSOCK_STRP_DONE_PENDING
    write_unlock_bh()
                                  sock_map_del_link()
                                    sk_psock_queue_strp_done()
                                      INIT_WORK(&psock->rwork.work, ...)
                                      schedule_work(&psock->rwork.work)
    sk_psock_put()
      sk_psock_drop()
        INIT_RCU_WORK(&psock->rwork, ...)
        queue_rcu_work(..., &psock->rwork)
                                  process_one_work(rwork.work)
                                    sk_psock_destroy()
                                      kfree(psock)  <-- use-after-free

INIT_WORK() and INIT_RCU_WORK() overwrite work->data (wiping the worker
pool ID needed by find_worker_executing_work() and start_flush_work())
and re-initialize work->lockdep_map.  That lets __queue_work() run
sk_psock_destroy() on a second CPU concurrently while the first worker is
still finishing, and causes flush_work() in sock_map_strp_done_wait() to
see a NULL pool and return early without waiting.  Could psock->rwork be
initialized once in sk_psock_init() instead?

[Severity: High]
When a surviving psock is later added to another parser map and goes
through sk_psock_init_strp() again, does resetting psock->copied_seq drop
subsequent incoming TCP data?

net/core/skmsg.c:sk_psock_init_strp() {
    ...
	if (sk_is_tcp(sk)) {
		psock->strp.cb.read_sock =3D tcp_bpf_strp_read_sock;
		psock->copied_seq =3D tcp_sk(sk)->copied_seq;
	}
    ...
}

In tcp_bpf_strp_read_sock(), tp->copied_seq is held behind
psock->copied_seq by the unread SK_PASS bytes sitting in
psock->ingress_msg.  If unread SK_PASS messages from the first parser are
still queued in psock->ingress_msg when the second parser is initialized,
overwriting psock->copied_seq with tcp_sk(sk)->copied_seq rewinds
psock->copied_seq behind the next skb on sk->sk_receive_queue.  On later
packets, tcp_recv_skb() computes offset =3D seq - TCP_SKB_CB(skb)->seq,
which underflows u32 to a value larger than skb->len and causes
__tcp_read_sock() to discard incoming skbs via tcp_eat_recv_skb().

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 0d7a8d9405d19..8b14a338a0327 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -115,6 +115,33 @@ int sock_map_prog_detach(const union bpf_attr *attr,=
 enum bpf_prog_type ptype)
>  	return ret;
>  }
> =20
> +/*
> + * Wait for the strparser of a removed parser link to be torn down, so t=
hat
> + * a new parser can be attached right after the old one was removed.
> + */
> +static void sock_map_strp_done_wait(struct bpf_map *map, struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +
> +	if (!READ_ONCE(sock_map_progs(map)->stream_parser))
> +		return;
> +
> +	rcu_read_lock();
> +	read_lock_bh(&sk->sk_callback_lock);
> +	psock =3D sk_psock(sk);
> +	if (!psock ||
> +	    !sk_psock_test_state(psock, SK_PSOCK_STRP_DONE_PENDING) ||
> +	    !refcount_inc_not_zero(&psock->refcnt))
> +		psock =3D NULL;
> +	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_unlock();
> +	if (!psock)
> +		return;
> +
> +	flush_work(&psock->rwork.work);
> +	sk_psock_put(sk, psock);
> +}

[Severity: Medium]
Can a back-to-back map update still race with a dying zero-link psock or
attach to it before teardown finishes?

kworker                           CPU1
sk_psock_destroy()
  write_lock_bh(&sk_callback_lock)
  clear SK_PSOCK_STRP_DONE_PENDING
  write_unlock_bh(&sk_callback_lock)
                                  sock_map_update_elem_sys()
                                    sock_map_strp_done_wait()
                                      /* DONE_PENDING clear: no wait */
                                    sock_map_link()
                                      sock_map_psock_get_checked()
  sk_psock_put()
    refcount_dec_and_test() -> 0
                                        refcount_inc_not_zero() -> 0
                                        return ERR_PTR(-EBUSY)
    sk_psock_drop()
      rcu_assign_sk_user_data(sk, NULL)

Because sk_psock_queue_strp_done() takes a reference on psock when the
last link is removed, the zero-link psock stays in sk->sk_user_data until
rwork drops that reference.  Clearing SK_PSOCK_STRP_DONE_PENDING before
sk_psock_put() opens a window where sock_map_strp_done_wait() does not
flush, and sock_map_psock_get_checked() either returns -EBUSY (if refcnt
just hit 0) or resurrects the dying psock with its old
psock->progs.msg_parser still installed.

Also, because sock_map_strp_done_wait() and the SK_PSOCK_RX_STRP_ENABLED
check in sock_map_link() both only trigger when the new map has a
stream_parser, adding the socket to a map without a stream_parser right
after removing its last link from a parser map skips the wait completely:
it can hit the same resurrection or -EBUSY, or call
sk_psock_start_verdict() while strp_done() is still pending.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121103222.8820=
9-1-jiayuan.chen@linux.dev?part=3D3
