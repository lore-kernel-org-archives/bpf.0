Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BC48663D
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682452; cv=pass; b=lcQuQTINbezRs2RXxa9MeouhW9JcmzFKNHqZyvOw7jC3PI07h6tWV5656nPKFLY2ZIJuoMlhmniEWO2+LH6dVL7Wjwda77ulitvWVGzyaAxAOyyuDFJNlVOIigX68oKlSirMNjfks9WujuJfk4jXN1uIOb+9scsRLnk9yoa0DgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682452; c=relaxed/simple;
	bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1VvkkIqQeo7h1qPwR8ycdf/ai9U/fwTC+zlfoj3FTKOCjhT7Kayta5nKTJwv+nfUKM5nHbVOrCyrRXsvdbfp8q5Uv39BsI6R65TZpwuHzEm+Dc8ZFTTK71uLLlzW306F41pIZAaW/wSoqEUQVJkPFd0SbirqGqmmhwQcrE/05E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3In9U80; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3In9U80"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso38449a12.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682450; cv=none;
        d=google.com; s=arc-20260327;
        b=StWKR6RQ8Jvog06nkWgdJMTMtPF3dFBo0xhvjicWYsg60dzJFP9mnz0FyO5WlpGv+0
         LzyaSTLfcU/Q6pcePhtbUXQLKdlpOFLrlbxrNakaVrrNNuNTkTCi4EXU2xO46EnCBnCI
         ARwIrYvW9ZetmCJ2g3GJc95LuCB+Qvra/t04JUdbQjpPTYb0FwEDiRRv7HAgUXkxknh+
         bqucY5TrBxdbeXmgWroyAcUMO6em2gLc1TRDtADzRxE1TwzOeupHxT3+4UlwAFoyA55w
         JgRQkvmiYn/c426YOcSX85ucVQ4KA8RJBTeUTl+qOQqGevSmPBwlcUbq5GV875jgMz8m
         kQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
        fh=7PZC37LH2sGqwLEK76lee9BsohGzibMfIH5NgvVumkM=;
        b=gFiftu8BGttIkwI8ml73wkARrd39vxKd/8JCnn5pXpaYEDt7fC0E/0OChiL2gLWm7X
         EfYy8zOMIaTmGUPbb9S9R/sX3g2aIdG3oqrWDRKCSAB5R8SCngDXLRonXn3g6j/eDnui
         FeRqp542Ug6TMxiUOJCPUMZSZpvUyWF4ZoSlUWnXgHb9p+UR7Qb7MGiGIoRLOlTdcW3r
         PchsCSaiTM5cmX3ia1PCuGT63Ff/Wp29zw1m1m/jIUYDUE3qlAUypWHOqUFc9IXBVNG1
         CrYRJzmEb8aJNY49iQGcYbGaJ38oGTLaVEFAqOIce6N75KeG2fY1i8jnIeH8vQDu5skn
         SKag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682450; x=1788287250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
        b=X3In9U80BKpQbeNg61vgbUs9CA+a1cg135fGIgEm3O2UMuK73+9jQKnn7SQFIUlkxJ
         ob8U1VCXRkIG+yu+uMkoVPk9Z+wgw5eDoX+7kXkYd99d3E1QhOgl+GaSpynJ8UtWANSd
         Z1BYU2bUxEAQjYX5rJg79izzLf5cowzGtmS+JqMhY+kjgIVaO0IKEMX6Zb+2Ym32Pi7P
         13RUX4PPkQasY/K4n7qcbNPESlgl/1vn+Wq0fFDKZ2cxC3dP4Di3d3NG/b7XS4kJZUQ0
         4YBtH7F13ecWUJge969Aw/ezoX0nYnWlBEYJjn4woAVHsXgEAjW2Tptr8+RncoR80tsB
         DNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682450; x=1788287250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
        b=qb8JQN3Is4yPEGrlJ+NFzAG5/I9+1TLK4UP5UX2Q70zage/CuBi/c2PKNmo+m4Q3Fc
         KcZBuXfW/Y3RydFQ1bgQhRgNL6dRLN6a1dlna8w+77WN4khhGbSwD9EZwWxk5nTTWdpH
         rKVdjN8hWhKXptox9IKqD+VCyTWggN0oN+xKEUG0RwGPWnB/+hK7dOwVUsZDJlDwxU6e
         fzt4zdQ/wfGw9Xv2SWq5z69YUSvtuQV3wglO1lhE0ogahtbf7PgdiKZR+T2bj/E/+HRB
         EAZH+v2XaecM2Im533mnhsrxlXc8Gv8iP4Qg5/iWWCmjBC/0sJeu0dVBpQkI6EsrIgq9
         +sGw==
X-Gm-Message-State: AFuF++mJmTssYeD7sRdKAT2aSvUi+yzHFXfyeThrYJFx3SmAhps6HeK2
	xFrXACzbRNh8gqWiylMTZe9zsG6iuDmnGVCBNzbZd0g3tMwJsOtZO/tmez/FUtxlAYJmMfYt4ZG
	1MJcKOXdwdqwy+f2yTpONBWE/87xM3zw=
X-Gm-Gg: AR+sD12t03xvTl6ifzoxr3qazSMl8FGJfcdlMniQPKBT0QBzMYzY5PQlZxF4xHux4kF
	NzwC7VY7l4vwllfU0W0ThkJ5IKxmsGuEhNAhZPVJI4Br4utTbLmktXtwN5hBW1R9mgzhcBVKsLg
	byfrnigLem/5BIJs8HnNLxUwk/tazSQdKbp1Ut4rUpmRfHnoicrb455KDjJlAjaY48hKfcFaobX
	hIvW2fw50yeryEflXni9MYsCzjGEBOCpoO4ii0hNv4MpOramcCync8VcBLTOVGPpqFJmBULkZ1g
	IAAd1eh3ME+dh7utXSjXYuam2cnjJjR3mLc23UwdRJeJ3GiQZIhMhIKD4P4bgm90jbopOHEIK4T
	sHf3MxEgfYruaP9qXP5DepOrfg1GIwjJl5sAazk4RhA==
X-Received: by 2002:a05:6a20:eec7:20b0:3cf:a7a5:e310 with SMTP id
 adf61e73a8af0-3cfa7a5e417mr148047637.9.1787682450200; Tue, 25 Aug 2026
 11:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev> <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
 <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev> <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
 <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev> <CAEf4BzZpB-qkhu3SAu5MrYYAT2+ZN8WaXqpmnKruOOdjJOLK2A@mail.gmail.com>
 <7f18980c-0c15-4862-af1f-f451ca12dac5@linux.dev>
In-Reply-To: <7f18980c-0c15-4862-af1f-f451ca12dac5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:27:14 -0700
X-Gm-Features: AcwNN1X2RE3UG00GfCM7tcLMBWO7FTBVU9F1ssGpubHcRFwnWfxEEW3QwlAbcZ0
Message-ID: <CAEf4BzbS8enxXg7YfWXssBg4jPHr2Z6L9cAigpfUNxiOep3BJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Avinash Duduskar <avinash.duduskar@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>, Rong Tao <rongtao@cestc.cn>, 
	Eyal Birger <eyal.birger@gmail.com>, Pu Lehui <pulehui@huawei.com>, 
	Jingguo Tan <tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:15=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 25/8/26 04:02, Andrii Nakryiko wrote:
> > On Sun, Aug 23, 2026 at 10:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>
> >> On 22/8/26 01:46, Andrii Nakryiko wrote:
> >>> On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Leon Hwang <leon.hwang@linux=
.dev> wrote:
> >>>>
> >>>> On 15/8/26 04:14, Andrii Nakryiko wrote:
> >>>>> On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux=
.dev> wrote:
> >>>>>>
> >>>>>> Similar to the tracing_multi link support for kernel functions [1]=
, add
> >>>>>> support for bpf progs.
> >>>>>>
> >>>>>> When attaching to bpf progs, it must attaches to the target by tex=
t poke
> >>>>>> way.
> >>>>>>
> >>>>>
> >>>>> Please spend a bit more human effort on justification for the chang=
e
> >>>>> and explaining your use case. In what case you'll be attaching to a
> >>>>> large amount of BPF programs such that attachment speed-up (if ther=
e
> >>>>> is any) matters.
> >>>>
> >>>> Will update the cover letter with justification and my use case.
> >>>>
> >>>> Here's my use case:
> >>>>
> >>>> I'm planning to enhance the function-graph feature of bpfsnoop [1]. =
It
> >>>> will trace all bpf progs, including their subprogs, to draw a full
> >>>> function call graph including bpf prog call sites.
> >>>>
> >>>
> >>> fair enough, interesting use case, definitely outline that in the nex=
t
> >>> revision (and provide before/after attach time as well for such use
> >>> case, please)
> >>>
> >> Will include my use case.
> >>
> >> Implemented the attachment micro-benchmark. Here's the result on an
> >> x86_64 16c16g VM:
> >>
> >> ./bench tracing-multi-attach-progs
> >> Setting up benchmark 'tracing-multi-attach-progs'...
> >> tracing-multi-attach-progs: prepared 1000 identical BPF program target=
s
> >> tracing-multi-attach-progs: fentry created and attached 1000
> >> programs/links in 679.324ms
> >> tracing-multi-attach-progs: fentry.multi created one program and
> >> attached one 1000-target link in 470.042ms
> >> tracing-multi-attach-progs: fentry.multi creation/attachment speedup i=
s
> >> 1.45x
> >>
> >> The speedup 1.45x looks good. But attaching to 1000 progs via fentry
> >
> > I'd say "meh". If 500ms is ok, 700ms is not that much more noticeable.
> >
> Besides the attachment speedup, this series provides a way to attach to
> multiple bpf progs via one link. The current revision reuses the

that's mostly a convenience which is pretty trivial to abstract away
in user space, not really a hard requirement for kernel to support
this

> ftrace-based attachment, which relies on
> CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS. In the next revision, it will get
> rid of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS with its own attachment
> implementation. Hence, this series will be able to run on those arches
> that have trampoline support.
>

sure, post a new version, but it's a bit less motivating to add extra
complexity to the kernel if the only outcome is slight speed up and
user space convenience of having single FD

let's look at new revision and see how this goes

> Thanks,
> Leon
>
