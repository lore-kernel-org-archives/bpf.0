Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805133C06
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392712; cv=pass; b=Jl2qsLuMIDvD0NUU1eSOdnkfv0Fsm4icajrhOw3UCvBj4/V3aZvYOF7di6vE2q4Jo+br4BaqOIReBxT62Q2yPVxnJH+8jb70NRfoXDbXvdOTgE9uqoos8jxbNEy6+g0/c0AoamJp66/RouxdT7Lk1/yVRok5Z7j3ThDWK3olGmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392712; c=relaxed/simple;
	bh=ZR6CRlm+kjUynyI/TJRUEnDkvMkUBO9Ysvtfa/jLYNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyEFMA0Z18QSDOqWgjAm0XKjCUWplj3HIgd8qrgE8XVpjtxNm7VQ2TStY6g47pS3VMUf+5l+RcPB3fn9t4CKQesJuG1MBsi9oZet0ruQhLveasLzZz8ja3rOjsB8UAk1CKo1/XUGD5F5pzGq9aF4AS2jGh9M6cdAIVKd2E8cd5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1RVJlSe; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1RVJlSe"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1384ebe7a10so1864951c88.1
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 16:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781392711; cv=none;
        d=google.com; s=arc-20240605;
        b=QReUX0H9ZaVyNydRs8TRG7v9sGITqcPAUfw9/cOvy1xqL2T+6udhCr2gGr85Naz6eh
         GBcNdMQ8g8yG86VC+82rRvqux/ACENHckiHR0TLiIshcrie1iicbqYFk2KuYH+o7Rfog
         Abi+L3ZECdI0KQddxUoo478mA4f6tEzJ54oBD8Ldaz/kcePM3+6xAySUHukOralq1Jvm
         4owZcHjMVS/kdQd9vpQyphxS84ZLVMWvhWAzYXhq52wTginmTmKMcdO9tiiaMDMKFNOQ
         8I1mu4bKNC6W+Orp4FEzCxLJpOAI96Rnyf5ybVvsMLF9/d1x9p04DLoVioG5nYYupZrz
         Z6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrh3mtw21uDqAv+fInBxgdwwmlvcEY/ppShhIMRJqV8=;
        fh=5gVUz/RD0ySsunI1KsYGqL+IetUOkkDDN767WQP5vtM=;
        b=GYoDQlPrXFBiXKlt8OhXPxSDb1ngebnllLa02aWY/16jMxI+9CuzmtSXvfXhG6m8jU
         ChpHRl7HF8+D91iGjRfQnYig7BGDZyYLl8NPpyss2gT+7tmANWU8kHFPt5LHZAARuQt3
         C4cmp6Ydndn2kOH/c9/gC3/PEa9d2DsGWjR+2u2UXT0qiAgXB58828nJVF7EwVGcOPPL
         vGf/6fIYpF2GDP8KACuk81Gu9Qu4jdc0xnM+6BsY8qb2h/xS3jRCETBcdAfiWgdbLNMn
         Z60ezQa3WWYVUDDf/jv8Wglb1lE668xCcTXHnIgb8LUun9dPmTiI3sLOv7Qm7Is5TJ7Z
         +ObQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781392711; x=1781997511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrh3mtw21uDqAv+fInBxgdwwmlvcEY/ppShhIMRJqV8=;
        b=k1RVJlSeqUhRHAWLeR5bCLHief97nYMl+zbIqJBKCpn3asDCW/ooMhqoY6bxTr2mXU
         hHzd0j+Vgovum/i24MivwBymcjy8OswC2vPHkSzW8rdk2Bq/n7vzupAHpQK/nvm6CG55
         V2vplDHZjo0nsrRhRe+odo84tBi/Hoqvqjn0hpN+s+BcJZNNiweyK7xw6F6GSi8xe8Rz
         qzF/SzIqhzfFCBVUpZpfeK5RM+zvX6XOkRHk16Ajhiq80ZuBR9MNgh2jbvwdBDIBwhIZ
         zoqyGNRVP3FXOlxlgD6TOaV3md7cQgySn7b2bCcqnuqRCPN9uiO1MZ02TAEIcL6qDspr
         4eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781392711; x=1781997511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hrh3mtw21uDqAv+fInBxgdwwmlvcEY/ppShhIMRJqV8=;
        b=gIa0L9kyuwZ9k4sgW+BauyEm4ElKXyKPE/fmvhMeMc2LeoTSwJQJPpxH2kOfxSDmBG
         4jkI5f43JVUnlyQqfFs5MLxNWMTfkAqiK2jmD9p9bs0NrUAf7KYRPdFro2jKIVp+lS3p
         4Iuj2vRSGdyGzyO1FfUTDUaUvquB0m0ELCHq45xpVHWcIjmDBjOK6JUqMOUP5Pi4jOdD
         Gxgeq3u43jqj3qgJdJY0Tm8Q79i1oVcg7P6iqE1iq37Yx6Oip+fbNAOrpbbqJqWf5suC
         SupGr0V/PoV24MSfvFTAs2lgEsU9o5r5Fhr6iWbTcUIxYyiJ2x2cfY3VhL1eQFqkg420
         2C8A==
X-Forwarded-Encrypted: i=1; AFNElJ/J5KUlUAUSHZdZb/qyMJ3Hwuftb3HRNG4Z2pHvtfPilDRY6GvMoLDbgUQMeHGsNkCgY9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1s0LzybV2ImQvz6eXwUCDv/fcW41XnVoOLSxxc6kPfBhsuCt
	T6ZxyG8VOv0PzCV1c0WFn4bACnuE623lenQ4hVEsRdiAKzlMEaHTTzL5LNa1RVEHYYlrQk45NBB
	RJQegvYU9BmURVFSjVgwyCNoMT3Jf2qRvwCRjDIG+
X-Gm-Gg: Acq92OGuxCJM8Qo67rf19E+n8z/qXO1LufZkby4HUJENo7Fv5PhZj/30SoE5YTzwTVL
	EDGgazwPx92+6Oo10FWs58ew1BTg6W4ffKJCq3TgtI/lVa/awcQ793q1tDUJcsQLHtggQUZKaAz
	RJRVLn9uX8vJwaitztPJRhHW5EdyCJMxGoEbS/cuP7KZozbtI8Zyvno0o8RrFHXHVrDmTI3ZaJB
	iW8ht92EayIPXdpkkRxn3fw3/t8NFhaYCS9KDoKCMhzL/5HI5AC2XErm2rOTIvvXT9sK1iuGhhU
	FUhph7XQK6h6ztI6lb3PlxyI2ltOYolOlAODDfQLKRxlXu784B1DkvdmSWJYNuCNboSxn/9nref
	+e5brubkNIc37EJ4ocHHnUYg+QXH3/3ZuSAF/a/1yCizk52e/CRAr
X-Received: by 2002:a05:7022:4394:b0:138:33cc:d886 with SMTP id
 a92af1059eb24-1384bb1c329mr3810295c88.3.1781392709721; Sat, 13 Jun 2026
 16:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613102041.55e3b50e@kernel.org>
 <CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com> <20260613154750.0a2355a4@kernel.org>
In-Reply-To: <20260613154750.0a2355a4@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 16:18:18 -0700
X-Gm-Features: AVVi8CfWRjua43N5R25Ec3lhUHEDNvyeW-Rh2Ag46NdaoqpMNy3Y7Ggc1m-MHFQ
Message-ID: <CAAVpQUA0hA8DmR3Yaww-KjbdmoFK2b25hqec5zz9tdnKHjYJCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 3:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 14:43:46 -0700 Kuniyuki Iwashima wrote:
> > On Sat, Jun 13, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote:
> > > > When standard socket applications are run on these hosts,
> > > > a userspace proxy is required to mediate traffic between the
> > > > hardware and the applications.
> > > >
> > > >             +---------+                 +----------------------+
> > > >             |  proxy  |                 |  socket application  |
> > > >             +---------+                 +----------------------+
> > > >               ^     ^                               ^
> > > >   userspace   |     |                               |
> > > >   -----------| |-----------------------------------------------
> > > >              | |    |    +---------------------+    | skb
> > > >              | |    `--->|  virtual interface  |<---'
> > > >   kernel     | |   skb   +---------------------+
> > > >   -----------| |-----------------------------------------------
> > > >               |
> > > >               v
> > > >        +------------+
> > > >        |  hardware  |
> > > >        +------------+
> > >
> > > The first patch looks kinda nonsensical but then I saw this diagram.
> > > Looks like you're vibe coding an integration that makes it easier to
> > > treat netdev as a slow path for a user networking stack.
> > > Please tell me if I'm missing anything otherwise add my nack if you
> > > repost.
> >
> > Hmm, what would be a better way to tell users that HW TS is
> > available on tunnel devices ?
> >
> > Other options were 1) add attribute to tie the tunnel to a physical
> > device and use its ndo_hwtstamp_set/get, or 2) add bpf retval
> > hook in the path like update_socket_protocol().
>
> Can you explain the use case for HW timestamps on tunnels?
> I see you have some diagrams in patches 3 and 4 but the motivation
> isn't really explained, and we have 250 patches in the queue still.
> Not much time to play detective right now :/

To be clear, this series is not related to Swift.

Our RPC library capture timestamps as many places as possible
so that we can visualise the RPC calls and know/debug where the
latency comes from: application, library, kernel, network.

This is not specific to tunnels and applied to all workloads running
on container w/ virtual devices and init_net w/ physical devices.


>
> > Or do you think applications should handle ENOTSUP by ioctl
> > as soft error and always set SOF_TIMESTAMPING_XXX_HARDWARE
> > since the underlying physical device may support it ?
>
> And explain the deployment model and API semantics you have in mind.

The application first calls ioctl(SIOCSHWTSTAMP) and only when
hwtstamp is supported, it uses SOF_TIMESTAMPING_XXX_HARDARE.

The doc mentions ioctl(SIOCSHWTSTAMP) may overwrite the
configuration and ioctl(SIOCGHWTSTAMP) is not always implemented.
https://docs.kernel.org/networking/timestamping.html

But it does not say ioctl(SIOCSHWTSTAMP) may fail although
SOF_TIMESTAMPING_XXX_HARDARE could be supported.


>
> > Anyway, I'm happy to drop patch 1 for now and explore options.
>
> Not patch 1, all of it. I get the feeling y'all are sitting on a pile
> of Swift related code that needs to be made upstreamable. Odd series
> like this make me think it's never going to happen.
>
> > (Believe it or not, I haven't let AI write code because I don't
> >  want AI to take over the most fun part.)
