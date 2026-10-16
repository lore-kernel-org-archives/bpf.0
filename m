Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF33148D2
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114289; cv=none; b=MEAWXnth7tz3hVYGOG7+1CDwCGlTE1aAPiuW8Quo46/mV/aJ0HBY67kshRvDDirfvO+LNB+MyRNdG4qK5W+3coOrfO1ymU4EWrRMSGpYsm6wUPoNXLJZc+J325hMt5I6MLloAokk6fr5+K/mxIz0Y0mfype0i9smgokfOqI5z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114289; c=relaxed/simple;
	bh=OwUXXLW5bnVA6CgFPa4V0u/Xs8mJMFpLUBeC6FIIFnQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=W+IVolmr063j1PsGaVY3fIgoFPDoaIG3HnBpTxP8Bez365+UoDmd37JqKau3zxt52W0RUrKyZu564eYqqfo9dMwqQufFg0SIUi/ZLeMrtqcBzBCgs0oRctPUl55393ceTe970Jm2V6DDR6g/3wCi6OHmSfHYKvVZMAR1CN22AqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/DejfHx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/DejfHx"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so3326124a12.2
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792114288; x=1792719088; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OwUXXLW5bnVA6CgFPa4V0u/Xs8mJMFpLUBeC6FIIFnQ=;
        b=O/DejfHxyPuIZqqa1F8HP4FjT22WmnBmlnl+zdcQl5uEQsINZQiiyJ0szS8zVXYRo9
         4b3XTuz2Og+SGMbJUbetjbFD77S/TRFfEi4Xijk9z61owlimZ+cfDw92GExP4XE6k0W6
         nHK1yyt571H2n5Xz1DKcXDwBbUkPgCWjEl8rM/xaWW+IVxZIkpcbHz4uD2UsZfOktepN
         kZIwZ80P9rW1y0dFhawzqZklksr3osFHKSinYb9a2gr2LetZlK340prnJBDJajusU7T5
         twbBuKpUazYC5XougWMwHAVjfRn193SQNw5B/qcYYZz/722bTzzL20FKaANL1eWaYXs/
         AOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792114288; x=1792719088;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwUXXLW5bnVA6CgFPa4V0u/Xs8mJMFpLUBeC6FIIFnQ=;
        b=f/EfuXsSnEG/FfXT8wCO7usMgnXbuaBl87hxsV6C0GdFMTRWN4wNhCsVorHAOrj4Fu
         fgsqgsOed40XK4KASvEYOF7/FRNYNVtltA3sdeehi5xMxWdvVHBOyAlKIyy7djhoO+8h
         yHv2IxsSXGqPkhnunwhwmdDvKlmVAkYyVUQQvdhcGQXeewev/IIJJZUPEdCV/Z3DF7wL
         ZpOMwoIDGKguzIvxfa5JDSA1It1nzuSojULldGngcTaU98UltSaFGMKE381GLheRxQn8
         6IcqP+gwDEYhNhalIleMZpCXbky3PThEFk6wt/em2npFAzhI0gOKmRHfJr37rWgYMhIQ
         uClA==
X-Gm-Message-State: AFq9FYKNCb8ElDJA85malTEWpsB9RFjUdxmdHrs9YJMNcZe/6fSu3hVb
	RjJN2k2cFgYvNLbNE96/Ys9DF9eJAqcFLtfqAIxre+teI5W/6ItlMyvp
X-Gm-Gg: AYBFou2v6N6pGdUCC/IDOKTEy/V/y6ozWniinGe3/xulFBv1SXrG2KkC1d9FQhKHRpz
	3XuQKjqUUXDkPSEc5gKuUiSBzJRGlfQaDfy0/49JADnj9jczDKG/GicmDAbE+WHqiIq3W0CPuL5
	UHYYXdHPPbIJaihlgDXgDg4Hhv8wS55CHtyPKl/E+HM9aGFZ2n5UhDeAW7sn3b/kgwQx9znv74V
	/jYGod06gFSH64tca6J6fvyOjd6NJIek3SWUrG3F32ta7WotxCfvRDkxoYXQxUNr2/xuZtyNTUu
	3jNVRIkelFO/NrWln4ny9YvDKdcLRc0gt+phAYSpRr7nD17PmWSisowM2Jj7AKcjRf0y2duzPFT
	ClcJ9n186TxHf171G5l1I1JVNUyi6SXNpGBx+WFKr8soP9PdfesxM32/dwzHOXa7zEyZ3wFEI7w
	ciU79OCWhT9a41omDJ4Y5bhHt5IzzcbkOgu1/kDCSNmAVK1/zMXwrJJX60s/VqyvgG3rNiIr6tY
	NwHSdFmIYzX1UV3+OE8mNjrAamVTqRi9EwnxaV8QM0aSnqlsxk8a6HpQF3N/R9U6sn0bmmv3QXR
	6i8=
X-Received: by 2002:a05:6300:6d90:10b0:3e1:6c6d:ffd5 with SMTP id adf61e73a8af0-3e16c6e02f6mr11983162637.33.1792114287475;
        Thu, 15 Oct 2026 18:31:27 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f51f26324sm335024b3a.0.2026.10.15.18.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:31:26 +0000
Message-Id: <DM5VHTPNK75L.25IC5ASG1QDJ9@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, <kkd@meta.com>,
 <kernel-team@meta.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-7-memxor@gmail.com>
 <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com>
 <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com>
In-Reply-To: <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com>

On Fri Oct 16, 2026 at 1:24 AM UTC, Kumar Kartikeya Dwivedi wrote:
> On Fri, 16 Oct 2026 at 03:10, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Oct 16, 2026 at 01:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.c=
om> wrote:
>> > it on, as the tag says. A tagged member of an existing struct thus ask=
s
>> > every program that reads it for a check, including one that reads it
>> > through a probed pointer and relied on a NULL dereference reading as
>> > zero.
>>
>> Commit log reads like BTF_TYPE_SAFE_*() can go away one day,
>> but with this change adding __nullable to a member of task_struct
>> breaks every tracing prog that walks through it without a check.
>> So the tag cannot be added to existing structs and
>> BTF_TYPE_SAFE_*_OR_NULL lists are here to stay, right?
>>
>
> Well, BTF_TYPE_SAFE_*_OR_NULL also enforces a NULL check, so not clear
> to me how using the annotation over that will break a program (see
> type_is_trusted_or_null() usage). The only difference is that this
> annotation works with type tags applied directly on the struct.
>
> The only reason I did not drop those macros yet is because our
> baseline GCC version does not support type tags, once we move to that
> point we can drop both the macros, rework kfunc suffixes, etc.
> sched_ext is fine taking that dependency. The tag when specified on a
> struct member directly will do the right thing, just like
> BTF_TYPE_SAFE_*_OR_NULL does.

Got it.
Can we start moving into this direction?
At least for clang compiled kernels we can drop BTF_TYPE_SAFE_*_OR_NULL ?
