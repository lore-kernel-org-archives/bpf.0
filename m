Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CC378D84
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702848; cv=pass; b=Q+ilcFWoZ4NBNDIu0WpyimIK3Mk67F2n4XUSBkkMu+YYOTUfuwVYKMw9Ejur1ZVxd5lIlP5eYIDHESdMwTuTJ5/lcQoHt0SS9lsSdfq5myrYXDt4HbZ0Cb1Iyp0pdrhpTtNtLGxo4CQvLLqtbUBi5KdJCUVUcjSasb0cUXW5Oyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702848; c=relaxed/simple;
	bh=lMjYfl+Pmb7NDXCB4+hmAwoURdeJLXQAEFQ0PlMbzDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptrx72ZXUwNX7oKTVulOmghH5lid0hOHpPcirOlVK4NXU9FwVV1qIoI5UilkdnjVlM4ySohn5XsbfaeBv08qtJLPL1h50NjGg8RXLsf3CV9fPVMHO0tiFl3nJVmMYQJyqpCBdj+HbYRRAlen0LOeWfH3MLyqqA5ZXc1mmxIC0fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jrn/sVVQ; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jrn/sVVQ"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-127380532eeso291930c88.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 01:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772702846; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWLXIV9DHduyzXpFH5Kj3vE9yvVKzlsA5Ql0NoqCaXkOApVOl8VQlA9E8hKOPpSoR7
         0F2Njla96Bqyv55AkDBJD992voxmk3jzskfLUymoXVz4amRqw6S80LbyWiDy40SHsyMQ
         A4eMnQHo/ZsGqsn1MYHK+pMa8uTRaZPwYP3xTBPC7YdMyQ3uMFTa/SvIa/86h9x4GpO+
         xTs1GKRy2tNQJ28qVxtZG5ViaoIfXoMrPCy//EdSgzK82x+NRQX5VPNVgEBB+ebxd0rc
         w/Qk+zmq2Zqqig8mPjTpAi1LznprpWqa7cNOZdIZMEMGUggvYf06AvirKO7fH+w/lNdF
         R4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YGl7YGr5hs1Mp3RVhxOnhpc/LsWUXqci1b3NWeyBdTs=;
        fh=R1FkMQUf04WuFe6ak358N5QeDOQE20VkQXcOBsSuILY=;
        b=UZBvEz5JM1P6V79mbWQQe1SSls2mEL7nKU8H8s2naSLGrRerM+VeGEEh5VHSaZnOhE
         AvyxlFtGyxFNTvNJ0cVC+PJ3P072Lv+j1tkeVbus/3sSubiepAZMfNrQXkWzZxdd3Ou7
         QPvKjHj1TVZmWPUCKu7SBPKui7guiuuCnDMhKGtUHkfS5y+avsa/fhx7hkLJ7Rzz9sRM
         piAMR1MpocLDPU/ayrtgYwC272bkKr/4Oxt3AEJyUfY8bH/PncZ4YbLT/cIZpsD4oWvI
         rkGpHSKVuKWdaJ4QqhJqcbahDm18oWhcXo1hqbQoMMYyHbq2n7bQw/Loh2jgWajuP3bc
         pXNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772702846; x=1773307646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGl7YGr5hs1Mp3RVhxOnhpc/LsWUXqci1b3NWeyBdTs=;
        b=Jrn/sVVQs4MieGopJwRtadojipO3mkCjMRwDvBdMDScqI08y/cITVgvrqS8rKeKyPG
         pEIBpJcvPr8HdCQ4NlX/m+W3mf06CQE5gCDQNmBItSbJbN63xuljNt7aF4dEcD4/8vD7
         8mAxVSHzqBC33HEJB5wYfYoiPerooxy0qlino5Gg2XZ7gx7+J1HJ0NiIqUQboOazaCey
         z2U6UKpJD3XFR+U0VDhgiIgqvsES04fLapbUUxPrRADMscrZzYwzGbCeJqgUv9Giriu8
         XqA0nn9/8mbDKamVjuOLH3Km6ErEZ/usAQCJljY+SeSr2JajgEdDSIi5RiyOq4BhD3Ub
         Gqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702846; x=1773307646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGl7YGr5hs1Mp3RVhxOnhpc/LsWUXqci1b3NWeyBdTs=;
        b=IUbXpqr+TaNQ9VfGTEb0fcWF6fr1H70RSb4V6w5y/FPmL+C0XlWVhygyFOmZpPeVEh
         ezeR/7aFNDvrm8Ly4Bse8k2rStS7pIPe+H61JYFExZf2Kurko9ZmmVa5akRx/8CiRO1F
         8aZntgWWVZlP8WSFmNt6tPM4YlEKIybUuGxAhgcji8hl2SBcPhiglU+P7Ao9DxRFkS/6
         /M00jMBzE51FUEcentuX2GdBh9nwYxEdD9KVRHuoj4JTSphGxC9LSIsSSM1ixvHylEpL
         nMTjOw/BjOVNjHwpcHUxO5KmWKjydpFKj8GpqTxJEYOHSRi40SpQYZOpXxCJs4VGqme7
         Ohqg==
X-Forwarded-Encrypted: i=1; AJvYcCXTf5TgxIpjNrwpAKl0BRXBuB4Js8XD2/zGJPtOY1lX6VdvIWU4bBU3emCk64Jb3vDd7oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxchZPL+DG0r3YKZeoAbdBvEunXBSumP5IMhoB6DuMGsWxNDJKv
	ckJeYXbkuxTqs5FDTfn0/BuWKIOIWznVKjekrDOFILMypMlHaXxbZQSmVeRYfZkOHZvVQvr1Yk4
	S3Py39LANjPnsTqjhKtSKo4mXc0zzcq8c5U4dmDmI
X-Gm-Gg: ATEYQzx2h2Gs/FoqJXX6v0dsUX/dxECC4ARtAbVErttzRr7Qb5k8p8VgMdEKvHjebgO
	jW97Fnb2r2C2rNoP028bMIoe56GfmO8pCOKdmImBwy/bQTXFOzzA+2tdYPkauRGnJ/7trcrWA3p
	G70CauVMgbM1mVQ+1iNmnXizIrrWQwHZIRV4pvB9JXu00KmLsZ8Pw0PTiPhKfes1UvdycQeBNIF
	2o3AMqZYLQcD/6fuBiz/ym4T+VMd4db7agsdeguamSsNQLhNBS/Li6hZM61Ioak53FlaSDRRt1Z
	ZM2F4Kae2trO/GmK3B8mvZSzKIbfYHwVsIQNeiWkOeNL7PpiKAHa9R2nSJnUVRKsQtoRk2mp
X-Received: by 2002:a05:7022:6899:b0:11b:9386:7ecd with SMTP id
 a92af1059eb24-128b70ef851mr2410546c88.42.1772702845137; Thu, 05 Mar 2026
 01:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
 <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com> <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev>
In-Reply-To: <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 01:27:13 -0800
X-Gm-Features: AaiRm51CIrbURfGzu54QGWbHrTP5af5b7cqQqQoVQE0Fnyut1UlLLTuWdt-6J08
Message-ID: <CAAVpQUBrVzwDN2xc68owHJZP7VoAZQWhwo_xdo5noGZ27qmjpA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 12:30=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> March 5, 2026 at 15:48, "Kuniyuki Iwashima" <kuniyu@google.com mailto:kun=
iyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com%3E >=
 wrote:
>
>
> >
> > On Wed, Mar 4, 2026 at 10:37 PM Jiayuan Chen <jiayuan.chen@linux.dev> w=
rote:
> >
> > >
> > > On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
> > >  [...]
> > >  </TASK>
> > >
> > >  Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> > >  Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> > >  Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb=
.GAE@google.com/
> > >  Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >  ---
> > >  v4: Fix deadlock when requeued
> > >  v2: Fix build failure when CONFIG_INET=3Dn
> > >  ---
> > >  include/net/udp.h | 9 +++++++++
> > >  net/core/skmsg.c | 29 +++++++++++++++++++++++++----
> > >  net/ipv4/udp.c | 9 +++++++++
> > >  3 files changed, 43 insertions(+), 4 deletions(-)
> > >
> > >  diff --git a/include/net/udp.h b/include/net/udp.h
> > >  index 700dbedcb15f..ae38a4da9388 100644
> > >  --- a/include/net/udp.h
> > >  +++ b/include/net/udp.h
> > >  @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net=
 *net,
> > >  struct sk_buff *skb);
> > >  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> > >  __be16 sport, __be16 dport);
> > >  +
> > >  +#ifdef CONFIG_INET
> > >  +void udp_sock_rfree(struct sk_buff *skb);
> > >  +#else
> > >  +static inline void udp_sock_rfree(struct sk_buff *skb)
> > >  +{
> > >  +}
> > >  +#endif
> > >  +
> > >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> > >
> > >  /* UDP uses skb->dev_scratch to cache as much information as possibl=
e and avoid
> > >  diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > >  index 96f43e0dbb17..dd9134a45663 100644
> > >  --- a/net/core/skmsg.c
> > >  +++ b/net/core/skmsg.c
> > >  @@ -7,6 +7,7 @@
> > >
> > >  #include <net/sock.h>
> > >  #include <net/tcp.h>
> > >  +#include <net/udp.h>
> > >  #include <net/tls.h>
> > >  #include <trace/events/sock.h>
> > >
> > >  @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock =
*psock, struct sk_buff *skb,
> > >  u32 off, u32 len, bool take_ref)
> > >  {
> > >  struct sock *sk =3D psock->sk;
> > >  + bool is_udp =3D sk_is_udp(sk);
> > >  struct sk_msg *msg;
> > >  int err =3D -EAGAIN;
> > >
> > >  @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psoc=
k *psock, struct sk_buff *skb,
> > >  if (!msg)
> > >  goto out;
> > >
> > >  - if (skb->sk !=3D sk && take_ref) {
> > >  + if (is_udp) {
> > >  + if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> > >  + goto enqueue;
> > >  +
> > >  + spin_lock_bh(&sk->sk_receive_queue.lock);
> > >  + }
> > >  +
> > >  + if (is_udp || (skb->sk !=3D sk && take_ref)) {
> > >  if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > >  - goto free;
> > >  + goto unlock;
> > >
> > >  if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > >  - goto free;
> > >  - } else {
> > >  + goto unlock;
> > >  + } else if (skb->sk =3D=3D sk || !take_ref) {
> > >  /* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> > >  * data originates from the socket's own protocol stack. No need to
> > >  * refcount sk because msg's lifetime is bound to sk via the ingress_=
msg.
> > >  @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psoc=
k *psock, struct sk_buff *skb,
> > >  * into user buffers.
> > >  */
> > >  skb_set_owner_r(skb, sk);
> > >  +
> > >  + if (is_udp) {
> > >  + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  +
> > >  + skb->destructor =3D udp_sock_rfree;
> > >  + }
> > >  +
> > >  +enqueue:
> > >  err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, =
take_ref);
> > >  if (err < 0)
> > >  goto free;
> > >  out:
> > >  return err;
> > >  +
> > >  +unlock:
> > >  + if (is_udp)
> > >  + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  free:
> > >  kfree(msg);
> > >  goto out;
> > >  diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > >  index 422c96fea249..831d26748a90 100644
> > >  --- a/net/ipv4/udp.c
> > >  +++ b/net/ipv4/udp.c
> > >  @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *s=
k, unsigned int flags,
> > >  }
> > >  EXPORT_SYMBOL(__skb_recv_udp);
> > >
> > >  +void udp_sock_rfree(struct sk_buff *skb)
> > >  +{
> > >  + struct sock *sk =3D skb->sk;
> > >  +
> > >  + spin_lock_bh(&sk->sk_receive_queue.lock);
> > >  + sock_rfree(skb);
> > >  + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  +}
> > >  +
> > >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> > >  {
> > >  struct sk_buff *skb;
> > >  --
> > >  2.53.0.371.g1d285c8824-goog
> > >
> > >  There are too many protocol-specific checks in the generic skmsg cod=
e
> > >  here. This should be abstracted out.
> > >
> > >  Also TCP also has a similar issue with sk_forward_alloc concurrency
> > >  between the backlog charge and recvmsg uncharge paths so the abstrac=
tion
> > >  is necessary.
> > >
> > >  I've put together a simple diff based on your patch for reference.
> > >  I haven't tested it thoroughly, but it at least handles TCP and UDP
> > >  separately through a callback, keeping the generic code clean.
> > >
> > I can follow up on TCP, but TCP needs another fix, which
> > cannot be factored out.
> >
> > Some wrong assumptions in your patch:
> >
> > 1) tcp_psock_ingress_charge() uses psock->ingress_lock,
> >  but it does not protect any tcp_sock fields, especially
> >  sk->sk_forwad_alloc.
> >
> > 2) TCP memory accounting happens under bh_lock_sock()
> >  _or_ lock_sock(). sendmsg()/recvmsg() works under
> >  lock_sock() and TCP fast path puts skb to backlog if
> >  lock_sock() is held by userspace. This means even
> >  a simple bh_lock_sock() in tcp_psock_ingress_charge()
> >  race with memory accounting happening under lock_sock().
> >
> > Since sk_psock_skb_ingress() is called from both GFP_KERNEL
> > and GFP_ATOMIC context, the simplest fix would be to put
> > lock_sock() in sk_psock_backlog() for TCP, which is ugly though.
> >
>
> OK, thanks.
>
> Now my only concern is keeping UDP-specific logic
> out of skmsg.c.

We already have TCP-only msg->sk logic there that
you added.  It just does not look like TCP code.

If really needed, we can do such cleanup in bpf-next
for TCP and UDP altogether (probably after another
TCP fix ?).


> We could use a function pointer so that UDP
> implements its own ingress charge in udp_bpf.c, while other
> protocols just use a default no-op or even NULL.

If TCP requires locking outside of the scope, there's
no point adding one more extra layer/complexity just
for UDP.

Even if we go that way, most likely we cannot get rid
of protocol-specific code (UDP/TCP-only hook) and
end up with the indirect call helpers, which will be
expensive than simple if logic.
