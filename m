Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8E3ABD88
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455739; cv=pass; b=UZAme7xJMHoTA6kYILQs15yb+MLb9Vp0vq5gh0pR5tKb7UtBBV2CAc96Y5aq9lDNNQRpjmQkc8MHXfmRNBwS7a7Qd6L3uZ34bQvSH2zohNcU5ffZOUIEr6j4SPco1XLn0E/3gMtUErmmoEfv9NKWisrwjiMI65AoDzLmMRA7EWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455739; c=relaxed/simple;
	bh=hV5KLaAmEHz7Ic3f8xOxjqxj04qxIB9m3dv29dZ9WV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msnuSCXHQB1kSMSt8l3ldJtZvuzCc0WqsvODyTQI9PLbiUvBDCIukuZ57JoXmzLH80SaS4ZnaZedaZKbZxKYhleKXu2EPMP3KNYuk+PjXQteiwEJEaAhGmQhPhbM1TutUUVaSveK/OuroB87hc3Lv9TPmBL+XML21e/uOknSULs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlGabdku; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlGabdku"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84861fc51f5so337802b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785455737; cv=none;
        d=google.com; s=arc-20260327;
        b=Iyca5/U4SmuftLT6+lYcLTFUoS823RQbMovGyCIao6cTj0girP9ASdNQddLM+4FoNq
         YEbbevUmRT+KrLnS2Ctms8f99671UAkFRXrLG4Vwi1dDyq2KhWliacoDqOFFDimbVVFV
         TWoPGFkiD4UZnJQBUNbMRFO4tSkt6g9Y5BJ8uyNh7LzpQ2PdA/c4eoruqmWMNW/muirX
         2/BgDDVy5A4ri2GSGw7sEoB4ZIoE4pcTfgQarNxeFpACG7sYHZe+Q6sn9jPmtbm2vpqV
         Kmv+uA0mQUQT7ME3pClTtfMULQb69xCkoRGB9x+k62gsGCI4SKkWRO1jun378OMAVAyP
         tmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CCRaa9xG8Lu3CwSdJQLZiNXOhmRsZ3XnJvX/nF5Nkg0=;
        fh=wuZdHJzBerA61ub8T2GrIbsGHZ9BgIt3I3k/cIziLbs=;
        b=LM9yuFZNCWMHuMftPFQj90hCePohYpY9p6U5Rr4eBuepGujYuBvFm7rZWLknt8s7Ga
         k3n14c3vb7MGaWQMhsu+50g+2yHGtT/Ki/ZHCpUBiyqbLgmMQLGapuu3RLtr4PFC0PKP
         GW8pDPfEHhUoWbtRkQyBfMKwSGaV1eEq1ciA3T2CyeAaxj32gLdrtiiW4pjhbOsggazd
         1izdRGmZRJfCdVyLI+fUuueflIWRYX/Wk7/erhKMkmULGVUDf/7/gZglVsDne3uCalrv
         xtjXm0fA1GXSdWNdPJMdViyjRNOXNRTNtnlIaOJRZ5IndOgYeIbd4yE2NCROyEI0jRhT
         5k2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455737; x=1786060537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CCRaa9xG8Lu3CwSdJQLZiNXOhmRsZ3XnJvX/nF5Nkg0=;
        b=QlGabdku0Tis2lK4OWjEHuAAYzLt5MjAmJv+VTLvMrizha141ZO7yF1h9JI0lff6tj
         +RuzrwXFAJVnhw/EydgI1F90qWzEC2WCGMhg9YaSFls4tMYM82jiTDDVP6ykMnnVDUJf
         4cxo2I8OA1E0t8JYZw43QMgeUa03svKz1ykf1gCO41Phw6szNf9JzUrC88VNMn3ExdBe
         ILqNKZfNEomBfgkRqqywfenbajbOi5O3MGQkvOJn+P3jUq1t08xH+z4Offq3nvZMoyge
         bSlvmxLmBFAd3mkPgoXBmoh+ohPXrSqSMfSXOOPOFqrwH5ltT3dSy34lXvxHU1GsztQL
         W1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455737; x=1786060537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCRaa9xG8Lu3CwSdJQLZiNXOhmRsZ3XnJvX/nF5Nkg0=;
        b=E5brS2OyOJVyWSMkE/qpZwx+SV0dsIaKm3OhFrekHKQFaPb5s2972PlVn7zoo8a5mW
         YZA9TauVDjO4iHmVlbgg4Qn/3+gslVY/CW5kEom5V4ARK4nQ7G6MTOw/Emf3J5Nn+iQK
         8zi08RZ8DPk73C+Apz/h22jzAipk+LbHxnxxt7t/Oqi6IB7ZA2z6WEG4oG+9WjqX2V7y
         Td2LvBVoi1uFVCdA0eVVZf6Z8pmcUolHFSS2xf+NwjAAOm7qjfFExj8nosChlbiAfcrE
         jzHbYNEZ5o88Tx4WCY2mz35iwlCCl/byyxfpWsjhlwqUeDY+SmmqTMJvl2eQqLZtcMwn
         w9MQ==
X-Gm-Message-State: AOJu0Yw0yAcTlqu0ruoALMS/Gr6Gq3nUFRViXU7qMkzynnUwoP9iO7yn
	JAmP93lJM9BMH4VjSCYFWK2VGuE91pXuSvEwtGjCvV94fnPC+MRbnmZPkZwiK9s11gRSxr8EGox
	PrSdMiVTG8p/QVe/CohQsFFk8jkglGIM=
X-Gm-Gg: AR+sD11SOFNw3dl688Gx2LF9xoAxhGZHCpHltWXUOlOICDDPZkAbM3i8WCNeSbo1D8K
	4HjdaombAiZ9cmgb656GAzS9zZ1p/EySnsDhqwpquQwk85v+m/Qmt2e3uMtNjzjHooAct2kDrfa
	cz4M4PR1pXVfdjy4rWmknEsS8+8S9E6L5f6egpSG3SwHM5/G2lEfOSmfz0lLTogcxJVNmnQXBE3
	jMvA0SqY0jl48YM1/cX+FRvt/xgs50pBDWmmPMUQfboE8aSEkr1CCILFLwoTHyJCLAfcqOPIGf5
	RUrHFYRcofBymJKe70YpZc1/2MqjkEjGR3usmjFFjA6R/vIi0/Oekmjg2hv8ddJJYl0R1dlKo91
	8SPgcAIUr6dViseC6Uv5FFe+w1LWYa8/MR/+ZNsIviA==
X-Received: by 2002:a05:6a00:cce:b0:847:8e98:9a4b with SMTP id
 d2e1a72fcca58-84ebc2422a4mr4253539b3a.34.1785455737231; Thu, 30 Jul 2026
 16:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
In-Reply-To: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:55:22 -0700
X-Gm-Features: AUfX_mz01KsvC0dTQTZpCMew9O6d6Q6PCq2A8CWuLf7bfi4pR2EqEu-Q6tBwvaU
Message-ID: <CAEf4BzZXu=E-E+_DXukwuzdGAH6LwxhFuWkX5j6Os1YAn3Vtcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tracing: Make per-template BTF id lists file-local
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, rostedt@goodmis.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, linux-trace-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, broonie@kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:52=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> DECLARE_EVENT_CLASS emitted __bpf_trace_btf_ids_<call> through
> BTF_ID_LIST_GLOBAL, i.e. a global symbol named after the event class.
> The class name is not unique across the kernel, so the symbol
> multiply-defines whenever two translation units instantiate the same
> class.
>
> Switch to the file-local BTF_ID_LIST: the list is reached
> only through the event_class_<call>.btf_ids pointer, initialised in the
> same unit, so tracefs readers never reference the symbol by name and
> resolve_btfids still fills the now-local .BTF_ids entries.
>
> The handcrafted syscall classes are the one cross-unit consumer: give
> them their own local BTF_ID_LIST rather than importing the generated
> sys_{enter,exit} lists, which are now file-local.
>
> Fixes: eadc0725ab8d3 ("tracing: Expose tracepoint BTF ids via tracefs")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@=
sirena.org.uk/
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/trace/trace_events.h  |  6 ++++--
>  kernel/trace/trace_syscalls.c | 22 ++++++++++++++--------
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 09ad57ac4b73..45ffbe04b580 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -404,10 +404,12 @@ static inline notrace int trace_event_get_offsets_#=
#call(         \
>   *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
>   *   [1] STRUCT trace_event_raw_<call> (the ring-buffer record)
>   * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
> + *
> + * File-local: the class name is not unique, so a global symbol would
> + * clash across translation units.

drop this comment? not super useful and file-local is default behavior
for BTF_ID_LIST anyways

>   */
>  #define _TRACE_BTF_IDS_DECLARE(call)                                   \
> -       extern u32 __bpf_trace_btf_ids_##call[];                        \
> -       BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)               \
> +       BTF_ID_LIST(__bpf_trace_btf_ids_##call)                         \
>         BTF_ID(func,   __bpf_trace_##call)                              \
>         BTF_ID(struct, trace_event_raw_##call)
>

This should go into Steven's tree, not bpf-next, right?

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
> index 48ef1a93e576..9b5931f2f280 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -9,6 +9,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/perf_event.h>
>  #include <linux/xarray.h>
> +#include <linux/btf_ids.h>
>  #include <asm/syscall.h>
>
>  #include "trace_output.h"
> @@ -1305,13 +1306,18 @@ struct trace_event_functions exit_syscall_print_f=
uncs =3D {
>
>  #ifdef CONFIG_BPF_EVENTS
>  /*
> - * BTF id lists generated by DECLARE_EVENT_CLASS for the sys_enter and
> - * sys_exit tracepoints. The auto-generated event_class_sys_{enter,exit}
> - * is unused (per-syscall events share the handcrafted classes below),
> - * but the id lists themselves are global and reusable.
> + * BTF id lists for the shared sys_enter/sys_exit dispatcher tracepoints=
,
> + * resolved by resolve_btfids. Defined locally rather than importing the
> + * DECLARE_EVENT_CLASS-generated lists, which are now file-local to the
> + * translation unit that instantiates the tracepoint.

drop "resolved by resolve_btfids", and drop the part about defined
locally because file-local, too much Claude style

>   */
> -extern u32 __bpf_trace_btf_ids_sys_enter[];
> -extern u32 __bpf_trace_btf_ids_sys_exit[];
> +BTF_ID_LIST(syscall_enter_btf_ids)
> +BTF_ID(func,   __bpf_trace_sys_enter)
> +BTF_ID(struct, trace_event_raw_sys_enter)
> +
> +BTF_ID_LIST(syscall_exit_btf_ids)
> +BTF_ID(func,   __bpf_trace_sys_exit)
> +BTF_ID(struct, trace_event_raw_sys_exit)
>  #endif
>
>  struct trace_event_class __refdata event_class_syscall_enter =3D {
> @@ -1321,7 +1327,7 @@ struct trace_event_class __refdata event_class_sysc=
all_enter =3D {
>         .get_fields     =3D syscall_get_enter_fields,
>         .raw_init       =3D init_syscall_trace,
>  #ifdef CONFIG_BPF_EVENTS
> -       .btf_ids        =3D __bpf_trace_btf_ids_sys_enter,
> +       .btf_ids        =3D syscall_enter_btf_ids,
>  #endif
>  };
>
> @@ -1336,7 +1342,7 @@ struct trace_event_class __refdata event_class_sysc=
all_exit =3D {
>         .fields         =3D LIST_HEAD_INIT(event_class_syscall_exit.field=
s),
>         .raw_init       =3D init_syscall_trace,
>  #ifdef CONFIG_BPF_EVENTS
> -       .btf_ids        =3D __bpf_trace_btf_ids_sys_exit,
> +       .btf_ids        =3D syscall_exit_btf_ids,
>  #endif
>  };
>
>
> ---
> base-commit: eadc0725ab8d38c05148fce49f8d5c6a0e01f062
> change-id: 20260730-b4-fix_btf_tracefs-fdafda5fdb5b
>
> Best regards,
> --
> Mykyta Yatsenko <yatsenko@meta.com>
>
