Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CC33A70C
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847821; cv=pass; b=JDDF81WqbMdGyQMz5apyxhuIv21tuzqix8sYRxl1RDxxkw7t/nGBMwwxtTCyTn+0+Li0OCgq/red4y3PljpGmxuLqH+w0KDb86K1IvqWbcXTrdRKaCnPe4fHRZ3EQFg5XdUSPKbURj6Xcgd44SXjXeRwyE3zLXrXML6ejc70w4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847821; c=relaxed/simple;
	bh=Jx51te78F9fG5q/MbG0A5UTogSDg2Gbg5/ECwjUppIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRV4hTtfprdIP/igtJM0/5yhELLnQxahiuOXXGqP1SBQyrmCWfEnwGZ6QGFdXE52RG1W+4d6Ue7Yb4cEqT1bDCxJykOuvk3/dJAPFtI++vk5wBQ+HHnXjCnkl8yhX5TvO8w9KVo/K22MgqV94uvLt14Z4eVwL8AiGRQnaKjp+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqHqXuBs; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqHqXuBs"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354c6619a07so2260998a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847820; cv=none;
        d=google.com; s=arc-20240605;
        b=Cb01QMo32Xy5OkFgwDQ5oReAKRPEbfUwbV28rB7GPMaundzEAHPF4ZFI+CqxpXxT6L
         wfPBAsyZcqCfHQIaiAI7qyWQVp+OLFWamHpN0cjKSo9iNGSv8fLBooLqdId5FRkyFtmF
         EYYZ6NUlNzijjiB1IqrX3WcK0ZhwQ4ZZMn3MjfnBuB/PTQPeKqd3cqvffP/XLy0B1ssk
         3WOrxxnpycSMVYadP8qARBxrIRPjmlmihKKAYv1da3stqmpfNkdnQw6eliWQDRxWDd84
         O6HLf0E3kYBtmdN7im9njsg/NCv3W1b2ph7TPTGEdmYwJFl0QBJoIyqjw/mD/YAOm8CG
         tyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jt1DZERRpdgz/hpf7D4avpdM/l4d+3BW56XSnERdwo4=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=L2NEpPVstibtcHB0OPqY5IcGAENdKFG5w+Y/Hg5Ll83Smhak0nwhkOoqsF0i1fHCxk
         G0W9l2BKCNclbT4Hc2I/Z7CehX5vHxYEsiB3RjRvGVlbCXNGFR1z/W/qwtMOCjakjJTP
         XZA7D59jU12f5d0lV5HwokGsxESZsu4oMJGS1A/ww1ADdaomWjvSOd/Q4f5xu7pOc1zP
         MCbcR/lbZnGJS+v9N2aoln1fB0C8dCWN+3Gq2OjRv9vrmOlR8RKScd/X5y7J73mp+HYy
         Zz5uOq640ihyYrnEdxkwYUWfiDPnxYvKawuxrsXYK1lkT9f9HnLUIO8rdB9595FNzj2g
         W7Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847820; x=1771452620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt1DZERRpdgz/hpf7D4avpdM/l4d+3BW56XSnERdwo4=;
        b=RqHqXuBsl4dyKLsyk3CqFZTCtoqZ5tp08btewEkxYXFuynmzjQe7na4l32MPZI5Uaz
         1M8gb1ArWi2L3blR5vCN+YtGBdChmQhFn19xO1ZKVeEM1nNv99VcAlS1lWKBn5D1KmSp
         itW3d+IvzO0uwOT6OQ8SwAWkxGNRiCIAaO1DsuK4byheqjrhSxUD8dE91sPE1KIQb7aO
         yUbwuwZ7yrFh6LzdW+vYK9kUDVA50aaftRGLs/b24fS3Us2AmD1U9Zz9VKdPkoXBowma
         pwYgy9RhCTeOa744HUOpYMUyBfdQJRkPkZ1FkWLWTyP1orOp6UBV+gQ1VjdJdN2psYPP
         JWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847820; x=1771452620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jt1DZERRpdgz/hpf7D4avpdM/l4d+3BW56XSnERdwo4=;
        b=gG3XsDg6lBDXTaO7YZPlqz1pMSOZv2NYV3ZeVTqHZu1tdCX+jfQ6qARvBJMwRNrps9
         ClZgc+Gx+MEYoUBUz+ODSSvyPZtGdTEH36pHAoIlOP9LzBi+6gHLADAdzQTZcvAnLp3H
         g01KQRqN8LW+3KuBfo+5n4NU4GRyMejR25pqFaE+SWfbWbBiXnCXiUPktn3sMWyj0fpW
         JvD5GgTvcdE9pDKiOmTpooe+V1Tu/xJkr7i8RAbQn+qduluB9xt9UBGvqAwlU57mewjC
         2eId1dxqbnUiIg+q7PgTPEZAQg0Uif5pdBa2zLDDuDakJnpEM5o61znGKSWDpFeAx5O6
         iWOQ==
X-Gm-Message-State: AOJu0YwlCNw6AZnKPoiHgr+rMnfeaoHB07tknZerjECuuySkMyw6dARx
	dgg++/0cgtNqCts0O3C5K3/KnNsGVoBir7e7krsv+CXSoBlq6/QisfQyUOSH42WA4Sp00UtT9ZD
	hyOuwSvSgxskmXxzmpTyHNhJI7tWS67o=
X-Gm-Gg: AZuq6aJcLS8K3Z9Pw+cZSdF/vuY+vuRAKFtt4orREyCuGfOBJmCDGzNWt77LDCMwVDx
	2+lEPps2CdGnC8IRVZgtz5RpyEfBVFrU6LW0rORh02LReaq17r0TNRk+QJ3CVnWO745Ulk8qTIE
	kBZjHiGAWq8j6qjrVEJX45dCP1GvYZzSM7yklxaLuC1WAsOnSqhJ0FW/Xvj6eEUQB815pXeyLts
	AarhcilsmgKJ9YReu/ipV3GQWDfr5uGxYfmyL0mj5tYtg9uBQzlVqjfXng5nZsba0UAYWBZ3Krp
	t/ZaDS+7DVM5DnTOwYMv8Ck=
X-Received: by 2002:a17:90b:3845:b0:356:1edc:b31 with SMTP id
 98e67ed59e1d1-3568f3deb20mr768188a91.20.1770847819706; Wed, 11 Feb 2026
 14:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-4-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 14:10:06 -0800
X-Gm-Features: AZwV_QjoHW_eXa3KNFiIoCYgpB2WNX8VGq4f2zB1kEtI7WZ87KX-ICHH1_RVN3c
Message-ID: <CAEf4Bzb-b+EcF1oLXA7mijL5kVmjpOuh2B+LPM9x4tAFOYHCsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Refactor reporting log_true_size
 for prog_load
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

On Wed, Feb 11, 2026 at 7:13=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> The next commit will add support for reporting logs via extended common
> attributes, including 'log_true_size'.
>
> To prepare for that, refactor the 'log_true_size' reporting logic by
> introducing a new struct bpf_log_attr to encapsulate log-related behavior=
:
>
>  * bpf_log_attr_init(): initialize log fields, which will support
>    extended common attributes in the next commit.
>  * bpf_log_attr_finalize(): handle log finalization and write back
>    'log_true_size' to userspace.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h          |  4 +++-
>  include/linux/bpf_verifier.h | 11 +++++++++++
>  kernel/bpf/log.c             | 25 +++++++++++++++++++++++++
>  kernel/bpf/syscall.c         | 13 ++++++++++---
>  kernel/bpf/verifier.c        | 17 ++++-------------
>  5 files changed, 53 insertions(+), 17 deletions(-)
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
> index ef8e45a362d9..dbd9bdb955b3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -635,6 +635,17 @@ static inline bool bpf_verifier_log_needed(const str=
uct bpf_verifier_log *log)
>         return log && log->level;
>  }
>
> +struct bpf_log_attr {
> +       char __user *log_buf;
> +       u32 log_size;
> +       u32 log_level;
> +       u32 __user *log_true_size;
> +};
> +
> +int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> +                     u32 __user *log_true_size);
> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
> +
>  #define BPF_MAX_SUBPROGS 256
>
>  struct bpf_subprog_arg_info {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..e31747b84fe2 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -863,3 +863,28 @@ void print_insn_state(struct bpf_verifier_env *env, =
const struct bpf_verifier_st
>         }
>         print_verifier_state(env, vstate, frameno, false);
>  }
> +
> +int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> +                     u32 __user *log_true_size)
> +{
> +       memset(log, 0, sizeof(*log));
> +       log->log_buf =3D u64_to_user_ptr(log_buf);
> +       log->log_size =3D log_size;
> +       log->log_level =3D log_level;
> +       log->log_true_size =3D log_true_size;
> +       return 0;
> +}
> +
> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log)
> +{
> +       u32 log_true_size;
> +       int err;
> +
> +       err =3D bpf_vlog_finalize(log, &log_true_size);
> +
> +       if (attr->log_true_size && copy_to_user(attr->log_true_size, &log=
_true_size,
> +                                               sizeof(log_true_size)))
> +               return -EFAULT;
> +
> +       return err;
> +}
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0e231c0b1d04..e86674811996 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2867,7 +2867,7 @@ static int bpf_prog_mark_insn_arrays_ready(struct b=
pf_prog *prog)
>  /* last field in 'union bpf_attr' used by this command */
>  #define BPF_PROG_LOAD_LAST_FIELD keyring_id
>
> -static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_size)
> +static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bp=
f_log_attr *attr_log)
>  {
>         enum bpf_prog_type type =3D attr->prog_type;
>         struct bpf_prog *prog, *dst_prog =3D NULL;
> @@ -3085,7 +3085,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>                 goto free_prog_sec;
>
>         /* run eBPF verifier */
> -       err =3D bpf_check(&prog, attr, uattr, uattr_size);
> +       err =3D bpf_check(&prog, attr, uattr, attr_log);
>         if (err < 0)
>                 goto free_used_maps;
>
> @@ -6189,7 +6189,10 @@ static int prog_assoc_struct_ops(union bpf_attr *a=
ttr)
>  static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size=
,
>                      bpfptr_t uattr_common, unsigned int size_common)
>  {
> +       bool from_user =3D !bpfptr_is_kernel(uattr);
>         struct bpf_common_attr attr_common;
> +       u32 __user *log_true_size =3D NULL;
> +       struct bpf_log_attr attr_log;
>         union bpf_attr attr;
>         int err;
>
> @@ -6241,7 +6244,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t ua=
ttr, unsigned int size,
>                 err =3D map_freeze(&attr);
>                 break;
>         case BPF_PROG_LOAD:
> -               err =3D bpf_prog_load(&attr, uattr, size);
> +               if (from_user && size >=3D offsetofend(union bpf_attr, lo=
g_true_size))
> +                       log_true_size =3D uattr.user + offsetof(union bpf=
_attr, log_true_size);

LGTM, so

Acked-by: Andrii Nakryiko <andrii@kernel.org>

but it caught my eye that we will never return log_true_size if
SYSCALL program tried to load another BPF program (light skeleton
case), which seems limiting, but we can perhaps address that
separately as a follow up

> +               err =3D bpf_log_attr_init(&attr_log, attr.log_buf, attr.l=
og_size, attr.log_level,
> +                                       log_true_size);
> +               err =3D err ?: bpf_prog_load(&attr, uattr, &attr_log);
>                 break;
>         case BPF_OBJ_PIN:
>                 err =3D bpf_obj_pin(&attr);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edf5342b982f..f1447b1878fd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25840,12 +25840,12 @@ static int compute_scc(struct bpf_verifier_env =
*env)
>         return err;
>  }
>
> -int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr, __u32 uattr_size)
> +int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr,
> +             struct bpf_log_attr *attr_log)
>  {
>         u64 start_time =3D ktime_get_ns();
>         struct bpf_verifier_env *env;
>         int i, len, ret =3D -EINVAL, err;
> -       u32 log_true_size;
>         bool is_priv;
>
>         BTF_TYPE_EMIT(enum bpf_features);
> @@ -25892,9 +25892,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>         /* user could have requested verbose verifier output
>          * and supplied buffer to store the verification trace
>          */
> -       ret =3D bpf_vlog_init(&env->log, attr->log_level,
> -                           (char __user *) (unsigned long) attr->log_buf=
,
> -                           attr->log_size);
> +       ret =3D bpf_vlog_init(&env->log, attr_log->log_level, attr_log->l=
og_buf, attr_log->log_size);
>         if (ret)
>                 goto err_unlock;
>
> @@ -26044,17 +26042,10 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr, __u3
>         env->prog->aux->verified_insns =3D env->insn_processed;
>
>         /* preserve original error even if log finalization is successful=
 */
> -       err =3D bpf_vlog_finalize(&env->log, &log_true_size);
> +       err =3D bpf_log_attr_finalize(attr_log, &env->log);
>         if (err)
>                 ret =3D err;
>
> -       if (uattr_size >=3D offsetofend(union bpf_attr, log_true_size) &&
> -           copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_tru=
e_size),
> -                                 &log_true_size, sizeof(log_true_size)))=
 {
> -               ret =3D -EFAULT;
> -               goto err_release_maps;
> -       }
> -
>         if (ret)
>                 goto err_release_maps;
>
> --
> 2.52.0
>
