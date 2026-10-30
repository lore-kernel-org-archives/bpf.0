Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793385189;
	b=ZsVqA/nFLW/p/jNDdvayP0QkvICcZiXYz2Pk8AjpuGiz62skH2Hq/O5Oil3l3FDgelZl
	 90Q8wg3SiNHbWuTxQWy4/W/q4f47PwQZawgNrzNOycuaQdVkRUTAwd8WsyPO9Mhrd5N0Q
	 Wz/MBhDVcPDjPs9pvN109hYHg+8OZdMyRG1Yss9Z2gvM6DaBimKa6S2YmEUDRiW/QQuHc
	 oC2U2XuIZ6e4jUzSsb6+LRKeRmpcJAGNXWEmtzONc3b16Tuf4w86ZnSLqwJb8HnZJKgoc
	 SPgem9Bp++WipXBmIQdOQLCmYW+cWdQK3H8pXQI/6wKpLfrYLCd63Lkqe9zZDjvnqcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rLRPIDFBIAKjp7ZYiuuNSbJ4bMyAndQA2wW+oB/2Zmk=;
	b=n/YIVSCYXp6FAsrtW6STJF5sgBlU5L/P6jl6LJCSuptXiiJf1Zydco8nHkn/zI5u/GMF
	 9ocqoNLXMmYK4S2pq/VVFvCyp4xmF89TIietu/d0E/HBqBa4+fQVJZ8JzJAzzNxmP+m5p
	 tqaGGLyTBjzer3k7LRtjEdgUJf76ahw3liI4jDdXfH1/EFvOzZoymIXIpwXBGCUgqnOvI
	 Vg6pfzHx5fn2VbVF+VnCpQZ847HW/sh4H9d0sJmq4UfzQCclPsmNUdtM0a1lKauujJxYS
	 P0J+VgW8cUzfGVmqCh1+6U6/MQK8BIA3InXplaCjtSIVIl8atlZhYsbsapFd6piu5nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8EnBTJW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD1606A333
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48CD1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8EnBTJW
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso497385a91.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793385189; cv=none;
        d=google.com; s=arc-20260327;
        b=aGbsjwlj1kJG7rZUl7vjoMFLwhPjd6fwnWm0Lo3v8vv+ngoWB3X4WIzbKqhS5TsqqI
         SviZPULOVqCAD/mYfEsK5hC0IkIqPxHCkjIMN1l/rzuqAqT0ieR72R1POTdqdsMlM9r5
         X3rrAlwIn9ResEkvG1oFUoUIT1ZuoUbPpEgF0GdGg/ZEOFPWmx7BtPdT4EMx/pYpMXof
         4hX9AUPnSEigrcCgW8/W24Jj27z6Veq3NxcRdJTjU3MxEpfVnRs4Ebz84L4l1xnV2qDi
         uGXpH08o0DTV0BaGB1EHk3DBfghBjD2YGSgHwF4kjctTw5y85ncyw/fkSSu9oCGdkXRk
         ftFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rLRPIDFBIAKjp7ZYiuuNSbJ4bMyAndQA2wW+oB/2Zmk=;
        fh=hxRZ/yxzH0mnIMeGpQd7Zzze8yONgMQRyPM05yvEJ80=;
        b=oT+rElAALLl1Mrnfzc9FLXXtDf1qWgf7FeRg431t08y26qn/Og0oi5OsGe1rWE/TWp
         AXqbToK1lkZBh0J0j0LxLjsEHuqZBsayvfGevnPzA2P6bL73cR/QYjRlBdQz4mKhKH9L
         dwLr3FjBQugtrQW9gpMlkx8ZjKOald8iaIEyijT9Uz74ajDbtCsVKUQEtJlHN+cHLHnc
         nI+WDFjBuI3CileKcZQZxUIw1k+Gb/04Kk1IK29h0ROw6o0uO/zG2QfHebujTRPxCBNC
         k7cKcDH17uiCP/usuE1FF6YlrspLSkNKwROAY7KrL7sdcGviyyGqPDnH4rMzDKJ+Zjm+
         mtEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385189; x=1793989989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rLRPIDFBIAKjp7ZYiuuNSbJ4bMyAndQA2wW+oB/2Zmk=;
        b=g8EnBTJWOnssAjipvNS5BcPWTgLDbfORfYWmtmpoNXCuskM1YBoc6hiN9o0YwDRon7
         lBZF6vUfHF1B4XUmiBd2DfRIQmpf7Y/1QlyRNpxaP3vW2JKWWD2cssSpc251riEiAS4D
         09fUXft9nGJlqG2zCOPqH5eAMzNBghDMSpF+tU2C/xJicsH0HYgWrwgkliv/R9x00mDz
         lbMxAM3a6803+oFSdfk4E58MCgBwq1PtE7RvCy46yKXBahxLv2ThwAXi3bPFhuZxV6dI
         6KaqN1cKU6u8mVnqxypg2hmGe30refJ1f0WnAexhpztXHJPJ5ozFL5DEGSmZqCeNMHll
         MGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385189; x=1793989989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLRPIDFBIAKjp7ZYiuuNSbJ4bMyAndQA2wW+oB/2Zmk=;
        b=0pwMtPeso6JkH9UAqO1FebjcoFd5EX/Yr7llCxw1aNSaBTHqftu9Ix9kO65y0wlsJN
         qtec0VYgKDSCmf0RR+vOiAXbYsK791IjvsiR25DVqWvoS/qYewEwEisPq7xX3q5MpDY4
         MHeI/dX+yK/UV310LD+o5+VlfUyoiqlNdLjdyk2pnQWJKWmVnkjVAiQ+dn6iaP2W9kCj
         3CeAXOmZYAvpm96NkRaQUR8kkf8eDI+FeeCEx41G51RuZ6e2h6meXignwtzJGFEbmSfz
         V8BaF2WYz7oIWBk6y0YT1KYYlYC00T8LYwwfsKSWyPBXzzR7bWEQvImR/uHEPXV69xKF
         VojA==
X-Gm-Message-State: AFq9FYI6gSwNnaZRGtc1M0fYUw7Q6FSTtsEtUV/oxOe+7iH70pNB0pSE
	rxH6LeJ+aujUbaIgwBX/UdwXS6/93UpyI1CVUK6KlwfeKsNw5k+EeE5is8k8IIOg+fIMuOpJ8yO
	/oDBWckTZKJcAgtwqBUGFEujiCcMGRMLsHlMC
X-Gm-Gg: AYBFou3HpPnrsclpe/Xpl+gg2xdTmgeGIWza1bsYcqewylkpRWHZ4EL3UdA/49Q9BVy
	DrefOPjKBlpVipVKcONeCl6zlVH5RuaKGt8VLhd0RkylOeLsiBd1RHki59E1DV0gWAR9Tz/+HsL
	/XsrkwUULADZTgE2vBHSiBHxXW5RsFqqTW37xZbCtvKjmwJnpQT8QWeMLWPgX5H6IrVbvv8zhHM
	vTcYPFHVK/9uTeEGrThjPEGLKc4kfg01HARRBYIWvfj0hTEq77a+M7HbJbAi7TsUnz4JGO8qna7
	29GuqQTppDR1sV49RnBlmUw5xa1FwtHPPJMtovteKVtWzmFyEtu5gvQBXfnFhUut4WE0FT7wl41
	DI7d9VVciXsdQIWG0Wlz23PnhIYurIdxquFWj24r1CZYbI2tAcbcM34G1bH5RRChIgU6/U2Iyr/
	wUU54b7aKqv6GZpqdFYrKRCg2c1rxR/1CiIydeHvyU
X-Received: by 2002:a17:90b:2891:b0:3ac:7c52:fb04 with SMTP id
 98e67ed59e1d1-3ae897ab44emr2498858a91.44.1793385188426; Fri, 30 Oct 2026
 11:33:08 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com> <20261029223348.3730738-5-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20261029223348.3730738-5-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:32:54 -0700
X-Gm-Features: AclHuK_OsQiucho_SdGjodgZtlMyIUsGHNGqPj-hETbc74mvteYdLXVwAlopj0A
Message-ID: <CAEf4BzZrEOFm5014E20bs0W_9ic7shx8LVkV3jP-zS7bFhJ1fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 4/7] libbpf: BPF programs manual loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:34=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> BPF programs designated as manually loaded can be loaded and
> attached independently after the initial bpf_object loading and
> attaching.
>
> These programs can also be reloaded and reattached multiple times,
> enabling more flexible management of a resident BPF program set.
>
> A key motivation for this feature is to reduce load times for
> utilities that include hundreds of BPF programs. When the selection
> of a resident BPF program set cannot be determined at the time of
> bpf_object loading and attaching, all BPF programs would otherwise
> need to be marked as autoload, leading to unnecessary overhead.
> This patch addresses that inefficiency.
>
> A manual-strategy program is loaded via bpf_program__load()
> and unloaded via bpf_program__unload(). It only requires that
> bpf object is already in PREPARE state (BTF loaded, maps created,
> relocations applied) rather than requiring a full bpf_object__load().
> Manual programs are skipped by the object's own autoload pass.
>
> A few key changes described below:
>
> gen_loader is rejected if any manual program is present since
> this loader is finalized during bpf_object__load()
> and so it will miss any manual programs loaded later.
>
> Two program log related APIs were relaxed to work post OBJ_LOADED
> state to fix regression where verifier logs were lost in case of
> bpf_object__prepare failure. It makes sense to relax those for MANUAL
> programs as they can load post OBJ_LOADED state so the log buff still
> can be set at this point. Also add proper documentation to the setters.
>
> Failures with BPF_PROG_TYPE_STRUCT_OPS were encountered and so in several
> places code related to struct_ops logic was altered to take into account
> struct_ops program with MANUAL strategy set. The general idea is to rejec=
t
> this type of programs for manual loading since those programs cannot
> load/unload independently of each other per a given struct ops.
> Hence, SEC("!...") style declaration is rejected for them while
> bpf_program__set_load_strategy() does accept them to allow certain
> flexibility in the API future usage.
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Co-developed-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 194 ++++++++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.h   |  51 ++++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 225 insertions(+), 21 deletions(-)
>

[...]

>  static int bpf_object_prepare(struct bpf_object *obj, const char *target=
_btf_path)
> @@ -10038,7 +10137,8 @@ static int bpf_object_prepare(struct bpf_object *=
obj, const char *target_btf_pat
>                 return -EINVAL;
>         }
>
> -       err =3D bpf_object_prepare_token(obj);
> +       err =3D bpf_object_check_gen_loader(obj);
> +       err =3D err ? : bpf_object_prepare_token(obj);
>         err =3D err ? : bpf_object__probe_loading(obj);
>         err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
>         err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> @@ -10121,7 +10221,7 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
>                         err =3D bpf_gen__finish(obj->gen_loader, obj->nr_=
programs, obj->nr_maps);
>         }
>
> -       bpf_object_post_load_cleanup(obj);
> +       bpf_object_post_load_cleanup(obj, false);


for consistency please add /* !force */ next to false in a follow up

>         obj->state =3D OBJ_LOADED; /* doesn't matter if successfully or n=
ot */
>
>         if (err) {

[...]

> @@ -16286,10 +16393,26 @@ void bpf_object__destroy_skeleton(struct bpf_ob=
ject_skeleton *s)
>
>  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_pr=
og_load_strategy strategy)
>  {
> -       if (prog->obj->state >=3D OBJ_PREPARED)
> +       struct bpf_object *obj =3D prog->obj;
> +
> +       if (obj->state >=3D OBJ_PREPARED)
> +               return libbpf_err(-EINVAL);
> +
> +       switch (strategy) {
> +       case BPF_PROG_LOAD_STRATEGY_DISABLED:
> +       case BPF_PROG_LOAD_STRATEGY_AUTO:
> +               prog->load_strategy =3D strategy;
> +               break;
> +       case BPF_PROG_LOAD_STRATEGY_MANUAL:
> +               if (prog_is_subprog(obj, prog))

this subprog check should be independent of strategy, we shouldn't be
manipulating subprog load state (it's meaningless). Again, please just
send a small follow up

> +                       return libbpf_err(-EINVAL);
> +
> +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> +               break;
> +       default:
>                 return libbpf_err(-EINVAL);
> +       }
>
> -       prog->load_strategy =3D strategy;
>         return 0;
>  }
>
> @@ -16297,3 +16420,32 @@ enum bpf_prog_load_strategy bpf_program__load_st=
rategy(const struct bpf_program
>  {
>         return prog->load_strategy;
>  }
> +
> +int
> +bpf_program__load(struct bpf_program *prog)

hm... why that int is separate from the function, plenty of space
(nit, but adjust in follow up, please)

[...]
