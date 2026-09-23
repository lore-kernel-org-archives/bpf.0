Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64928372ED3
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156482; cv=pass; b=ZJkDXPrWr6SfVW0NafxlLbDYyK57tbaC7FnypzPH5ztu6R4vu9UD40qKgkujWNNSPkmZL3PyNPj/LDl93PxM5aEHTjkJ2ljzq40b5J0KmtWX6IhSv2tuUK2zZ+0MkefITDyUJB3QshXAGohNFwwnGbY60obaLR6vL8z+TfnvIAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156482; c=relaxed/simple;
	bh=nyggQDgw6t0wPOAxA+hYNPIEmbpYLxztlatxyx2+00M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gICwJ3T4480XpaCRjMm3AI4pTZi1X7QTcmQf6m/NPcE0PvSDOwuYtnum+FRrTq/Cf2jW+xdgycuPcM4PcZDuBtmiDW+XgejgHczhrsJCi17X8qq9E4pmsvnR2A1ZvuFqik4xVqGKgAwAGTbZvGnbFFBwN/R8KK8hYIqnnGo4twc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEGtARDB; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEGtARDB"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso4786241fa.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 02:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790156478; cv=none;
        d=google.com; s=arc-20260327;
        b=Ov1xnaLg11kNhB3Rl6QGcMgUe6chJkcoPh2DDCLLJ6fkB4C2sAUxpfc84b4i0hjKsu
         NYH3WifNNHNnA68W+fNohy8XSO0qMyh3/nOFdQk7njwqgByoCgF7wLSYwehUZH4SxeyN
         wg24opcGFSEcCHzejPFi2V0Ow9arTI1iPTdzwYQ2gvBHb26KITSzIJZig+MLUpffGei8
         jLcdeRA2vvlTXsMuYqaFkpABz+eaDRxSpLClKolQYJ2gcUmifuSb1K/s9anyReppn/CP
         /IAlndbzK6T82CuWso2uuoOPzUJ8AoV/vz7VMLe9CZmzU/KdL55HIMv0D3a6Uy422q3U
         DTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLEKHnzRC7zsQJRJ6heX63AtqGj1/BSwRwuk1jfCOso=;
        fh=RuFdmx8OTKxJX5tP6p1uw7Nk9pkV88OYODy2FSgkots=;
        b=HEZ8zFLXgFGX4pZX2DrmDAsbsN8sEPR9fDi4jPhvK6CDLamiSK0NNvpVK2A/N2HaXK
         iwAYRFxndeKY0IK+5+eN9j++tGVGwcZgMvxtof9osIjiffn9vVuBS1k4JZ5EiTJRY3CK
         xcsTTaJv0eMMo6G/I/H5VbZdomHENPo2Nr7bNvFLFSLEsohdpAy06D99Dkw0H1E+tZ1G
         9sp10jhh8D+U2JIYyGrDYj60hoxIiekYgC5jrKBVdeAH4mLB4AvNKVyiYDyIwXFVErmJ
         VZvPB2wrk49atSmfhrD/vgtXWqO4FCXCVJRgeufYtqHQycDT5E8++FcpH6CUq23dk3XJ
         sB4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790156478; x=1790761278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLEKHnzRC7zsQJRJ6heX63AtqGj1/BSwRwuk1jfCOso=;
        b=gEGtARDBrPVUb419IIEN78MswtA8tlAvQ1Mq7PSVl2+ZoRy7eovHuB+dweOUmo9Qj6
         cheBJwqlHstJITBDOuNbthxZ8Eo0I6fc4/Uw6h9IDJQCDsZzORxIshwG/bkZg9SdfwFc
         FqimNRW4rkJ4pAGKZmzTf+0NtdyZ1Sm4NSrPxfU4icfC5+Wk26eATCWAFzlvgaX5AKw2
         7JTkM9+SZNE457G+ZlYX92AduES2nt1X4jHyvb7HWMjvGw50CmoamU8QFHmmPAQ33jij
         m/F7958d7ubkqrJbfV7CZHsg6qe2WcsSTOdh6eLZcVKYc2NuD7eV2pSYPWIKtXW/Zj40
         lMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790156478; x=1790761278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLEKHnzRC7zsQJRJ6heX63AtqGj1/BSwRwuk1jfCOso=;
        b=CAHdwj2DAwpLYm0FuvJRmGP/8yVkDr0qZl27e2gHJYXEoUbV5kFW6TnNFBnR8xaGDg
         NHuRpthJ6ZsYuUqBMdgZtr+l+FOqz/9hGmAXAtyjco4pQscyczr3L6LDFfO4/7c+k+o8
         P3ukY+bK0zpw32JK7HPOp82cflICGhU3b+SH12t8uTFWAIVbuwhy1KSyRFtbTDCjA57v
         s8H9pMh0Q2jl46mtIOsxlUDcE2pGtlXU6TLt9jHNOEZpSloFeib/DeLJXltI5eyRm2fg
         qUc802/8/qiNGH+iW1sgeyCHgf52aqA3Y7c952FrraBgd60V+aWvjpO/EBo08afC5HwZ
         uMMg==
X-Forwarded-Encrypted: i=1; AKwUvBxpHs0sR009LPHPRPw1Cgpncf9txhLbU+SG2HM5nXAzRksnt2cuVrYspJRWDAYC2M7GzXg=@vger.kernel.org
X-Gm-Message-State: AFuF++mWbQE9SR+uUeZlidjVYTu2Jyr5gdrLlp2s+CxH/uGz+K94qYC0
	MXx7wUOMCib0WbIPOzzKBU12AcSJRFo731D20hpHBtsbjiMBBymnHxeJTQ/M+Bzv3+xPPqLIHm9
	TDv+nwh1QTFhfxGtokuw7kq7cu+qhfIApFW+x+q1qUU2HFT0=
X-Gm-Gg: AYBFou2Z2sEZPJ4WCb1mrsH6/LI8OPQE+z8Wp3ZvEZwiBOPIQ0pP6Z3+/kaBxUCo7aC
	dZqA382qhxmQX0KtF20Le4QHKzcSJEl/2Kg0xUMW6fSB6cgqJWbi2EAqmQC/EvxxAGpRfPzrQkm
	7zvAtnzVdqu5TYBR+qBMJl6gIIv22Oeg0KOH5ccOEi9rWbMpm6lc3LilKcHIpvDVfVLTHTP4ryf
	2cnfzxW1m7eGzfV7jy+xi0XbTMgPsMIGuUxUvT79tqbf3Xx5eiOgkMFlN9vFclXHTbViLTu2T1r
	0EREOd1t284r0vXdUbmC3t7GDdTXNJoKedgqrqlAnM4pv7AJO8tDdx2JgYnJGeeQmPq6DtFt4x5
	7wY2K3GILlgo3mGpw2ILNqu+GUjTV63yT8xwaO/KxIVO0LjDJtLwNMkge2yK/fBEzI2C9YXSPBy
	DGE7Kh
X-Received: by 2002:a2e:b88e:0:b0:3a6:1694:8233 with SMTP id
 38308e7fff4ca-3a630675898mr4370951fa.25.1790156477862; Wed, 23 Sep 2026
 02:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com> <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>
 <arLpc9BBv_W6nw8c@devvm7509.cco0.facebook.com>
In-Reply-To: <arLpc9BBv_W6nw8c@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 23 Sep 2026 17:40:39 +0800
X-Gm-Features: AclHuK9fy-ahoDrY3GpGjYtS2oLvfELFozp55I3DKx16zDwZlBD2euppcOCOfmE
Message-ID: <CAL+tcoCE1MmEQKZRX2ct4zrWxZiSj53ztVuRWU_o1+9AmO7B_g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:53=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 09/22, Jason Xing wrote:
> > On Tue, Sep 22, 2026 at 2:45=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 09/19, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@gmail.com>
> > > >
> > > > Greeting,
> > > >
> > > > It's BPF Timestamping 2.0 that aims to observe the packet latency
> > > > more efficiently and simply for different protocols. The current
> > > > series is only focused on TCP protocol.
> > > >
> > > > At Netdev 0x1a/Netconf 2026, the history, background, motivation an=
d
> > > > rough implementation of the feature were exhaustively introduced[1]=
.
> > > >
> > > > History
> > > > =3D=3D=3D=3D=3D=3D=3D
> > > > - In 2009, Patrick Ohly implemented the basic infrastructure
> > > > - In 2014, Willem de Bruijn enhanced the TCP latency observation
> > > > - In 2024, Jason Xing proposed its lightweight BPF version
> > > > Detailed slides from 28 to 32 [1].
> > > >
> > > > Background
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > > > transparent, it's still complicated due to a few points inherited
> > > > from the design:
> > > > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> > > >   When we confirm the issue arises from the kernel by using attribu=
tion
> > > >   ability of timestamping feature, we need to further minimize the =
scope
> > > >   until the issue is fixed. That means, we then have to resort to w=
rite
> > > >   a few complex BPF progs with the similar functionalities (like sk=
b
> > > >   level tag) which should not happen.
> > > > - Not enough low-overhead
> > > >   Serving the sensitive applications, an always-on latency observat=
ion
> > > >   platform should mitigate the self-impact as much as possible. As =
we
> > > >   can conclude from BPF Timestamping selftests, there are some bloc=
king
> > > >   and time-consuming points like where reading/writing BPF maps hap=
pen
> > > >   in the extremely hot paths.
> > > > - Minor flaws
> > > >   There are a few minor flaws inherited from the initial design, li=
ke
> > > >   missing tagging the last packet[2][3][4].
> > > > Detailed slides from 33 to 39 [1].
> > > >
> > > > Motivation
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > During the process of the large scale deployment over the last few =
years,
> > > > we eventually realized timestamping feature doesn't support contain=
er
> > > > scenario and we need a finer-grained and flexible tracing tool (pac=
ket
> > > > basis) after a few rounds of attribution of issues.
> > > >
> > > > Design
> > > > =3D=3D=3D=3D=3D=3D
> > > > - Start time
> > > >   For the specific protocol, we need to accurately set the start ti=
me of
> > > >   each packet first. For TCP, we chose the entry of tcp_sendmsg_loc=
ked
> > > >   and the driver time as the start point, so that any BPF program i=
s
> > > >   capable of computing the delta between start time and current tim=
e.
> > > > - Simplicity
> > > >   Previous BPF program (like selftests) is too complex to implement=
. The
> > > >   core idea is to make everything as simple as possible. And it sho=
uld be
> > > >   decoupled from BPF area and previous timestamping feature as much=
 as
> > > >   possible.
> > > > - Flexibility
> > > >   BPF program hooking any function with skb parameter can get the l=
atency
> > > >   value, which means it's no longer bound to the pre-embeded report=
ing
> > > >   phases (see __skb_tstamp_tx)
> > > > - Efficiency
> > > >   Avoid the previous BPF operations as much as possible. Make sure =
the
> > > >   feature achieves the lowest performance impact, which means only =
time
> > > >   operations remain.
> > > > Detailed slides from 40 to 62 [1].
> > > >
> > > > Implementations
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > in-kernel
> > > > - Find a suitable place to timestamp for each packet
> > > > - Pick the right start time for TCP
> > > > - Handle the split skb due to various reasons
> > > > BPF prog
> > > > - Hook any functions that carry skb parameter
> > > > - Read out the start time from the skb
> > > > - Generate the current time and then compute the latency
> > > >
> > > > Discussion?
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > - Do we need a kfunc to allow users to reset the start time of each=
 skb?
> > > >   What I had in mind is if someone tries to observe the latency bet=
ween
> > > >   two specific functions (rather than tcp_sendmsg_locked).
> > > > - Current implementation is real hardware timestamp always wins, wh=
ich
> > > >   means BPF prog possibly gets the hardware time that is not aligne=
d
> > > >   with bpf_ktime_get_real_ns.
> > > > - After the series, do we need to implement the same logic for
> > > >   SYN/FIN/PROBE... As far as I know according to numerous user repo=
rts,
> > > >   a small handful of issues came from 3-way handshake.
> > > > - Reusing the slot of hwtstamp might bring potential problems or ma=
ke the
> > > >   code hard to maintain. Can we add a timestamping specific field i=
n
> > > >   skb to deal with the latency observation?
> > > > - netdev_data conflict in IGC driver. It seems unavoidable to pollu=
te
> > > >   start time when it's enabled. Should V2 feature coexist with hard=
ware
> > > >   timestamping?
> > > > - Should V2 coexist with net timestamping and BPF timestamping? If =
not,
> > > >   the maintenance should be easier.
> > >
> > > After netconf discussion, I was under the impressions that no kernel
> > > changes are needed, so what changed? Is it hard to track start_time
> >
> > Ah, you refered to the internal version, right? We wrote a kernel
> > module implementing similar logic which differently finds/borrows an
> > unused field of socket to store the start time. It's quite similar to
> > the series actually.
> >
> > After deploying it at a small scale in production, I think it's
> > meaningful to upstream it. But as you noticed, there are remaining
> > discussion points on which I hope we can share opinions, especially
> > the future shape.
> >
> > > from tcp_sendmsg_locked on the bpf side that we need kernel support?
>
> [..]
>
> > Sure, we need kernel support that why I'm trying to introduce the
> > sk_start_time to help.
> > https://lore.kernel.org/all/20260919143732.11772-4-kerneljasonxing@gmai=
l.com/
>
> Why can you not do this on the bpf side? There is even now a sendmsg_lock=
ed
> tracepoint with skb/sk argument. Or is it mostly because you can't
> distinguish between cgroups? And looking at your example [1] and don't
> see why a tracepoint won't be enough. Or is it too much overhead? In this
> case, it needs to have some numbers attached...

I understand what you meant. Sure, we can generate the initial time in
the tcp_sendmsg_locked() and try to pass it on to each skb in
skb_entail(), which means 1) we need at least two hooks, which brings
obvious overhead, 2) it's still not that easy to use as I expect it to
be super easy to use/write/deploy, 3) I try to decouple it from BPF
infra or complex use for the convenience. It looks like we now go back
to BPF Timestamping V1.0.

Adding hooks does harm to the performance to those real
latency-sensitive users who were actually yelling at us. There are
some interesting numbers I collected previously (Sorry, I will not be
able to collect more real data because I left that company:( ):
1) The kernel module introduces around 5-15% performance impact in the
real workload. After we removed the hook in tcp_sendmsg_locked, even
though the module didn't have the full function to calculate the
latency, the cost was decreased by ~3-5%.
2) Fentry has ~4% impact on some workloads. It's very similar to what
we use netperf on loopback [1].

The crucial idea behind the feature is that we're trying so hard to
deploy the latency platform 7x24 without any selective sampling. It
now looks like an advanced/21-century tcpdump and it can be
_always-on_. If someone is just looking for one-shot tools, of course
there are a few alternatives that are not good enough though.

[1]: sides 25
https://netdevconf.info/0x19/sessions/talk/the-future-of-so_timestamping.ht=
ml

Thanks,
Jason
