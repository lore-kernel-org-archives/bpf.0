Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7B337BAB
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337250; cv=pass; b=b4oWcYsphy/Ot8jz4VK+Z+bkw5WmoY3bGeVn+qKgsILlJjT3fYQY7dn4xRd/SqQI4hSND0DNtLm/4A7/bdDpB8m3WKFKhatPUnCqrjY9TRhdLAmIxnRMXbHwZBYjv52GgW2E4FzmJwisvWEe72gWe8GBtznpMWckNaR1NotL9h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337250; c=relaxed/simple;
	bh=2A92KqKoCJmcZ56ZasJV/t7WaDXgH6qSgLNOV+CEQaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8wlAuCkPOKIdztIAuivGEC2BvDgw7ycLsyIupZdBp4kW9MHkkugv15s9uQjlwOuDwiNkHuSPUyTSn6i66TKTZZ2XOunB2D1M1IiGIitKUrabYuy0zguTmYkMSV63/YeLQQs8BqrioetPSezmsp1WOn6khn+TxQextZbll5i4ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUeypJUo; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUeypJUo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc891373e0so16023795ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787337248; cv=none;
        d=google.com; s=arc-20260327;
        b=q++SEo+B+KXTIUdOOW8qpBpGtfeZqfosYqUN25EehZD7j0vW1BRtIf+76RrCeSgRGi
         Mnqr7BjWd/8xBXhwUclYknrvco5kspeNWKLEKVzkORGGUWEvZ1+d9iUXVyQwfehQCHRh
         SgOTsEtur4hlyePP7qVjL5iU9ubgrxOIqRlODfxrwJBlS4RrsstTFIwKDWeDL6EQ836n
         rZIJ3+c8yRgC8BupSSNLh9Ly49K0jIrOmUQ6pfYHQvymqN2ZWpfjEJ9a8T8YrF0gqRrZ
         GAcioLxgqKPGX9HmheWUWe41IeT1KHcrZOocc9Z/vDe5OmC7SVIV0461A1ynL9gkP7Kj
         fhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0Ukbw5yEgIofWImq0KqMRHmw7+kGVu41QRqHiQ2DTo=;
        fh=PXqpcrZ4Mqfqz3/FG80qyVmLfiziwTPlOxhAo4b4ePw=;
        b=eruLCZ9OqqoVkx1ph9KYVfaVgkZZCDeb4wBIJ97Fkh9RudA1253uJ5KKJtOyvQjjD6
         GirwK2prBMjz96QcTL2En1pO5mtJOjLTSvuTQUBZRnUYGe3sL1stXLeeeAo5DhagrJqm
         n1R95JUNl3ipqgv1kZuxf1IrWrHsYv07NSmrAX+Rc/hxjdh+XWl40uN2EXE/P7I40rNd
         XKzkHUKLFUMDgGFR4oFOOlcTASgfZ3gy98/YslriUlni0maAnHr0sw/G47kANmWPP0I5
         DI1M+TNty2VCT7aze9WDZTqlpiu9s/PvQrJIuBqIE1yjUXCt+DaNaUXlMGQzsqjWsXXD
         Mqrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787337248; x=1787942048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0Ukbw5yEgIofWImq0KqMRHmw7+kGVu41QRqHiQ2DTo=;
        b=rUeypJUoO2uLmKZLOE7GfBMYob3PTQ79N2DcnLL/LhJC9mDO3pnAKaNL6TNfaECykp
         CcamObRLnWx4MkSQST827fTRgvOgLogbCnIX2KEEb09oBCGGzv4lgmL/m5O2GLzPftsQ
         qY3DXd/vAAzAVewNLOE69Kt1QpZb++e+P/jcjl6iotOmTmpoM3mGMankC5y8lfISy00Y
         7UZ+bDBD/BaS5AyeE8fWo13zbjIA3PWepTsJ9JRnGSveeGHu4NTpPQBJEAPmWUvpwtc3
         jmeef3xFBzApf3iKM4ztzTGKpD2ywjEc2b5AqP/xFc6RLEIfryNNrSqzG93pknqk0a19
         obww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337248; x=1787942048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0Ukbw5yEgIofWImq0KqMRHmw7+kGVu41QRqHiQ2DTo=;
        b=cyAlg1GdPRI4Tmqht842hTLib7eCzqTHyHaeZzPyR8x8kBLBucP4/3spwnKKNSgVPI
         2GfFh3/Yo/8EAW6eniAQHVg9RZgZ6a2uCj/AVFEx+VN+a3Yt7FQ7mfSvknxZfU4tZrqY
         V0l295UqW+0eHLCZpvsTukpF1WGg8/jF+a24GZ3+WYXDavHa7IoU8ClUKrQ8Noyh09OH
         vHBxDgPQ+gVYyUWt1BOedAl+RGWuectdI2hYWPl0PMNIEcl7Bn23c/M1nvKtRfGDNpcn
         bqrAHXPgQujSGUmA3fsVHp83ayR8VhRwe6XVRKyS98kDs/LSZBOfVjS2MJGumEdIUCWr
         8gkA==
X-Forwarded-Encrypted: i=1; AHgh+RoWiGcqztc8xC9qViQcu+Pcv2z09dysIZG4Ejn/iwo5U5D5kiUOT5v3mppHt04Lmk85mx8=@vger.kernel.org
X-Gm-Message-State: AFuF++lsFlceLP0Q2qy82loIcApv2feZJWOn6dA6ULqNzgJqCsnZyruq
	++3LTM0qnfkJHCmcsHRB1iLpXZM/OgLRlqzrQRsZaG7XKNYBdOU04E1re+ltL3ftSVNrd+IEzAg
	sVNNN4JVbaMcYGAjBqqfPuNBNHl/hYeY=
X-Gm-Gg: AR+sD12WOBILuSrNwbcdnZtgBTvT1EG5X09zlTVfDVzn/8X4VPv/KkKd7SD/2zn4lSb
	ImdzRLxWZ2/qBrLJJpwT8NUn87/ST1MNP2m/NYjTKxj+ESKzW8yyTVg2pvirdON9wXFfPl2U2JU
	QxNj+suqJnxtZvbaN9qdBXIoFLWvIWSWExPQjFgyHTiK0s6gHh8FynmL7wcIE6ZYiwkagkDnbPc
	PazxjnIe0UehwPokdNarzsuHiolUt4H7jJbE3k/iBAmf6C2RZB6mv9gNCr9Pi4Bzh9r/HjI7LDB
	9YRpYWGMMs/HeMW80q3FNZ68AmC9flHQB7FbVtyLc4lz/ieyWuaaKXkTIg4VEs2SAbdHj4lcRUw
	f0aciWiZgUMbvLNkh4hMz2/VMt3jRWigif2Kx
X-Received: by 2002:a05:6a21:3a45:b0:3cc:fb7d:a9ab with SMTP id
 adf61e73a8af0-3cd4b9ea5famr1632166637.2.1787337248227; Fri, 21 Aug 2026
 11:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821014210.18681-1-kartikey406@gmail.com>
In-Reply-To: <20260821014210.18681-1-kartikey406@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:33:54 -0700
X-Gm-Features: AcwNN1UMxCVEBEK7W_zIG4V60WyE6AsN7ajAZMnJmYaQz6_nFKVc9evdZTs2M6Q
Message-ID: <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:42=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> During fork(), perf_event_alloc() reads parent_event->prog locklessly
> which can race with a concurrent bpf_perf_link_release() clearing and
> freeing the prog via perf_event_detach_bpf_prog(). This can result in
> a NULL pointer dereference or use-after-free in bpf_prog_inc().
>
> Fix by holding bpf_event_mutex when inheriting the BPF program during
> fork(). Make bpf_event_mutex non-static and declare it extern in
> perf_event.h so it is accessible from kernel/events/core.c.
>
> Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  include/linux/perf_event.h | 2 ++
>  kernel/events/core.c       | 8 +++++---
>  kernel/trace/bpf_trace.c   | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..5c6dabb6dccb 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
>  }
>  #endif
>
> +extern struct mutex bpf_event_mutex;
> +

exposing this mutex like that is definitely a smell.

AI tells me that this perf event inheritance case can happen for
non-tracing (i.e., BPF_PROG_TYPE_PERF_EVENT) events, which are
attached while holding perf_event_ctx_lock, not the bpf_event_mutex
(this one is held for tracepoint/kprobe/uprobe programs).

Please validate and adjust the fix.

>  #endif /* _LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7..a89e33c47073 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13433,12 +13433,15 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (parent_event->prog) {
> -                       struct bpf_prog *prog =3D parent_event->prog;
> -
> +               struct bpf_prog *prog;
> +
> +               mutex_lock(&bpf_event_mutex);
> +               prog =3D parent_event->prog;
> +               if (prog) {
>                         bpf_prog_inc(prog);
>                         event->prog =3D prog;
>                 }
> +               mutex_unlock(&bpf_event_mutex);
>  #endif
>         }
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 75495a5c3507..730fc22a9daa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_o=
ps =3D {
>  const struct bpf_prog_ops perf_event_prog_ops =3D {
>  };
>
> -static DEFINE_MUTEX(bpf_event_mutex);
> +DEFINE_MUTEX(bpf_event_mutex);
>
>  #define BPF_TRACE_MAX_PROGS 64
>
> --
> 2.43.0
>
