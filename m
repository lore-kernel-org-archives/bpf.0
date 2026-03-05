Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98F26ED40
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689265; cv=pass; b=H0FbtHF2AZY70QyRu2hN/XlyR/2kIa8mr4+xgdvlpQpa6YsGZqeDZwPiIcbtY6SJHUtRpivqAyGCDV7gtOpPlmnlU0Tdc6e0iew4mHVDb/t3fVAgPmUAPumheCPg2l9LH/LPzV5rYTQS3ZuyZL3IIpkTvvyrfhezA3t1Sr9/1Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689265; c=relaxed/simple;
	bh=M27Yna8X0zrfWHnR+isYLz70HtJwqqK1k1ckUICdl1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb13TGuvLJW/ihI49O3m9Vaycq7KkdiPneZQ2jHsOscJVwulPpvY+GQWKxEbboVzttL+rMMkgODg5tlvD8QNd0vSup6UwjyPRMah+KbsMasfQZIApgnxy5dngotAdJ5TArEOwPqDuQSH4Ic6hvss+6uT9ffoRXhFjqUJeL++38w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nps2Sm00; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nps2Sm00"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986e0553bdso73462057b3.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 21:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772689263; cv=none;
        d=google.com; s=arc-20240605;
        b=WOHx0UtpE1e2azmq7COiS09Oa79B7Rc1Onl/S2b1k8hPnndAtQmoEtqzipotiS5HKo
         IMW4iPIVRRY7p4yetbZnxTccKTPXv1wnLx/QNRYzXSj7TgjJe3yuVK5Npg/4z53HNXtQ
         MoEh75zNA+B2njm/9g4O2dSSn4hW/+EVDKsnWToFn3DkLxzENthJqNGFyXp0/nh5mH2R
         u0IbOdDt4VHu/Jul573OCZ7B+907rpOspqxzuc8ASXGx7iowkMLLwJ790yudo/69pS+j
         846svrBi36gg2C0uWkm+sKobAetYq3lCXXL93XPGCQPpdeJFY41AoCtFXbP6N9NHz85C
         omQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5lViOhTQOc97pGXCTK5Bc4leTHHVImkEt66j97PSp44=;
        fh=0qZM7vONpaCee0QN5yIcqdOdjI/foMsW1nXj1piZfG8=;
        b=L4xKsbUSQRK7/YXfzDDHAma0MXX0DUIlhE6SOQY93OhAec8iMejIUfmj8hyTCk2HOx
         XTcdCrbmXXX7Rs5HbaBBNBhjhCYCDsX/xke4/Uudu4jLb0C9WncT6lSlO7/3T0uXbkkY
         q5N9Fp9q7leSY4vdSnNbnmdp9LxukCsfH1VGBQD9RalOc8qXHM0aJ5GGuYvdhi3kpuFt
         Llf6okP3USMLX0Sz1IVqXShyfBfbjVGFKT8LqL8A18zneZhd6iN/lufvPoMGshOw47Tj
         o4E6nvzSm+YjfAOoHl6s5qvmw7xQHpfoQu8k0LobZHxTthg3PCKHava1UFVo0v7xwZ1u
         jNBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772689263; x=1773294063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lViOhTQOc97pGXCTK5Bc4leTHHVImkEt66j97PSp44=;
        b=nps2Sm00SxUNhSZgi8NMp9co3N4o2zS+phWsf6o3zRz/paU8T/4mmhnrtVSADdxB0e
         JwH03ltlVKUW558AzYGVVOWsHhESz4tK1YCYw9MPSuiT9uDBWHoxRy5nhdq0MFlNFzyc
         LFop4jHMxkJRjyjiYek+KEmk0HooOwATOWPGd3RO6kob/YgVzSmeqnJJKLkyPDqXDj/G
         5pN/xrlESiNLv5G3Xv75HkQbiY68JHWt46kCkJy2Bcl0U+YikR9+H6O8/YK8mQLIAIk6
         m8eZkEseiLZV0lTAJlkTI43fZ7TALcDN5EFWCYZtJoMwI1LhfcJc9tfOahjQDuAq67OP
         auqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772689263; x=1773294063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5lViOhTQOc97pGXCTK5Bc4leTHHVImkEt66j97PSp44=;
        b=dJAMb7gZy7ZAlFZi/2/l3ErEYdY8ikFxd8Ipig5KDto50H7aIFLc6eiQAAlG5Ar+0J
         vMGYeq09bEymRzGn3bAQB8XTDwQzEiEzRU7VAZzNjUrY9TOGyYf79hKRPR8d/iAUPt6C
         chMt3nE8xaFzqm7ZrQhjDRM6zLHdIxCZgMk3RvEqjdwposj72ej3CBpSY5Fn2uvZrsZA
         Waq8CuwWF9bIuGWU8NrtPvDYDNwybZ5CEYipmzRERqsXlWiz/njy2KmfEGEbPkJy/qiz
         rxRqf8SBFNnM1rv1ovL9sJTeMJ8M8ArHJokm58wRH4ZhnNwSHrSH1fSUY5t+jQVBvXhV
         L/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVW7tmk92xFwVGTpmCl9OWLf5Mzrn2aa7+YKl5MXlvHgu8YE7OVqWFBR8p9ZraaxriFeR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgC9qWthvPuGAN4RMQOszAXuhbj4mvhvIS8pGHyikMmElQ/LS
	SFNwC8pCkfAU/4brYdAI2p7Ch6IvinZ68CxVpQW59/oi/l1hod1EnUaswmSAyQPibeTKsXIl2Qi
	VG60mOSRwqu4Bv8Hg9haj6n5+GIpK2Rc=
X-Gm-Gg: ATEYQzyYBpeaOPGqgcdI9wCCEqsC4cWiVyUoY+UYeZrDZvvSa0puITW4RpsieziCY8B
	XomffkZQuhfKvSJBKanzW6N+m5TFWlEbjcg6uM13VxarqiQn7cv1yWcbYlxtBn0EI+aqLkCS/HQ
	ChKr2V1+7QvsoKqp+aOEGnV2XTt0C6lWOlOGN6nNCysfiUyMyXcWXiD0fKlUubspS8VSjBWVylV
	EW+jah7kixw3oQapF8lxqCzhkZxZ7wg8Lqqnj+VV88Sfg4nDJJfKLDZ/NfuzQqo27vYePPPs0v/
	GijJuSqQ
X-Received: by 2002:a05:690c:385:b0:796:1eee:b8f7 with SMTP id
 00721157ae682-798c6cd98b1mr37817047b3.58.1772689263197; Wed, 04 Mar 2026
 21:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin> <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
In-Reply-To: <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 13:40:27 +0800
X-Gm-Features: AaiRm52WUNKOCQbYrgnbjmYd-Z49f36R1X6n1pZRrztpXr21tW4EoYW1PsKhd0Q
Message-ID: <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Waiman Long <longman@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, David Laight <david.laight.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 12:30=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/4/26 10:08 PM, Yafang Shao wrote:
> > On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> >> On Thu, 5 Mar 2026 10:33:00 +0800
> >> Yafang Shao <laoar.shao@gmail.com> wrote:
> >>
> >>> Other tools may also read available_filter_functions, requiring each
> >>> one to be patched individually to avoid this flaw=E2=80=94a clearly
> >>> impractical solution.
> >> What exactly is the issue?
> > It makes no sense to spin unnecessarily when it can be avoided. We
> > continuously improve the kernel to do the right thing=E2=80=94and unnec=
essary
> > spinning is certainly not the right thing.
> >
> >> If a task does a while 1 in user space, it
> >> wouldn't be much different.
> > The while loop in user space performs actual work, whereas useless
> > spinning does nothing but burn CPU cycles. My point is simple: if this
> > unnecessary spinning isn't already considered an issue, it should
> > be=E2=80=94it's something that clearly needs improvement.
>
> The whole point of optimistic spinning is to reduce the lock acquisition
> latency. If the waiter sleeps, the unlock operation will have to wake up
> the waiter which can have a variable latency depending on how busy the
> system is at the time. Yes, it is burning CPU cycles while spinning,
> Most workloads will gain performance with this optimistic spinning
> feature. You do have a point that for system monitoring tools that
> observe the system behavior, they shouldn't burn that much CPU times
> that affect performance of real workload that the tools are monitoring.

Exactly. ftrace is intended for debugging and should not significantly
impact real workloads. Therefore, it's reasonable to make it sleep if
it cannot acquire the lock immediately, rather than spinning and
consuming CPU cycles.

>
> BTW, you should expand the commit log of patch 1 to include the
> rationale of why we should add this feature to mutex as the information
> in the cover letter won't get included in the git log if this patch
> series is merged. You should also elaborate in comment on under what
> conditions should this this new mutex API be used.

Sure.  I will update it.

BTW, these issues are notably hard to find. I suspect there are other
locks out there with the same problem.

--=20
Regards
Yafang
