Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B74428487
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234544; cv=pass; b=pk4IqwNQDKqjiHDgZkYcY+heIBY0hKshf5DhY3+e0VRUx5isNv0UU3hJtVk3BpK5WVMHMQUwdI1h0/0E/lySlhtd72AoB3NHtGNR30I6ajTgj81lxXoiiVp4EK8ptaqKCDJWVIqQHckixxeA5TbYeDqy7nGi+IUJvqVBhZIHdxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234544; c=relaxed/simple;
	bh=P4RccTdALVk7KXo5G3kL+D6XbgyLZgvTIID4CJSA/Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgVuc2HUZ69elvvz+2JQEl0TzQ/lheOCH4vbN2ci0tjkKffCYWNQHucAtoA5ZKOdQmJF/0260tzYUlmrcHqoULYYyuyDKoDpp+V6faieAnZ+4M/ZbWb+Fm0hXIE+rE2bNI01yxG7RxEHYCqGNZrYOLGZZ0J1iQHWUORANmRYuiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHBjjc7i; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHBjjc7i"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29efd139227so1576235ad.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234543; cv=none;
        d=google.com; s=arc-20240605;
        b=WFRcytPNanpbAGt0ulUkSpoGtkwLA8qMblHTdbQJcsiHZ3EssPVio6c6+yjhMDU4Bw
         ZCFRet2nGzD5WrDQHvVsyP9wMKAQwfMO6V9OeXr1FKVkWX7srfC/YrWbb8OGEfMhQqfQ
         g7Kr2BNURJTgpBQjn+TNhTp+YwgdRmECKJU4qy2vx8CzyMC18+SgoOQ4DILS2S4f1ZTe
         Nul4TUyNyXxrTVjyD24gb3wIcCZ6JDa9PLHhhYdAKZqsUhlm6kCBMs75F1YC07GofXOg
         TH0PLY4KKVdaa1j0zKzXlgyES1GYju3kQfO8sSIuLKmrSAgrsKhXZm7oLeh506z9O2pC
         l+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h+M8Htr9ti73Lf5CZxUjPKlAeSUlxTCFeqOWZih+5WY=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=LbE8XTdpgemvwGlr0f+i5xAqHjxi5QSxwoGBUllMQANHTHO9xvW0HRTLbS3i+oAa3f
         Lza5Duf70/hAdpJxJvM+/pZtmNDs5Veyn03gWhiYQJqBHqZEf8PhOJqjySJS5gaUDdkU
         CNp+LcsPAdQwRTz2JgoR+9PGFX85DyYtov1N0pY1EBIo6z5qjx5L5BIG3qOCdL7w98KY
         pcYmWgSZj/5iQA8nhp/4Sepc3h0LjSFoZn1Y8Di6pO83tbsp871dy5Bjf2voh2fZAgm6
         r3vbAv1GnZVBuNQ7SFIKokp+rzHIRiDl4FR++PBhMx7SZ9zPl3PhOoHaFR7N5bWQXI7z
         uzrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234543; x=1770839343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+M8Htr9ti73Lf5CZxUjPKlAeSUlxTCFeqOWZih+5WY=;
        b=cHBjjc7iLYz5ndTbkY8fkF0/MP5ECbbQnxbQkJFDBaodpp7nubmlOhd1roRx4JfggI
         LYeEo3jTuisOAmtfVhP+h/cLQirxjv/XE0aWSXUm0B/6IzFeGJ3uqwbxB7thJxEBsT7T
         V2PnsMVf/p9zg1Cb893QKi6hHGCLIaARhuyi6f2/WR64mJY63H+6/6uP7rfAmB4bgj9q
         BpmFgM4YhZvcMBQ2wrcUUz6H5gaxv6aj0y6zd0SDro63l5nmVxIiIpdxuWt//XvQqLEQ
         TvtjQqHY0iq8DTNqaa0DfLGIChMAXL1RUGbjPMOFAy1u4N82ig9WFLlFQSzmRAJh5kdz
         +Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234543; x=1770839343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+M8Htr9ti73Lf5CZxUjPKlAeSUlxTCFeqOWZih+5WY=;
        b=P/3gxI1NQ4ARFYgt9RRtnNl+7cW76oJpjh+FkIy7pfkWu8burmLfnuX2tgDZWLkWSt
         jKHEi0mRlyenls/71sNqGZLbbOiPV/RFa3lTPnZlItk653AXT+MU4f3SAmQ/NDinQG4D
         R44QdE2KQBmAgkw8FEOcjANlTgFqtzE8+x3/O+WGpUOtYwEpyH6w2EmtHSdk72UyzhwB
         oZ5m8CcjOkglcFpoJG9ZNt51NIxin8IMXy4SzbeIw0TNcaBeyY10xqUu2wcDZSDGYJyc
         NFJpXIAbTnWLoXNC0UfZy7riZiw/uGCiqK20ShZPn/sNT/Ni8BuXTnF2zntk0QMrnP0C
         gYGQ==
X-Gm-Message-State: AOJu0YznmqU/1usI2LC6AMvXMK/ARmTIcdueCA2UODsE/5faENpkrvT/
	ha37WtjPLW++f70JhBb1+eoIWAJg/+nc/9vqCu5+7Uw1vgJIRRf+KPW0w8ko1I5TiPP6uxhtScA
	XSRudw4QNAbFjBGiVnFJj2xYBQ4Yyu8w=
X-Gm-Gg: AZuq6aLAJ8xHqNdpyn/LppCYX/j11y5skUq4fkHxAmwoAdP/6H7fO7SBdPLgQy3zkkD
	JjEwV6lwJkEKAAZFjVDCHCblGa/IAxaRQzfqnfxy6kha7K3dZAOVJl76812inrHkrbpz1vV++LS
	EaVtFB1GlV+MnZ8TyYDcMzTmik7nvWsFeGl6D9lUH/Y/yZ0gqmhPUm66/fWKo3HO9VazNfHS1hk
	sLhMV8Q07ELsdT98M2scZL5efy45Y0GvQpcpzOCUOY4E29UBmRzITSLR2h2IcmWvAgddD2DO2xT
	t1srBc35IA8=
X-Received: by 2002:a17:902:e88d:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2a933bc9b8amr48387865ad.5.1770234543336; Wed, 04 Feb 2026
 11:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-5-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:48 -0800
X-Gm-Features: AZwV_QjUlT_cWqgjztt8E7bGlgaHJ3gG7CwUG4HZmCNdazdNONiDcafxsvfD97M
Message-ID: <CAEf4Bza-PM9ExqJS=Q_oj7Cqc5dvmbN_Zv9-4UnJNtsZU28FoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 4/9] bpf: Add syscall common attributes
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

On Mon, Feb 2, 2026 at 6:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> BPF_PROG_LOAD can now provide log parameters through both union bpf_attr
> and struct bpf_common_attr. Define clear conflict and precedence rules:
>
> - if both are provided and log_buf/log_size/log_level match, use them;
> - if only one side provides a log buffer, use that one;
> - if both provide log buffers but differ, return -EINVAL.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/log.c             | 24 ++++++++++++++++++++++--
>  kernel/bpf/syscall.c         |  3 ++-
>  3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c805b85b6f7a..0d106fddbbc5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -638,7 +638,8 @@ struct bpf_log_attr {
>  };
>
>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> -                               bpfptr_t uattr, u32 size);
> +                               bpfptr_t uattr, u32 size, struct bpf_comm=
on_attr *attr_common,
> +                               bpfptr_t uattr_common, u32 size_common);
>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index ff579fcba36f..345005ba98dd 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -873,10 +873,30 @@ static void bpf_log_attr_init(struct bpf_log_attr *=
attr_log, int offsetof_true_s
>         attr_log->uattr =3D uattr;
>  }
>
> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_b=
uf, u32 log_size,
> +                              u32 log_level)
> +{
> +       return log_buf && common->log_buf && (log_buf !=3D common->log_bu=
f ||
> +                                             log_size !=3D common->log_s=
ize ||
> +                                             log_level !=3D common->log_=
level);

let's validate (unless we do this somewhere else) that if log_buf is
set, then log_size and log_level (? not sure, maybe zero is fine) are
set, or all three are not set. Same for common->log* fields...


> +}
> +
>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> -                               bpfptr_t uattr, u32 size)
> +                               bpfptr_t uattr, u32 size, struct bpf_comm=
on_attr *attr_common,
> +                               bpfptr_t uattr_common, u32 size_common)
>  {
> -       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_siz=
e), uattr, size);
> +       if (bpf_log_attrs_diff(attr_common, attr->log_buf, attr->log_size=
, attr->log_level))
> +               return -EINVAL;
> +
> +       if (!attr->log_buf && attr_common->log_buf) {
> +               attr->log_buf =3D attr_common->log_buf;
> +               attr->log_size =3D attr_common->log_size;
> +               attr->log_level =3D attr_common->log_level;

why are we setting this? Do we still have code that can access
attr->log_buf even though we pass attr_log everywhere? If yes, should
we still have that "split brain" code?

If we don't have this assignment, then I think we don't need to have
bpf_prog_load-specific and btf_load-specific log_attr_init() helpers.
They can be unified into generic log_attr_init, where for
bpf_prog_load you'll pass offsetof(log_true_size) +
attr->log_{buf,size,level}, and for btf_load you'll pass different
offset of and btf-specific attr->btf_log*

This helper will just be making decision whether to use common_attr's
log fields or passed directly command-specific ones.

Or what am I missing?


> +               bpf_log_attr_init(attr_log, offsetof(struct bpf_common_at=
tr, log_true_size),
> +                                 uattr_common, size_common);
> +       } else {
> +               bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_=
true_size), uattr, size);
> +       }
>         return 0;
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e81199361241..7125ea445c6c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6232,7 +6232,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size,
>                 err =3D map_freeze(&attr);
>                 break;
>         case BPF_PROG_LOAD:
> -               err =3D bpf_prog_load_log_attr_init(&attr_log, &attr, uat=
tr, size);
> +               err =3D bpf_prog_load_log_attr_init(&attr_log, &attr, uat=
tr, size, &attr_common,
> +                                                 uattr_common, size_comm=
on);
>                 err =3D err ?: bpf_prog_load(&attr, uattr, &attr_log);
>                 break;
>         case BPF_OBJ_PIN:
> --
> 2.52.0
>
