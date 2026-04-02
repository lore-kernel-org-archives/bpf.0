Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970F26E711
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150649; cv=pass; b=UEuOlDUXWJMna7epyJptX9734UrC/oqQYEh1/04S/XcsRi5XI2RYic7bAF4j/dcN0oBlG3orleLcX7EE0qSGggj9bOADkDmviDill2mPJZV0494a72i14x1cRdQArhzKlNSr8SJmlq3MeDbCieZK+I6tYrFtgnWGICnDyGIJWyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150649; c=relaxed/simple;
	bh=GmTOz63CjjNnwPvUynaJmyNfPQyf9rdnijnUUmNurQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4Q/7GCx5pP0JqQnXfdp9fzD92A1o5cEu9BK1OKXdR4GS2ba6dk0tN1mmZvU4046UVFK9RlfLnIAj56oEL7UKCF/EjnxhodmWyWTBJOC02kyEWhpCHeNSYJoWX8k/Pnmu9HyiEz91qZV80YmTZmCdtpdFy7bmTKkx0oTNiVYBAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVETSoxY; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVETSoxY"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso1494874c88.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 10:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775150647; cv=none;
        d=google.com; s=arc-20240605;
        b=kUqqES7r9a5ZCZpdjExAynQCyB2xQCF4iUtjLMRvc5fQNns/2HckKOrGHMyTdwAjHV
         gudGGnRKUNIGPgpkidIjGuWhiLfeeYz8wd0C5RYjXbYuW0262us3j6SKNvRXajfXmidY
         vCRY30HGjuRG/Z6Kri6p1yiYaXxrrSJP/8eHhebpCI2BFXEOS7OwY7lwVbNBdIyJ3P4R
         i583F0TIvNJXsmJYP9q0tR/0LQOL1xVIRSoI++OCgSvdCtIKL1uiQkPruHHHm0g42e1i
         A9B6H+gcXgEjk/1NE5LJ3zFAe5XGh8Tid3vSBHZ4vJvEz3MdQYQZdigvQQoldRj2mwRh
         zV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGdK9uBWaQFJrzrBAhj31vEGGDLY8Xcv6XnPO/Im1ko=;
        fh=ljZlXD7elBj8yHWdUpZCaAiRy2E3zAlGu79jyZvnNzI=;
        b=WT8US31LW2UkJnawIGDEyTW77gDrEBbPm7nhhsGyLRLNxD4oSomDXdY+8bp5ShZM3o
         TxqZ+9aA907/IeEk6kxw7Nl57G/mNEULMUAgCte0/Z46z7eScPK7Pa7EQFAGW8NH9Hhi
         AJgBamXqjPa54umyf8ZJRZgHvx6wFQtFc/xNKIKfcSGd9SqXuILi+/q8BmNPSKiEvalE
         fDDEmIUy80NbcHsVuMUbkAjVYohetChoqsJKT2i5maUOQq6m6c289il/P9xyeX25WrjA
         UxBNvnOWoHLh98A7uZc8t2z2L5UVUh6+/nS0JAPjVmP/LySfjloPIHjtzvd3ilI6sCZS
         GDaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775150647; x=1775755447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGdK9uBWaQFJrzrBAhj31vEGGDLY8Xcv6XnPO/Im1ko=;
        b=KVETSoxYryiYMWBfd2JS0DG0XZG4vEf3Fdtz3cQtdhn99eujidRsSm3TtN47r02826
         Sf2hgYSY6stx0UzMQHKBHb7DeQ+UQO+0Xz+fZKP5j819LxptRcLynBKC4weDVMSzlUuA
         59VV22NrTwBKxiiyfzhBUt7vD5vIRrHtQWdL4O31inQNiBwpLU8mwQOjhfdcmFKo+EQb
         PtRcBXOaTNe/hgn6o1xwZaQs+dkUVw5EyCU00pXaVCcJsqCM7k5RjM/k6RB5yiuqu2bQ
         lNhbswkXPbGhB/kEyEVOLlPD/uwV2NW6u9PYSO+2ZzIGfSTc4+ce7fdR8RVxCgADoi/k
         +8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150647; x=1775755447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGdK9uBWaQFJrzrBAhj31vEGGDLY8Xcv6XnPO/Im1ko=;
        b=VkQYV4QKC6QQ/4fgIrX8CiU24DTTncapDQz0glJQRYBazei5WMmWggPrq8N4q5lCQw
         i0qVTznTSqBPOGX969UKcxMLcha/s+YDij15hjgCNcmMWNl/Xb0rCe2WBBN3Z7w/CUOC
         9FWx+jNKh7aOZz1+E39SZGPP6kCx2ROL5POfmENPayS3mwrHMgaQ6Gglt3MrNm3LMtui
         JJ5wn6JUh3g5A3n691dVQSVd0gHl8dZ2Gg163grFoY7lHVS5mX8yHtD1qamEWSNlz2ks
         rmiFS0QyxPPnOdGfRf+MrRoHePqzZJMMs1pbZTsmy+nwUTUSPHru0HkNGBrw9j66MIRJ
         atqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs8BRrxzFrGRuOkOBqPRyYWw6QECbhGvQtk+FWfK2QKufnrKAAopcTsmncKupuoAi8M+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEcWybctrHN7FaJm1o9ivxbEf9k78L/aczaAUIZYjDQ/T6cVE
	ZkxKpllXDR37Uo5TmVNepNInFhEIQMrKrTbC1IQ3woPvOwVCcViazmF5eEneVgtYcmvzNRVguWJ
	BIOyQxbhsIZHuzFe8Z5ayCgr1qTvIQN3xmjKoCByd
X-Gm-Gg: ATEYQzxLd3AAWU50Jlf2bBZ57In2RPS6EWcHm22FjcanT7TniAo44sOeB9YLgVOgE9U
	m+hGHipQvtQZHCucwUKoUklZDsbl4HxDpTNcgotdOJ8eS4e/GtyPD8LSStj+KsJK6crI9qgs1zo
	Y62nZ+mSVlQ/9w/DhBnX3lQ0WgWh66EdP2PxAuEWW8vSpLSFuuN49wgsODS9Pj60UKkingvhgxG
	IO7lLL7/uGDYhauVgXQEtX05yHGDZA+41ieJ93xa0fj8CwBrFsMcN3rO9Wf/WVLnmiRuDVbh1sb
	I7ynYvrrYPuIKLmMVHGWhXYITGkk9mPYLUkfUGeteTc/UIiejtq3umyDQzozRGtawlXY5Q==
X-Received: by 2002:a05:701a:c94f:b0:123:3488:899f with SMTP id
 a92af1059eb24-12be6519c10mr4248175c88.32.1775150646649; Thu, 02 Apr 2026
 10:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402050928.32946-1-kartikey406@gmail.com> <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
In-Reply-To: <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Apr 2026 10:23:54 -0700
X-Gm-Features: AQROBzCGH_diGpPlCLn8lJeTbdIZpGJLDfsG4ZjERFe3Vm2HfWlunO9yF1a-KKQ
Message-ID: <CAAVpQUCj2O8zPHPNwU3qkcLqz_iSmowEgxOFX2JAM5JNBqG7gg@mail.gmail.com>
Subject: Re: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, john.fastabend@gmail.com, jakub@cloudflare.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, cong.wang@bytedance.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:03=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 4/2/26 1:09 PM, Deepanshu Kartikey wrote:
> > udp_bpf_recvmsg() calls sk_msg_recvmsg() without holding lock_sock(),
> > unlike tcp_bpf_recvmsg() which properly acquires lock_sock() before
> > calling __sk_msg_recvmsg(). This allows concurrent tasks to race inside
> > sk_msg_recvmsg() on the same psock ingress queue, where one task can
> > free msg_rx via kfree_sk_msg() while another task is still reading it
> > via sk_msg_elem(), causing a slab-use-after-free.
> >
> > Fix this by adding lock_sock()/release_sock() around the sk_msg_recvmsg=
()
> > path in udp_bpf_recvmsg(), consistent with tcp_bpf_recvmsg(). Also make
> > udp_msg_wait_data() release lock_sock() before sleeping and reacquire i=
t
> > after waking, so it can be called with the socket lock held, consistent
> > with how tcp_msg_wait_data() uses sk_wait_event() which does the same
> > internally.
> >
> > Note: syzbot testing shows a separate pre-existing warning:
> >    sk->sk_forward_alloc
> >    WARNING: net/ipv4/af_inet.c:162 inet_sock_destruct
> > This warning triggers from the idle CPU path (pv_native_safe_halt)
> > and is unrelated to this patch. It appears to be a pre-existing
> > memory accounting issue in the UDP sockmap path that requires
> > separate investigation.
> >
> >
> > Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D431f9a9e3f5227fbb904
> > Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >   net/ipv4/udp_bpf.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index 9f33b07b1481..f924b255cee6 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct =
sk_psock *psock,
> >       sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> >       ret =3D udp_msg_has_data(sk, psock);
> >       if (!ret) {
> > +             release_sock(sk);
> >               wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> > +             lock_sock(sk);
> >               ret =3D udp_msg_has_data(sk, psock);
> >       }
> >       sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> >               goto out;
> >       }
> >
> > +     lock_sock(sk);
> >   msg_bytes_ready:
> >       copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
> >       if (!copied) {
> > @@ -90,12 +93,14 @@ static int udp_bpf_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> >               if (data) {
> >                       if (psock_has_data(psock))
> >                               goto msg_bytes_ready;
> > +                     release_sock(sk);
> >                       ret =3D sk_udp_recvmsg(sk, msg, len, flags);
> >                       goto out;
> >               }
> >               copied =3D -EAGAIN;
> >       }
> >       ret =3D copied;
> > +     release_sock(sk);
> >   out:
> >       sk_psock_put(sk, psock);
> >       return ret;
>
> Kuniyuki  is already working on this. Please see the
> existing discussion.
>
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

Oh I almost forgot about this.. will respin shortly. Thanks.
