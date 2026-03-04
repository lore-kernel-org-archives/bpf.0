Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE937266A
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655307; cv=pass; b=sD2rRWQWVd9mP21GetanTLph9SZ8gKOGciq1Cn279uRxYyf6Jtz6U20JiKbibGxqHAbCyuDs99t8z/F7RAigT2i8wZXJzaDz/giB05wveZn8PfUNtLdlUvb5YMbw4QQTD6QHjO8gWl21ghZLNHu5V85cgDamQAZF3pxfhth801A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655307; c=relaxed/simple;
	bh=abSi4JD2ktlQGTbjB7Yv2uvKpNn8VDJZ/Pv4m6j917E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgVQgLTt8Do/1MdYSm9dK7+rpCMLbZCK6zktEY1NCAZfjB92aPj7AQvWufB7qXsGsavVXdLkivSC+cjebYNFWwTaFQk8jGaJK1aMIA2shtniQ1teMS5EMe3GTk1XZ/PeISwJa6shAwGiLdKDBxs/cme1D8ojTGiv8yjgV0cZ/PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcY0NlQs; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcY0NlQs"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660b497adaaso3132633a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 12:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772655303; cv=none;
        d=google.com; s=arc-20240605;
        b=cZ8AcskoHsQJlMJy0AgGBbVjChzmBJjFt55ZVxv2SEBpyrRK+L2v5vHDWEb7Ydoajc
         TFCDsqZLfRYTU/hvttSuqntgWL8BIFAD3U30b/hf4kfWv+RAA4wBjBgja0cbavwykAQg
         aM9zEN4QYGjz5PXBGsY7f07I73QIg3h14AK9/OMpMZ1G2ksQfGjYNEd+y+k5QYHerbnz
         CAsAMNQyyVyx//oXt/igamvrBMH1MqJJgX8CK7iGVvLccU5WxRp3PAz7XBKF2BW9vvx7
         35vabAhh3Ix+K3b74bLhGeFGMZhLpGXXt3i2LzlT9kH6c4Lp9Dc5DrCqIcvz01gTj7Ur
         PU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+GfNQFz0qALmfPoIx3Yqf69fSM+V1guhjH9flo/Vo5g=;
        fh=dU5h0tBUPpWl0I7iV3++UpKN9w7YJTsdco5IyOsvCCE=;
        b=jQTbzIKqeSmC1OneOhIpMOBR9l1XUP2LSL0qIKt8/QTfvaPIF9zqyWgbo72Df+tcyk
         UUmqa/Q8EmISNOgko2oTUNVXWoNk+LWjcobMamC3Blky6/zCntYHbJMpDCDZw9GH0kJS
         o1DoPO/c5zJ+BDSU5C5M5d7tAzVHcaHyuWqItukYFfFohRG+fk/T2QkWQljEzbubRHv0
         RdEMwTuTOpWgLgshhlEBVBbQtjQ4TuXvO43BsjiAZ748Zbh9Mz7JCQhMsxz9J4D3RcIX
         c9SDpTP1u+RKiAoO5fLN5vZyyJgNc0rUMYoLdMvigXrPcVOcfbmfiDtDKTb82LxBTVUh
         hXbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772655303; x=1773260103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GfNQFz0qALmfPoIx3Yqf69fSM+V1guhjH9flo/Vo5g=;
        b=qcY0NlQs2xUZVL8y73qJzPI/Ag569wTBnEw0iXx5sfcCVTpnVf03H1L55PHwuTGKUU
         w5A5mQvVh4yoF9L4imchZK3vTxRanXNiWwkeUxpxv3f1lqo+0cjZAOfjSVVvIVrVhNmE
         szaFUbEwmEkqQwr3MlH6bfaVgzLGdpnbbPnRO4wGkQuNQqgxlX3y4yt99A/zNAkBuPb8
         Hus8qEmH4pidXdl9JnIw1OsrDGLnYTWVLFhpPiuJ3Ko5K3QrZzpVxggDWG33EyF7EnSe
         nTOJPf2jFOvPOi1Gb8kAwZ2PGKS95t3PTGZIBbtkweeJj/bIkChTRTZ4XUfbqMBi0sIf
         1Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655303; x=1773260103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GfNQFz0qALmfPoIx3Yqf69fSM+V1guhjH9flo/Vo5g=;
        b=G37Fl0T9aynNVg657fAo+4JamGCxP6v/PIzvY9ixJu7ahB14Y9+6+flGp+alIJC3rX
         8LsNTGLXhBqnVcwcB3P/jsOrx8cbq3Ym6ZDz7c6ynKaFiaWV02Z7SCXQBStEpKskrdJB
         bfx9QFKzVCuIkw9r0ZK1CpK2aOuFpYH4o0DfJ0fkfLMVXvfVBO8wiMCyCTFFgBk/Fwtx
         KUofo9saLuqCHwIGPng/4tbHx6rhuh+D7S7nd1gJurMiPW6hUZcd35ICxd0/HgCSV1Lm
         R7rhXYcFP0pLelFJEVx8Sywxd0CyHTr6yWJcdbXM34rs+X8AV/K6rC8hvFOkjeRO1PZn
         nFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWheD9+4LcxK3ZK1qCTPC8f0pvtn+4210fT+j/PB/CgHhQUPlrjT1OIfrFEMMy8u7cjToQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVl1m+JuBOR32kXqBpO8PkCzsxXh/z1YMVyQKD0YY3NoCc4ZCU
	aY57KG0x5yPsPPOFFcWKdFMOceHFo3ATBJPS0WeSMzqEvVr553l49i7T7/aNlHzYWDHjU0PZdCG
	hhV2pQLXy1mLjTrQwC9RDkB3d6Rx+a50/igHoy1/j
X-Gm-Gg: ATEYQzwTzcvZsBdE5o8xdeou9N9Zf+QXP8PIOqe+ESXq6vPoOqwyBCTkOhfdfDDz7iK
	yOdRienQtNsf6rytLmGMcg8FFt3W7N24pEr+wWgAD8x9vw7NElYmf2YOV1ZTBT3P5UI4HGKySjv
	XTZtCaLMrbyFiB4/nwfkOklGy3Z6ViV0PbDJrHTUZ6ktE+7IYArV1yguJFb9fsUBRnFqa+BycLg
	hWHyN4f61w3mQGryQ0GuRyek9bGhfsqjY/fbECzxpAYIRbFth0Rbt3OgLH2XokgJR+bXLXiKwjw
	9CculW7RYmwSj57Smy31qw/dMeOBBUKCGidKyEI6Ps3tGB60QQBL//CBaqpo1fpeIUutzg==
X-Received: by 2002:a05:6402:321d:b0:660:f98d:2288 with SMTP id
 4fb4d7f45d1cf-660f98d255cmr1816058a12.25.1772655303070; Wed, 04 Mar 2026
 12:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <88077a77-8b9e-4372-bb39-c7a638cfa3d4@linux.dev>
In-Reply-To: <88077a77-8b9e-4372-bb39-c7a638cfa3d4@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 12:14:48 -0800
X-Gm-Features: AaiRm52T_t6qSTYYdmTx7ZNa4wzm14NqAvvBrpkSAcnYn9Ejazc9osTiZW3oT4o
Message-ID: <CAAVpQUAzGyf03WTEWrphDZMSxjrN6=WOeXmu-HTGWg+c9smvFw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:04=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/21/26 3:30 PM, Kuniyuki Iwashima wrote:
> > syzbot reported imbalanced sk->sk_forward_alloc [0] and
> > demonstrated that UDP memory accounting by SOCKMAP is broken.
> >
> > The repro put a UDP sk into SOCKMAP and redirected skb to itself,
> > where skb->truesize was 4240.
> >
> > First, udp_rmem_schedule() set sk->sk_forward_alloc to 8192
> > (2 * PAGE_SIZE), and skb->truesize was charged:
> >
> >    sk->sk_forward_alloc =3D 0 + 8192 - 4240;  // =3D> 3952
> >
> > Then, udp_read_skb() dequeued the skb by skb_recv_udp(), which finally
> > calls udp_rmem_release() and _partially_ reclaims sk->sk_forward_alloc
> > because skb->truesize was larger than PAGE_SIZE:
> >
> >    sk->sk_forward_alloc +=3D 4240;  // =3D> 8192 (PAGE_SIZE is reclaima=
ble)
> >    sk->sk_forward_alloc -=3D 4096;  // =3D> 4096
> >
> > Later, sk_psock_skb_ingress_self() called skb_set_owner_r() to
> > charge the skb again, triggering an sk->sk_forward_alloc underflow:
> >
> >    sk->sk_forward_alloc -=3D 4240   // =3D> -144
> >
> > Another problem is that UDP memory accounting is not performed
> > under spin_lock_bh(&sk->sk_receive_queue.lock).
> >
> > skb_set_owner_r() and sock_rfree() are called locklessly and
> > corrupt sk->sk_forward_alloc, leading to the splat.
> >
> > Let's not skip memory accounting for UDP and ensure the proper
> > lock is held.
> >
> > Note that UDP does not need msg->sk assignment, which is for TCP.
> >
> > [0]:
> > WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x62d/0x740 net/i=
pv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMP=
T(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/13/2026
> > RIP: 0010:inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157
> > Code: 0f 0b 90 e9 58 fe ff ff e8 40 55 b3 f7 90 0f 0b 90 e9 8b fe ff ff=
 e8 32 55 b3 f7 90 0f 0b 90 e9 b1 fe ff ff e8 24 55 b3 f7 90 <0f> 0b 90 e9 =
d7 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fc
> > RSP: 0018:ffffc90000147a48 EFLAGS: 00010246
> > RAX: ffffffff8a1121dc RBX: dffffc0000000000 RCX: ffff88801d2c3d00
> > RDX: 0000000000000100 RSI: 0000000000000f70 RDI: 0000000000000000
> > RBP: 0000000000000f70 R08: ffff888030ce1327 R09: 1ffff1100619c264
> > R10: dffffc0000000000 R11: ffffed100619c265 R12: ffff888030ce1080
> > R13: dffffc0000000000 R14: ffff888030ce130c R15: ffffffff8fa87e00
> > FS:  0000000000000000(0000) GS:ffff8881256f8000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000000700 CR3: 000000007200c000 CR4: 00000000003526f0
> > Call Trace:
> >   <TASK>
> >   __sk_destruct+0x85/0x880 net/core/sock.c:2350
> >   rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> >   rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
> >   handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
> >   run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
> >   smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
> >   kthread+0x726/0x8b0 kernel/kthread.c:463
> >   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >   </TASK>
> >
> > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
>
> Cc: Cong Wang, who is the author of the quoted commit and also the
> author of the full UDP support in sockmap.
>
> JakubS and JohnF who are the maintainers of sockmap and skmsg. Please
> take a look also.
>
> Jiayuan Chen, you had submitted patches(/fixes) for sockmap/skmsg. It is
> a good chance to gain review credit.
>
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 96f43e0dbb17..dd9134a45663 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -7,6 +7,7 @@
> >
> >   #include <net/sock.h>
> >   #include <net/tcp.h>
> > +#include <net/udp.h>
> >   #include <net/tls.h>
> >   #include <trace/events/sock.h>
> >
> > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
> >                               u32 off, u32 len, bool take_ref)
> >   {
> >       struct sock *sk =3D psock->sk;
> > +     bool is_udp =3D sk_is_udp(sk);
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> > @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >       if (!msg)
> >               goto out;
> >
> > -     if (skb->sk !=3D sk && take_ref) {
> > +     if (is_udp) {
> > +             if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
>
> A quick question. This case happens when the earlier
> sk_psock_skb_ingress_enqueue() failed?

Yes, the skb is charged by skb_set_owner_r() and the lock
is released, so I left skb->destructor as is and avoid extra
locking when sk_psock_skb_ingress_enqueue() fails.

>
> > +                     goto enqueue;
> > +
> > +             spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     }
> > +
> > +     if (is_udp || (skb->sk !=3D sk && take_ref)) {
> >               if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > -                     goto free;
> > +                     goto unlock;
> >
> >               if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > -                     goto free;
> > -     } else {
> > +                     goto unlock;
> > +     } else if (skb->sk =3D=3D sk || !take_ref) {
> >               /* This is used in tcp_bpf_recvmsg_parser() to determine =
whether the
> >                * data originates from the socket's own protocol stack. =
No need to
> >                * refcount sk because msg's lifetime is bound to sk via =
the ingress_msg.
> > @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >        * into user buffers.
> >        */
> >       skb_set_owner_r(skb, sk);
> > +
> > +     if (is_udp) {
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +
> > +             skb->destructor =3D udp_sock_rfree;
> > +     }
> > +
> > +enqueue:
> >       err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >       if (err < 0)
> >               goto free;
> >   out:
> >       return err;
> > +
> > +unlock:
> > +     if (is_udp)
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> >   free:
> >       kfree(msg);
> >       goto out;
