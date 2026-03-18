Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD9262FC0
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871332; cv=pass; b=u62tSxFeJ31LRTohm02dgH0r9+dkrV8Us+yHZnfIndhOHG6ZAGVlhckCCXTW2rkMeNTEXXm6FzNbl8H+/8UBtxvzElE4TDqQr9lS/AIV2uFAEq8JvP2h6UX52naxnWKMatcEsnzV4TYhIgUVv0aMBEjx0CLLVbbrd8KCP6MekMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871332; c=relaxed/simple;
	bh=UjxD1P+Sxin0qoGbQttA6wHIF8APuqZ7pPScS0nA+30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6ruNFyj62b0lGmESkJ8MMre/T538zlZrBr0OtAWcKMEes9hj6fECn55HdyE9zqxeuqE8KAk+lSHk2HVIbJh42VICFVn/ghGVdEgKwBJCZtOtY/aYwjkHiVGm0yxyZcNJyS9tfB9dZ2BM/1m7nYwN+gJmMu3b1AQM3kyJT1KDx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlRm//+s; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlRm//+s"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso205144f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871329; cv=none;
        d=google.com; s=arc-20240605;
        b=X1tlqgr7/3sXFe95rSrY3j8v+TRDGZAh2Hbsde0YGyJzWyB+x2zdJVxCWHz1nn27QZ
         /W3N2kYcatdxz/CQjH0kJRRxwqwdMWFgqe83wusOULbqupIf1fXHRZBA3wDIg5eKODRE
         k9PhxE54jnM56HCLazq7pUsp5snqe4BfwmApfol3tBAzHBGqCb8Ly4dfdxVz6XTMkBg8
         bIbC6ZdkGCuckcaK+n9x8+IFIZWnOQeDjsQ/7RvwHSNi810Z5H4q79n+uUpbpJFW2xkX
         D8AsMeiP1KHAEXdVMegqHphoZIjNxWnk6W0dga7/+PCR+ICKBN7ZQC1igOfduZvSAmTN
         yBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8NlX3c5kGkfpRo9/5lGQBSiC4gLEPIZ5q6cKftZmaCI=;
        fh=sySLC0eAOnLfusWdSev/PfJ6j9EdrDmz8sk94TrrcCY=;
        b=eoCNdJAAwEwoNRwOjh0QnIMNq3jAEwtTKypQ8+CaBsEE6iP4Sa7v0ZY/Cp6X4mtR0F
         WBeqk7WYnH2hZ4R9h+bdYVFCGHmn/jDW8RAfABODWy5LUkOD04EeV1QqQwcO2z590fDJ
         1FSKz2H3U6BLZqjihTKY1Lzpr8SAQ3KAFKdTcqRQM1k8KJRxv/9wJzcbxrAro0DDPCtM
         GZIYfgFxnYVVmYOTfAeIKiLgDVCUjCkgw2qgck8Zu115kScgmHsr3vLqEk5AaqcSZYr6
         KzYjDlhbTGagMCZ/F2BjsiJzBMqT79X8PDzDTaaDbVb8RNZxTyBXQwcaFSdb7Z0Tf/+g
         N9ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871329; x=1774476129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NlX3c5kGkfpRo9/5lGQBSiC4gLEPIZ5q6cKftZmaCI=;
        b=NlRm//+sAR5efmWVI0wKBBNpwFoM5hRwUbMKyDIIaOVQ+IvyXhxk01ZY7UvAmzlNNa
         VR2wDY0r6Vk89Gz3D/yLopfthHYvSnt0HJIixiq6cn4vxJxJ/bHhO834Ebkb23gTzOeX
         WROxutXG5Jmo5GVUAv1Khu9z5wUTBqYmO/I78Ro2bGLgkSxQUOneYUdNewer1YgDEEge
         omtwotl++HuhMBaAv1wi9NMyf1RdIAzEz2PcEcTsrxkxfJ6HJHwIA6bd+dvNqtn3aqkh
         V1e/d87Kl1oNX9goLc4ojuxjOOysc1IWBuS6pSr4wX4xsLqP2BJWFe2VbfepwxXpnHo8
         Z+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871329; x=1774476129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NlX3c5kGkfpRo9/5lGQBSiC4gLEPIZ5q6cKftZmaCI=;
        b=SPpsmBPMNopI3S0ZRZsEBJxB7y1m/6CbnkV8OSZ/gqbf4HmttRcC/iYV3wy1943Wpk
         bwCgeEgQEVPSkToivt/3YhSPpBzmLOIoLfZKmQGRsO0pVXOdQXn17LU/G82CuM3lfURK
         PB2MqZBdd7zx7YAd2NWIgsFpBZi+ChIncbaEfU1YbxNknFbXqalT3raw71aq+1wpGJES
         +VcxXUGUJseR8vAJzoETWIicsB+4eq7QfmsP/FJm11gG2YXO27nDVBfwR/S0SXYM79hI
         XjRYtm3fnMIVhV8DiYQ4+mXqeX0m/BOOj7m+OMmkfs87TjeKsjNf6QDfqUSx1frdb8pL
         KLCA==
X-Gm-Message-State: AOJu0YzCJAFoK1wRjBeyNh8eSVvpcJMj5ki0bATZleX+e02R6FicEU9u
	/9UeS4ujO3GGwwBOoMXze5ChqewBtZmgHJy+yvgDDwZfQ/NcdOeHKFgBgDvUM8gpyFeJ6nBhafA
	whOsLWCzAoK9XIEx1bwX4sCcP7qbODdg=
X-Gm-Gg: ATEYQzzgmZEAM/RMrt0QRB5DeezvT25Wu3U5iJ6HFO/+i3ugHq76VQKpvcA+Mqnqtid
	3oSoEtY/DtQs4SVCyc5Yv8W6ux5l/zwzJvmvTn8bzfcIH4TjyhYliqIK33xsYYYn63hja7fq8gN
	yZA79w5WdbyIk4JCW9ZiZrpvmlfczbQre7DYBSdKNtQpTtijMkH+nA4H+29zfCVfosSDHkI0e0Z
	14jEqI38mS+369p+g3ZflUYxEBSdfnvXzq8brlod5Ho2vkcs2bK8ZrLthLqSFYTorHJfV2QgiTa
	FEQZMYxSY8stIqf0UIBPIkQceC8pPkXbNa7ss1JKCbJZDq4mDaKWEShia3A=
X-Received: by 2002:a5d:5885:0:b0:43b:4aba:8f32 with SMTP id
 ffacd0b85a97d-43b527c54ccmr8317359f8f.28.1773871328942; Wed, 18 Mar 2026
 15:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318103526.2590079-1-memxor@gmail.com> <20260318103526.2590079-3-memxor@gmail.com>
 <878qbpkxh9.fsf@gmail.com>
In-Reply-To: <878qbpkxh9.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 18 Mar 2026 23:01:32 +0100
X-Gm-Features: AaiRm50accfVjSPlzCiqxLCr6RCV1Wtmlcg_fu5DQTQQPEt2rDhE_dWlwSBc23w
Message-ID: <CAP01T75v1r6jH=LH_+njSzmQp9VhrL_LPz1T0U1DQbR6mfBFsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add syscall ctx variable
 offset tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 15:45, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
> > for syscall programs, and cover disallowed cases for other program types
> > lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADMIN
> > so that kfunc related logic can be tested. While at it, convert assembly
> > tests to C.
> >
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |  34 +-
> >  .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
> >  .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
> >  3 files changed, 325 insertions(+), 67 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > index 8cdfd74c95d7..04d5f46264a3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -126,29 +126,35 @@ struct test_val {
> >  __maybe_unused
> >  static void run_tests_aux(const char *skel_name,
> >                         skel_elf_bytes_fn elf_bytes_factory,
> > -                       pre_execution_cb pre_execution_cb)
> > +                       pre_execution_cb pre_execution_cb,
> > +                       bool drop_sys_admin)
> >  {
> >       struct test_loader tester = {};
> >       __u64 old_caps;
> >       int err;
> >
> > -     /* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
> > -     err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> > -     if (err) {
> > -             PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> > -             return;
> > +     if (drop_sys_admin) {
> > +             /* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
> > +             err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> > +             if (err) {
> > +                     PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> > +                     return;
> > +             }
> >       }
> >
> >       test_loader__set_pre_execution_cb(&tester, pre_execution_cb);
> >       test_loader__run_subtests(&tester, skel_name, elf_bytes_factory);
> >       test_loader_fini(&tester);
> >
> > -     err = cap_enable_effective(old_caps, NULL);
> > -     if (err)
> > -             PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> > +     if (drop_sys_admin) {
> > +             err = cap_enable_effective(old_caps, NULL);
> > +             if (err)
> > +                     PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> > +     }
> >  }
> >
> > -#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
> > +#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, true)
> > +#define RUN_WITH_CAP_SYS_ADMIN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, false)
> >
> >  void test_verifier_align(void)                { RUN(verifier_align); }
> >  void test_verifier_and(void)                  { RUN(verifier_and); }
> > @@ -173,7 +179,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
> >  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
> >  void test_verifier_const(void)                { RUN(verifier_const); }
> >  void test_verifier_const_or(void)             { RUN(verifier_const_or); }
> > -void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
> > +void test_verifier_ctx(void)                  { RUN_WITH_CAP_SYS_ADMIN(verifier_ctx); }
> >  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
> >  void test_verifier_d_path(void)               { RUN(verifier_d_path); }
> >  void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
> > @@ -293,7 +299,8 @@ void test_verifier_array_access(void)
> >  {
> >       run_tests_aux("verifier_array_access",
> >                     verifier_array_access__elf_bytes,
> > -                   init_array_access_maps);
> > +                   init_array_access_maps,
> > +                   true);
> >  }
> >  void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_context); }
> >
> > @@ -306,5 +313,6 @@ void test_verifier_value_ptr_arith(void)
> >  {
> >       run_tests_aux("verifier_value_ptr_arith",
> >                     verifier_value_ptr_arith__elf_bytes,
> > -                   init_value_ptr_arith_maps);
> > +                   init_value_ptr_arith_maps,
> > +                   true);
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> > index 371780290c0d..c054c8cb7242 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> > @@ -4,6 +4,10 @@
> >  #include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include "bpf_misc.h"
> > +#include "../test_kmods/bpf_testmod_kfunc.h"
> > +
> > +const char ctx_strncmp_target[] = "ctx";
> > +const char ctx_snprintf_fmt[] = "";
> >
> >  SEC("tc")
> >  __description("context stores via BPF_ATOMIC")
> > @@ -69,7 +73,6 @@ __naked void ctx_pointer_to_helper_1(void)
> >  SEC("socket")
> >  __description("pass modified ctx pointer to helper, 2")
> >  __failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
> > -__failure_unpriv __msg_unpriv("negative offset ctx ptr R1 off=-612 disallowed")
> >  __naked void ctx_pointer_to_helper_2(void)
> >  {
> >       asm volatile ("                                 \
> > @@ -295,77 +298,324 @@ padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
> >  SEC("syscall")
> >  __description("syscall: write to ctx with fixed offset")
> >  __success
> > -__naked void syscall_ctx_fixed_off_write(void)
> > +int syscall_ctx_fixed_off_write(void *ctx)
> >  {
> > -     asm volatile ("                                 \
> > -     r0 = 0;                                         \
> > -     *(u32*)(r1 + 0) = r0;                           \
> > -     r1 += 4;                                        \
> > -     *(u32*)(r1 + 0) = r0;                           \
> > -     exit;                                           \
> > -"    ::: __clobber_all);
> > +     char *p = ctx;
> > +
> > +     *(__u32 *)p = 0;
> > +     *(__u32 *)(p + 4) = 0;
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: read ctx with fixed offset")
> > +__success
> > +int syscall_ctx_fixed_off_read(void *ctx)
> > +{
> > +     char *p = ctx;
> > +     volatile __u32 val;
> > +
> > +     val = *(__u32 *)(p + 4);
> > +     (void)val;
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: read ctx with variable offset")
> > +__success
> > +int syscall_ctx_var_off_read(void *ctx)
> > +{
> > +     __u64 off = bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +     volatile __u32 val;
> > +
> > +     off &= 0xfc;
> > +     p += off;
> > +     val = *(__u32 *)p;
> > +     (void)val;
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: write ctx with variable offset")
> > +__success
> > +int syscall_ctx_var_off_write(void *ctx)
> > +{
> > +     __u64 off = bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +
> > +     off &= 0xfc;
> > +     p += off;
> > +     *(__u32 *)p = 0;
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: reject negative variable offset ctx access")
> > +__failure __msg("min value is negative")
> > +int syscall_ctx_neg_var_off(void *ctx)
> > +{
> > +     __u64 off = bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +
> > +     off &= 4;
> > +     p -= off;
> > +     return *(__u32 *)p;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: reject unbounded variable offset ctx access")
> > +__failure __msg("unbounded memory access")
> > +int syscall_ctx_unbounded_var_off(void *ctx)
> > +{
> > +     __u64 off = (__u32)bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +
> > +     off <<= 2;
> > +     p += off;
> > +     return *(__u32 *)p;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: helper read ctx with fixed offset")
> > +__success
> > +int syscall_ctx_helper_fixed_off_read(void *ctx)
> > +{
> > +     char *p = ctx;
> > +
> > +     p += 4;
> > +     return bpf_strncmp(p, 4, ctx_strncmp_target);
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: helper write ctx with fixed offset")
> > +__success
> > +int syscall_ctx_helper_fixed_off_write(void *ctx)
> > +{
> > +     char *p = ctx;
> > +
> > +     p += 4;
> > +     return bpf_probe_read_kernel(p, 4, 0);
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: helper read ctx with variable offset")
> > +__success
> > +int syscall_ctx_helper_var_off_read(void *ctx)
> > +{
> > +     __u64 off = bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +
> > +     off &= 0xfc;
> > +     p += off;
> > +     return bpf_strncmp(p, 4, ctx_strncmp_target);
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: helper write ctx with variable offset")
> > +__success
> > +int syscall_ctx_helper_var_off_write(void *ctx)
> > +{
> > +     __u64 off = bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +
> > +     off &= 0xfc;
> > +     p += off;
> > +     return bpf_probe_read_kernel(p, 4, 0);
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: helper read zero-sized ctx access")
> > +__success
> > +int syscall_ctx_helper_zero_sized_read(void *ctx)
> > +{
> > +     return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: helper write zero-sized ctx access")
> > +__success
> > +int syscall_ctx_helper_zero_sized_write(void *ctx)
> > +{
> > +     return bpf_probe_read_kernel(ctx, 0, 0);
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: kfunc access ctx with fixed offset")
> > +__success
> > +int syscall_ctx_kfunc_fixed_off(void *ctx)
> > +{
> > +     char *p = ctx;
> > +
> > +     p += 4;
> > +     bpf_kfunc_call_test_mem_len_pass1(p, 4);
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: kfunc access ctx with variable offset")
> > +__success
> > +int syscall_ctx_kfunc_var_off(void *ctx)
> > +{
> > +     __u64 off = bpf_get_prandom_u32();
> > +     char *p = ctx;
> > +
> > +     off &= 0xfc;
> > +     p += off;
> > +     bpf_kfunc_call_test_mem_len_pass1(p, 4);
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("syscall: kfunc access zero-sized ctx")
> > +__success
> > +int syscall_ctx_kfunc_zero_sized(void *ctx)
> > +{
> > +     bpf_kfunc_call_test_mem_len_pass1(ctx, 0);
> > +     return 0;
> >  }
> Tests are comprehensive. Do we need to test rejection of unaligned read
> too?
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

Thanks, I am actually now considering dropping the aligned access
requirement, I will add a test for it.

> [...]
