Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B83CC9F4
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555548; cv=pass; b=B+XS/2FBrUgJwfPcL8QCd0ZxGETHgmdpF/1yOVDZRg38f8B/z5cJYQxRrhes/pdEbtB9sAlnXBTr6pMVyR4VdRTVdEby4D84Q0xcyn8peQBBMRT1Y+4MI1joZ/w2NP0+yHQfh+Bctn1BLkVGdYQmWMFw/YLuHfuL+Aji8rMF+kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555548; c=relaxed/simple;
	bh=NFXHmw3PkqEWgxiKBYkMhtqKQRC4i3Ub9VuZb+23jdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcHxXk7+JY20htsqo30KN/JxoekwFxrl5lUg8T4njJpwbI5OROaNfBkI5BRvngTTCowDYu4nd/nlmEq7gYqDGctZbE4c35jsVDtuJPUNuWiTb7DAMu7Qg/ja1YhsfMVhz7ARtuNFV/rs6R36D6bKIfeH5Hn+Bwvz3RsQF2xAZp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwiMJ4u7; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwiMJ4u7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439afc58ac7so2858274f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 08:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772555545; cv=none;
        d=google.com; s=arc-20240605;
        b=HWPi7yGjgpCDVwKnR8Xo4DrCUg5adUF7j4mFVBraJH7e7CPXe9K4h+fLCT3tRDHXF2
         gJ/G1gUT4l6/tb2pdH73MBRzE6y/kJT2gkitHM/vrGYCrD1STWsocRj6tWOZvqam4Uo/
         Rl6ZEiZCbTrNN0iD/5VmxPQmiccEuajYYGAmxIS9VuROF5/tvYX0hy/n4ssBR7fWijG4
         F6T0hYyixIMNO+LeSQxEVadrJ7aTQ6HTNK8eiaaV7oeKGra9md2xiUYgQ85H3g431/eC
         EjkvrQy9ww+SdECnb2aDrCdmf+2IMSkO/rVPXR445ooStq2l/58Fse1T7EVnexIzYK3D
         m5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBMiOuYcRpOOTzwH8waC6iyTJM7VoSPVS2wRmUYeTEI=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=DpEkmGTTQzRSor1PJn9wfOvRcoar4EEMQ+kXahOC4deV9UwNhRZ5FiIjjNBIJMZcMy
         tEiMt1DHrGXpq97xTpSTVOCcecYf26WHxmcQcKBFTsp0XUfv6YdYQfr43vIOtDLGc3qH
         g7vtfjr1nrc+i7wOXEiBbyAFLMD2xe4nN5lLf+lnDok+VGburzNI2yjYs7PRmZyLoJOf
         B1bHDtOuYoChfUHiG1t1KB554RE4b+deFqo9ZZuw3PXDpKGL56fdm4M7lU/jOpOyKaRR
         gYr5t+F+NGjzPSQB6iuhdMgTG91YzMG+dGEAjR2WFJx5hB3jtUuIhFs5anpNc7xtUdiq
         OzOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772555545; x=1773160345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBMiOuYcRpOOTzwH8waC6iyTJM7VoSPVS2wRmUYeTEI=;
        b=PwiMJ4u7mC3hl7iMBOHTDeqDL/WfsUsxrT04iZirUQ75QjBZGqui7tt9XM7wndPntz
         wh88NU0NWNBio8RTmqP1YPEqT/9yrLuQep35uJu3fNRyqVA86iYtWsGf9JuSpiD+xbzg
         YSzjTlBKERjTU19Btp7vwdNteYFwlAcZrDjwMLDZCGZ+LMvFbKH8Rs9kicmLcbsKvVGY
         uYEuP8/SLTW7RZfCLhrwzdawiywhjyY1byUQ74FarzAVBAtb5v1/dNL6yjVTb+kUWZVr
         5eA5dcqJFeVewuAc6IiQLBS7MMQbpuVpIFB5tyPM2hTxPiZggn8DZLh7/hLA4T5Rbogc
         LWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772555545; x=1773160345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBMiOuYcRpOOTzwH8waC6iyTJM7VoSPVS2wRmUYeTEI=;
        b=tjxsPUB93kyfxpLed/P0up9kgAqOFfjKIyn7aW/IOwTDnjfORVgw85oODhLHjUsD3y
         LNdPIW5VoRy+Uy9L5crrd7P5V41ZIf18IVulk9taNCqju8AQWcHuI5Mc4WM5Hrpx/cpP
         mkXpwqm5E2r63jHjkkbGujnyoLfGgXv3DABO8PbW1M96vhLwQHce0QTd2EL7I+uZ+M+e
         fc0YpWN2u+T7qgcq44IbuxGrhYi+hhHvWIYJd1l75eD3oF24XNx80E3RUYUce9ooOG+A
         CJYu7J3ICK0H28z3fNhg6cujALkWk8HXZkQ2LxWPeHn1I6nY+zsJ5lQSQcc9cf8u65fx
         c7aA==
X-Gm-Message-State: AOJu0YwbE/i4ukb24fsk19X27Mei7ie5s4D4QTpyGn/ahOsjfzmqo9sg
	CVER3+5SwdRunweZJ+0KnQ9uSnP+lVxCqnJSYhq78SkEReqAvTNCi86GcTlSVDTCbIlJ+RZnGgP
	8oPYHMFt+mv3hX47czJtElndVe94UN5A=
X-Gm-Gg: ATEYQzxZvatyFEA6kJdJdi+Xm4dst3hr6wHxbxioqi46YO5U3PlRZBBIwrvYDw7yXru
	cGJhosu4Z/+YM0a4UQuKWjY0Rob/v1xk2UWg4JYmzGRkd5P6dSNOdxIzV5jcKov4gOFo6MkNDla
	tXAbz4OMHq+Iqsf89JBgqzQY0ox1gKejkSdnJnvdZ6pNwsyZ49ES6YphIgEWyiferL/P3fINAww
	ghTx1xO2bndtrUMAiPNKNnR6So+a1CpuuyKt6MFRhMF0i0QaDO1r71wLQyp1iZQGWr+is76ukuQ
	q4f1a3o2MPPXY+D/F/3Wl+GzyFP/xDyJRm7EGkUzuIsbQJoad+CwAeBNxyP8Z35KIAvzqbOH3D4
	LSTfmsAgLamDYZc9tQ/JfMfcQ2w==
X-Received: by 2002:adf:e98a:0:b0:439:ae2f:83f9 with SMTP id
 ffacd0b85a97d-439ae2f8611mr15735667f8f.11.1772555544549; Tue, 03 Mar 2026
 08:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-4-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-4-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 08:32:12 -0800
X-Gm-Features: AaiRm53VhWZu-OFtnzTca7W5Gj5GrAoGcTd3X-WhGbWInJUGAAWZuQfxnod7Crs
Message-ID: <CAADnVQKc5H=k-++CHxs+Y1ggptRSLRcACLgVaMgOmt=QBT=dkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Refactor reporting log_true_size
 for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
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
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
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

So you added 'from_user' gating because
you replaced copy_to_bpfptr_offset() with copy_to_user()?
This is a drastic change in behavior and you don't even talk about
it in the commit log.
You said "refactor". This is not a refactoring!

This is v10. The common_attr feature is useful, but
you really need to think harder about what your patches
are doing.

pw-bot: cr
