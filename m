Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D93431F5
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382657; cv=none; b=B/eQyr4seC05qSmNxuVEPI/n+rEtaTdIQ1/2VHmLRieuaSbg1J+6H6Hy9GhK1T2/SFWRHdFCmyrrJjt9ZGcZSwxXPYsTR/tv4j2dPSdEvrX1W62cSW5cnhPxhWi/JWpwB1rU/vBaho3lZDJwD/LZ+5UxYVh2L0qM4935aCwQK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382657; c=relaxed/simple;
	bh=LFYTLDya4nUBuNoGJGqoPOOHGM2W4WbbOzsRrDENqYs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=aiwD5INuDaeZBm+/Vm3HK4BYeETlUWlTtYjRnwHApf12ZXjIwdbbEwVGRdQv0kw1EP3vUx/sD0ej1hMm7sUn+gS/9vINcmeAtv4NPXftdlh77obHUhwWSb8Gl3rXcEs8ph+Vug/1ASCtPSCw4sjllB4XDqmzouAKIvDN/pzjUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BymCD4Zr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BymCD4Zr"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773382643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlZNI/5acX8z6wx0x3sjimiPxTKa3g6pXUT2Z8+5yzk=;
	b=BymCD4ZrgzFHF1x87zKIoazqFmSjkOaNt3zN1X5rdXKRlDMyukkg0amqB7bd+yuEz9vea7
	DzSPS4PMBxu0jIJifSFscC8oOtcNwv0ncRczmqjPYxbE5UdMJq/xluC0f5QAFgPd87aecX
	qNVBryDztRpsfB0Nyxr76bAhsphQFQA=
Date: Fri, 13 Mar 2026 06:17:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "teawater" <hui.zhu@linux.dev>
Message-ID: <90829ef692dabd1635daf6475bd09b192788376d@linux.dev>
TLS-Required: No
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
To: "Muchun Song" <muchun.song@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Tejun Heo" <tj@kernel.org>, "Michal Hocko"
 <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "=?utf-8?B?TWljaGFsIEtvdXRuw70=?="
 <mkoutny@suse.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "JP
 Kobryn" <inwardvessel@gmail.com>, "Geliang Tang" <geliang@kernel.org>,
 "Sweet Tea Dorminy" <sweettea-kernel@dorminy.me>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "David Rientjes" <rientjes@google.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Meta kernel team"
 <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8F3593EB-9D81-4459-8675-E922426DCB1E@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
 <3ECC9B38-6C1A-4F60-9C18-98B7A1A56355@linux.dev>
 <abHPsCypwo7ZhqIt@linux.dev>
 <8F3593EB-9D81-4459-8675-E922426DCB1E@linux.dev>
X-Migadu-Flow: FLOW_OUT

>=20
>=20>=20
>=20> On Mar 12, 2026, at 04:39, Shakeel Butt <shakeel.butt@linux.dev> wr=
ote:
> >=20=20
>=20>  On Wed, Mar 11, 2026 at 03:19:31PM +0800, Muchun Song wrote:
> >=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>  On Mar 8, 2026, at 02:24, Shakeel Butt <shakeel.butt@linux.dev> wr=
ote:
> >=20=20
>=20>=20=20
>=20>  [...]
> >=20=20
>=20>=20=20
>=20>  Per-Memcg Background Reclaim
> >=20=20
>=20>  In the new memcg world, with the goal of (mostly) eliminating dire=
ct synchronous
> >  reclaim for limit enforcement, provide per-memcg background reclaime=
rs which can
> >  scale across CPUs with the allocation rate.
> >=20
>=20> >=20
>=20> > Hi Shakeel,
> > >=20=20
>=20> >  I'm quite interested in this. Internally, we privately maintain =
a set
> > >  of code to implement asynchronous reclamation, but we're also tryi=
ng to
> > >  discard these private codes as much as possible. Therefore, we wan=
t to
> > >  implement a similar asynchronous reclamation mechanism in user spa=
ce
> > >  through the memory.reclaim mechanism. However, currently there's a=
 lack
> > >  of suitable policy notification mechanisms to trigger user threads=
 to
> > >  proactively reclaim in advance.
> > >=20
>=20>=20=20
>=20>  Cool, can you please share what "suitable policy notification mech=
anisms" you
> >  need for your use-case? This will give me more data on the compariso=
n between
> >  memory.reclaim and the proposed approach.
> >=20
>=20If we expect the proactive reclamation to be triggered when the curre=
nt
> memcg's memory usage reaches a certain point, we have to continuously r=
ead
> memory.current to determine whether it has reached our set watermark va=
lue
> to trigger asynchronous reclamation. Perhaps we need an event that can =
notify
> user-space threads when the current memory usage reaches a specific
> watermark value. Currently, the events supported by memory.events may l=
ack
> the capability for custom watermarks.

I agree. Even with BPF controlling proactive reclamation, I believe
there needs to be an event reflecting capacity changes to signal
when to stop.=20
Otherwise,=20the reclamation volume per batch would have to be set very
low, leading to frequent BPF triggers and poor efficiency.

Best,
Hui


>=20
>=20>=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>=20=20
>=20>  Lock-Aware Throttling
> >=20=20
>=20>  The ability to avoid throttling an allocating task that is holding=
 locks, to
> >  prevent priority inversion. In Meta's fleet, we have observed lock h=
olders stuck
> >  in memcg reclaim, blocking all waiters regardless of their priority =
or
> >  criticality.
> >=20
>=20> >=20
>=20> > This is a real problem we encountered, especially with the jbd ha=
ndler
> > >  resources of the ext4 file system. Our current attempt is to defer
> > >  memory reclamation until returning to user space, in order to solv=
e
> > >  various priority inversion issues caused by the jbd handler. There=
fore,
> > >  I would be interested to discuss this topic.
> > >=20
>=20>=20=20
>=20>  Awesome, do you use memory.max and memory.high both and defer the =
reclaim for
> >  both? Are you deferring all the reclaims or just the ones where the =
charging
> >  process has the lock? (I need to look what jbd handler is).
> >=20
>=20We do not use memory.high, although it supports deferring memory recl=
amation
> to user-space, it also attempts to throttle memory allocation speed, wh=
ich
> introduces significant latency. In our application's case, we would rat=
her
> accept an OOM under such circumstances. We previously attempted to addr=
ess
> the priority inversion issue caused by the jbd handler separately (whic=
h we
> frequently encounter since we use the ext4 file system), and you can re=
fer
> to this [1]. Of course, this solution lacks generality, as it requires
> calling new interfaces for various lock resources. Therefore, we intern=
ally
> have a more aggressive idea: defer all reclamation triggered by kernel-=
space
> memory allocation until just before returning to user-space. This shoul=
d
> resolve the vast majority of priority inversion problems. The only pote=
ntial
> issue introduced is that kernel-space memory usage may briefly exceed m=
emory.max.
>=20
>=20[1] https://lore.kernel.org/linux-mm/cover.1750234270.git.hezhongkun.=
hzk@bytedance.com/#r
>=20
>=20Muchun,
> Thanks.
>
