Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DEFC1B
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586159; cv=none; b=aH+CzS3fZp3T9vUygF6tcLLg+X/1LevkJYcTlc2+z3mbAe7A7OPkENndn7txaeyjJxh57As4QClhDrBdutRVxQZzvU3zJ7ew2488vvIzbCMltwtDsgClkrBNrLY+OqTNe/89HqYHlU+RZJW8CDkznroWeT9vW5pylJef2+iw4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586159; c=relaxed/simple;
	bh=luncRuA5vnipV4goB+3N1vMZbt0W17n3b0q6Qp2JXUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptFHjEh+YlJzBmqgyzXcp9+XX7L2EN7WU6y5NT8N6PsoTmoju17FC+pkCNGfaA0a1AfcDtKy1MvOHYnI8S3AMDnBYwu//o3AhvpsXLOw73iebzc7AzJryfMZjICW0+/EfKVqLfIwR8OcfwC7xDjeTrK5jVG+Mp96WUD2FFBSz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rkPTOepc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rkPTOepc"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60982a6d8a7so45244877b3.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709586156; x=1710190956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPnN3dFBTc28GNlG9yE073G/8kEzjDecpdpv6G1vFFE=;
        b=rkPTOepcsnPuoFhGX5b0Edx+Lrt55lqqrpG5J3ectCXddIk/v3x67EKlBVyc71akeO
         aQjcbeWVe2J81yYQ5avDCnuspn03nf06xqLRMLuMqg+hQzXhiK/AYpEmFdnwIEwqffUo
         WzUa21oi1epQcEkYN/m4sP6ZyvE7RPZJHg5K+Q4stUB7pogfbNwje+CVt3lKyStG0rkC
         CisMT9Fare5Ul/KRtPF2WROnxKqtrdy09QfRCLb0iRxHU3TNFw8BfY+/OxI8U6/xNr4n
         GqKaC9Ee/wbmZnm2G9WeO3m3YQ/WuKhj9U5EUGbZY+9thYfnodMmonSvKJ1+aQxRf5Rn
         oKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709586156; x=1710190956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPnN3dFBTc28GNlG9yE073G/8kEzjDecpdpv6G1vFFE=;
        b=U0GYaxkert3aPRA5JthmX659eXaY0bXk9KRnkIDI2d8EY5Y0/egPaPI2eO4wOjK8ax
         ET28YdknS0qkgTMARtERgRQqLAKE3ERPDKtO5TIXtGGHqGw4D6n1jyzLigiiZ9OCoVNf
         XMembaYfDtBRc8FfgwiBupbGA4t/JwyXtqjk8SQKpkFK6p/q5o/pwksqZewWvWDUwhmh
         f9Y1ZVMoCsMONCOLTc3ViFQi9N3WdZCbbPlbaoL0sopmshiEreNt/W9YQFjjw+QsCAZY
         niyw5YMvBSM5CPfKS2LS+wMMCcpMeytr28yIE2YSSygisT7GzCVLWDuUOMhXId0XcSsT
         LqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCULf9fDHlK/A4/uxFLex1t0ZA+86GOa5acUrYdHtcK1lmRTMVTLuYGRbzSVDamhLi6//iTw3j04mDpJ7yuQkH9WI5FC
X-Gm-Message-State: AOJu0YznMF7K7QKvUUoP0ePDF0u8ObX92SugdPRlx/pmMUnSgSoKl72T
	TW82lHjW5wpigR5aidw9+168zhY+b2ye/pIvkpSDuZG3zs/dwimjISq8uyYlraXJHVbW4a5ASx4
	pj/KV+Oe51DYMVc0jytOOWwrMXYqARxRpYEAe
X-Google-Smtp-Source: AGHT+IE8+zvwn1VLt4AntJbEDZpwulZRwNBONFfaY5c9Rma66osS7yNg6dlMa+s/AXZX/uIn/0Biky9M0uXeMbhZxbk=
X-Received: by 2002:a81:4ac2:0:b0:607:850e:7583 with SMTP id
 x185-20020a814ac2000000b00607850e7583mr9052659ywa.38.1709586156622; Mon, 04
 Mar 2024 13:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
 <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com> <20240304121812.450dda4c@kernel.org>
In-Reply-To: <20240304121812.450dda4c@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 Mar 2024 16:02:24 -0500
Message-ID: <CAM0EoM=NuPeTbopi7XprLuVavNT8dKHApBxzdkFqNcRvO=pPwA@mail.gmail.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun, 3 Mar 2024 14:04:11 -0500 Jamal Hadi Salim wrote:
> > > At
> > > this point in its lifetime, eBPF had far more examples of real world
> > > use cases publically available. That being said, there's nothing
> > > unique about P4 supporting the network calculator. We could just as
> > > easily write this in eBPF (either plain C or P4)  and "offload" it to
> > > an ARM core on a SmartNIC.
> >
> > With current port speeds hitting 800gbps you want to use Arm cores as
> > your offload engine?;-> Running the generated ebpf on the arm core is
> > a valid P4 target.  i.e there is no contradiction.
> > Note: P4 is a DSL specialized for datapath definition; it is not a
> > competition to ebpf, two different worlds. I see ebpf as an
> > infrastructure tool, nothing more.
>
> I wonder how much we're benefiting of calling this thing P4 and how
> much we should focus on filling in the tech gaps.

We are implementing based on the P4 standard specification. I fear it
is confusing to call it something else if everyone else is calling it
P4 (including the vendors whose devices are being targeted in case of
offload).
If the name is an issue, sure we can change.
It just so happens that TC has similar semantics to P4 (match action
tables) - hence the name P4TC and implementation encompassing code
that fits nicely with TC.

> Exactly like you said, BPF is not competition, but neither does
> the kernel "support P4", any more than it supports bpftrace and:
>

Like i said if name is an issue, let's change the name;->

> $ git grep --files-with-matches bpftrace
> Documentation/bpf/redirect.rst
> tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
>
> Filling in tech gaps would also help DPP, IDK how much DPP is based
> or using P4, neither should I have to care, frankly :S

DDP is an Intel specific approach, pre-P4. P4: at least two vendors(on
Cc) AMD have NICs with P4 specification and there FPGA variants out
there as well.
From my discussions with folks at Intel it is easy to transform DDP to
P4. My understanding is it is the same compiler folks. The beauty
being you dont have to use the intel version of the loaded program to
offload if you wanted to change what the hardware does custom to you
(within constraints of what hardware can do).

cheers,
jamal
