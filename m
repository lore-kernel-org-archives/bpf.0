Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487F3DE439
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369619; cv=pass; b=MBJjXrPq0qwcYLAsONrG15d1SgvnArQPhQuuKHuSaertNdVlTv4yJzdBt6ODu4/7DP7Y/5P3hHX1jbOQbWc3ljLwvDb95VGH5qIPqRmS8yMUPF1wccEZRIT3rpjv3Af+EsoacEiZ8zqkSuXV2GJzEOsSvxCuRDxczlKVCdhMWyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369619; c=relaxed/simple;
	bh=prmM21//B9sPKYo5WgVpAv0RCpCNoPqxT9f76VlMleI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jePYPjEZWZHdVufBwTlaKyOm3w0cgrjtIyCYARsoJ33KjKkUpnGIZ04dzRo9FW0ijt9fdRSoOsLZT/DDLU4w//+j1JhyAB46LC5BJiyaft1cv5Y0x0e6oqOdfyAF+DkYFiz5KucBJdOon2Z/xB/RVdYzU3ajL5LH4dLkPkBVWzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAcJtj0H; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAcJtj0H"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso2387815a12.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 13:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369618; cv=none;
        d=google.com; s=arc-20260327;
        b=apC1YHibN1Q1lE3nSZNPWoAUhcHIl2r1WO0T12viibdQc2+PHrlxjX6sGfzrAvDnZT
         HzLww5e/R7JCFrpHJwQRYbh3jUsvjp6SnuMiWnqftCbpOlOI7w/NYOkZeM1g4DmBx27D
         dESz/yyXQFs7bYrBJNppgnxS/evIOB7A5QaY80gZqU/MYpR7V/NG2adArTSTsD1ijGCq
         D1XaKDLASBSIxj61Y2iaDPzhXB4gqMPBnobG5/4PbJq0ZpDrA6l8E/5mRqAw+2Tx16B1
         5kJlghiFAaJrxSkyHDQmdRNGnk0JuG1Zzvqr2MDlr1voi1XEuXkbpSExxHE5ApH1jJXm
         Oo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4bzkzQjedlM/WHqa+XHjmbIeat2b4Ekopu5HBj7jW+I=;
        fh=gPJ++hIj+ngE9IqQL6tvUl/HJqxSXfaMxWFzifsNi6s=;
        b=jEkLtZxrzyhHykox74LcdTxKUnTBumsRNXYYs9RphogLkSfpSi4b5laalLVTGpy7wU
         QL6LvmqWKL81H3/rLA3oLHdVuP4pym8L9g32frmOFf6pdqBiVi+FTk0HWMNnfHTotoS/
         A7eyQoNcWrRYCMgff5hFl2HaNhxDuft1IHk7Bp/IqJyF/6TOdlPShkfLSdLJSP/DTh+4
         kQ93ZeOUgHnqxjX5VrzSO5XNwevFZ587bkWV72oZut2BL7SeV3VbcomBuEs4jRS/uOGH
         btr4UCBi+QX+X+jwwfY0fHKPnSpEMeeVVCbg9yTDiQhanvhImcZP6EhmcPp+notZXez3
         Zs+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783369618; x=1783974418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bzkzQjedlM/WHqa+XHjmbIeat2b4Ekopu5HBj7jW+I=;
        b=SAcJtj0HoAc9bgbTOSO1OA4cOAyy0NZAvktwpKKtq6D2iExA8wxkhWe7iEVfdC4Z6m
         Ci711e2geyy0tvM0g1WrSRc8cZZFuqmTrWcwYM4NgRxwIcvDNGU4POnYWrQcyn25b7eA
         c6d0lPEtce26jHCk+mL/U9aLBXtbssGTIitfyQYOSBBAH6rze53zekzF5W9QVbS1X78z
         RtcUAHjAUb2IvVKJ0uqUX+RzDWhP0meEvhnTOIt2cqJQ/GOWFZnbWazU1fwYlKLl8Top
         ESCUOIkU4tu1X11pRCtQBXsXkRwqAHUFCd8T3u3HroWtH3ligwSBJ7DRp5C3atr+fDE+
         tcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783369618; x=1783974418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4bzkzQjedlM/WHqa+XHjmbIeat2b4Ekopu5HBj7jW+I=;
        b=AkR0QLYmpG0CRQ8d5W9A8MRaA/P+mlFPYGD6PNywAKr7UwA/iIkddF/VzJtvLvzbRp
         F4N5qiDLcN8z0hsF8oKh2y/R5nD25+30Df29Nx3gXdsBeM2CJPQF2a4z5/QCkMTD5w8I
         HLR7N+0Fd9/g12UOl+j3lZBfTttDdDbwpZ0+C5hYLjKNQw2cuUoj+fM/Q9zRESuDr5li
         EuwsfAtKxxfKdFy661QvNglSJSsVNT9OJTHOzjzFT5vyXI3JMjTI8+qb9sWK7LYVd42K
         tt9L5ltWuyuAQM44/YKQd7/QpSmUB/QkqAFsF75TFA69sNWY7kwIMidtzqMYKQtpCB2a
         JiAw==
X-Forwarded-Encrypted: i=1; AHgh+RoVPqgXx9eDSd4IfMS7pthmNb1sD+WUEIsDdhxodX33Qtu3mpIXAgKgbWy4vEOr4Get0Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczUjEnUiQmWfzGWnjwPvg3lvqT6FaIo6SOta083ZI1hn+BnKU
	YdPCHQzOdc2VFBTz/G+GTnYbZwELqkcrwroqIEy7WwxSF/0m4Qp/zOjSfzMUvbFVfejxJwdV8a6
	NkXr2iUJQDNTAQnlNnv02aeV9DttDzPLx7A==
X-Gm-Gg: AfdE7cmhwP4oFsQ37SMWA3EyPesVnVsKdYlLo5+JEeBD6GMe9Z9KmWV5ciuMU3Xrme5
	+HcdjOpnmKuSxQpsCAFQFv5T0S2eU/kJzjTL+9QA5B3ep96Tx4aqAgJhy/2SJG27FJoYBhuMXUU
	fi5wGiNQTAjN2UyRjiuf1Dm0CIYwT9M+nGEJYMOzG+TSteDpD0+v230yboyRMEviybZ9Evqf1Rb
	AFLDdeUxPGifVqNq01b2vo3Bae4lm+FbftuJfzWcruIYA7VhltYtBqCrrbp2TGvmk80KAYf
X-Received: by 2002:a05:690e:4842:b0:665:6f1e:cad2 with SMTP id
 956f58d0204a3-6677fc26633mr1331309d50.56.1783369295329; Mon, 06 Jul 2026
 13:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706093525.13030-1-mahe.tardy@gmail.com> <20260706093525.13030-3-mahe.tardy@gmail.com>
 <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com> <akvlWB6AkP6kQ7xO@gmail.com>
In-Reply-To: <akvlWB6AkP6kQ7xO@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 13:21:21 -0700
X-Gm-Features: AVVi8CfZRlGTvWxUUfHSVDzobBUdmJmQJRm0dIoZ7u2Wc5w-j_dRvm0qI4-zD7w
Message-ID: <CAMB2axPrEo0uwRkLr1fw+ycCJMGckbo4j27+_it7qqARs-9BzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev, 
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 12:04=E2=80=AFPM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > On 07/06, Mahe Tardy wrote:
> > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets =
for
> > > sending data. This provides a mechanism for BPF programs to emit
> > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > socket types with IPPROTO_UDP protocol but could be easily extended t=
o
> > > SOCK_STREAM and IPPROTO_TCP in the future.
> > >
> > > The API consists of six kfuncs:
> > >
> > >   bpf_ksock_create()   - Create a socket (sleepable)
> >
> > [..]
> >
> > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> >
> > Since you're doing only UDP for now, maybe you don't need bind/connect?=
 The
> > kernel should autobind (by default) when you sendmsg over UDP socket (I=
IRC).
>
> Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> and mostly added the args checks. Another thing is that send is simpler
> since only used on connected sockets, so you just pass the struct
> bpf_ksock and data. So on one side it would simplify the current
> UDP-only API for now by removing the kfuncs but we might need a more
> complex send kfunc (something like sendto).

I also have the same question about the necessity of bind(), but
connect() + send() make sense to me. In the stated use case, the dst
addr probably doesn't change often and I think avoiding route lookup
everytime should be a good thing.

>
> >
> > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > >   bpf_ksock_release()  - Release a reference (cleanup via
> > >                          queue_rcu_work since sock_release sleeps)
> > >
> > > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and L=
SM
> > > programs.
> > >
> > > The implementation follows the established kfunc lifecycle pattern
> > > (create/acquire/release with refcounting, kptr map storage, dtor
> > > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > > struct. Cleanup is deferred via queue_rcu_work() because sock_release=
()
> > > may sleep.
> > >
> > > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > > specifically support AF_INET and AF_INET6 sockets.
> > >
> > > The socket operations go through the expected LSM hooks instead of
> > > by-passing them like many kernel sockets since those are created by B=
PF
> > > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > > exposed to LSM progs, has a re-entering protection to avoid recursion=
.
> > > Also, because of the LSM checks, we prevent the use of the kfuncs fro=
m
> > > asynchronous workqueue as the current value would then be invalid.
> >
> > [..]
> >
> > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > kernel sockets that may exist in each network namespace. Out of
> > > simplicity for now, the settings is host wide but the counters are pe=
r
> > > network namespace.
> >
> > What is this guarding against? Rogue bpf programs creating too many soc=
kets?
>
> Yes. AI review raised this because users are prevented from creating too
> many sockets by bumping against the max number of fd and this would
> allow them to create way more sockets. I kind of agreed that having "a
> limit" on resource creation would make sense but maybe it doesn't and we
> can simplify this!
>
>
