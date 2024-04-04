Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B31272BB
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237674; cv=none; b=TppJekv0J2svGG++koYH77gOUGm7pq1JaLfeHu8NzpmRzO9fIEzydSXb9bsnmpjtoeUgnWqypIba+GztalDY2NqJMgKBC/+4Ozh1PGZW52aAmF6yKn5/mDTWu88NIu+xfei6HV8byuw1dEr6PCJU4dJ8zOxvkPX4kab1tl2iaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237674; c=relaxed/simple;
	bh=hDcbBQeU+B7GEainBaRPFeI/b7BXaSqcsO17ALzCtg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKwphnAAx6ii4djp0pe19jBlj7GLxAQoPcjDxZ349o2SDofivu0byaAT/oeBGzjhinVOcsuTGrAdGYOTdvkWXXbKl8iLTnXI6uWO+U4T0nply82LXOX0SWhxzT6wmEgfH8m8XM3INbsjbenRTWO1XkoINBvHa6IqlaTUOlF2T0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACRgZXIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACRgZXIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712237671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDcbBQeU+B7GEainBaRPFeI/b7BXaSqcsO17ALzCtg0=;
	b=ACRgZXIK8jrD0SkvfchYEScrKsLR4Ismx4yJxnOjYeVQgpE4fA/I9f/3IwK/o6g5N7ItpI
	tZ52WQ6VKJquiVZiBHiricYN389lfHFFo4TNlPauLagGPlzhD1xfRcTxbEWpWt21T8ztBH
	t90y4GyJcY9+cIO8tUvTfgYkAwfPa0I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Hb7_QMGmPXai7_i7Oqy6Hw-1; Thu, 04 Apr 2024 09:34:28 -0400
X-MC-Unique: Hb7_QMGmPXai7_i7Oqy6Hw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d835fe0b39so8312151fa.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 06:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237666; x=1712842466;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDcbBQeU+B7GEainBaRPFeI/b7BXaSqcsO17ALzCtg0=;
        b=MQTqch+WWr8+wfC+btnA5VmhUkP1UxyQaCvAuOvI390gjK7yGOkxT98P/cvF+1jnn7
         kD+u2Xfeh1qlQUIOCQYz65rKV+LUVCnmwvty1ZAjcOURQW7FlfPcaArAlgo6DEJCF5DL
         JozP8Ik427R2T6w4YsbiZXJipqYx/Wi75FMosCLlDSVS+Gj250MBH6S54WsLOmB7vysG
         joxoyVVTCdm3vQW+bLncUa/dZFsKqdSF6YCn6kk7MfsH9Jd64paErUsc5ngbsQ0WgHh8
         fG1Z3sRG/Gq8ct7CdPUyRTgRjAVhKk77Cg9pWSPQrxvp60DM9Bdn8+d7Iq0tX2MgYiZY
         5wXw==
X-Forwarded-Encrypted: i=1; AJvYcCUxQGT9ZtNu6j0WZYu6KMp4WHlfC3VcualUzqTfZsYr7NEiMnRyjsZC0N+M03TzWZlr4LFp5lR5F7xonEqwSptgMwKI
X-Gm-Message-State: AOJu0YyUTA1kXB9xdTRPMglr1j3nkORtwFG0t9rNBMncoim/tr6hGqe/
	f386041i3vn6w7yfcE2Db+oCIwEUGSb9X/dqVrbcMJFW8pkxWAptnUgtjVLNc/p+FEbEEDvR3VF
	GlQQKFg7dGlwKC9Q1UBpl887uUvKORiamryCljK+gCngr0f5A+Q==
X-Received: by 2002:a2e:9956:0:b0:2d8:45ff:d606 with SMTP id r22-20020a2e9956000000b002d845ffd606mr1555589ljj.50.1712237666388;
        Thu, 04 Apr 2024 06:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESL8vxfsypVflX/j6u+Cw899PN0WfevQKEzyUxQ+EmPi+UIru9k+mXs48fuOAKEtxSigt8lg==
X-Received: by 2002:a2e:9956:0:b0:2d8:45ff:d606 with SMTP id r22-20020a2e9956000000b002d845ffd606mr1555560ljj.50.1712237665975;
        Thu, 04 Apr 2024 06:34:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c45ce00b0041487f70d9fsm2691247wmo.21.2024.04.04.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:34:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 52B0F11A25F5; Thu,  4 Apr 2024 15:34:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
In-Reply-To: <5a0db8a6-6d73-48a6-8824-3191657ff11a@kernel.org>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com> <87sf1lzxdb.fsf@toke.dk>
 <5a0db8a6-6d73-48a6-8824-3191657ff11a@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 04 Apr 2024 15:34:24 +0200
Message-ID: <87sf01l09r.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 21/02/2024 15.48, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>>> The cookie is a random 128-bit value, which means the probability that
>>> we will get accidental collisions (which would lead to recycling the
>>> wrong page values and reading garbage) is on the order of 2^-128. This
>>> is in the "won't happen before the heat death of the universe" range, so
>>> this marking is safe for the intended usage.
>>=20
>> Alright, got a second opinion on this from someone better at security
>> than me; I'll go try out some different ideas :)
>
> It is a general security concern for me that BPF test_run gets access to
> memory used by 'system page pool', with the concern of leaking data
> (from real traffic) to an attacker than can inject a BPF test_run
> program via e.g. a CI pipeline.
>
> I'm not saying we leaking data today in BPF/XDP progs, but there is a
> potential, because to gain performance in XDP and page_pool we don't
> clear memory to avoid cache line performance issues.
> I guess today, I could BPF tail extend and read packet data from older
> frames, in this way, if I get access to 'system page pool'.

I agree that the leak concern is non-trivial (also of the secret cookie
value), so I am not planning to re-submit with that approach. I got
half-way revising the patches to use the system PP but always
re-initialise the pages before the merge window. This comes with a ~7%
overhead on small packets and probably more with big frames (due to the
memcpy() of the payload data).

Due to this, my current plan is to take a hybrid approach, depending on
the 'repetitions' parameter: for low repetition counts, just
pre-allocate a bunch of pages from the system PP at setup time,
initialise them, and don't bother with recycling. And for large
repetition counts, keep the current approach of allocating a separate PP
for each syscall invocation. The threshold for when something is a "low"
number is the kicker here, of course, but probably some static value can
be set as a threshold; I'll play around with this and see what makes
sense.

WDYT about this?

-Toke

