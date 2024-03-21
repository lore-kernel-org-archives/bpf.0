Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14A133998
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058058; cv=none; b=mR7UEP2C37g4eAoYqisnr1/do8Mxjq58jhb3mmP0zWdfgTVTuWxtKiIL/LF9s6S3ccnvTOmUpGMaBfTa27dySAwENwB6VFrhjtcZk5i0Aywp/ZHnsDXHnbWJdiwCEasc3K+cfdpDpsRASvDkys0FlycnyHXyxaqUyV8XMWaXEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058058; c=relaxed/simple;
	bh=P0QXRcbYNrOZZQoNeQMQTfhaWovBIb04/1790P72g4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDBc1Z2/3sqQp98sakmMdJ0vP5rOuLfKa5dq4wGhWIe3j39nJOXe6LnxRDsRYhzh6ikuVAH/gh05t49clUZJfATp3TOQbqdZMqmxOr9L9SGcGtmrKyLnXq2vmzjl8jxCL0aaVQyH+KAfXfzm6vP88/CYdeZNFwqfj0mA86CweX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAcKLEy7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAcKLEy7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-414776775d3so5143295e9.3
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711058055; x=1711662855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2gGZaykEWbHPvvJhrVGXXh43k/Ke4nXzWR1IIwz3L4=;
        b=YAcKLEy7uN2TRuwLMbks1VG+aAuMGtotMHLxxDaiX78X1bVdftF9BzydIXWqhU4diB
         lI+5o4AMnO3mm4c+rWX6cY6jN1ZLUEPPxf4cod3P0hV9robWYoYC14dme7pSt4moJ8YQ
         J9tdWdDGiz7JDPjsy//vtfHqhXdVCwdWDXZZ4BrctoScOVdJNfT7EpBaJRDYbr0WKC2J
         aYwMHeox9HmlxCo9nXoqmmPKNRuNf/Hjo2VYoyAUK+hsDS2RHjEpClDNoz/RyDn8WlkZ
         VlB9MRET3186AwxAUujCMvqk64ifiVd44Qqwh81T49eawoTRmHEvSUvlpaGyR0ph/jFA
         A6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058055; x=1711662855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2gGZaykEWbHPvvJhrVGXXh43k/Ke4nXzWR1IIwz3L4=;
        b=NSVLcqIjG2fHCcyCQ+9acGBP5B/fQXqGqcmKCiSMAiXGWTKZkrC40QdSBG9glbjmEN
         7CrF2FN6SiG6SWK4B+RtaZhgOkL3OwHRoAQN7aSluH0yw+Cvn6yKARUM9YAkHSCbaMoR
         Ly1phBQd8/byHPtsrooJzpzF6AMP46N/toVFdxmkFkSNT8lQv9NgOpRt+j8Xzo8xBIZA
         n0AkJZhC3O10iHFINmDEIWujtag6OCgsCOYtdjvljQ131w5qTbprrV+S6RDeDlYBcqcN
         xf2OP8Xrbz4FT06P+Nusw/7W5k36EBM2/rcR2FwQcWzfLSIYA5MAw6eGL0HXhM5l72HX
         5O0Q==
X-Gm-Message-State: AOJu0YzYgX1zk+khOrF2fPJIcbBWoajb1v0xhFQ7aSq4p35mCbxR0TmV
	ImPFNOM3yoIdvj0VgYw63AUK6wPjDeZwIXR5p8sRZkXFq+9Np/xfrxiI8/H4FkNl0SDSVqiyJ6r
	nI0wRNCaDYEW2OnfInSNOYgIOO50=
X-Google-Smtp-Source: AGHT+IHxw1muFPh1JD1zuOqPw904hfjcRO9d4xxjm4v26eY12c7HmXX/9wuXxWCN1CURDdhsGIAdkFh6WoFvvPpVJRo=
X-Received: by 2002:a05:600c:4f56:b0:414:a49:1327 with SMTP id
 m22-20020a05600c4f5600b004140a491327mr261577wmq.8.1711058054995; Thu, 21 Mar
 2024 14:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev> <20240321200114.2219721-1-yonghong.song@linux.dev>
In-Reply-To: <20240321200114.2219721-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 14:54:03 -0700
Message-ID: <CAADnVQL3yAnS4+A59OBmpbhEhQx7Was-EnTcLW9k4ddnXQi31w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Handle <orig_name>.llvm.<hash>
 symbol properly
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:01=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With CONFIG_LTO_CLANG_THIN enabled, with some of previous
> version of kernel code base ([1]), I hit the following
> error:
>    test_ksyms:PASS:kallsyms_fopen 0 nsec
>    test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>    #118     ksyms:FAIL
>
> The reason is that 'bpf_link_fops' is renamed to
>    bpf_link_fops.llvm.8325593422554671469
> Due to cross-file inlining, the static variable 'bpf_link_fops'
> in syscall.c is used by a function in another file. To avoid
> potential duplicated names, the llvm added suffix
> '.llvm.<hash>' ([2]) to 'bpf_link_fops' variable.
> Such renaming caused a problem in libbpf if 'bpf_link_fops'
> is used in bpf prog as a ksym as 'bpf_link_fops' does not
> match any symbol in /proc/kallsyms.
>
> To fix this issue, libbpf needs to understand that suffix '.llvm.<hash>'
> is caused by clang lto kernel and to process such symbols properly.
>
> With latest bpf-next code base built with CONFIG_LTO_CLANG_THIN,
> I cannot reproduce the above failure any more. But such an issue
> could happen with other symbols.
>
> For example, with my current kernel, I got the following from
> /proc/kallsyms:
>   ffffffff84782154 d __func__.net_ratelimit.llvm.6135436931166841955
>   ffffffff85f0a500 d tk_core.llvm.726630847145216431
>   ffffffff85fdb960 d __fs_reclaim_map.llvm.10487989720912350772
>   ffffffff864c7300 d fake_dst_ops.llvm.54750082607048300
>
> I could not easily create a selftest to test newly-added
> libbpf functionality with a static C test since I do not know
> which symbol is cross-file inlined. But based on my particular kernel,
> the following test change can run successfully.
>
>   diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/tes=
ting/selftests/bpf/prog_tests/ksyms.c
>   index 6a86d1f07800..904a103f7b1d 100644
>   --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
>   +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>   @@ -42,6 +42,7 @@ void test_ksyms(void)
>           ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_f=
ops");
>           ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
>           ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
>   +       ASSERT_NEQ(data->out__fake_dst_ops, 0, "fake_dst_ops");
>           ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_=
cpu_start");
>
>    cleanup:
>   diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/tes=
ting/selftests/bpf/progs/test_ksyms.c
>   index 6c9cbb5a3bdf..fe91eef54b66 100644
>   --- a/tools/testing/selftests/bpf/progs/test_ksyms.c
>   +++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
>   @@ -9,11 +9,13 @@ __u64 out__bpf_link_fops =3D -1;
>    __u64 out__bpf_link_fops1 =3D -1;
>    __u64 out__btf_size =3D -1;
>    __u64 out__per_cpu_start =3D -1;
>   +__u64 out__fake_dst_ops =3D -1;
>
>    extern const void bpf_link_fops __ksym;
>    extern const void __start_BTF __ksym;
>    extern const void __stop_BTF __ksym;
>    extern const void __per_cpu_start __ksym;
>   +extern const void fake_dst_ops __ksym;
>    /* non-existing symbol, weak, default to zero */
>    extern const void bpf_link_fops1 __ksym __weak;
>
>   @@ -23,6 +25,7 @@ int handler(const void *ctx)
>           out__bpf_link_fops =3D (__u64)&bpf_link_fops;
>           out__btf_size =3D (__u64)(&__stop_BTF - &__start_BTF);
>           out__per_cpu_start =3D (__u64)&__per_cpu_start;
>   +       out__fake_dst_ops =3D (__u64)&fake_dst_ops;
>
>           out__bpf_link_fops1 =3D (__u64)&bpf_link_fops1;
>
> This patch fixed the issue in libbpf such that if clang lto kernel
> is enabled and the symbol resolution is for ksym's,
> the suffix '.llvm.<hash>' will be ignored during comparison of
> bpf prog ksym vs. symbols in /proc/kallsyms, this resolved the issue.
>
> Note that currently kernel does not support gcc build with lto.
>
>   [1] https://lore.kernel.org/bpf/20240302165017.1627295-1-yonghong.song@=
linux.dev/
>   [2] https://github.com/llvm/llvm-project/blob/release/18.x/llvm/include=
/llvm/IR/ModuleSummaryIndex.h#L1714-L1719
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 64 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a7a89269148c..8c3861192bc8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -664,6 +664,7 @@ struct bpf_object {
>         bool loaded;
>         bool has_subcalls;
>         bool has_rodata;
> +       bool need_kallsyms;
>
>         struct bpf_gen *gen_loader;
>
> @@ -8016,14 +8017,73 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb=
, void *ctx)
>         return err;
>  }
>
> +static int check_lto_kernel(void)
> +{
> +       static int check_lto =3D 2;
> +       char buf[PATH_MAX];
> +       struct utsname uts;
> +       gzFile file;
> +       int len;
> +
> +       if (check_lto !=3D 2)
> +               return check_lto;
> +
> +       uname(&uts);
> +       len =3D snprintf(buf, PATH_MAX, "/boot/config-%s", uts.release);
> +       if (len < 0) {
> +               check_lto =3D -EINVAL;
> +               goto out;
> +       } else if (len >=3D PATH_MAX) {
> +               check_lto =3D -ENAMETOOLONG;
> +               goto out;
> +       }
> +
> +       /* gzopen also accepts uncompressed files. */
> +       file =3D gzopen(buf, "re");
> +       if (!file)
> +               file =3D gzopen("/proc/config.gz", "re");
> +
> +       if (!file) {
> +               check_lto =3D -ENOENT;
> +               goto out;
> +       }
> +
> +       check_lto =3D 0;
> +       while (gzgets(file, buf, sizeof(buf))) {
> +               /* buf also contains '\n', skip it during comparison. */
> +               if (!strncmp(buf, "CONFIG_LTO_CLANG=3Dy", 18)) {
> +                       check_lto =3D 1;
> +                       break;
> +               }
> +       }
> +
> +       gzclose(file);
> +out:
> +       return check_lto;
> +}
> +
>  static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
>                        const char *sym_name, void *ctx)
>  {
> +       int lto_enabled =3D check_lto_kernel();
> +       char orig_name[PATH_MAX], *res;
>         struct bpf_object *obj =3D ctx;
>         const struct btf_type *t;
>         struct extern_desc *ext;
>
> -       ext =3D find_extern_by_name(obj, sym_name);
> +       /* Only check static variables in data sections */
> +       if (sym_type =3D=3D 'd' && obj->need_kallsyms && lto_enabled =3D=
=3D 1) {

why bother grepping config.gz ?
I see no harm in doing below strstr unconditionally.

> +               strcpy(orig_name, sym_name);
> +               res =3D strstr(orig_name, ".llvm.");
> +               if (res) {
> +                       *res =3D '\0';
> +                       pr_debug("extern (ksym) '%s': use original name '=
%s' for comparison\n",
> +                                sym_name, orig_name);
> +               }
> +               ext =3D find_extern_by_name(obj, orig_name);
> +       } else {
> +               ext =3D find_extern_by_name(obj, sym_name);
> +       }
>         if (!ext || ext->type !=3D EXT_KSYM)
>                 return 0;
>
> @@ -8322,7 +8382,9 @@ static int bpf_object__resolve_externs(struct bpf_o=
bject *obj,
>                         return -EINVAL;
>         }
>         if (need_kallsyms) {
> +               obj->need_kallsyms =3D true;
>                 err =3D bpf_object__read_kallsyms_file(obj);
> +               obj->need_kallsyms =3D false;
>                 if (err)
>                         return -EINVAL;
>         }
> --
> 2.43.0
>
