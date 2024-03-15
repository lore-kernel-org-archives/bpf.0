Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B863AC
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710475073; cv=none; b=Y5pJMh6KlxCzMdyrOjPIkHgxxdyVOOLfzyHuiOIKYmqVYd2vbGFUl/CVqujo8Qe/BYK6Ug0wHDT46yaaPUkWTKLrCHzYrznIRHYMQKfzcd/k79px33kiVaM3lf3dEU35urFdJBE3HAsMBnsD9Ip2xopBc3c2EiPRTl6ej18QNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710475073; c=relaxed/simple;
	bh=XrRLDqAVl22VbXmpfig+mi4vMZup62eU1f1mImfk81M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2uaqkG8ectTo696sRNlLc0V3TrBJfG5Jni8FRngQ7HKmjmQl8hjzl6e7kFqkczacJKHAe9Ox2p7GnCqvdA/UUK5AtTFyKxR32GeXE9VRotz7Oi178o5aNWLAqnNAfldYu5dhD7BhR3fCZ8OXlr8fuwFgfWN7jokwVh7VCsR0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5aIKlLV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5aIKlLV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so1202228a91.2
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710475071; x=1711079871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ze8Zq8vXs8Qp8t8VzOxnd/h6CRWwhu6khNIZXpiL7k=;
        b=Q5aIKlLV1I4f8wzaHu5DMhoGRUj5I3h3CQKaPKUPeuAp/67AUiAk5Se0tGVzGkCD82
         vAtNLeWH3Sbgx2NKZrX6888b1I2YkGWUGbjwq+hXlk9fw9+V4gkK8rI1l6pDji+z3XRe
         B6cnFnqr8heixPMzeeM+rf3xK7YiXPPBI1zrs2ImjfYcTsJ/cOTzjd5OerLoSPmJOg6a
         Ci+MkmVmSqVrfnjGD9/QcLnjb5q40GWlUQgycnqI3sNK9SRrsPKhL4Vl8O6Pc/RnaHtm
         QyLBczyyy4sxcRtaQJm83LxpyJnm70YC4Hz9xvsEucvLMC40rzupxb00rtMC/bnVkGx2
         Safg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710475071; x=1711079871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ze8Zq8vXs8Qp8t8VzOxnd/h6CRWwhu6khNIZXpiL7k=;
        b=MvswW/6fDIe/Bd0ljoTERWNe0TxtPzAl7UMmgUV1MlmEST149ZvxvMX8+HgIIdguhF
         gETzH824mjfcMi42L2WeEucn09wYFVLTkctJR7LZpy/wI5wvla43Dvr4/lgxaza/Uvm3
         UJ+ozoBygJwlETwvPFVfLwbNF3xVw60hPTVkkbLWZW5wczLHXsGc1xRM0NP+EIsV/UrJ
         9Krxf7wCWHT8J2vb6lFMCXWFbKwQLUD7xtxzGTFk7C53GzH4jrwBMIZl12STC4B9Wzs/
         lYirNDxWN8XyziUVjKqjgKkWZ6jAOy5L/jNhanKUlaUbjIzdmZyfFmuZ/PXdq68GvEl/
         Hq8Q==
X-Gm-Message-State: AOJu0YzoubeVYPBaFJXSqIuhc9n/jTVJ4EWY2Wg1M7ip+9djaDvhSbzQ
	YgSIkIxfC9Ah2hyAZSLNgLL/7Z4hgr2puXTWMHkB4F/d9dzFkdzzYZrf+vBMHeBmpmfP8sJ6XFm
	JqKxJj8UqoREv3nwqGqzDZq9I2GEgDu2+
X-Google-Smtp-Source: AGHT+IGrz5XkG8Kvriid4O3kJDCIbHkGCLPIQnZxm1NxeutFhy8SjE9wx3/OzU8jPUFfdCW7bc0nXX7FiAUgVlbOqSA=
X-Received: by 2002:a17:90a:c596:b0:29b:b865:3dbf with SMTP id
 l22-20020a17090ac59600b0029bb8653dbfmr3505079pjt.48.1710475071122; Thu, 14
 Mar 2024 20:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com> <20240315021834.62988-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20240315021834.62988-3-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Mar 2024 20:57:39 -0700
Message-ID: <CAEf4BzYpEz=XGwYaG8_YBRU6WbDp_23ybVLC1aEy1bYMJ77hVg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] libbpf, selftests/bpf: Adjust libbpf, bpftool,
 selftests to match LLVM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The selftests use
> to tell LLVM about special pointers. For LLVM there is nothing "arena"
> about them. They are simply pointers in a different address space.
> Hence LLVM diff https://github.com/llvm/llvm-project/pull/85161 renamed:
> . macro __BPF_FEATURE_ARENA_CAST -> __BPF_FEATURE_ADDR_SPACE_CAST
> . global variables in __attribute__((address_space(N))) are now
>   placed in section named ".address_space.N" instead of ".arena.N".

.addr_space.N, according to code below

>
> Adjust libbpf, bpftool, and selftests to match LLVM.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c                            |  2 +-
>  tools/lib/bpf/libbpf.c                             |  2 +-
>  tools/testing/selftests/bpf/bpf_arena_common.h     |  2 +-
>  tools/testing/selftests/bpf/progs/arena_htab.c     |  2 +-
>  tools/testing/selftests/bpf/progs/arena_list.c     | 10 +++++-----
>  tools/testing/selftests/bpf/progs/verifier_arena.c |  4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 4fa4ade1ce74..540c0f2c4fda 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -121,7 +121,7 @@ static bool get_datasec_ident(const char *sec_name, c=
har *buf, size_t buf_sz)
>         int i, n;
>
>         /* recognize hard coded LLVM section name */
> -       if (strcmp(sec_name, ".arena.1") =3D=3D 0) {
> +       if (strcmp(sec_name, ".addr_space.1") =3D=3D 0) {
>                 /* this is the name to use in skeleton */
>                 snprintf(buf, buf_sz, "arena");
>                 return true;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index efab29b8935b..36e26f4f5997 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -498,7 +498,7 @@ struct bpf_struct_ops {
>  #define KSYMS_SEC ".ksyms"
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
> -#define ARENA_SEC ".arena.1"
> +#define ARENA_SEC ".addr_space.1"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testi=
ng/selftests/bpf/bpf_arena_common.h
> index bcf195c64a45..567491f3e1b5 100644
> --- a/tools/testing/selftests/bpf/bpf_arena_common.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_common.h
> @@ -32,7 +32,7 @@
>   */
>  #endif
>
> -#if defined(__BPF_FEATURE_ARENA_CAST) && !defined(BPF_ARENA_FORCE_ASM)
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_A=
SM)
>  #define __arena __attribute__((address_space(1)))
>  #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
>  #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
> diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testi=
ng/selftests/bpf/progs/arena_htab.c
> index b7bb712cacfd..1e6ac187a6a0 100644
> --- a/tools/testing/selftests/bpf/progs/arena_htab.c
> +++ b/tools/testing/selftests/bpf/progs/arena_htab.c
> @@ -22,7 +22,7 @@ int zero =3D 0;
>  SEC("syscall")
>  int arena_htab_llvm(void *ctx)
>  {
> -#if defined(__BPF_FEATURE_ARENA_CAST) || defined(BPF_ARENA_FORCE_ASM)
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_AS=
M)
>         struct htab __arena *htab;
>         __u64 i;
>
> diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testi=
ng/selftests/bpf/progs/arena_list.c
> index cd35b8448435..c0422c58cee2 100644
> --- a/tools/testing/selftests/bpf/progs/arena_list.c
> +++ b/tools/testing/selftests/bpf/progs/arena_list.c
> @@ -30,13 +30,13 @@ int list_sum;
>  int cnt;
>  bool skip =3D false;
>
> -#ifdef __BPF_FEATURE_ARENA_CAST
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>  long __arena arena_sum;
>  int __arena test_val =3D 1;
>  struct arena_list_head __arena global_head;
>  #else
> -long arena_sum SEC(".arena.1");
> -int test_val SEC(".arena.1");
> +long arena_sum SEC(".addr_space.1");
> +int test_val SEC(".addr_space.1");
>  #endif
>
>  int zero;
> @@ -44,7 +44,7 @@ int zero;
>  SEC("syscall")
>  int arena_list_add(void *ctx)
>  {
> -#ifdef __BPF_FEATURE_ARENA_CAST
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>         __u64 i;
>
>         list_head =3D &global_head;
> @@ -66,7 +66,7 @@ int arena_list_add(void *ctx)
>  SEC("syscall")
>  int arena_list_del(void *ctx)
>  {
> -#ifdef __BPF_FEATURE_ARENA_CAST
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>         struct elem __arena *n;
>         int sum =3D 0;
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index 5540b05ff9ee..969bc091060b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -19,7 +19,7 @@ SEC("syscall")
>  __success __retval(0)
>  int basic_alloc1(void *ctx)
>  {
> -#if defined(__BPF_FEATURE_ARENA_CAST)
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>         volatile int __arena *page1, *page2, *no_page, *page3;
>
>         page1 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0)=
;
> @@ -58,7 +58,7 @@ SEC("syscall")
>  __success __retval(0)
>  int basic_alloc2(void *ctx)
>  {
> -#if defined(__BPF_FEATURE_ARENA_CAST)
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>         volatile char __arena *page1, *page2, *page3, *page4;
>
>         page1 =3D bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0)=
;
> --
> 2.43.0
>
