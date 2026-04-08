Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173F29992A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633466; cv=pass; b=cp/g8IFa32hWWeG1ZNa7dIvRFTzLg5jlgwj55YU1WauF7m5y2OH3vz0OVnQX9w+LRO1Afuaq3/w8lPvZ2j7lwAbYKlg+URpBj1WedH37r+UmvtvIuZ0pUckF+crtzYDwE8pAO91kdaSRmGS9BsRTGiCF97loKIuzmasF7ghDc64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633466; c=relaxed/simple;
	bh=CeA6uYKOa9sqRJ+MQyCP23Joz9YR2D1UWj7MkNiwvrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVU8mEBd7PYrJ2ho/OMdlBqSeTKZ3HdbZMz9+PtvjMsmh/U1Qd6EggryaK6+29tiOUOV+tcS0Cc96ooMzu2JVaA0hsQhAQk2uneiDJUzHFgN6i8OZmht/c82WiC1ryZacPIKJagNg7fhXWWCRaD2mY7oe1bD16evBvonH3I+nBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA3V4Y+7; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA3V4Y+7"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a283c44478so6690536e87.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 00:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775633463; cv=none;
        d=google.com; s=arc-20240605;
        b=Mr4IcQ7WG3St3FXdmmt2QRXoa6idItuxynwMTSmnnwOxM53+iFFu08bP9pguUUaR+S
         PDGmI5PWFRKnJRMyFnbEnKFmwc9SFzqb4TyXimXYSmpyvOf6IAUw5h1mYXcOSLPLpsdB
         Bcvw6L+O0VBNQ5EoR/HUSeofWkNf9MW0rHrQJbVWw2L2KJ3TaCpEqntkYF5GYgCIdETt
         KvioGxuGgzPPQdxGFul5ThVLnpiryw839vw5Szj9yMp0oI0cRLAyVg+bQYwlMVOfLu3u
         bFB4ld7W61xeTmALtSIsbwKof2ts4YOLQTTqVIS2Wu5LTAzzg+ypTUrGDF0W0TtHK8N4
         TpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHN/+v66yc0A89NHJH+2Y3ZhjzBVXfkm+kEWhWOJlLw=;
        fh=B6yzksCPyM+jdImdD2b2bXaU6o3DrmxL4QD+W+UtVr0=;
        b=EfrGf14tvEWEx0Kx9QySK5XVJAp962jKk41aZJWAfJjSSPsymfueUzrRaT5X64xqAG
         0m/B5x/QEj/1ELNzuf5C9ZZY0Wr115OqcGyF05Wn8VJ4pHvwtYLinc31tDLkXoixhBiu
         NRytmWa5HV9+pPgA++b+j32lILbzV5VSG9aforai0paESgZcejqZqcShlnMfHyL2msmJ
         +zZVD4eJWTBwl7lpSfKwE8cIGlx0wi9vN7s8dhcNl1iNwCERG4grN/Db+8Ti1OSb+1bR
         sgfSf92mbq/sk3Up2TGnS4EXbaHIdvWrzXxmAywOpuQonxixWhWfz5cMZmdpZSxYbQgX
         mpcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775633463; x=1776238263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHN/+v66yc0A89NHJH+2Y3ZhjzBVXfkm+kEWhWOJlLw=;
        b=nA3V4Y+7NhmNK/hsfXPp/WrVVMuQEIIPJ9N3LQ5p8xUf5VFRqSvJ7ZTxT3uMJqkOxg
         lFWkEE63E9VoAV/SbYZxb/IR3CscNrSCoFcqGetAWsndi7cFfNIQhfROj0gzVVVyB1ow
         oGB+Bu4OSN6d8FnciSP+fa5tw2LWntsPRUZOBP7Z6LpRSNzHJUWl6m+JwthW8KDAHlwW
         sxJEWMcL2BAFnhOAipzVY2gt7I9izxPaXl2o+0xzgVzyuUgQysuQEvm0IEDOnvYfjLt6
         p0a9sGnpLbWi8mCTErZ30sLJnLXitc9jJ8UKs6wKT5eLkvovUfr98e34U9yxuwr4/HrY
         jGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633463; x=1776238263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHN/+v66yc0A89NHJH+2Y3ZhjzBVXfkm+kEWhWOJlLw=;
        b=bc8xJBvevwZWicIJSPqomL1hV/l2qLhUjxi/B3FOw9rkKnurbpHTXJhqV6LPnIElGb
         y+8lQ2nu2bDrtEim5AY/rN9I7nWu756A5XfT0UYv0lEhr4arDIagB+b0u3DqrgAyYgSO
         tuFvYIycN1Ib4vwvmoA2glH8QWGuPheJSsO8VIBFDCZ5ihRjaxVi2TTdx3SvwFLcba1z
         xFQEz8Y1QAaX+DL9FMDnmWfm71h1KlPQgFk3E0CiM4xHJ/W/cRli6TcEFYKwWsbYitqL
         hlhcN3ZKUn1g0ESR3jiXm8Uha+hHtax3lgJHx4Yk+ETFUiMkC7PfrIeu7c05p48r76YQ
         BXqw==
X-Forwarded-Encrypted: i=1; AJvYcCUECjxb7fO9OIi/Uq/vtkfkBpZq74PvsJNz9QB/I8DcofnGwjiEYkn+yS1+g1htTYV+F+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVinqINUPC8kc2gkPOpB8PSB5V9+eXXSoq7qbuEztlnNIPdRC/
	9HN66q6xTZBqTdZfNRx0g1yvnW5/JA+Ushmoxv0WXqGCr1IslgjQsz/f7xwbdaQemnp7OmdFmvO
	UnPqNjRraTRafzMi/gsopXA8qdMHorlk=
X-Gm-Gg: AeBDieuFTQuPi5/aETyyGZzxUlNKyD6iMwlmP6biVckpXezHYNB+z/1as86X1KUx8A9
	0qEtQe8GQgOEeH1N+h+f9B34OJHcJ5W2O9uQMQ5sUjzzyHWzA3wiUBvDjECcKl9rB/zcWoIgn/M
	JG2qKHbnyyOoGRNgOZIOniErQKsDpFAbi9ZMdZlsh1SWw3rjoUxxvnzaY7/yvUKkfIiDzGUNZSe
	Vnu6pnRLP9Ld/GdQDD4IOcxgURHWBk3RgCz6Ma7CK0gI6rCpcgo5VSlluwcddbBwf3Yj5Vi6fHU
	L+OsGsiY
X-Received: by 2002:a05:6512:2251:b0:5a2:c406:a74a with SMTP id
 2adb3069b0e04-5a33758d965mr5354978e87.35.1775633462669; Wed, 08 Apr 2026
 00:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com> <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com> <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
In-Reply-To: <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 8 Apr 2026 15:30:24 +0800
X-Gm-Features: AQROBzCA_HI1mJ5iXTGiSj9KFSmyl8xFzPMd49B8ysVtzC6MO0xGXC6MCb7Q39U
Message-ID: <CAL+tcoAa4FqSik8sGAzj6t8s_TpqBUDp95KkucCVDWBOQAkRiA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Apr 8, 2026 at 5:17=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > The patch is the 1/2 part of push-level granularity feature=
.
> > > > > > > >
> > > > > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occ=
urs even
> > > > > > > > though it might not carry the last byte of the sendmsg.
> > > > > > > >
> > > > > > > > Prior to the patch, BPF timestamping cannot cover this case=
:
> > > > > > > > The following steps reproduce this:
> > > > > > > > 1) skb A is the current last skb before entering wait_for_s=
pace process
> > > > > > > > 2) tcp_push() pushes A without any tag
> > > > > > > > 3) A is transmitted from TCP to driver without putting any =
skb carrying
> > > > > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > > > > 4) sk_stream_wait_memory() sleeps for a while and then retu=
rns with an
> > > > > > > >    error code. Note that the socket lock is released.
> > > > > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will =
jump to(goto)
> > > > > > > >    'do_error' label and then 'out' label.
> > > > > > > > 7) at this moment, skb A turns out to be the last one in th=
is send
> > > > > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() o=
pportunity
> > > > > > > >    before the final tcp_push()
> > > > > > > > 8) BPF script fails to see any timestamps this time
> > > > > > > >
> > > > > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > >  net/ipv4/tcp.c | 4 +++-
> > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > > > index c603b90057f6..7d030a11d004 100644
> > > > > > > > --- a/net/ipv4/tcp.c
> > > > > > > > +++ b/net/ipv4/tcp.c
> > > > > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *=
sk, struct msghdr *msg, size_t size)
> > > > > > > >  wait_for_space:
> > > > > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > > > > >               tcp_remove_empty_skb(sk);
> > > > > > > > -             if (copied)
> > > > > > > > +             if (copied) {
> > > > > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_n=
ow,
> > > > > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > > > > >
> > > > > > > Now the number of skbs that will be tracked will be unpredict=
able,
> > > > > > > varying based on memory pressure.
> > > > > >
> > > > > > Right, I put some effort into writing a selftests to check how =
many
> > > > > > push functions get called at one time and failed to do so.
> > > > > >
> > > > > > >
> > > > > > > That sounds hard to use to me. Especially if these extra push=
es
> > > > > > > cannot be identified as such.
> > > > > > >
> > > > > > > Perhaps if all skbs from the same sendmsg call can be identif=
ied,
> > > > > > > that would help explain pattern in data resulting from these
> > > > > > > uncommon extra data points.
> > > > > >
> > > > > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? Th=
at is
> > > > > > close to packet basis without considering fragmentation of skb =
:)
> > > > >
> > > > > No, I meant somehow in the notification having a way to identify =
all
> > > > > the skbs belonging to the same sendmsg call, to allow filtering o=
n
> > > > > that. But I also don't immediately see how to do that (without ad=
ding
> > > > > yet another counter say).
> > > >
> > > > If we don't build the relationship between skb and sendmsg (just li=
ke
> > > > the SENDMSG sock option), we will have no clue on how to calculate.=
 If
> > > > we only take care of the skb from the view of the syscall layer, it=
's
> > > > fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But =
in
> > > > terms of per skb even generated beneath TCP due to gso/tso, there i=
s
> > > > only one way to correlate: adding an additional member in the skb
> > > > structure to store its sendmsg time. This discussion is only suitab=
le
> > > > for use cases like net_timestamping.
> > > >
> > > > Well, my key point is that, I have to admit, the above (including
> > > > existing bpf script net_timestamping) is a less effective way which
> > > > definitely harms the performance because of the extremely frequent
> > > > look-up process. It's not suitable for 7x24 observability in
> > > > production. What we've done internally is make the kernel layer as
> > > > lightweight/easy as possible and let the timestamping feature throw
> > > > each record into a ring buffer that the application can read, sort =
and
> > > > calculate. This arch survives the performance. But that's simply wh=
at
> > > > the design of the kernel module is, given the fast deployment in
> > > > production. I suppose in the future we could build a userspace tool
> > > > like blktrace to monitor efficiently instead of the selftest sample=
.
> > > > Honestly I don't like look-up action.
> > > >
> > > > Since we're modifying the kernel, how about adding a new member to
> > > > record sendmsg time which bpf script is able to read. The whole
> > > > scenario looks like this:
> > > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will =
get
> > > > a copy of its original skb
> > > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > > current time, and then effortlessly do the math.
> > > >
> > > > At this point, what I had in mind is we have two options:
> > > > 1) only handle the skb from the view of the send syscall layer, whi=
ch
> > > > is, for sure, very simple but not thorough.
> > > > 2) stick to a pure authentic packet basis, then adding a new member
> > > > seems inevitable. so the question would be where to add? The space =
of
> > > > the skb structure is very precious :(
> > >
> > > Finding a suitable place to put this timestamp is really hard. IIRC,
> > > we can't expand the size of struct skb_shared_info so easily since
> > > it's a global effect.
> > >
> > > I'm wondering if we can turn the per-packet mode into a non-compatibl=
e
> > > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > > sendmsg.
> >
> > Agreed that an extra field is hard. We should avoid that.
>
> Avoiding adding a new one makes the whole work extremely hard. I'm
> wondering since we have hwtstamp in shared info, why not add a
> software one for timestamping use? Then, we would support more
> different protocols in more different stages in a finer grain, which
> is a big coarse picture in my mind.
>
> Adding a software bit will completely reduce the whole complexity and
> be very easy to use. Would you expect to see a draft by adding such a
> bit first?
>
> Or just like I mentioned, repurposing tskey seems an alternative,
> which, however, makes the new feature incompatible.
>
> >
> > If the purpose is to group skbs by sendmsg call (e.g., to filter out
> > all but the last one), it is probably also unnecessary.
> >
> > From a process PoV, since the process knows the sendmsg len and each
> > skb has a tskey in byte offset, it can correlate the skb with a given
> > sendmsg buffer.
> >
> > The BPF program is under control of a third-party admin. So that does
> > not follow directly. But it can be passed additional metadata.
> >
> > I thought about passing the offset of the skb from the start of the
> > sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> > as each new buffer will start with an skb with offset 0 ..
> >
> > .. but that won't work as there is no guarantee that a sendmsg call
> > will not append to an existing outstanding skb.
>
> Right. TCP is way too complex and we indeed see some tough issues when
> trying to deploy the feature. So my humble take is to make the design
> as simple as possible.
>
> >
> > Anyway, the general idea is to pass to the BPF program through
> > bpf_skops_tx_timestamping some relevant signal , without having to
> > expand either skb or sk itself.
> >
> > I hear you on that measuring every skb is too frequent. But is calling
> > the BPF program and letting it decide whether to measure too? BPF
> > program invocation itself should be cheap.
>
> Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
> an awesome way to go. My ultimate goal is to do so. Instead of letting
> people implement various fine grained bpf progs, we can provide a very
> easy/understandable/efficient approach with more samples. It should be
> very beneficial.
>
> >
> > If per-push is preferable, with a filter ability like the above, it
> > seems more useful to me already.
>
> Push-level is a compromise plan. Packet-level is what I always pursue :)
>
> The current series has this ability: the bpf prog noticed it's a
> SENDMSG sock option and will selectively call
> bpf_sock_ops_enable_tx_tstamp() to do so. Only by calling
> bpf_sock_ops_enable_tx_tstamp() could the skb be tracked.

FYI, bpf prog could call bpf_sock_ops_enable_tx_tstamp() to enable the
skb track selectively.

Thanks,
Jason
