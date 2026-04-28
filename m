Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCE21FF30
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367715; cv=pass; b=ro1+fStjbpou0fj4f2tfF86vKwuhbQcuby9mWsxs1XKR9hboKjVAm5qhlorsnp48qRFdKtmzJebeNUyu6V0BrOv6dcRNzbCBwIIEM4xh+hQ/IDAPirxGGS5kp1eYy1XB84oZVSGGRKyUgViNmKtkpmsepFdlVCFEu22Xem1XTJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367715; c=relaxed/simple;
	bh=YjqZEZx8tiCJ8VD58miLVFzU7n3mdJN57vq90O/bjAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDb3CSbSdrF6OfJ1fm9L2hVQeACxIiwN0mDS9lTjvKZ5spwHhp0jOiJbwvVWgCsifc186Ua0E4M3csm84jhS/ymIZ1MLQLTAEI1ZO2xn5upJcsWWhtjuEDkXEleH/s+Pkp1Q5tAaSB9fLJM9ZdNcDONqnjV8ylUY8XtbYS9O9JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAC8lOn3; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAC8lOn3"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67785ef88feso8961938a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777367712; cv=none;
        d=google.com; s=arc-20240605;
        b=espeha5UsG8FDFJ2hc/kV7QiWsTqDhixetdbatqdFUNrtqRX7EqVcsPxqweglWqDS8
         r4JtPuvw+EED1JQDHgqoRBUsohZBOvWODP8ArZ+JrdGg4iSOb+YmHy9V7mnQaPfKo6XA
         D0yTPL+XM4QGjO1C5zZgdp+A3c5Nb1YvjChK4pD6v+wOr6zwyosyhThrOZ14WCzFsTir
         na4REnpuhL6s/KxVOfA4j+l3f1UqYfczcrNGwUIURKYyLYeKUe3vLgH5Ud4Re1l/O0uf
         Z9XPJ9Wv//JJZpK6GMY9OZEpKerbZfZRLET4OWdyyC+wBPFLSDvcmpP//+dIA1c2OrWJ
         h1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t3FNQO31qqSm2wmYS0/J9by0pPUv6cNeIE+R9Z9aG54=;
        fh=PnmYwwIEyGc3uGnzLellVUyTXAaSujwRtCwQxVQ5pwc=;
        b=QMUWgq9r872qSmtLHJnPxrH4LawbcG2gww9gEi7ft6ve5xvQvST/rDt26c0z669vnn
         gNeRcDCwDvV8a4hICAZerRZ3MA0KrWj0lmIk23yk+yGS71/Gkik2qi8omQMhuRIGU++h
         OBEhmwcz1O8fRTDkYKyikVjgmj2UWoSzK73q3tlRitmXlxv20zW/+ey2zPDMXstg8BYt
         qtJBRocC2gQNpQjgE4adPc7Jx81NvwLyB3hOEDU0Ze4QgpJv/b+x7h1Ibe3f/qlK8R6D
         vAB5Nj+RriadUKM4juununb6v6o8UQZxkNnChvQoNaWVCykFKhS6IzDvZtTvfIP7/n+6
         UTEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777367712; x=1777972512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3FNQO31qqSm2wmYS0/J9by0pPUv6cNeIE+R9Z9aG54=;
        b=tAC8lOn3LwZA8UwHamXz2XmB2rRN+ekH4hNuX584z4XL2yK7o8NrAODM9X+NZisEKP
         YRQEamGSmUd4LOCgdzblN3AdPVG3wX+tts7pB5YyYcRZxs5k02J/Zw6BLtSfs9zH9toA
         65So5Z6+QqCKh37veMDsW/w+vIcEdqLlpYjqLjyHkP/azRE1jgKTvhnQ2YVtfehTkXnQ
         bGq5vecrNSEnZHpgDJny3fAXUjX6Ddspq426+fP0OjWfjsRHJSa/KrDaVxMQi3DorbZD
         AE+ug6L7MMW43qWb0lT6xtsOyRetqx8/dpZwo0QwTN09+F439gnhW6aBmvEZEmMyehk9
         13sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367712; x=1777972512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3FNQO31qqSm2wmYS0/J9by0pPUv6cNeIE+R9Z9aG54=;
        b=aoNnrUrC5mBBUsuwrozkeZS1Fu/GWpA2cj3DNyyzT3WeeY/eIGDWX1viYgwMKVq1wW
         Wx8Kh0Q/bd6mJgkpytsUb0ji/sBI5TibF7rRBTcwafOqILQKg58GYAjUQOMxmNOTJrR8
         JK9G6/pcOMaWD+HjNpldxKsbNv7/B/uawTWXXuJeo1AohsDUVkVybH/qwBLSer0X9cPI
         kIRo1QKUnLYGxLz5WorutfzGyYE5bKiPJxXdIElPbTSYhx+oTVH4hrwNhabi7uEvohdH
         k7V3hQhYEoO9k6jfuMdC1j4vhjQ7JAHG2TeKjk1wS7ILxLtoFPPjid+9guX7FtsdYPDf
         AcsA==
X-Gm-Message-State: AOJu0Yzr0he9olel/Khwc2k3Aynfw7QH+w6J5lNafxryH1SU13fwTnGq
	UnlnsZDNb/tZ0fAIQpruK/qm9bmpamg60n2QDOZyfpSAoDbi9Y9aruVLNyk3Lfbaa6TaUrxDfVG
	x3Fa3HtJGGjAgR6epWssEaSrhjyIehY0=
X-Gm-Gg: AeBDiev8+SDCUVEhvmAdf504tfepbu1omo4Q7HqTsM2/SySKdGlWN2vUZ7YDd6/AmPZ
	CXuNhOxwlSKEGY81uFJTDN6egSmlj5XotNNqQydU6PzJzZXlBlkKNEA5ntGVUdq73qhTz0ZBSTS
	uax6GSf49DTHdeWxifjKftBo2AjkUWtdq76/6v6txUES3qcLdLNUGvAdETrjMMwxkO/cTUSYt9y
	WmYc+VetlU2tlp0A+nghHyI27q1736jhqmcgg17YyvmmyTQtx2iAuL9x+BABAC4h/7qhi0ep1+L
	6XQFqFJ3GVzwiw/9
X-Received: by 2002:a05:6402:35c6:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-679bb04e47fmr1017401a12.5.1777367712243; Tue, 28 Apr 2026
 02:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-2-puranjay@kernel.org> <1e77ed1ac93e28f5ecb073ea7dbb4c009c81104148c3bb22a78d096e92b0656f@mail.kernel.org>
In-Reply-To: <1e77ed1ac93e28f5ecb073ea7dbb4c009c81104148c3bb22a78d096e92b0656f@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 28 Apr 2026 10:15:00 +0100
X-Gm-Features: AVHnY4IulzcwdVBhJdlh4VM18Hd4-Rqv5NQESETTc30678pBKjTc2WeHGzmSJzM
Message-ID: <CANk7y0hoLpLk=_RpFR9yNBud3ZS5az82Hh=SjCX=fRLbW0RGWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] selftests/bpf: Add bench_force_done() for
 early benchmark completion
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mykyta.yatsenko5@gmail.com, feichen@meta.com, 
	taragrawal@meta.com, ndixit@meta.com, tehnerd@tehnerd.com, 
	kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 1:05=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selfte=
sts/bpf/bench.c
> > index 029b3e21f438..47a4e72208d6 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -741,6 +741,13 @@ static void setup_benchmark(void)
> >  static pthread_mutex_t bench_done_mtx =3D PTHREAD_MUTEX_INITIALIZER;
> >  static pthread_cond_t bench_done =3D PTHREAD_COND_INITIALIZER;
> >
> > +void bench_force_done(void)
> > +{
> > +     pthread_mutex_lock(&bench_done_mtx);
> > +     pthread_cond_signal(&bench_done);
> > +     pthread_mutex_unlock(&bench_done_mtx);
> > +}
> > +
>
> Is it safe to use pthread_mutex_lock() and pthread_cond_signal() here
> given that collect_measurements() calls bench_force_done() from a
> SIGALRM signal handler (sigalarm_handler)?
>
> If the signal interrupts a thread that is already holding bench_done_mtx
> (for example, a worker thread executing bench_force_done()), the signal
> handler will attempt to lock the same mutex:
>
> Thread context:
>     bench_force_done()
>         pthread_mutex_lock(&bench_done_mtx);  // lock acquired
>         [SIGALRM arrives]

bench_force_done() is expected to be called from SIGALARM handlers
only, it is never called in Thread context.

>
> Signal handler context:
>     sigalarm_handler()
>         collect_measurements()
>             bench_force_done()
>                 pthread_mutex_lock(&bench_done_mtx);  // deadlock
>
> This causes a self-deadlock because pthread_mutex_lock() and
> pthread_cond_signal() are not async-signal-safe according to POSIX.
>
> Could an async-signal-safe mechanism like an atomic flag with sem_post()
> be used instead?
>
> This concern was raised in the v1 and v2 reviews by Sashiko AI on lore:
> https://lore.kernel.org/bpf/20260420124120.13970C19425@smtp.kernel.org/
>
>
> Could this code lose wakeups because the condition variable is signaled
> without a shared state predicate?
>
> If a worker thread completes quickly and calls bench_force_done() before
> main() reaches pthread_cond_wait(), the signal will be lost because POSIX
> condition variables do not retain state:
>
> Worker thread:
>     bench_force_done()
>         pthread_cond_signal(&bench_done);  // signal sent
>
> Main thread (not waiting yet):
>     [still in setup]
>     pthread_cond_wait(&bench_done, &bench_done_mtx);  // misses signal
>
> This would cause main() to block for the full timer duration, defeating
> the purpose of bench_force_done(). Should a boolean flag be added to
> track the done state?

  t->warmup_ticks++;
  if (t->warmup_ticks < env.warmup_sec)
      return;
  if (t->warmup_ticks =3D=3D env.warmup_sec) {
      *t->timing_enabled =3D 1;
      return;
  }
  // ... only here can bench_force_done() is called

So bench_force_done() fires at earliest on tick warmup_sec + 1,
meaning state.res_cnt >=3D warmup_sec + 1 when it fires. The subtraction
is always positive

> This concern was raised in the v1 and v2 reviews by Sashiko AI on lore:
> https://lore.kernel.org/bpf/20260420124120.13970C19425@smtp.kernel.org/
>
>
> >  static void collect_measurements(long delta_ns) {
> >       int iter =3D state.res_cnt++;
> >       struct bench_res *res =3D &state.results[iter];
> > @@ -750,11 +757,8 @@ static void collect_measurements(long delta_ns) {
> >       if (bench->report_progress)
> >               bench->report_progress(iter, res, delta_ns);
> >
> > -     if (iter =3D=3D env.duration_sec + env.warmup_sec) {
> > -             pthread_mutex_lock(&bench_done_mtx);
> > -             pthread_cond_signal(&bench_done);
> > -             pthread_mutex_unlock(&bench_done_mtx);
> > -     }
> > +     if (iter =3D=3D env.duration_sec + env.warmup_sec)
> > +             bench_force_done();
> >  }
>
> [ ... ]
>
> What happens if bench_force_done() is called before the warmup period
> fully elapses?
>
> In main(), the final sample count passed to bench->report_final() is
> calculated as:
>
>     state.res_cnt - env.warmup_sec
>
> If state.res_cnt is strictly less than env.warmup_sec, the resulting
> negative count will bypass the iteration loops in the report_final
> callbacks (like ops_report_final()), leaving aggregate variables at zero.
>
> Would subsequent calculations divide by zero and corrupt the benchmark
> summary?
>
> This concern was raised in the v1 and v2 reviews by Sashiko AI on lore:
> https://lore.kernel.org/bpf/20260420124120.13970C19425@smtp.kernel.org/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/250255=
33577
