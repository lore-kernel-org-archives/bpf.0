Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE9382F32
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625164; cv=pass; b=qkkuP7DdTragrGggBRaFzKwiIy4M8Qa6uTT6d1+m8GGUHMJYi9/tTGXUUNUmDowFSol1UuFv29wICrWWM41qGHLL4WeoGQ2rNZYCJfKOxNhmiGSw988SJ74HCPAeJrYT0OPAAA/+pf5FIbLSyQhQvZRJt5Pz7CyJFbemsrjW3N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625164; c=relaxed/simple;
	bh=VekVx6oVI9uxYLcdxQxGgO4u8pOxcIL9EWHkrdmTRaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvrY4vcqqghxQ0DQhFcIwGtIH41nXCaSVUCwsbv5N3GuRZllNTlerk/1zpSP7I6dbZKFkndPLfoxrQ/tA1edIxivWCjDyrCg6JOA2lx80MdNfBUyc/K7vCBlMq9416SQAiy4cHSY0s176DiTgcQnF/z5n1xl2gK+M7t0HAb4dPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffyZhS4Y; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffyZhS4Y"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7986a347d4bso66001477b3.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 03:52:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772625162; cv=none;
        d=google.com; s=arc-20240605;
        b=DpJ6wFYrgcUxjVelCiKNjEuxphGiZ0khuCjGBZ5TSeTdOXptUk0xsqO3f9s/fg/i5b
         ZZSCKSkp+M1aCcsBoPLoNzYPO5iWICp0Cej7LO7/PJrZp3C6zNTMg3Bemcq7//+/KSQc
         OZ8LJeXYMiQArWWVjIcKFSZPIbUd49wjh+9SvSmZZeHrbDRd2hrtNBUnxI4YU87ZwDH7
         Ev6ctkqGXOYDMcdkS+5LOOjs/nx+9fI/03L7dmgVxWu4C4NRpuJh+/pFLIdy9IGg4k0/
         4d5euOhiAN9kJK3ilGuFSdpRW51qUXYh4OzEilqMKdCFph1CK9AKs9ZP4mBdBQ8URcDf
         CfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E4bTnoKyYg+ZkPmDWt5dwpptrcP5N3axZAvJuFi4GqI=;
        fh=9X4j6YyEB2Y6y7Xc4hfDRxx6rkjCuDefVphpLPUJsEM=;
        b=HRsqZfk2TMw2DjhmO0DeKxeK++mZoCwLXWpzGDdyBGg4AD31AmZSXb+oTEqq8PdZy9
         cLhSGuMAJrVOBG3fj8WbZEyc2UqG0X7hhmaq/+cseYGXUcbSEtJ+lB8/432L2CKNrQ2E
         WV0WlZ/9vrYeTDy5uKzlPVwrKhFA2lGK1059hznlACsTo3dVGAjan7VPIDm4FuAB02yc
         ueJjIaJ84RFv5Vo72aq6dR8KtWgSZyulB4E1h+tO35PaHeuTtJECrEbnv2BFXRWfJYu0
         nkxeBQXHKB1hBNqr+gFPOfdjhh/LlWcIree/ToTEMTvyyAzfBB0p68vzq4XdXOq2OU8a
         Qugg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772625162; x=1773229962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4bTnoKyYg+ZkPmDWt5dwpptrcP5N3axZAvJuFi4GqI=;
        b=ffyZhS4YpITBZnfOqgfFr3FPdzVLMFxdJwWxlrFtDd65+Y22Vw65aXQ9iHc9qLukB1
         j8wMw9gHk0Lweu4JGs5WPsJmg7KvFTN1o9Oqz1+BWHLF4G2c+ClRRTzk+Uk72Qq05/1W
         n7tWya6JtG0GOhpnEz1HjaZuU9ptULpBWIl+hyHv7SXjM/nb9AVCPqMAhljv96q9rSUT
         WsRSY7ouR/urMgckM6jo1AlL+qrNVJKFcQvJvxm6qFhfygpKPpyiTFBi79/q+7HnPXqt
         +hSmDg8ARzZNN+21X/z55FVzAs0WoUsEbOXjaC9yyKzyn6ziP/ub56KWQVy2kfpvq6mG
         yP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772625162; x=1773229962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4bTnoKyYg+ZkPmDWt5dwpptrcP5N3axZAvJuFi4GqI=;
        b=MnhJNUdXpYEY00lIOb8b8+NwW4uEhpRKduH6nTistplPqU4rwApKHGJuqMwA69d5/I
         LS+YvA9UIo0TsK/ftSCQggwyxmuXtswjB2j1YPxPnKkYmVb5rNxJ1fVirQ+qLuU+dZ8r
         rJAsLj+Prx8SbkZFAkLOQbRvvZ0ShuJ+WUL+LLq8hxTrdr6ldU8dXNd7cnJqqvlpU7qh
         zvNutJ1+sjALcTscTxzXc8HN03EZ8/6c15CLJYvPGn/3lmcDlXndfwfRRyYys4HjpyVd
         RH0QfPMTqwxKYMxTzm7U8v1ismMNeSMcrE8K+My+4k7fbLL3D+lshV8Bjq1xb+BzZg8I
         /wuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRkh4YOfGw0wuxYaAeJn3mceXex4UXczfXcVd/VBHCrueTqVRxDzMshoG4moZtllYr0KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmf2W8i8xSiIORGwgbJwAh83UCv926OCj0t/+ZgXKcrtBGOxz4
	uLN+oUWqqFEFyP2RhWPIEVbvJ8ScAChny37GDC9mpXyfa8SjxCzOJI7UsozUBWq/0rcBnfLwHAy
	NXripJGfGGxcJQW8FKst0eLfcWk2s7mM=
X-Gm-Gg: ATEYQzywXZCZZQrpueVM/Ciq2SNyKKtKBbhgBSpWY63Xguccr655O+oM9MXFNq5DXzP
	ORgMdM5avYvwZXe/Ty3V01YMv+qMHylWXyzKEew59nO9+z/pCR8QVsYl/BnxvkVVWwC8W2wDKbS
	lV532IRwuHaFhxvKgm9y8dt5kXO6aRajzw0sS7B9xSHyAsFDOyTYHu95niHk50AuKpdGbFPxRK/
	mZSNv6+K2mgEP8BAnyTA4P94vqXJjUQ1VcHd303C6hSssYxNWZQo3md9qALh1iNHvrhMUNhZqXL
	VF894BpD
X-Received: by 2002:a05:690c:6184:b0:797:d1c3:fa8 with SMTP id
 00721157ae682-798c6cff6d5mr11616527b3.66.1772625162592; Wed, 04 Mar 2026
 03:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>
 <20260304101111.GQ606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260304101111.GQ606826@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Mar 2026 19:52:06 +0800
X-Gm-Features: AaiRm50HAnHucaq2QbXVGRKnqcxmQD2ibZjAONGti34NosYd6G-Q-R1cb7KsCTE
Message-ID: <CALOAHbDmmbcK-0mG=44rw3wbaTwS8drzYD-s2gg8g+rPQZNLCg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:11=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Mar 04, 2026 at 05:37:31PM +0800, Yafang Shao wrote:
> > On Wed, Mar 4, 2026 at 5:03=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > > > Introduce mutex_lock_nospin(), a helper that disables optimistic sp=
inning
> > > > on the owner for specific heavy locks. This prevents long spinning =
times
> > > > that can lead to latency spikes for other tasks on the same runqueu=
e.
> > >
> > > This makes no sense; spinning stops on need_resched().
> >
> > Hello Peter,
> >
> > The condition to stop spinning on need_resched() relies on the mutex
> > owner remaining unchanged. However, when multiple tasks contend for
> > the same lock, the owner can change frequently. This creates a
> > potential TOCTOU (Time of Check to Time of Use) issue.
> >
> >   mutex_optimistic_spin
> >       owner =3D __mutex_trylock_or_owner(lock);
> >       mutex_spin_on_owner
> >           // the __mutex_owner(lock) might get a new owner.
> >           while (__mutex_owner(lock) =3D=3D owner)
> >
>
> How do these new owners become the owner? Are they succeeding the
> __mutex_trylock() that sits before mutex_optimistic_spin() and
> effectively starving the spinner?
>
> Something like the below would make a difference if that were so.

The following change made no difference; concurrent runs still result
in prolonged system time.

real 0m5.265s user 0m0.000s sys 0m4.921s
real 0m5.295s user 0m0.002s sys 0m4.697s
real 0m5.293s user 0m0.003s sys 0m4.844s
real 0m5.303s user 0m0.001s sys 0m4.511s
real 0m5.303s user 0m0.000s sys 0m4.694s
real 0m5.302s user 0m0.002s sys 0m4.677s
real 0m5.313s user 0m0.000s sys 0m4.837s
real 0m5.327s user 0m0.000s sys 0m4.808s
real 0m5.330s user 0m0.001s sys 0m4.893s
real 0m5.358s user 0m0.005s sys 0m4.919s

Our kernel is not built with CONFIG_PREEMPT enabled, so prolonged
system time can lead to CPU pressure and potential latency spikes.
Since we can reliably reproduce this unnecessary spinning, why not
improve it to reduce the overhead?

--=20
Regards
Yafang
