Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210113A9D82
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998329; cv=pass; b=YmB3whsNlKnjol2e3DYjTxPFtohnGy4qpjqp26HKV8nQqt1T6FBq+s7ngxPhKmtxbcSo2q24CrcsywvMjdqzi87ctX76tfmm9SYP0hcy4HW7CjrgRc7P/cSDWLh4AEXtW9qH5IzZZDeSoibRmRqohYEDdcDcU/zD3cOxzxgQGKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998329; c=relaxed/simple;
	bh=ZRBwVsvWBGXOq+iTHCWqU+jdlHSTlRyRad0MwMeHrsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZaGOLTn84b27G/iRP2xPKdI2x3LaFeRt1pChn4Ca0ZSB++2Hfcl96T0JrG3sa6k1utllntCANq0ZFVkHWjK4juTkmb8NuBhX096JB90xll2GSISQjUebopIgQRFTf054m/T7SG+jUfcGPJY48lSs8CMqlRuHEdpxyA68upn6xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROxYsrh8; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROxYsrh8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2040712a91.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774998327; cv=none;
        d=google.com; s=arc-20240605;
        b=NjY1vbdjYM8DQEuQDf8LPSf3Tb41cLuPoe4fBcU737LkW5/sshXTmuIEb82yY/oLhV
         DkGCDImMVw0VqV5ZWwP0XQynGddiRqFavrOOfS7JuJLWuW3Kr/BFqVwrF7MWcsPSnnDh
         kig9YPk+8nFgrZ0lRtDVAlGY8IOKMjjI9B18v10jzleha0Gcdtxqi4T6dzbLjdNYw5za
         MZCufy5R5eCFBCJe3IVZY5GmqVI2TjGEqzGPRNh9gfIA9TrOtq+KMG0tCUMDrEDu3fQ2
         1vDwwlfmsKsoYA6IXBJ6fj6uqkqyPsJ9ovR3lkLBwkXXdvzz/zDz7yotPmyrhGLVmvFF
         B+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f3T3MWARWKqErIQsg+XxtK4/lTcCCgWEPLRVpEoVfeE=;
        fh=POP0ydDNFUne3HyOYVevlhtaIL75qTZjfSeEOeP+aa0=;
        b=ZsTpBhMMEnxvcfJWStoWVR0qJ8Sb1JLoZEKSBCw2tlAaHnKsiKFu0nl3PgFVIbHcfL
         p6ZDKDEjHKDzrTiskxMcJEXGErqJz1I3dgmuVjxcaUJGYk97wFhb/0M1HZvEiN2TAbKS
         B70Wvj71LTwnC6RdjSLWhjL4zxxhzzJXdT627LQ8ZHJCAfZ1YyCoGR3OuQRwS5V/Ot0E
         +XEgqcOzPxbzxAbkzfPxsegnlS/CBlnHDsUydJ2gvPwsjMWVDqPfBwQtwA4VmEFMWgLD
         CtBsGPuxqGMbzCgp6ZlUg/AsVN0bfeEquR6acELf6Qlzw6Aqr1r3Mm4p9uhGlKXswDb7
         p3Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998327; x=1775603127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3T3MWARWKqErIQsg+XxtK4/lTcCCgWEPLRVpEoVfeE=;
        b=ROxYsrh8331gfNCAROsriYe92mf+ocsRtX0dJHMcIvXz9f98xfwFt4AFeeCYqjRVu9
         sUAfqH/hJseeU3pSB6DPQ8suQgutSAah0VcqMVc0CR8LkxsdaeDBzEgCOtyFUV3eKkAS
         Za8axVJDD9O9Z2z4+XCKwf+tT4apB+97HA8C3n19T4v5ImusIY7qeGDgK4D089Xuww2D
         MYjAWXeoOnsj2sWCj1J9xZWXQMnvsJOoNPkmI2fX4WAWQz4Q96R5HgRXz5PM3kFtinhU
         Ts5CaMckEDLPpGdGwo0NvoHTQu4YVaulsshQXdUXPQvHttEG23F5Uyj5avAtJ6wsCz9N
         mNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998327; x=1775603127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3T3MWARWKqErIQsg+XxtK4/lTcCCgWEPLRVpEoVfeE=;
        b=nec0lZFM07ghpxJqV21ceB6WMVcXzaZEt45cX0JNR57zqwPwHzYJpkvhShNWdfksId
         PuursJcIXWx5yrkhdvmHboJmrsgWtJUnfxjTFQezE5zbQplJ4yeAGFzluZMhDB6bZ/1E
         TfTULMkz4q50rB418gP1wjWkGyFi13lIpI0VzPiEGfFfS5MfiJ7QW6zuL5J7xPahErqq
         eZELZ2PzyGY2Z+N6xlO9SS4GauaVafGnMo+lbwGjmX0PPgJpX5r+2oqeEHVo+9V9eWRH
         IuzNdrNppavI68M3u98MAyGJxvPSrZT0V9EDOChZV6tlwE4P8ts7eT6RFTfQtKPqhgoP
         T0dQ==
X-Gm-Message-State: AOJu0YwZo1XYF7DdcC/0zRTEliwxVVKilQZhWGxGweJkTk7W9mghRoJg
	voDMD4P45JJOvY76CD+mQOfGI7W/LbjrFbMsvzLbbyIYUrJcIAT1L8sS289ZcoXreZIn4/NsmWN
	Am76b/hzhxuMd+jr1ZNDOUXMdkwdwn3s=
X-Gm-Gg: ATEYQzwDXVYkjmQYe+791q0y+mOIIaycHpVMpNRjk6JAE3ms68GkOr8K6jnbNMdi625
	ZBrBSpy9iZpfcdcqPFI192gemBP3NjYUzePFnwSRiLG4VboUI8rx5fBo0xIRnEhNPmIHGVCKVMR
	Uy1KK3ya5RwB72mWv/pf58bZ8sJ5VqMJepvNdFaWcZJ4fdTDibLt3bQQbogRKb5tAyA0r897ejN
	w0UxqwNU4QrI/pbeGT+0WlZn8ahPpnhN8WqtOCW9mD2QUtNeUVOaNQIrJHD6UtWHnmQC4ppF2Mz
	UxPyVKPM16Xt/aK7HtRjNVo=
X-Received: by 2002:a17:90b:224b:b0:35d:997c:8ec0 with SMTP id
 98e67ed59e1d1-35dc6f5fe01mr1072369a91.18.1774998327494; Tue, 31 Mar 2026
 16:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331152509.70468-1-hoyeon.lee@suse.com> <20260331152509.70468-2-hoyeon.lee@suse.com>
In-Reply-To: <20260331152509.70468-2-hoyeon.lee@suse.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 16:05:14 -0700
X-Gm-Features: AQROBzAAL-X_ypOSNrpdw3OWyXYdZVHuS5aWcVM2vwD7QchOby05JqtBjChZK7M
Message-ID: <CAEf4BzZGJ5A1t5GcU3kt_gK6uK2-mzqNvtuR9AMzpiyrgEvrUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: clarify raw-address single kprobe
 attach behavior
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:25=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> bpf_program__attach_kprobe_opts() documents single-kprobe attach
> through func_name, with an optional offset. For the PMU-based
> non-legacy path, func_name =3D NULL with an absolute address in offset
> already works as well, but that is not described in the API.
>
> This commit clarifies this existing non-legacy behavior. For PMU-based
> attach, callers can use func_name =3D NULL with an absolute address in
> offset as the raw-address form. For legacy tracefs/debugfs kprobes,
> reject this form explicitly.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  tools/lib/bpf/libbpf.c | 21 ++++++++++++---------
>  tools/lib/bpf/libbpf.h |  3 ++-
>  2 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..9083f542a3b0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11523,7 +11523,8 @@ static int determine_uprobe_retprobe_bit(void)
>  #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
>
>  static int perf_event_open_probe(bool uprobe, bool retprobe, const char =
*name,
> -                                uint64_t offset, int pid, size_t ref_ctr=
_off)
> +                                uint64_t offset_or_addr, int pid,

don't rename it, keep it as "offset"

> +                                size_t ref_ctr_off)
>  {
>         const size_t attr_sz =3D sizeof(struct perf_event_attr);
>         struct perf_event_attr attr;
> @@ -11558,7 +11559,7 @@ static int perf_event_open_probe(bool uprobe, boo=
l retprobe, const char *name,
>         attr.type =3D type;
>         attr.config |=3D (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET=
_SHIFT;
>         attr.config1 =3D ptr_to_u64(name); /* kprobe_func or uprobe_path =
*/
> -       attr.config2 =3D offset;           /* kprobe_addr or probe_offset=
 */
> +       attr.config2 =3D offset_or_addr;   /* kprobe_addr or probe_offset=
 */
>
>         /* pid filter is meaningful only for uprobes */
>         pfd =3D syscall(__NR_perf_event_open, &attr,
> @@ -11816,6 +11817,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>         default:
>                 return libbpf_err_ptr(-EINVAL);
>         }
> +       if (!func_name && legacy)
> +               return libbpf_err_ptr(-ENOTSUP);

-EOPNOTSUPP

pw-bot: cr

>
>         if (!legacy) {
>                 pfd =3D perf_event_open_probe(false /* uprobe */, retprob=
e,
> @@ -11835,21 +11838,21 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
>                                                     offset, -1 /* pid */)=
;
>         }
>         if (pfd < 0) {
> -               err =3D -errno;
> -               pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf e=
vent: %s\n",
> +               err =3D pfd;
> +               pr_warn("prog '%s': failed to create %s '%s%s0x%zx' perf =
event: %s\n",
>                         prog->name, retprobe ? "kretprobe" : "kprobe",
> -                       func_name, offset,
> -                       errstr(err));
> +                       func_name ?: "", func_name ? "+" : "",
> +                       offset, errstr(err));
>                 goto err_out;
>         }
>         link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts)=
;
>         err =3D libbpf_get_error(link);
>         if (err) {
>                 close(pfd);
> -               pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s=
\n",
> +               pr_warn("prog '%s': failed to attach to %s '%s%s0x%zx': %=
s\n",
>                         prog->name, retprobe ? "kretprobe" : "kprobe",
> -                       func_name, offset,
> -                       errstr(err));
> +                       func_name ?: "", func_name ? "+" : "",
> +                       offset, errstr(err));
>                 goto err_clean_legacy;
>         }
>         if (legacy) {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0be34852350f..f75f3ab0f20c 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -557,7 +557,7 @@ struct bpf_kprobe_opts {
>         size_t sz;
>         /* custom user-provided value fetchable through bpf_get_attach_co=
okie() */
>         __u64 bpf_cookie;
> -       /* function's offset to install kprobe to */
> +       /* function offset, or raw address if func_name =3D=3D NULL (non-=
legacy) */

legacy mode will be useful on very-very old kernels only, let's not
distract with constant mentions for "non-legacy", please remove
"(non-legacy)" here and other legacy mentions above


but also, while you are at it, let's add a proper doc comment to
bpf_program__attach_kprobe and bpf_program__attach_kprobe_opts APIs?
That seems like a more obvious place to explain name+offset and offset
as absolute address behavior, IMO

>         size_t offset;
>         /* kprobe is return probe */
>         bool retprobe;
> @@ -565,6 +565,7 @@ struct bpf_kprobe_opts {
>         enum probe_attach_mode attach_mode;
>         size_t :0;
>  };
> +
>  #define bpf_kprobe_opts__last_field attach_mode
>
>  LIBBPF_API struct bpf_link *
> --
> 2.52.0
>
