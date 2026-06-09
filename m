Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DD5B21A
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021846; cv=none; b=syIXD6QChROMuRJmCQd3oLV0FqSdcrxxwKHBOb8qGO60HsUqoiQuj92DN/mPA3pAlLjb8ip5ElPTvv57c9P4m9go3RNk9GF9bfHuGr2GvFQzhipUQIFNrY86gh4tq/dm7RreKWVoRSETLg/epKHtkhz7wimG2yAr7JeZ9AetMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021846; c=relaxed/simple;
	bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKHWB6CryLPPuu+jjL+r4ZUa3XYytMrn7HWFgD+uyZXx+HzSFqVpZXgSP6woUllt2oFH61QtJnNHJHN0zioNyBcYbTQvKBPBp+U5nc9y4oB9G4Zh6FCQawp/jQC2Rm56tcM3c/rJ+5M3kzeBoNOvxmkwbz5PE8elURntFnPCWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ygl2i57n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIPfDj5U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygl2i57n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIPfDj5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781021842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
	b=Ygl2i57ntFpKrQtX1PVr+76LwjWTxuawBbkrpF7bv0xd2+YbsOKN/hCCYdR2URuOeEwFh2
	Lieev/xRKVjbBt5RPZCWAO2+ugWNhbU7pwUHq5XcMFDwUpnc8niDBlDt1BUrPLRZSWXzMQ
	IxRNrC4c0pG6qA1cuA3OVKd8th9X5yk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-wrtyUh3rNpOA81bYI4ZfCQ-1; Tue, 09 Jun 2026 12:17:21 -0400
X-MC-Unique: wrtyUh3rNpOA81bYI4ZfCQ-1
X-Mimecast-MFC-AGG-ID: wrtyUh3rNpOA81bYI4ZfCQ_1781021840
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490afe64f26so28523045e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781021840; x=1781626640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
        b=DIPfDj5UaiSYEOpAjhvpAeT2bzP8scfcR6fD6GtkF/Tn9Qtm5KqWJ+5giIREsE2Qhx
         LJT11ZQxu57hvwiO9FSTZTzn8ZuyjXkwdk5px16PxH8bzSohzLDRslXWtnOqyn/Zxhn0
         pthFT9pYBcwk3onIvP4in6TPPUa1D02q9lpuX6jHtl6d3qdAMexMgRqlAQWfngllL4x5
         RMzQb4GK9NJYsgoqwCvbaFbF4Nomp1+au/6A+/KPz5sAz8W2m6Dwu2EP6St5jdtKZ0uB
         yhrhLvMjCvhwdbY/vk+Mkrk0oNVtJFOfsA5xRyMOuKloatzfr+9F8O+Y3hj09yhV1Ah6
         wGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021840; x=1781626640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
        b=Ylej0Hjj6e6O4Qv1UBl5fLoOIjXWZWlGOxvHy8kai1Dm52yqMiYWOApsLnpcn5/FuI
         ihL1sTuAUSdXBkQt4Do8lmJAXMCG9zQ9IvaEShx3+1oSkz5wYl79uke830ILpcf2aUqv
         +TXC+d3UDdZAmnXjDbEYanj6FKZUTZVIaSkHGD022OK8mYHoI/s0+dFV7knsY2Nxj7gt
         W6e7h2M31WbtM6CZBufkPYEXVxVh75H7/gPDtUp3yvSpko20lPbWWswertvgocjxbALL
         yhl2E0RAcNf0n7U8/u+mUNeuFwfwEpS9P/4B4BBdRuKNKYKU7CYNrKZV18921Ef1OuEW
         Nbzg==
X-Forwarded-Encrypted: i=1; AFNElJ+0woXBXpFYiN2KZ5samdyup3R0Mxqx/rKkmGIffsD37aP6kIbY+DU5TLbRTtcgkF4bTi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNjxvbNLG/xIjDEBvMSC6CbNawGQX6jvr7jutDwviN5AL6fZI
	o/GUtsCBrM3QbCdEipys+Vw8kkxPw84srWUqP/MWTXICSjm5H47PfxRDyVQsLoXeFRnSXQNTLSx
	GcZoyhuFItwXzqtP+kKTTjEW2kUKRyaUcquY3DghAqKeFmy88yh/1AA==
X-Gm-Gg: Acq92OH/1TUYTkVFRjQFPiyQ39eTMFd81jtEGcRSOfWp6H49wqE6MrDdVg2oTL+DaWj
	fv6SrLHRzS8Wau9oj+E0PkZtgczpcknIEwpHiXSGfNn5OSq64F7znaVhFBb2Ip5ZBy6OUqtG8Ic
	kwW4rPLJ6zyyOPf9d/NKnIJvhfzORKxymmnTSm7CgMKGjevn7kM+jwPr6rx9AIXwUeGmfT54UPf
	hN0qhl7YDJTeydg6YSYIL2IEMKRwcyB3lqDayd0DL5Sxkq/nLSXc9JONuub2d62UrguJRVEr4UQ
	4G7SgPNs19rG7jnwz3stGNTB6Os0uHRaPLkN6LOzschUheLbeTG6Fh4uIK1Tv5A+JyN/I4Z8fB0
	H+z+PPyCKYEMQ3bAZpUidC7ROKv3KLqlzvLAj
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490c2cc27bdmr286472445e9.6.1781021839839;
        Tue, 09 Jun 2026 09:17:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490c2cc27bdmr286471965e9.6.1781021839417;
        Tue, 09 Jun 2026 09:17:19 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm532407115e9.8.2026.06.09.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:17:18 -0700 (PDT)
Message-ID: <b9562bea557a68981b6a9400ec33072330ae621f.camel@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
From: Gabriele Monaco <gmonaco@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,  Linux-Arch
 <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>
Date: Tue, 09 Jun 2026 18:17:17 +0200
In-Reply-To: <DJ4LJ3T8PYRG.3TG272FHH78RM@gmail.com>
References: <20260609094941.56122-1-gmonaco@redhat.com>
	 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
	 <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
	 <DJ4LJ3T8PYRG.3TG272FHH78RM@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 16:42 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue Jun 9, 2026 at 3:04 PM CEST, Gabriele Monaco wrote:
> > On Tue, 2026-06-09 at 13:22 +0200, Arnd Bergmann wrote:
> >=20
> > > Did you see this cause measurable performance problems,
> > > or did you find it through inspection?
> >=20
> > I noticed it while debugging an ENOMEM issue in the test_maps BPF
> > selftest on PREEMPT_RT and this was an obvious cuplrit (irq_work
> > not scheduled during a stress run). Turns out the problem is still
> > there after this fix though.
>=20
> I would imagine this to be the least of your problems, I think
> there's a bunch of blockers for complete selftests passing with
> PREEMPT_RT support in BPF.
>=20

Well, I'm starting to believe that too..
At the moment on well tuned machines we are only observing ENOMEM
issues in the test_maps and only when it's literally hogging the
allocator (preallocation is off and 100 treads do updates in parallel).

What else are you expecting to fail under PREEMPT_RT?

> > > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > >=20
> > > Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
>=20
> The patch makes sense to me as well.
>=20
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks,
Gabriele

