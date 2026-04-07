Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8830E0ED
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532845; cv=pass; b=gcgQVUa2WwzS0CPIXGls08tzoZ2z95YZGWqovW2cBDVQ4S3djF2X8M8L+fPR8SqYkssVd20PpoOoP2N1LFtbMgyp6cwU5rDnQnvHLDNSh2ZFCSztdn97ZSl5rFnmmH32sRon+YfquUDTB5BY+Z0w7s3nx0OTnreAd3BAj8Tq1G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532845; c=relaxed/simple;
	bh=Yjx0P1FayQ+aswRUqrzahcSgnCpPUXKWDEzX7RCxt+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2l/XsuOaPC4SohPK+o+KBoeRBDoUQAU2oCCB5568qWCdBX/KQrklIqf40Z+9IVzn8K6602289LmK7RcReOQbeAzvS0K8PZs4f+ieFUAdUvAgQ6VlQD0XN8JntcYWsTfx3DLURPXg5RIwET/YZdECR+YPDVrfSYyHbTBFbvwKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/9MC9sH; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/9MC9sH"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2beae348eso5102619e87.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 20:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775532842; cv=none;
        d=google.com; s=arc-20240605;
        b=jniwGdp9qzw2iueovioBfE+JinpRIIBTFc76FejncPBdSy9LfvMOXgQUckoQyT8xhn
         vtj/RzhcUCeHZ1YGaql2MZahSEuYnWuaxII51oNXo5Rbhvh9pcjzmvKtsTRGC8ASyGxG
         JhjQcn/U/uiDiJWrDw9hiYAbOAagZOBdKQERVGwY9s4DRY4T3tJ0Zb4dIGXUdf2w6/5P
         H1RGrPH20czIx3r2a7VkQUuWZ3KArpE8RjeivmMO+BnJNFNZpSGh4vfkhJBq9P14ydd5
         Zi0Acw2WXJ8R5veNOGPufX57xnpkN2ZI1NiH+rWxULJxAzzBdA2C4o2oKPj1K+KG73yY
         3AZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3PNoohLi4ojxQ+BzINYqs8H5aArYT9tOIdlY75O8KU=;
        fh=Ml1Q/d1npucPb4LWuoCFsJ4dcH2z0PP4b44YQKLWZ48=;
        b=c5Nx7Mcpcd9jpSON5DBo0h3KOIR5QIb6SYwdUVSpEmLeL0/E3tz51vBgE1h/MV4QXi
         Eu5/gfU0CL8u7jBM+nf0yNO0VXitqam/VtwE3tzHiw+Z+mkU4ZLWw3Ngm07Ege58sOAE
         Io35/PQhVrUMTR6kr5ZkP/d2w9uSZG0nBhHwWIkcUt9T/66mG0UJwkq7XGstXPey3PGt
         dSllwSWtUTi5etJ9TH2Fk8qglbrepeaFAiopo92R7WkLtwQfXj4Aa8uEcnZ7iMyd00S8
         JaW6InNl2b+G09tpvM21f40b5gE0fEwZMHRCkWgwOsrxOUw0mYnu528PB09DC+hwGPiT
         CzWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775532842; x=1776137642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3PNoohLi4ojxQ+BzINYqs8H5aArYT9tOIdlY75O8KU=;
        b=a/9MC9sHiadUav7bheLILFiODYAk4t/HMampf1dIg7ahKQLyrJceJGSgu85nPNi060
         46TjAQ0YBKTh8IzMKV9v/bHg8y0WlMUFdFbCFmUtiJ8n9Mt0IngWteypHPrLYbqV0CVs
         xVQspp+VkjNEsIYzEPHUR2d8GjIAf8Mz1mK6XJIN5uKdnkIGgUfx7XEKlVcJXx/yMcXQ
         5Qiai6ZF3RK8K9iLj/cTh2KuJrKYeceBWulCLTClOe16phQ8+l3zHST7bJPg4y7+AcFG
         nKAIZOpffgT1YRq+TwpBtThembUlIq+MQotvkiRoOBLvr1K+Ttk3IAk09vb/l9rJAxw/
         fEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532842; x=1776137642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3PNoohLi4ojxQ+BzINYqs8H5aArYT9tOIdlY75O8KU=;
        b=cWdntHxYmaIuZpZVQOL88LVRGzSikFaHs3dsGOXfQJOf+rRde97avYyAgtHjrVzL+l
         sg9+UV2HY1ZPbOjt3ZrXKi+OV5wfF86OVhGKCN2Z9VczrDqgtgC0F3RTExIQAgWYpnUO
         H+JyCIFHqKS+8PJPhkb4Xd8vUz+pXOUCJgBeEbHk3JjKAVyHabl+Y3Wq/Hf9U0Ly/QhT
         wgsh8zQLMfdT0amRmgEihkaxRVDcJjD6lxDpz9TfEN9/Fk7KD/84/89T4uU4yMKHkOWr
         QOfTLhoJ0dog7VUsseJJT+urTyIezQMij64d97bhnkVm6KcMEDfUTZlXGWRyWs5usFQq
         zLwg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Zp+QGbeczwqC9T7uqwkTo4AC2vtYqN5RfD2f/l1+8MlnBygu1t0/CCwgQ5O8KVsoDhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SxmEx6y7sY4GIirZnsL1GLlZ4M9Q2W02DbPVv+T15WEgKZtI
	rYgQEHmjE4SBLuZHeZKMUYWkq90QygMU6XUw7V5Xe9FZj+2QqVOV5V8tJksR4nUxB0VW16MNqft
	0hTqYRrk3/XF8U7Lnxh+Rb8kp7rjY/0U=
X-Gm-Gg: AeBDietlso6KfIKatoWOxSScN8r9CPiSSN07ZaT1vjYbRkXFkQ9SW+0xRdt/pEY0D7R
	4swu25Iv9ZspbasaQMlgCYvOnykxqNP7Nft2IZrXocCBcpb1jcYDgxbuSZj+9gkXrWGdV/3p6TY
	MAnW9DzR6LqAZ8JjZJw+sAfi9U/n6+hkKcc8qURWINYn932w7mk1HNjThv+qyEYBFlgc54ye/x5
	NNJ0OwzTG6NaZTdZe8k944rCC1a2B621c+63ORxpUnxkld53qOgDznJFRpCL1unKzydZkF7lQ3N
	p8EHDes0
X-Received: by 2002:a05:6512:118c:b0:5a2:c742:7a76 with SMTP id
 2adb3069b0e04-5a33759394dmr5793209e87.44.1775532841398; Mon, 06 Apr 2026
 20:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com> <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 7 Apr 2026 11:33:23 +0800
X-Gm-Features: AQROBzCVep2rMbj10HatyLnc1BEUgEJA7ncanO8dNr1X3UBx1xselIpn5iOhKeo
Message-ID: <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The patch is the 1/2 part of push-level granularity feature.
> > > >
> > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > > > though it might not carry the last byte of the sendmsg.
> > > >
> > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > The following steps reproduce this:
> > > > 1) skb A is the current last skb before entering wait_for_space pro=
cess
> > > > 2) tcp_push() pushes A without any tag
> > > > 3) A is transmitted from TCP to driver without putting any skb carr=
ying
> > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > 4) sk_stream_wait_memory() sleeps for a while and then returns with=
 an
> > > >    error code. Note that the socket lock is released.
> > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(=
goto)
> > > >    'do_error' label and then 'out' label.
> > > > 7) at this moment, skb A turns out to be the last one in this send
> > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opportuni=
ty
> > > >    before the final tcp_push()
> > > > 8) BPF script fails to see any timestamps this time
> > > >
> > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index c603b90057f6..7d030a11d004 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t size)
> > > >  wait_for_space:
> > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > >               tcp_remove_empty_skb(sk);
> > > > -             if (copied)
> > > > +             if (copied) {
> > > > +                     tcp_bpf_tx_timestamp(sk);
> > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > > >                                TCP_NAGLE_PUSH, size_goal);
> > >
> > > Now the number of skbs that will be tracked will be unpredictable,
> > > varying based on memory pressure.
> >
> > Right, I put some effort into writing a selftests to check how many
> > push functions get called at one time and failed to do so.
> >
> > >
> > > That sounds hard to use to me. Especially if these extra pushes
> > > cannot be identified as such.
> > >
> > > Perhaps if all skbs from the same sendmsg call can be identified,
> > > that would help explain pattern in data resulting from these
> > > uncommon extra data points.
> >
> > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
> > close to packet basis without considering fragmentation of skb :)
>
> No, I meant somehow in the notification having a way to identify all
> the skbs belonging to the same sendmsg call, to allow filtering on
> that. But I also don't immediately see how to do that (without adding
> yet another counter say).

If we don't build the relationship between skb and sendmsg (just like
the SENDMSG sock option), we will have no clue on how to calculate. If
we only take care of the skb from the view of the syscall layer, it's
fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in
terms of per skb even generated beneath TCP due to gso/tso, there is
only one way to correlate: adding an additional member in the skb
structure to store its sendmsg time. This discussion is only suitable
for use cases like net_timestamping.

Well, my key point is that, I have to admit, the above (including
existing bpf script net_timestamping) is a less effective way which
definitely harms the performance because of the extremely frequent
look-up process. It's not suitable for 7x24 observability in
production. What we've done internally is make the kernel layer as
lightweight/easy as possible and let the timestamping feature throw
each record into a ring buffer that the application can read, sort and
calculate. This arch survives the performance. But that's simply what
the design of the kernel module is, given the fast deployment in
production. I suppose in the future we could build a userspace tool
like blktrace to monitor efficiently instead of the selftest sample.
Honestly I don't like look-up action.

Since we're modifying the kernel, how about adding a new member to
record sendmsg time which bpf script is able to read. The whole
scenario looks like this:
1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will get
a copy of its original skb
3) in each stage, bpf script reads the skb's sendmsg time and the
current time, and then effortlessly do the math.

At this point, what I had in mind is we have two options:
1) only handle the skb from the view of the send syscall layer, which
is, for sure, very simple but not thorough.
2) stick to a pure authentic packet basis, then adding a new member
seems inevitable. so the question would be where to add? The space of
the skb structure is very precious :(

>
> Right now, push-based seems rather arbitrary to me, informed more by
> technical limitations than a clear design. Perhaps per-packet makes
> more sense, esp. since BPF calls are cheap (compared to the other
> errqueue mechanism).

Agreed.

Thanks,
Jason
