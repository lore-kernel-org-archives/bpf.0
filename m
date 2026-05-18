Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFE2773D8
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146685; cv=pass; b=O1mLW15k0z0fxB3Uz3k4iCPUhN5KTV99Pp5ajpSQ0NRw0lqPQfFh9XNWDxOhwkbKwA3175h5Msms/S7SfmGs0xDWq8xOj9xZ4jJXWN9QBjgSpGP7uZQH599D0a1zvgcYnPVjkKlAYZXYRPyGHkToFevBQoOZ8YT88lKT3vJyacQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146685; c=relaxed/simple;
	bh=VipnUx2jbHvuaNIPNdTFNiq04JRHrsVUhe4G9NZFzfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eot/9LCCEVeV3omCw1hP1lNQ/kcYOH34LS4IFzWMPR8Z5lsf1fZTaqNqUVQACO2q3c613bqw0lGIUrqO7YScT/jM/YW/E1ps6f4Q9eYufDBeIGcPdhV8rjpwC4idi/vSHI7Jzg8ofta1a3Cqed74f09KPKsOT6EjvipDmik34pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h358LR2F; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h358LR2F"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8fbe18b1dso4817550e87.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146681; cv=none;
        d=google.com; s=arc-20240605;
        b=aodrE+yyUsGjPWMUAaT0nKb/8aZGDxkkOd7lq/J8hGOe5/50SXtu6IdDxRJiyuORfd
         A8rJT6QhyI5dspu5t/6ur8x0TWDF3zoqw7ErAdUUr70Dqhs/HjdF7eCeCq2uwLqnlKSU
         TpBWhL85BGRuMIs3d1Rz6c80mg9WDquRO8e200UKcN4iKY8SWbExEOsUnZAWO3G/S3Lu
         MNMRJh47G3Fbf+PuT/MlWWK6QI2pC3VH+t7n7jDPFq9VWtQPRFjfyjU5Mpd+MWxQ933+
         Xpxji+SwhQXbPzb/n4k7nKWs9S24E/8Bndo8G+5yMbBy90VOg0O4pTYUyLbYIjn7R87p
         B7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OeHXD4ikgoMy/aJKrVC9XPIi5iwc8fhLQ8mqvzdVSo8=;
        fh=IQa5J3ImpgMHzw+e4Q5T7nSYLkUQmAswXG8vI7TsSLE=;
        b=G0p/zLOMzNmX9fvp928IXClGOpjerCAlrlfem8/eXhDujriNGFZzKHVr5j5TRPLRe4
         tH12iw4JA2oNV0JMVE2xRXJDsjh0tENKNqQ7EtKFg/azKuLG0YfvwjLxqqccHqWkfFsr
         OFt81SmUUxsa8ph2ut5K1iBtqFx5FtaetT4PGYi6+Y7qufKdpSrczGPVDtsb4ltvTH4t
         7Qxkw9nUuhzegwpJTOALDQvvcvMruk/98qtLs2/7GLqxqV03Iu6e3VIiUwd7UeKss8rV
         5bZoxtxDMP8fhp5dwpvAUrUJjKEWBcIWWB+yExsfJdrdDRa79o3J+QEOFtInCGnlsXJe
         fLkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146681; x=1779751481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeHXD4ikgoMy/aJKrVC9XPIi5iwc8fhLQ8mqvzdVSo8=;
        b=h358LR2F8RmXNFEEBwBB1Vuc0F7qHtOp2XK6B9WNBUtK4ToDKJhaRW+jfnFJbMvsqV
         aMPC9ws6p0QBoJLO5dGwMHY7a4n/Vt49FNu619Xd2JYsdSHoA7m8qm2h+5lD48JY19hE
         zZ1kmtyHAQuOgMPuPIDP912iUUuWHoRxIM+ZSabKMbqPYFADGaDKZvrG/UvgQlxqR1Lm
         KHCL4cZMarpzoDg4kOMHFyH1brK9CWqLpvfaXemmPI5r7YEpshtxdtBmQjFmplrtAAoZ
         g4Vr38cLr5HkVRnJxCFzdJX3mTHnVhMRzFft7URD1E5O2cWa9VtRSZdfhzCvVMw7j60G
         tNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146681; x=1779751481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeHXD4ikgoMy/aJKrVC9XPIi5iwc8fhLQ8mqvzdVSo8=;
        b=Cn9m32KCXW4N9PTgOlXVOL1CHuyRzZR3WI+adbvrkpIz+pI8/XZ9DgPdDL/oRCBG7t
         WZMWOYi6GVpd9sT6eO0ny0cTWB7RsJG90GHA9eVOnHg2CeuH8OKKAeQI7Z+N1nv/1u0I
         L35mzoHAkqyrB3UBqM6izI7/aW9Ksm0+kTaYA2QmYl3j6TzjCyHdpd26qndEIbXGBQOR
         sbSNMxZ1SW7id+EWDa+PNJoF5/8Wa8CZcCUG/544hYWVkAATb0idBDA9wGvbTIss9xQH
         CC9lFXLj6+IEfPZH0emPhh+m+ju2Ka63Kt4vnnU45O1hCqwbYHBGAQ/XIXlGFLU5380s
         tF4g==
X-Forwarded-Encrypted: i=1; AFNElJ+4pkB+wd5T20h1xU7KucW8Vjn3lxE+4Z51V0QrEs4XeHOJBTJz8FEpmZ1GqgVOLj2MKjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxgXTI5L5l9UCzlwKrJxm6Ff95EgbNJBinnAaKvMWCMidRG7I
	sZlolifT94BpJD8/1AurPR9D3cEU5tG5g5+bC5mQsEJS5BRXGhG/rYMwMLNn8JJ/ToiKlRI+GNK
	18phqzR2uJIChOmNgccdNCOX47Ia1QtQ=
X-Gm-Gg: Acq92OGfYvidrIdw4FnqQTBO/T4yG8VthJT0cgPQukIZKptlxVCWzMCg/7GJ4C6IgSD
	8KrTgoel22OCuOfBhwnBOl5pRAoX3EPpKUtEDX/TFCjp2uIt/wx2Ip5joa8Y0KqxQmt1PqUUO7z
	CMUUHewLZHacy4LMBNVZgRy93Ffj3H3+i2CWTT1q5L7UjaMKFeoph3JuKuKAlR3CdO6C4ObeIZ0
	NvR6fj7ZQz9P00tEAKuYu8n2JjhUJu5sFYbsTCi0weNsKyJX7zfQjpOirIuJnr0Nwf6hGFhvn2/
	yussjbWL598/Fgkwzzat54w9zZwOxbKlWrtsbeM=
X-Received: by 2002:a05:6512:1595:b0:5a8:97d7:8c30 with SMTP id
 2adb3069b0e04-5aa0e774304mr4904749e87.40.1779146681318; Mon, 18 May 2026
 16:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
 <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
 <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org> <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 07:24:02 +0800
X-Gm-Features: AVHnY4LVZc-R1yRP9brSbuATWXMCmOVNYnH1xgIPBcAKlQwo6Wb-k_4Gwm8CFHk
Message-ID: <CAL+tcoA_VBcXu_2zVXFvsWF7+U=-TZf7bCz0KzNpN=p=82tB=w@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 7:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, May 19, 2026 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >
> >
> >
> > On 18/05/2026 15.53, Jason Xing wrote:
> > > On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <hawk@=
kernel.org> wrote:
> > >>
> > >>
> > >>
> > >> On 18/05/2026 10.23, Jason Xing wrote:
> > >>> From: Jason Xing <kernelxing@tencent.com>
> > >>>
> > >>> Add two if statements to accurately isolate bpf timestamping and so
> > >>> timestamping. They can work respectively.
> > >>>
> > >>> As to so_timestamping, only add a loose condition via report flags
> > >>> to avoid duplicate strict checks that is done in tcp_recv_timestamp=
()
> > >>> and performance impact. If the loose condition is hit,
> > >>> tcp_recv_timestamp() is able to handle the exact case and doesn't
> > >>> hamper the existing timestamping feature.
> > >>>
> > >>> Make it work in TCP protocol.
> > >>>
> > >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >>> ---
> > >>>    net/ipv4/tcp.c | 14 ++++++++++++--
> > >>>    1 file changed, 12 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > >>> index 21ece4c71612..64c69bb3578a 100644
> > >>> --- a/net/ipv4/tcp.c
> > >>> +++ b/net/ipv4/tcp.c
> > >>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len, int flags)
> > >>>        release_sock(sk);
> > >>>
> > >>>        if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > >>> -             if (cmsg_flags & TCP_CMSG_TS)
> > >>> -                     tcp_recv_timestamp(msg, sk, &tss);
> > >>> +             if (cmsg_flags & TCP_CMSG_TS) {
> > >>> +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > >>> +
> > >>> +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > >>> +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIME=
STAMPING))
> > >>> +                             bpf_skops_rx_timestamping(sk, &tss,
> > >>> +                                                       BPF_SOCK_OP=
S_TSTAMP_RCV_CB);
> > >>
> > >> Does this mean I can enable timestamp reading per cgroup?
> > >
> > > Yes, I think so, but I didn't try. One of the natures of sockopt
> > > feature is supporting cgroup attach.
> > > cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
> > > something that you're looking for.
> > >
> >
> > Sound good
> >
> > > IIUC, you can attach the prog onto the cgroup where all the sockets
> > > are set using the bpf timestamping function. So the current impl is
> > > cleaner and has better isolation (to filter out those unmatched
> > > flows).
> > >
> > >>
> > >> In Simon's netstacklat[1] tool we are forced process all RX timestam=
p
> > >> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2=
] on
> > >> the cgroup IDs that we are interested in (which is a significant
> > >> overhead, as this is deployed at Cloudflare production scale).
> > >
> > > I can feel the pain when filtering in this kind of relatively hot
> > > path, which is what I'm trying to avoid internally. What I've done in
> > > production (to cover those old kernels) is to just let the kernel
> > > print the information, that's it, and there is an agent continuously
> > > gathering the data, doing the match and computing latency. But it's
> > > overall complicated.
> > >
> >
> > I hope you don't mean your internal/old approach was using printk and
> > then analyzing this data.
>
> Of course not :)
>
> The internal approach is to cover the old kernels but doesn't mean the
> approach is old :P
>
> Instead, the internal kernel module is super efficient and I'm trying
> to ship bpf with such an ability. The fact is we've already deployed
> in production: 7x24 running, zero sampling.
>
> Please see page 24 where there is a brief introduction on how to deal
> with the log part:
> https://lpc.events/event/19/contributions/2055/#preview:3846
> I believe this is the promising direction (ring buffer + lightweight
> kernel + heavy agent) we're taking.
>
> The headache part is that I need to provide an agent written in BPF to
> do the heavy process.
>
> >
> > > Many thanks here, I'm always interested in hearing more useful and
> > > real requirements and fancy ideas on how to monitor the latency :) No=
w
> >
> > Simon Sundberg <Simon.Sundberg@kau.se> have many more fancy ideas on ho=
w
> > to monitor the latency.
> > The netstacklat tool is part of Simon's PhD thesis:
> > - https://doi.org/10.59217/qklv6836
> >
> > And we even gotten a paper accepted on netstacklat:
> > -
> > https://kau.diva-portal.org/smash/record.jsf?pid=3Ddiva2%3A2034009&dswi=
d=3D3032
>
> Sorry, I cannot access this link. Could you give me the title of this pap=
er?

Waiting at the Front Door - Continuous Monitoring of Latency in the
Host Network Stack

Oh, I guess it hasn't been officially published right? This is the
reason why I have no way to know the content.

Thanks,
Jason

>
> >
> >
> > > I'm still struggling to port the internal functions to bpf
> > > timestamping.
> > >
> >
> > Good luck, feel free to get inspired by our netstacklat tool.
> > Key point is to let BPF store latency histograms and then let userspace
> > periodically consume these - as heatmaps.
>
> Thanks. I'll dig deeper into it.
>
> >
> > We are proposing to add 'netstacklat' as a new libbpf-tools utility
> > - https://github.com/iovisor/bcc/issues/5510
>
> Great!
>
> Thanks,
> Jason
>
> >
> >
> > >>
> > >>
> > >> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstackla=
t
> > >>
> > >> [2]
> > >> https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/ne=
tstacklat.bpf.c#L484-L488
> > >>
> > >>
> > >>> +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > >>> +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> > >>> +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> > >>> +                             tcp_recv_timestamp(msg, sk, &tss);
> > >>> +             }
> > >>>                if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) =
{
> > >>>                        msg->msg_inq =3D tcp_inq_hint(sk);
> > >>>                        if (cmsg_flags & TCP_CMSG_INQ)
> > >>
> >
