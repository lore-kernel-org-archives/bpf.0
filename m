Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C422541C
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802632; cv=pass; b=C0v5VOUgXfByscLcR9GUCF4264IZK/Zg5wMgoFHviLLtTcn2Keo/MLmeIa2kcyhcBOpFvyzig6aqIcYwEUqX4G7gCO0G0L4QJzzu1ibtah3yvPoWTaQKnJpXIBqGivD+0PUuLqOB3kjePceF5eioPuaAXzHNShPVaeiaPGqO3eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802632; c=relaxed/simple;
	bh=gQjcSjlbpKalBZ5Z62dAnhtosnjzzG4RrydexSnDwH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdERLBgw1Z520RTGfXR+pyyRFIVlMTNKxB72OUcX0jDX7PKfN7UWGWsVj1h0a8jginVlBp1DUsxgTMeqn293ZDQ1Sd9bNW1FrvJOuQ1k2fLnaacgg7a2tciB1VPCA0kINvybGUVue6j5sKAPlK5xQ3npykyM9iryM356EEiwlA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8wxmIN/; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8wxmIN/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1526869a12.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 11:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769802631; cv=none;
        d=google.com; s=arc-20240605;
        b=iB5nVFlt+X+5n6T10ABbPdQEQrgDFrTGEhQztJdT2rCyAKHqnbep/JGPjeFkLqNdSE
         B+bxYkOCNd/usZEnbapTMya1jtF0oI0Ftu2HM3LZe7F2lT8gchMtMq+1QWJ7/VEcFsIJ
         Q5tEj9zy3WoEmaSrnPY3o4UfQMDMEAPlmSSJeSN++r4pxawBxn08ztqFp8Y8hSv7gHux
         UMNwKW2WcQdNpMF7JlP88ydjK9ZteOZoYOHI0IZTWa8sR+onNQQB/RGzChNJMM0WRoN8
         SE5VAb7gwVmHXueNaZ6TggeggYuNTzoOrd6MIf6CJ/fftX/c+SB7FCUhzrVsfYy7+AS2
         3P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJW87ItPtnhQxFUy6EMS2HWMqA32zGvL0mHIWccRN1M=;
        fh=bexlN/6/SCupOEjnnLsnO0DlyJjrPrIiih6x7XE7MV4=;
        b=bn3YSG+Gr3qiwsbfDcNIekRO+tFNlVvk81eEl/TcK9jT2nirVMO1I57qmqyHCnjIrp
         RVdCq/pgYDW0UqSOnN4z1s9QjNgPtgI/7gl/BxdcYdSkmKH5CuYLD47OvD8TFa4ptycN
         RpNFVzxPvzjp0LWvRacKmuui9MQn4wF9e2s316XGx2cVcJqb8niQsHQShsToCwXC02II
         iCdbElpfiOqU4KRq9d1T2LLTgrcAJGu01iVr9WzQfP9yARf5OTOseERnbP0X+h1l4oqI
         WCIXZ20I7luQ9YnBT7jpRUDh/edDnC6KPq2++UXyAy6Visw6Rt+UMY9q7teq5nUZDfyV
         S8dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769802631; x=1770407431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJW87ItPtnhQxFUy6EMS2HWMqA32zGvL0mHIWccRN1M=;
        b=c8wxmIN/cM7xFtOsZs1etqO7Dx97JjSFaikAKBthysvodw5mcMnmPaDu2WFVt/YEIB
         IK44XBMCKRfeHqYtR3rBmbUOubncyiYlrsxL+NRoYmo47bncj1KQuQY65JxrC9DjbTjM
         MUC2rHzytLY62Lt+N/jS7KfnQ/RCRzFSfocdHzqvzf/zP74y7o4n63iBXRAWuuLc9KYy
         otzDWnSYmBaIzGT5/3PxKlWAqpzalYmFViUFf+JrMD/jOchb9d1fMKis5tBQuo7covLB
         SIBtVoR9KJ7xVyoti56ozYbJih+csoWYciA5mP/3rVaidiGMwEQ9NOp5dtB2by847e63
         LS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769802631; x=1770407431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJW87ItPtnhQxFUy6EMS2HWMqA32zGvL0mHIWccRN1M=;
        b=eAKaNZmlPXB3htcDxv5Ga8v5mqpfIibOD3+y3n4sRvkc2EP1XwvI0SXXBpyLIhkBJ0
         z5drbbYiShLYxE6ZcpQ8AHTEPbpBdInpZkJ6CNJ7dEYBY8NyLWAfxjtaYqJK1Kkwo8w8
         VDzGUiCY3Vqyvy3naMiMhEHFfIiMW89Zh/PVZ5AWCWVHY6lDKoR6DhJIuGprFSIDTVyj
         EXn2GtEtNSovboYJTvQAnfP7leQPcZQI1FYQlPR9LU5Qs0FqZvGiND11B3bAiarVGKfw
         dfeqFqu7wKpnh0U5gEvcmUo6/9SlMMLzier9aRHgpP+m79yJfq7W5vaDOB93/KFihaka
         44Og==
X-Forwarded-Encrypted: i=1; AJvYcCVhNN8mk5kkOd/V6WA54+jCmzZHedcoG4UMhzxuMoMLod2xXp+lCC151ob9TFjGhazjdSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbS8d3YQGbnI+FXtBuQHuSDPtiEfr/+s7HsR3V7ClvV4KWFDgi
	/Kz97dPJosJ/MpstQzh+BFadLdA5k9Uu6d/blIaf6FlSDIvMPlTkooMNhzP5nWwy8CpyF4FEkab
	pEdbQMJBqIn4Yoz3mwRxaXY6iy7CYWm0=
X-Gm-Gg: AZuq6aIsNU5eD0bHDXZbclwT1RXW4DSvu28D3AUdRenPSFybWvE3F75bLZr35zXqj5I
	7AhoxNZvnoFSw4lsYU3w146OaU13rs0Xv6S/SoZUtXd6RZAnEQyKyekoQM/crv2DScwBQkK7tFZ
	BrXhC/aXJsT9/xdiq2s7+4cnrik4G86IQ+rl/yE7K1vsPXqpOpVFJNK8MgFM3c0xqe50Uu541jc
	+SFtzX9jm3mXMhY1mIBqa6MHwzN6QRInnM38imF+RmMol+7belXztBdairr5MiiiOqsBOgn8qa5
	Nqb2eb/ThZk=
X-Received: by 2002:a17:90b:48c2:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-3543b3941dcmr4278320a91.17.1769802630549; Fri, 30 Jan 2026
 11:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
 <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com> <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
In-Reply-To: <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 11:50:16 -0800
X-Gm-Features: AZwV_Qjz0B_OOY_cBNBMp0TW3abs0mS0HrQLtI9tn5KtCvOPc_qOKR7Q6-X39eg
Message-ID: <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Blake Jones <blakejones@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:44=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Hi Andrii,
>
> On Wed, Jan 28, 2026 at 1:21=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > I'd probably pre-generate some unique ID (using atomic counters from
> > the BPF side) that will be sent along with the async user stack trace
> > eventually. And then join everything after the fact in user space.
>
> I might be misunderstanding what you're proposing, but I don't see how
> a single unique ID would solve my problem.
>
> If a thread executes the following kernel function foo():
>
> void bar(object_t *o)
> {
>   mutex_lock(&o->lock);
>   o->count++;
>   mutex_unlock(&o->lock);
> }
>
> void foo(void)
> {
>   mutex_lock(&current->foo_lock);
>   list_for_each_entry(object, ...) {
>     bar(object);
>   }
>   mutex_unlock(&current->foo_lock);
> }
>
> and blocked on both mutex acquisitions, it would generate two distinct
> kernel stack traces in my profiler, corresponding to the two calls to
> mutex_lock().
>
> If I held onto the first stack trace ID in fixed-sized task-local
> storage until I could acquire the user stack trace, it (and its
> associated data) would get overwritten when it came time to take the
> second stack trace.
>
> If I just used the kernel stack trace ID (and not the user stack trace
> ID) to index into a non-task-local BPF map, I wouldn't be able to
> distinguish data from different user stack traces.
>
> If I stored this data in a log, adding the user stack trace ID when it
> was available, and aggregated the log in userspace, my profiler's
> memory needs would go up by 50-100x, which would make it unusable.
>
> Could you help me understand what you're proposing?
>

I'm not really proposing anything. You have a baked-in assumption that
you will have a user stack available *synchronously* and that you can
use that as some sort of lookup key. This is simply not true with
SFrame (and asynchronously captured user space stack traces in
general), so you'll have to redesign your approach (or you just say
that you only support frame pointer-based synchronous stack traces).

> Thanks.
>
> Blake
