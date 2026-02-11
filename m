Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90F30F924
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847727; cv=pass; b=JiuC2JCoyxnd4IYWA9aWYVrIkiW2DWPtMQf9Xtc0WyhDOdFAFNSMupbKjXmOuUal5ucmhRj5iQjCJX0mX6cDdNPRFwA0+Cxk8ZYBHH4cSoIsvAeRFnLQfIrzcFv6O6iI2T9d5dX2raFukeehAuXUj9saXhUG9ErNzhfqy5nA00I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847727; c=relaxed/simple;
	bh=YTEc7yz++McjM/QESfkzmoIxz5gszvA6+FEULAO3vW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc708/0y+4eQVd6N7SWDKvPz1x13q7QbftEP0AdwzXkW6Dnoqf8/fCvsqh1Y3TifSwjASqdIN1Rp2bMu7G68hO0ZpwsqPl8NVEBDmKnquckJ44vFOZFUabQs7GY9/Wc4JgQ9lHKjUQ1elTAQF7IzJBXiTwMnDIS4OUgvsQG70kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKEMc8KQ; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKEMc8KQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35640ad94d3so2065645a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847726; cv=none;
        d=google.com; s=arc-20240605;
        b=asH805h3ud+b8GNxr6GCRpn3deJWEFM7VoJFT8c1XkUr49bOEgNMpV32QrGGj+WOJi
         8pcsH8DhKpmawrlEz883A2K8J4GjqpuB9q8/ANolGk9a/VEh96nSBfuZHvPFOSoxYH4v
         TY2h28DjRJ8H8Ubw/3LjaqEU47o/zLtqfMAldbhhr3QuagRigYe54A3e9ZiLSXgfQAWV
         kuhhP82cbBqaNColKz0zrc3Un/zah9766M7RMnMWBJBIxiybMESI/CKY8SWUnSUvYfet
         qCsLRylSZAFckma56IKvYX3fxTJ7YqV7CFgrXcPDcJGTaj6g+oE9X8HxMux41rBx31C4
         Dc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBH8LUgAoQkvcJBNFakHNRaolsL29KJZe94++vwPAx8=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=gxLBw5Pe4XUc1SoPPiEJKMXcGT+IQ4LFn2SlBI3+KOaRXT9nc9G8OgiGOTZ2Ekxh/6
         meeOnVzhlriugyI5fSCLYUlyHmqyaclcqc6yyOSyDHSGND4Xk1HyvpiiULbe0v39GmHo
         cQGfRlGfvpJCjiZbdMfMs2k7AgVziHj6XSRaLiDhH3t8p1OUDWsUsDbrU358R3JmMGIw
         LTjjUceazLrQbBiQtJ+vjHO1k7ztS7u4iifky1NnP6q24s4Jllt1K4O0rBLUf7L1iH6w
         aIP1+DtQ4gIVVVN0k1wKdYPdLcJPPrLt5WE1BFl9kCxXjiJx1HUuHzQGeKdeP8gjqEAt
         0YiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847726; x=1771452526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBH8LUgAoQkvcJBNFakHNRaolsL29KJZe94++vwPAx8=;
        b=NKEMc8KQYqzZgd/32ApugbQfpSTM7iHGzu6RpUeOFRcsNzbJ581VL8koHKiDCS7jLd
         +QXz/2qgsrKBFznkGa3zcPjBAsvyJCNTGDdXXSu7xR6o0hpIIAwpBL0ZmnwyBXW0Bhz/
         lmpRn5fvDW3UDRTs149pe75NLdTfD6X0ZlKM1vnEmly2Eep6NHEh7v2R3Dx7RTDwacoJ
         voH13EGmXoWY2lS0uUXiMmVfm9wk6J4t/0JA+ISqwKTWt1fm1jsledz3UOGPZAUHg7WS
         +0z9EvVT+uWnp50Z211j6RliwMItsiIh+AqI9M17M9TAADxQyA2NLhcbHlpDBQLCWwfH
         HBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847726; x=1771452526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBH8LUgAoQkvcJBNFakHNRaolsL29KJZe94++vwPAx8=;
        b=ke7fq0pkU7V2TFf7uaPyKEhGivpxl/wPWfjIcQnkIzT3w5VxbP45yJkemZxiA96x0r
         lOSOqfbmaQJlujgOQyZhMHESO3BrlSIVobODDhddA2GENgXJXm3AuDjcR+RSV+MULcnD
         yrXWQCaI2h3g1lB9RFi+Mc56l8fZT0LKXOHUasUsfLeQqQ++io2YFeaIcM/11s4oh+x3
         3JYhsL9ivTdRqLZPP5mhhkgP9qEiTpI1OjhdeQseqkhM+pgHv0Kh5nJV20f6NjsOui/H
         vajdHjHXuZUycPmHb6e4fsjtNei3INgpE2yI4gA3C6HMABUFTPlVBE9R6/OjwU9lArw4
         JiCg==
X-Gm-Message-State: AOJu0YyZ/P+EaAXXnV+AdgQzAjE5sApc/WSq0uBMABEb9INsk15H1+ro
	70WdDtPt9ka5grln9ZFvG2/bPOBh/dzTvgjgTy2UH7Y6NNeI4gETpJg6TRWO7GPHzX3CC7yY2s7
	+1fI48JLOIqnIEKEQqvq7+lCpri7F9zw=
X-Gm-Gg: AZuq6aJZfTbaR2X1Qv5NSFmVxC0YmQ0004zFcc2cUn1R2VUdAvTqm6DaOR/jWfojgYt
	3gySGDUT/xnAIFqeC6xgSyyLIU7J9j8HBFiZm5hYnV1xasb7gkDFFAcrcLesaeMuaDRfg+WS3Pk
	PuZqASONJoK95z5U6OyYjzUsgxkKHGQnKjUX/yhBcRc3/XaptabYU5JNHnxbvud+npEDeZx83NN
	/hfSkey+UV+lq/KZ41Oe+VFKWxapYEXESzSergdzRRfshrllqw50C4fECilmaRnXk7PnaO+z4b3
	6S7QR4UF19KTorxsUQZgcSs=
X-Received: by 2002:a17:90b:4ecd:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-35693cbc9b2mr148121a91.4.1770847726037; Wed, 11 Feb 2026
 14:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-5-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 14:08:32 -0800
X-Gm-Features: AZwV_Qh1cQXIN4noSjTPx6D9rnW3i7gLc8B_jvGvfZ948hxwQMFC6HuziGukW0c
Message-ID: <CAEf4BzbTtC19E_=RCk_KCjrOimbefhnXCEfURw4b+caxCY6SRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 4/8] bpf: Add syscall common attributes
 support for prog_load
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
> BPF_PROG_LOAD can now take log parameters from both union bpf_attr and
> struct bpf_common_attr. The merge rules are:
>
> - if both sides provide a complete log tuple (buf/size/level) and they
>   match, use it;
> - if only one side provides log parameters, use that one;
> - if both sides provide complete tuples but they differ, return -EINVAL.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/log.c             | 31 ++++++++++++++++++++++++++++++-
>  kernel/bpf/syscall.c         |  2 +-
>  3 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index dbd9bdb955b3..34f28d40022a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -643,7 +643,8 @@ struct bpf_log_attr {
>  };
>
>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> -                     u32 __user *log_true_size);
> +                     u32 __user *log_true_size, struct bpf_common_attr *=
common, bpfptr_t uattr,
> +                     u32 size);
>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index e31747b84fe2..a2b41bf5e9cb 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -864,14 +864,43 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>         print_verifier_state(env, vstate, frameno, false);
>  }
>
> +static bool bpf_log_attrs_set(u64 log_buf, u32 log_size, u32 log_level)
> +{
> +       return log_buf && log_size && log_level;
> +}
> +
> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_b=
uf, u32 log_size,
> +                              u32 log_level)
> +{
> +       return bpf_log_attrs_set(log_buf, log_size, log_level) &&
> +               bpf_log_attrs_set(common->log_buf, common->log_size, comm=
on->log_level) &&
> +               (log_buf !=3D common->log_buf || log_size !=3D common->lo=
g_size ||
> +                log_level !=3D common->log_level);
> +}
> +

I'm not sure this check is doing what we discussed previously?... If
log_buf is set, but log_size or log_level is zero, you'll just ignore
log_buf here...

Maybe let's keep it super simple:

if (log_buf && common->log_buf && log_buf !=3D common->log_buf)
    return -EINVAL;
/* same for log_size, log_level, log_true_size */

and then below just

log->log_buf =3D u64_to_user_ptr(log_buf ?: common->log_buf);
log->log_size =3D log_size ?: common->log_size;

and so on


We can be stricter than that, of course (as in, all triplets have to
be completely set in either/both common_attr and attr, and they should
completely match), but it's just more code for little benefit.

>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> -                     u32 __user *log_true_size)
> +                     u32 __user *log_true_size, struct bpf_common_attr *=
common, bpfptr_t uattr,
> +                     u32 size)
>  {
> +       if (bpf_log_attrs_diff(common, log_buf, log_size, log_level))
> +               return -EINVAL;
> +
>         memset(log, 0, sizeof(*log));
>         log->log_buf =3D u64_to_user_ptr(log_buf);
>         log->log_size =3D log_size;
>         log->log_level =3D log_level;
>         log->log_true_size =3D log_true_size;
> +
> +       if (!log_buf && common->log_buf) {
> +               log->log_buf =3D u64_to_user_ptr(common->log_buf);
> +               log->log_size =3D common->log_size;
> +               log->log_level =3D common->log_level;
> +               if (size >=3D offsetofend(struct bpf_common_attr, log_tru=
e_size))
> +                       log->log_true_size =3D uattr.user +
> +                               offsetof(struct bpf_common_attr, log_true=
_size);
> +               else
> +                       log->log_true_size =3D NULL;

why not treat log_true_size same as log_buf/log_level/log_size? If
both are provided, they should match, and then we don't have a
possibility of inconsistency?

> +       }
>         return 0;
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e86674811996..17116603ff51 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6247,7 +6247,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size,
>                 if (from_user && size >=3D offsetofend(union bpf_attr, lo=
g_true_size))
>                         log_true_size =3D uattr.user + offsetof(union bpf=
_attr, log_true_size);
>                 err =3D bpf_log_attr_init(&attr_log, attr.log_buf, attr.l=
og_size, attr.log_level,
> -                                       log_true_size);
> +                                       log_true_size, &attr_common, uatt=
r_common, size_common);
>                 err =3D err ?: bpf_prog_load(&attr, uattr, &attr_log);
>                 break;
>         case BPF_OBJ_PIN:
> --
> 2.52.0
>
