Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE43A5E97
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732550; cv=pass; b=qQUtJ8s1lj4Sz20gjz9RsdzIAs5TqFohhXWkDkYxqa1GH92oVxekJ7JVtFeZmBdhJ/p4d8V6/CsWx3LjKFsWbUJFaGXK2q0cPYXW2Me2aOzHEgqd70lE26H88jdjn2TKN+wa09aJzDE7mfJm2XZAPawFZVynP4LZibp9nlKRwdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732550; c=relaxed/simple;
	bh=i+YP140PLemK/U6Yt9E7hJTQhWz+l0nqwNgDmqAdJrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaTM2NRtZSlI6Je+5f8b/J0+GwsHSwoVg8ZuATsM3nhSTbl9f9OLSa6ntrFRm3loaZ9iv1Z4gpRsbssJRzxo+joBdIalpcIPP+XBiJrE2D8X95RujMitsCcBLc9QKbgHxP4FYbuoD3yK6D1U0NSsKJ3fo10Qym7uN+o1yMQk1EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DNLUPOn; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DNLUPOn"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1274204434bso6105040c88.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 09:42:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772732546; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAz/ZYiGI6QH8wdyEjdP+bdQbgwmYGwgGI/fe1Ub9SwB7c6NR28PCMPNFMQ3PT1oC2
         LHUSxf/6Ec0Lf7cnnggELLgWR+cfvwS7mWDTVC5suew5HEM3YEeRQrwmsMmVNuvJoRGW
         Io50aApnRD2GHyV1f7LLaiBLckZ6VfRU4SYe2EX17Fcnz3Igrv5SXJw09rwoBvkuWCAv
         I3O8BIz+DpGqhlMeKr1TPcZpyUwydUSVhRSCIisGs0gwvXiSC6qOVfMWdHNcgwCtlHUJ
         Jz95J/pAnupPW0Xc2R4V1SX/yfjik7EN5XxL4NA0GPwUmq9s9NnoIa9DjJ5ne+EX93B4
         gKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gbgz3Z6394P2QFrzwiyPE+LdMUZrXZDO0PNhBDie8BE=;
        fh=om/wXPIRZzyivn2h2mjmTRA/oTIZe4R719oUGO5W3C4=;
        b=JPuw5rMCCUZzP58xvlhoELD53IO7PA9ZQW82QImGehtvQENLXwcHbn5brMH+B5CAn1
         5KdxtVS9aXO5U+OzAhGrL0Prdzb9JYrhU2ia0Bt2zZimGjOiVJIJ2e+aKw81Q/10WYhC
         5GUF3vF8QVp+2QROFVmxeHf9HB6zHoGfm8c63UkopjRHHndet3b3UkRGQnhm4LNgTPlQ
         QcO5KCXfyrX4/c3YVZw2bQhzacpn1l3WENO6rJriBN/3qujF2j2E9pz8efwjcNrLMQTi
         +qULgCPE6vghqEeEupnHXtnHtbBnIrZ6xuJPcgbsKz+H8gABpOFMt0p+TCI+hlU65cAI
         h6TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772732546; x=1773337346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbgz3Z6394P2QFrzwiyPE+LdMUZrXZDO0PNhBDie8BE=;
        b=3DNLUPOnQKcpnhvlW8Fmu0YYv1+Jmg/x63gTbW+3d2BbMMVh6bwyUHgfMiWlo8Gmzw
         K8tPginOu5yDCQ55X36QxcBP2lWVsjxgmXhl9hWrWen6eV57sUzgQsHcVv1oHHm5jhmH
         rnr/ZAnL29Epwv6all4U1eh0qtas8s9az0sP+9UcNz3UIzJF+qFtprhy2/kYNf43N4Wq
         XNmCKRxGn9DPJSdx7hb8Vz4GXx4CAy9XI5wgssOk12DKr8fzxc0KufN+8QJdp5HM898n
         +fJuocBo9wignD6cfKitPFs6gdI/+Dme31l9el4iV0pMMrsZH+yt3fOBtFXoZ5OfEHTJ
         zDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732546; x=1773337346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gbgz3Z6394P2QFrzwiyPE+LdMUZrXZDO0PNhBDie8BE=;
        b=wYgdakWGcVSE46Y/6kFrBL2E/y+IDEk/1gfQyHgeAvZwB+U/LKVtLvytJqclBKH9N6
         P9LSZ8pFSxR44LxEqBQfRxTOuEVrkN2JeveUnSS8kX4zT6x+T+xxwUBiOP25SMgJMRcC
         3ENgbtNHatG1zLnZxDSTPGE5qItjj8RKRNAHB0/j0sm+0Rt8N/NxJY4HSUUiYL3A2Mns
         wPAa42agGEjEzIYRhx6mnuDgyKm14Ce72oVCnMUgSbi62hQm/Vs0W8JshuhptUI5LtZ2
         tsJM5GcYqyO9tlXokwStaiPAh8qF45KzK08hsflMrQK+U3MooSZGqG0eJxOGVBBN7eR0
         OcCA==
X-Forwarded-Encrypted: i=1; AJvYcCWbozCqVYyDVk73C4RE64Rq/dT6VFI9Jbh4AF9vKQ62zmYoaOOlHzL/0hcQRZr844zJAug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzjPlEx8eyC2psVQu5lygKyadneuFilkOmcYJfWKER4XRWQ8k1
	I0kuR3YZIjf7g2f5Razlu59elO9AgkPYcVM/ZhM1aefPOiazRrmx1OXJEkdZiYplH16Jxo51JmN
	/0NluCqTRjTswwS4asqGGfJ4T/CntDqlIypKchZ56
X-Gm-Gg: ATEYQzwPizsqWZGnowIxekJKav/fB/EGivW7wrm3tU7jDe+XwPYTng+SFG+mDB+/+YR
	Mma1LhlyGrMF5KDuUAJUwBDRuIOGgKFngUziEFxvgtJvfi+VfWzrvLykFrDqAqn20MveYH6Mcrn
	Ro2f8fJMYPNAPUOeO8LsLrM8jgEnPE1s7Mr1N5+DYR2lDbxg6wmiKe7s8L1X6dOSHRoNXVFsYxm
	2/0LJh+dbCuYvGVv1Q5cmh+kQUYoeNB1tfxEKNr5yIs87rR4GgoOIak8J0rVCeWUw0v74DFG9VE
	y+mSOLgklCKViJGietD3OpGCPy4gThimdWh38v2h1c8lzsPQvr1JVNxy8FyYzwlpmclwaa1F
X-Received: by 2002:a05:7022:69a9:b0:11f:1e5b:2dd6 with SMTP id
 a92af1059eb24-128bbffdc4cmr1436701c88.17.1772732544870; Thu, 05 Mar 2026
 09:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
 <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com>
 <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev> <CAAVpQUBrVzwDN2xc68owHJZP7VoAZQWhwo_xdo5noGZ27qmjpA@mail.gmail.com>
 <3e278eea8830a7b68054ae0b5a99e1bc7ae5fbf3@linux.dev> <2006d401a04274b735dc15b86e58b497fd524540@linux.dev>
In-Reply-To: <2006d401a04274b735dc15b86e58b497fd524540@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 09:42:13 -0800
X-Gm-Features: AaiRm53j4o9YVFxMkUJ4036kWVl0ll3VeHCrggTZlxe35HqDpilYX_txTOHwNAs
Message-ID: <CAAVpQUD+GiToMjWU387zgMT17emmXH_guWuebbvjPuppF5pbKw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:04=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> March 5, 2026 at 18:45, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:jia=
yuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.dev=
%3E > wrote:
>
>
> >
> > March 5, 2026 at 17:27, "Kuniyuki Iwashima" <kuniyu@google.com mailto:k=
uniyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com%3E=
 > wrote:
> >
> > >
> > > On Thu, Mar 5, 2026 at 12:30 AM Jiayuan Chen <jiayuan.chen@linux.dev>=
 wrote:
> > >
> > >
> > >  March 5, 2026 at 15:48, "Kuniyuki Iwashima" <kuniyu@google.com mailt=
o:kuniyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com=
%3E > wrote:
> > >
> > >  On Wed, Mar 4, 2026 at 10:37 PM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
> > >
> > >  >
> > >  > On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
> > >  > [...]
> > >  > </TASK>
> > >  >
> > >  > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> > >  > Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> > >  > Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00=
cb.GAE@google.com/
> > >  > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >  > ---
> > >  > v4: Fix deadlock when requeued
> > >  > v2: Fix build failure when CONFIG_INET=3Dn
> > >  > ---
> > >  > include/net/udp.h | 9 +++++++++
> > >  > net/core/skmsg.c | 29 +++++++++++++++++++++++++----
> > >  > net/ipv4/udp.c | 9 +++++++++
> > >  > 3 files changed, 43 insertions(+), 4 deletions(-)
> > >  >
> > >  > diff --git a/include/net/udp.h b/include/net/udp.h
> > >  > index 700dbedcb15f..ae38a4da9388 100644
> > >  > --- a/include/net/udp.h
> > >  > +++ b/include/net/udp.h
> > >  > @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct n=
et *net,
> > >  > struct sk_buff *skb);
> > >  > struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> > >  > __be16 sport, __be16 dport);
> > >  > +
> > >  > +#ifdef CONFIG_INET
> > >  > +void udp_sock_rfree(struct sk_buff *skb);
> > >  > +#else
> > >  > +static inline void udp_sock_rfree(struct sk_buff *skb)
> > >  > +{
> > >  > +}
> > >  > +#endif
> > >  > +
> > >  > int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> > >  >
> > >  > /* UDP uses skb->dev_scratch to cache as much information as possi=
ble and avoid
> > >  > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > >  > index 96f43e0dbb17..dd9134a45663 100644
> > >  > --- a/net/core/skmsg.c
> > >  > +++ b/net/core/skmsg.c
> > >  > @@ -7,6 +7,7 @@
> > >  >
> > >  > #include <net/sock.h>
> > >  > #include <net/tcp.h>
> > >  > +#include <net/udp.h>
> > >  > #include <net/tls.h>
> > >  > #include <trace/events/sock.h>
> > >  >
> > >  > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psoc=
k *psock, struct sk_buff *skb,
> > >  > u32 off, u32 len, bool take_ref)
> > >  > {
> > >  > struct sock *sk =3D psock->sk;
> > >  > + bool is_udp =3D sk_is_udp(sk);
> > >  > struct sk_msg *msg;
> > >  > int err =3D -EAGAIN;
> > >  >
> > >  > @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_ps=
ock *psock, struct sk_buff *skb,
> > >  > if (!msg)
> > >  > goto out;
> > >  >
> > >  > - if (skb->sk !=3D sk && take_ref) {
> > >  > + if (is_udp) {
> > >  > + if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> > >  > + goto enqueue;
> > >  > +
> > >  > + spin_lock_bh(&sk->sk_receive_queue.lock);
> > >  > + }
> > >  > +
> > >  > + if (is_udp || (skb->sk !=3D sk && take_ref)) {
> > >  > if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > >  > - goto free;
> > >  > + goto unlock;
> > >  >
> > >  > if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > >  > - goto free;
> > >  > - } else {
> > >  > + goto unlock;
> > >  > + } else if (skb->sk =3D=3D sk || !take_ref) {
> > >  > /* This is used in tcp_bpf_recvmsg_parser() to determine whether t=
he
> > >  > * data originates from the socket's own protocol stack. No need to
> > >  > * refcount sk because msg's lifetime is bound to sk via the ingres=
s_msg.
> > >  > @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_ps=
ock *psock, struct sk_buff *skb,
> > >  > * into user buffers.
> > >  > */
> > >  > skb_set_owner_r(skb, sk);
> > >  > +
> > >  > + if (is_udp) {
> > >  > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  > +
> > >  > + skb->destructor =3D udp_sock_rfree;
> > >  > + }
> > >  > +
> > >  > +enqueue:
> > >  > err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg=
, take_ref);
> > >  > if (err < 0)
> > >  > goto free;
> > >  > out:
> > >  > return err;
> > >  > +
> > >  > +unlock:
> > >  > + if (is_udp)
> > >  > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  > free:
> > >  > kfree(msg);
> > >  > goto out;
> > >  > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > >  > index 422c96fea249..831d26748a90 100644
> > >  > --- a/net/ipv4/udp.c
> > >  > +++ b/net/ipv4/udp.c
> > >  > @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock =
*sk, unsigned int flags,
> > >  > }
> > >  > EXPORT_SYMBOL(__skb_recv_udp);
> > >  >
> > >  > +void udp_sock_rfree(struct sk_buff *skb)
> > >  > +{
> > >  > + struct sock *sk =3D skb->sk;
> > >  > +
> > >  > + spin_lock_bh(&sk->sk_receive_queue.lock);
> > >  > + sock_rfree(skb);
> > >  > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  > +}
> > >  > +
> > >  > int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> > >  > {
> > >  > struct sk_buff *skb;
> > >  > --
> > >  > 2.53.0.371.g1d285c8824-goog
> > >  >
> > >  > There are too many protocol-specific checks in the generic skmsg c=
ode
> > >  > here. This should be abstracted out.
> > >  >
> > >  > Also TCP also has a similar issue with sk_forward_alloc concurrenc=
y
> > >  > between the backlog charge and recvmsg uncharge paths so the abstr=
action
> > >  > is necessary.
> > >  >
> > >  > I've put together a simple diff based on your patch for reference.
> > >  > I haven't tested it thoroughly, but it at least handles TCP and UD=
P
> > >  > separately through a callback, keeping the generic code clean.
> > >  >
> > >  I can follow up on TCP, but TCP needs another fix, which
> > >  cannot be factored out.
> > >
> > >  Some wrong assumptions in your patch:
> > >
> > >  1) tcp_psock_ingress_charge() uses psock->ingress_lock,
> > >  but it does not protect any tcp_sock fields, especially
> > >  sk->sk_forwad_alloc.
> > >
> > >  2) TCP memory accounting happens under bh_lock_sock()
> > >  _or_ lock_sock(). sendmsg()/recvmsg() works under
> > >  lock_sock() and TCP fast path puts skb to backlog if
> > >  lock_sock() is held by userspace. This means even
> > >  a simple bh_lock_sock() in tcp_psock_ingress_charge()
> > >  race with memory accounting happening under lock_sock().
> > >
> > >  Since sk_psock_skb_ingress() is called from both GFP_KERNEL
> > >  and GFP_ATOMIC context, the simplest fix would be to put
> > >  lock_sock() in sk_psock_backlog() for TCP, which is ugly though.
> > >
> > >  OK, thanks.
> > >
> > >  Now my only concern is keeping UDP-specific logic
> > >  out of skmsg.c.
> > >
> > >  We already have TCP-only msg->sk logic there that
> > >  you added. It just does not look like TCP code.
> > >
> > The msg->sk field marks ingress-self vs ingress-other, which is
> > protocol-agnostic metadata. TCP happens to consume it for seq
> > tracking, but the assignment itself has no TCP-specific check
> > (no is_tcp_sk() or similar).
> >
> > >
> > > If really needed, we can do such cleanup in bpf-next
> > >  for TCP and UDP altogether (probably after another
> > >  TCP fix ?).
> > >
> > >
> > >  We could use a function pointer so that UDP
> > >  implements its own ingress charge in udp_bpf.c, while other
> > >  protocols just use a default no-op or even NULL.
> > >
> > >  If TCP requires locking outside of the scope, there's
> > >  no point adding one more extra layer/complexity just
> > >  for UDP.
> > >
> > >  Even if we go that way, most likely we cannot get rid
> > >  of protocol-specific code (UDP/TCP-only hook) and
> > >  end up with the indirect call helpers, which will be
> > >  expensive than simple if logic.
> > >
> > An alternative would be to add such sk_psock_udp_skb_ingress() in
> > udp_bpf.c, without adding any indirection layer.
> >
> > This way we don't need to design a new abstraction before the
> > approach is settled. Just a UDP-specific ingress helper, which
> > keeps things clean enough for now, and avoid scattering is_udp
> > checks all over sk_psock_skb_ingress, just need one if (is_udp).
> >
> > Thanks.
> >
>
> After thinking a while, since the UDP-specific behaviour only appears
> in the redirect-to-self path,

Are you saying psock->sk =3D=3D skb->sk is always true and
skb_set_owner_r() in the else case is not called for UDP ?
