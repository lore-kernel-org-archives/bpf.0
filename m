Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BC2D8767
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794504; cv=pass; b=YwLxcI0LRoTCWxHx9cwakJrV4uq5JENA9VN5nbSJs1+I/5lgQfvfz/G2FiFFy5vvD8ACfg4mbkpj/DC936M1ZWb3LN2vQK5gXzgnaQpdcFjVsB7w4W4BcsHZ86EeNjSqjm6+5scWOMnuitv++1A4cBYcZW1uICAGRWghQpzKxHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794504; c=relaxed/simple;
	bh=dGI1EfqlJIDpYTvAjhVpbmijiAVz6//qtKxOWFURD/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIu+GtlHS8cJon0lM/sGcuFsDp7klD7TeSXGo+w4BIih76+HSKKp2wu2NzwXyG1B5VT6dPXIOOfB6Ecj9fHVlzj1nj66tsmdlfvq96FcLZHD+/kEaG6leTzZkSfztCvy0kR57JXoybA30M2VSt8N9HQxBnZDf3FNj/EvHPnV7GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui7oLhuH; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui7oLhuH"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso10002525e9.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 09:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769794502; cv=none;
        d=google.com; s=arc-20240605;
        b=jdtJNsDg7+vM7bYfAzriVc2OD2u8Wk1frc+JuxYOtbmW5cll+B+4ILeZrZ0swOQffR
         GSqeuuH4ty7ygao9jhRE25cyT+vv1oLZd2UuGZDjUYKZGkB3asGdbkSZgteqRxlGixdh
         DUwogobuTbAJEHgNdvWWOiUbSAMkTbDeX+PY7csQK1kIrLrkqFHHC/ZOEF1btKmCgHyh
         64BWijuzkgsM9p600sJWpLCFlf6AhH9nJq3xJpoyI1W5fsX26O3hzwicsAODh6xjz0cl
         AxQ7K4CDHEHK62GdSaFUUGubcvR/ypNOQ9ACWx4Nx5yQtevcx+h/ZpC0DiLwzRbtlA5U
         OpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vpEnsGzRXrrwPW4/qayekbNgQ3pC2h1NUlHmylN9N5M=;
        fh=ezDtKYsUssWKTB3GN1s3Hd7yvydRzL+k+y3Y0q/xlyQ=;
        b=dV4wUj6IbVA4cC2GYQZjZvA/GvqlwjTNQkqfzTvQX3SoDZhn1HV741K+x/350nMyJw
         /CbN0L2/jjNvlWgc9RMcQYsq9i5ii8ZVvB7/XDFYbAu2npGcT7V/XhuBFjj6Q1b88pwC
         BH1mhP1k0YFkzhzyoJbDKz6o0a8w0EZFAxIQBGLKWA1hfeq2FAhuXgKmFwqC8v9fj+55
         O5xTqx0E65+pjEq8nV6Y5CrBzI3V+yUVu7ZNR5wrW4/RvO5uu7xXOMHuskbOTAjZK0lZ
         TseuvqAgJX5qJOeHZ+nGwCA9/jKeFeMhD6ZE5Ml3zXhwj3lEql0+Df8t5RW8Hm5gyFZp
         E3Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769794502; x=1770399302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpEnsGzRXrrwPW4/qayekbNgQ3pC2h1NUlHmylN9N5M=;
        b=Ui7oLhuH/XND1yMRYmPZESXPkLeZk8OpIgpQXM98kj/5qzxYI5JekDMggs7NC8clGG
         fRi9xS7lvX1w+FMXiyitEtxCX5phgjllyLwyns3qWbJKhG7NeIqThW8eK6I6Om6Q+4Mx
         GDXIwgkmeYUssAPNfyUU+2SxADMD5vJFi8uWw8ukhzgukINO/VJiLYpc1YU3ReOcraus
         P02vaS2blKYlbGjzv3SWzvRLwn2kVJSiNjrRlWjXmrzCv+JXgH5EOR9AOMYhXn1kN2LP
         oy9dTC5SOsEYnJltinkoGL/6nH44A9/0i7iYUZWtvWhQuk3jmZCdOp3yYACAS/PaAB4Q
         o9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769794502; x=1770399302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpEnsGzRXrrwPW4/qayekbNgQ3pC2h1NUlHmylN9N5M=;
        b=N6dk3le6m6ZX8bPAKI4PmD6kNPUhc31mASZTlr2n0egxfHtDCJWlNE87NGpEn264At
         QhAHdk2GZ/WN+FhGTen4RDBp3CXHNnpxzCrXkqPY8zKevi6K2jLXzvj+Eel8NwbiOY1U
         cFcrqp2OG7chU0+ZJy7dDEJoB2QAaT01sJ49YBsWoklhUDFnTwV0X9+mniLlaUuI6Ru6
         NJEJbKiY2xsac0OJDyE+wlLIqw6rtz4U+s//dxCK/0rmSqWjhXdUpe56yt5XM9RrVsiZ
         6Rf+bXYfpJcghqKmYPTzqBmSXWKRV6D50N+v2k4582pJ70ly2XoWPmmrKpQJ0dc7eE8V
         VO4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJdTa1ime9GgCTMRVODsXVKix/NPI2FiCVkCalj6muYMsIoWApcOm0vlN67x18WKodrbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzkQQdt2mzptH9R6H1NgmSD1xX/gVxsASdOoG6qJoOpSG4Jdw
	yrzuVpF6n3bouyTgp9e5etWsMmvk740os0pmLt0RRFNpPwbzI3iW0zKSnjgfBPoK7gBLYGt3tu+
	6pWreyMR51X0qJYecojti54SAobgfd4Q=
X-Gm-Gg: AZuq6aJ4iGR+AXJ1FYqYbKDwEdyeRjdEdKjDb943KQnC5edbk5hUQktMdmNCAF2DLz+
	BfnEW9dwZS52hO7Y/ugHg6GM0dkX/w6Y97MLjz0zJrW7xPtgtsW/SThVmgQSMkuqTHPojEruh4S
	Yy8rwEHZS07WV4M6xgtLwCHRqIcpwZ1q8bLFV8Jm86KB4pM8hXpCnmleRq147DpQq16D52lL0Tl
	uOExj1yHrfzPiIe5Meeew2qRVcRTUEz1XARP/jSmjqIWgu610H1s5T6/RTsoYCAtvjxaZawL0Hz
	hJWmiGSF2yuUI5nGHMa1kK/AiF+hg//q1iW8J7f1FmTquqZvgOntDsWfdBb8
X-Received: by 2002:a05:600c:c4a3:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-482db49d765mr49600445e9.30.1769794501578; Fri, 30 Jan 2026
 09:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130081208.1130204-1-jolsa@kernel.org> <20260130081208.1130204-2-jolsa@kernel.org>
In-Reply-To: <20260130081208.1130204-2-jolsa@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 30 Jan 2026 18:34:24 +0100
X-Gm-Features: AZwV_QiWJnIeM-UxhN1IWveDSDI2RtwVN5kLxDjmioxWau2BpjGpMx11EMIfEYk
Message-ID: <CAP01T76RmkoJA+g=-Vr0mBvx29j8UjK_xg7VDwUR-FxtJbjnuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow sleepable programs to use tail calls
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 09:12, Jiri Olsa <jolsa@kernel.org> wrote:
>
> Allowing sleepable programs to use tail calls.
>
> Making sure we can't mix sleepable and non-sleepable bpf programs
> in tail call map (BPF_MAP_TYPE_PROG_ARRAY) and allowing it to be
> used in sleepable programs.
>
> Sleepable programs can be preempted and sleep which might bring
> new source of race conditions, but both direct and indirect tail
> calls should not be affected.
>
> Direct tail calls work by patching direct jump to callee into bpf
> caller program, so no problem there. We atomically switch from nop
> to jump instruction.
>
> Indirect tail call reads the callee from the map and then jumps to
> it. The callee bpf program can't disappear (be released) from the
> caller, because it is executed under rcu lock (rcu_read_lock_trace).
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h   | 1 +
>  kernel/bpf/core.c     | 4 +++-
>  kernel/bpf/verifier.c | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5524f9429e76..3b0ceb759075 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -287,6 +287,7 @@ struct bpf_map_owner {
>         enum bpf_prog_type type;
>         bool jited;
>         bool xdp_has_frags;
> +       bool sleepable;
>         u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
>         const struct btf_type *attach_func_proto;
>         enum bpf_attach_type expected_attach_type;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e0b8a8a5aaa9..5ebece600aeb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2401,6 +2401,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>                 map->owner->type  = prog_type;
>                 map->owner->jited = fp->jited;
>                 map->owner->xdp_has_frags = aux->xdp_has_frags;
> +               map->owner->sleepable = fp->sleepable;
>                 map->owner->expected_attach_type = fp->expected_attach_type;
>                 map->owner->attach_func_proto = aux->attach_func_proto;
>                 for_each_cgroup_storage_type(i) {
> @@ -2412,7 +2413,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>         } else {
>                 ret = map->owner->type  == prog_type &&
>                       map->owner->jited == fp->jited &&
> -                     map->owner->xdp_has_frags == aux->xdp_has_frags;
> +                     map->owner->xdp_has_frags == aux->xdp_has_frags &&
> +                     map->owner->sleepable == fp->sleepable;

Sounds reasonable, but why not permit tail call of non-sleepable prog
from sleepable prog?
The problem is only if it's the other way around.

>                 if (ret &&
>                     map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
>                     map->owner->expected_attach_type != fp->expected_attach_type)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7ff8394e0da..f185ebc6748d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21386,6 +21386,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>                 case BPF_MAP_TYPE_STACK:
>                 case BPF_MAP_TYPE_ARENA:
>                 case BPF_MAP_TYPE_INSN_ARRAY:
> +               case BPF_MAP_TYPE_PROG_ARRAY:
>                         break;
>                 default:
>                         verbose(env,
> --
> 2.52.0
>
>
