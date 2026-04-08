Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51F35AC3B
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689577; cv=pass; b=YJ8ne/TSQSV4D5UvNOJo4+9nEfEZzrQ9sRVie0fqZo8yumN/GCbNTP5DV7aOwL0Pdv3+ZzDm4H984bVeoKvD4l0Q9fFZZsea4v2bQL9T6vmuWIY68sTnh9hV40obswpB2VNZZh4VWtfa/1H03qDI3XzAypTVqfa4FX+1Xuz8Y18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689577; c=relaxed/simple;
	bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHjkp0srlHRw68WnwAV36TT8uehl579lgHJb5E1sL/tyV50ATeOX3iEMrGJF8XABqXrEMifb9eV7ckuiYtOab9HHEgJUJ57WkhSJ6oDWSlKpQAxe8/lqfE+irTV5foVLAvmPX0w8DFVk6VY/CBRXbntPd5l3b4ui/wZJWYucc8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhOQaNX0; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhOQaNX0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so279588e87.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 16:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775689573; cv=none;
        d=google.com; s=arc-20240605;
        b=iw5QRH5fNRmmfnLal619kLnDkBbhw8qvvamb+4825mD925e7sn1eB/MQl2ejtLLtZb
         c7c86eqigX2lKYQm+i1XQiv3FyHQ3OU8ae2D6uNKF2ZFH8npVoUzol8EuAEXdL+gCviO
         rZlOAFHl4Wk8LwozZn8OI02/jvb+dQvJ0bO5AK/X3kutKBC9INBe90diK+dtqrDtRxf0
         fNGBBsrvuABLdfNIsukAJ4+GASQjvZPZLd6B2I5oXGdiIj/04XoGstmbsYUfjpauae0M
         mnh0zGJ6bXTogoaJCTG26qHxcBmoudsD71p5zpODfS7LlPz8Z9fwoCCmNVKIf7NR7MDi
         kYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
        fh=rZTRStmJ77ZLW+bVKVzBpJzUHWeIXpmPIMDYZTGCzMQ=;
        b=bBlQvaGVCJ9g8dbq8MdM3UytSdBQ+rkWOjkuUO0pLDRfaoXpmpxkLsJenkxeCUN6nf
         mV713ROSlvOt3uoEaOW91KDHoEm+UJhi4o49ozoeGsOR2hRbIxhb+WaE8we/KsyP8jWB
         bCgqyM+tyigylLgYuDW+zf/EukOAuuO+eEswFXwltKHXJG40dxo+b2a3zXglKvZ4pson
         Dv1k/u6y5Vhfi/MHlPSzYhtyMASHA50F5/UoLfjMLGvHVIwAVT1lG5lir5gyS9sKvJN4
         nXtvFuY6l3zi1CkNhbWvBOIFh68+Cj0DPoud26F4ZRk86paHbWYuS8KbE9l4znp4+ADk
         tQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775689573; x=1776294373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
        b=fhOQaNX02gPoFdrlvbU9SpzwcfwU8wAES3XWx8gv6zy91sICkyiWXAtZw4XQooBleW
         EbLTdCUFHmoodtytBNKqjEzSf3+s7e/FzND3S5OhLfepH/HIaHZu+PKBUhkRY2xUy67z
         /SK3g9IAdrDFhKJ9/eGKVfwOmeyz5BL38gmHlKpLO4j2+QYd87rHyUcf15ecTBXT70He
         8S9XzxjY1v+BcFOwgs2gml+zXwYIkFRV79KpTZGJTjP9Q3EOIun3F9H/HumbMDImUtH2
         s0w9BrrxPGn2fPoI9PAkGPNw5EEzav9M3igffoPzCn5SprUXMvGM7l77THCj8rRRnRh6
         zP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689573; x=1776294373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
        b=cVeUE+cQjECdF0H2pex81W3LbuAPBpgLkFiMjYeDRVGWw1yGcAW3VR8YKKr4HoXPms
         /Q1Gz3xPZ/Q1Ve5KkMj/M6gcLpUTKBL0UqvJjGE6PaO6RrRrdGrCVV+ghpYGPY/dzC3b
         DErgIALJLBZnz2594hvBSqOQ4jMUf5Ps8yi59kmji65sOUnUE2fjLXlSIPiCnjGk5Kjs
         fzI2SOR4VPC3ANudZuGK9TXnlj3eiKTsmpesgykDZ5GEn8sOSQV6LYFV5Qz2hv+4AJLZ
         SqQ1K8D/1U++XM8I126v40ftxUvE70qtmOkP9VWPGZWGf/jb3Z3Z+QqssewzAL4vRayv
         fPcg==
X-Forwarded-Encrypted: i=1; AJvYcCWLoaNLL0Wo0K7P8ZYNr66ak/xMNUjDqi6MQmhj5dncZDJdJccKhotl4i4z1aJZDtaw3Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiu4yCBgkJG/ls1E/JBPMG6waWI475c2eJ/HJoPVLLHFdDqamA
	3f26RqaRzS2cuTvXZPpcRWFxMxR3dNcXrDYg5dOSSXrUOqOUtcVHuByfV2XcdX5MG1Rfd5wjLOH
	Zp9swPhzwogXRWdUE42F85z+H1o0QTDs=
X-Gm-Gg: AeBDievkPmrkj2GINLyXe9MY+38OT7aZeYKKeOeZTVGkYMQ58/pYcSU6WNoQFSawalr
	aCGBmJdj71XqgxLjdHEYAdWKvCh/Zeygc/0bHlb+0g+nKI2/4RoWKBeeCX/uv6lKXFRWUtWQdup
	OVO6mjzVqfBCsNw0ucl/iwRWVTPhkNgDrxc2zzIDdAOKjKGZA7u3F/06cP4GidgLX8jYySRPAdT
	kpzNBDC+Fn9t0yeDAVQUpaEbwU5YerG/7XhhdljGDW/WJW/fv9yu4mMfO+095LASFWOmglah48b
	vlbeAGk=
X-Received: by 2002:a05:6512:2255:b0:5a3:ea23:9af8 with SMTP id
 2adb3069b0e04-5a3ea239d28mr12499e87.24.1775689572219; Wed, 08 Apr 2026
 16:06:12 -0700 (PDT)
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
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com> <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
 <willemdebruijn.kernel.257654f9a3f23@gmail.com>
In-Reply-To: <willemdebruijn.kernel.257654f9a3f23@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Apr 2026 07:05:34 +0800
X-Gm-Features: AQROBzDQgEI9lw5wbSyPTgXA2FWuJ-qBMbd5NRMWRIDCToG7zeyMq_VD-ECIWvg
Message-ID: <CAL+tcoCx0fB-jsF3j03vFfhPDvO0T-B=FGzEgi4GE06Y_rjeMw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 11:15=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > > Since we're modifying the kernel, how about adding a new member t=
o
> > > > > record sendmsg time which bpf script is able to read. The whole
> > > > > scenario looks like this:
> > > > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb wil=
l get
> > > > > a copy of its original skb
> > > > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > > > current time, and then effortlessly do the math.
> > > > >
> > > > > At this point, what I had in mind is we have two options:
> > > > > 1) only handle the skb from the view of the send syscall layer, w=
hich
> > > > > is, for sure, very simple but not thorough.
> > > > > 2) stick to a pure authentic packet basis, then adding a new memb=
er
> > > > > seems inevitable. so the question would be where to add? The spac=
e of
> > > > > the skb structure is very precious :(
> > > >
> > > > Finding a suitable place to put this timestamp is really hard. IIRC=
,
> > > > we can't expand the size of struct skb_shared_info so easily since
> > > > it's a global effect.
> > > >
> > > > I'm wondering if we can turn the per-packet mode into a non-compati=
ble
> > > > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > > > sendmsg.
> > >
> > > Agreed that an extra field is hard. We should avoid that.
> >
> > Avoiding adding a new one makes the whole work extremely hard. I'm
> > wondering since we have hwtstamp in shared info, why not add a
> > software one for timestamping use? Then, we would support more
> > different protocols in more different stages in a finer grain, which
> > is a big coarse picture in my mind.
>
> I don't understand the need to store more data in the skb for BPF.

I see your point.

>
> With BPF hooks, the bpf program can record the relevant data directly
> in a BPF map.

It works for sure, but, as I said previously, it's not an effective
approach that can be used in production to run a 7x24 monitor.

Either adding a new field or repurposing the tskey makes the whole
logic/arch very simple. Being simple is being efficient and easy to
use. Without changes like that, the performance of flows can get
hugely affected just because of the monitor.

>
> > Adding a software bit will completely reduce the whole complexity and
> > be very easy to use. Would you expect to see a draft by adding such a
> > bit first?
> >
> > Or just like I mentioned, repurposing tskey seems an alternative,
> > which, however, makes the new feature incompatible.
> >
> > >
> > > If the purpose is to group skbs by sendmsg call (e.g., to filter out
> > > all but the last one), it is probably also unnecessary.
> > >
> > > From a process PoV, since the process knows the sendmsg len and each
> > > skb has a tskey in byte offset, it can correlate the skb with a given
> > > sendmsg buffer.
> > >
> > > The BPF program is under control of a third-party admin. So that does
> > > not follow directly. But it can be passed additional metadata.
> > >
> > > I thought about passing the offset of the skb from the start of the
> > > sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> > > as each new buffer will start with an skb with offset 0 ..
> > >
> > > .. but that won't work as there is no guarantee that a sendmsg call
> > > will not append to an existing outstanding skb.
> >
> > Right. TCP is way too complex and we indeed see some tough issues when
> > trying to deploy the feature. So my humble take is to make the design
> > as simple as possible.
> >
> > >
> > > Anyway, the general idea is to pass to the BPF program through
> > > bpf_skops_tx_timestamping some relevant signal , without having to
> > > expand either skb or sk itself.
> > >
> > > I hear you on that measuring every skb is too frequent. But is callin=
g
> > > the BPF program and letting it decide whether to measure too? BPF
> > > program invocation itself should be cheap.
> >
> > Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
> > an awesome way to go. My ultimate goal is to do so. Instead of letting
> > people implement various fine grained bpf progs, we can provide a very
> > easy/understandable/efficient approach with more samples. It should be
> > very beneficial.
> >
> > >
> > > If per-push is preferable, with a filter ability like the above, it
> > > seems more useful to me already.
> >
> > Push-level is a compromise plan. Packet-level is what I always pursue :=
)
>
> Then why not directly implement per-packet.
>
> If the BPF call is cheap and the BPF program can choose to selectively
> track packets.
>
> Reminder that you do not want to break (BPF) users by changing
> behavior. Let alone more than once. If per-push is going to be
> obsoleted, skip ip entirely.

Understood. My initial version was just to try to solve the missing
tag issues with the minimum change. You're right about the
compatibility across kernels. Let's work on the ultimate plan then.

Thanks,
Jason
