Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6C3A1E6C
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547826; cv=pass; b=jDMtL8j4x1LdwIUWmptAnT6qnSKqLo0+xr4WFWRYCDQT10hOTCyBC1WiXMeQpgXgtNycRinHS8RgL5VDPcHTNtqL4UP7GWSwH0FHx2W0jTYY+EQmglH0/5LulMn6pL03pauxTFxskUOVc5M5peMJ44eV6CcrEGbhjPdsIA/gDvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547826; c=relaxed/simple;
	bh=KqABs7Z6fJms9Jugr+QlGVltcIlIw0JtZB8PES8chgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7PCJGgYHlGwQMSzCzlBtq89HOdyvp/rgEwdWVUWw9YGjWZh6YjWayLGraWFLAM82hnReAzp7vw0rZea7eLAxY4tfDHYcu+hMqM6YXwCl7o2JE+pHjHgrKNIOBOcl7D9lSMtT3n2Vy09/gh8FkSWKw8StPotUkW5skFwpvWBbQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3L7/sM9; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3L7/sM9"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2b636b944so4891020e87.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 00:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775547823; cv=none;
        d=google.com; s=arc-20240605;
        b=A33E6N8mZ0jg5P+KQ/Y7rNu1KP+M1Ei9fyq34B7ojCqX1Zas4BWkbvqsbzQKFu4WwP
         26MH3T3lBTRekscE/4WVCv4+5YpKDDg1K8kdYY/kOUzvaFGoa68XGO15LE/3SBYfFY9A
         0dRpfAIb8i4qp2bvW/ZofZMF9egdH3XqH/a1mJNWOGWDKTmtPL5eaMTYGtid2rXD6XX/
         JlCYO+oPik7blK4rANuMn9Ih+9x8TGpUhUYmepZyB889puXpMMo/Mqs76H2CdiUadFB2
         eImzTkZa1xI99ZurMZfsUWdt3A4+ItZ9msR/uXRSAmDohq7TfeaX1flxZDmLR4XXnFFP
         5z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFx/0pjhy5NqBlYulyKM1FZvRqnlbThaSkwZhZnF+W8=;
        fh=RDdA8pYLKANJDzpVLYbjgRVVPpUOOLynSRk+1OgSV5s=;
        b=XkbNPDGY4NN5I6TMP43a+eXmCLAoWZZI4speR3aeSG/NTNbWEjOcGJITnnxOzQ7sWJ
         uzPHviBnjOzpZSHPiXTf6c6x62jPK0g5mbTVIGN6cVCvMbCrEw7x9Z+8FyniwWxK6bc0
         O4JHCqs07C5pPZjW3jli3v1jB2g/FegOwBvhb/VPi1Vn/eVo1+4ipYfW9/jOjLFPazp4
         XRRAxp9U/hteaJ5rXnSDpoBrJ3/q+o8efn4NaUPuhP/coLbI8S6vwtJs/DY0VFYmMeCu
         LlUWEfuMEI8S//b1WBFiuf6XjSn5px2vUd5j6kErKwCJktzkb3PYHc7mm8c7JzB9K4Ux
         ZdLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775547823; x=1776152623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFx/0pjhy5NqBlYulyKM1FZvRqnlbThaSkwZhZnF+W8=;
        b=d3L7/sM9pkI7kzNZAMuiSG/xxfFact7FqSnQj1/tJpAEozkPriUsFVV1R05T5v+o07
         lI2lsFPMKjg8u8Nc1r8TBEx2RtDXvZCUYKfQtb5YDKMwAEiHnkvrz7vNqA11XKzCccF+
         SRWfs1iwrZMJY5GpdIi4wWLlPJd8bpYkXCmQ+kNmM+5lO8+Jlnk8ymdTCJY/Tbm/un9u
         J/tethsJwGfGowKmAsSCXfNSfPMJH67WdyBp05p5Azc39YfMaUjYz5lLO/6bNOqDxfL5
         l3knkuS9xhr8g+hZY1/akbZJVHXqZny9cjZ6R2DajkYVSJ9IIU8dxRedFFQEA2OAIT7h
         ep5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775547823; x=1776152623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFx/0pjhy5NqBlYulyKM1FZvRqnlbThaSkwZhZnF+W8=;
        b=s4DJbc/MRVHKHmkZ4fH0OgsoFiGiILTNQZR8fYmz6kLGMzwZuzguW0URvlRtkzKOgI
         MiXAdZjfGVhgAw4MjiaDccU6LlWf7nSqqeJ0Oze6cdQB6N6ey0qQ9dNKDpKTJ6WZRSE8
         fT78SVhvTToInilsrcPgWsbAZRSBrz7uur7fG0aU/MuQNeFBWZyYcT+JR+9CWyD+TRXm
         Vg1BAZeJPQYd5hTZdRckIn58ewscGztP0sOoG4B8ab8cnSfPeozARG9+xiv3V+0iuZoe
         fKQDfJ83QmNNT1rmUgdA8sAKLPz+or+lqlzWp4tcQ9D4y00K0dhOCzd2LdSouR7DZbu2
         zSOg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+OiK89M66EyWXZTujy76NArnV2ZLycYmTonNUm7taRd+RX2dPHnqhUiL6a4eS0rbPFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7NNRinrbETUEpzHeChYX7NL5kNnW9YwA+3JL9I7/6842/WZw
	NI6tsDdCV4YptVCE7ztFdOFKVo6ng6nafRHclNcU78CLx1jC0gKSxDlSByDG9B2AMzWp7q3hbP4
	XVOX3h5ZhJjYjqWhBt3Cs04Kia1aOTdE=
X-Gm-Gg: AeBDieu0pcDTZ9j+mgCyM2tGz+zEIUa8ni0JQQxcSPLfKz511fBlxExllI7FTnjH6Gr
	7Nb8Mx/xKGyQ1L7niIxRPax+dQD+C5zmwWaNPf+ZkURvor3hPQ5RweZeSN4NDVjsmLsM5uXJ5X3
	Nnpwfft5M3bJxVSg0wLnx6itPTvytEItRUTM05ocBaNfGZ6XQBhYAe2qa81B2mJfj0WrQfv+HDb
	DShcPdWFhFr7S4yYiwTqAsE2gctk4xDFvdddG7EZQHK36YDXRZaofvwEv3F9OSOLYoKnHdaQs7p
	GgyOtZxE
X-Received: by 2002:a05:6512:3d0e:b0:5a2:a5f6:dfce with SMTP id
 2adb3069b0e04-5a337556becmr6028363e87.11.1775547822201; Tue, 07 Apr 2026
 00:43:42 -0700 (PDT)
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
In-Reply-To: <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 7 Apr 2026 15:43:04 +0800
X-Gm-Features: AQROBzDvPxkvcwVC5KfAZvN--TaHv5-V1B-Pjsm3w69-IUAhNtf68jhyOZx-lOc
Message-ID: <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The patch is the 1/2 part of push-level granularity feature.
> > > > >
> > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs ev=
en
> > > > > though it might not carry the last byte of the sendmsg.
> > > > >
> > > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > > The following steps reproduce this:
> > > > > 1) skb A is the current last skb before entering wait_for_space p=
rocess
> > > > > 2) tcp_push() pushes A without any tag
> > > > > 3) A is transmitted from TCP to driver without putting any skb ca=
rrying
> > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > 4) sk_stream_wait_memory() sleeps for a while and then returns wi=
th an
> > > > >    error code. Note that the socket lock is released.
> > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump t=
o(goto)
> > > > >    'do_error' label and then 'out' label.
> > > > > 7) at this moment, skb A turns out to be the last one in this sen=
d
> > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opportu=
nity
> > > > >    before the final tcp_push()
> > > > > 8) BPF script fails to see any timestamps this time
> > > > >
> > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/ipv4/tcp.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > index c603b90057f6..7d030a11d004 100644
> > > > > --- a/net/ipv4/tcp.c
> > > > > +++ b/net/ipv4/tcp.c
> > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t size)
> > > > >  wait_for_space:
> > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > >               tcp_remove_empty_skb(sk);
> > > > > -             if (copied)
> > > > > +             if (copied) {
> > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > >
> > > > Now the number of skbs that will be tracked will be unpredictable,
> > > > varying based on memory pressure.
> > >
> > > Right, I put some effort into writing a selftests to check how many
> > > push functions get called at one time and failed to do so.
> > >
> > > >
> > > > That sounds hard to use to me. Especially if these extra pushes
> > > > cannot be identified as such.
> > > >
> > > > Perhaps if all skbs from the same sendmsg call can be identified,
> > > > that would help explain pattern in data resulting from these
> > > > uncommon extra data points.
> > >
> > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
> > > close to packet basis without considering fragmentation of skb :)
> >
> > No, I meant somehow in the notification having a way to identify all
> > the skbs belonging to the same sendmsg call, to allow filtering on
> > that. But I also don't immediately see how to do that (without adding
> > yet another counter say).
>
> If we don't build the relationship between skb and sendmsg (just like
> the SENDMSG sock option), we will have no clue on how to calculate. If
> we only take care of the skb from the view of the syscall layer, it's
> fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in
> terms of per skb even generated beneath TCP due to gso/tso, there is
> only one way to correlate: adding an additional member in the skb
> structure to store its sendmsg time. This discussion is only suitable
> for use cases like net_timestamping.
>
> Well, my key point is that, I have to admit, the above (including
> existing bpf script net_timestamping) is a less effective way which
> definitely harms the performance because of the extremely frequent
> look-up process. It's not suitable for 7x24 observability in
> production. What we've done internally is make the kernel layer as
> lightweight/easy as possible and let the timestamping feature throw
> each record into a ring buffer that the application can read, sort and
> calculate. This arch survives the performance. But that's simply what
> the design of the kernel module is, given the fast deployment in
> production. I suppose in the future we could build a userspace tool
> like blktrace to monitor efficiently instead of the selftest sample.
> Honestly I don't like look-up action.
>
> Since we're modifying the kernel, how about adding a new member to
> record sendmsg time which bpf script is able to read. The whole
> scenario looks like this:
> 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will get
> a copy of its original skb
> 3) in each stage, bpf script reads the skb's sendmsg time and the
> current time, and then effortlessly do the math.
>
> At this point, what I had in mind is we have two options:
> 1) only handle the skb from the view of the send syscall layer, which
> is, for sure, very simple but not thorough.
> 2) stick to a pure authentic packet basis, then adding a new member
> seems inevitable. so the question would be where to add? The space of
> the skb structure is very precious :(

Finding a suitable place to put this timestamp is really hard. IIRC,
we can't expand the size of struct skb_shared_info so easily since
it's a global effect.

I'm wondering if we can turn the per-packet mode into a non-compatible
feature by reusing 'u32 tskey' to store a microsecond timestamp of
sendmsg.

Thanks,
Jason
