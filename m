Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858ED293B5F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608580; cv=pass; b=G0lHjp0YobCJUmCYP143+xJiOvGBm2pOeDqeu1ponOV+GUKq69l6fwTwDlb2ycRY5th/gb64jFxJC/NDtbrbB+8eYBbLGXWndGD7i+x9BnR0e/X8PyEO4UkrXtkCOib4Ww5/+8BGdxwgpnxdQkHvaknCSIDYHuhEFol36qgbdqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608580; c=relaxed/simple;
	bh=yc04CXDJZIssiibVZiuD663knKh8kMXknZH9b823FCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n22znO0+c9BczfVNF7hV9YhQ0wqKdZSkfRxrBoKzSK4T3EZdps2/oJndjeW3C3fKgqjhDkaKLW6+Bluj53RY7PwbJcD77L4WT88WHy8QMUuGmKhDBMyI+lvdQjJ89Of8OsKWLPk7k0UWO+8tga1f6VTG7tqZ9ZGqBZpsJ53IIdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+JUawZu; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+JUawZu"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2c500750dso6989402e87.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 17:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775608577; cv=none;
        d=google.com; s=arc-20240605;
        b=li0A94ZSdfB5oqJkgPrd+APWduu5JMjtMFhHAx42OCKszY/NecQLZI8MzeSPqufewn
         yxI330IKgF9UQVQLqnu6CplIeLmGwgrf4ulGzQ6wsQ+5LSMNTLoclaJocfXfZDJ8cP+q
         k7/Ohl0Lk6Z2AZ8GyM4AC8qpYfiaiRNqand/ac8lIghI9K71nxtz3eNeLJONMZNbs0oO
         JT0Xu7d++moocWXeVPW82HTGUn2fXPQ6NFRzam/+eGOvjjIOAgeUl7TaNNbpkiPKTdqi
         hOvmOpza5032w+hknOyeUBwfgRu2mA7BvBsLGWgIYzRmNmyxFvSF7MGASgKxOHVONTVf
         PkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6n/7HQyrtMfTJW06twOyVYb1ZogrEoRjRGf+zORS6bw=;
        fh=fMSQXTV5ORucyEhNVZhm2TpZuk87HwL7pbtDry/tZk0=;
        b=OdRaM/lnqp++CvDkw1nvf2lwX1OQS403p3XEV+fBB2XMqxmJcQfZVKqC/U4bUS+8/n
         lgD8RWoRWv0/rKX7+T8PY3jHbGmSjD3ykCYCfSt+vv3J30/QjjaCKt9DrluLPuYIquUq
         GHDFxxW/3GhImS2Jv8WifZRXlZX/wqE7x/vsRDPAUP3DyX9GERdeaQaY/5oQbIbNwyNe
         md/6Hn5SVZYUJwGj542aix4+KE1eX8Ww9eWt9nJF/ipnHXvr8R6Aet18Sd+dpM9X8mzX
         NV8hCK1v7beCDMg2RXXcQuzmqYiHhV3lwGPFXFOJT/GA0cKzy2qAuWPPl6vVrUtZYPU4
         ylcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775608577; x=1776213377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n/7HQyrtMfTJW06twOyVYb1ZogrEoRjRGf+zORS6bw=;
        b=C+JUawZuGpJ+S/JC3+NwIKuvjzqT0kP5t1tTzp6xss1ly7PtsnDa5T6+TFVz3Ulka0
         HkEfXFZPKxDaaEvfdSjmSUeSCQ7p/9qc604rPQJse8iot6ypAto4/2P0BfFS9haL/Rpf
         HVbCCPXBq5jVHdXozjhK8ZC+/Kr2cf+pTOYZW8s2iFdr5TU15g1UyHz3i9mUgNYK7HTG
         kiL803MtiEScAeIYh47lLganqZgJQfC6Z8JdDA3G5ShuwMMFy4x6L9dA5I4peoRhmX/9
         gNexUL+qN2gHuRdLNiItEeou7XiL3cQ9entBn3HEbXXCn2QakJAzFEypLkaLmCCu38zD
         mTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608577; x=1776213377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6n/7HQyrtMfTJW06twOyVYb1ZogrEoRjRGf+zORS6bw=;
        b=R+Qeo0WU9dfa4yne90HZiJuMLgv6JTRP9gBDVPtZyD1WZQqkJn6jvri/rLAmiL48IM
         VIpjdHhTFTKsY3avCkKkexgGzRvLXpGQzHKLWa8EztC2KRGlEnebgVc08fr2nLDUcPQX
         qTtgy+4/5bQ73VsOhQiaaXm13WEahkxzMl0y1eUZaySPC1GnQzQ1cRyVWLKO76LXhUif
         c/MPIdiEGOOJ3L3ttq5anlo6uuN/jJPjYgvcar2J9Mj9gCPFoqmfpKEV2oNBLRbF9Gcc
         9CT1h96LLC/qSvBVA2rpte9jxxu5ZlJ5Lr/dNiZY2IyrsDstauNI0iWTOW4oq8N9NmHH
         LYpA==
X-Forwarded-Encrypted: i=1; AJvYcCXUbF0O/KT8TRG+JZXNBNPL6/RBhaBWu4L0e6waPnCjsmp6MMSHdVqdecyhrciJVTLKDOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwvPBTntvitY9qfUFFCXT9drtVJ7kUp7nrYTN3y/Ppni0N8dl
	A4PcZwUEm7mk0ieV4ZYbc5YUzccC/4T2ob54apomCc3hVUwI05wOuL8tBF77zLRewc/ug892wsw
	j8r8AwTVUwVVI5Nkz1c157bUfeCB+yaQ=
X-Gm-Gg: AeBDiesfAOadACgoiMs1mrlN0KFGaatCfgQcHdvtZuXx2KTLGAp7HBOwFCWJHkJA5cQ
	dw6Hh2lRqXffhIARSiyCXXwXdThe8oMaEOIPvdzKvnKXEV12OqtO2xKJgK4dHBAPH6Y1zLWt6gI
	kNPFMT+IlUcQilDA0mzzfvSWy6gLXkkbPIzBTfZp8g6t2L60ICOQStr8JbdtQZiKlYepfZUNMRP
	iGtAUT6jAFeB/6RW1bBb9QBo+5s+qoGdbYYph1af/gePoQYd36/N0vpj5jg8qVW2DAXKv/qcz3V
	aL8duaI=
X-Received: by 2002:a05:6512:3b12:b0:5a1:1daf:f7b2 with SMTP id
 2adb3069b0e04-5a337514f67mr5768921e87.0.1775608576338; Tue, 07 Apr 2026
 17:36:16 -0700 (PDT)
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
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com> <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 8 Apr 2026 08:35:37 +0800
X-Gm-Features: AQROBzCRTd0x9BrsJHcoQc-2sCYrx--jI_bQa6YUl2OGCkGbIENnd0UvF44LYi8
Message-ID: <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:17=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > The patch is the 1/2 part of push-level granularity feature.
> > > > > > >
> > > > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occur=
s even
> > > > > > > though it might not carry the last byte of the sendmsg.
> > > > > > >
> > > > > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > > > > The following steps reproduce this:
> > > > > > > 1) skb A is the current last skb before entering wait_for_spa=
ce process
> > > > > > > 2) tcp_push() pushes A without any tag
> > > > > > > 3) A is transmitted from TCP to driver without putting any sk=
b carrying
> > > > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > > > 4) sk_stream_wait_memory() sleeps for a while and then return=
s with an
> > > > > > >    error code. Note that the socket lock is released.
> > > > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will ju=
mp to(goto)
> > > > > > >    'do_error' label and then 'out' label.
> > > > > > > 7) at this moment, skb A turns out to be the last one in this=
 send
> > > > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opp=
ortunity
> > > > > > >    before the final tcp_push()
> > > > > > > 8) BPF script fails to see any timestamps this time
> > > > > > >
> > > > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  net/ipv4/tcp.c | 4 +++-
> > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > > index c603b90057f6..7d030a11d004 100644
> > > > > > > --- a/net/ipv4/tcp.c
> > > > > > > +++ b/net/ipv4/tcp.c
> > > > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk=
, struct msghdr *msg, size_t size)
> > > > > > >  wait_for_space:
> > > > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > > > >               tcp_remove_empty_skb(sk);
> > > > > > > -             if (copied)
> > > > > > > +             if (copied) {
> > > > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now=
,
> > > > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > > > >
> > > > > > Now the number of skbs that will be tracked will be unpredictab=
le,
> > > > > > varying based on memory pressure.
> > > > >
> > > > > Right, I put some effort into writing a selftests to check how ma=
ny
> > > > > push functions get called at one time and failed to do so.
> > > > >
> > > > > >
> > > > > > That sounds hard to use to me. Especially if these extra pushes
> > > > > > cannot be identified as such.
> > > > > >
> > > > > > Perhaps if all skbs from the same sendmsg call can be identifie=
d,
> > > > > > that would help explain pattern in data resulting from these
> > > > > > uncommon extra data points.
> > > > >
> > > > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That=
 is
> > > > > close to packet basis without considering fragmentation of skb :)
> > > >
> > > > No, I meant somehow in the notification having a way to identify al=
l
> > > > the skbs belonging to the same sendmsg call, to allow filtering on
> > > > that. But I also don't immediately see how to do that (without addi=
ng
> > > > yet another counter say).
> > >
> > > If we don't build the relationship between skb and sendmsg (just like
> > > the SENDMSG sock option), we will have no clue on how to calculate. I=
f
> > > we only take care of the skb from the view of the syscall layer, it's
> > > fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in
> > > terms of per skb even generated beneath TCP due to gso/tso, there is
> > > only one way to correlate: adding an additional member in the skb
> > > structure to store its sendmsg time. This discussion is only suitable
> > > for use cases like net_timestamping.
> > >
> > > Well, my key point is that, I have to admit, the above (including
> > > existing bpf script net_timestamping) is a less effective way which
> > > definitely harms the performance because of the extremely frequent
> > > look-up process. It's not suitable for 7x24 observability in
> > > production. What we've done internally is make the kernel layer as
> > > lightweight/easy as possible and let the timestamping feature throw
> > > each record into a ring buffer that the application can read, sort an=
d
> > > calculate. This arch survives the performance. But that's simply what
> > > the design of the kernel module is, given the fast deployment in
> > > production. I suppose in the future we could build a userspace tool
> > > like blktrace to monitor efficiently instead of the selftest sample.
> > > Honestly I don't like look-up action.
> > >
> > > Since we're modifying the kernel, how about adding a new member to
> > > record sendmsg time which bpf script is able to read. The whole
> > > scenario looks like this:
> > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will ge=
t
> > > a copy of its original skb
> > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > current time, and then effortlessly do the math.
> > >
> > > At this point, what I had in mind is we have two options:
> > > 1) only handle the skb from the view of the send syscall layer, which
> > > is, for sure, very simple but not thorough.
> > > 2) stick to a pure authentic packet basis, then adding a new member
> > > seems inevitable. so the question would be where to add? The space of
> > > the skb structure is very precious :(
> >
> > Finding a suitable place to put this timestamp is really hard. IIRC,
> > we can't expand the size of struct skb_shared_info so easily since
> > it's a global effect.
> >
> > I'm wondering if we can turn the per-packet mode into a non-compatible
> > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > sendmsg.
>
> Agreed that an extra field is hard. We should avoid that.

Avoiding adding a new one makes the whole work extremely hard. I'm
wondering since we have hwtstamp in shared info, why not add a
software one for timestamping use? Then, we would support more
different protocols in more different stages in a finer grain, which
is a big coarse picture in my mind.

Adding a software bit will completely reduce the whole complexity and
be very easy to use. Would you expect to see a draft by adding such a
bit first?

Or just like I mentioned, repurposing tskey seems an alternative,
which, however, makes the new feature incompatible.

>
> If the purpose is to group skbs by sendmsg call (e.g., to filter out
> all but the last one), it is probably also unnecessary.
>
> From a process PoV, since the process knows the sendmsg len and each
> skb has a tskey in byte offset, it can correlate the skb with a given
> sendmsg buffer.
>
> The BPF program is under control of a third-party admin. So that does
> not follow directly. But it can be passed additional metadata.
>
> I thought about passing the offset of the skb from the start of the
> sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> as each new buffer will start with an skb with offset 0 ..
>
> .. but that won't work as there is no guarantee that a sendmsg call
> will not append to an existing outstanding skb.

Right. TCP is way too complex and we indeed see some tough issues when
trying to deploy the feature. So my humble take is to make the design
as simple as possible.

>
> Anyway, the general idea is to pass to the BPF program through
> bpf_skops_tx_timestamping some relevant signal , without having to
> expand either skb or sk itself.
>
> I hear you on that measuring every skb is too frequent. But is calling
> the BPF program and letting it decide whether to measure too? BPF
> program invocation itself should be cheap.

Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
an awesome way to go. My ultimate goal is to do so. Instead of letting
people implement various fine grained bpf progs, we can provide a very
easy/understandable/efficient approach with more samples. It should be
very beneficial.

>
> If per-push is preferable, with a filter ability like the above, it
> seems more useful to me already.

Push-level is a compromise plan. Packet-level is what I always pursue :)

The current series has this ability: the bpf prog noticed it's a
SENDMSG sock option and will selectively call
bpf_sock_ops_enable_tx_tstamp() to do so. Only by calling
bpf_sock_ops_enable_tx_tstamp() could the skb be tracked.

Thanks,
Jason
