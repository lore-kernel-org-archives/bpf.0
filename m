Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64F1DFD1
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744047; cv=none; b=WTA/WVvUpbTF8J7KBX5d+2vGuTtOHisTo+J37fs76dGrEWFjd/lJKlC11/WrKmS6Zb4sjjHoTOV+axq0249CZ4FaKs+vfi3WjnKEL5m7EMstiUnN5XaqjaydXyB0fXslVx/gt0yaPgBLyzsNSf/USVFQsnv0qVKXDFZihG+vBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744047; c=relaxed/simple;
	bh=bAgTInjbJv3XwD7/O1jbeULAQI+aUyjRMAofpspPLo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5EYgE6DyLYmU+v/FTpRdjkdkQrVBhOIBreCrQjAXaXD3nEGsIfcCGG+HVu6hyru152kyTCnijMLTdm8YAXJ8DJpCqOLHcnmuax/SHMGb+ImGZDhYNf4usAwnnOTNIvw+hA1eJ377OGxPK15jpvuCMzvVTyTR2N7KcVtFbGV/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvQOKLQB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvQOKLQB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0d82c529fso20871725ad.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711744045; x=1712348845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkGjmID5X3szaNox8llG1m/dFN6ZL3vp2qboF9OSt44=;
        b=NvQOKLQBqp/A23E/Zr5yntzIv9UW6N+modQ8/Vi7qeWO9WgMKKaFWC9Kyfi/80PEPe
         7EyyfSY8VBfQK8rpoqJo+Po5r3fd6UAtmkbU7MYxMts5Dl/AKeS8Vldh/YTxYz8khWcy
         IoPqhqLwhqG/MDGHhj387TZEIKh94d0xl5TX9NB16ebtdWTuwIbUQJt7/YNN71ccF3D2
         3jMaiMYqN+SX1qWyCd9HLuC6SXXgsxstvBj74SFJHKEwdhZYLA6a6KsoMCllshioGyUL
         ejK54lyVG8T/uktLqmRnj6RHlrJQgJYa018I7S1c870gBbxQpxxGkxQ5Rqq8UPaQoyXc
         ZODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711744045; x=1712348845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkGjmID5X3szaNox8llG1m/dFN6ZL3vp2qboF9OSt44=;
        b=aIsZUDIm5gCtEPkjt2Rou30jMFNqF89rY7raNt8FbhXkFno6TpLD8XsbNtMqdYAGkk
         6Y/yzQySJpn8teV4Q1q6GrWjF7t7EbKwjMY08PcVDite1ifnSY3xYQQV9RVvGCM23lm+
         m1q1iGXVIU5ViFT/jbfRz1zaSJgmU72SdBxTFUtYobYdoMM9Wh/IAZzcGm9dj0MMqsJT
         +V2+mtKU+V+xmgYLaCMSnpyteKj6r/QYVxzdbsYsRwZZZlqggLdrCckmz2UynG2l+krt
         +NBX3/NGPF0/cBIhIjBvxwhz/63ZOSbaqnzO6+CV2CDBA/58C0hsLpeq5/ndENe5tChn
         x77A==
X-Gm-Message-State: AOJu0YyNKpK8LykbyVLh+zlhSbkBjTJpfl5UW91S6BYUSZY21g6yudvW
	OD7r+l/STh5FtDrfwldmVG1bGg+Pzqte7uyHRS2tTb9u1OqR3JzleHWAap+7Ab1iMnpU94gMY6+
	UdYpr1M9pZ5OTU9WMlcCg+mkvAB8=
X-Google-Smtp-Source: AGHT+IEB7o5Ju+A6MWy5aanVPlbK+3cCZj7I/7qXvAuYOGj59SUS1XIgNupZkhhqL9vAP/otQ2vM8GhjjjzKCz/akD0=
X-Received: by 2002:a17:902:e804:b0:1e0:e85f:3882 with SMTP id
 u4-20020a170902e80400b001e0e85f3882mr4140730plg.38.1711744045013; Fri, 29 Mar
 2024 13:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-3-andrii@kernel.org>
In-Reply-To: <20240329184740.4084786-3-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 13:27:12 -0700
Message-ID: <CAEf4BzZk-iHvSMW-9S44NdqVhQE55dhvSz952Fm_3yWhm6wBeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: inline bpf_get_smp_processor_id() helper
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> If BPF JIT supports per-CPU LDX instructions, inline
> bpf_get_smp_processor_id() to eliminate unnecessary function calls.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edb650667f44..24caec8b200d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20072,6 +20072,23 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 }
>
> +               /* Implement bpf_get_smp_processor_id() inline. */
> +               if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> +                   prog->jit_requested && bpf_jit_supports_percpu_insns(=
)) {
> +                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(lo=
ng)&pcpu_hot.cpu_number);

so CI reminds me that this part will have to be architecture-specific.

We can keep BPF_FUNC_get_smp_processor_id inlining here in
kernel/bpf/verifier.c, but have arch-specific #ifdef/#elif/#endif
logic? Or we can have an arch_bpf_inline_helper() call or something,
where different architectures can more cleanly implement arch-specific
inlining logic? What would be the preferred way?

For arm64, it seems we need to just do &cpu_number instead of
&pcpu_hot.cpu_number. For s390x there is some S390_lowcore thing
involved, which I have no idea about, so I'll be asking for someone's
help there.

> +                       insn_buf[1] =3D BPF_LDX_MEM_PERCPU(BPF_W, BPF_REG=
_0, BPF_REG_0, 0);
> +                       cnt =3D 2;
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       goto next_insn;
> +               }
> +
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> --
> 2.43.0
>
