Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793290985;
	b=aQbprz0//L375tcia5uurwP+sKNEfznmWB5mP6P49nv4fj+BQD4dyimERX9hrytc/HBX
	 Gqa9wkhlfUcbVXGDO0EtxQY9a0K7Us/nsFwaiQkH1qA75+NsuwL07GvHgYhMVF957bPDi
	 oOgqJqElKnCMe9S5HNitbRmGEjeZHeqUIOdkToR4tuxlrfh0D/c35RoGMtSZFAHHQ4saV
	 h6HLpq2dWuDb//ApyHWrsQQX2ONADgcsnOzKHgxYYftR8B8GGfdSn+X6t+ZLY4UELfdfv
	 DOthPuPcwkGl/rmCp2bw8T8gTwJYvAaeCd42g7ea+eCaK6SlYL4qMrSj4uDmnAu/hzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
	b=eeTnw+RMbgGQ90zdfq44adY5zMvltObB9gIFW2RFQZWK3W7aEkmI9kLLLTMbYgUEey2F
	 n48EXwysCCpcXZxwAkHiEJor4xBWtwNUhbD2q/Xd8DtX4kqy1spX3fp8b3zEgjfwm0+S3
	 72wjozeOBD0R0Poev2iPSL+JGdXVHgiTLvtO5XyqmYhpRQXXKt7nEkvayHQqkx5XW1n32
	 QsGK65ueKOr9vf2HA1Sg0mOuobBA5XwY8x3awZBMOz9oaKTb6wOz5wpItkIiQpBR1ZvRu
	 PjpzMVjneAEVQ6kx9KQru9HDsDbbb1wo77pwezX6gdzm8e7Ckq332oNXpvN6+gJGumQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl6h3FxT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F160A380C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77F160A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl6h3FxT
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40f29667e6so320991966b.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793290983; cv=none;
        d=google.com; s=arc-20260327;
        b=oBpbv8sJ4y4a7VxZIdIMozBFAc34XaRtS4p5x2ULC2HWqlQA+xFj6kf9VTiLhajJnV
         KAE/WzAP2nSlKFVqNz7r9u6Q1sTFoRmhn18gwBj72atMcnh+V1EOB/Xi+oD5ctxfDbH9
         nXD8KufzdoP8BT6HFSNn9aSxSPFQmSIWVI8DD4Ktz0lmQKsVEl6RPsXZ5A4rYXT0YyTZ
         KMjJgMODDY/2QZ0whJUsk/EveM3KP0VtkOpaXYHSdDh5ZN2+Q8SacBY2/c4xo6kn4tKM
         uHjHZ9D1mE8d1x6ddK+Yx44iLRwabMZIyTlnP6vh5LIRLAr4Fb5HQDb4sOQIDV+OccS2
         PGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        fh=PvUGavGpFlNRd7NQy2ALC1wcQIZjFG1VK/PefPLkKGI=;
        b=rpbNPRPdMn3lwkFlZyHcjTlZfCRD7Y4xJmQGoXfi/nWfbKph/md+Cqr27UAoqkFzmN
         2YNoYxKjrUsCOJT1bwhZn8iO4CpoUfCksi2/gT8JlBB+0W3cQHMWpbTdo5WEn93/Nqa0
         z+DZNx+eLCybquxnu3QCuSQYxwKzbJCABo3Bjc6PZFNrpE1Io2nGmPT2uJh7B1GbN0Dy
         gcVfIpT3HUtdr/TQrbvRFzec64JY7Cibct4wr3tzdYDz3iY0UjwNDLqOgMmk5Ml/KG6K
         PWGT2nb916hph/VLu7GMHTpgyUCqC4GeqLJFUE4BvPNyZRPxMa3PyVzwGljD6hBIg/PQ
         EmKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290983; x=1793895783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        b=vl6h3FxTysc9yet6D3Q0d2GO8gweert+j49hx6iOwi7wFPNTUWfuBL7fsyyfVvnyvZ
         +Z1/kzcfRHuriJXExOiQjIZH32FZIEYk36Du+K2Qp+xNd/zW+Vw7+cZ+3sHCdKppJ5o8
         eatU0GNm4EFgoeUQ+hg+aufwcL0fsR0bxtDwsqwYPSmTHeXFmK4DaWOmC6SqnWgBoZ3w
         PCxuGBUd4CKVgczgjA3vYepQkhpbhYZnVWmJ7nhg0H7W7tE5tOgms8p4YL8rZwXyG2iI
         Zc2yNh+LlvzPXc6XiXnDpdY/AAXfxq39EqGeUq5qFxEMHK/EKYejffUV2/LJ4wO5JK9I
         JZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290983; x=1793895783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        b=tFTzkkJV+B7Tw787+nucRY3s9/rVrBqVUl2Pfurm/4WH88FoJbDjFQ4VetR7THIv2s
         xjGmuKSqDXox5VUJ9sZ+uA+LJPaJ+0w4J1J++pYKa+9vei8BuQDOaI06Bgg7raa7Jsio
         5D00hyvMYbrgSj+DEl1FdP8S5seBoiyrfa/X3mc54gcXPyUV/1aX8YPH6MDviv0fH153
         9MbVajAVlRpjULvYiHPzCJo3fccQVKVp0Yg8mDL5bt4CY/ya2n2/t0gM42lKb9tXtNti
         97dd0FZ8cZYgudw2Yco4wENRm4k2zprZlTbQg9xBwcqrbMLG9YhL87SeRYzvUBKIb9ac
         j+FQ==
X-Gm-Message-State: AFq9FYKQE1afMHZV/0o84iB0a9PIJzZBncumyUYJJrc7HVwO4Ptp68Vu
	9hL2Y4iE52YdmguDWdoDPNslXvxwL5di4k76Zq+akYdQT8x8Vg4ftd2S/h9fTc8ExsUkpteACt/
	U+JHPlkuvZcnFSc/fTnCdYmBQWhmQ9SA=
X-Gm-Gg: AYBFou0cBNXNkofLOgaJq4x8zpuS2nPKmUWDhXni+nNWfQ8pg/YNHFk5wHNH/cc/oQ7
	pGssQMQehrITSTvip6JVWU8dFfH1JYj7M0tMK73im0OTlgEnTKzGc6P1PJVaJrMnxilXFDLUaeU
	ln2pMscGhZ51bn2bDk5nbqgSVVuJBF40fdpEAjqb+65rYryVnHJtGS59FYvFOdSZjIpY6aDVZuj
	2VwV9BVuFziI1IeK6vRx3lYvu/JAjT77fp81AoLB5zL2IXVBeygu5yTgzPt5WY/i6sUsrJK3YvV
	8PMzFUetzvXQBsiyiwMxr6nDQWQCtD8CZC8vT2ro7OSrmrKkyl01gJsxXl36YhhM4kY3Mlgl8V+
	/015yaLhp/e8tapyBp7ej3Kkdcu8twWg4Rtqkx0n7wGRqh9AL3pyrV3ChbR/zGvr+89yt6XO8Mm
	Uk20f12/PdLcjWGbdTl1h09gdaHcGPgvHqInC0QHSc/8AQnSjxC7DR26g=
X-Received: by 2002:a17:907:2d10:b0:c31:91f9:60b7 with SMTP id
 a640c23a62f3a-c49bdf43869mr561025466b.34.1793290982774; Thu, 29 Oct 2026
 09:23:02 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026154948.99408-1-leon.hwang@linux.dev> <20261026154948.99408-6-leon.hwang@linux.dev>
In-Reply-To: <20261026154948.99408-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 09:22:44 -0700
X-Gm-Features: AclHuK8UvOBWlBbj0vfMh3zLVN3mKm1giM1eECBMPqUpu-79pHcpcFNIaDEnC_I
Message-ID: <CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for bpf_link_create
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

On Mon, Oct 26, 2026 at 8:51=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Since the iter_info and iter_info_len in struct bpf_link_create_opts are
> legacy, reuse the slot of iter_info to place log_opts.
>
> When adding log_opts support for iter link_create in the future, we will
> move the iter_info and iter_info_len to the last union, see below. And,
> keep the backward compatibility meanwhile, that uses iter_info if
> iter_info_len is set.
>
> struct bpf_link_create_opts {
>         /* ... */
>         union {
>                 /* ... */
>                 strut {
>                         struct bpf_iter_link_info *info;
>                         __u32 len;
>                 } iter;
>         };
> };
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 20 +++++++++++++++++---
>  tools/lib/bpf/bpf.h |  5 ++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index aea534764dfe..38dcb31e8c0e 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, link_create)=
;
>         __u32 target_btf_id, iter_info_len, relative_id;
> +       union bpf_iter_link_info *iter_info =3D NULL;
> +       struct bpf_log_opts *log_opts =3D NULL;
>         int fd, err, relative_fd;
>         union bpf_attr attr;
>
> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>         iter_info_len =3D OPTS_GET(opts, iter_info_len, 0);
>         target_btf_id =3D OPTS_GET(opts, target_btf_id, 0);
>
> +       if (iter_info_len && attach_type !=3D BPF_TRACE_ITER)
> +               return libbpf_err(-EINVAL);
> +
> +       if (iter_info_len)
> +               iter_info =3D OPTS_GET(opts, iter_info, (void *)0);
> +       else
> +               log_opts =3D OPTS_GET(opts, log_opts, (void *)0);
> +
>         /* validate we don't have unexpected combinations of non-zero fie=
lds */
>         if (iter_info_len || target_btf_id) {
>                 if (iter_info_len && target_btf_id)
> @@ -824,7 +834,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>
>         switch (attach_type) {
>         case BPF_TRACE_ITER:
> -               attr.link_create.iter_info =3D ptr_to_u64(OPTS_GET(opts, =
iter_info, (void *)0));
> +               attr.link_create.iter_info =3D ptr_to_u64(iter_info);
>                 attr.link_create.iter_info_len =3D iter_info_len;
>                 break;
>         case BPF_PERF_EVENT:
> @@ -960,12 +970,12 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>                 break;
>         default:
> -               if (!OPTS_ZEROED(opts, flags))
> +               if (!OPTS_ZEROED(opts, iter_info_len))

semantically cleaner would be to use log_opts here instead of
iter_info_len, send in a follow up?

>                         return libbpf_err(-EINVAL);
>                 break;
>         }
>  proceed:
> -       fd =3D sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
> +       fd =3D __sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz, log_opts);
>         if (fd >=3D 0)
>                 return fd;
>         /* we'll get EINVAL if LINK_CREATE doesn't support attaching fent=
ry
> @@ -975,6 +985,10 @@ int bpf_link_create(int prog_fd, int target_fd,
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
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65..fe3b7fd8512b 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -422,7 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date l=
inux/bpf.h */
>  struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;
> -       union bpf_iter_link_info *iter_info;
> +       union {
> +               union bpf_iter_link_info *iter_info;
> +               struct bpf_log_opts *log_opts;
> +       };
>         __u32 iter_info_len;

in a follow up, let's add comment next to iter_info above and
iter_info_len here that these are deprecated and that iter.info and
iter.info_len should be used instead

applied series to bpf-next, thank you!


>         __u32 target_btf_id;
>         union {
> --
> 2.55.0
>
