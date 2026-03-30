Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCD3BB48
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914405; cv=pass; b=mEGmA1viQadteC4DaqKAnbT+x80GGP3RpUaXR37ORyqJhLitYWDrO7oItEEbHgpbYbQdcxukAMCpss8rKxmTy6ptzWW+UCCi8bS4D5uyPCKLqCQ5Hoxg4mJVEyj6YLuJ35QiFs5ZznqmnB9VOBfIopndm+ibV/Q8a+JarZikykg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914405; c=relaxed/simple;
	bh=y3PpL15g3dDmoiG6yCSQbhX+COXSuw50MpsHP09kdbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6JM+6UWsNDuQgpR7qAKYsiLjXOhqLV2bL7ZNP0GzoPwVazDoPb2Ghpm2sAJck5X2owAZK74FHaD7S876rVKSEv9XE4339/zCfZ8jlmht08hdP9s+6tO5Fva+Nd9Ba3hIEyLmJTYNwisnC5OGpzTpxLFqrnw2kYHtL6hC9UNxAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEVagPms; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEVagPms"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c766a95a72dso3277330a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774914403; cv=none;
        d=google.com; s=arc-20240605;
        b=c6QJQx9pAjTgTebefjljl149d5p9bXhsPaRg0DCWCRZys9MHzbN14BYeCAtB36jbQY
         Hd2OU8XSQOwkwaY4Lj+j+gg1wiOhlPD+FAv/rTXMP9SAmqw/SyUJxsKk1jD2wwk4ZqCE
         D0M+nlMoasDNbVOxoYc/NWG63HSNBwlkZ85/fPa+wX9A3sKdNlMirYBrfitABPRZOuGR
         sB+SlNeAEd7y47F/VYAA919UyHP5Cy8lQrnRl0oEKIz4KWLGXNBTxRNmQ+Me6Kh3jsYn
         4xur1zHnAWDIpQ77yzz/UqlJGwIbfs772M1m9fLlYoYNTPGwB9Tdt8ELT1WfifaziF9g
         smPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FHVUhJQq8m7SEx+y6i/6ANk2A2z3JCf04DCLMufazM=;
        fh=7Jb35+oq4UWQtjw/uXhMBPPTRMbe/LyoPELKcHXevv0=;
        b=astfmPih0ZOYI6BV3Mtgy+/XxuGq2UAqadb24yWhub1vQvtfVuMI5Q9+ITgxl6v63/
         JCsmFN2/a3NXuRx/wOxtXqCi7VYj5vOARwAI3lcSFWe1yUQEyFDgMyxMqQQI1elVjnhU
         q+MVeeXOLXnyPnF7pBjrRmXy3fJOl813rtldcw1V1EHb8CN+Ms3R0Rh53+n3qlorovMA
         U1ooNRzM7qnk6A5Vz2OpjVcjfMgRwpRI/eRTgmc0Fu3AORElLGFUTvCiPmlg1UHsrN1F
         jhKVNpGwGsdFP2Rl0t8l3YLmxn6Pa/7r7HHqbeimA/cH37fZrzj9bcKsGUkBg+mr/ad2
         G5Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774914403; x=1775519203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FHVUhJQq8m7SEx+y6i/6ANk2A2z3JCf04DCLMufazM=;
        b=KEVagPms1puUYSb+hLp1w8TvkuobtREcBMXXgGsVY91ANhVGJq/69vlK5eAdnQmydg
         70phoawtRp0WiSmVEvLGmbGotDs6HNJ5aMWIGQW1484qF7IDVaMHd2M/PM5tC0MEYOgP
         mP+5nvGAlqvu71TqQjolhJQ4KDRgT0QlEVDj1U6Q5mKaZf4E1lzhDfxaPbPC/eIqmd1M
         0HpcwriFLU44naQNCxcLxmyU7FMPHRGkKdXXQ4jviY8/Wf80MB2eEqqylMBUJi/mjxEH
         OF58In6pwF0ZMCrnivqQ09LkCFIAix5bDEh18P0oixYuxbg8xQyf1TZB0/k7hIFFLyv1
         369A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774914403; x=1775519203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5FHVUhJQq8m7SEx+y6i/6ANk2A2z3JCf04DCLMufazM=;
        b=SFTSm0AjOj5HpqB8jZf8VJysM9x151WMMi5Cbuby7Yn1FujBb6CAqRrwfHtbgvwPSH
         RUK0NQxXlV9CJH4p6j0YDRC+z79U2QNhhrYYcU529GLVC81BX7QaT+OFU4tID7jiUbRT
         FveckKlxf+eP7Hj9dmAWECKAWaYtQYd/ntSfR/c/r7YmWSddMjiEog7qZsFrXtV27Zzh
         nInDn5N41ZvFrZmJ8kmyo7Iowvrf05vzpD0auyKUHw6oE6VyVvpO+WfAUX4zXf9QVksb
         hAaCQQQBPUUkXT/XyacvCrhI8tQVN5BNZZOdry+LFM/Ji9Fjp/XzPhYifIPASgulMDnC
         oqTg==
X-Gm-Message-State: AOJu0YxmoAczRR04yV7fyNzh60hDZ7ep3gG8T8mKDWvGqY/XsGT/MdPJ
	zaBiBtIm1ve9U19e90zmAyHXvwVjXR+GRZLg0aYb23aNPFR1hPu/G6qehWuWum7sOWtmcOxN095
	nHUbrKmN8kGezYQSfZDJARKNGzb6F2Ts=
X-Gm-Gg: ATEYQzzh+DolkrAQYwtZz69d0U2XBr69kl05dndUxIKKAsaEE16X63n8JVcaQqQ2kwU
	Eoaq/X8lfd/N2RRz7Nvaw3fMMD2FoNZeL1RbScjP1N+CN8vfwInWyiB66YArZ4NXB+MAO7CTBVG
	OjW0HaYRPY2gClfcDBWwaqJ0G9QlkOCPk4+e/zF4ixdcYPfxFKCfAUZ34MZKPtMlAJxDXpY1EDu
	yH0CgQucyfcEco6efhkJFOJaUZW5BhLcqlG7Rr6rwlLUttljMCcDfM/kt/ynqxudUAjrSU95qXw
	egGx3475nPL4yunNxGNPWCzrL/G9hdwd/A==
X-Received: by 2002:a05:6a20:2455:b0:39b:ba95:b127 with SMTP id
 adf61e73a8af0-39c877ea601mr14114772637.4.1774914403400; Mon, 30 Mar 2026
 16:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329212534.3270005-1-memxor@gmail.com> <20260329212534.3270005-4-memxor@gmail.com>
In-Reply-To: <20260329212534.3270005-4-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 16:46:31 -0700
X-Gm-Features: AQROBzBJQXDGhCaBs701YEA9DUTqIx2rCu4-eniXwjTjbb-fGX3lmfsFbvt4LUY
Message-ID: <CAEf4BzbkRVWauUvoB5nMsbARrt_G_+ohYVth_tp1vz7SdNNH1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] libbpf: Wire up verifier warning display logic
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 2:25=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Wire up the flushing of all accumulated messages in a program's stderr
> stream after verification is complete. An example is shown below of a
> warning printed now about usage of deprecated kfuncs.
>
> $ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl=
 -v
> ...
> libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': VERIFIER WARNINGS:
> WARNING: kfunc_implicit_args.c:40 calls deprecated kfunc bpf_kfunc_implic=
it_arg_legacy_impl(), which will be removed.
> WARNING: Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
> WARNING: For older kernels, choose the kfunc using bpf_ksym_exists(bpf_kf=
unc_implicit_arg_legacy).
> ...
>
> Note that test_progs overrides the default logging function, hence -v is
> necessary. By default these messages would be printed for the user.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..f308bacd083f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7826,6 +7826,27 @@ static int libbpf_prepare_prog_load(struct bpf_pro=
gram *prog,
>
>  static void fixup_verifier_log(struct bpf_program *prog, char *buf, size=
_t buf_sz);
>
> +static void bpf_object_load_prog_emit_stderr(struct bpf_program *prog, i=
nt prog_fd)
> +{
> +       char chunk[256];
> +       bool emitted =3D false;
> +       int ret;
> +
> +       while ((ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, =
chunk,
> +                                          sizeof(chunk), NULL)) > 0) {
> +               if (!emitted) {
> +                       pr_warn("prog '%s': VERIFIER WARNINGS:\n", prog->=
name);
> +                       emitted =3D true;
> +               }
> +               libbpf_print(LIBBPF_WARN, "%.*s", ret, chunk);
> +       }
> +
> +       if (ret < 0) {
> +               pr_debug("prog '%s': failed to read BPF stderr stream: %s=
\n",
> +                        prog->name, errstr(ret));

instead of potentially spamming debug logs with this, let's detect if
streams are supported and not even try to read warnings?

Also, why 256 byte buffer? 1-4KB isn't a big deal, it's user space

> +       }
> +}
> +
>  static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_progr=
am *prog,
>                                 struct bpf_insn *insns, int insns_cnt,
>                                 const char *license, __u32 kern_version, =
int *prog_fd)
> @@ -7950,6 +7971,8 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>                                  prog->name, log_buf);
>                 }
>
> +               bpf_object_load_prog_emit_stderr(prog, ret);

just inline this, we inline bind map logic, so why not this one?

> +
>                 if (obj->has_rodata && kernel_supports(obj, FEAT_PROG_BIN=
D_MAP)) {
>                         struct bpf_map *map;
>                         int i;
> --
> 2.52.0
>
