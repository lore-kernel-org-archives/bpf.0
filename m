Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FB37E30A
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634355; cv=pass; b=moxHO+6XQSMp04Ze7DDLwYCHGnYicop0+k4htsMDT1T9jkaCLvL/kP9bBONrBVENU7/Ns+NL6GRIo64a8pdUq8T6conGMvxTuqiUnXFn7ccsnC5HDgMjH6f90iZaJcKOf/lG4UCUB1kWlRR0lMFfg/KB9Efnz3xmnxi96ZvTYPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634355; c=relaxed/simple;
	bh=rJTYxgQC+lQ1uoeB2LriF+FOQyxEeURNnM/kGqfyi/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3uymR7Kiv8cDwavx/GVMqzhgPBXb0uVltoTnjYRZLfYF8nnWQPU9V+vuD+I7WF/+j/dKnxCBNwzV+qPbJ9DPWTAmqZnJa23cJaaRb6RmOmn3K0VhwfoS/S9TloSCdIQqQ0BGG2pMspnr7Bx1SAE4NjEbn/sqkIkcS2TgiJSgAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=creBAhKy; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="creBAhKy"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso6434566d50.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772634353; cv=none;
        d=google.com; s=arc-20240605;
        b=QxvaizzDgjdWgJ8jDzVIsYvtZlu5cg/wBFPPJghxYcR5QXzPJptZppUYcdLnC3FXzx
         ArZyYcvd6MX2auhF1R8xoOedgUxfsV8L0B+Pl3ywMcPNa8UMiAYVp7xcijzGLzSkOyDD
         Zh23I3Si2qrHilRFR+uGqKW6MTkKdvnkOhFVl3YPUSgMEeawLy3+tPkB/0lXLbG5u0Bf
         U3GFSGfoZKEvdzHE6dlIo3QzWRZ4hHCd27Ns+5SN30sX/gvsW0w14whgAYSUsy/hN7Fe
         p+RZlSw+sgzqsIdy8JP+TYgMeuqCvLJ5/bFCOe8d4+bHTxfbmaWC0Zu/K07sO8OaQkC3
         +JnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z0zm/zFxMTgcfX8pnQDebzIcNOSzxcI0PpL2GvEUjqU=;
        fh=sBSndwXuHoLimSbZQiiE3XC5iKnoiFWCoiy0I6UGSIs=;
        b=JzSEDXTYr+P3x8YwnwUXig1J3EsC6iVgyIKF6RCsmhWq3Qo364k5skAkxCX8poVOq2
         5QcEuMzrpxbBt2KN2hHXrAwMRTbuq6NJOChWJHrM8LD/iGFkqM4OmEZB7trPgLVDZPf4
         aW7tsQPJWvIQhxLRhkMMQq1NirtBDdOZHhxw0Zxgp1ei/8aDdwRmqZLWBEIe4sF9J35O
         77bQORn4GZC+XXitoHQ2XGDoxH1Lwh/dNO7eyMmcN96sSmLDsmLT28dXl+BbI3VZhr9h
         zzrvsi53JyiwF2b058QDlSjQrZQ+e1cJ5fh8XUuIP368jcgJnQ9n1sh2gYGG8kT84O2Q
         ouwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634353; x=1773239153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0zm/zFxMTgcfX8pnQDebzIcNOSzxcI0PpL2GvEUjqU=;
        b=creBAhKyHkX3c0HDgjeKJzXTeGumZYv1sr4Ul9krpI0n9soGEnkWtSATyQk89b3RXH
         3buzhG2FK7RD/gC0KmgyB3LxHxH6VY1z12jfqn5ne8wrIykqkuM+UFYfNcivSvkoJOS2
         zGI7YQ4y9CwgK2kQgJIhq1CrxzCLp4u+V85h35KkyDoobfj0HOL8XAtHz7cv3lCtUmI6
         5TLmp7veJTrKKwzE3v4BT4I+PvF3hUszjd1fP45ZHuiA0p7pClluvG4fXIYWQyAxD1xu
         pGDIBq9Rt/yn8kzXsD7As14fNHsrtJ7RNKK0MNuyhX+Z7/24CLVvIGTLNZEXEHGKxuGH
         vHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634353; x=1773239153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0zm/zFxMTgcfX8pnQDebzIcNOSzxcI0PpL2GvEUjqU=;
        b=rAncsWsng5oBT8PrAcaXv3uvrgx1t3xIh9oMgfoCkDSUKo+GpQ3OsfTZcjOuKj55wu
         lwdbGFehy0v2ORcOyvSrs3U1xoQe2e4gSS1i4HtWJxTYu2skBDugCftp0oYkKdPCZXf8
         oNhkVv9MjkYomPLUsiXoA4lQ8Bns9zTy4Mp3/i6u8gytVd6s6voZc9fBNnNuPMClSelw
         4a8gMY61fyqWkHLdJybyePITqww09QlROrZ6pBKicYT7tDBZxNmyN6IwS9VA9mcHknjv
         +lJmZ3VLm58ALs9lLxUnOgxrT/wf3stCAtxX7IeqzNqx399K62g0xQm6KkwVCxfh2LMJ
         h/eA==
X-Forwarded-Encrypted: i=1; AJvYcCWJAg3JLs8nFHNPJ9hy/EsF7k3H8VYS2+1PoeUCIhXsVaZXld6r7I4h2f3rxO3Zl1LqGxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/Mp/LXVhoPMp4wZNimfCRG9pc0DqPo9+KETV4wvTONe+GJbP
	BtqG+kX11aC1XPgNpn7Gtm4lR0bxI94L5KkOOcrcyBUxQMRUKHpiKgmOeRzNSM5wXExfH8tceh4
	g4zUeFiVXUgFyov2T49CDsPZqgltjoMg=
X-Gm-Gg: ATEYQzycsiCA4lQETvfyrclGArpJ1lInEgqJD/Crwqkfp6b4r3DdcCjWJUXCO//mHq8
	JriXTEy7TNK4vtnkzaY3Tgbh4CCnMry5IEKyuX2zLl6Lq4yb0ngSYZo78fjrgcMbPdM2/dQuGZc
	zN5HGCF17ccBL8uX8y+sjLoYpCNgOBpNbkbdxA5SR/QdNMHAq58gnIPQpmhfncnw3RtUeuproZs
	zKwW0Acg8mWloCyUaky0VMIbT0KKS0HKy0zFS9I5VuuRuXwPVmddpBbEVAE2IfxxMXy2V0zihWI
	l7Xb0hhZ
X-Received: by 2002:a05:690e:1c1c:b0:64a:db50:faa6 with SMTP id
 956f58d0204a3-64cfa08d5cemr1407571d50.87.1772634352811; Wed, 04 Mar 2026
 06:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>
 <20260304101111.GQ606826@noisy.programming.kicks-ass.net> <CALOAHbDmmbcK-0mG=44rw3wbaTwS8drzYD-s2gg8g+rPQZNLCg@mail.gmail.com>
 <20260304124148.GA2277644@noisy.programming.kicks-ass.net>
In-Reply-To: <20260304124148.GA2277644@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Mar 2026 22:25:16 +0800
X-Gm-Features: AaiRm53hMCKvbvNXj58w9LyMkxop3_JEJwaG3KpE4kSPSeAFXGwBklmTAbdWw3Y
Message-ID: <CALOAHbDQP9gyr0R5YO1nCxsbw2tLFKuc4xz4UbbTEy7TkzrMuA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 8:41=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Mar 04, 2026 at 07:52:06PM +0800, Yafang Shao wrote:
> > On Wed, Mar 4, 2026 at 6:11=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 05:37:31PM +0800, Yafang Shao wrote:
> > > > On Wed, Mar 4, 2026 at 5:03=E2=80=AFPM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > > >
> > > > > On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > > > > > Introduce mutex_lock_nospin(), a helper that disables optimisti=
c spinning
> > > > > > on the owner for specific heavy locks. This prevents long spinn=
ing times
> > > > > > that can lead to latency spikes for other tasks on the same run=
queue.
> > > > >
> > > > > This makes no sense; spinning stops on need_resched().
> > > >
> > > > Hello Peter,
> > > >
> > > > The condition to stop spinning on need_resched() relies on the mute=
x
> > > > owner remaining unchanged. However, when multiple tasks contend for
> > > > the same lock, the owner can change frequently. This creates a
> > > > potential TOCTOU (Time of Check to Time of Use) issue.
> > > >
> > > >   mutex_optimistic_spin
> > > >       owner =3D __mutex_trylock_or_owner(lock);
> > > >       mutex_spin_on_owner
> > > >           // the __mutex_owner(lock) might get a new owner.
> > > >           while (__mutex_owner(lock) =3D=3D owner)
> > > >
> > >
> > > How do these new owners become the owner? Are they succeeding the
> > > __mutex_trylock() that sits before mutex_optimistic_spin() and
> > > effectively starving the spinner?
> > >
> > > Something like the below would make a difference if that were so.
> >
> > The following change made no difference; concurrent runs still result
> > in prolonged system time.
> >
> > real 0m5.265s user 0m0.000s sys 0m4.921s
> > real 0m5.295s user 0m0.002s sys 0m4.697s
> > real 0m5.293s user 0m0.003s sys 0m4.844s
> > real 0m5.303s user 0m0.001s sys 0m4.511s
> > real 0m5.303s user 0m0.000s sys 0m4.694s
> > real 0m5.302s user 0m0.002s sys 0m4.677s
> > real 0m5.313s user 0m0.000s sys 0m4.837s
> > real 0m5.327s user 0m0.000s sys 0m4.808s
> > real 0m5.330s user 0m0.001s sys 0m4.893s
> > real 0m5.358s user 0m0.005s sys 0m4.919s
> >
> > Our kernel is not built with CONFIG_PREEMPT enabled, so prolonged
> > system time can lead to CPU pressure and potential latency spikes.
> > Since we can reliably reproduce this unnecessary spinning, why not
> > improve it to reduce the overhead?
>
> If you cannot explain what the problem is (you haven't), there is
> nothing to fix.
>
> Also, current kernels cannot be build without PREEMPT; and if you care
> about latency running a PREEMPT=3Dn kernel is daft. That said,
> TIF_NEED_RESCHED should work irrespective of PREEMPT settings, the
> PREEMPT settings just affect when and how you end up in schedule().
>
> Even without PREEMPT, if there is a task waiting either the wakeup or
> the tick will set TIF_NEED_RESCHED and it should stop spinning. If there
> is no task waiting, there is no actual latency, just burning CPU time,
> and that isn't a problem per-se.
>
> What should happen is that the first spinner gets the lock next, the
> next spinner is then promoted to first spinner and so on.
>
> This chain continues, which means the lock owner is always
> on-cpu and good progress is being made and there is no CPU contention,
> or the spinner gets marked for preemption (as said, this does not
> require PREEMPT=3Dy) and will stop spinning and go sleep, or the owner
> goes to sleep and all the spinners stop and also go sleep.
>
> Again, you have not said anything specific enough to figure out what
> happens on your end. You said the owner changes, this means there is
> progress made. What isn't clear is if any one particular spinner is
> starved (that would be a problem)

As far as I can tell, no spinner is starved. The spinner and the
impacted task are interleaved, which is expected behavior.

> or if this latency spike you observe
> is worse than would be from running a while(1) loop, in which case,
> that's just how it is.

The latency spike occurs because the impacted task must wait for the
spinner to voluntarily yield the CPU. In effect, the spinner behaves
similarly to a while (1) {} loop.

So the real problem here is that we should avoid unnecessary spinning.
Is there any reason we have to spin to speed up the ftrace_lock? I
believe not.

>
> What is not sane, is marking random locks with random properties just
> because random workload.



--=20
Regards
Yafang
