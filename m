Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976541E6DF
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577122; cv=none; b=uy6XevHcuPkmBeMlrzfE/o4N0Tce0AZw3yWvkVnPa/Q9j7UDhlGc+x3LkMgzE5KLy/W6a9KcgwlMg2c1xvppvAA4nztwXzLzMW22Af0NKjR6ihen1bpsts5Ljkz3m1dUhB7u+2MMJ6mkyN5flduJVWnW05S+FVxtuoclIIHFp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577122; c=relaxed/simple;
	bh=UoDDENVMVF5Bz2fZwHd0lFydgvPhiZFqNxWecRPzuk0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ksmtZqw7XxU8YkkpZsXEa1W8aNLFvu/PsAm0UWICD11lusZQURkNgw2bpEVf3jcb6OPh6JdBQVdFe6HQg0Y9/bXtS0zVEM6rejrAbfu1oAJroqBJgVsG5Ai96/1jgZwaaP3xcAcPykURukY765KByQ5b14T2mYjj628dKAOHcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZzFvAVc; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZzFvAVc"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c1c5cb0f9f1so165660366b.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787577119; x=1788181919; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UoDDENVMVF5Bz2fZwHd0lFydgvPhiZFqNxWecRPzuk0=;
        b=AZzFvAVc4/abtFv+MghODW8LNTapD/MPMAerkvoZas6krUkY/Yc43Ma3d7Of9dijpQ
         bcPGOMsU0W/1K8DzhEo7kzLg9oLa1ucO6LcpFFG0mEO6YbmeasAnYKQKpaPUhHuRF+/9
         TqzJx1rhqbrtSqx1RwrCoPnWMQWsrNSMkeBq5ysdDke04i1WcDRMrmbz1Lp4XjGescwm
         u0hMidZeKktJaP0i2Q3PtBLQWt3qXZDVDPyiz31MKktCK/S2cak4ijK0i8GMTTtbnsFw
         UEKMMngmbvF6w/ypSTzzl6nruxoDcZITvYaBWu0V7/llEnPp015/B7i1bD67CwYfKaan
         AG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577119; x=1788181919;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoDDENVMVF5Bz2fZwHd0lFydgvPhiZFqNxWecRPzuk0=;
        b=QcP5aLE7TC3y4LmhDirzjzCCzZp9q10JUjKr+MKq9LfPtuvgUDTBiUbPzxI6HQZU9l
         pPoMNEnqRp4AIuICqrgobk4xrrgIDdLKVnqR9FfHBLsXbqYofzLgMeI6Tx8548Q/esnl
         ElbUp7i8phXtf+gFKVSwC/7LCv3X4vVePkrH3dH6E0N1Shk1rXz/kXOZpQ1CDhvBCMNg
         XTcd5ixqc2gzBS0/pAIE5bYugvm8+A56OZM3uRsvSGjpOATexn4nkarlt68tMI8EQHZV
         MJ+XKHnrrdvJaJorpaAbaRJu3BUk+C0zuueSrHEJX5RfLBBxV5nzWgUbLaimLqis9kKs
         vJsA==
X-Gm-Message-State: AFuF++nt+9OjWsFVRzXC5FRFNwiGC6PseGew3MnWNxbvuhArMYAUBINi
	u+WZCTULw+7yNab+q45oe/KRqAxHnPcsNGd+G5bqXAfkblQM7T34Xmgb
X-Gm-Gg: AR+sD13W72pd+CV+QBfv38sKULLWo02KDuWsmg+awc6IdnNojI5ooDb1e0Y9+OPXRz6
	zfWGlJdpzUHZOmyMXPCt1Zga5dFcL/lza6TdU3wmRsBNR2aqYcbUsFD9EjsRqqtMCRiutDjiaYP
	xQISiXkEhHuABd5Cd+o9uEJAh5NRr783yr/Y72LmrthqU6XfnPzGOPGd36PtELAZl2HPajox0BC
	fTBzQyHuPZJpXhAgO76Qzu59FfRle2hxhnh7oRG2ToPLxBuQHJ32Yx282kM91neM9COGLepiK5d
	VG0f67DGnr6njRICaCrCQZbG2uqbIA3nVA8XtvWpt8d+y6Uy+VID5Y7A8AO9SsWTvxaUXMMoLNt
	qhuW2Lg2Dv9fw+j/+gk+ewLOE3FnGu6JX0THCpR6e9BYKE/1qjF64S1vca87WiWpvwTEwx3rdpq
	Ly2ZBGkKInAO6Y+/U0Jr1Jm0mT08MVM29iDKOWH1ttZGzx3/Cb/c20AvpWUou+zyqTxcvO4fYaZ
	uQ5wTzJSHJTPNeUkkOP9W7ECv0hcTafs2h8c0mm8dhde3LsMikhwVNAdzlg8UK89x8UFcjAyf1u
	aErdG8o64xL9Zqbby87U2tyDLt4=
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id a640c23a62f3a-c2492797eb0mr2083634066b.24.1787577118741;
        Mon, 24 Aug 2026 06:11:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496295627sm1207740566b.15.2026.08.24.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 15:11:57 +0200
Message-Id: <DKX77B18XF28.LG3DX8NUFQGI@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Michal Hocko" <mhocko@suse.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>
Cc: <bpf@vger.kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
X-Mailer: aerc 0.21.0
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
 <aow4YNCDa0gDwbfj@tiehlicka>
 <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
 <aoxAo6gDK00PeCzG@tiehlicka>
In-Reply-To: <aoxAo6gDK00PeCzG@tiehlicka>

On Mon Aug 24, 2026 at 3:01 PM CEST, Michal Hocko wrote:
> On Mon 24-08-26 20:44:18, Jiayuan Chen wrote:
>>
>> On 8/24/26 8:26 PM, Michal Hocko wrote:
>> > On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
>> > > bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
>> > > conservative guess for BPF program context that is always false unde=
r
>> > > PREEMPT_RT. So even a caller that really is sleepable gets the
>> > > non-blocking allocator, which never reclaims and never engages the O=
OM
>> > > machinery.
>> > I thought one of the main motivations was reentrancy. As you cannot
>> > really assume the context bpf_map_alloc_pages is called from there is =
an
>> > extra care needed so that this doesn't re-enter the allocator from bpf
>> > program called from allocator path and deadlock.
>>
>>
>> Agreed, bpf_map_alloc_pages() is designed to be safe to run in any conte=
xt.
>>
>> The commit message should be precise.
>
> How do you achive any level of safety for the _sleepable version? Vast
> majority of the kernel is sleepable but that doesn't mean this is safe
> from the mm reentrancy POV.

I think it will only be invoked directly in the arena map fault handler, wh=
ich
runs in task context. If an interrupt occurs and tries to allocate pages,
can_alloc_pages() will return false and it should pick the _nolock() varian=
t
which is safe against reentrancy.
