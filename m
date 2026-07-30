Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF336897F
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452506; cv=pass; b=qIGESEjconOqffWrirtqTAMQTVf0dGVPQYiGsgzrvySFWHuDbHulchjUt8QerKhoOcOJ2bt4IVzBYSQnwnbguIDeWwy+iiDnARJFtvof804eohBITVXA8s2vZwxoZn6GHn3P4jcMUmMr/o68Aw/GH8SsMn/SpdJtusvCZP/jh8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452506; c=relaxed/simple;
	bh=e0EcIf399xNKKchZ3dfrBmyOcFx9SYjxIQFiZ4f3oKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLC9f20DvfcAEYn/kshT8CDuYwLnMzaYdj3x5FjejQc4WumkZb4qPD7h5IdYrL2LVUoVo/Qr/y/b1ZU+CgZEzZz1WlMMLf111U2clw5RTPMCKQRTlhUhPqRycAjittmhoK/5IL/JjvMdkPmuxWFvVA7QnpOBfS8/+4wT1SWSxPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPmJLdzO; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPmJLdzO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487088510aso476751b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785452504; cv=none;
        d=google.com; s=arc-20260327;
        b=BoNaNpzNFFmD6V2sFpxhp+tuxmvr5F9ZQNytf1VhLS8PwnIcPagE/DlpfjED5/P34H
         I/l5i4bWowTVX5Q7bo/3kxnmmVPHmzbF3eYRcZS+V8z4BQAOyqFrh0beaqApLXzlZoaj
         S74Sf7G3xoiZrKOcTkiHmvD+YTgcKbWTTwE2vNu7nERDmZiBWOIv8iBzVgHER+8vJe7u
         CsfcHQlWAILNYRukKmqcxhwxWEWtRgBu7DtF80NLuSDN0IJ5h5MptVKa5kd6Ajm5YKUo
         C56ElzEJvVB1VBvIG4Y1EAMUD9iEm6JLi25gRV0BCSJGpAs3hTV0TpFOCTmwHLvjo6F5
         wr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFtG538FVlXpB9nXr+oNs3sXJNnCPQ5ybWYzjPcKAKw=;
        fh=hDhpngdGB6+8lT3IQjg/bJSGHdpzdmrY6OYZRfdlI94=;
        b=NPNPrm8daDdco3CYK11itijvyUvPTM+I5ul+Ax2eqt0b8E+EvMUGju3jORuls5xEjp
         oot6nWkbi2+4lZMcKLmh5ibo+THu0jW86VJeKVowZ12FnVSqroRacOV1pJaKepzGU24l
         FIICOAJrd1R4nV34NcUkBfg0Jx0FKfCTAtjhCnmaMpzhmrH/AKMipIFT7142ZdMBrd2g
         edMDl94DpCN0l14YnX7lG6+3hmb/MIl4pZBXBB1CvDYkNFP3/7jyQ+5+hRq1cLZDV6eA
         WQmRnf3CVMMaTOfkiU1zYD+W8Vi12vnfpyqsUHsMA/6z0a1cO/gW3+/24BPAbeiVQhni
         AQKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785452504; x=1786057304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pFtG538FVlXpB9nXr+oNs3sXJNnCPQ5ybWYzjPcKAKw=;
        b=QPmJLdzObXblMiFZZra8dC0BgY/CxfkChwKuIkuTyrzRpMb+Smffoz77XafVXsTa3P
         1AMqlIIBq6xgNdyUZBwHvFWGH42bGq7AjJz5Il5sgAAQszaZTH/uTACQ0Qm03GEJ/CoZ
         eHwUdKIiEIbj3fF1z14citI/KUOLXv+TVWvXw+QgWh8Y0O0MLS4r49S0gVW28bL76l3+
         dVQ2G+Tq5IKBxLri2UbSHNp86ox5vav1BvvQ8cS3VC7qqIyAFYBgZj7C/cEqWQpUYVr0
         ZUo261VWEvXtWTo4idpG0vO5F7kCmXi98KAPvrAkYKVNBkcDGFUqN2D7Sf4Lq2GiVIxa
         FHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452504; x=1786057304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFtG538FVlXpB9nXr+oNs3sXJNnCPQ5ybWYzjPcKAKw=;
        b=WUyRGCt05RMIOPjJm7u/9BgKS8n2ZiNwHOmNmrMufv7SIfGlZ0I5gezdG2M90vj8C1
         8orNKZhBRvPL2+rTqedciqqJZRy+0jYe/uC5hBKwkMb69ohd1fmbGpGsAm4mC1NkfARj
         MuOfqTyuRhYpM3VYwKA/CAM5Yb/SOX6Vh4FDDuS1uFJBJd+uOBMImsDj4uIMBfM0xooJ
         xMzb1mV0tEGAzpOcZSKcXbI93imzW5yYiZo6CYC2r3f3zqIewo5/18A1SjocF+Yov7WK
         MkQZm/0eA/nU0pEW7AWkBZcFHZUJPG4snHAJiLUWiqGqez+BVTK8EnTvnE+PWOC+3NIE
         1a1Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro/j6WzCuXWOgYyfGnC1ptJRApWmvi1Iofa/IUdh+H2/fmMiliOP6Ymy43+t1dlNKdX0+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8R487GzR9hvSYc0os822tSCqxnfEEyccylz0oZHcGgjjAe7A
	o2yEhBXwl9O9UQOOS9Dl5i7S6anoXPiJDG2ECPE0jrnWkFt7EsThipVV34WPK037viz+RAXvjCg
	HlaUygfUFsFLPWLAmuxD7njzZJtwFfRI=
X-Gm-Gg: AR+sD13n9XFe3paWry6e18H4VwBm+APxh4Gjzhi+e4xMAYCGte5zQw0I++mL1+Ee5cc
	UzsqQCpGIA5G+wrWSLS/cdPhQnEzoEP6PRHBdrd5nVUlF41CfFledlHOxSakuGbwZ/q5bzEufYu
	u3TM6xiCiSLdcvc36eaQ7IXxWySrZRd6mqBHg17PJ+DIgXsLW4WUhukcYYMqQcQt3gD447OScFN
	5vFwb97P83bwQafJNDjWqZAtGrEXY9uO+Cks7n4d1Kbvj00Z9poWIGwW/EJ6HH3ckkObcJ6Fgvt
	M+B3ykqI02TXfWSsHUBDv39m+vqlPMUMNCma7YpIy+CikvvpmhPDyZHoXzSUVIlT6hh8bsLfVlh
	7AymbdHbJd5R8jgH4K45qOnv+8eXKjAXChJdhJ5hWnw==
X-Received: by 2002:a05:6a00:cca:b0:848:2f73:8ffc with SMTP id
 d2e1a72fcca58-84ecb994a61mr1553018b3a.69.1785452504115; Thu, 30 Jul 2026
 16:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-9-jolsa@kernel.org>
In-Reply-To: <20260729083807.1588544-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:01:28 -0700
X-Gm-Features: AUfX_mxlIqp8k9-YiMjbbhF584kWEf_ZieJfMoz242UWMEE7juCILCPfLTm8CnM
Message-ID: <CAEf4BzZWgmL39Q8kQNu8B=-B1Vw2OipHvCaLbxCgU9XE6aNfVg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 08/11] bpf: Restore trace->nr value properly in bpf_get_stack_pe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> In bpf_get_stack_pe The __bpf_get_stack call changes trace->nr value,
> so both kernel and user path need to restore its value back.
>

something feels off here, this trace_in->nr restoration just in
bpf_get_stack_pe is weird. maybe we should either make sure
__bpf_get_stack doesn't modify trace_in->nr or restores it before
returning to bpf_get_stack_pe()?..

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation int=
o helper function")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/stackmap.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 05269f2a9e08..875f530f3597 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -942,9 +942,9 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
>         struct pt_regs *regs =3D (struct pt_regs *)(ctx->regs);
>         struct perf_event *event =3D ctx->event;
>         struct perf_callchain_entry *trace;
> +       __u64 nr, nr_kernel;
>         bool kernel, user;
>         int err =3D -EINVAL;
> -       __u64 nr_kernel;
>
>         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
>                 return __bpf_get_stack(regs, NULL, NULL, buf, size, flags=
, false /* !may_fault */);
> @@ -962,15 +962,12 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_=
data_kern *, ctx,
>                 goto clear;
>
>         nr_kernel =3D count_kernel_ip(trace);
> +       nr =3D trace->nr;
>
>         if (kernel) {
> -               __u64 nr =3D trace->nr;
> -
>                 trace->nr =3D nr_kernel;
>                 err =3D __bpf_get_stack(regs, NULL, trace, buf, size, fla=
gs, false /* !may_fault */);
>
> -               /* restore nr */
> -               trace->nr =3D nr;
>         } else { /* user */
>                 u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
>
> @@ -981,12 +978,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_=
data_kern *, ctx,
>                 flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
>                 err =3D __bpf_get_stack(regs, NULL, trace, buf, size, fla=
gs, false /* !may_fault */);
>         }
> -       return err;
>
> +       /* restore nr */
> +       trace->nr =3D nr;
>  clear:
> -       memset(buf, 0, size);
> +       if (err < 0)
> +               memset(buf, 0, size);
>         return err;
> -
>  }
>
>  const struct bpf_func_proto bpf_get_stack_proto_pe =3D {
> --
> 2.54.0
>
