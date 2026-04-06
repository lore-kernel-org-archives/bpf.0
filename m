Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6327381B0C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486283; cv=none; b=We10XOojvLg04RwcoWZPd9tY4FE6Jq/FnYHI0l6lZCToDb4/3LJXoDruFBJzmhOPF/xfgTMVniGIZdmjady7vELz68o4Rexevv6hYG+g3c/wxUpWJC4ofeVkGL2CPXCFoa0DiPIi08GR6nuvgbt6eA4IYjwlJrKiVfQL0Jw2rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486283; c=relaxed/simple;
	bh=GJ0RW2irJ6kcELwmCqa4ZzK3ti6Qayrvc3Dfceb+uO0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eGHAcb4SBVvaXJWxLfXbtJoR3830ry2urp+Vr8vRvI0t9JDZZ8H7pIbTPHiFr8KgkWXh0aS8q/7pxKAFdUssLL+S8q+BenqLIMGd9u3vpdVHn9BLFTO+BNwozrWv0TuGc3aKoJqz32WACjrpgXFu1IY8wuItSOnvcdjc43KM7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JILDSpyg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JILDSpyg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79db5e18ac6so43896287b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775486279; x=1776091079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFDVgCinty+f10gqXM3FVX6dOkEjy/NrsNcBhghN+XE=;
        b=JILDSpygQxmw1lDrjKhQE2L7MmMjSyiVnH7Sfta0FX8+ZN12GKuku9qS6bSca8PYWG
         E4ArerLFGy638ZNqL5oBRmmTq6F8ki2sGU4j+dwg8iTWIu8o+rQMM9nsZOFeRh3vh9Cn
         HzuhVORghtaUsuxqxA0zzX4NStf0+lusB5kXe5kEA+/r1K19/G5BFoK2Z54K1kO6k4uV
         ArzvmTJgylNpLEWDA8aukhgzi1uRaxvpvyqn+r1mRJuQsq13fQtE/m2e3ImKOh8yrPDu
         ZihUGisdsOMDyFeRC7e4sqffHm3gAEUVKEdSvtYH6bCEsDbJzECJxWoc05QwBqVYTlS4
         sN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486279; x=1776091079;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFDVgCinty+f10gqXM3FVX6dOkEjy/NrsNcBhghN+XE=;
        b=B/7dRrM2+DaHpvulO6eU877NdVrR8HPjM8qpNKQ/3F54Lr6WHhR7AGFwHxG5hNOyb/
         RnvZ3DaqCSR63Pv7e4OvkAlAuB2bTJu1YAr6apebEDpOZRlMwnSOR5lkW5RLx9+x/kpP
         XLEgMZLYNTJe0TdvA3ywwqQCEbhnP7pnKnHnLotXo5uQH7eWCIWb4jOngL+ZfkzZbon3
         DZfjhVMZ9MPUd20worDHZr0my4vt9Y3+Eehn5qZ/aYjWWU2bia16FMReh2VfQNB2eY8r
         Mw4e3qkm7hcstHx1I2vcnkqRAznZBOBI2XCgLyY+GutI8KTlJI+33tqeSyjJE+S34Q4I
         R1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7v9GfbeqSBgsengqyGOWeT5xFLnudMg2+EzwJYU9R0vM+/g/5pR882yCIjutORSwEruo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwesLCPx8o7IKRrWUvigCgPk4zwNTLE3xoENG/vEKyB74+692
	zTpq5ReDZOkwmoBCN4RLL0jxg677JeskBwPfVXXhSlqO1XrNIZoOAOHh
X-Gm-Gg: AeBDiev7nzZWXhZt34UtUqY1EqVjz1GFzvjWqIuQdXiYB7DdhIsqOKzYIdVkH7T4nmA
	dgsfAXYh7pjFVNlBNbu0pwtSUCy2S4BwtUstykOyASRDC5FSZUNwU9qYgSaAbMLpcNgkuQGxf5H
	ay7otcE+aJHTs1P81F28BepUWPW4htMo4JiImSZyQ6J461/Cd9loF0UcdrGWGiKnbGRAMWRpS84
	hds/mGgBCP4iqsLJ/3aQcdp71VsmIg7tkx1c/FgxiCL2zz5JNNtUazV/G1qKeIe96euGZ0lZPFk
	I0Wig4FGJXmfC++3qvmDV7nAJcIXRQhwbrs737WP5lW9aumBoK5vk6RofDyHARI7S3mE40TmCg1
	2zAn4+8XR8y4eeeud790K7LPdVb/GW0v+LlxRg8clQxBu4zrjUDqroYLhI7dfwLXu+fvdNzugNr
	YWLQBtpCLoxpQpXyghJXtNDkD1+u7Je8orAkX/FmVSDQTWaUS5ZGrQOtXWIZvA6PrDCCeSCOeYV
	stT
X-Received: by 2002:a05:690c:3481:b0:79b:e24e:e308 with SMTP id 00721157ae682-7a3bc106b46mr129094537b3.8.1775486278637;
        Mon, 06 Apr 2026 07:37:58 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a83adc3sm6144992d50.5.2026.04.06.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:37:58 -0700 (PDT)
Date: Mon, 06 Apr 2026 10:37:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
In-Reply-To: <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The patch is the 1/2 part of push-level granularity feature.
> > >
> > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even=

> > > though it might not carry the last byte of the sendmsg.
> > >
> > > Prior to the patch, BPF timestamping cannot cover this case:
> > > The following steps reproduce this:
> > > 1) skb A is the current last skb before entering wait_for_space pro=
cess
> > > 2) tcp_push() pushes A without any tag
> > > 3) A is transmitted from TCP to driver without putting any skb carr=
ying
> > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > 4) sk_stream_wait_memory() sleeps for a while and then returns with=
 an
> > >    error code. Note that the socket lock is released.
> > > 5) skb A finally gets acked and removed from the rtx queue.
> > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(=
goto)
> > >    'do_error' label and then 'out' label.
> > > 7) at this moment, skb A turns out to be the last one in this send
> > >    syscall, and miss the following tcp_bpf_tx_timestamp() opportuni=
ty
> > >    before the final tcp_push()
> > > 8) BPF script fails to see any timestamps this time
> > >
> > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index c603b90057f6..7d030a11d004 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t size)
> > >  wait_for_space:
> > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > >               tcp_remove_empty_skb(sk);
> > > -             if (copied)
> > > +             if (copied) {
> > > +                     tcp_bpf_tx_timestamp(sk);
> > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > >                                TCP_NAGLE_PUSH, size_goal);
> >
> > Now the number of skbs that will be tracked will be unpredictable,
> > varying based on memory pressure.
> =

> Right, I put some effort into writing a selftests to check how many
> push functions get called at one time and failed to do so.
> =

> >
> > That sounds hard to use to me. Especially if these extra pushes
> > cannot be identified as such.
> >
> > Perhaps if all skbs from the same sendmsg call can be identified,
> > that would help explain pattern in data resulting from these
> > uncommon extra data points.
> =

> You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
> close to packet basis without considering fragmentation of skb :)

No, I meant somehow in the notification having a way to identify all
the skbs belonging to the same sendmsg call, to allow filtering on
that. But I also don't immediately see how to do that (without adding
yet another counter say).

Right now, push-based seems rather arbitrary to me, informed more by
technical limitations than a clear design. Perhaps per-packet makes
more sense, esp. since BPF calls are cheap (compared to the other
errqueue mechanism).

