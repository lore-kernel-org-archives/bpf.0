Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795424655;
	b=KKC9eBOC8nLIkYvrNg59OnkcWQg87jUMjRhWLlvL/CnKiDORlIugOid6bw5tH3HJ55NC
	 czXNFRIBnr3rylfXrAm5TD0+RAAaznteLrhyGdJ9TIF32bsK6qDyi293CZYeXkfXNq51r
	 9MtT8gqdFJD5bRAmHPdjC+gqxSSMoltV80f1ZgsLnUvpAZBAbb8EYJBmyv3fA5iYA2sp/
	 Y9OdCM2Y0PO/JWWec5dGDhyGj9b4/luFOL3OPytlZEUWazt+cpEfLs54lBTBuP9LMWpj0
	 cyvZ987VOHB8BTyQKnmAjYuGwsbwh/sO7BOgQdTyz/wVzq7vqIojClTFaDCUPUFM4YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Iahu//YmpmZyg0DhyYrw87fZlA1aEgZxAw+wZWOdpsM=;
	b=4nVE4y4+eK+FT5lMVNhP2BauuvxwxHySmBKLPn7ARhderSND3dy90pFkC2j3gMZJHT7x
	 pJpYnRvuUZtDd1mM0guSzlfO+oFF01GQGS1xWyjim6JRCrPMp5G2Fncg7iwOq8tGqvrDL
	 7B4TNj4EpH/E/QlTxwEH29/bTFkMzSViop2hHV8js7NhAEn4PweJJueEHh8z99mNNnPH3
	 sfTNshm6ClXwyqNH32etbtOmg5SF2g38Ag7iENCKJAhPHeNxtT3l8IAM3oLROakDQyySc
	 fj6YX4GPkUFvdHWxRsEj5Ja/KmrMtE19NXNX0OPawMcMskzmQo1x5GfEXAQMARpQmwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzh59vly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2C606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzh59vly
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so18647785e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795424654; cv=none;
        d=google.com; s=arc-20260327;
        b=B0INK+g/NCg9gaG61lNdH49kIQJiLD895VCgsTq0Fz6JaxW6Ec1d1XWoPxVuPJWbxJ
         zmJ2dlC1VEhmBHj4xNsQveMErrFNyckE/vOom2Pz3NL6GhnlIvu9HkGI8wbnOcGco5s8
         y0KmbmF38PS3iEAOobJtgjc9CauJ3QTfSoGC5dHEp2lmYKN4T8+pAwlRpu65CY0lOhbC
         ZI7GZL6HUx/WGrN9OMkicoVy6E2H6QjxdYQf7jjpQmaUAbkUZ1/lBhFZHPrbDSERDWAa
         omKIpaCwVQa694fMUXgN/obyzwoVSgLPRzaM8rhIWxd0Rngb3BL9QfSztMOljy6ADA/f
         8tTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iahu//YmpmZyg0DhyYrw87fZlA1aEgZxAw+wZWOdpsM=;
        fh=TLOpDXMqwa3fLkzLt7tudP3SPqPJ+FiHWVJW9OPrMes=;
        b=gVO7GxNhTL9n5JmgV9KGe/Ko6COn1TxfxTiliYTXhScvQziEnNwW/0ltG7q0tCHf2m
         yjE8hIPx14IhYmMzpd5P65Gl23B/HuD3UUUa9rUKLOa/Gse71+kZrjusIxspuVWdjo5s
         m0FY9iFEh4WvZNjpV84z8zgaMmfIGmTdoDtDP3/8f+dfZxwNOhprqQdjFDNeudrMzAYk
         NlCI52cuizUzd+S/2NN9tQPFMHPO69Ixj8x0jbcOFXwccCQnZqY5cJy5eW/9DuU+cSWG
         WonFtPRaaf3RmRmgd+qyDwvRRjdJNzVLV0sTU0UvYaj8Vs2+haeJS8nsXsvrcmY03xuL
         27zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795424654; x=1796029454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iahu//YmpmZyg0DhyYrw87fZlA1aEgZxAw+wZWOdpsM=;
        b=Xzh59vlyxu25A0YX5r65mvsWDOc7XnpsInyTaQSA322zS/gqRwLLodre9BTAwe61up
         9TLw4fgjPWEgu24JYmDKvdu0t2qSd01actNwTe587I9D2Ev+sOBJ5l0LdhzYaVlwNaJT
         /T07I+HG006abWBnJfK9TtfN3nhs+oEbysVTpFNh0ICl1H3KUyB108N9dJZp8e4H7AzY
         +tQ0MfhWJBPVkoCB36+0w4FVAXHd/RccLsn51AClZK8EW2IKiz9wLQ/D5kEdPX969m7u
         T5o/AHlvDK4/CB802NxBBKkFVC0JiIrcX7+XJgRrr68xWLqpxyKCoEqlX9d3OZ0S+4mW
         oQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424654; x=1796029454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iahu//YmpmZyg0DhyYrw87fZlA1aEgZxAw+wZWOdpsM=;
        b=LKhbOyt3vibZtfUm8raHYvPzKIswU2Nz48eYmXvPZ2cmY7CHAYFU4rpEj1KMieQ0f+
         I+pgOELMOpSWqSIGHAzf+2NwypdtgnwmvkjZKdbNTsV07zpaDL9Zd6Yqjo8FyIiici9Y
         i3zdElrznBMLUWc3Jij+czg5ucTzPnuWM4gOJg3TvS6QL/63dO9zXBS6XNTd2CcdZPj3
         9ScGZY9CrB4Ai8M0SLSmur8WFy7uY0HzxcIV8AF1dXJAitOsFuBGefcoWAp6xbuJHue2
         8ukONSqh6y6MWi44Q/kM/2GuXgm0OGNfuWJlPzXOI27m11EVZYlQWJuAMzIdGIMob/0M
         T/NQ==
X-Forwarded-Encrypted: i=1; AL+hErERG6LIIL/6wjAybQVkYQ7gOjeMTnYCEbQwG+Nlc//yDxKIPbH0zyybdMxvtkbuXyN/GMo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lYuXf/zXEKxHs193+NaYz++NKHAJhcYP7X6yyeQCkDTfTleB4
	6+RtWFMjyMJSpI2V/rz28r3F7bmP1wMFClRgFBBDvtKWDEzilqJFzNYQM4wap2Kv+M4i3cpC8kq
	eHOiJNvXp2Y+V6ZveZZ4khtnchRCDTsk=
X-Gm-Gg: AZFdTZdY88MklLZnyf/yQBqX11vqrt6WcRGrpZMU98vWub8ZnYFaT/wozT68ZaTDiy0
	ZTVrnIsmar1dMM5JpT03nKcXAP3LDRUKR7yciswtsgjcPVVBXCecvioXEZ6akM4a73I4z+F8yL9
	cU3Dk8/9c0gFzcbAnHaoNf10YL2PEHvc8h9jjvsBAzJu/iBbeZ8p4k3gMvIcI81/YIU4rt7bH9B
	dB39FrBe5AQf5qPZAL3kiMDLT/QeHw0iPRwO4y1GgAKb3+WLT7QryNC320lVg/FLc/TNaRP4zFX
	KVCwiKb5fapFCC32Ygi6WBta2jVMffpWzLP3pl6H2vq83JKeP5aU7DNv0rKBZY5A+HcLOQRk9dx
	5RV2qQQv5sk9r3zcQEzirE/YdFuVVEp8QxMTPeE+FEraTgTxz09TL2JdT8A4WVnvvN3NAVToHtP
	ND6ed1BX4FQ3P1yuUhABQ0GxCUS1oXnX1oufS/kJocTXzQay6XG0yD
X-Received: by 2002:a05:600c:2319:b0:4bb:752e:991c with SMTP id
 5b1f17b1804b1-4bb86160370mr174614835e9.15.1795424653574; Mon, 23 Nov 2026
 01:04:13 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
 <179542364209.3135.6346728453187808939@kernel.org> <CA+X8Sdi2zLn8ZUOWXQww1DOFkOqkPWFwrF9t5LnHxn==3s+8ZQ@mail.gmail.com>
In-Reply-To: <CA+X8Sdi2zLn8ZUOWXQww1DOFkOqkPWFwrF9t5LnHxn==3s+8ZQ@mail.gmail.com>
From: Wong Steve <shyckless@gmail.com>
Date: Mon, 23 Nov 2026 17:04:02 +0800
X-Gm-Features: Aa3M54q0kY5NXfFKpwRMPNQElPAV1wS6zgYhFbHOo44WAbFtAZw8Id81pwRjkew
Message-ID: <CA+X8Sdhn8u=QFkuFOzTQf-rdCRLLd_uBsQ83pJNb4jWsKuFriA@mail.gmail.com>
Subject: Re: [PATCH net] net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF
To: netdev-bot+sashiko@kernel.org
Cc: pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, kuniyu@google.com, willemb@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev, 
	linux-kernel@vger.kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [Severity: Critical]
> This problem wasn't introduced by this patch, but can reuseport_attach_pr=
og()
> right above hit a NULL pointer dereference on reuse->prog [1]?

I don't think this can happen. setsockopt() holds the socket lock for
the whole SO_ATTACH_REUSEPORT_* call, and a listener can only move to
the closed section through shutdown(), connect(AF_UNSPEC) or close() on
that same socket, which all take the socket lock first. So the socket
cannot be shut down and evicted by reuseport_grow() between the check
and the reuseport_lock. I also tried it with a delay added between the
two: shutdown() waits for the attach to finish.

Thanks,
Suyuan

Wong Steve <shyckless@gmail.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=80 17:01=E5=86=99=E9=81=93=EF=BC=9A
>
> > - [Medium] The fix only covers the setsockopt(SO_DETACH_REUSEPORT_BPF)
> >   path.
>
> Thanks for the review. Right, the patch only covers the setsockopt
> path, and that is on purpose. The disconnect and re-listen case is
> different: the socket leaves its group, and when it was the only member
> the group itself is freed, together with the program that belongs to
> it. The program is not removed from a group that keeps running. Making
> that path honour SO_LOCK_FILTER would mean keeping the group alive
> across a disconnect, which is a larger change than this one.
>
> If you prefer, I can send a v2 that says in the commit message that
> only SO_DETACH_REUSEPORT_BPF is covered.
>
> Thanks,
> Suyuan
>
> <netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=80 16:47=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The fix only covers the setsockopt(SO_DETACH_REUSEPORT_BPF)
> >   path.
> >
> > --
> >
> > net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF
> >
> > This commit makes reuseport_detach_prog() return -EPERM when
> > SOCK_FILTER_LOCKED is set. Without it, an unprivileged process that is
> > handed a locked socket can remove the reuseport program with
> > SO_DETACH_REUSEPORT_BPF. This matches what sk_detach_filter() already
> > does.
> >
> > > diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> > > index b9e5648fa4c51..cdff61161a70a 100644
> > > --- a/net/core/sock_reuseport.c
> > > +++ b/net/core/sock_reuseport.c
> > > @@ -727,6 +727,9 @@ int reuseport_detach_prog(struct sock *sk)
> > >       struct sock_reuseport *reuse;
> > >       struct bpf_prog *old_prog;
> > >
> > > +     if (sock_flag(sk, SOCK_FILTER_LOCKED))
> > > +             return -EPERM;
> > > +
> >
> > [Severity: Medium]
> > This closes the setsockopt(SO_DETACH_REUSEPORT_BPF) path. Can the holde=
r
> > of a locked TCP SO_REUSEPORT listener still drop the program by
> > disconnecting the listener and then calling listen() again?
> >
> > connect(fd, AF_UNSPEC) or shutdown(fd, SHUT_RD) on a listener goes
> > through this chain, and none of these functions check SOCK_FILTER_LOCKE=
D:
> >
> > tcp_disconnect()
> >   tcp_set_state(sk, TCP_CLOSE)
> >     sk->sk_prot->unhash(sk)
> >       inet_unhash()
> >         reuseport_stop_listen_sock()
> >           reuseport_detach_sock()
> >
> > With net.ipv4.tcp_migrate_req at its default of 0, and a program that i=
s
> > not BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, reuseport_stop_listen_sock()
> > reaches the immediate detach:
> >
> > net/core/sock_reuseport.c:reuseport_stop_listen_sock() {
> >     ...
> >         /* Not capable to do migration, detach immediately */
> >         reuseport_detach_sock(sk);
> >     ...
> > }
> >
> > reuseport_detach_sock() clears sk->sk_reuseport_cb. If this socket was
> > the only member, it also frees the group:
> >
> >         if (reuse->num_socks + reuse->num_closed_socks =3D=3D 0)
> >                 call_rcu(&reuse->rcu, reuseport_free_rcu);
> >
> > reuseport_free_rcu() then releases the locked program:
> >
> >         sk_reuseport_prog_free(rcu_dereference_protected(reuse->prog, 1=
));
> >
> > tcp_set_state() keeps the port bound when SOCK_BINDPORT_LOCK is set, so
> > listen() can be called again on the same port:
> >
> >                 sk->sk_prot->unhash(sk);
> >                 if (inet_csk(sk)->icsk_bind_hash &&
> >                     !(sk->sk_userlocks & SOCK_BINDPORT_LOCK))
> >                         inet_put_port(sk);
> >
> > On the second listen(), inet_reuseport_add_sock() finds no sibling and
> > calls reuseport_alloc(). Because sk_reuseport_cb is now NULL, this
> > creates a new group with prog =3D=3D NULL. The socket keeps listening o=
n
> > the same port, but the program is gone.
> >
> > Documentation/networking/filter.rst says that once SO_LOCK_FILTER is
> > set, "a filter cannot be removed or changed" and that the filter "will
> > be kept until the socket is closed".
> >
> > This only happens when the locked socket is the only member of its
> > group. If it has siblings, re-listen puts it back into the existing
> > group through reuseport_add_sock(). With migration enabled, the socket
> > moves to the closed section and keeps the program.
> >
> > In a one-socket group, the program matters mostly when an SK_REUSEPORT
> > eBPF program uses SK_DROP to decide which connections are admitted. The
> > group-wide load-balancing change described in the commit message cannot
> > happen through this path.
> >
> > Should the disconnect and re-listen path also respect
> > SOCK_FILTER_LOCKED, or should the commit message say that only the
> > setsockopt detach path is covered?
> >
> > >       old_prog =3D NULL;
> > >       spin_lock_bh(&reuseport_lock);
> > >       reuse =3D rcu_dereference_protected(sk->sk_reuseport_cb,
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261122-reuseport-lock-filter-v1-1-a3e5324c8d55%40gmail.com
