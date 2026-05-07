Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215413F1676
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162421; cv=pass; b=s5HTKeRqMlVjUt2aJ4wNDjbw2jLeYCBEkIRKwyWkijfHHlhluEgXhIwM2Y6FY5eDCTKQH0xbpmwbO3+YpVmk+3dQdu3NTBBkeS/IThPBYhxz0Bm+xZXGL9WIgeilmzwPBJqW+kXEfYpqg3uUJY13vOXluhYHQFahIZbXPr0r8h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162421; c=relaxed/simple;
	bh=NgGwy3mvpYSRRM9A26ZTqpRGpZD7OTzkMeZ/hv3jjxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrKtS/kNcB+b7t3B15KBknI6tX+wpDP3uRljmWFnqCQPaonoCEqKx9ijeoX1r5r5W13zuUhuB16oEyVl1YkcVZTBZmUZvQe+phFiMZNN7YdBkpuve8oVpyvfMq+CCEruN9wwH2qjHWGmjvbnjWGlvgnzWTBZDFaDg2T5TzU8EOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9tkqTth; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9tkqTth"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bdc947aaa3so8658467b3.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 07:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778162419; cv=none;
        d=google.com; s=arc-20240605;
        b=l1euwS3S3PfBs9GcZ/z1y1Du4ZRJ1kOHWeUo3Am2zKVZfMCHzv2pswstaNeI6WQwSP
         IdVffzNffTGmIiD9oxQaNcZQMjTs00yIJk3Gy4zrUkMU2wSJmTES40o0H+De1ujB1SZ5
         ISHVaUYSlMvHt14wjQCqXBkg7lPEl3ZRGFgRkCb+CnyjPyX0mVqx5Y7Xjs87Lm9iVCuz
         6a9ahrScQDkYNcJ3YeZJBkyRDXzr0ekF/nCuCUMG8Oi+M9h1zsri691F3QSd0UwJsTqK
         beXKXts4Dsi30uAgUtiqal5lpDMdx92d02p8EIRVJL840k/wU8w7EzHf68CgeMBipj6F
         Xq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSsxCu2EY6wL+/Ao8fB+kQaDgEegPK7yyR61GQYrcEs=;
        fh=5mCRHD7yY6n/vA3GSlVjpBXcJpcJK8xnOCdaITnxSFc=;
        b=N2QaiGQBDjUL4W2gwYnAm9NZgWpOq7ShfHmzjIwiFanWWMN0k14TFtaMLxytXTlS65
         HD+Xf0BmHc7ITpeDEt86Oy91gHoi+7LylrIjpVEtDSNcNv8Po0IrIzO+3f+RiFMJJEWb
         XE0Su2FeJ17/k/c73+exMZgxA4Vx2aBzqIYHrl5WwFEolFVtqcofrWOVfkfAXGYHRSn/
         VR5sOk89iTWahjyLHvdgg4uGcD2OgzJXWnCdnQ5+NLmAvCjPswqSZbxwgmnS01Z2D3OD
         a/Fgv2eEYrFORES0QiHxXa3k8GTGa/MBVV7GnjwUbwDQGsuWeHlJ+Fr12s3unG1tebtd
         ewhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778162419; x=1778767219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSsxCu2EY6wL+/Ao8fB+kQaDgEegPK7yyR61GQYrcEs=;
        b=i9tkqTthqkVVMPBkzsDx468/hZMkanrJYXBSNvcBZRwEZ4t8NWJTvdWhSZPS8r3dh6
         uBh9bN3GZRnaK1F21m1E8hRtTvavxz9GuFFNlxKJqqO4ir3OgTw5fjySwbLNuPlhLFdj
         iYrLComHaUNO/SjOm64R2XpW+ON458HzDpmG2/dV8QKeFJoR36OWyw2tbis3s/06JDVY
         5Z6cN8mMAqnI5TgbHEgYhKubKm0SuCo1LfOo9DWRGhhZsHYDkllut4nia9xfjzb79BJD
         U2D/Pafo+1jdRYfUZrlLhH1wYpJWNp/DJ0qhUiGVqdtMDp+Wy8mP2CKv667V56oCJ7ji
         APGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162419; x=1778767219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSsxCu2EY6wL+/Ao8fB+kQaDgEegPK7yyR61GQYrcEs=;
        b=jNVPxgcaigf+rn2CSNEJXdbQ8n4l5A5Quhh3XhwjlA0SE63tvEBqQMyblKGCn7JFeF
         O8muLKvW+SNN/cQJLb31YfZoCI56ZtrBwydFA7++FgCj/S9CTJUV1s1e056vZVGU5RvG
         0YXBiV4SwXszG3dIl1GR8DdEk5PaToPpu8ldkbx+6mmE6eJ58FiPGfj6Xxa1FTO/T6o5
         9k0lRMWO/UB5WJTAPhC/1O1xvj5+j7gGOvYaWCkKffe3rGdaHBHzYZGQTZdYa98WxxXj
         lwmK3P+iH5T1K5ITnKcqgvjaoomy2jV4F8YVMoYVzN/3NadWcDD3Mc0m2NNhDfKxdvzS
         rnUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S6A7NJ1y4MdtVp9SkwVeOaBPIttbkDuW0U7SqewIpX15hh5ql4sXITSJ9hNZXxUfXrRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwogMUfaAmupo0NxXfvU2jnclCsdHOCw3PXkuOQ1T6OUqxMmzH
	yj+LAKnK1jXX3sVmZPWGD5UW64p9EFxyE4ySqAR03H8nGDBA5OTgsQPKlNaCvWWudb10SVQMMuX
	UXhGMaaGSfZmRodnbAYsljDMRh2dsRL0=
X-Gm-Gg: Acq92OEDi9TM4BaDPJRn0Lu2GKl013NOmaaft8bbET4y0iuIr3UUS5oZaHM31PHu/Po
	xS+jcgNG4Qeb66t0Y2qj6oQWbmOAeBqRLxQzwpDbcnQipS/dybOV8XOjIIr846x43iNIda9S5Ks
	xkw5a5SqENvKIBgRTvtOyhzd2DmLFXlZTNEAw/Ge5d1vym1xFW0ylnUUnmlCaZsskTtUMB3EVmk
	majfbM8qoO/SYFrYqgE+g3R0S+fSA1AzBElTEgvdT+9akraWZ37BItmx1Bmou4pD2mG6cUB/n6K
	fJpqwFHbE9vC1OKlapw=
X-Received: by 2002:a05:690c:c50e:b0:7ba:f712:95a9 with SMTP id
 00721157ae682-7bdf5d8a740mr94370707b3.7.1778162418679; Thu, 07 May 2026
 07:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507113915.24988-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260507113915.24988-1-ihor.solodrai@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 16:00:07 +0200
X-Gm-Features: AVHnY4ISNy24-iZSFwl_uSDPkk8xcu7BAIxgdc4aViXxXvye4B5odFDzdfxJgAg
Message-ID: <CAMB2axNSNraaEFN-N3Rz5CoApMRStcV4eqyaA33NH7QyUFDx0w@mail.gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Use both hrtimer enqueue helpers in
 vmlinux test
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Thomas Gleixner <tglx@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 12:43=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> The vmlinux selftest triggers nanosleep and checks that both kprobe
> and fentry programs observe the hrtimer enqueue path.
>
> After the hrtimer_start_expires_user() conversion [1], nanosleep
> reaches hrtimer_start_range_ns_user() instead of
> hrtimer_start_range_ns(). Hard-coding either symbol makes the test
> fail either on bpf tree or on linux-next [2].
>
> Keep both hook variants as optional BPF programs and enable the pair
> matching the running kernel before loading the object. This is also a
> nice example of how to modify a BPF program to work on both older and
> newer kernel revision.

Nice. Can you further use bpf_program__set_attach_target() to avoid
duplicating the program as an example?

>
> [1] https://lore.kernel.org/all/20260408114952.062400833@kernel.org/
> [2] https://github.com/kernel-patches/bpf/actions/runs/25485909958/job/74=
782902203
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/vmlinux.c        | 26 +++++++++++++++++--
>  .../selftests/bpf/progs/test_vmlinux.c        | 22 ++++++++++++++--
>  2 files changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/tes=
ting/selftests/bpf/prog_tests/vmlinux.c
> index 6fb2217d940b..286feff31488 100644
> --- a/tools/testing/selftests/bpf/prog_tests/vmlinux.c
> +++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
> @@ -14,15 +14,37 @@ static void nsleep()
>         (void)syscall(__NR_nanosleep, &ts, NULL);
>  }
>
> +static void enable_hrtimer_progs(struct test_vmlinux *skel)
> +{
> +       bool has_user_helper;
> +
> +       has_user_helper =3D libbpf_find_vmlinux_btf_id("hrtimer_start_ran=
ge_ns_user",
> +                                                   BPF_TRACE_FENTRY) > 0=
;
> +       if (has_user_helper) {
> +               bpf_program__set_autoload(skel->progs.handle__kprobe_user=
, true);
> +               bpf_program__set_autoload(skel->progs.handle__fentry_user=
, true);
> +       } else {
> +               bpf_program__set_autoload(skel->progs.handle__kprobe, tru=
e);
> +               bpf_program__set_autoload(skel->progs.handle__fentry, tru=
e);
> +       }
> +}
> +
>  void test_vmlinux(void)
>  {
>         int err;
>         struct test_vmlinux* skel;
>         struct test_vmlinux__bss *bss;
>
> -       skel =3D test_vmlinux__open_and_load();
> -       if (!ASSERT_OK_PTR(skel, "test_vmlinux__open_and_load"))
> +       skel =3D test_vmlinux__open();
> +       if (!ASSERT_OK_PTR(skel, "test_vmlinux__open"))
>                 return;
> +
> +       enable_hrtimer_progs(skel);
> +
> +       err =3D test_vmlinux__load(skel);
> +       if (!ASSERT_OK(err, "test_vmlinux__load"))
> +               goto cleanup;
> +
>         bss =3D skel->bss;
>
>         err =3D test_vmlinux__attach(skel);
> diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/tes=
ting/selftests/bpf/progs/test_vmlinux.c
> index 78b23934d9f8..c90f7ac63f91 100644
> --- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
> +++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
> @@ -69,7 +69,7 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long=
 id)
>         return 0;
>  }
>
> -SEC("kprobe/hrtimer_start_range_ns")
> +SEC("?kprobe/hrtimer_start_range_ns")
>  int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 d=
elta_ns,
>                const enum hrtimer_mode mode)
>  {
> @@ -78,7 +78,7 @@ int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, k=
time_t tim, u64 delta_ns,
>         return 0;
>  }
>
> -SEC("fentry/hrtimer_start_range_ns")
> +SEC("?fentry/hrtimer_start_range_ns")
>  int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 del=
ta_ns,
>              const enum hrtimer_mode mode)
>  {
> @@ -87,4 +87,22 @@ int BPF_PROG(handle__fentry, struct hrtimer *timer, kt=
ime_t tim, u64 delta_ns,
>         return 0;
>  }
>
> +SEC("?kprobe/hrtimer_start_range_ns_user")
> +int BPF_KPROBE(handle__kprobe_user, struct hrtimer *timer, ktime_t tim,
> +              u64 delta_ns, const enum hrtimer_mode mode)
> +{
> +       if (tim =3D=3D MY_TV_NSEC)
> +               kprobe_called =3D true;
> +       return 0;
> +}
> +
> +SEC("?fentry/hrtimer_start_range_ns_user")
> +int BPF_PROG(handle__fentry_user, struct hrtimer *timer, ktime_t tim,
> +            u64 delta_ns, const enum hrtimer_mode mode)
> +{
> +       if (tim =3D=3D MY_TV_NSEC)
> +               fentry_called =3D true;
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.54.0
>
>
