Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7B392C32
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270219; cv=pass; b=aGGASMmjwk0axIVpU83QgIFm7GKDA28yYifj4BWjaNxO8+yIkYxj53SvLnWLIIbGjzQn3WtNMiQbVVjR1ri9jufKXvUlY5wvJgftunCeWlDY89O1LJPirXPrhES0JsgHAQX+wG27L0511druBgmDA+xoMVh0zPSwab1OFSb46nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270219; c=relaxed/simple;
	bh=jmsj5oKoQm/LmO5LlH+nHdu46F2DpGaY7QVmpGcp8os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOdrpqQKd74UxcsaQfwb5xAi7sx8O020YTF6/gHZgJsB9rQ4zUuIDmnh/DwUw7tvXCNSpwM8WQSH9qVPvBYnqD6a99mfZ1uu6w1E9X5pJyaUD+JoSaTahYoLVmtaDkSfY7YA+dChklQbdivwrmgyTaYLIhDG+HdDPOEA3EzD+OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axOpFUqz; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axOpFUqz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3597b474cbdso193156a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270217; cv=none;
        d=google.com; s=arc-20240605;
        b=D6UyMswPJuaV0TbvyRfIC7YvSn5BQPDiLNShUzKq/8K9negzaOLwG/0gDZgpWoVrAd
         Ex0KOPgPhc3ARN+9TigMNEU/5T/s+TdnAdcjcHt1IuQM/coqxgLCg4BAtm0n32fYv1or
         bciXlT2A2Ud29qwOcnknLpr+nbXvAeIEbusM/HNb5jENBhLdkpLpyIAQclBUJZ6judPw
         1CIDrlcd6E9dIsctydGAXx/O28FN8WEVQNtQXwgl8Za/B+K3OojTg8HKSgnhI/a1RgDK
         syEHxXS0RdNVRElbvyPQOsdw7hFDw6GEjr/avniynZydsilgjtNFc25ylnrT26Fmbeu2
         i01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=paqxgkSP/FXrDx4Kj+HG/1n4vaxw+qhNMUAyokZv/QQ=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=CP73I8ANe/fa7zqVdQ5U3+Y9kGV/cpTPnwjmhEbs0eLbu49KQPiHZgUbYhYwqLq+1p
         KFAMA6jZGmsGVWVHDahEEhhdWqPBnkqq8IzvCbyX2IFnt6WeXoZXoF53mYMlN7A9EJiL
         Id0PrbsOwN8NKUoOUMtxEuJ/4KIX58dRTR1pUKPo9HlTROFu3SDg6pU8bKmHCGuJCqRf
         3xxnRx5tWtUE/vFSjUTDTZ83P3cUdnOdVP5mp8Mwlc2MRlLVjyeNXFP11FKnrWbork4r
         7GTnHwyIjxV0A0hudYmfHt+7s3ILOa/sMcME6+4jbpXA7XkjX1P2BQ8Hp3l8fvnU4xl6
         mc3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270217; x=1773875017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paqxgkSP/FXrDx4Kj+HG/1n4vaxw+qhNMUAyokZv/QQ=;
        b=axOpFUqzERnZUnQ1IKtyNi1uyEcyQTyF1NTdIMrXW2G854DX5wRySighUsV03wXYP6
         +m3hfelqfzrYpSDOZjUhCKY7BiIo4b1JGUbu7vy6G/OozZciXgMXaFcO/rg2YPj1xyNd
         RvSeG06Q8pa4Nl9g6D9Ypxa6g1FHQXbWiQ9Z5gygSUFrroQcC6SUNM2ceulnkrDh5tqg
         OYV15oIVz87l+UrE5XFiNZQZ3itNWYUprpDK/D6saAYNR3+uAqPI0m7nHSMEmrKBjOay
         rx3odv5kcqHjlfvEL6ZdSJgpb9AUaA4YjUo+rHo0TP256j2ftG6VsimIubfVKCRDSKwW
         /cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270217; x=1773875017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=paqxgkSP/FXrDx4Kj+HG/1n4vaxw+qhNMUAyokZv/QQ=;
        b=S6mofvmrMSINKZmlPIARdewORzKMaiTzhG/RQgQZI1a6znHOhLaEjqgBPMymI8pP4m
         apj3Kce1hQNTuUPZAWFlhF3r7ZEr+VEe6J54z6pQDTrmsHA1C03qB8qA+x/61nM2jW9J
         pyhConpHJMHq3UxEh1k4LTG/blGSkq7MiXZH2d7ZbYPjgajUHyJcAlIZx4alrjgvaaCZ
         ZUSqiWc+hXvkFjkiJntgJW90fzqTkrr0CoVUlOoDiFEu1bG36VmJi8c8Qr6qihiDq7+H
         slIiof+0+E4LLwbxkOf/yAYbnR0HZYEtaDmxaGsqzeTCYiPaUDmAuXUTMPd4CIR3Qsz4
         3W/Q==
X-Gm-Message-State: AOJu0YyLV58FNQvV4UzNDP/49gg57MsSmjZJhR1BqesMLoLsZbgLSAoJ
	Syu+1g1HwuuC+sOF2e7rudnHEHFyuqQLbbP6i+72TP91CxuKeyAB5KXq2hps72cSayhXgvZGtxo
	T8Cgsb4liYJXu9VavU/+LtRCxcK5tQbg=
X-Gm-Gg: ATEYQzwc1oLITIeV0zvQjIDreiJVmA4AGZcsoqxAXmdIzupQWnH1LQqJ/s9MSZgHfrS
	EeoSBRnmlMZJwAFUXb4Pm1H9jYj5vzDUdYLtMylU3n8ExwN4F8Tg/tB1LaYQyDzUpUa7hs9fuiA
	EAm2KLlM6yPR+vSVuk5KS1fuEnbzbhlFlXGOzFtxAudXfupqhIFR6Q5STK7kLgbjKzborYIMZPS
	/Tky8/PD9WgM2spz0V431ZwtUy+E+O7gA76L39gaQ6WtdIYthwKt8nPVtPyDXdFWKmktow6JHxW
	NxTE94DXUJ60Ayqs9A==
X-Received: by 2002:a17:90b:48d0:b0:359:8312:90a2 with SMTP id
 98e67ed59e1d1-35a01263bc5mr3837978a91.11.1773270217034; Wed, 11 Mar 2026
 16:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com> <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 16:03:24 -0700
X-Gm-Features: AaiRm52GiyqfSLUaSPasKc0PYVvgz6CWqHaqzoDBgohMVnMwBBfljrTfpqxldH8
Message-ID: <CAEf4Bza1sRe6mxM5ktWyCALnjJDDpX3d8AGaO4NOcAkmwA_fAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 11:18=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_program__clone() API that loads a single BPF program from a
> prepared BPF object into the kernel, returning a file descriptor owned
> by the caller.
>
> After bpf_object__prepare(), callers can use bpf_program__clone() to
> load individual programs with custom bpf_prog_load_opts, instead of
> loading all programs at once via bpf_object__load(). Non-zero fields in
> opts override the defaults derived from the program and object
> internals; passing NULL opts populates everything automatically.
>
> Internally, bpf_program__clone() resolves BTF-based attach targets
> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> func/line info, fd_array, license, and kern_version from the
> prepared object before calling bpf_prog_load().
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 82 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..4b084bda3f47 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf_=
program *prog)
>         return prog->line_info_cnt;
>  }
>
> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_l=
oad_opts *opts)
> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, attr);
> +       struct bpf_prog_load_opts *pattr =3D &attr;
> +       struct bpf_object *obj;
> +       int err, fd;
> +
> +       if (!prog)
> +               return libbpf_err(-EINVAL);
> +
> +       if (!OPTS_VALID(opts, bpf_prog_load_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       obj =3D prog->obj;
> +       if (obj->state < OBJ_PREPARED)
> +               return libbpf_err(-EINVAL);
> +
> +       /* Copy caller opts, fall back to prog/object defaults */
> +       OPTS_SET(pattr, expected_attach_type,
> +                OPTS_GET(opts, expected_attach_type, 0) ?: prog->expecte=
d_attach_type);

OPTS_GET(opts, expected_attach_type, prog->expected_attach_type)

and same almost everywhere else

> +       OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?=
: prog->attach_btf_id);
> +       OPTS_SET(pattr, attach_btf_obj_fd,
> +                OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf=
_obj_fd);
> +       OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0)=
 ?: prog->attach_prog_fd);
> +       OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog=
->prog_flags);
> +       OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: =
prog->prog_ifindex);
> +       OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: =
obj->kern_version);
> +       OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->=
fd_array);
> +       OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->tok=
en_fd);
> +       if (attr.token_fd)
> +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> +
> +       /* BTF func/line info */
> +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> +               OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, =
0) ?: btf__fd(obj->btf));
> +               OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL=
) ?: prog->func_info);
> +               OPTS_SET(pattr, func_info_cnt,
> +                        OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_i=
nfo_cnt);
> +               OPTS_SET(pattr, func_info_rec_size,
> +                        OPTS_GET(opts, func_info_rec_size, 0) ?: prog->f=
unc_info_rec_size);
> +               OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL=
) ?: prog->line_info);
> +               OPTS_SET(pattr, line_info_cnt,
> +                        OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_i=
nfo_cnt);
> +               OPTS_SET(pattr, line_info_rec_size,
> +                        OPTS_GET(opts, line_info_rec_size, 0) ?: prog->l=
ine_info_rec_size);
> +       }
> +
> +       OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
> +       OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
> +       OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));

as discussed offline, we shouldn't use OPTS_SET(), we control pattr
size and layout, OPTS_SET doesn't contribute anything here and should
only be used for writing into user-provided opts structs.

> +
> +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +               err =3D prog->sec_def->prog_prepare_load_fn(prog, pattr, =
prog->sec_def->cookie);
> +               if (err)
> +                       return libbpf_err(err);
> +       }
> +

[...]
