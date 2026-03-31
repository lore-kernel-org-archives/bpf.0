Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E302E7F0A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917910; cv=pass; b=UuQZiysQqquz374CFl9P/MvNmzYlS/qetr8kP/IiKBQD3j0ngQI5HdyCb6YYwz0SOsC+JOxX1CEQnbRzvogicz3OLc9N0N+bG3dqepNYDchHSgZpFbg/qc4qphDbf4w6fpIwIvBdXX/AAnzOBA/jQOWX1PvG+5M3U6GNkqiE4GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917910; c=relaxed/simple;
	bh=UPcJ6K3x0scIK/CuXs9SlihgeXTrmwNwzX/lh915fpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b97wdX17uDSvJxC1l8ZQjvBHmup0jQbEGOgbBQ6bVxFxcXgxgqsycwyiIawpyZs/p093coJjsbBK13wn4jeG7yeCB8l3Srnw7u+ICIpDpFKBqPkcxHP7BsBr1LTeMlP3c9LyTroj4PX3aSe7wvciF6sVITcQsXuYk9/VeBqFfPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egaE+iWv; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egaE+iWv"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829a27414a3so2985303b3a.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774917909; cv=none;
        d=google.com; s=arc-20240605;
        b=T8mVQmnQKLdGgg179Ki/bHfbjp51tZ5BVQ0fZZ4PI4V2Vph8lbxoNpNoY7EPPYHp0/
         JMR6cgwAJbN41G/8tcN4ram7YKpxyPENQ12AYLmLf8uGZZsf39DbLWoz4MVX38hbTXQR
         obY4F2ZZ/mmRSKzqvddL09rMM4YbZnconiQuVUtLoOcyf1hWvCRKAgVQ2XHx0SIOxWtE
         YJin0KY85fviX5OymeiXIReW3IVvF4t1X1d5vsF6/bbtZRi25STFRS6V1ryzLsSGWPon
         vg0yi8fvGmbUWo4m3vjrZQlg12oFq4OLZPaUz2WRBDiw9dlTQ05CpgtAogXvjXjgKweK
         ikFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++3bGtO5VHZ2hYYVDCN3LHpQZviLGNLV95P14y9kl3Q=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=ZJWepv1MWNYcoZKy1zX3t/39V/PWn92Ys269LOFo0rjxR2TLuYHQhe/N4oA8a48Rmd
         GTOTtSuxzBS+uY+G2Ci6nrmzNgGgKVy3oZ2NyZX/IsXCrVFkQWoU84tckYWOnAHi8CIt
         welFo1fc+4yMK1hICWlnSwqFyeh6NRpMdKn8LeA8Ja8+8keCDnaR3fewpf8cJtPsiwRa
         uiwooMxdNC/sUhv5eE/nedtlydvugedca6Hxnl2/iXxdlJtBjUkKrglGVtowTPb2JOsN
         Fl93LnTLJiWps6UjySZYu+y033Bku6ak36RxsPHG46Ks1Z2tdlwNqYnJrzm+m57wzDCw
         ubdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774917909; x=1775522709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++3bGtO5VHZ2hYYVDCN3LHpQZviLGNLV95P14y9kl3Q=;
        b=egaE+iWvYz6c2rCCanTpSKDv+2N5wL+hhShlJbdKFSSJGx8AcRLBF9T7iF7N0X4y4W
         QfQfsRXuHksAu9ZAO2Gxv1teuO0fUkcrgaAo0eT6yOJsM5WgxYkTFnlV9lsw/1IogBmd
         Dfd5auiwLwN3yN5EcyylKjt9JknVyFdfstbZcRd/Wi18w9eXdwRnYyGbVsWT7dYxA4x1
         XhXU6V3tW/T5ryQfZ69X4A5Kvta/V5YVaR0TiO1l0VlUXprTfP1YERpNBxm3SPYF0i9g
         QLinr4p5uW3nh8WtBrzfYpLvJS0fzFf0iq+mlyOo0rPdjlPm040UPLFnsVsrrX9IMZyl
         IRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774917909; x=1775522709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++3bGtO5VHZ2hYYVDCN3LHpQZviLGNLV95P14y9kl3Q=;
        b=iOpfM++/apkfQDBik6vqQOjlOKifr6mvgBod9hs1DueXZp2xwTr1Cc7zULl8ojroLX
         ibDMFb+oJngI25qfPlE/RqtztWWBJn0mgFxk456W7VK650VDT+32YkPs/2DzrwTb4Peh
         D7xxuysmyoDhbbqCEH81g3wmJo5rWc3PUzFdERTIGKbTET2qKZZTQwzwk8L5aWfl0axY
         O5g12d7oEmW+ig70iUPURYkUoR7cE114+KJqNsuSWgQp/typrB3RrkwujJHu0auAaXqj
         j9UymFmyY+PRfAeRNgZ0GGvzjPo401/yPnv207lja5AIbt/EA42MMypfC4AZiDKpRcEf
         0Jxg==
X-Gm-Message-State: AOJu0YxYgcsyTESaCPSLxhAuZomm2qfZPpPzBo7ENQhR7nN0vAM4EI9N
	LUlQ/r+ivaGTNOvzqmeitchvmEhCfzLrECYrUuOo8PEmnCR3zO2QEad5ksKdTs3cMH7TObnFSOW
	u6TpKmlO+UiF7kzaReLQ93qaL1NoOdoDIcA==
X-Gm-Gg: ATEYQzy8yHGAFOXKiAqMy+kkovJOWOWH4FZNCPzfRC0cGiYoCf4yrtxapKebpRztHSo
	b+/HFaAK7ebRRDYBVer9HsLtMUh3dXUUMON85V+mm9Z6FsvPhB9Y15mnwgoRCyPnaIgLR+k5Z97
	Voz4P9eYZEWB8Ns6SIYDne/6m2gD9DtfJjBCfm2o1RZIXW9aoab+G0ySo+XW9TOqZ/3ZVpStRzx
	JDA9wlrizfXo0X38qWwjlMmAYruRUeAhmgMEHkFKCmF9TVqzlL75fhsNsI2cJRzTf2fi7+2PbdK
	p6+6c4vJAM+pKh4bo8dNtVU=
X-Received: by 2002:a05:6a20:9187:b0:398:4c9f:d970 with SMTP id
 adf61e73a8af0-39c877a9973mr13440931637.14.1774917908661; Mon, 30 Mar 2026
 17:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com> <20260330-sleepable_tracepoints-v8-1-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-1-2e323467f3a0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:44:55 -0700
X-Gm-Features: AQROBzA1RcuTqjMozI6n8phQB1DhiCAifTc0VLDrhgLkYvpT4DRw--fwC1HmdwI
Message-ID: <CAEf4BzaR-Lm=zGkf3ar1bbeEKwgedrPbMwrPvJunVe1LCcjfag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/6] bpf: Add sleepable support for raw
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Rework __bpf_trace_run() to support sleepable BPF programs by using
> explicit RCU flavor selection, following the uprobe_prog_run() pattern.
>
> For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
> protection with migrate_disable(). For non-sleepable programs, use the
> regular rcu_read_lock_dont_migrate().
>
> Remove the preempt_disable_notrace/preempt_enable_notrace pair from
> the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
> migration protection and RCU locking are now handled per-program
> inside __bpf_trace_run().
>
> Adapt bpf_prog_test_run_raw_tp() for sleepable programs: select
> RCU flavor per-program and reject BPF_F_TEST_RUN_ON_CPU since
> sleepable programs cannot run in hardirq or preempt-disabled context.
>
> This prepares the runtime execution path for both BTF-based raw
> tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
> sleepable BPF programs on faultable tracepoints (e.g. syscall
> tracepoints). The verifier changes to allow loading sleepable
> programs are in a subsequent patch.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/trace/bpf_probe.h |  2 --
>  kernel/trace/bpf_trace.c  | 20 ++++++++++++++---
>  net/bpf/test_run.c        | 55 ++++++++++++++++++++++++++++++++++-------=
------
>  3 files changed, 57 insertions(+), 20 deletions(-)
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
> index 0b040a417442..8066249e4ba2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2072,11 +2072,19 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_=
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
> +       if (sleepable) {
> +               scp =3D rcu_read_lock_tasks_trace();
> +               migrate_disable();
> +       } else {
> +               rcu_read_lock_dont_migrate();
> +       }
> +

At first, looking at this repeating pattern I was going to suggest
adding some macro, e.g., bpf_prog_run_rcu_pre(prog) and
bpf_prog_run_rcu_post(prog) (whatever the name) which would do this
dance of sleepable/non-sleepable rcu lock and migration. But then I
thought why not have a scoped guard for this? I'd even look into
hiding run_ctx manipulation inside it.

Curious what others think, whether it would make sense?

[...]
