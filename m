Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037BE3D47D2
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661313; cv=none; b=OhKPBYNHEYAjUIntEYmmf3MKIaFC/sruCRQh39VYp2H4+9rPnMdb5dmyilVF+g2CBFERlEoOffFde69iknbbRv6N8g2J9SdPc6OgMaR5wSjfZoBdgqZWD3Z3ZsftcS/NzMPEByLm1YfDbcfAhN9xNFAKkhtUv2zSAJ4VcxecXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661313; c=relaxed/simple;
	bh=MUmg7aRS1NARZPwNW8v03m8A7zZa8PDCceHu+O157kw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LAIvodn51/uxG8Go/JwZfStYNtZINa3HQledWfKeyjdfRl1v2JuYRAon2Yomi/4P5g2ot5DtW+e6oRpmtEhvGnrZvHZ5hTtl25I5hDxX6TxPt7y5sIYm4EceBGppGizxYhe4o1n1xLzmKuck/Dcl534jt9ocnJ7+y2jn6E+TsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPNIt+Ui; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPNIt+Ui"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7a299d84b7dso68087b3.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661311; x=1776266111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEicXTnGlZKyDrMeVQ9uoHja4kW2nn8vtj1Re/7BjO8=;
        b=mPNIt+Uin44FlTag4emzhXdmVmzkXRt8Ng+vrCZnnC7Fri3ntMOjTixpWIGBSNFKMl
         rRskbGrWFYGznJ6aIFUWfzpOva61gdKjV1Cq85Vauf5jgqmtGJJQO44V0s5/Bb3WMO5f
         F/w+KnQyFTrqEsYXoc1y3B+U8YVNmexfatxwK6zgn8sfr74uk4L4+pBTkIpomVulicQy
         pHIuWSED+fOR9rD69jbHYcyJjxKuQqNdLEO/unGTHCgxYt7TqAsgxiWirA+mLyBrCvza
         /Haj1luRoGVReMVMuC/7jwnDnqLObj+jk21EsW+JrsaZDCQ9OBkmxgTQVvWZYG534PBb
         PlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661311; x=1776266111;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEicXTnGlZKyDrMeVQ9uoHja4kW2nn8vtj1Re/7BjO8=;
        b=Vw7IOSKuE7fSNdn0YGIy6RzaswheLtmKTeTNOUvvuGfjV7hBTuWkYcul7e0cfY/L3O
         Uks8v0skD2DOInT4Spg2PCuZSYE1oYL23L5eNKx37RGhXjU/hDyt3Gsde4hvGpRv+OJb
         CdH4wIAxkfqbosib1+5XTHqDSu+pkspRRjOFG21353kEbKc0cB4snfuoGbgHhHOH/cLQ
         xM5x1euVcIeoLN+qqiP40FXMQhA4j5O3bO/HhB65Ix+42RvUWhIDKd764u3CqOpt5Jt3
         qq8uXRHy658Dj4d4KfvNYENohtTOt8T7XQHKYPx0XgpAqtr96JrUZdwY0FCF07bnWry+
         /xFg==
X-Forwarded-Encrypted: i=1; AJvYcCUxYHi7Zv7a7RKgb4APKNoMYxb7hs0i4nZMwY/PtdTLO2p5pGy+wdBS0sNSeShjuBoKGLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ctM8+ZvQ1TRPpAI3EagQV43PlyaW0ZV9R2HIQd77cpYg3+3R
	c4dsKJB0kof13xKIoDxkALOWY7K4UFkguW+X9GjJn3dNwhSSLI7CP9lU
X-Gm-Gg: AeBDiesVGGJCiWs1gk9bFzWLTFSfVmS0mJ6unzi0uYfA7c6gSvdPNGiFTeKJfcGqPaW
	ub7U+iupU1fHtJ7JSnvdiQ2wcDTt/lIxlzSw/5pN+wj6JVcLjXP9ys+CHa7vgYBWzEZqoNFoKtr
	zStY01eGIZQxjvNhciDiKtNVSO8PIJrvzWW64MHxbCeebqcJmT4A934RtIK0okZtdVjSXfAx8No
	NX+gFPjuX24jPNywH4TrBR7IwLohRJiIasJZnF4hCI99tu70LAcoqAViSVUO1V5uDdNPzaJRVwY
	PCyDAc++/8APyMsDCIgemGBohAuqCEJJ61n5ZiZ5drgFC6AH3yKXvk+bLqZIIGPGDQemkCEFrVD
	I0G6ySNj5rbTcsfNCO2OksTFOl9kVuY+SBZ6Ja+tJn/TM6uIE+uANZiTA3nDaROIVUvn4iY04dp
	dl7bIozYZYQu2e/G7Kpi3SenS+FlseY4zMEf/cjMGC1BPlziNmsyEteT5lfiPmSOAhxW1JcuhD4
	ZBpiWNbz1kUuyM=
X-Received: by 2002:a05:690c:e56d:b0:7a0:17f4:e761 with SMTP id 00721157ae682-7a4d604f276mr170996477b3.45.1775661310965;
        Wed, 08 Apr 2026 08:15:10 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a4fc065bf6sm71884147b3.38.2026.04.08.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:15:10 -0700 (PDT)
Date: Wed, 08 Apr 2026 11:15:09 -0400
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
Message-ID: <willemdebruijn.kernel.257654f9a3f23@gmail.com>
In-Reply-To: <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
 <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
 <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit

> > > > Since we're modifying the kernel, how about adding a new member to
> > > > record sendmsg time which bpf script is able to read. The whole
> > > > scenario looks like this:
> > > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will get
> > > > a copy of its original skb
> > > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > > current time, and then effortlessly do the math.
> > > >
> > > > At this point, what I had in mind is we have two options:
> > > > 1) only handle the skb from the view of the send syscall layer, which
> > > > is, for sure, very simple but not thorough.
> > > > 2) stick to a pure authentic packet basis, then adding a new member
> > > > seems inevitable. so the question would be where to add? The space of
> > > > the skb structure is very precious :(
> > >
> > > Finding a suitable place to put this timestamp is really hard. IIRC,
> > > we can't expand the size of struct skb_shared_info so easily since
> > > it's a global effect.
> > >
> > > I'm wondering if we can turn the per-packet mode into a non-compatible
> > > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > > sendmsg.
> >
> > Agreed that an extra field is hard. We should avoid that.
> 
> Avoiding adding a new one makes the whole work extremely hard. I'm
> wondering since we have hwtstamp in shared info, why not add a
> software one for timestamping use? Then, we would support more
> different protocols in more different stages in a finer grain, which
> is a big coarse picture in my mind.

I don't understand the need to store more data in the skb for BPF.

With BPF hooks, the bpf program can record the relevant data directly
in a BPF map.

> Adding a software bit will completely reduce the whole complexity and
> be very easy to use. Would you expect to see a draft by adding such a
> bit first?
> 
> Or just like I mentioned, repurposing tskey seems an alternative,
> which, however, makes the new feature incompatible.
> 
> >
> > If the purpose is to group skbs by sendmsg call (e.g., to filter out
> > all but the last one), it is probably also unnecessary.
> >
> > From a process PoV, since the process knows the sendmsg len and each
> > skb has a tskey in byte offset, it can correlate the skb with a given
> > sendmsg buffer.
> >
> > The BPF program is under control of a third-party admin. So that does
> > not follow directly. But it can be passed additional metadata.
> >
> > I thought about passing the offset of the skb from the start of the
> > sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> > as each new buffer will start with an skb with offset 0 ..
> >
> > .. but that won't work as there is no guarantee that a sendmsg call
> > will not append to an existing outstanding skb.
> 
> Right. TCP is way too complex and we indeed see some tough issues when
> trying to deploy the feature. So my humble take is to make the design
> as simple as possible.
> 
> >
> > Anyway, the general idea is to pass to the BPF program through
> > bpf_skops_tx_timestamping some relevant signal , without having to
> > expand either skb or sk itself.
> >
> > I hear you on that measuring every skb is too frequent. But is calling
> > the BPF program and letting it decide whether to measure too? BPF
> > program invocation itself should be cheap.
> 
> Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
> an awesome way to go. My ultimate goal is to do so. Instead of letting
> people implement various fine grained bpf progs, we can provide a very
> easy/understandable/efficient approach with more samples. It should be
> very beneficial.
> 
> >
> > If per-push is preferable, with a filter ability like the above, it
> > seems more useful to me already.
> 
> Push-level is a compromise plan. Packet-level is what I always pursue :)

Then why not directly implement per-packet.

If the BPF call is cheap and the BPF program can choose to selectively
track packets.

Reminder that you do not want to break (BPF) users by changing
behavior. Let alone more than once. If per-push is going to be
obsoleted, skip ip entirely.

> The current series has this ability: the bpf prog noticed it's a
> SENDMSG sock option and will selectively call
> bpf_sock_ops_enable_tx_tstamp() to do so. Only by calling
> bpf_sock_ops_enable_tx_tstamp() could the skb be tracked.
> 
> Thanks,
> Jason


