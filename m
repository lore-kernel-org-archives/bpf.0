Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792538768;
	b=vxbwbv/1UZGtZh/Y1mIhYmTt5F7ui5G89nCf/GHIv1sAauGDsVvWBzf0RbPiMNVk1GS7
	 TAvz8lo7KHSpYL7QgoRKXuvH9puKrWytfszvmtX9bDW2aA20OjT5Tz0G1r4SLNOrk0N6+
	 VSB6HTJ4HO/zuaHnPgAMGT2lcKZlsAO9FOnNRbIE3WHKDINxvg/AuYXKPolxdcmJqIL1l
	 9Lbo/2Z2IxzrPvgzBcLfkG+vWq3xFoHPlhYh7Dvdo3i7ylaUwEvQHNbT7ZSkFNBGYRIFv
	 U3swc7npNQUY6lRBaGkVyfuy3uZSx4iHhaRFpFYMRtjhn9FWgRezVFFDJM0UrAHfRRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xyqDPzOKJl88+NvwNHrrm2JsEqX4pARN/C15jZakpa0=;
	b=hEWbwBM/DG2F9CPUQ26rhTXGvNKjFNGLWAFNzRdVFpY2GSKe4Zf6S1hL5fpfJXuGANVT
	 5s/1wBOzGAnXxVLQKgVG2NEKcH0cR+HMPFvgXp4VJ95BhFoiwojgAmVFYhtK4K67j5bKv
	 w7fW40OMxB8xwSlb96oK7DPcKI8D8YWi4W2+y6lb4bvYJG0V0z3YldSL1hpB/MNwgexgY
	 VIIrIto8Ijys/A8hZwClt2xoKCnEVQkshUuazTpTR7vuObkitUegruw3COX2VFY0GTDml
	 afl0CCzHph5fyCfXmWab6cElKILxuJ0iXO8OWIdCOKqpa5ou128yYj0bF4rgCY1rXFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qM0+ADNG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E256606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E256606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qM0+ADNG
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e977109392so951865ad.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792538768; cv=none;
        d=google.com; s=arc-20260327;
        b=dAlDnncbwS3C34J1i3ANiGXQBS+uWIgj9aedX+m0AnE1wg6jw4PNrtVA7omFrc5FRB
         WuULgmEZGMrNPfuy7NHIphN33v0Osly0Qzp8cllpKgE7ViTYFmwcZVTN/J1c1Ulp6sWM
         PJONr9K54AkUOpwMtSkg7LG3K/oPDFINUc632qlH12cg3BlYRfqjfdyuhgmnE2T3BVU6
         OPqT7G4xNQPj1MMKLvlvLBy536Jpzwlxhawx6oWNqJxoQ0qWwZtHixvGM+zbHiijeo8Z
         wVKu/eNtD4SdCiI0fy6iGFfSGF1UzmuGFbrYbwZIXYx25xaW9AzBj38vrjYXPGpWCO9V
         /Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyqDPzOKJl88+NvwNHrrm2JsEqX4pARN/C15jZakpa0=;
        fh=PvUGavGpFlNRd7NQy2ALC1wcQIZjFG1VK/PefPLkKGI=;
        b=cahQ4xVlldbb01U1DxoVuaGVjeSKejUU7cQO51sdM7aogx8pO7iUd3D9ZhY+Cololi
         ELDHwWAVmwkxVLQRBKYn5Rd3uI23v4AwcVkD8Vd9+KLemBW1DzD+JC1epE8WXGlxjnrL
         90vrfAoWeKPOtntLYlv742Ioj13wvx/FdumoMg5r5Fk6hkJbUGkfh68UrLhZ2VcCIT5V
         omFo45s/WsAu4ULdBQGG7tNC+LIz8a4IZaxPhkqbW6jb+p6AG/UW/JCf1gqVeZb46N+6
         gH6SzbuujcdM++izO9fBmS69CLoY0vImguzXjdU22d+PLlYOoHOHothu6QQ6zXfqOYY7
         IJuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538768; x=1793143568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyqDPzOKJl88+NvwNHrrm2JsEqX4pARN/C15jZakpa0=;
        b=qM0+ADNGoG3hYbfcw9Hhfz1nkRSW5OE3gkA32HzVbHb6cTQfwInMWb6jgTvgikixYt
         NR1Bm1uImSOUNIt0HdWC7wk6ceUdaCMvZUneapLTvY7j66PJX+f33N9mTpZg8D0kxbmO
         JzloxsssVmu/gVxMuIGT8rTZBG+eTnSqyn3H7jwEC1ksSRizF6ANPGqEPDUFuGAiC8jV
         DIocPjtvPOwB6tYWxJWF3RcLTWJk89LvUmOqL31KmcG31QCFKJPHFyRal/wW0smxUO71
         u0Z0TRF3+xEvMZXbaW0dLZW5a9iHqrNeyLtveF8va4fa/DIvI31hhPCPbHKX9iqFZrU1
         b7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538768; x=1793143568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyqDPzOKJl88+NvwNHrrm2JsEqX4pARN/C15jZakpa0=;
        b=wkQpsnDI45aodsSC9YnJJzCC7IS9NszNRwzw1B7UbT5gYjg+rrcCLBFw7eN/5DNeOm
         ALhBQNNHiMmWe061l5TeDLS7G3w0TDJEgRH/m+RGEZLZx1/jL09LcCeB+rAoBQx4cVKB
         E0HbzPQd5PMvYD5teYSepMKonSTdpW/McjhQGG+agM2okr8yBLF3rvfTLxbODTPUKxIR
         3PaE8nJ5RjMs6A5xvXm8RNLlRlTbdThUEnPmUaAc4ML3HoGhH8jffs5txLeNCJsqBUeh
         nkJYjcQY98oB0N6AN516DcPOzUUxu6rOGGg3Us36LfUjqBiiXWAdhwWctxTCXwejTrn/
         bSvQ==
X-Gm-Message-State: AFq9FYILTWC4hFlQRMWopuOQA5skr7DLvr9rX0konlibYh2Z/e19PioK
	D/GuouAFz6PyJKsxRscTcnUSTJ6qOXYV0ZT9a4yHYHhebqbqPyQiJN6JPtJcgUWXBQOLPEdkzBa
	CZE9N9N9rwPD37sxT8UT60esJk5PhTF8=
X-Gm-Gg: AYBFou0CowX1DV7Tq9o26kUpxuiTpTEIr3a0dz6Z28hlL1F4EzerG82mGkh8d2DyEaj
	iA5289W/pSpf4mwf35IB95+szAdSZzuzg6iO+UrvKekYwMcOqoma0NWBPPxjUkTKkX8gDRx2eqY
	c+ylOdibbahqvK6kpPTR3h83oKe1fRIoR9LE25O8991U+/PeuKEKUHzeEAXmFU4b93k+TJ/i+f6
	PePXyZyyVykbjUAVohTwxvr3L0P+C+/tAEOaC9x8xw/yQf5b0n+B791HBqmzX4kzJiPvytgVOvF
	zujrKYFMlhd8x7SC7uv9IY/Xv9z01jwr2XmlKpo91gRNk73WFDhbovDy0vtVVKj4f5NCrAXZh4A
	hZeInJPe5uJPIhox4mt9VfSqbSBYgxBre5nmFUxX2zttpkZD0dxto
X-Received: by 2002:a17:90b:17cb:b0:3ac:a521:95e with SMTP id
 98e67ed59e1d1-3ad86f028c8mr320588a91.47.1792538767665; Tue, 20 Oct 2026
 16:26:07 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019153628.15912-1-leon.hwang@linux.dev> <20261019153628.15912-6-leon.hwang@linux.dev>
In-Reply-To: <20261019153628.15912-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Oct 2026 16:25:55 -0700
X-Gm-Features: AclHuK9R-Pz11REH9KszPt0wQBWz-TsT_XQJqO1BNWiMHHq0gxNTu4ERDjHPk6w
Message-ID: <CAEf4Bzbr46UkiE1sbb+Zwcs0S1ejpKmtTGjNCAkWD-J6FRcPGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add bpf_link_create_log API
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Masashi Honma <masashi.honma@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add a new API to accept the log opts, instead of extending the existing
> struct bpf_link_create_opts.
>
> Appending log_opts to struct bpf_link_create_opts would place them after
> attach-type-specific fields of varying sizes, making it difficult to
> extend the struct while preserving forward compatibility.
>
> For example, adding log_opts would prevent extending uprobe_multi
> directly with a new build_id field. Instead, a separate union would
> be needed:
>
> struct bpf_link_create_opts {
>         /* ... */
>         union {
>                 /* ... */
>                 struct {
>                         /* ... */
>                         __u32 path_fd;
>                 } uprobe_multi;
>         };
>         struct bpf_log_opts *log_opts;
>         union {
>                 struct {
>                         __u64 build_id;
>                 } uprobe_multi_ext;
>         };
>         size_t :0;
> };
>
> Without log_opts, build_id could be added directly to uprobe_multi:
>
> struct bpf_link_create_opts {
>         /* ... */
>         union {
>                 /* ... */
>                 struct {
>                         /* ... */
>                         __u32 path_fd;
>                         __u64 build_id;
>                 } uprobe_multi;
>         };
>         size_t :0;
> };
>
> Introduce bpf_link_create_log() to accept struct bpf_log_opts separately,
> preserving the forward compatibility of struct bpf_link_create_opts.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c      | 28 ++++++++++++++++++++++++----
>  tools/lib/bpf/bpf.h      |  5 +++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9a2107d4f6d8..263a1d516a02 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -788,9 +788,10 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enu=
m bpf_attach_type type)
>         return bpf_prog_detach_opts(prog_fd, target_fd, type, NULL);
>  }
>
> -int bpf_link_create(int prog_fd, int target_fd,
> -                   enum bpf_attach_type attach_type,
> -                   const struct bpf_link_create_opts *opts)
> +static int __bpf_link_create(int prog_fd, int target_fd,
> +                            enum bpf_attach_type attach_type,
> +                            const struct bpf_link_create_opts *opts,
> +                            struct bpf_log_opts *log_opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, link_create)=
;
>         __u32 target_btf_id, iter_info_len, relative_id;
> @@ -965,7 +966,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 break;
>         }
>  proceed:
> -       fd =3D sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
> +       fd =3D __sys_bpf_fd(&attr, attr_sz, BPF_LINK_CREATE, log_opts);
>         if (fd >=3D 0)
>                 return fd;
>         /* we'll get EINVAL if LINK_CREATE doesn't support attaching fent=
ry
> @@ -975,6 +976,10 @@ int bpf_link_create(int prog_fd, int target_fd,
>         if (err !=3D -EINVAL)
>                 return libbpf_err(err);
>
> +       /* bpf_raw_tracepoint_open() does not support log_opts */
> +       if (log_opts)
> +               return libbpf_err(err);
> +
>         /* if user used features not supported by
>          * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
>          */
> @@ -999,6 +1004,21 @@ int bpf_link_create(int prog_fd, int target_fd,
>         }
>  }
>
> +int bpf_link_create(int prog_fd, int target_fd,
> +                   enum bpf_attach_type attach_type,
> +                   const struct bpf_link_create_opts *opts)
> +{
> +       return __bpf_link_create(prog_fd, target_fd, attach_type, opts, N=
ULL);
> +}
> +
> +int bpf_link_create_log(int prog_fd, int target_fd,
> +                       enum bpf_attach_type attach_type,
> +                       const struct bpf_link_create_opts *opts,
> +                       struct bpf_log_opts *log_opts)
> +{
> +       return __bpf_link_create(prog_fd, target_fd, attach_type, opts, l=
og_opts);
> +}
> +
>  int bpf_link_detach(int link_fd)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, link_detach)=
;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65..dedaf8086902 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int targ=
et_fd,
>                                enum bpf_attach_type attach_type,
>                                const struct bpf_link_create_opts *opts);
>
> +LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
> +                                  enum bpf_attach_type attach_type,
> +                                  const struct bpf_link_create_opts *opt=
s,
> +                                  struct bpf_log_opts *log_opts);

Leon,

how about instead of adding this new API, we try to repurpose
bpf_link_create_opts' iter_info to be used as log opts? we have this
right now:

union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
struct bpf_link_create_opts {
        size_t sz; /* size of this struct for forward/backward compatibilit=
y */
        __u32 flags;
        union bpf_iter_link_info *iter_info;
        __u32 iter_info_len;
        __u32 target_btf_id;
        union {


that iter_info/iter_info_len is a bit of a legacy before we had
per-attach type union, what if we add iter section into the union,
wrap iter_info with union and put log_opts there, mark iter_info
deprecated or something.

I'm not sure anyone is actually using iter_info (I didn't find any
uses in Meta code base, for instance), but we can detect its use by
checking iter_info_len: if it's non-zero, then iter_info must be a
real bpf_iter_link_info. so we should be able to detect this just
fine, the only downside is that you can't use log_opts and iter_info
simultaneously, but I think that's fine: you can update your code to
use new iter.info fields instead, if you need log_opts + iter_info.

WDYT?


> +
>  LIBBPF_API int bpf_link_detach(int link_fd);
>
>  struct bpf_link_update_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index eeba4072a5da..f6eb57151f7d 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -475,4 +475,6 @@ LIBBPF_1.8.0 {
>  } LIBBPF_1.7.0;
>
>  LIBBPF_1.9.0 {
> +       global:
> +               bpf_link_create_log;
>  } LIBBPF_1.8.0;
> --
> 2.55.0
>
