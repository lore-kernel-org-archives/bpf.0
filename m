Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DA1FC0FC
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381597; cv=pass; b=JNoy/Y8djjc7z4QcYPiCzhwk1nRKQX9k5Dm/emD2YJo8Q3h3LHw672V4U/Qb6VjHoQoO5nh6lq4GxkJtZ9tbbnNkLtS2AaZYk1NGRJ6PUqvvOMJCLx20MNtABgzPvT3zfk9cXpXbBv7wh+1FUP3KX0pJaAM+RffR1vULLO3+Vsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381597; c=relaxed/simple;
	bh=QBOxtohiI7Kyu36G/rSR7TKuTBAmaD/ptlinBtDxbOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlxWGuqYLHy4UOOPSGNUVsPJhMh1Y7uRCEKU57As/2rn9GwRcqPI3mg4EoTIOz5Jq/7fKEceRH5MqbHCaoeUhcsVDD7qdqtsyOLSNgz3OxRsh56Ma9fNBFN7d3soEYtoS35ckB+RweowhLQh8ga+oJX6IY8Zd0cTDHp9OgE5Hm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBjGRQ1e; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjGRQ1e"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so158405f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774381594; cv=none;
        d=google.com; s=arc-20240605;
        b=NEJjnG3UghjKbSO8wpqht2sHNoXfdHhf2BLs1KCJlRSSgLlFd5ZCPt1M7s1IafdbFY
         OnAHxNsYHeXS7Uo3aZhBy4ohDWuq4sM/pSuxiuuvrpT3QjHddYv8qDktUxnanVuH8Aru
         hEMrh9J82CBm4dTJQtV+31UnVb0AHnZJdLvVDnDHnwwisAk/aXt5lUpOvV4XmMpBGwoN
         242D4yt/m205DK6r7JuTdY5X7yhCMEVhZZdN+VLLbmlWASDru6WOiBIHoLvWIc4yYxUU
         SmDnrKaPl+6yrm8xnzDXTdixa2G0CBgKmvSuPwl50iY3vktQ3KR4V9Cixc4LqXfsUuOA
         BBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7PJrjgdvzlCPeVe5s5MOJbhxLc6+yhO5I5dMEXvbx8w=;
        fh=oEMtQAMr3zPZpaJG5v1tfpkLsv0x83ljrknzlFra+uA=;
        b=WA6ZLsfCEVllQ5MpO5CTpOgwzAYuxf6OzQ3rPzXaYE6iXEYW2RxLaoXh37kitpTxfl
         NF6DBVnFTBrHlEz8OMmd/IbLlVmcCHAvfqLVmjuBVwjUhJ3C3bEprhcKIVWyB82UlSPn
         X02WftSiFFKBi//zqys6Hlz6m/CEW+AX64hskf1iI3Ic1qXMgcK8r1bzot9LoafZYSoi
         9U/5EtJkZjZekbjAJIbObSwvaE6Fq5/uOwg04QqZUcUMHidRbT9zvUnlvJhTNyHaeATV
         c5ekMPUAVhFWekvyJy3MPPqEzS5y0c2avYpVgV+/niSwXbS7JxUYwH+Dha7MQyK8gCYE
         eYpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381594; x=1774986394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PJrjgdvzlCPeVe5s5MOJbhxLc6+yhO5I5dMEXvbx8w=;
        b=lBjGRQ1eQDvAOAPNxdHtl3Co7KD7kM7MnGrQYkCrdhaOa53+k+K5a3s+G6Wh+RE+w3
         lpOc+cZJxmc3ozX1I/zklXoc7IR89HtY5E+SzXG/ypAia+pRE/qrmpkOVJ5rneFWBqca
         o4Pi/KunYDaDOdn6p0F9jbcwBwwio28kqiqxq8DvkSZWsuwY7DLMaO7GoxaiIOIZbbzA
         TOJI/AQQm7qIksTVLVKWwTNMZuaZsrc1kQ5fKfuj3pcpNPD98HBQeTp9gnY/ayj52gt9
         n1BFKIfKSE2+9JlOUvss3l5OHKhOiZRruL7JOfj1TTSwXEoGqIiPDw5a7hLxzPIBCqMo
         wgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381594; x=1774986394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PJrjgdvzlCPeVe5s5MOJbhxLc6+yhO5I5dMEXvbx8w=;
        b=oZ/BQ+9BmUYqqPyrOfo/ql5eL43u8eTSH0j//Ds+EkFrBnieJ5CUgb+6KbgyWjYNpK
         82u8Yey89Z+k13j6bPXonke7cE+XD7hVileDPvrlyR6f7Is583X0PvyTq7Uwd1Mx7N+T
         EjlmpLyHYnIv+22sQWz8+kz9nVgrQtvqBChoeKcO4ovSJ0FRm8aSeW0H2e2n414svEHh
         fc/0+ivD/Gm2RooQPPIQxairYxS5YsKM0yQ5nRe8eIEsIcPdPz0X68fPwg7jisSF96QA
         sr/fJnY7OuHT0N/aE/8M50xBMfQ3M7jWztbusSLH/5yU9704jrsQDXyLFehSDuay5tbe
         +4RA==
X-Gm-Message-State: AOJu0YxdvZhqt30m24rl3Gy5gb43XnU4U/35MJ0HuEuIMzpatB/CyXkj
	4WZZ1f0lijf3iVqp+q6MdOt/jdKRc8noqP8UOqXgLz0vfEojhlU2iXAir3LtmFTk5YI5cD7vlWb
	+KNOJ+4W9i1qhDI7vFA9+8Gb6lKK8pUA=
X-Gm-Gg: ATEYQzzFk1vLwRB6bKLw14BWP9k1i6/RU0ZzTfxqkdqTNEuk12wOZ62Z86PjvpnqVBy
	gh2kKD4BoWuJv5K4aPNBOnktvd9csX8YXBynKk6ZFDvatXzn5YsG56JP3MEcRmp6YYZ+++/jt9d
	QczVFkad6aGVWMl3h/V/pVWqeOUKgfQHjPB0yHv3sZ+/BmT6lYzYxP7hTnBuT4R18LgyXxpLUQ3
	yLowOCD+jRNnhDluheRdORJORTUVyEMw6BBkIUU/K/h2jD5jaRmu7YChCd4JzYGOIUbYn6XGSA+
	TrBNqW8WOruUtYQdn+MZuFv0hUaKyTw73n+UZ+fa+aMOR7tkWJGywakS6sg99NS79cjqncJiHVz
	UvwNEk1xWXTYpVkrUicjIk5K7yQ==
X-Received: by 2002:a05:6000:4905:b0:439:cd2b:35f0 with SMTP id
 ffacd0b85a97d-43b80526441mr6322819f8f.2.1774381594026; Tue, 24 Mar 2026
 12:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com> <20260324-sleepable_tracepoints-v6-1-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-1-81bab3a43f25@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 12:46:23 -0700
X-Gm-Features: AQROBzD_z2Dn2oG4ibWSYZkSdX8giICw3v_9SbcT43P7fQwub5FWIWkiGpO5GS0
Message-ID: <CAADnVQ+C6fJ1UpTzdYyJrookqjyOh1iGO9LqjwwFyRCf4W16+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/6] bpf: Add sleepable support for raw
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:03=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Rework __bpf_trace_run() to support sleepable BPF programs by using
> explicit RCU flavor selection, following the uprobe_prog_run() pattern.
>
> For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
> protection and add a might_fault() annotation. For non-sleepable
> programs, use the regular rcu_read_lock(). Replace the combined
> rcu_read_lock_dont_migrate() with separate rcu_read_lock()/
> migrate_disable() calls, since sleepable programs need
> rcu_read_lock_tasks_trace() instead of rcu_read_lock().
>
> Remove the preempt_disable_notrace/preempt_enable_notrace pair from
> the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
> migration protection and RCU locking are now handled per-program
> inside __bpf_trace_run().
>
> This prepares the runtime execution path for both BTF-based raw
> tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
> sleepable BPF programs on faultable tracepoints (e.g. syscall
> tracepoints). The verifier changes to allow loading sleepable
> programs are in a subsequent patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/trace/bpf_probe.h |  2 --
>  kernel/trace/bpf_trace.c  | 21 ++++++++++++++++++---
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 9391d54d3f12..d1de8f9aa07f 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -58,9 +58,7 @@ static notrace void                                    =
               \
>  __bpf_trace_##call(void *__data, proto)                                 =
       \
>  {                                                                      \
>         might_fault();                                                  \
> -       preempt_disable_notrace();                                      \
>         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(=
args));        \
> -       preempt_enable_notrace();                                       \
>  }
>
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..35ed53807cfd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2072,11 +2072,18 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_=
map *btp)
>  static __always_inline
>  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  {
> +       struct srcu_ctr __percpu *scp =3D NULL;
>         struct bpf_prog *prog =3D link->link.prog;
> +       bool sleepable =3D prog->sleepable;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
>
> -       rcu_read_lock_dont_migrate();
> +       if (sleepable)
> +               scp =3D rcu_read_lock_tasks_trace();
> +       else
> +               rcu_read_lock();
> +
> +       migrate_disable();

Pls don't sacrifice performance just to have common migrate_disable path.

>         if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>                 bpf_prog_inc_misses_counter(prog);
>                 goto out;
> @@ -2085,12 +2092,20 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link=
, u64 *args)
>         run_ctx.bpf_cookie =3D link->cookie;
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>
> -       (void) bpf_prog_run(prog, args);
> +       if (sleepable)
> +               might_fault();

why?
might_fault() is there __BPF_DECLARE_TRACE_SYSCALL.

pw-bot: cr
