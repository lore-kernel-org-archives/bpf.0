Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B23B95F9
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234541; cv=pass; b=bR/M8+9nNyLd8x6ihoPRPK3ozdG7nsnpY/dCmuGKn2QiD/PzX5cqeydANuEv8JhMUmmCqEUY47X/3zfP6fbU52UQ4jsooDcVtRQsvdNH9eqrCZDD2QyMC/Up4uMnZDrWTcfCbT1gLRa+7VV3XKFbN7yLbLeHx+WQprsUjYfIG70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234541; c=relaxed/simple;
	bh=B3y43fdvkCJvjh5Z6KJwL8Qv+EAMqv2LGtVQzZKKa94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALVIXZggnh0cfuoBBJE5qU207soKu4yJHHtIHARS1C8Gb4Ob6CpeljYRwNheoea4eP04q6V6qUM3q/KzHPaZVQ+CFx7ZxdeNVVz3DDTdAQt8bNiOrZeYLuNsdVNiDM1viti3TEsh/j7Mn6v+NDjLsMwADyF1RIwrZ6F2ZTt6CwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+DkgA+a; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+DkgA+a"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso46928a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234540; cv=none;
        d=google.com; s=arc-20240605;
        b=PQtsiqthaIbSwY+E2nA7YjAS9xCsTW1TtK7UCbE50KqK4UK0iReHizKn/Cp/LAYmEx
         Hxef6dntQmgOGYomH00R9/sSd6cIHMgGdTFGAwreGW4HStc2Fbb/blaXkg2l2XV9znTl
         732pQcmVLQmAB1ZTu9jNDBW9pHNLmonwCaPdQExxmqxVnOXgiLxPsmJkAA/srtROnzPI
         l2KSqkVWlZVKQQWIqnAHawjvNXWuLtOV6mTNqoaioAjx5e6tDqrJt8EJ35Y39CSz4BUY
         FUimLG5yENnhpZBR6Wlh3GiclOIZQIqMXXPYLsG0ArQ/SI/M5RrxYoFhXjvsG611Tm4q
         Iifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ou3bUaOU6pyPsxirJGD47BajZ+kCq3l+P77vnFSOEKM=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=V4PI786Iuvm7ZjRhiVWW54bA8XEhfp5/yHLUVmmbVqzxIJN26oiJtsVzkcNd2qaKN8
         qRo1HQqQW+bjZDzBMDLvsk5i2XtOkY5CDP7mt3/aKav1M9GdlnfHoG+YFzy5HYvLkqm2
         wMnu6T53nbAeWNKgp45KW8Ky3l7SnYL+EhoARsGivFUM8uWlpBe+NTpSISP2B6Y3DXsS
         GkZASbMKxLvun4SOghmlcEqWSshbzk11jT7lP+QwTvEnzPBuMlbabm0GPw5VHVG0YpKK
         sJOtKtwdoTWJ89dlfF3DAfopfkWstpPTHbHSwLb+4hJzfbj8V1H2F3GcxgoosN1hwECL
         9f8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234540; x=1770839340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou3bUaOU6pyPsxirJGD47BajZ+kCq3l+P77vnFSOEKM=;
        b=Y+DkgA+aINdjpTwfL4D9odDSkqgXwawF9kQcOARx3c9RvxscRiza7UdtNemb3S0W0x
         IOcShVmT3D+XKC8GwvNRBTojGU4xDupCX6Om5xv0NRME6GBsoft7/eA/eApWZV85xDjm
         8SRFX2NIkeDb0BhHskW/XbrGTcs04Xl3Kl97RXd3kkWhtRITGXQx0lxhB5VhOhIQYOtm
         I+Bp312iaQwUFUgYkHiiBlCmhbnr+6HZlbn70t0DnJ7NTZDHXecb3RMyM2AccrxLatVq
         TvKUv+4WU4a0VFlxqQl9tbRCRgxRaEv95LI4tsLdjHjpKr1+zp0y+AjUbfrVXoldvWZi
         75iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234540; x=1770839340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ou3bUaOU6pyPsxirJGD47BajZ+kCq3l+P77vnFSOEKM=;
        b=tn9CHhto0h7/RSVrJPqN1zwxV51zmc2FlQvQKonwfM4CFyjA87uDRPtGqDR5eRv1vG
         skxrFag10lElT+S08/asEiT8RosUF+HgsiHDccx++3KyfRVVwaidfVKYhxckysy9JVSC
         RhsZ0/gGF1GFlLH1qGzXa9L1Pt1E4Nye7tt1ZRArWnptT70sUYCswwA539a1Zyjs7tKE
         ZnuvtJag3HlgvEURSYu1b8oO/SKJJXfJP1rar4JXYAeq2BVdI+ynUjGrh/q3/UU2f3QM
         9eKU655LwAyaNBBFx82Wbi9g8PRwyWIinqgFYZtoHki0EVdZHCyoLew/+oG/QUqCNSfo
         2IZg==
X-Gm-Message-State: AOJu0YySvFgqi9nqxQfV1IUF+xOA2VZPOFCOm41G58I6FttsKvdaxrM1
	NYTtmt20xgugxdBHQsrD+YJsBd0yJkjbRTGQj4Y9Pmw9fZV8ZBwJoBQi5gQhewUa5w/pIfxjCnF
	kMms4KwZKqutkncO3H16zkN33B4VPwxc=
X-Gm-Gg: AZuq6aKhPhM7UM0LIT1H5Fzdho7Xlq5imKE3hn6LP2kgizqGxqHQfxrKA/gTPvYFWoC
	4or1d5qt2XjtfK6w8cMYMnKtEEiv0Q+28+G//IDK6tNyfrixfl0WLkoPS6x+RLkxRTQTi+6rMr+
	GQujGoocssRvtm0QG4/dGd0DdnV4cohnC+e//LMhCHz+Li6luw5cYzxh0aF0MARnmraI9nyZ7FF
	DHCf9g67ndXO8eEAitS3H9fFOoYARM34OCy+RO0U0Rx3+Ry1a9Jdc3KmvehmrQg4D3lWy6bUaYz
	wJ9n6POkpCk=
X-Received: by 2002:a17:90b:35c8:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-354870e4f05mr3605002a91.11.1770234540184; Wed, 04 Feb 2026
 11:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-4-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:43 -0800
X-Gm-Features: AZwV_QgJ7Bm5-XV_jmFavQ2YE0pj8PhX0zAxJIGqH2A1WMmMepCAC4lZG3IYaek
Message-ID: <CAEf4Bza+n2-tq0cGvAit23OduWbqO6teF211iPnOfp0s_ZwEPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/9] bpf: Refactor reporting log_true_size for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> The next commit will add support for reporting logs via extended common
> attributes, including 'log_true_size'.
>
> To prepare for that, refactor the 'log_true_size' reporting logic by
> introducing a new struct bpf_log_attr to encapsulate log-related behavior=
:
>
>  * bpf_prog_load_log_attr_init(): initialize the log fields, which will
>    support extended common attributes in the next commit.
>  * bpf_log_attr_finalize(): handle log finalization and write back
>    'log_true_size' to userspace.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h          |  4 +++-
>  include/linux/bpf_verifier.h | 10 ++++++++++
>  kernel/bpf/log.c             | 35 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c         |  8 +++++---
>  kernel/bpf/verifier.c        | 13 +++----------
>  5 files changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd9b96434904..d4dbcc7ad156 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2913,7 +2913,9 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t=
 expected_size,
>                              size_t actual_size);
>
>  /* verify correctness of eBPF program */
> -int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr=
, u32 uattr_size);
> +struct bpf_log_attr;
> +int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr=
,
> +             struct bpf_log_attr *attr_log);
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8355b585cd18..c805b85b6f7a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -631,6 +631,16 @@ static inline bool bpf_verifier_log_needed(const str=
uct bpf_verifier_log *log)
>         return log && log->level;
>  }
>
> +struct bpf_log_attr {
> +       u32 offsetof_true_size;
> +       u32 uattr_size;
> +       bpfptr_t uattr;
> +};
> +
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> +                               bpfptr_t uattr, u32 size);
> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
> +
>  #define BPF_MAX_SUBPROGS 256
>
>  struct bpf_subprog_arg_info {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..ff579fcba36f 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -863,3 +863,38 @@ void print_insn_state(struct bpf_verifier_env *env, =
const struct bpf_verifier_st
>         }
>         print_verifier_state(env, vstate, frameno, false);
>  }
> +
> +static void bpf_log_attr_init(struct bpf_log_attr *attr_log, int offseto=
f_true_size, bpfptr_t uattr,
> +                             u32 uattr_size)
> +{
> +       memset(attr_log, 0, sizeof(*attr_log));
> +       attr_log->offsetof_true_size =3D offsetof_true_size;
> +       attr_log->uattr_size =3D uattr_size;
> +       attr_log->uattr =3D uattr;
> +}
> +
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> +                               bpfptr_t uattr, u32 size)
> +{
> +       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_siz=
e), uattr, size);
> +       return 0;
> +}
> +
> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log)
> +{
> +       u32 log_true_size;
> +       size_t size;
> +       int err;
> +
> +       if (!log)
> +               return 0;

can this ever happen? why guard against this?

> +
> +       err =3D bpf_vlog_finalize(log, &log_true_size);
> +
> +       size =3D sizeof(log_true_size);
> +       if (attr->uattr_size >=3D attr->offsetof_true_size + size &&
> +           copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, =
&log_true_size, size))
> +               err =3D -EFAULT;

minor nit: return -EFAULT;

> +
> +       return err;
> +}

[...]
