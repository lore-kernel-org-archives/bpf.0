Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F73ACA4B
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638003; cv=pass; b=fv3VZ4DxigYEubBvP2qCgB0tOCS/puEBMMnx8KX4P8gyxfWBAbs5W9ib4zfdt+odNQzU5V94GQgTEDz9zQEsR8wQr3JwrZVpwOtNapnDm4IvTw5ObiQZF2Y5zkgWtwyrMzzsuCUldmwjkUpiWKJFLI5DVVfkq+hWJfFR47xyMSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638003; c=relaxed/simple;
	bh=YhsLLjQRUDzkPzU0mRmzVdaxhPXZm/VwEJGe4cF8Y0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2XGeJ37MOWS/HD430j/4QrMR52AQQ3N4I5xbCPIjVgXfmH0d6psuW+tgirj8p6neDhrWsfn/DWF+lPo5CHYLMQZL5h++oIXcUMWVLEVdU8Jf8R2nz6uPUUphm8JyQzjVEQ+GeyxZ2TYxUgru2atDPtLaHNi4e8Y9gLGawR/wDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQMpMKht; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQMpMKht"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64fc6b21789so4431454d50.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 01:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775637994; cv=none;
        d=google.com; s=arc-20240605;
        b=ecnOKAHWwA2xYldIMhz56302V2yqzWvjCgH6XbdSGcb2lJB4VO+qFqrmrfHNbF09l2
         xDT7Zi1h63RAP9+EqAAguAPLT9G3Qg739tK9j6YoMUHuu9APfGcYUtScz0bYzJE940IA
         zLP4c1axFnFwb/jP7ezHGTa1B/WhmX3Z63ABcxP36gUrJJx7YuSz34OKLvT/MQnOVz2a
         zmzj4wY6exjEqgOF6dkGeV4DmP/7TsXxnVLfqDp6E9k4ZoXSzOtVaSox/FOrhuSTBfat
         t3RvR9BhNx4R+3NErN3auLTevUzgQd6jUWsUhbsARvMHWoJRQeeFZgqONJFm0A0Pj5x+
         QnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3YSEWkj82f6zzxq4zWAsOUqn+B1wCj3cMP81KRhunI=;
        fh=7Jb35+oq4UWQtjw/uXhMBPPTRMbe/LyoPELKcHXevv0=;
        b=dxnmvsPVE0Ln38zDHAsC+93snoPWq5tgau4gHqj8W7wqfcpNQuQ151ZCmgZfn4Il3p
         C+mnzX6jDll6vclw5llmcyT/+mEXewaKtDyjK6enRQCyHdiaTxpgTj9NAWGO7SFOmgU0
         QzV+1Hhz+OCvrciBqfABAbNPa9TDGYdyLO/B+XdrNrUyBWoC9MHuoxEJHR8E5gWyUXuj
         DOZe2hEdyJv8CLsS273tNIruwZDk70nNh8SYb2oXcP7/Ek/Ps4M5H/w6wMuddC3BBPR9
         IP+edGLGvia3tqi722rmUwF8VbA76lasB7lyF94qgANipzMifR25IFwumibJnpwvQtYn
         B5ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775637994; x=1776242794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3YSEWkj82f6zzxq4zWAsOUqn+B1wCj3cMP81KRhunI=;
        b=IQMpMKhtQf0g/rRcZWbRSveAscjHBJIiywZ/Nu997BFWVwQHdmu2NpZlkZrb2bLy/K
         r4evI+piNH34kMkDmsAE26995l4g0j8snCkQPlPSo4P8Ux983QNr+jmBmv7EOP7Wp6X9
         6MeGUkI7FpiYDnXLB0QPyercHkjUjPBtuaYcf5pZzrEZKU6jgXR4ihUdnZg/B6D40xis
         rS0P2gmWFxyDfHboL8KxSKGHTGBoC9IXZoZNKJx6SP8t0tOfapgjzccSg5EEE33QkPFm
         Wl9EqIKex/p/9CDaQn0FB20qR6NZjrUIOZfyem9YRYRXrXQrYFDojrXtAdhOdlB5XKTx
         l94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637994; x=1776242794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3YSEWkj82f6zzxq4zWAsOUqn+B1wCj3cMP81KRhunI=;
        b=lmTt0EZOa98DErw3D5dQb2rNqTu6GT6T73a8oDh7K7h3cFC1W/knXGhnCNBkpBZo/Y
         byTjk6OiptBkSgFkuk3PXjdqUkL1dMN+dKBNLU4x0MYqknC8V8HfZzmllyNfwcc8Layg
         HAzZfYyL0fTzIXlQ2SR59pVziD2r5Z+kJ7njmmwDXd7lBTYBv5TJfuUKL1UOMueOrqen
         FIiZRHZUYxHIxvUxhstqwARKQips0mjchNW3ucweBtSRAC7jECrYb26mWSkZxVobBjLe
         40hB0DdWiPww5RQeMlk3TfVvWqPQOHG5NOsob1YB10B/jMV0WZEwPhTptnTh4oV4dB0t
         e5Jw==
X-Gm-Message-State: AOJu0YwzzVcuudNnJPP0AttWsWiPu0lsc4Y5LlptEK7FvBq2pwTAp7sS
	JfaJvCAlT9x1A6oiEfy28RWGjdn8OPwWa17dQbl1v9ZexZEnIbNFBm8vFS85PmzU11Row3nh7Yu
	x9Zkkv+uCcpaMp/mGmHceR5LRTbBdsbM=
X-Gm-Gg: AeBDieuSN6l2jcNKisP9b66kXFH5lKv6e7dMwqqWbGVMHwDoLHWuI8zguVAnTDtXU8/
	dxchfgvHW3n3v2t3pM7vWNAE9zCLE8xHvxIz3ITwe5y+DB7+oq/xIem4VyJUy0ARmKzNv8oPpSv
	FBQaM76zr6uE2Y9gz/n2hqBdqkGfHvosFfVO8A/1clQnqibiXXRrIiepjOGU6uyDk3IhemEAnIP
	3/FuYXzs/abuSPEka1E5Rlf9ccuiuv2UK2HE/S0vwC6rqCeVzK7zNfLZObz/9QfO0hSanqNwQ9e
	xL4PIRIJaWsbFdDcdrOTT8UvhOcIALWvAHNKyJuR97DRr9rXJp7QcQI=
X-Received: by 2002:a05:690c:dc9:b0:79a:cc64:886e with SMTP id
 00721157ae682-7a4d634d86dmr205377607b3.52.1775637994066; Wed, 08 Apr 2026
 01:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408021359.3786905-1-memxor@gmail.com> <20260408021359.3786905-2-memxor@gmail.com>
In-Reply-To: <20260408021359.3786905-2-memxor@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 8 Apr 2026 16:46:25 +0800
X-Gm-Features: AQROBzA6KB6yYaGhVMDD5JBoaACTL7kSueJgtBJw-_IU9ql5WlgcrF6DaV1zT9U
Message-ID: <CABFUUZF3qczom4j2_4hoy4FJAPEHotJvtiJvQ4Yd+oUP+QBiwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add support for verifier warning messages
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:14=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Relax conditions such that we allow log_level =3D 0 to have an associated
> log buffer. Add a warn() macro that emits messages to log buffer without
> any restrictions, aggregate the warnings emitted, and then use it to
> decide whether we reset the log or not.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/log.c             |  6 ++----
>  kernel/bpf/verifier.c        | 17 +++++++++++++++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36bfd96d4563..c7b34236a4b5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -795,6 +795,7 @@ struct bpf_verifier_env {
>         bool bypass_spec_v4;
>         bool seen_direct_write;
>         bool seen_exception;
> +       bool warnings;
>         struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn sta=
te */
>         const struct bpf_line_info *prev_linfo;
>         struct bpf_verifier_log log;
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 37d72b052192..c67fbbbd5768 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -18,13 +18,11 @@ static bool bpf_verifier_log_attr_valid(const struct =
bpf_verifier_log *log)
>         /* ubuf and len_total should both be specified (or not) together =
*/
>         if (!!log->ubuf !=3D !!log->len_total)
>                 return false;
> -       /* log buf without log_level is meaningless */
> -       if (log->ubuf && log->level =3D=3D 0)
> -               return false;
>         if (log->level & ~BPF_LOG_MASK)
>                 return false;
>         if (log->len_total > UINT_MAX >> 2)
>                 return false;
> +       /* log->ubuf may be set for log->level =3D 0 to get warning messa=
ges. */
>         return true;
>  }
>
> @@ -229,7 +227,7 @@ int bpf_vlog_finalize(struct bpf_verifier_log *log, u=
32 *log_size_actual)
>         int err;
>
>         *log_size_actual =3D 0;
> -       if (!log || log->level =3D=3D 0 || log->level =3D=3D BPF_LOG_KERN=
EL)
> +       if (!log || (!log->ubuf && log->level =3D=3D 0) || log->level =3D=
=3D BPF_LOG_KERNEL)
>                 return 0;
>
>         if (!log->ubuf)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 594260c1f382..86d77d5f7f83 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -47,6 +47,7 @@ static const struct bpf_verifier_ops * const bpf_verifi=
er_ops[] =3D {
>  enum bpf_features {
>         BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
>         BPF_FEAT_STREAMS             =3D 1,
> +       BPF_FEAT_VERIFIER_WARNINGS   =3D 2,
>         __MAX_BPF_FEAT,
>  };
>
> @@ -368,6 +369,17 @@ __printf(2, 3) static void verbose(void *private_dat=
a, const char *fmt, ...)
>         va_end(args);
>  }
>
> +__printf(2, 3) static void warn(void *private_data, const char *fmt, ...=
)
> +{
> +       struct bpf_verifier_env *env =3D private_data;
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       bpf_verifier_vlog(&env->log, fmt, args);
> +       va_end(args);
> +       env->warnings =3D true;
> +}
> +
>  static void verbose_invalid_scalar(struct bpf_verifier_env *env,
>                                    struct bpf_reg_state *reg,
>                                    struct bpf_retval_range range, const c=
har *ctx,
> @@ -2128,7 +2140,8 @@ static int pop_stack(struct bpf_verifier_env *env, =
int *prev_insn_idx,
>                 if (err)
>                         return err;
>         }
> -       if (pop_log)
> +       /* Preserve warning-only output across branch explorations. */
> +       if (pop_log && !(env->warnings && env->log.level =3D=3D 0))
IIUC, this can drop some warnings when log_level > 0, which seems to
be a reasonable
design trade-off to me. Might it be worth mentioning this in the commit mes=
sage?
>                 bpf_vlog_reset(&env->log, head->log_pos);
>         if (insn_idx)
>                 *insn_idx =3D head->insn_idx;
> @@ -25211,7 +25224,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>
>         ret =3D do_check(env);
>  out:
> -       if (!ret && pop_log)
> +       if (!ret && pop_log && !env->warnings)
>                 bpf_vlog_reset(&env->log, 0);
>         free_states(env);
>         return ret;
> --
> 2.52.0
>
>
