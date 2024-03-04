Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BC7B3C3
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588701; cv=none; b=MPDKvZ6OwWusG1P5U7CdwEhL750gVeVLYlQXhQYlDlXOAhFRAvsbHEJMPGjK2V5IYS23tIBvOQMeM7XZsVWrQezMeBgOecv3AAP3pKSvLeW6PFe7tfwIr3L3KZPus68fgubJf14V8ACzLn+4J7H2w9i3JrJ7hIE7whueY4llOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588701; c=relaxed/simple;
	bh=m63nuccIQyrVRicyfUChG7CecjTuo6QczTw9J3puSjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tigH5LxilNwPoa10fyse431E+UdxECZoorW2DZVV8oZeBn8FfzoEn5Xu2aQ3UYqqjaWx1uTsmmeBIdaL3GqWotnIMj9E0NAazfKrQE46lSRu9PZZPbRfdEqXZql9j5IMXY5N8a7lstAowAomPc7itum5MarO5WRFjC7dG2Ez8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gBuCLJLd; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gBuCLJLd"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6098ba9959aso663987b3.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709588698; x=1710193498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbmJzzoiMybFA9L8m/Y4BIq4OckJ6wySDCJm0tFlaUw=;
        b=gBuCLJLdtXFqqG2EYo2s4gsBi0z2mC8UnU4ladYbTK8IXNsIZ6hgHmN5vvTent1hV9
         Gyai2dWREqfaB4oCdFRnqSWcNL/1vKUq9kPx6GflAnGVYtbEJRzZzITCuGIABvjkxcT+
         RxGGquO5GXc9kPIWa2dFESy6vAigejSK2NSTnCMpElQhHu4xUHZrNEv6+fz7qXIO3jv+
         EzOnpA7WOJHSil7f+K0wuzTsnKh1QIJgPlNQ+v00jZ1kMaAyXzd98Zqc9QEAiZqnNUx/
         zR2WZrgp2uC1u3C/w94Nm5gRefBP8CsyEF4K40DOC46giYvLVtI7HZ2X3IWihHg5Zo11
         fzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588698; x=1710193498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbmJzzoiMybFA9L8m/Y4BIq4OckJ6wySDCJm0tFlaUw=;
        b=SbBydqeaD1wd/C7SpfvXMoIUz/KHYMbIoj5niSvHZnYKYH/IF/Y32iK2gUTi/xrEka
         Agt9Sk/1Y0b8I8X0b1ZLcvGaYx/BaqpE9bC5gjVRMIQU9/nSyw336tAJlxwRrbx47Ryd
         tZNrc/T3SMG9Ln7hMWjC+7cetXzKNCpOp452RAoDDFZz9n7JEUoc9HfOr0AXoDovh+ac
         //+VLx2u2D8nQXg7Zkra+7VEWYjdXlb6hprOpYoPcmmMFW6rNFthLmitt5DAzFOMw1ve
         56PX4ptaFxOPYcz4QAjAMUqvjQPbfMOQryWXJqIHJ6GDGhYHHOQjybW26YA6L1RkRQJZ
         5q2g==
X-Forwarded-Encrypted: i=1; AJvYcCWAVnDDNk/XG1BBuXc9Lo0gvQXZLJaY0OInNAQo/pHHdYXMjttgFIChOfqhH8SNjJQHPCBM+1n5dMpAHDp32S7vxa43
X-Gm-Message-State: AOJu0YwDu6uR3HMe3Ta+/LKwMseGMcLTry74jz9Qd997d8/WEcHnr6iM
	EzKTUXX6S3y+nmPH2Zbe7WBMMFgOKqjIhUa+4wSKXalMeWYDMqjPe3CKsPmttziAP2bAjai7+Hb
	JgwjO+ZGxRwH+F0IK0NbAN/+Oxi1AOGC5iM4G
X-Google-Smtp-Source: AGHT+IGuJLyI1uhwS3gw19hby60ql0XTX4VLWQE+mJhI4Hc9+aySZWsOYw8E425+25h/KHv++/VZe3lTA14aW7mEL20=
X-Received: by 2002:a05:690c:398:b0:609:3c37:a624 with SMTP id
 bh24-20020a05690c039800b006093c37a624mr11491521ywb.35.1709588697894; Mon, 04
 Mar 2024 13:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
 <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com> <ZeY7TqCGFR3h36k-@google.com>
In-Reply-To: <ZeY7TqCGFR3h36k-@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 Mar 2024 16:44:46 -0500
Message-ID: <CAM0EoM=b6ymCEKs14ACanbkzscy=AdARYHSWprtexHBswD7xeg@mail.gmail.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Stanislav Fomichev <sdf@google.com>
Cc: Tom Herbert <tom@sipanda.io>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, anjali.singhai@intel.com, 
	Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, deb.chatterjee@intel.com, namrata.limaye@intel.com, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, pctammela@mojatatu.com, 
	dan.daly@intel.com, Andy Fingerhut <andy.fingerhut@gmail.com>, chris.sommers@keysight.com, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:23=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 03/03, Jamal Hadi Salim wrote:
> > On Sun, Mar 3, 2024 at 1:11=E2=80=AFPM Tom Herbert <tom@sipanda.io> wro=
te:
> > >
> > > On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > > >
> > > > On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@kernel=
.org> wrote:
> > > > >
> > > > > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > > > > 2) Your point on:  "integrate later", or at least "fill in the =
gaps"
> > > > > > This part i am probably going to mumble on. I am going to consi=
der
> > > > > > more than just doing ACLs/MAT via flower/u32 for the sake of
> > > > > > discussion.
> > > > > > True, "fill the gaps" has been our model so far. It requires ke=
rnel
> > > > > > changes, user space code changes etc justifiably so because mos=
t of
> > > > > > the time such datapaths are subject to standardization via IETF=
, IEEE,
> > > > > > etc and new extensions come in on a regular basis.  And sometim=
es we
> > > > > > do add features that one or two users or a single vendor has ne=
ed for
> > > > > > at the cost of kernel and user/control extension. Given our wor=
k
> > > > > > process, any features added this way take a long time to make i=
t to
> > > > > > the end user.
> > > > >
> > > > > What I had in mind was more of a DDP model. The device loads it b=
inary
> > > > > blob FW in whatever way it does, then it tells the kernel its par=
ser
> > > > > graph, and tables. The kernel exposes those tables to user space.
> > > > > All dynamic, no need to change the kernel for each new protocol.
> > > > >
> > > > > But that's different in two ways:
> > > > >  1. the device tells kernel the tables, no "dynamic reprogramming=
"
> > > > >  2. you don't need the SW side, the only use of the API is to int=
eract
> > > > >     with the device
> > > > >
> > > > > User can still do BPF kfuncs to look up in the tables (like in FI=
B),
> > > > > but call them from cls_bpf.
> > > > >
> > > >
> > > > This is not far off from what is envisioned today in the discussion=
s.
> > > > The main issue is who loads the binary? We went from devlink to the
> > > > filter doing the loading. DDP is ethtool. We still need to tie a PC=
I
> > > > device/tc block to the "program" so we can do skip_sw and it works.
> > > > Meaning a device that is capable of handling multiple programs can
> > > > have multiple blobs loaded. A "program" is mapped to a tc filter an=
d
> > > > MAT control works the same way as it does today (netlink/tc ndo).
> > > >
> > > > A program in P4 has a name, ID and people have been suggesting a sh=
a1
> > > > identity (or a signature of some kind should be generated by the
> > > > compiler). So the upward propagation could be tied to discovering
> > > > these 3 tuples from the driver. Then the control plane targets a
> > > > program via those tuples via netlink (as we do currently).
> > > >
> > > > I do note, using the DDP sample space, currently whatever gets load=
ed
> > > > is "trusted" and really you need to have human knowledge of what th=
e
> > > > NIC's parsing + MAT is to send the control. With P4 that is all
> > > > visible/programmable by the end user (i am not a proponent of vendo=
rs
> > > > "shipping" things or calling them for support) - so should be
> > > > sufficient to just discover what is in the binary and send the corr=
ect
> > > > control messages down.
> > > >
> > > > > I think in P4 terms that may be something more akin to only provi=
ding
> > > > > the runtime API? I seem to recall they had some distinction...
> > > >
> > > > There are several solutions out there (ex: TDI, P4runtime) - our AP=
I
> > > > is netlink and those could be written on top of netlink, there's no
> > > > controversy there.
> > > > So the starting point is defining the datapath using P4, generating
> > > > the binary blob and whatever constraints needed using the vendor
> > > > backend and for s/w equivalent generating the eBPF datapath.
> > > >
> > > > > > At the cost of this sounding controversial, i am going
> > > > > > to call things like fdb, fib, etc which have fixed datapaths in=
 the
> > > > > > kernel "legacy". These "legacy" datapaths almost all the time h=
ave
> > > > >
> > > > > The cynic in me sometimes thinks that the biggest problem with "l=
egacy"
> > > > > protocols is that it's hard to make money on them :)
> > > >
> > > > That's a big motivation without a doubt, but also there are people
> > > > that want to experiment with things. One of the craziest examples w=
e
> > > > have is someone who created a P4 program for "in network calculator=
",
> > > > essentially a calculator in the datapath. You send it two operands =
and
> > > > an operator using custom headers, it does the math and responds wit=
h a
> > > > result in a new header. By itself this program is a toy but it
> > > > demonstrates that if one wanted to, they could have something custo=
m
> > > > in hardware and/or kernel datapath.
> > >
> > > Jamal,
> > >
> > > Given how long P4 has been around it's surprising that the best
> > > publicly available code example is "the network calculator" toy.
> >
> > Come on Tom ;-> That was just an example of something "crazy" to
> > demonstrate freedom. I can run that in any of the P4 friendly NICs
> > today. You are probably being facetious - There are some serious
> > publicly available projects out there, some of which I quote on the
> > cover letter (like DASH).
>
> Shameless plug. I have a more crazy example with bpf:
>
> https://github.com/fomichev/xdp-btc-miner
>

Hrm - this looks crazy interesting;-> Tempting. I guess to port this
to P4 we'd need the sha256 in h/w (which most of these vendors have
already). Is there any other acceleration would you need? Would have
been more fun if you invented you own headers too ;->

cheers,
jamal

> A good way to ensure all those smartnic cycles are not wasted :-D
> I wish we had more nics with xdp bpf offloads :-(
