Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C12EE611
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698813; cv=pass; b=fd8ih3YwWoK3q8vQlE6CgFfXBj62W/cV4HvNkfP4ERPLT4kGQRI/nNpU0PVe5vzMB0wQwwFvo2R1326HMDKK3ajbIrw0LECA008OM/YX5Ayg5m6CLDHOyf67NgAsZavynYgjiFtd3PuAGtB/0ywTnj6B/w0R2mEBnBOLBMsq6ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698813; c=relaxed/simple;
	bh=q3iYQueIFWXgCSAD2C/833gWcRTs0DLE7l1SHwkCB/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Twb1m0+6S9ngxokDZO5nXMx4wMJCsD62OWhmxxOdS+fF2uwMO6xhw59NTHcaV7NWgxQOzcpLFXkz/fitc46bM5jP+8IGv/K1hD+o5J6znQsSsOc3iDAWsKdWQRAohwyomBOrlAL1LDdDlCkCzaQZ169Qac/pVEiclIPkXhOrvoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHMB9eb3; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHMB9eb3"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d73422431so2787928f8f.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776698808; cv=none;
        d=google.com; s=arc-20240605;
        b=k8++BQSLE1Uo49BwfHsatkVrdAYjAY9lZeSh3/MZmaEF2w1egwqKkRVEbLdBsKnCL4
         Qt0uZsshpaFMQMXgKQuzaxIbJZ5lU6BsXOm4JqgBJ9Cp3CX423brYH9iZMNDVIA82F0U
         Ao10zlLpi63ONqhX89H05QaSu79pFUBK3LmkKh+BkX/ujn/IpMk9ABoGXjXxnIZgQqDk
         pyG94NSQ8t4zr7/rZAiHhhUf23uFSctXmXHKxA43HIcqy/eI4EV4nLUvRxsI+KhGAOu3
         dX1LcJqXHBknmnzLBiU5Zg0BMfJX4Kqv67pUXWqSSESO+qplZgmBLNBDK40bUcMd4usM
         zvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NOAiTCSmCEbeup31GFdSnKY42LJJ6xW0lagBdCoj+D8=;
        fh=zaCmUXYsN4Lkv7omNhKOgHzW3+IM9MSi9QcW9nCtmqY=;
        b=gb6MrUPGnNtTNGTwCy/XoJwcuWKwK8A0zsWowbNLBCOOekXpp4VJFTDAxhD5iPImY9
         Y2OZswfsc/qCluqRPbVIjAPPl7UrfZxLUZOuG9Q7ja4jO091/KhstW5KqGkhOZUQ2yaz
         uijiGHO/cJCbrAykFoC3BavTwDbv1Zsi1j2ql6AAuS18dQm+eFC/54iGu8C4t9QH38+T
         +4HbFN5Dj99GshbGe8Yqidej9a9nSTcPtGkMH5YX/E6VVRCAvZZtP7fREJLkYUwfSvH1
         oWPrrQ9jdojHuWMo0FLUJ7m1yQ3B01zDRPxXA+D3kcVdW7b8sjJX0o6KZGnTw4sFa9zr
         HJfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698808; x=1777303608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOAiTCSmCEbeup31GFdSnKY42LJJ6xW0lagBdCoj+D8=;
        b=kHMB9eb3vWSiTfoar2NxVFToNkucE4++L/rOigLib7ZINfKVRvTiptAjXcFloNIoy2
         JPtmR02G5VnMFiaEppgVKryfENq3oYCykK5/GS5HZj1UE0hcNydsr6gS/T0br1ENUfVz
         5QAolV9rknF8x7KyaejdA+hDzXNzeKA7Ep2nLBn6sFKt2m5lOr5+KYwlk9gsnxcnUV7P
         Dk6PHr9afeDfpgdrlWIYxW1BOrtcnWu3Flh8veJIWJWhGCXLcsSv7DxR7aMsFSJA/6jS
         dZ+5TJv5VfrkvOrz0YH3wY57BM8v9aJ3C28tPP3Ztqjcmwg+vPBCDZwZ+ppEcztyu8yO
         5C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698808; x=1777303608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOAiTCSmCEbeup31GFdSnKY42LJJ6xW0lagBdCoj+D8=;
        b=Gp4ROmJDuoE3dJOarJUkKNGlx18ZD02N9lHDVkYeVDxelr751NTP62iPTTSuq8yyjO
         d4bSv0tGNd9GvZrHoKP0pJ962cIBH4650lqJM0QhFXYhgAlg4PfrHBe0NkiCRQB6KkVm
         0SeQ94P+txuAdNjD4/angoTqI81OcAO//I3sA4eBUXF6irPD4DGsv6HRufCNSAKuEQsy
         fc/+kv7+hZhaL5hwjOjuFTD4z4cKzRd3kUXbu4x9CHqfVTkehq+o2m0nLz8V7SK4VnIC
         p5AtrFxHi1Zlid3bDTLPZm1X/SL4WejDUcRGgERsOwg1CDLpYj8XB/x7PrU2mkRyWtXv
         FedA==
X-Gm-Message-State: AOJu0YwNesJe36GNw0R/rWvk31q6X6jwhLVI+EumIWZ5kj1p+TthujRc
	ELHBt0YGiRwQ45HbRlymHSMDxOfOqwWXOtalIzX2BdWzJvqAAYV40XmFSw1nlGJAOxFCp2Dw+3q
	UsS2g/qCFoTeKrHc//mqu3+Od880v8dQ=
X-Gm-Gg: AeBDiev0hYLxkqqyjIdldqoFgHIyAsh4ZbAL7Yw+qJG9JCG7fTYqJxZmMWbjFt5jdq6
	sJ90neuUbGPaak3zIgLpGz9KW75QChr9aG22P8dxZr007kxkA3pfJUAhvV0myzB1Y+Uu14lMvEN
	JsF+6IL1wIpVf9HIip7okiPwicGFPxW7bWUC7fdqCG8708+PZrKfY+hXXFtVpQjUnXB71+z3dUc
	hMJ1oO0xzvzzXq7MBzI7EbH83oUbgkeWQczuo7zuZpdvubjMxzOHFpZIlqHptosXjs9VVdCel9E
	2wYPsE/Q3ns7FXHu4QqLylM/UCE4gmMdXx5scW67iNDcTRJINJZvGFjPBY5jCzCI8+636Hb2bww
	9eJ8gT77NI6WTbroIC1BuM9PpMF4ubnDpvQpOgEkyoWCAdmIZcWR+5ksJqabbdiLA9x2z
X-Received: by 2002:a05:6000:4283:b0:43d:7ea1:fb53 with SMTP id
 ffacd0b85a97d-43fe3e15f7emr22065899f8f.33.1776698804352; Mon, 20 Apr 2026
 08:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-1-memxor@gmail.com> <20260418171701.610025-2-memxor@gmail.com>
 <3f9d8cf9-d025-410f-abd3-470433a4d479@gmail.com>
In-Reply-To: <3f9d8cf9-d025-410f-abd3-470433a4d479@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 20 Apr 2026 17:26:07 +0200
X-Gm-Features: AQROBzDwBj2Jsl-xDfzQzTt5aQZsvGwc_OldnddZAHtef0oSQqy4m7riNUglFTI
Message-ID: <CAP01T76Upx7sOcxG6v_ZvK5Nx=5zNLn=_DGuSEziowv4i80QHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add support for verifier warning messages
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 15:37, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
> > Add a mode where log_level 16 can be used to receive warnings and have
> > an associated log buffer. Add a warn() macro that emits messages to log
> > buffer without any restrictions, aggregate the warnings emitted, and
> > then use it to decide whether we reset the log or not.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   Documentation/bpf/kfuncs.rst |  4 +++-
> >   include/linux/bpf_verifier.h | 11 +++++++++--
> >   kernel/bpf/log.c             |  2 +-
> >   kernel/bpf/verifier.c        | 21 +++++++++++++++++++--
> >   4 files changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > index 75e6c078e0e7..47d60011d8eb 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -353,7 +353,9 @@ marked with KF_DEPRECATED should also have any relevant information
> >   captured in its kernel doc. Such information typically includes the
> >   kfunc's expected remaining lifespan, a recommendation for new
> >   functionality that can replace it if any is available, and possibly a
> > -rationale for why it is being removed.
> > +rationale for why it is being removed. When verifier warning logging is
> > +requested, the verifier will emit a warning when a BPF program uses a
> > +deprecated kfunc.
> >
> >   Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
> >   supported and have its KF_DEPRECATED flag removed, it is likely to be far more
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index b148f816f25b..515afcb83ec7 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -689,15 +689,21 @@ struct bpf_verifier_log {
> >   #define BPF_LOG_LEVEL2      2
> >   #define BPF_LOG_STATS       4
> >   #define BPF_LOG_FIXED       8
> > +#define BPF_LOG_LEVEL_WARN   16
> >   #define BPF_LOG_LEVEL       (BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
> > -#define BPF_LOG_MASK (BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED)
> > +#define BPF_LOG_MASK (BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED | BPF_LOG_LEVEL_WARN)
> >   #define BPF_LOG_KERNEL      (BPF_LOG_MASK + 1) /* kernel internal flag */
> >   #define BPF_LOG_MIN_ALIGNMENT 8U
> >   #define BPF_LOG_ALIGNMENT 40U
> >
> >   static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
> >   {
> > -     return log && log->level;
> > +     return log && (log->level & ~BPF_LOG_LEVEL_WARN);
> > +}
> > +
> > +static inline bool bpf_verifier_warn_needed(const struct bpf_verifier_log *log)
> > +{
> > +     return log && (log->level & BPF_LOG_LEVEL_WARN);
> >   }
> >
>
> It looks like there is a little inconsistency in how we handle warnings
> vs stats and other log type, all other log types go through generic
> verbose function and have level check inlined in verifier, while
> warnings have a separate warn() func.
> I think warning should either follow the existing design similar to
> other types or we should consistently refactor all log types.

I think the predicate for both is going to be different, in the end
both call the same functions.
Do you have an example of what you have in mind?

>
> >   #define BPF_MAX_SUBPROGS 256
> > @@ -848,6 +854,7 @@ struct bpf_verifier_env {
> >       bool bypass_spec_v4;
> >       bool seen_direct_write;
> >       bool seen_exception;
> > +     bool warnings;
>
> nit: bool has_warnings is a bit more verbose, but I think better
> describes this variable.

Ack, will change.

>
> >       struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
> >       const struct bpf_line_info *prev_linfo;
> >       struct bpf_verifier_log log;
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index 011e4ec25acd..2cf79fac8d43 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -154,7 +154,7 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
> >       if (WARN_ON_ONCE(new_pos > log->end_pos))
> >               return;
> >
> > -     if (!bpf_verifier_log_needed(log) || log->level == BPF_LOG_KERNEL)
> > +     if (!log || log->level == 0 || log->level == BPF_LOG_KERNEL)
> >               return;
> >
> >       /* if position to which we reset is beyond current log window,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 69d75515ed3f..8de2a4e5f5de 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -47,6 +47,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
> >   enum bpf_features {
> >       BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
> >       BPF_FEAT_STREAMS             = 1,
> > +     BPF_FEAT_VERIFIER_WARNINGS   = 2,
>
> What is the usage scenario for feature detection for verifier warnings?
> My gut feeling is that if you don't have warnings feature, you don't
> have warnings, and bitmask should just work if you pass warnings bit
> it's noop.

I will check, if it isn't needed for backwards compat with new libbpf
on older kernel I will drop it.

>
> >       __MAX_BPF_FEAT,
> >   };
> >
> > @@ -282,6 +283,20 @@ __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
> >       va_end(args);
> >   }
> >
> > +__printf(2, 3) static void warn(void *private_data, const char *fmt, ...)
> > +{
> > +     struct bpf_verifier_env *env = private_data;
> > +     va_list args;
> > +
> > +     if (!bpf_verifier_warn_needed(&env->log))
> > +             return;
> > +
> > +     va_start(args, fmt);
> > +     bpf_verifier_vlog(&env->log, fmt, args);
> > +     va_end(args);
> > +     env->warnings = true;
> > +}
> > +
> >   static void verbose_invalid_scalar(struct bpf_verifier_env *env,
> >                                  struct bpf_reg_state *reg,
> >                                  struct bpf_retval_range range, const char *ctx,
> > @@ -1683,7 +1698,8 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
> >               if (err)
> >                       return err;
> >       }
> > -     if (pop_log)
> > +     /* Preserve warning output across branch explorations. */
> > +     if (pop_log && !(env->warnings && bpf_verifier_warn_needed(&env->log)))
>
> Is it possible that env->warnings == true, but
> bpf_verifier_warn_needed() == false? As far as I see you just check if
> `!env->warnings` which better correspond to the comment.

Will check.

>
> >               bpf_vlog_reset(&env->log, head->log_pos);
> >       if (insn_idx)
> >               *insn_idx = head->insn_idx;
> > @@ -18803,7 +18819,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
> >
> >       ret = do_check(env);
> >   out:
> > -     if (!ret && pop_log)
> > +     if (!ret && pop_log &&
> > +         !(env->warnings && bpf_verifier_warn_needed(&env->log)))
> >               bpf_vlog_reset(&env->log, 0);
> >       free_states(env);
> >       return ret;
>
