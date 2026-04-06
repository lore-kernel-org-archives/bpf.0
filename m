Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E15326928
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476810; cv=pass; b=ezEyUKSjhXfxua3o7EjFOt22nwFgfNRVuUuL1TpzBwE8LEYY/SueiaiCHKLgV/GM2MCNmfDfyu98ORxiqAFsIflgctGTid0dIcwfI6Eef3x+Q2R6NtqMEByY0i8HHDuoLJDLDKjBMEXsT4exdr6mHOpZVbzeMXftnRE9M4mgHT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476810; c=relaxed/simple;
	bh=fcEIZMZ8hJHb+M5FGnQOEit1qBuFU3wayQRg42scuo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBc8exSTF7O45Sj6HH2K4E4jiGabjmIqJbUfcfULirKxhP1008UiclE3pnnTz3ExYmQk5te4KlBAYOIUvDOTCsaU9kvs1k9OiDLBrgfDjpZ0kZWfQfMfQl4AwtXfy0tFpyDvoseojixtkp+u/AKs04JIzei9wfisSvhFP9W/a7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj83SUlP; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj83SUlP"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so4404382e87.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 05:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775476807; cv=none;
        d=google.com; s=arc-20240605;
        b=SPXvMmz95fFYZTa2mj77KQYucvFghoqQSTCV3eGXd5bvAdBF1zVv9wBw4M+X/GxWRh
         ymzhcN/NZXf5n0abqNbiFaU3t5BWYTYiF4HP6lv++ateGGNUp0Q0VS78BcLisSdKnSSk
         jNeO5aBMwCUhTZUeMN4if4gxHDBYinI1FZ6LLguhNpqQAlyGKWGwJ/ix4EnsBD6IA20+
         6d5FrK/dkgUYDuWDzvqvBPg4JZMsl7ycVG2ML8N5nH6Y6cNHbxOS2dpTSLl9cGJaRcpk
         L5K+m5KLOQNkQ4d5aAsLApIn0esfv9TRuhTTUaqxYZvzQw6C6lAsVt+CmlzZXqo12Fr8
         mjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xUzQMuJkHWjZKwmfTvvznTEuXmb9XPZ3i0McRs/Z5mM=;
        fh=T3Ui1lnudRdK4NtmfOWH9nNctdlhnj5W35h7d2S7Bik=;
        b=TM9Gj/R8plbfdZr0cj1NziPc0wnixHlmmmZT58JGDhpC2WcCu3Gc0gdVilnQjN/AFt
         rPm+FTvv5K8rDzADvK70Xd8TtTtSgTbl1OY7O5oZ3bEu3eHUrdXZFqXaWMV1ybFvSe5c
         iHPFSAEFZoKMO9dgroz7Quhlz+FpP+a80ZzrMH2xSBPHVGqPTLijk2NWW4irQxAg67n0
         g2MUOxQL5aZFbiEnZsb9z9HJAVX4ED3lPFLlauo/DhTyPJKA7y9heJ2aqhH5re/3he6X
         lBvnBcQJRZvROnE9iZYjXMsHRuxId/K2rtUJ9azN6umA2aXIm8puMdagSwGmmspv6f8f
         kmvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775476807; x=1776081607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUzQMuJkHWjZKwmfTvvznTEuXmb9XPZ3i0McRs/Z5mM=;
        b=Wj83SUlPex1uBTfA1nOtyIo5Yw/mz51AV3+XO61r1exCSO2Z3GjqrYXvDJpyJBrRPZ
         3sY505RBGWK8bWGQUKAnyVK40Z3irKenrRTJuW5dhFbPam/UjTMN0lVRc2Wd39AcpJ+u
         R69G+3rUhui/SXYmP95ZCbJgrwPc/QvlfMM4xTSWLmVonE5xICAC67NvFbnuoGqgS04N
         vGFHxgrkJc1pxaRgoYbJqwBjIcyb7EGjPV0vVRI4xNNNcjFeSryOgiK7x5ByPVl9chfx
         XVtA7FxU3UF7rLSLXQ6o3+zQMiQdIS74Tz3lQ2xX0Am3z1xwcV0wGO2P88asYhvreOec
         ickw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775476807; x=1776081607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUzQMuJkHWjZKwmfTvvznTEuXmb9XPZ3i0McRs/Z5mM=;
        b=ZcBe/i+1c7h3Pj0XSr2/kgJ1ppZTTrCAgMt07sWW9J4gPUP0RQqtWVrEwq6swSqETL
         hUhEbIw1SPz+3NpDGJt+kUdcM55WMA46ASSUET76MiUC9HxL9u10swXlym94BHje+dWP
         ypC+Q39htYM4CsboDzpSBds6mCLRM7elZWXUoOtM62OXzLGXcmXM4Oi9J1P/hezgvA9u
         k0KmBs1R5bkr+ovbOzypEZ9t7rKk877aFmn6DGF9aCbeZjLH+lP0/2bf3FoF4sKwsfg9
         PMlJryV6dRSSovgsrCBlYfyOR432FRH7e8heUdMYE0TGZvftXomVYk8Cw1YzHPD11YOC
         AWzw==
X-Forwarded-Encrypted: i=1; AJvYcCWnp/vksQPEv89Noc8LBSF9no2i2sZOg/ocGDkw+9QlKXv8ZljsigJ+xk/nLq/kc/9GzrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFUL0bt+fNxhgtqmTfQQ/LDipUxqF1UxXz2/t1mYTLwA+3qg9
	6OYMprbHjL45+vvCrArMFJ0YakxY7bAwsX/CE2dhUgOD5nWEs2BrUJ1k9D4/WH6qu+HS4HYcQGc
	yKKyik85ySS2J3yYcVFba4vjAfvNoJ0kJ7v1gJP9+6g==
X-Gm-Gg: AeBDievMG7h4qluElhLW3hhklwssCYcZevI/ziXPGo0Ceu4tSylRYXd6xxoMnPxB6I6
	nmsDi/yXoBAXqq/dhtCNSyeUAesW6wZSGgXCN3tmKjm9WsryLLPRWHgO+gp6Rqu17VPokdrFjdr
	ZFZi8+IFGJSyDoFyzIggATpTV4xC6fevv5VmCr4VYtn0OVVT0fj4jUFx3VV+Jj8jkER9IBayHfo
	FwpC/y+MLX+pU42evTfQM29ZHLkWzS9NYRxEd8XKtbWOMuHLwFR1Gq5G7tDNgoG8aOV1ndK6pBJ
	oYJZRLM=
X-Received: by 2002:a05:6512:3d92:b0:5a2:bb45:7f21 with SMTP id
 2adb3069b0e04-5a33757c21fmr4613352e87.28.1775476806506; Mon, 06 Apr 2026
 05:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Apr 2026 19:59:28 +0800
X-Gm-Features: AQROBzB3sC5UT6ZJcIRcqKr0kaJV4c5b4kQZPMFgIGiWrxzPe3N-tzGEy0vqdu4
Message-ID: <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The patch is the 1/2 part of push-level granularity feature.
> >
> > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > though it might not carry the last byte of the sendmsg.
> >
> > Prior to the patch, BPF timestamping cannot cover this case:
> > The following steps reproduce this:
> > 1) skb A is the current last skb before entering wait_for_space process
> > 2) tcp_push() pushes A without any tag
> > 3) A is transmitted from TCP to driver without putting any skb carrying
> >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > 4) sk_stream_wait_memory() sleeps for a while and then returns with an
> >    error code. Note that the socket lock is released.
> > 5) skb A finally gets acked and removed from the rtx queue.
> > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto=
)
> >    'do_error' label and then 'out' label.
> > 7) at this moment, skb A turns out to be the last one in this send
> >    syscall, and miss the following tcp_bpf_tx_timestamp() opportunity
> >    before the final tcp_push()
> > 8) BPF script fails to see any timestamps this time
> >
> > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index c603b90057f6..7d030a11d004 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >  wait_for_space:
> >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> >               tcp_remove_empty_skb(sk);
> > -             if (copied)
> > +             if (copied) {
> > +                     tcp_bpf_tx_timestamp(sk);
> >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> >                                TCP_NAGLE_PUSH, size_goal);
>
> Now the number of skbs that will be tracked will be unpredictable,
> varying based on memory pressure.

Right, I put some effort into writing a selftests to check how many
push functions get called at one time and failed to do so.

>
> That sounds hard to use to me. Especially if these extra pushes
> cannot be identified as such.
>
> Perhaps if all skbs from the same sendmsg call can be identified,
> that would help explain pattern in data resulting from these
> uncommon extra data points.

You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
close to packet basis without considering fragmentation of skb :)

Thanks,
Jason
