Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F03F1047
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876470; cv=pass; b=APs+IiPMT38ItwGzvfXvxdSSHDOuU3T2kiGz+lj9YyHf48KM3kUczJNMMhGGCg+McvxkZSYG9MYvfk0i0VjzJh3pGA9DbnprgtH9aqp0tcWWDagVFc4AYm1+WL3H+3LiaQUX+gGaSi9YDKJLNFLLtnBciRleG11oypak1A85yz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876470; c=relaxed/simple;
	bh=bjf5Hsz9QIzLA6lvdSDKXAYUwc5cxHnM5lKA+KBX+WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll4KdIN2hnDNpGrl9has/jR9yW1uRciFsUZPw3XjughL3XAddml1hsCSkgOpPqyxH9hQOz26YrcLsbiQNsIHbk8EStssChLrLEHrJsAd3W9sWSshZr/pEznObZrRrAeQ0KC4FJIn/jTXOdvjmRgEFy3majhE29EphKsrH4u4Ytk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oq/z2bXT; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq/z2bXT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c7364550so545566a12.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787876468; cv=none;
        d=google.com; s=arc-20260327;
        b=C7ElGEtOf0TkKwMBBIPKcSwBogFpbRnA6w8ozD0dPGKv4YQWwBRKx+ft0WGL+A7ujU
         xzyoCbKyEJU5SvEVob+sWSW2SAUsBj/MPpYT5u1JSLc2mgLH335liNsRftRZUwDkB53v
         9BdeDpmuJtL6zRw5oKBMXIJho9l4j3Wv/w4SFlD59FAsuH5c0SCWgJF1ghMleLc3yfq7
         xTTT4mn6T8WpVNdCrjUZNJsBCzOyI7OkifBFfbsxnKY76NXg0ZJ7Zgs35ozc1XEV73ut
         cvXlBMLlfod78vH+2Cpw2tnXazhUqDxLzLTrr80e1qeAjNa1rz268ipwvDAP3y82bJP1
         ecUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/M3iuB7vkG6CWTTtd49jF8rSL19O1YOSXS3GGtvJSA=;
        fh=NFTkP+cRLv4fJhfIHZ+mII7UHhYVOJOhZOM1I9rvRx0=;
        b=QBT0jnsNG4cOb81F1RrZx2CzUMPzxtCGx+JRHvl1l2fknKscOr+V6GnTSk54i7oQMr
         DWMxQoogfG7H5drO/myBkQTDsuHrLc6lqkWrVqNprGxbkRZC3s227K6MRVWhX4sts1IS
         L220kgstHzXaRPyKdA6+vbxj0oNrph45hPSX0LP4ChyXNL66JNx1XuCvhCbS4MOmOpi2
         o4jQoGvE4Ne6zq+4KodfQjYKsb9bs12T96uZlSV9otTDymOY/k4+ixnnZOIta+OF6VsQ
         2KdlNZpW5gnu7CDJ1hMLdc4dQmFtz1g8GGsYZ6N4o3oP9tDjWpWvjF+VSTvdPLnh5gXJ
         REEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787876468; x=1788481268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/M3iuB7vkG6CWTTtd49jF8rSL19O1YOSXS3GGtvJSA=;
        b=oq/z2bXTNGFDYjGU5xk33bsrAja1VXKdhrICrNw9fAQcJDmPO+CO6nozUlCmNqFexd
         1rW6vmH8+t4zItFSlhyZ5/1CmSkz5rfAIMoayZh6nJOYk4sf0DwUEyUi8OlALjWt53D2
         fuXv9TI7RSDG46ah2JuuAcf1JldT/8SHplRB0jRR7NNQQfLMvvBFy22X/3H247AaKcvR
         Zm+7v7yVV5xzrrtxXo89sIAS8Ym7nNHjwj2QukVif+nc9KatrvrPm2PqAPWHnSbmmgSQ
         Pxzl2Zf+65o2s4zuFF44kEYOBSpbpDGJjSOwWQYxUFNG4VJN5d766Rr+C0ddLUlLpX5d
         xXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787876468; x=1788481268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/M3iuB7vkG6CWTTtd49jF8rSL19O1YOSXS3GGtvJSA=;
        b=PtpqeEKdk0uI5uupwkcdBknnTqvLTWQdwkpQJieLZFrsDRua/bigvwRr4ya8LKwij5
         AU1yWZoteXdBrOYTjx2TqNK7iuQJcenm7/FODDULgWfEpBjLAgTx4OpTRWmBUwjprLR5
         3fMESpKkNKZwEpOzXlUf9FPs9FoOZElLhdQENvsSDsVMVD3uEcMbCxZkNNHjBiOIK2KZ
         9SY2l/x9UXgauWUqCp1BUa4PMy7tAHUbJWTiJIIbKlEjNHHEMrtsu7NLDsB2HhuSphcH
         1z3BJWMMtbZr15qcrZ8mlNPFlIK54T1nHJxps7tLOuyv2nUQizOMtbupHKKjplmXwPJl
         Y2JQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtcQvCZdPUwQY8+itrP4mbgpNnco01Ke+PcqVHERJxbQSNI7IMfZcv1zPnYgn5TYuSkSo=@vger.kernel.org
X-Gm-Message-State: AFuF++l1rSj+oDT16g+33IN00Pp4iVGXDWUO00S/uXZ9RF1jV6m32Pzg
	/x9Tb9lw2xbsVhBisFplb8ERQeTvAuqB+0xDgWQM4h8D4vz0h7j2//A6o8zI8yDuaavb+QfFy7G
	AZ8mU+SsZAjGuUsqlkztIedekBkJDMro=
X-Gm-Gg: AR+sD107nz0Y27BIxioQutnxGYGWKwc3XSJuGW2+eUr2NOsw+klwoLjyJhis0/joTdj
	OP+pPKx6xBpz6q6vvZ4V7jyJQzfE+TGMjWBHQgpd/NB+CSA9Xk3vPT7Q2scCy2gX59P1NnYYs8M
	rjiWxxm6EOivoxGhYmFh+3HPkaWsmusxeZ7ZiX6E8BW3ohmUEktaYkrnCvMiq/lbbWMtZFINf7+
	lZNCEQbYot+2muSvNX6+lbb/o8yo0P6SJPLM/XiM8yhzM6epIUtpN4OtL6tP/o/CfJo8S1EcJNY
	91fC7tjqDZDEvL/yZV1tfT+jfolLg07hEy/4frfOU4ktW2+vOB4If+Aq7sMbo8HGYP+mngbbGLk
	asHt1HAM8rmumU7r28fuB2ozvag==
X-Received: by 2002:a05:6a20:258a:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3d2686a9058mr4249511637.9.1787876468214; Thu, 27 Aug 2026
 17:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827100214.169215-1-toke@redhat.com> <f8413c983b5bbf569125bfa9d12a81f2293adc9905f89d746cc51276c21459ea@mail.kernel.org>
 <87cxv34rsi.fsf@toke.dk>
In-Reply-To: <87cxv34rsi.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:20:55 -0700
X-Gm-Features: AcwNN1UthGpVkmYrvAH5z2HeAW139K55ZeLEO1miPfjporsm5eaIOOJ6W6eK0Ao
Message-ID: <CAEf4BzaupNE1_svo_zjOB+ccfZWUrAm7s5kJDCMOnMKaZ4Odww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move XDP frags flag to prog_flags
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	lorenzo@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> bot+bpf-ci@kernel.org writes:
>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index b749c01742ee0..7d6f0fe518d99 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >
> > [ ... ]
> >
> >> @@ -7879,6 +7877,12 @@ static int tracing_multi_mod_fd(struct bpf_prog=
ram *prog, int *btf_obj_fd)
> >>      return 0;
> >>  }
> >>
> >> +static int setup_xdp_frags(struct bpf_program *prog, long cookie)
> >> +{
> >> +    prog->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >> +    return 0;
> >> +}
> >
> > Does storing BPF_F_XDP_HAS_FRAGS in prog->prog_flags here break callers
> > that use bpf_program__set_flags()?
> >
> > bpf_program__set_flags() overwrites rather than OR-ing:
> >
> >     int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
> >     {
> >             ...
> >             prog->prog_flags =3D flags;
> >     }
> >
> > Previously the flag was OR'd into the load-time opts by
> > libbpf_prepare_prog_load(), so it survived any user manipulation of
> > prog_flags between open and load. The new code latches it into
> > prog->prog_flags at open time, so it's lost whenever a caller assigns
> > prog_flags instead of OR-ing.
>
> Making it possible to manipulate the flag after loading is the whole
> point of the patch, so this is expected. As for users like:
>
> > bpf_object_load_prog() passes prog->prog_flags straight to the kernel:
> >
> >     load_attr.prog_flags =3D prog->prog_flags;
> >
> > Two in-tree callers do exactly that on SEC("xdp.frags") programs.
> >
> > bpftool (tools/bpf/bpftool/prog.c), i.e. 'bpftool prog load FILE PIN
> > xdpmeta_dev DEV':
> >
> >     if (prog_type =3D=3D BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
> >             bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> >             bpf_program__set_ifindex(pos, xdpmeta_ifindex);
>
> ...doing a set_flags without preserving the existing flags will lead to
> clobbering, that's what's implied by the API? So any users doing that
> are buggy, I'd argue.
>
> > Keeping the load-time 'opts->prog_flags
> > |=3D BPF_F_XDP_HAS_FRAGS' in addition to the new prog_flags initialisat=
ion,
> > or having bpf_program__set_flags() preserve section-implied bits, would=
 give
> > visibility without breaking existing callers.
>
> Both of these options will still make it impossible to turn off the
> frags bit after loading the object. I guess we could do the "preserve
> section-implied bits" part and add an explicit
> bpf_program__clear_flags() to remove everything. What do others think?
>
> >>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-s=
upported sec_defs */
> >>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
> >>                                  struct bpf_prog_load_opts *opts, long=
 cookie)
> >>  @@ -7892,9 +7896,6 @@ static int libbpf_prepare_prog_load(struct bpf_=
program *prog,
> >>      if (def & SEC_SLEEPABLE)
> >>              opts->prog_flags |=3D BPF_F_SLEEPABLE;
> >>
> >> -    if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> >> -            opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >> -
> >
> > Should setup_xdp_frags() keep a program type guard?
>
> No, the setup callback callback is called too early for this to make
> sense. However:
>
> > The trigger requires a deliberate retype, but the guard removal is a
> > behaviour change that the changelog does not mention. If the flag is me=
ant
> > to be XDP-only, should setup_xdp_frags() keep the type test or should
> > bpf_program__set_type() drop the bit when moving away from
> > BPF_PROG_TYPE_XDP?
>
> Clearing the type-specific flags on type change could make sense. I can
> add that in v2 if others agree?

no, let's not.

But instead of making this XDP-specific custom callback, let's have a
generic default libbpf setup callback that will do the same for
BPF_F_SLEEPABLE, seems a fair game (and technically will allow to
dynamically downgrade sleepable to non-sleepable, if there is ever any
good reason to do that)

pw-bot: cr

>
> -Toke
>
