Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B44086B;
	Wed,  3 Apr 2024 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121675; cv=none; b=GasC4uLe6wsK7lRhF4UgtxPVJaUaE5oEnYD4aIhyMp4x+nvXfSvtR+RTpEjojv6zh67Fnov7sB2ONXgN9b2I93lNZcFvhWgD0x0JzFJhOZ3PqLdhbPItLFzh2HHfcnKbJUbwsRUr99JOJSCASSYCDXziubQh/cXO3THSDZk0o+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121675; c=relaxed/simple;
	bh=Z04dXfqhQoPka3kWZ2rCAbBw5YWEqBvOumRhRZjQBps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soq0Yq6mifaPhgii1wnX0ndb0fCH6s0yOVLNOkXl5k3zGFynCRRKSxDWgHOoONM+QcgJT79Dl1NmSG4Sn/uD+0Nk3wkPfTmZQB+G48MIaDpGPHoSY7iODAqLGgxVlQdDakYhu96WvVBbmp+fOHqIvZMkUi0OHbQW3Yb67eyeIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2UgVxqZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2UgVxqZ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a297378cf0so206732a91.1;
        Tue, 02 Apr 2024 22:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712121673; x=1712726473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoSiAxMmd7PrX2Im9r7GPLxnlY6pQxrAQtsoyEBgojs=;
        b=E2UgVxqZtVliEhjDU5kIi2Wzlk1Bs1dj+WI32S6eS3cY4wsZSnfnguTCyuVV8SCCUt
         JRr423zbgWbx1l7wALm+W9QsgjBe13lsG+gZJf/Twk/bJFsD+rxLLFpF5Pv1xNEpMwbZ
         nHGXfz4aJIMrfQ0wkMTLAkVqIDOcQ/MIV946NkkZEbSvU2pEuR6X27fvbrowVpsEu/ug
         OWxjvn3HArv7RIzOUBJ8ph5xAlFBcZmFp9tD3xFu/laa2L2ztNuTwzTdB5xrDlnuwbET
         ePI62n0dEklGQLszBsTK6RaS4rZzSptjBnIz81OO+KTi9smMzKrGCWea6Idgvy19fAYp
         WLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712121673; x=1712726473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoSiAxMmd7PrX2Im9r7GPLxnlY6pQxrAQtsoyEBgojs=;
        b=TPLq0im8dtvkzTyhZcL4usweKIYNi8/WyY0LAGHmwqn30k+h9K1CNbBRZAC5Yoxr+D
         MtaRvl5NxQFEbGK8ltRcomLuNG1FbrtiOsQshgYI3jjDysC+DYbl9skOJLBl4xwGMYMY
         K3PgufckWKIb+0dIObYuipi82xPHBe7K2HbpL6xgwWJKfFPJbC5v+a252hMYSRGsK3Ni
         IMhF2vHbpym9ghaMM9DJvQvv22aWeZDi+UGvczA+3b8ktopesj/1/HBX2/T3GOWpR0i6
         uSH6QQrqJzqcHzazcuiARP7Jv4oHJYBTNafqk71gGd0Edy79QKl1OOL7/BzResM2flTw
         70IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYw986qk2oZQXb2QwYm6V8pU0tLuddRN25qC8i+r72+h1us5xDaNF+Anv8A9UrLbZZ+75azoY6PGviHpMYKAguoatZUgM3/E9zmf0yPfJaRhmrNxgedMtTrMPeo5VnCpsdM4I31KFU
X-Gm-Message-State: AOJu0YxRVZl2AZumfL1BjU2zPpMN+cWYJ+8OHmfjIySj/oFcWOsNd6Cc
	hT845SC8wQmzohykUmkOStoERjbrmHQrrFdkSNijGV0M8Iam0ck6oIS+Z2E9LZ38RYBGwFGkhDK
	Euo8LNDAce0eZ14gt5AFDmbJ1szNAZ720pwk=
X-Google-Smtp-Source: AGHT+IFmw+dNkBpNGR/lr+Wwal7rWFu7MeELy85xRmamPutQ0897FhcZ3Z7O7GSUt+yOQwbl+sVA86f+85YrJJKy+/w=
X-Received: by 2002:a17:90b:1954:b0:2a2:69b9:78d7 with SMTP id
 nk20-20020a17090b195400b002a269b978d7mr2674901pjb.17.1712121673391; Tue, 02
 Apr 2024 22:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
 <20240325181338.39376089@gandalf.local.home> <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
 <20240326150121.68e9db8a@gandalf.local.home> <20240401202552.470d845bd79c841b9158fb56@kernel.org>
 <20240401120918.67cc3191@gandalf.local.home> <20240402093839.7de89341138748f743ae896d@kernel.org>
 <CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
 <20240401224733.7a9bcbb6@gandalf.local.home> <20240403094048.3a443fbeeed551f11c1970d8@kernel.org>
 <20240402205459.297c4206@gandalf.local.home> <CAEf4BzahMFsdN8QvW6XiUk+3MzvLUjudXO5=qfhKBYfDvEgy5w@mail.gmail.com>
In-Reply-To: <CAEf4BzahMFsdN8QvW6XiUk+3MzvLUjudXO5=qfhKBYfDvEgy5w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 22:21:00 -0700
Message-ID: <CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:00=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 2, 2024 at 5:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Wed, 3 Apr 2024 09:40:48 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > OK, for me, this last sentence is preferred for the help message. Tha=
t explains
> > > what this is for.
> > >
> > >         All callbacks that attach to the function tracing have some s=
ort
> > >         of protection against recursion. This option is only to verif=
y that
> > >=E3=80=80       ftrace (and other users of ftrace_test_recursion_trylo=
ck()) are not
> > >         called outside of RCU, as if they are, it can cause a race.
> > >         But it also has a noticeable overhead when enabled.
>
> Sounds good to me, I can add this to the description of the Kconfig optio=
n.
>
> > >
> > > BTW, how much overhead does this introduce? and the race case a kerne=
l crash?
>
> I just checked our fleet-wide production data for the last 24 hours.
> Within the kprobe/kretprobe code path (ftrace_trampoline and
> everything called from it), rcu_is_watching (both calls, see below)
> cause 0.484% CPU cycles usage, which isn't nothing. So definitely we'd
> prefer to be able to avoid that in production use cases.
>

I just ran synthetic microbenchmark testing multi-kretprobe
throughput. We get (in millions of BPF kretprobe-multi program
invocations per second):
  - 5.568M/s as baseline;
  - 5.679M/s with changes in this patch (+2% throughput improvement);
  - 5.808M/s with disabling rcu_is_watching in rethook_try_get()
(+2.3% more vs just one of rcu_is_watching, and +4.3% vs baseline).

It's definitely noticeable.

> > > or just messed up the ftrace buffer?
> >
> > There's a hypothetical race where it can cause a use after free.
> >
> > That is, after you shutdown ftrace, you need to call synchronize_rcu_ta=
sks(),
> > which requires RCU to be watching. There's a theoretical case where tha=
t
> > task calls the trampoline and misses the synchronization. Note, these
> > locations are with preemption disabled, as rcu is always watching when
> > preemption is enabled. Thus it would be extremely fast where as the
> > synchronize_rcu_tasks() is rather slow.
> >
> > We also have synchronize_rcu_tasks_rude() which would actually keep the
> > trace from happening, as it would schedule on each CPU forcing all CPUs=
 to
> > have RCU watching.
> >
> > I have never heard of this race being hit. I guess it could happen on a=
 VM
> > where a vCPU gets preempted at the right moment for a long time and the
> > other CPUs synchronize.
> >
> > But like lockdep, where deadlocks can crash the kernel, we don't enable=
 it
> > for production.
> >
> > The overhead is another function call within the function tracer. I had
> > numbers before, but I guess I could run tests again and get new numbers=
.
> >
>
> I just noticed another rcu_is_watching() call, in rethook_try_get(),
> which seems to be a similar and complementary validation check to the
> one we are putting under CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING option
> in this patch. It feels like both of them should be controlled by the
> same settings. WDYT? Can I add CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> guard around rcu_is_watching() check in rethook_try_get() as well?
>
>
> > Thanks,
> >
> > -- Steve
