Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2793D6CA3
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763712; cv=pass; b=otT8IB95u/nIpQ8ZXoPBKqqoRxxvWNf9dzKFKoDhVtO2eggn51QBUEIL+lcr5mc23p4fpuwn+8MX96jEgc/y9daGH600Q2vC5f5mgUEJCl/EMLggNfkfP1F+ILqV3ba8aRxcimp5xmv3fm8u6yo/rgetNgZ+i9iVNAEIr98Wm84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763712; c=relaxed/simple;
	bh=OZCwVFcLEdyzc89JwRofAKbJWZwiK73kMSkQvbIQ0EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBjoNCLFOVHfeXu9oPI7qWxL830TkqvpGT05Jg/yS1ukTib2UbGjt+ELwLvOxBG6djveqWAC+TMwMMDidN9dULF5FT1QuSRfGjQgAvmFII9qDDVYfZToeiBes5iadlV9/J9hg1rE2GU5wynWMzP4H3+JaCaQSVHC/fxn0fz323Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXrmWigo; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXrmWigo"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3e27d525so378699e87.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 03:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790763708; cv=none;
        d=google.com; s=arc-20260327;
        b=AhZMG/oB/PikNukaIbMB9Eg4xCAZ0EwF8uLpAEPdco8rYRDfuq+nfWOpLKNwBF19ki
         7wAxm83bJHXaC/blEPm0Yum641waluc8t0xxLZILYdGllLyvCHf+6fQstyhnpsTZao8f
         TyR4QQOW6Mh/9MwGi2XIIb14GqjP9KsDOWTiyAOlyglMM7pkFE8kxWdeAWmdPBty7DJv
         jiuSTbsRqWarH9PYAxIDPd9GJjeqKCvm2Ibyoe+CEJUnz+yIqtfi9gNwHxpYmjUNucG8
         o+2bkOb6oNb5zvT+22AeBo9+4Y5pumFOhzkaewRUQEfFbPlSpeNpFm9fTH0WOzI9PJj2
         galg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nehh+riObSjWcaTYS+qfcz/m6mzt0XKLZn32719dpic=;
        fh=zUBpqbYQ/aUknTMY2H9qJyxOcVrYi4c/sfL760omcZg=;
        b=PLt8XPKwjiC1mZIC9s+XCOrE8UDa68M/8U03AryD+4Ym2VD18f3YRwf+7lpEk2l4KI
         41zESgK1Rl9sbgByAridvOkqlv2ffkurKejE0r0ITlPS8AIZt5Kos6FQrceu53QK/b9m
         Ij5DItsWKzms5tpUuBLytLq9X7qlfVO2C/2ofF6Jbe1lYECw5UmJ4ltM/4wgGqkstFQE
         wmvogxJX5Kwn4+PYFwYhfy3tCFrFNaPQHGHWg1KKhDy4gXKSNEY8doDgV8WKWd/+QwuG
         yUPzdsHr40BfKTa5sS9mTbwAMBYM3ILpe2Kkh1RY0eP/t6xNx+iqyEXk+qkVhAmA88+4
         q+vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790763708; x=1791368508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nehh+riObSjWcaTYS+qfcz/m6mzt0XKLZn32719dpic=;
        b=KXrmWigo5hMj7ThCVcUlRoNsZQWiFhgyIc4b5SkIgMcY7NDsfptsGBAWAWWyiyQuGj
         wMZapGCA5utkwN0pSRqZ5/gvbfpY2+1rmByGaVhLU+QZUOskMTXnXLcMMnraFw0NfTtM
         YDBxgpvVrKdGSlIKbdbsMFqzfW9a6gdrfXWSdNGOcsXUijxZYWUJOfMhfaApMCQ/TQXs
         zGgcxeFPJxbv3vBVwihvhleh0v3AmwJOjM9Ji8wOdeCtyPVlzx1bOYQQx76Cb+f2fxgN
         cuI3lMmmEOBEOz9lW3RMhWNAEguGvWVNisiwmFssPU9HXDSu9jffvprmb0vQksTMbeTY
         yZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790763708; x=1791368508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nehh+riObSjWcaTYS+qfcz/m6mzt0XKLZn32719dpic=;
        b=zPob/9J5aqw7n77xtW+2p62BAx/bJfOo9vSXwemcpKIuT8RyohaVBKjtzyxBxFcp8X
         rRa2Iod5pdGTAD5pm0hUI2+0PmmV2D2mFYkiasbNXcY58in2/rR349jYUNRaomYH9cJc
         L9u0B372F0m/5AOIyaVQq6iTq0Ep4l2ok8xn+uGxnHQytKApDWqIR7ujYoGXgH16ufz/
         Xx1St+u4Al/jJdxUc07Newe2eUw+h2ukvc8/Tnite30UR/nqhaVYPt7/FzThr50lmzwN
         Tpxg0tF5SYCUtIdvEjznBhz/uyGfUy0wdBA7WTXby9lBcxC/tuc/aBOzTyB8krS5EyPj
         MFRA==
X-Forwarded-Encrypted: i=1; AKwUvBwQOeLCLtLwqYzxhn1ZCrkQmIGKABoutwfySq6kVj9Oozs9s+ewnMitsuOyH+O9wRopyvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM1fnMxCLfQhVgWx8LqSEdiH0GzD0hswi7Oz4J4nmA/xiqVYim
	9QFtm2Gfn/4S6SWxxJnvwyoPoVUYK72KohBge8HBDo3rvUykJNRfoIA6rGNOrWQksAVKrKgntql
	8a12mii8Koqo8GToUPErnX5WVgh3mQuA=
X-Gm-Gg: AYBFou0NE0hWu1O10DIFqhoEjg7bEQ8ErF/6BPB0X8RP4YVKGBL33+olvj4IbkENy91
	DdcvwZLFTfxf27hoGiixlxxsDbktc9B5qIxJ0v7G9wwiIRz8Kj2O+h4UnypGuG+oI8dyfsHjzOw
	MJXfunOHBs3CzGs4bBthh0ffIApjVXZSkkGTEYDzD4kOsdjBqIBlPkXQZL858sRw5hp9A6FOP6S
	gD6h8V1fMcjVlq13+gSmYS+iak9SUvyK6mGwS8eT1gXJdKvbARr0MzDFMvGum7Mdnvrq6+8x808
	Kl/3GDkf57QECXdxkLvrBoBSDEoAyRBE7C8MtQPXl7HYUXEztWbngGdJi1I9TcohtCwVnL35DIu
	qMyLaPSNYQ6C4vrcHcqDjIUxcV99uAsuvw9r/dnTnmR1ppU9uJPzt5clwrnqfRwDTPHHeTw==
X-Received: by 2002:a05:6512:66d4:10b0:5ba:3248:3e with SMTP id
 2adb3069b0e04-5ba405ee665mr336729e87.17.1790763707497; Wed, 30 Sep 2026
 03:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com> <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>
 <arLpc9BBv_W6nw8c@devvm7509.cco0.facebook.com> <CAL+tcoCE1MmEQKZRX2ct4zrWxZiSj53ztVuRWU_o1+9AmO7B_g@mail.gmail.com>
 <arVLfFuu02eS2Txs@devvm7509.cco0.facebook.com>
In-Reply-To: <arVLfFuu02eS2Txs@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Sep 2026 18:21:09 +0800
X-Gm-Features: AclHuK8mBdfazbzlfgj_iVLcezQ7qs2nEz7htX1GaA8_RfEXLwJaczul2f7Kv_U
Message-ID: <CAL+tcoDp7WAM8e5+4=TXTTUEy+dzvVsKFP=5Qjp7voo=+RabCg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:11=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 09/23, Jason Xing wrote:
> > On Wed, Sep 23, 2026 at 4:53=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 09/22, Jason Xing wrote:
> > > > On Tue, Sep 22, 2026 at 2:45=E2=80=AFAM Stanislav Fomichev <sdf.ker=
nel@gmail.com> wrote:
> > > > >
> > > > > On 09/19, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@gmail.com>
> > > > > >
> > > > > > Greeting,
> > > > > >
> > > > > > It's BPF Timestamping 2.0 that aims to observe the packet laten=
cy
> > > > > > more efficiently and simply for different protocols. The curren=
t
> > > > > > series is only focused on TCP protocol.
> > > > > >
> > > > > > At Netdev 0x1a/Netconf 2026, the history, background, motivatio=
n and
> > > > > > rough implementation of the feature were exhaustively introduce=
d[1].
> > > > > >
> > > > > > History
> > > > > > =3D=3D=3D=3D=3D=3D=3D
> > > > > > - In 2009, Patrick Ohly implemented the basic infrastructure
> > > > > > - In 2014, Willem de Bruijn enhanced the TCP latency observatio=
n
> > > > > > - In 2024, Jason Xing proposed its lightweight BPF version
> > > > > > Detailed slides from 28 to 32 [1].
> > > > > >
> > > > > > Background
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > > > > > transparent, it's still complicated due to a few points inherit=
ed
> > > > > > from the design:
> > > > > > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> > > > > >   When we confirm the issue arises from the kernel by using att=
ribution
> > > > > >   ability of timestamping feature, we need to further minimize =
the scope
> > > > > >   until the issue is fixed. That means, we then have to resort =
to write
> > > > > >   a few complex BPF progs with the similar functionalities (lik=
e skb
> > > > > >   level tag) which should not happen.
> > > > > > - Not enough low-overhead
> > > > > >   Serving the sensitive applications, an always-on latency obse=
rvation
> > > > > >   platform should mitigate the self-impact as much as possible.=
 As we
> > > > > >   can conclude from BPF Timestamping selftests, there are some =
blocking
> > > > > >   and time-consuming points like where reading/writing BPF maps=
 happen
> > > > > >   in the extremely hot paths.
> > > > > > - Minor flaws
> > > > > >   There are a few minor flaws inherited from the initial design=
, like
> > > > > >   missing tagging the last packet[2][3][4].
> > > > > > Detailed slides from 33 to 39 [1].
> > > > > >
> > > > > > Motivation
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > During the process of the large scale deployment over the last =
few years,
> > > > > > we eventually realized timestamping feature doesn't support con=
tainer
> > > > > > scenario and we need a finer-grained and flexible tracing tool =
(packet
> > > > > > basis) after a few rounds of attribution of issues.
> > > > > >
> > > > > > Design
> > > > > > =3D=3D=3D=3D=3D=3D
> > > > > > - Start time
> > > > > >   For the specific protocol, we need to accurately set the star=
t time of
> > > > > >   each packet first. For TCP, we chose the entry of tcp_sendmsg=
_locked
> > > > > >   and the driver time as the start point, so that any BPF progr=
am is
> > > > > >   capable of computing the delta between start time and current=
 time.
> > > > > > - Simplicity
> > > > > >   Previous BPF program (like selftests) is too complex to imple=
ment. The
> > > > > >   core idea is to make everything as simple as possible. And it=
 should be
> > > > > >   decoupled from BPF area and previous timestamping feature as =
much as
> > > > > >   possible.
> > > > > > - Flexibility
> > > > > >   BPF program hooking any function with skb parameter can get t=
he latency
> > > > > >   value, which means it's no longer bound to the pre-embeded re=
porting
> > > > > >   phases (see __skb_tstamp_tx)
> > > > > > - Efficiency
> > > > > >   Avoid the previous BPF operations as much as possible. Make s=
ure the
> > > > > >   feature achieves the lowest performance impact, which means o=
nly time
> > > > > >   operations remain.
> > > > > > Detailed slides from 40 to 62 [1].
> > > > > >
> > > > > > Implementations
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > in-kernel
> > > > > > - Find a suitable place to timestamp for each packet
> > > > > > - Pick the right start time for TCP
> > > > > > - Handle the split skb due to various reasons
> > > > > > BPF prog
> > > > > > - Hook any functions that carry skb parameter
> > > > > > - Read out the start time from the skb
> > > > > > - Generate the current time and then compute the latency
> > > > > >
> > > > > > Discussion?
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > - Do we need a kfunc to allow users to reset the start time of =
each skb?
> > > > > >   What I had in mind is if someone tries to observe the latency=
 between
> > > > > >   two specific functions (rather than tcp_sendmsg_locked).
> > > > > > - Current implementation is real hardware timestamp always wins=
, which
> > > > > >   means BPF prog possibly gets the hardware time that is not al=
igned
> > > > > >   with bpf_ktime_get_real_ns.
> > > > > > - After the series, do we need to implement the same logic for
> > > > > >   SYN/FIN/PROBE... As far as I know according to numerous user =
reports,
> > > > > >   a small handful of issues came from 3-way handshake.
> > > > > > - Reusing the slot of hwtstamp might bring potential problems o=
r make the
> > > > > >   code hard to maintain. Can we add a timestamping specific fie=
ld in
> > > > > >   skb to deal with the latency observation?
> > > > > > - netdev_data conflict in IGC driver. It seems unavoidable to p=
ollute
> > > > > >   start time when it's enabled. Should V2 feature coexist with =
hardware
> > > > > >   timestamping?
> > > > > > - Should V2 coexist with net timestamping and BPF timestamping?=
 If not,
> > > > > >   the maintenance should be easier.
> > > > >
> > > > > After netconf discussion, I was under the impressions that no ker=
nel
> > > > > changes are needed, so what changed? Is it hard to track start_ti=
me
> > > >
> > > > Ah, you refered to the internal version, right? We wrote a kernel
> > > > module implementing similar logic which differently finds/borrows a=
n
> > > > unused field of socket to store the start time. It's quite similar =
to
> > > > the series actually.
> > > >
> > > > After deploying it at a small scale in production, I think it's
> > > > meaningful to upstream it. But as you noticed, there are remaining
> > > > discussion points on which I hope we can share opinions, especially
> > > > the future shape.
> > > >
> > > > > from tcp_sendmsg_locked on the bpf side that we need kernel suppo=
rt?
> > >
> > > [..]
> > >
> > > > Sure, we need kernel support that why I'm trying to introduce the
> > > > sk_start_time to help.
> > > > https://lore.kernel.org/all/20260919143732.11772-4-kerneljasonxing@=
gmail.com/
> > >
> > > Why can you not do this on the bpf side? There is even now a sendmsg_=
locked
> > > tracepoint with skb/sk argument. Or is it mostly because you can't
> > > distinguish between cgroups? And looking at your example [1] and don'=
t
> > > see why a tracepoint won't be enough. Or is it too much overhead? In =
this
> > > case, it needs to have some numbers attached...
> >
> > I understand what you meant. Sure, we can generate the initial time in
> > the tcp_sendmsg_locked() and try to pass it on to each skb in
> > skb_entail(), which means 1) we need at least two hooks, which brings
> > obvious overhead, 2) it's still not that easy to use as I expect it to
> > be super easy to use/write/deploy, 3) I try to decouple it from BPF
> > infra or complex use for the convenience. It looks like we now go back
> > to BPF Timestamping V1.0.
> >
> > Adding hooks does harm to the performance to those real
> > latency-sensitive users who were actually yelling at us. There are
> > some interesting numbers I collected previously (Sorry, I will not be
> > able to collect more real data because I left that company:( ):
> > 1) The kernel module introduces around 5-15% performance impact in the
> > real workload. After we removed the hook in tcp_sendmsg_locked, even
> > though the module didn't have the full function to calculate the
> > latency, the cost was decreased by ~3-5%.
> > 2) Fentry has ~4% impact on some workloads. It's very similar to what
> > we use netperf on loopback [1].
> >
> > The crucial idea behind the feature is that we're trying so hard to
> > deploy the latency platform 7x24 without any selective sampling. It
> > now looks like an advanced/21-century tcpdump and it can be
> > _always-on_. If someone is just looking for one-shot tools, of course
> > there are a few alternatives that are not good enough though.
>
> IMO the feature as posted looks very tailored to a specific/narrow

Quite opposite.  Perhaps you missed reading the key part about the
"lack of container scenario support." And the fact is that there was a
wifi guy talking to me that he also wanted this to land and support
the wifi.

The new arch serves all kinds of complex scenarios that BPF
timestamping v1 doesn't have the ability to support at all :)

And BPF timestamping v2 is per-packet-based, which makes everything
different: allows admins/users to investigate stall details if they
want.

I believe the full explaination/theory/motivation... have been added
in the commit message. Please if you could reread all of them
(including the slides), I would appreciate it :)

> use case. You save the sendmsg time in the socket and then use
> it during skb allocation (with a few quirks here and there to account
> for fragmentation/tso/cloning/etc).
>
> For the very least, If you're looking to turn it into a non-rfc submissio=
n,
> I'd add numbers: tracepoint based implementation vs this kernel
> accelerated path. And then we can discuss how much slower the tracepoints
> are and whether you're using the proper ones... (and have an actual selft=
est
> example as part of the series)

Sorry, as said, this is only one part of the new arch.

Sure thing, as you suggested I'm going to add a few numbers with BPF.
Also a selftest!

Thanks,
Jason
