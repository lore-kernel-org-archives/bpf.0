Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEE25B2FA
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776544479; cv=pass; b=ZfxN8BSwIdYXFlIfw8LqCHP0LZ1wYVoqmKL0ZSCFskxrnh/Xasy1MI1Q24Lr1KzwSMyRI4ploYLyJDO6FzHY97VoY1awBj+cXHNxW06DG2F9OTyFDwskWj/VZvtBlgV26zs0JqGvwdRiw2CUr5+VUNA0mOzV0uinMNe9CErLFBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776544479; c=relaxed/simple;
	bh=zSH61zPq7ho/3oDm6Z623xkw2pZm0YZSEuIlUtQIjPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XntLJJABuPp1Foufsy/bwX5Cd3zyHcZBO2Y2lnfscVmdKiHlA0Pp8k9THTRunA+4kwERlxPKoNcYVhPquGWE8hl5a0PP966EPfDfAl02spR2keKl417RPXG8LyqBk/yYTpgULs6OgJcH/kAk8OI5hksqpyr95vswDuV83i5Wjq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyw3HslE; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyw3HslE"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so726426f8f.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776544476; cv=none;
        d=google.com; s=arc-20240605;
        b=RD7JzghTzhQQi5+S3L57yTDqMcXiLG02YmQAWFLUHM5QNQkLttPKKmVC/awChp10wH
         KyiKjd7N1MyBvC4rdZ6woWnvS4utzIsRvUsRBc5kwfKWYXBLJ0euqjhA/RRW9BvRNxRe
         WV2l0bN2WlwGYlgq0hmatBvVqY6N40X+lo6D5c1fOIYWtJtiKzomCCY642kSHNuj9BnA
         GQYSqZmLyr6ol9Vfai8CQFGh4S416Hygy/8D2b6yQ33nbETf6EfS4eiBDz8G+z+wbIA1
         6PMwwmpJHZEqi356+WFoZmh9mz55ot/SRRfxXQVaEhc5oyg45ib05zuGqT0u3XQVofhP
         LIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JTCAV7gPntav4t0K+c6AM2A4cKKE6i8QjCPAIqEW+7U=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=WYhf+69o/eLiVkp3/wAoef8AZohiDEMY3oNm4rsMwYa/BHofX5yVfhXdJXbhFsRLoZ
         O2tTtzPNKhCQWrNw3L3MwMKIYNk96jwD25EAfU6pBZ9yna0jXunyyP9j4GR0mOIMLVn5
         nKNFmF7DMA85jwo5opBGqdcgHLWsMmaV4R3xJhQTumJxnY7DQukXZ7fGZ/t0X+QvZHLW
         qpGcPKRlz1FoNupOJ8vg7EpzHKdWQuqu8cXcI0R1f75ggsegD4QxQos0BcT6l+Yp/E6Q
         Du+1gCny35A7I355yXu/IWkYGjjTsZYlcqpUa0DNRg58laoE9NbngzaNdMgbR98fWRDj
         5wog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776544476; x=1777149276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTCAV7gPntav4t0K+c6AM2A4cKKE6i8QjCPAIqEW+7U=;
        b=Gyw3HslEzscMJ+1TFZmh75ihwa55TFphE3Xmaz3C4SffrCZhSdowtevD+PcCLkHv8L
         s5l7c0AxdxoupAlDJxuTX8m6NlyVZI2+XE/InHQ1rSqorzCW7vkYC39z8XQX/Phs4cNH
         rUNEukAsv8WpIV7olkGTbWG1tYmDt+WW8J6delWBpT26ne6yg1ZdPDVltWdKt3bjA0Sk
         OxA3Dd7BS67KvaeuDnjQNtR4Yt3ccfLqifO+rZpPe8Lp/arI/a07yd2zjLM7rMF7BKI1
         +Ke5q3SjfBcN1kg2j0DUHf/PG33eQGsnNvBcr7SQExg6MCPXa8EgPQ3vVxB+CepZVcjl
         xFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776544476; x=1777149276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTCAV7gPntav4t0K+c6AM2A4cKKE6i8QjCPAIqEW+7U=;
        b=AWQMqSuVQScZJ4wMLyFg7BxPtN1dTNUb3pPCCaRv5MQXaytIxI66fgPxO+ZdYhwZMF
         v2ZJ5TdZHm/juwdNAetd2cMpXNL33Fhz+ZFQ/aZnykpzlIAVqB3VpftOjuQPHImk4LUe
         6kygv+YT3S6/kR9vET6S6pYNu2V95AM/EbBK7XBThyf9Tgsfxi0SP/YG1/H1VE4QZK3Z
         M6RYLcHIPwM/6NiZK4Nr0MQp/Ew/5he27JURzZT2dJQ77nA9NfSME9S31Yam9NC5Pnaj
         USpbOru0E44AIhLncP5IXC+CKSrHNDxu/MURflqoKp03gWFZB5f7rUYjM1vdsuAlDsro
         WRsg==
X-Gm-Message-State: AOJu0Yyi8gEN4hRupf4KKpvir/aj7E8gVQgKb9dJAakhTSQZTE7ohrzd
	0hOyC0I7BuSPFPxVuVwx00+6ucT9WU7bVIyg+rqIhHdFSWG+UZ8Zy/PD5I7TzncPf2F46UF9jdS
	azzW6PrVug0oXEIwpGKGHQGttoK9cKkM=
X-Gm-Gg: AeBDiesR1I7p06bVTDjc6T1ZTBlDbL3gztuKzliG0IMQVUYKimGXSgl0yC3FRNquRxY
	wXNZgaC03nBtsjVAFV27f4jABO7vRoqk9q/Urku/xxgntbQINVgr1fV5tV2pTNpB/YQu2Jqv1GA
	mDIxs8Dc4yeOvaPnPAgK5aVzU1F4k3BVrsPmWrgVZw4cwHVhGpwuq64QZcw1JDpj/7aYECUbsJu
	Gtwfq9v0nhxQnGxkYYtRqQjRw2EwGO7/ye8raUvRZXIj6EyuW9MfE9NlXx/n51WqaWC7nHRAV0E
	4tOTnHEFlGfuyDHTB//aGZ3k+DqH+w7rsr3m/jbEJVy3ASmImTp0i1BgAwfUH96VrTDAT5dZBCf
	bu/w8dvoYn1FOBf+UW+h0wE9lpy6/thpayM2mwqRH7hWmo3yb9pqX4xSiNkktvA==
X-Received: by 2002:adf:ffd0:0:b0:43f:e413:f6fd with SMTP id
 ffacd0b85a97d-43fe413f7c0mr8500983f8f.0.1776544476131; Sat, 18 Apr 2026
 13:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-2-memxor@gmail.com> <20260418174214.1A764C19424@smtp.kernel.org>
In-Reply-To: <20260418174214.1A764C19424@smtp.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 21:33:57 +0100
X-Gm-Features: AQROBzB20kK2f1gVCyqNeNyXIqM0F95-WYuhzW6KxD7p8QcxA1cNf6fVs6DLklM
Message-ID: <CAP01T77ZjTWhHffh42R17xmsVwKkjRD8T2=8MA1TT1Y09GG2+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add support for verifier warning messages
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Apr 2026 at 18:42, <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] Unused static function `warn()` breaks the build and bisection.
> - [High] Disabling log reset completely after a warning leads to log buff=
er explosion and overwrites the warning when combined with `BPF_LOG_LEVEL1`=
.
> --
>
> commit 35e5ff3f696c81863084f9e6fb58225f8242f3e0
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Add support for verifier warning messages
>
> This commit adds a mode where log_level 16 can be used to receive warning=
s
> and have an associated log buffer. It introduces a warn function and
> aggregates warnings to decide whether to reset the log.
>
> > Add a warn() macro that emits messages to log
> > buffer without any restrictions, aggregate the warnings emitted, and
>
> This isn't a bug, but the commit message states it adds a warn() macro
> when a static function is actually added.

Will fix.

>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 69d75515ed3f7..8de2a4e5f5de2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -282,6 +283,20 @@ __printf(2, 3) static void verbose(void *private_d=
ata, const char *fmt, ...)
> >       va_end(args);
> >  }
> >
> > +__printf(2, 3) static void warn(void *private_data, const char *fmt, .=
..)
> > +{
> > +     struct bpf_verifier_env *env =3D private_data;
> > +     va_list args;
> > +
> > +     if (!bpf_verifier_warn_needed(&env->log))
> > +             return;
> > +
> > +     va_start(args, fmt);
> > +     bpf_verifier_vlog(&env->log, fmt, args);
> > +     va_end(args);
> > +     env->warnings =3D true;
> > +}
>
> Is this static function called anywhere in this patch?
>
> Unused static functions trigger a -Wunused-function compiler warning, whi=
ch
> can break builds when CONFIG_WERROR is enabled.

Would just be unnecessary diff noise.

>
> [ ... ]
>
> > @@ -1683,7 +1698,8 @@ static int pop_stack(struct bpf_verifier_env *env=
, int *prev_insn_idx,
> >               if (err)
> >                       return err;
> >       }
> > -     if (pop_log)
> > +     /* Preserve warning output across branch explorations. */
> > +     if (pop_log && !(env->warnings && bpf_verifier_warn_needed(&env->=
log)))
> >               bpf_vlog_reset(&env->log, head->log_pos);
> >       if (insn_idx)
> >               *insn_idx =3D head->insn_idx;
>
> Can this completely disable log resets once a warning is emitted?
>
> If a user requests both standard logging and warning logging, both verbos=
e()
> and warn() will actively write to the log buffer.
>
> If log pruning is permanently disabled after the first warning, will the
> verifier dump the state of every successfully verified instruction into t=
he
> log for all subsequent branch explorations?
>
> Because the log buffer acts as a rotating buffer by default, could this
> flood of output wrap around and overwrite the warning that was meant to b=
e
> preserved?
>
> Would it be better to track the log position of the warning and reset to
> the maximum of head->log_pos and the warning position?

Good point, should probably do this only when log_level =3D=3D 16.

>
> [ ... ]
>
> > @@ -18803,7 +18819,8 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
> >
> >       ret =3D do_check(env);
> >  out:
> > -     if (!ret && pop_log)
> > +     if (!ret && pop_log &&
> > +         !(env->warnings && bpf_verifier_warn_needed(&env->log)))
> >               bpf_vlog_reset(&env->log, 0);
> >       free_states(env);
> >       return ret;
>
> Could the same log buffer wrapping issue happen here when log resets are
> disabled after a warning?

Likewise, will fix.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.61=
0025-1-memxor@gmail.com?part=3D1
