Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E944E045
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989871; cv=pass; b=p6AyzctqnkyRM2PubD8bvlQrqJ5xkIkS+YW1UaEKFpoFIc8YMe2jBKN09bsvOKJQJAkpGVQL8qKrif19iM9xdRkxbYxx/UeKwkyAeQHNFsRAO4Ou7fYzppiHIqMyhovbHQ8EGMvgRs6kp7FBDjKhExa0q3RyDhQ/UYOQfpWgPNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989871; c=relaxed/simple;
	bh=4LsiFgBeJHT970AX6k2Wx8aqU0/uzuEcAS1cDOyqHEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0/0sQvS2DPSp7soHD1Lp32xDjbpVHjbF4BYIB0sHZcZ+TNOId1LH8uaNATZI37+0WVt/hrIPOkBd/AeUi8uSWKYz+YXUIgkmDZ7ZOITQN3cRIK70Bh5V1h4p48Ye1SRY678epf2WZXvqEXkdPPRDWoJiFQsclH/UQoLq6E1+VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjPKDpJ1; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjPKDpJ1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so2254146a12.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 13:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774989869; cv=none;
        d=google.com; s=arc-20240605;
        b=icDqB1/00wN8z0WhYMLov2qKD2IcxocOJh2ME9gqKJJj1nh7B+V4o4f5IDZSyn9ANh
         FJJLXZdedv3Ow69KtJxX7avpzgfxMbPK2d9Au3hF6S519AP6LMS8fNnpWsPIHe8Hzn5q
         NZ8cbbY6+nzxLdd7b3XFhWdZS7CfJ0gC/oIjK/3bCUVAZwcOavbFw9qLpI+xyTCYMnKn
         /qKGhL953/iuhdLalXrLsU7uyL75Slafl0gibEMvke3qweWTedlaPYen/SLORPwWJCh+
         VjP8x/dr3nN982tDU8cWYZ6APpXXPhI8nmy9pjKmwu1DeeZtVaJ7gOeU5w8TrfO8d62f
         9mRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9MdEUdPWAqggvPPuWV2Cb/e/0EeHkK2+/HnLUYI25A=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=gIwummCZBWqSWeTuKaizLNy0h4KkjnOeWNUPfp2uRnJzmg0bd669QwJMhFbq2olfyX
         jb/Nno01EpOdoiTUTzqfA8NgtGz1hMbsufREjenYDOEbD3aY1rSJ3ECnvS2/WkNPljSk
         cdoqRzO8Zi7lv/XYhj8Mwl4CFlgFLy2XJaTrkmWX3CMipa0L+qUTsJH+nfMAF5dy6b6f
         BdsYxC23/GCHW8lSp/FO33l+xMqxSg3h/3k0FchNbvgvWd1ybRVLg08Nc452X0fNg90s
         Ct44zAIrAUpQyLl2ugbj7aiUHKxS7O4WK5NGevQmPNpuwMk2yDyM5nwmBm/5z8tSAt2j
         LESQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774989869; x=1775594669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9MdEUdPWAqggvPPuWV2Cb/e/0EeHkK2+/HnLUYI25A=;
        b=VjPKDpJ1uyE2Fj6KgTUdAaEPfN/uO9retSsuWeACfk7giMs19GhNykTtS1Rs0SsrAy
         +pfLsI9yPebRmOoUomQiGtK2Td1Km4kPsr3C9B1ve+qJDag1tirRWfagzm3oMvGJG64Z
         qzDCTF10jZwNg4ujOm6pxVCEiM8YZHVMJttlAVqhXV06TwwjN2VUg/13ZCrri2H2nob3
         qePA78a9ck4NaM43uhtMEQu9tB3qg12y0LhckomqXj/4DLCFT7brLPp1zCa10rHfF6iQ
         xVQSKZSOVPq7XPGfAPM9NuOgbzY/9lMTxsRLKvn+jZTaXwXK4lleSGFYCz8cWU3p43Vi
         BouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774989869; x=1775594669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9MdEUdPWAqggvPPuWV2Cb/e/0EeHkK2+/HnLUYI25A=;
        b=ZSyr24SFABQrMDrmAG6/lMtaHBRmLSA+C/Y3t+/K9TZ76Sj/yMjwqa3Ux22/ipqTRo
         KBXOQaj5Y8VP+U4YcGTjY+7KxGM5QVzWo08SRgdNpbc89f8pUSKyeLurXkNDlo8DYqp5
         qrWrjCx4oqxswfudVoIs1cacw+/z/49Bikpkby8enjf6v8Sz+lGSodoHqlW5pFfGuU2U
         3cEos1/Vd8WR5uThdjHFpWZzAuRwwA1WB+APMzXdhvBcDI31n3MU9qO4Tpt6ba0jf74r
         uoLHJJsYPOoNWQDo3EkJvcFHmVOlFHZihYtOy2h784RkzQ+wzBJyBfW4VS0QK1exf5C7
         XoaA==
X-Gm-Message-State: AOJu0Yy3f+pZMZCnsd3Ls3y5GUgggdY73OjuZf0UR6saOe8uYfUvTAVM
	bUyFzWnwddSMsC7xjc8nVtvelV+kHNn/0WXjeItJVQzaKFgUUZshfcuyFVsjZecnlHFamgQDWDw
	i6VjHL6IRVGiBFkg90MuqPfDUteuxGCM=
X-Gm-Gg: ATEYQzzozrBpjed0W1SkNoh6zdxstTDnVPxnUzwlFohOOUtGu+5ZdNGrQf3X6t6JVvA
	BWUp4V8Fap886BHiCMAGSraAU8cm/qqs6EZ2e58aDAPcq8xjcYFhtVswJ4yXkk6MjrrT+w4Pp/i
	+cU0L/bnEY76Kzz7xvcHRdRjLrQeRPZf8nOiU9L2ixhKqbHv9fVyelPyfoxcjBxXqJXxidsDP0W
	JO85kXF7sj0stsJsUMMvQ/T1s03gp6zuiSAa7Kq0fxUOTCyyZXgVXrGYBSBSSIUeoibLUNXQyFq
	E1ddZ43S+vXXHjC0NbZkQ74=
X-Received: by 2002:a05:6a20:3c89:b0:361:2c56:fca8 with SMTP id
 adf61e73a8af0-39ef77173b3mr647964637.50.1774989869047; Tue, 31 Mar 2026
 13:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
 <20260330-sleepable_tracepoints-v8-2-2e323467f3a0@meta.com>
 <CAEf4BzamwGd=_q4aHiWDx5cyRWPNHpH=9JwpsHeFrxCv0AFg7g@mail.gmail.com> <ad6e293e-6ce4-4a7d-8896-2848c4477ffd@gmail.com>
In-Reply-To: <ad6e293e-6ce4-4a7d-8896-2848c4477ffd@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 13:44:16 -0700
X-Gm-Features: AQROBzBZ6v-tZdBV06b0msmi0G-_jKcefeQ_lBmzH37bDskYcBCfCa6820Dg0jM
Message-ID: <CAEf4BzZCcBkR7eEJoVYW=siA8Uw-qM3KgVUS4wo7tFh3VZGuNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/6] bpf: Rename bpf_prog_run_array_uprobe()
 to bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 3/31/26 1:46 AM, Andrii Nakryiko wrote:
> > On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> bpf_prog_run_array_uprobe() will be used by both uprobes and faultable
> >> classic tracepoints. Rename it to bpf_prog_run_array_sleepable()
> >> to reflect its general purpose:
> >> per-program RCU flavor selection for sleepable program support.
> >>
> >> Add a bool is_uprobe parameter instead of hardcoding
> >> run_ctx.is_uprobe =3D true. This flag controls bpf_get_func_ip_kprobe(=
)
> >> address resolution and should only be set for actual uprobe callers.
> >>
> >> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   include/linux/bpf.h         | 7 ++++---
> >>   kernel/trace/trace_uprobe.c | 2 +-
> >>   2 files changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 05b34a6355b0..9fe19ab21cfc 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -2487,8 +2487,9 @@ bpf_prog_run_array(const struct bpf_prog_array *=
array,
> >>    * rcu-protected dynamically sized maps.
> >>    */
> >>   static __always_inline u32
> >> -bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> >> -                         const void *ctx, bpf_prog_run_fn run_prog)
> >> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> >> +                            const void *ctx, bpf_prog_run_fn run_prog=
,
> >> +                            bool is_uprobe)
> >>   {
> >>          const struct bpf_prog_array_item *item;
> >>          const struct bpf_prog *prog;
> >> @@ -2504,7 +2505,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_=
array *array,
> >>
> >>          migrate_disable();
> >>
> >> -       run_ctx.is_uprobe =3D true;
> >> +       run_ctx.is_uprobe =3D is_uprobe;
> >>
> >
> > nah, we can't make it into generic "run_array_sleepable", it's clearly
> > uprobe-specific due to this
> >
>
> What's the alternative, though, just make a new
> bpf_prog_run_array_tracepoint() hardcoding tracepoint-specific
> implementation into it?

you know what, I checked bpf_prog_run_array(), and it turns out we do
have .is_uprobe =3D false bit there, so I guess we baked that field at
some point there.

So what you are doing here with configurable is_uprobe flag is fine,
let's keep it
>
> >>          old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> >>          item =3D &array->items[0];
> >> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> >> index 2cabf8a23ec5..eb4d78e689ac 100644
> >> --- a/kernel/trace/trace_uprobe.c
> >> +++ b/kernel/trace/trace_uprobe.c
> >> @@ -1402,7 +1402,7 @@ static void __uprobe_perf_func(struct trace_upro=
be *tu,
> >>
> >>                  rcu_read_lock_trace();
> >>                  array =3D rcu_dereference_check(call->prog_array, rcu=
_read_lock_trace_held());
> >> -               ret =3D bpf_prog_run_array_uprobe(array, regs, bpf_pro=
g_run);
> >> +               ret =3D bpf_prog_run_array_sleepable(array, regs, bpf_=
prog_run, true);
> >>                  rcu_read_unlock_trace();
> >>                  if (!ret)
> >>                          return;
> >>
> >> --
> >> 2.52.0
> >>
>
