Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAD35979
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750855; cv=pass; b=GGOiqj4o3CCYrcvF1hRnhrN2U8JKe2AJ8eMz28UbDUBaZfEy7bVTTzwwuMAnQDxt7uVkKxJJqXzileOatZSgzYe3qFiO6MQETT9ETBH3yRVDsgxWXa5gltsSptu4ublLnSkAvFuzH/1zEH49fNbP83KSE8mwQnQEpOCyrjWD1S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750855; c=relaxed/simple;
	bh=1azYrEinK8y6tJDZ3QaIL2eau2ZUr1wIXFaYsJnaHzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHvTgjqEki01+Phhx+IYOOLYObOzKnqDVwMKFTRvMgtZ2y0BOCNtTY1ToF2yehBpQagJ/r1ACVQAr6Mil8GEUtZ3iod73aR+cm8Hc5Dz23PIrRMeNBZj8FoGRK4pUBYp2z18IIxOrparFco2adi+WnMfXkcBe9D8rc8LFbDHFsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1B9u/b5; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1B9u/b5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adff872068so41836295ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 14:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772750853; cv=none;
        d=google.com; s=arc-20240605;
        b=cEcb6KqX6h7lQf4iqyR1sh/Bcbip6KAXcuTXtTJhroNXCwoKZEry/gsC597zI5lpvI
         Krznxp5Fd4thGulhct9sqKXZaNbaMoBXH12ahuZaJT6MHpB3jui4GjPF+N7dcnv0j00E
         zMn8fkq40yiNW0fXrw/DVlO4+mdhY0hH0VczguxFZkvL1FNDIEsG9yyE6c4fEDMeN3BK
         NluuO5xiiIEq+Co4EBMkHqynuXluof+b8VXXnAaxDiR+30uzR/gA/0j8zW0AmJdvKlGE
         exwEixQbJ8VsGS3lrxWwK9PqkylFPrOOQxBK4t3StBAw3QQOu0zl6tvmlLNSDFe0nC8o
         L2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mS6eetn+UXkNvPmb2Ye/BOYFe3wgG6nAg5d6k0FtGpI=;
        fh=nQy42juJAtOd+ZZJVn9EZi5KSLdCBMcThKSvGZVlprQ=;
        b=KxyQ6XQVHGNoPNvkfcJ8npbfAkl4SQfW/WagT7rP64O4gBVG9aNh30Fa0waXGEu2nV
         gyHPGWLUzrZ75pZN4Mh3KeNwyJNoja6Tfgfc1SUOrsnCocTCKWJ+mCmKfV4lLW5szHDq
         rcNugKP7/2kLQLR3PBU2dwo39eFSeIuSfuJ6EX+I7j3SPL8yOsiVifjC1YJD4khPQNOX
         ov3C4pT00xybH4VE23o4WpQtMUkiIUNCadD2z3XY8gJO6CUWzCOQDNEsVp5D9+zP4lNW
         qOXb2do1ELm/x+iKl7or3GB81c2yEpCYuyesr95AKRBzBce9Ozwj1PZhG77Ij8a9DOJq
         efyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750853; x=1773355653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS6eetn+UXkNvPmb2Ye/BOYFe3wgG6nAg5d6k0FtGpI=;
        b=d1B9u/b51PD4FjmUpWK+O99lrCFrW4WHYIcA+dB9NZWiX9g5ZG9vXGyPEO3tFKF0m+
         n0qnvAJjqr9f5XUKoa7hpVPftd4M/rmuiOEof0zd5sK/MjoDXritq95I+uqdceKuFIU6
         Q5Y3of8OV4iv34PcMbfAhinZMUv5D05gzxqFuRsbO3YIS/dhq8VuVCqqQ2SqWI2tlgTb
         NZQw3LMaOb0U+iIVRkfCMtJJURJsZ7mh3kVuEJNCgollnwh9qMDkGKOVcoaSUW8SuLqn
         FVJbAJnbLpovOAjOpnFpFxQfMfG9YjJazy8oWRbziVDPZH967zhgZPXmjBpLYCBHiejZ
         xOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750853; x=1773355653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mS6eetn+UXkNvPmb2Ye/BOYFe3wgG6nAg5d6k0FtGpI=;
        b=snSzgo6/jiCvr1Mjn+FGLCF8tICq2KlWne1/EcVCuzl6tWI+QCMfHWqx8oDVPgZ266
         Kg32AfLbrZeUtizNvja/gReEikna8w2dSTQwHzREG9onmuxrzKjwIC3KMIWvlhlsgWsK
         dqmOPIvpHoX5RCY+TbZNQ8IYhTpv1F8A2Xr2tsebPNzvrxUGx4eboXKpADfJMdTT31UW
         5IUAHCxAac6bizgWIpm0bTDasSanIq7JCNnooxzPfHGcQs67/7RdPOOlu9vswGdAXA8m
         c3Yqic+XZ8L7TXZcqwxFlJwUsJgqSHE6i0XWlkijHRuJhCveeXdnzhnfkhiKhadJptsK
         N4RA==
X-Gm-Message-State: AOJu0YwHip8FuhnOxdJ3AUC8qz8ZUIWAYY9euuvYH7AwycQ5BpxdbPve
	HkXRTi5nscUpCXYGz1zd+Hh+m1qY10HvQSIsBriUAs6B4V3IXawanOv6mNYiC8UCI2P8FFf2L9E
	qKCcjtCowDyDl3lalAENh4hH5iuRGQCs=
X-Gm-Gg: ATEYQzzd70rtrMa9D8M1RbAzlexU0UO0sVJvdg0E3xYan938T4qKZL8bDuf46p96Mdi
	o4QKVK3hL9NPhtIiK2YiSyCPZU0m3jJrkWlTmcbNz4MtVZhzi4tK5zUEDB8lPjC7ccKw+GlTJ39
	bu6opAKsYDROjtwRpkBhJhyakWV0VMQexo/UeH8TnWeAVKbRvFSWEZUBs6cMg0llYa2s9rBcdyC
	pEbKbzGI6VIbBqf2DB/L9wT0pSwookivdkU0EgtQ8tD4nY3+8ZGvmPzTUI87gggpgQghtKh8bCh
	LFR/LNMZOiPL5ehNKNy49P8=
X-Received: by 2002:a17:903:1aa4:b0:2ae:606b:bd87 with SMTP id
 d9443c01a7336-2ae82431070mr1634765ad.28.1772750853320; Thu, 05 Mar 2026
 14:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com> <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Mar 2026 14:47:19 -0800
X-Gm-Features: AaiRm53NFCurSKO2ebO94yVwmcP9xEamBu8pRxlOGLbMf9o82R9IqVM4y9ncf8U
Message-ID: <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate kprobe symbols
 in attach_kprobe_opts
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 1:05=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> When a kernel module exports a symbol with the same name as an existing
> vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
> fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
> tracefs path).

If the same symbol name resolves to multiple addresses, that's an
ambiguity that libbpf has no business resolving. It should be on user
to resolve and use attachment by address, which libbpf supports
through bpf_kprobe_opts or multi-kprobe opts.

pw-bot: cr


>
> Implement a fallback mechanism that, on such failures, resolves the
> vmlinux address through /proc/kallsyms - filtering out module symbols -
> and retries probe attachment using the absolute address, bypassing
> kernel symbol name validation.
>
> Changes:
> - Restructure libbpf_kallsyms_parse() to accept a bool skip_if_module
>   parameter that filters module symbols before invoking the callback.
> - Add find_kaddr_cb() callback and find_kaddr_ctx struct to resolve
>   vmlinux text symbol addresses from /proc/kallsyms.
> - Detect duplicate symbol errors (-EADDRNOTAVAIL for perf_event_open,
>   -EINVAL for legacy tracefs) and retry with resolved KADDR.
> - Fix NULL pointer in gen_probe_legacy_event_name() when using absolute
>   address by passing func_name instead of optional_func_name.
> - Fix NULL pointer in pr_warn() calls within
>   perf_event_kprobe_open_legacy() by using ternary fallback.
> - Fix memory leak of legacy_probe buffer on retry path.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 155 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 137 insertions(+), 18 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..e725e3c98ee2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8460,9 +8460,11 @@ static int bpf_object__sanitize_maps(struct bpf_ob=
ject *obj)
>  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
>                              const char *sym_name, void *ctx);
>
> -static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
> +static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx,
> +                               bool skip_if_module)
>  {
>         char sym_type, sym_name[500];
> +       char module_name[128];
>         unsigned long long sym_addr;
>         int ret, err =3D 0;
>         FILE *f;
> @@ -8475,21 +8477,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb=
, void *ctx)
>         }
>
>         while (true) {
> -               ret =3D fscanf(f, "%llx %c %499s%*[^\n]\n",
> -                            &sym_addr, &sym_type, sym_name);
> -               if (ret =3D=3D EOF && feof(f))
> +               int n =3D 0;
> +
> +               /*
> +                * Format tries to match both vmlinux and module kallsyms
> +                * entries in one call. Module entries have the form:
> +                *   addr type name [module]
> +                * %n fires only if the closing ']' literal is matched.
> +                */
> +               ret =3D fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] %n=
",
> +                            &sym_addr, &sym_type, sym_name, module_name,=
 &n);
> +
> +               /* EOF or malformed line - handle after the loop */
> +               if (ret !=3D 3 && ret !=3D 4)
>                         break;
> -               if (ret !=3D 3) {
> -                       pr_warn("failed to read kallsyms entry: %d\n", re=
t);
> -                       err =3D -EINVAL;
> +
> +               /* ret =3D=3D 4 && n =3D=3D 0: scanset matched but ']' di=
dn't */
> +               if (ret =3D=3D 4 && n =3D=3D 0)
>                         break;
> -               }
> +
> +               if (ret =3D=3D 4 && skip_if_module)
> +                       continue;
>
>                 err =3D cb(sym_addr, sym_type, sym_name, ctx);
>                 if (err)
>                         break;
>         }
>
> +       /* !err: don't overwrite callback errors with -EINVAL */
> +       if (!feof(f) && !err) {
> +               pr_warn("failed to read kallsyms entry: ret=3D%d\n", ret)=
;
> +               err =3D -EINVAL;
> +       }
> +
>         fclose(f);
>         return err;
>  }
> @@ -8529,7 +8549,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
>
>  static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>  {
> -       return libbpf_kallsyms_parse(kallsyms_cb, obj);
> +       return libbpf_kallsyms_parse(kallsyms_cb, obj, false);
>  }
>
>  static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_nam=
e,
> @@ -11527,10 +11547,20 @@ static void gen_probe_legacy_event_name(char *b=
uf, size_t buf_sz,
>  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe=
,
>                                    const char *kfunc_name, size_t offset)
>  {
> -       return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx=
",
> -                             retprobe ? 'r' : 'p',
> -                             retprobe ? "kretprobes" : "kprobes",
> -                             probe_name, kfunc_name, offset);
> +       /* When kfunc_name is NULL, use absolute address format (0xADDR),
> +        * otherwise use symbol+offset format (SYMBOL+0xOFF)
> +        */
> +       if (kfunc_name) {
> +               return append_to_file(tracefs_kprobe_events(), "%c:%s/%s =
%s+0x%zx",
> +                                     retprobe ? 'r' : 'p',
> +                                     retprobe ? "kretprobes" : "kprobes"=
,
> +                                     probe_name, kfunc_name, offset);
> +       } else {
> +               return append_to_file(tracefs_kprobe_events(), "%c:%s/%s =
0x%zx",
> +                                     retprobe ? 'r' : 'p',
> +                                     retprobe ? "kretprobes" : "kprobes"=
,
> +                                     probe_name, offset);
> +       }
>  }
>
>  static int remove_kprobe_event_legacy(const char *probe_name, bool retpr=
obe)
> @@ -11559,7 +11589,7 @@ static int perf_event_kprobe_open_legacy(const ch=
ar *probe_name, bool retprobe,
>         err =3D add_kprobe_event_legacy(probe_name, retprobe, kfunc_name,=
 offset);
>         if (err < 0) {
>                 pr_warn("failed to add legacy kprobe event for '%s+0x%zx'=
: %s\n",
> -                       kfunc_name, offset,
> +                       kfunc_name ? kfunc_name : "(abs_addr)", offset,
>                         errstr(err));
>                 return err;
>         }
> @@ -11567,7 +11597,7 @@ static int perf_event_kprobe_open_legacy(const ch=
ar *probe_name, bool retprobe,
>         if (type < 0) {
>                 err =3D type;
>                 pr_warn("failed to determine legacy kprobe event id for '=
%s+0x%zx': %s\n",
> -                       kfunc_name, offset,
> +                       kfunc_name ? kfunc_name : "(abs_addr)", offset,
>                         errstr(err));
>                 goto err_clean_legacy;
>         }
> @@ -11651,6 +11681,44 @@ int probe_kern_syscall_wrapper(int token_fd)
>         }
>  }
>
> +/* Context structure for finding vmlinux kernel symbol address */
> +struct find_kaddr_ctx {
> +       const char *func_name;
> +       unsigned long long kaddr;
> +};
> +
> +/* Callback to find vmlinux kernel text symbol address */
> +static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
> +                        const char *sym_name, void *ctx)
> +{
> +       struct find_kaddr_ctx *data =3D ctx;
> +
> +       /* Only match text section symbols ('T' or 't') */
> +       if (toupper(sym_type) !=3D 'T')
> +               return 0;
> +
> +       /* Check if this is the symbol we're looking for */
> +       if (strcmp(sym_name, data->func_name) =3D=3D 0) {
> +
> +               /*
> +                * If we already have an address, we've encountered a
> +                * duplicate symbol name. Reject such symbols to avoid
> +                * ambiguous resolution.
> +                */
> +               if (data->kaddr && data->kaddr !=3D sym_addr) {
> +                       pr_warn("kernel symbol '%s': resolution is ambigu=
ous: 0x%llx or 0x%llx\n",
> +                       sym_name, data->kaddr, sym_addr);
> +                       return -EINVAL;
> +               }
> +
> +               data->kaddr =3D sym_addr;
> +               pr_debug("found kernel symbol %s at address 0x%llx\n",
> +                        sym_name, data->kaddr);
> +       }
> +
> +       return 0;
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>                                 const char *func_name,
> @@ -11663,6 +11731,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>         size_t offset;
>         bool retprobe, legacy;
>         int pfd, err;
> +       const char *optional_func_name =3D func_name;
> +       struct find_kaddr_ctx kaddr_ctx =3D { .kaddr =3D 0 };
>
>         if (!OPTS_VALID(opts, bpf_kprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
> @@ -11693,9 +11763,10 @@ bpf_program__attach_kprobe_opts(const struct bpf=
_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>         }
>
> +retry_create:
>         if (!legacy) {
>                 pfd =3D perf_event_open_probe(false /* uprobe */, retprob=
e,
> -                                           func_name, offset,
> +                                           optional_func_name, offset,
>                                             -1 /* pid */, 0 /* ref_ctr_of=
f */);
>         } else {
>                 char probe_name[MAX_EVENT_NAME_LEN];
> @@ -11707,7 +11778,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>                 if (!legacy_probe)
>                         return libbpf_err_ptr(-ENOMEM);
>
> -               pfd =3D perf_event_kprobe_open_legacy(legacy_probe, retpr=
obe, func_name,
> +               pfd =3D perf_event_kprobe_open_legacy(legacy_probe, retpr=
obe, optional_func_name,
>                                                     offset, -1 /* pid */)=
;
>         }
>         if (pfd < 0) {
> @@ -11716,6 +11787,54 @@ bpf_program__attach_kprobe_opts(const struct bpf=
_program *prog,
>                         prog->name, retprobe ? "kretprobe" : "kprobe",
>                         func_name, offset,
>                         errstr(err));
> +
> +               /*
> +                * If attachment fails with EADDRNOTAVAIL (or EINVAL in
> +                * legacy mode) and we used non-NULL func_name, try to
> +                * find function address in /proc/kallsyms and retry
> +                * using KADDR instead of ambiguous symbol. Legacy
> +                * tracefs API converts EADDRNOTAVAIL to EINVAL, so
> +                * we need to check for both.
> +                */
> +               if ((err =3D=3D -EADDRNOTAVAIL || (legacy && err =3D=3D -=
EINVAL)) && optional_func_name) {
> +                       pr_debug("kallsyms lookup for %s\n",
> +                                func_name);
> +
> +                       kaddr_ctx.func_name =3D func_name;
> +                       kaddr_ctx.kaddr =3D 0;
> +
> +                       /*
> +                        * Drop the function symbol and add the resolved
> +                        * KADDR to the offset.
> +                        * This avoids kallsyms validation for duplicate
> +                        * symbols in the kernel. See attr.config2 in
> +                        * perf_event_open_probe and kernel code in
> +                        * perf_kprobe_init/create_local_trace_kprobe.
> +                        */
> +                       optional_func_name =3D NULL;
> +
> +                       err =3D libbpf_kallsyms_parse(find_kaddr_cb, &kad=
dr_ctx, true);
> +                       if (err) {
> +                               pr_warn("failed to get addr for %s\n",
> +                                       func_name);
> +                               goto err_out;
> +                       }
> +
> +                       if (kaddr_ctx.kaddr) {
> +                               pr_debug("retrying %s using kaddr 0x%llx\=
n",
> +                                        func_name, kaddr_ctx.kaddr);
> +
> +                               offset +=3D kaddr_ctx.kaddr;
> +                               free(legacy_probe);
> +                               legacy_probe =3D NULL;
> +                               goto retry_create;
> +                       }
> +
> +                       pr_warn("symbol '%s' not found in vmlinux\n",
> +                               func_name);
> +                       err =3D -ENOENT;
> +               }
> +
>                 goto err_out;
>         }
>         link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts)=
;
> @@ -11931,7 +12050,7 @@ static int libbpf_available_kallsyms_parse(struct=
 kprobe_multi_resolve *res)
>         data.syms =3D syms;
>         data.res =3D res;
>         data.cnt =3D cnt;
> -       libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
> +       libbpf_kallsyms_parse(avail_kallsyms_cb, &data, false);
>
>         if (res->cnt =3D=3D 0)
>                 err =3D -ENOENT;
> --
> 2.34.1
>
