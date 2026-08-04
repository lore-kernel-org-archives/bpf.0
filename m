Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F173FB048
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883247; cv=pass; b=OKXBhhiAd7u5j39sKdTymX/cHpmbNKZMuQ510gjLfRob5I1Mf4ARIbVJipcT+gAuLFz/xFrgSr+3wtAwrRyvFciCONz/7e9tY/gaasGJDIi+aFLuYxSWvWgSkgC2oW2P/adbvViYStldPqZqNu3c/P95u7givlZrW8i/jhO5fIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883247; c=relaxed/simple;
	bh=8YO/c8nqXR/z3cbdTOZHDnL9LRiWh05yxnX47oK1Jpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taM4bL1sxo+gw8Io6YGMSMlUskqR8k9RZvoYPyQpWOaGZGJXg59zy/1lvba/NNzp3bF6AHEr3qM1BHmTHRXql9Ynz6aSJA9w9FCde6MBaIdAFR2M3tl7N2qrYFWKRfFEZauKyADrsnAOzJSl69zAuPJI2TW+TWdWhWcd6KED+8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy17d6iP; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy17d6iP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso513570b3a.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 15:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785883245; cv=none;
        d=google.com; s=arc-20260327;
        b=dkmC30E9RqcxHH/g7M5b7tNe6Fk0nBETiKuGil9zV/FZmDVplad8FOdlK5t061byjh
         JAGdBLiYjMM7WhsbMuSrHViVuPSddsKpuWGzVAVDJ+9DUNVX8qKWMk6mje2Bh0wlw9Uo
         Q9SY6urelOwBg8o3pkaLycM4Xmx9dnWYrRJpLRVOnj02Ys2Co6HNpRtMjATcglLxzU4q
         qDXTEchwipUPVgP0HGKoxoyt3IBdJQkm5h/d4poOltyOuCCcLHoIcm7tN++eZUG6OePT
         3tHIsi6IB/CzQQ2oT8bP/7E4u6Ej0gMRQiJSEIA1jAr84uYgaP0cwdNQTM0iohR/lwVa
         rgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e9rV8hoxYvRNAquc1eeEYTZTw7acz/uGtS0MUeE+pO0=;
        fh=WI2bs0s7wffm5h5jB1JdWpEdVAmZPQfDpeQVC2lyV+U=;
        b=NRKgdvJcT4BEOfxpKwidjWW4eMww61+IWPefiXN2/B0oL+gq31BSwUpSP8sTy0qZry
         vKLT16CGL1US0rt8uLO5ZJrMi2faquS0AppOGdrpvGj20k5oziClxHl2yTaIileN2UcL
         XjWidQAjwTvFb/n7V8icglmmyrDzC/IBtcllAdh4jDAtOOR+tk6vs7MH0qIwivSVPIaw
         /azSxy0MP6E0svQlu0Qm+SNbhoak2Xlr8Nx0N5JHOL0RJITjpDKNs8ArA2rABksfHhER
         NkcR8p3dZtc/Kz+GUn2VWcBIwb+/eMFE9/N28OIYoB5fVm3C4CSNNbH98tD8bTNaii9Z
         ZC1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785883245; x=1786488045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e9rV8hoxYvRNAquc1eeEYTZTw7acz/uGtS0MUeE+pO0=;
        b=Cy17d6iPeBjbteWIvjIQS1a/jnVwfnRYmUA1Ai/YLf4+kLvSuRZrAwiLAD6oN9OtO6
         2Xb3LxtzhTKiD5EycO2C00BMLpvG22TACQ4lmvn/kv/QkAEHGgsug7MZwE41nlGlFF/Z
         dSeMjeGC5ECJcsXdsULaOJK8wbIaEWstf1obi93IpJOM5YzwvItj8fCn8wKzdMr/YCVT
         3EtAAIf81sMkuEMdo4xUYrHrUOPKqWLzaUeqHAY6lReVpeFARV60FU9J88QbKOOgWCri
         7/dVdf9MB4SnKnAUGesOtXp3rnH6AbABVCgqno3u1T0mOEsTPMYBhMr4MJXmOtknzXeG
         eRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785883245; x=1786488045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9rV8hoxYvRNAquc1eeEYTZTw7acz/uGtS0MUeE+pO0=;
        b=J/fWmZ7YrsCpj8sVeEWT6Z/WCI/BigW4+53F4zOsEhD6Q8I01F1RLd9MaM6c8UzxDj
         yUWkwYbpMs1EElSotFJtv73S9rih1amzKOO/tqOSOdjUXGYSDPgtcaQzeGJp5tPuavNd
         7TFbBuPJX1LQndczVBq0BrEeBWrYEYehZhaR9YhpzIFNw58R+/bJcMMKuSf9/MmnQlUO
         x4CtvrvyV2SOmox7mMXvNoM5H2jTHWrd4WGSSvcYjhY1K1F1SK5NI9FEfrNk68ZfkbU4
         OS2gh/vgdtDGEK/SMM2YnaGbZJT07xkQ3xy64onuTBYE3Esf2QzO+z5xtmLRu28V/Jsq
         YvaQ==
X-Gm-Message-State: AOJu0Yx6ZRvyHpntmYv4sY4qTUDnrvHzIhOEP2G2NG6oX5RPosQpTXhG
	ajCD0kq+SwbGMJHMZn4QuATf574PV7ddHkaVoGG9lWNcY2vH5JKy/fqbxtsqvY3PNsEBslDVyZh
	brDyKRJWysSyg3AuMNjOTt3b7htLUh+g=
X-Gm-Gg: AR+sD10hSSE3eJo20B5WTfkTPfFdUdiHHoGOGFuwlSSN7IDv0jwQhr6ylkwWPz+auSs
	jFIIiS50oJQGILbbuBrfEpoIag86p5LkeQaAo3p00lGP/lC4p8RFBmv/pboYyfvh3jGseEJF7FZ
	VXisPcdj0PpsyQEdB21C9eprSXDug+O84Lr3n6LyliVhf8aW3ZqZoTn5GD/22ALnPRTp+puKdtd
	qMobhVQZCxrSKr0cdoXRMFed1IU1w9X1r08a6IpNUf+Q0UELhUzf4IOr8iRpkIgEixG/76G7N8Z
	rBthBIhJqBMWsi8TMxFud4379JKrgldMISQG+QqyA9aifmQY3UK0ncesMKxsLoU3QjJ6JKEYj6s
	zd3AKh+n59P2tEWW2EQnjCEMG4juRNUcepuorPNkYfg==
X-Received: by 2002:a05:6a00:1c8d:b0:847:888f:9b0f with SMTP id
 d2e1a72fcca58-84f2dc220c9mr2131689b3a.15.1785883244971; Tue, 04 Aug 2026
 15:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804154813.90795-1-leon.hwang@linux.dev>
In-Reply-To: <20260804154813.90795-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Aug 2026 15:40:30 -0700
X-Gm-Features: AUfX_myhoVq4YO88LDoYkSacczsNK0Irx0ywz4qGkQ7SfLeNMDImRJOqOMO5lKk
Message-ID: <CAEf4BzbJCB0KUZMkeRPfYSjMQ3Q3eoFKUZS3px1mBBhxtEqYdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Move tracing_multi_bench_attach
 to bench
To: Leon Hwang <leon.hwang@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> In CI, the tracing_multi_bench_attach test could cost >10s, which should
> be avoided in daily CI running.
>
>  ./test_progs -t tracing_multi_bench_attach -v
>  WATCHDOG: test case tracing_multi_bench_attach executes for 10 seconds..=
.
>  serial_test_tracing_multi_bench_attach: found 40163 functions
>  serial_test_tracing_multi_bench_attach: attached in   9.367s
>  serial_test_tracing_multi_bench_attach: detached in   1.798s
>  #546     tracing_multi_bench_attach:OK
>
> Since it is for benchmark attachment of tracing_multi link, move it to
> the generic bench framework.
>
>  ./bench tracing-multi-attach
>  Setting up benchmark 'tracing-multi-attach'...
>  tracing-multi-attach: found 40166 functions
>  tracing-multi-attach: attached in   9.278s
>  tracing-multi-attach: detached in   1.836s
>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |   2 +
>  .../bpf/benchs/bench_tracing_multi_attach.c   | 177 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 125 -------------
>  4 files changed, 181 insertions(+), 125 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_tracing_mult=
i_attach.c
>

Jiri, are you ok with not exercising this logic regularly?

but also hm, is 10 seconds expected?


> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 55d394438705..e4d8cbd51d71 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -966,6 +966,7 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.s=
kel.h \
>  $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
>  $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
>  $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
> +$(OUTPUT)/bench_tracing_multi_attach.o: $(OUTPUT)/tracing_multi_bench.sk=
el.h
>  $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_up=
date_bench.skel.h
>  $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
>  $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage=
_rcu_tasks_trace_bench.skel.h
> @@ -991,6 +992,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>                  $(OUTPUT)/bench_bloom_filter_map.o \
>                  $(OUTPUT)/bench_bpf_loop.o \
>                  $(OUTPUT)/bench_strncmp.o \
> +                $(OUTPUT)/bench_tracing_multi_attach.o \
>                  $(OUTPUT)/bench_bpf_hashmap_full_update.o \
>                  $(OUTPUT)/bench_local_storage.o \
>                  $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index 3d9d2cd7764b..5ce31459835c 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -545,6 +545,7 @@ extern const struct bench bench_trig_uprobe_multi_nop=
5;
>  extern const struct bench bench_trig_uretprobe_multi_nop5;
>  extern const struct bench bench_trig_usdt_nop;
>  extern const struct bench bench_trig_usdt_nop5;
> +extern const struct bench bench_tracing_multi_attach;
>  #endif
>
>  extern const struct bench bench_rb_libbpf;
> @@ -628,6 +629,7 @@ static const struct bench *benchs[] =3D {
>         &bench_trig_uretprobe_multi_nop5,
>         &bench_trig_usdt_nop,
>         &bench_trig_usdt_nop5,
> +       &bench_tracing_multi_attach,
>  #endif
>         /* ringbuf/perfbuf benchmarks */
>         &bench_rb_libbpf,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attac=
h.c b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c
> new file mode 100644
> index 000000000000..7389d1742ddc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <search.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <bpf/btf.h>
> +#include "bench.h"
> +#include "testing_helpers.h"
> +#include "trace_helpers.h"
> +#include "tracing_multi_bench.skel.h"
> +#include "bpf/libbpf_internal.h"
> +
> +static int compare(const void *ppa, const void *ppb)
> +{
> +       const char *pa =3D *(const char **)ppa;
> +       const char *pb =3D *(const char **)ppb;
> +
> +       return strcmp(pa, pb);
> +}
> +
> +static void tdestroy_free_nop(void *ptr)
> +{
> +}
> +
> +static void tracing_multi_attach_setup(void)
> +{
> +       LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +       struct tracing_multi_bench *skel =3D NULL;
> +       long attach_start_ns, attach_end_ns;
> +       long detach_start_ns, detach_end_ns;
> +       double attach_delta, detach_delta;
> +       struct bpf_link *link =3D NULL;
> +       size_t i, cap =3D 0, cnt =3D 0;
> +       struct ksyms *ksyms =3D NULL;
> +       void *root =3D NULL;
> +       void *dups =3D NULL;
> +       __u32 *ids =3D NULL;
> +       __u32 nr, type_id;
> +       struct btf *btf;
> +       int err;
> +
> +       setup_libbpf();
> +
> +       btf =3D btf__load_vmlinux_btf();
> +       err =3D libbpf_get_error(btf);
> +       if (err) {
> +               btf =3D NULL;
> +               fprintf(stderr, "failed to load vmlinux BTF: %s\n", strer=
ror(-err));
> +               goto cleanup;
> +       }
> +
> +       skel =3D tracing_multi_bench__open_and_load();
> +       err =3D libbpf_get_error(skel);
> +       if (!skel) {
> +               fprintf(stderr, "failed to open and load skeleton: %s\n",=
 strerror(-err));
> +               goto cleanup;
> +       }
> +
> +       err =3D bpf_get_ksyms(&ksyms, true);
> +       if (err) {
> +               fprintf(stderr, "failed to get kernel symbols: %s\n", str=
error(-err));
> +               goto cleanup;
> +       }
> +
> +       /* Get all ftrace 'safe' symbols.. */
> +       for (i =3D 0; i < ksyms->filtered_cnt; i++) {
> +               if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
> +                       err =3D -ENOMEM;
> +                       fprintf(stderr, "failed to index ftrace symbols\n=
");
> +                       goto cleanup;
> +               }
> +       }
> +
> +       /*
> +        * Collect names that are not unique in kallsyms. The kernel reso=
lves a
> +        * tracing-multi BTF id to an address with kallsyms_lookup_name()=
, which
> +        * returns the first symbol of that name. For a duplicate name th=
at may
> +        * be a different (non-ftrace-able) instance than the ftrace-able=
 one in
> +        * available_filter_functions, so attaching to it by BTF id fails=
 with
> +        * -ENOENT (e.g. t_start/t_next/t_stop). ksyms->syms is sorted by=
 name,
> +        * so equal names are adjacent.
> +        */
> +       for (i =3D 1; i < ksyms->sym_cnt; i++) {
> +               if (strcmp(ksyms->syms[i].name, ksyms->syms[i - 1].name))
> +                       continue;
> +               if (!tsearch(&ksyms->syms[i].name, &dups, compare)) {
> +                       err =3D -ENOMEM;
> +                       fprintf(stderr, "failed to index duplicate kernel=
 symbols\n");
> +                       goto cleanup;
> +               }
> +       }
> +
> +       /* ..and filter them through BTF and btf_type_is_traceable_func. =
*/
> +       nr =3D btf__type_cnt(btf);
> +       for (type_id =3D 1; type_id < nr; type_id++) {
> +               const struct btf_type *type;
> +               const char *str;
> +
> +               type =3D btf__type_by_id(btf, type_id);
> +               if (!type)
> +                       break;
> +
> +               if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)
> +                       continue;
> +
> +               str =3D btf__name_by_offset(btf, type->name_off);
> +               if (!str)
> +                       break;
> +
> +               if (!tfind(&str, &root, compare))
> +                       continue;
> +
> +               /* Skip names that are not unique in kallsyms, see above.=
 */
> +               if (tfind(&str, &dups, compare))
> +                       continue;
> +
> +               if (!btf_type_is_traceable_func(btf, type))
> +                       continue;
> +
> +               err =3D libbpf_ensure_mem((void **)&ids, &cap, sizeof(*id=
s), cnt + 1);
> +               if (err) {
> +                       fprintf(stderr, "failed to allocate BTF ID array:=
 %s\n",
> +                               strerror(-err));
> +                       goto cleanup;
> +               }
> +
> +               ids[cnt++] =3D type_id;
> +       }
> +
> +       opts.ids =3D ids;
> +       opts.cnt =3D cnt;
> +
> +       attach_start_ns =3D get_time_ns();
> +       link =3D bpf_program__attach_tracing_multi(skel->progs.bench, NUL=
L, &opts);
> +       attach_end_ns =3D get_time_ns();
> +
> +       err =3D libbpf_get_error(link);
> +       if (err) {
> +               link =3D NULL;
> +               fprintf(stderr, "failed to attach tracing multi link: %s\=
n",
> +                       strerror(-err));
> +               goto cleanup;
> +       }
> +
> +       detach_start_ns =3D get_time_ns();
> +       err =3D bpf_link__destroy(link);
> +       detach_end_ns =3D get_time_ns();
> +       link =3D NULL;
> +       if (err) {
> +               fprintf(stderr, "failed to detach tracing multi link: %s\=
n",
> +                       strerror(-err));
> +               goto cleanup;
> +       }
> +
> +       attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0=
;
> +       detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0=
;
> +
> +       printf("%s: found %zu functions\n", bench->name, cnt);
> +       printf("%s: attached in %7.3lfs\n", bench->name, attach_delta);
> +       printf("%s: detached in %7.3lfs\n", bench->name, detach_delta);
> +
> +cleanup:
> +       bpf_link__destroy(link);
> +       tracing_multi_bench__destroy(skel);
> +       tdestroy(root, tdestroy_free_nop);
> +       tdestroy(dups, tdestroy_free_nop);
> +       free_kallsyms_local(ksyms);
> +       free(ids);
> +       btf__free(btf);
> +
> +       exit(err ? 1 : 0);
> +}
> +
> +const struct bench bench_tracing_multi_attach =3D {
> +       .name =3D "tracing-multi-attach",
> +       .setup =3D tracing_multi_attach_setup,
> +};
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 0aa9532a05cf..fd4f256d2e0a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -3,14 +3,12 @@
>  #include <test_progs.h>
>  #include <bpf/btf.h>
>  #include <search.h>
> -#include "bpf/libbpf_internal.h"
>  #include "tracing_multi.skel.h"
>  #include "tracing_multi_module.skel.h"
>  #include "tracing_multi_intersect.skel.h"
>  #include "tracing_multi_session.skel.h"
>  #include "tracing_multi_fail.skel.h"
>  #include "tracing_multi_verifier.skel.h"
> -#include "tracing_multi_bench.skel.h"
>  #include "tracing_multi_rollback.skel.h"
>  #include "trace_helpers.h"
>
> @@ -662,129 +660,6 @@ static void test_attach_api_fails(void)
>         free(ids2);
>  }
>
> -void serial_test_tracing_multi_bench_attach(void)
> -{
> -       LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> -       struct tracing_multi_bench *skel =3D NULL;
> -       long attach_start_ns, attach_end_ns;
> -       long detach_start_ns, detach_end_ns;
> -       double attach_delta, detach_delta;
> -       struct bpf_link *link =3D NULL;
> -       size_t i, cap =3D 0, cnt =3D 0;
> -       struct ksyms *ksyms =3D NULL;
> -       void *root =3D NULL;
> -       void *dups =3D NULL;
> -       __u32 *ids =3D NULL;
> -       __u32 nr, type_id;
> -       struct btf *btf;
> -       int err;
> -
> -#ifndef __x86_64__
> -       test__skip();
> -       return;
> -#endif
> -
> -       btf =3D btf__load_vmlinux_btf();
> -       if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> -               return;
> -
> -       skel =3D tracing_multi_bench__open_and_load();
> -       if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
> -               goto cleanup;
> -
> -       if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> -               goto cleanup;
> -
> -       /* Get all ftrace 'safe' symbols.. */
> -       for (i =3D 0; i < ksyms->filtered_cnt; i++) {
> -               if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
> -                       ASSERT_FAIL("tsearch failed");
> -                       goto cleanup;
> -               }
> -       }
> -
> -       /*
> -        * Collect names that are not unique in kallsyms. The kernel reso=
lves a
> -        * tracing-multi BTF id to an address with kallsyms_lookup_name()=
, which
> -        * returns the first symbol of that name. For a duplicate name th=
at may
> -        * be a different (non-ftrace-able) instance than the ftrace-able=
 one in
> -        * available_filter_functions, so attaching to it by BTF id fails=
 with
> -        * -ENOENT (e.g. t_start/t_next/t_stop). ksyms->syms is sorted by=
 name,
> -        * so equal names are adjacent.
> -        */
> -       for (i =3D 1; i < ksyms->sym_cnt; i++) {
> -               if (strcmp(ksyms->syms[i].name, ksyms->syms[i - 1].name))
> -                       continue;
> -               if (!tsearch(&ksyms->syms[i].name, &dups, compare)) {
> -                       ASSERT_FAIL("tsearch failed");
> -                       goto cleanup;
> -               }
> -       }
> -
> -       /* ..and filter them through BTF and btf_type_is_traceable_func. =
*/
> -       nr =3D btf__type_cnt(btf);
> -       for (type_id =3D 1; type_id < nr; type_id++) {
> -               const struct btf_type *type;
> -               const char *str;
> -
> -               type =3D btf__type_by_id(btf, type_id);
> -               if (!type)
> -                       break;
> -
> -               if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)
> -                       continue;
> -
> -               str =3D btf__name_by_offset(btf, type->name_off);
> -               if (!str)
> -                       break;
> -
> -               if (!tfind(&str, &root, compare))
> -                       continue;
> -
> -               /* Skip names that are not unique in kallsyms, see above.=
 */
> -               if (tfind(&str, &dups, compare))
> -                       continue;
> -
> -               if (!btf_type_is_traceable_func(btf, type))
> -                       continue;
> -
> -               err =3D libbpf_ensure_mem((void **) &ids, &cap, sizeof(*i=
ds), cnt + 1);
> -               if (err)
> -                       goto cleanup;
> -
> -               ids[cnt++] =3D type_id;
> -       }
> -
> -       opts.ids =3D ids;
> -       opts.cnt =3D cnt;
> -
> -       attach_start_ns =3D get_time_ns();
> -       link =3D bpf_program__attach_tracing_multi(skel->progs.bench, NUL=
L, &opts);
> -       attach_end_ns =3D get_time_ns();
> -
> -       if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
> -               goto cleanup;
> -
> -       detach_start_ns =3D get_time_ns();
> -       bpf_link__destroy(link);
> -       detach_end_ns =3D get_time_ns();
> -
> -       attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0=
;
> -       detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0=
;
> -
> -       printf("%s: found %lu functions\n", __func__, cnt);
> -       printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> -       printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> -
> -cleanup:
> -       tracing_multi_bench__destroy(skel);
> -       tdestroy(root, tdestroy_free_nop);
> -       tdestroy(dups, tdestroy_free_nop);
> -       free_kallsyms_local(ksyms);
> -       free(ids);
> -       btf__free(btf);
> -}
> -
>  static void tracing_multi_rollback_run(struct tracing_multi_rollback *sk=
el)
>  {
>         LIBBPF_OPTS(bpf_test_run_opts, topts);
> --
> 2.55.0
>
