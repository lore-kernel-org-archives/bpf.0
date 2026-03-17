Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577E37B036
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771873; cv=none; b=AbkcAwpOqdSi4mwn1pmQ01YhBv+TTtSNbYBbpcDmt6SZIPIoJ2j4ce6oOBfnWZixptiULmGmE/7HdjMj6uJ9s/9YvJRCRB48hf4JIkexon6SVPqDqjsk8TkrY7gU+lT+CceXPuBV+YtWW+wI47qBRUfDK8uzhbmfMMyHiwr1QrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771873; c=relaxed/simple;
	bh=Sn8dc4VAUbVHdeO6sX8S36ewqdpPzGJsoR0ZJSmzD7o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l/CHhHi+0XkKz0KypWHfigPE8R2OK5kjh3nMjZYsejNWV6eNgvImob4YkRSZpFrwWwl279YjZDLTTsd3snWvxmiIJVDC2JYzVKMf8J807vmNcynVO9rVY+Do1iY7eVIxwHUIDge9EQLGQK6yo5T8YcQ8aqViyzur/M650sDb+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Rkf7kpea; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Rkf7kpea"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509101189f1so55328541cf.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773771870; x=1774376670; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er+cBkoZIxH9IJuinMKMdfVcS8D6lweOcq/Usga4sI4=;
        b=Rkf7kpealqtQdXDGupOrp02kkd+2ok0Ew+26LwOwnelxknpQW/VaG1lXtNBUWEuAXc
         tEgdyVQOTJVmtRiYN0dzYZPhB8IunzTUXXJsVV6y8ltWw9JTn7rY/x+axNry6ZDAgMmK
         YSRJwoUwgasR0feMCnuCW/RojNXDvOsNL31bEOUUvGo/OJbnAnJufRMgjPj2D5Vz0aqz
         pFK0rCr5aAcus+kTwNZPEDS8FttY89nTc72WjAfbGY4kZEZQld8okxhJiK+5UF6hj+t7
         MhC7gOZgkQx6/+rFf9jKfmOPRnzvTsPfPWDleFd08zUCITatzo1D1XClDpRuHUKk1q/f
         58+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773771870; x=1774376670;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Er+cBkoZIxH9IJuinMKMdfVcS8D6lweOcq/Usga4sI4=;
        b=REgXvD+FEU8JhobSB2qmSHRujUylhKmiIzhTrrqMQyfmUoZh9n8M6vEgRQi/D13aK+
         0d3nX3XvZoZXn7zM3L9xcWQyLoqCMCg59ITn4XH+iRmTdIxvLEsGha10wh4KRNoA5PKF
         uGWSXs86JTc0SNCYyyT6nJnFlQk6lZS8219vdZJ+YI4opN+spJp6T28uvgL+cf/nl58u
         S3Ly6ACYnONe0K3Es1tehex8FP1ogNX6vZFZLNnK2+y07bW5+4RnoQTZP5+OF7e79hDV
         hayeo8CSm8hE+kGGlIIKbZOVj22cP7fPCNCQWUaOtEP2Bt6mqOpxW8XJVbObZAuebFPe
         ossA==
X-Forwarded-Encrypted: i=1; AJvYcCVc28xJlREuKaMzBNwZUupONWI9JWDXTj2I6wHeocX2Zh364WPf2Lxo8cmZe8XwI7Zxbo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWyrSi5Uwvclbk8UFmbJk+8tawXWczl2dEG77H7VuYeb9K7xP
	XRSmjDAeU9q6vgN3hipqNDOkhD7qXCBjAsDZ2NXxblb7LBArXopo0eFuX9ljCGx8P4g=
X-Gm-Gg: ATEYQzwH+qilAgvDQcM44MnUN1yNuCcftVFQdPH3qEPv9N4A/uTRwILZyEVsCeVMNUY
	aPWcsUjDUTrAGPlZBf+KEITa+gu1dH0Mjz2R6TEnKirmZ1lf62arAE9olUQM36W2/VOEBzd2cfb
	SNPBm/TOoC0stAsXVU/QjrxUtw5w0LDPh8Rpmx4bDBZfB9wCc0R2xsQWtcZho2F3+fNzZvYB2tG
	yHDnHYDbelZJq1WOWTDHi+v5BpW97IJHAFFkEPgg2FjYpXHxTbTZT+T/Qr/+hhmt3E7MA4XoOk5
	i1BacfebtwaSXChwV9r3nlhloMdIM/87V0DWrtq4KzX6UOIJy6aQ/rWR26ILf40yjDem4PvyGN9
	Pi3eQ6dfUkPrS7PmHjQPvDh4qB8nb4YI4F2fOuF1ZQqBD8bZWn9fLkuA63hcKW/ZQ5EWedxAKpT
	1VziprgIynD6HO6pI1LaiELdk=
X-Received: by 2002:ac8:5f84:0:b0:509:1009:e79d with SMTP id d75a77b69052e-50b148ba4fdmr3604901cf.55.1773771869884;
        Tue, 17 Mar 2026 11:24:29 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b13320817sm6983581cf.0.2026.03.17.11.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 11:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 14:24:28 -0400
Message-Id: <DH59NF5G3WVN.1LKGNUUA3784J@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Adjust syscall ctx
 variable offset tests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260317111850.2107846-1-memxor@gmail.com>
 <20260317111850.2107846-3-memxor@gmail.com>
In-Reply-To: <20260317111850.2107846-3-memxor@gmail.com>

On Tue Mar 17, 2026 at 7:18 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
> for syscall programs, and cover disallowed cases for other program types
> lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADMIN
> so that kfunc related logic can be tested. While at it, convert assembly
> tests to C.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  34 +-
>  .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
>  3 files changed, 325 insertions(+), 67 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 8cdfd74c95d7..04d5f46264a3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -126,29 +126,35 @@ struct test_val {
>  __maybe_unused
>  static void run_tests_aux(const char *skel_name,
>  			  skel_elf_bytes_fn elf_bytes_factory,
> -			  pre_execution_cb pre_execution_cb)
> +			  pre_execution_cb pre_execution_cb,
> +			  bool drop_sys_admin)
>  {
>  	struct test_loader tester =3D {};
>  	__u64 old_caps;
>  	int err;
> =20
> -	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here=
 */
> -	err =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> -	if (err) {
> -		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-er=
r));
> -		return;
> +	if (drop_sys_admin) {
> +		/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same her=
e */
> +		err =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> +		if (err) {
> +			PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-e=
rr));
> +			return;
> +		}
>  	}
> =20
>  	test_loader__set_pre_execution_cb(&tester, pre_execution_cb);
>  	test_loader__run_subtests(&tester, skel_name, elf_bytes_factory);
>  	test_loader_fini(&tester);
> =20
> -	err =3D cap_enable_effective(old_caps, NULL);
> -	if (err)
> -		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(=
-err));
> +	if (drop_sys_admin) {
> +		err =3D cap_enable_effective(old_caps, NULL);
> +		if (err)
> +			PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror=
(-err));
> +	}
>  }
> =20
> -#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
> +#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, true)
> +#define RUN_WITH_CAP_SYS_ADMIN(skel) run_tests_aux(#skel, skel##__elf_by=
tes, NULL, false)
> =20
>  void test_verifier_align(void)                { RUN(verifier_align); }
>  void test_verifier_and(void)                  { RUN(verifier_and); }
> @@ -173,7 +179,7 @@ void test_verifier_cgroup_skb(void)           { RUN(v=
erifier_cgroup_skb); }
>  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_stor=
age); }
>  void test_verifier_const(void)                { RUN(verifier_const); }
>  void test_verifier_const_or(void)             { RUN(verifier_const_or); =
}
> -void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
> +void test_verifier_ctx(void)                  { RUN_WITH_CAP_SYS_ADMIN(v=
erifier_ctx); }
>  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg)=
; }
>  void test_verifier_d_path(void)               { RUN(verifier_d_path); }
>  void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_defau=
lt_trusted_ptr); }
> @@ -293,7 +299,8 @@ void test_verifier_array_access(void)
>  {
>  	run_tests_aux("verifier_array_access",
>  		      verifier_array_access__elf_bytes,
> -		      init_array_access_maps);
> +		      init_array_access_maps,
> +		      true);
>  }
>  void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_con=
text); }
> =20
> @@ -306,5 +313,6 @@ void test_verifier_value_ptr_arith(void)
>  {
>  	run_tests_aux("verifier_value_ptr_arith",
>  		      verifier_value_ptr_arith__elf_bytes,
> -		      init_value_ptr_arith_maps);
> +		      init_value_ptr_arith_maps,
> +		      true);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
> index 371780290c0d..c054c8cb7242 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -4,6 +4,10 @@
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +const char ctx_strncmp_target[] =3D "ctx";
> +const char ctx_snprintf_fmt[] =3D "";
> =20
>  SEC("tc")
>  __description("context stores via BPF_ATOMIC")
> @@ -69,7 +73,6 @@ __naked void ctx_pointer_to_helper_1(void)
>  SEC("socket")
>  __description("pass modified ctx pointer to helper, 2")
>  __failure __msg("negative offset ctx ptr R1 off=3D-612 disallowed")
> -__failure_unpriv __msg_unpriv("negative offset ctx ptr R1 off=3D-612 dis=
allowed")
>  __naked void ctx_pointer_to_helper_2(void)
>  {
>  	asm volatile ("					\
> @@ -295,77 +298,324 @@ padding_access("sk_reuseport", sk_reuseport_md, ha=
sh, 4);
>  SEC("syscall")
>  __description("syscall: write to ctx with fixed offset")
>  __success
> -__naked void syscall_ctx_fixed_off_write(void)
> +int syscall_ctx_fixed_off_write(void *ctx)
>  {
> -	asm volatile ("					\
> -	r0 =3D 0;						\
> -	*(u32*)(r1 + 0) =3D r0;				\
> -	r1 +=3D 4;					\
> -	*(u32*)(r1 + 0) =3D r0;				\
> -	exit;						\
> -"	::: __clobber_all);
> +	char *p =3D ctx;
> +
> +	*(__u32 *)p =3D 0;
> +	*(__u32 *)(p + 4) =3D 0;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: read ctx with fixed offset")
> +__success
> +int syscall_ctx_fixed_off_read(void *ctx)
> +{
> +	char *p =3D ctx;
> +	volatile __u32 val;
> +
> +	val =3D *(__u32 *)(p + 4);
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: read ctx with variable offset")
> +__success
> +int syscall_ctx_var_off_read(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +	volatile __u32 val;
> +
> +	off &=3D 0xfc;
> +	p +=3D off;
> +	val =3D *(__u32 *)p;
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: write ctx with variable offset")
> +__success
> +int syscall_ctx_var_off_write(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	p +=3D off;
> +	*(__u32 *)p =3D 0;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: reject negative variable offset ctx access")
> +__failure __msg("min value is negative")
> +int syscall_ctx_neg_var_off(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 4;
> +	p -=3D off;
> +	return *(__u32 *)p;
> +}
> +
> +SEC("syscall")
> +__description("syscall: reject unbounded variable offset ctx access")
> +__failure __msg("unbounded memory access")
> +int syscall_ctx_unbounded_var_off(void *ctx)
> +{
> +	__u64 off =3D (__u32)bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off <<=3D 2;

Unrelated to this patch: These kinds of shifts are pretty frequent in
array arithmetic by the compiler, is it worth it/tractable to account=20
for them during bounds calculation?

> +	p +=3D off;
> +	return *(__u32 *)p;
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper read ctx with fixed offset")
> +__success
> +int syscall_ctx_helper_fixed_off_read(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 4;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper write ctx with fixed offset")
> +__success
> +int syscall_ctx_helper_fixed_off_write(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 4;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper read ctx with variable offset")
> +__success
> +int syscall_ctx_helper_var_off_read(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	p +=3D off;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper write ctx with variable offset")
> +__success
> +int syscall_ctx_helper_var_off_write(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	p +=3D off;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper read zero-sized ctx access")
> +__success
> +int syscall_ctx_helper_zero_sized_read(void *ctx)
> +{
> +	return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper write zero-sized ctx access")
> +__success
> +int syscall_ctx_helper_zero_sized_write(void *ctx)
> +{
> +	return bpf_probe_read_kernel(ctx, 0, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: kfunc access ctx with fixed offset")
> +__success
> +int syscall_ctx_kfunc_fixed_off(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 4;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: kfunc access ctx with variable offset")
> +__success
> +int syscall_ctx_kfunc_var_off(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xfc;
> +	p +=3D off;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: kfunc access zero-sized ctx")
> +__success
> +int syscall_ctx_kfunc_zero_sized(void *ctx)
> +{
> +	bpf_kfunc_call_test_mem_len_pass1(ctx, 0);
> +	return 0;
>  }
> =20
>  /*
> - * Test that program types without convert_ctx_access can dereference
> - * their ctx pointer after adding a fixed offset. Variable and negative
> - * offsets should still be rejected.
> + * For non-syscall program types without convert_ctx_access, direct ctx
> + * dereference is still allowed after adding a fixed offset, while varia=
ble
> + * and negative direct accesses reject.
> + *
> + * Passing ctx as a helper or kfunc memory argument is only permitted fo=
r
> + * syscall programs, so the helper and kfunc cases below validate reject=
ion
> + * for non-syscall ctx pointers at fixed, variable, and zero-sized acces=
ses.
>   */
> -#define no_rewrite_ctx_access(type, name, off, ld_op)			\
> +#define no_rewrite_ctx_access(type, name, off, load_t)			\
>  	SEC(type)							\
>  	__description(type ": read ctx at fixed offset")		\
>  	__success							\
> -	__naked void no_rewrite_##name##_fixed(void)			\
> +	int no_rewrite_##name##_fixed(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r1 +=3D %[__off];						\
> -		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> -		r0 =3D 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm_const(__off, off)				\
> -		: __clobber_all);					\
> +		char *p =3D ctx;						\
> +		volatile load_t val;					\
> +									\
> +		val =3D *(load_t *)(p + off);				\
> +		(void)val;						\
> +		return 0;						\
>  	}								\
>  	SEC(type)							\
>  	__description(type ": reject variable offset ctx access")	\
>  	__failure __msg("variable ctx access var_off=3D")			\
> -	__naked void no_rewrite_##name##_var(void)			\
> +	int no_rewrite_##name##_var(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r6 =3D r1;						\
> -		call %[bpf_get_prandom_u32];				\
> -		r1 =3D r6;						\
> -		r0 &=3D 4;						\
> -		r1 +=3D r0;						\
> -		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> -		r0 =3D 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm(bpf_get_prandom_u32)				\
> -		: __clobber_all);					\
> +		__u64 off_var =3D bpf_get_prandom_u32();			\
> +		char *p =3D ctx;						\
> +									\
> +		off_var &=3D 4;						\
> +		p +=3D off_var;						\
> +		return *(load_t *)p;					\
>  	}								\
>  	SEC(type)							\
>  	__description(type ": reject negative offset ctx access")	\
> -	__failure __msg("negative offset ctx ptr")			\
> -	__naked void no_rewrite_##name##_neg(void)			\
> +	__failure __msg("invalid bpf_context access")			\
> +	int no_rewrite_##name##_neg(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r1 +=3D %[__neg_off];					\
> -		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> -		r0 =3D 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm_const(__neg_off, -(off))			\
> -		: __clobber_all);					\
> +		char *p =3D ctx;						\
> +									\
> +		p -=3D 612;						\
> +		return *(load_t *)p;					\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper read ctx at fixed offset")	\
> +	__failure __msg("dereference of modified ctx ptr")		\
> +	int no_rewrite_##name##_helper_read_fixed(void *ctx)		\
> +	{								\
> +		char *p =3D ctx;						\
> +									\
> +		p +=3D off;						\
> +		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper write ctx at fixed offset")	\
> +	__failure __msg("dereference of modified ctx ptr")		\
> +	int no_rewrite_##name##_helper_write_fixed(void *ctx)		\
> +	{								\
> +		char *p =3D ctx;						\
> +									\
> +		p +=3D off;						\
> +		return bpf_probe_read_kernel(p, 4, 0);			\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper read ctx with variable offset") \
> +	__failure __msg("variable ctx access var_off=3D")			\
> +	int no_rewrite_##name##_helper_read_var(void *ctx)		\
> +	{								\
> +		__u64 off_var =3D bpf_get_prandom_u32();			\
> +		char *p =3D ctx;						\
> +									\
> +		off_var &=3D 4;						\
> +		p +=3D off_var;						\
> +		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper write ctx with variable offset") \
> +	__failure __msg("variable ctx access var_off=3D")			\
> +	int no_rewrite_##name##_helper_write_var(void *ctx)		\
> +	{								\
> +		__u64 off_var =3D bpf_get_prandom_u32();			\
> +		char *p =3D ctx;						\
> +									\
> +		off_var &=3D 4;						\
> +		p +=3D off_var;						\
> +		return bpf_probe_read_kernel(p, 4, 0);			\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper read zero-sized ctx access") \
> +	__failure __msg("R4 type=3Dctx expected=3Dfp")			\
> +	int no_rewrite_##name##_helper_read_zero(void *ctx)		\
> +	{								\
> +		return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);	\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper write zero-sized ctx access") \
> +	__failure __msg("R1 type=3Dctx expected=3Dfp")			\
> +	int no_rewrite_##name##_helper_write_zero(void *ctx)		\
> +	{								\
> +		return bpf_probe_read_kernel(ctx, 0, 0);			\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject kfunc ctx at fixed offset")	\
> +	__failure __msg("dereference of modified ctx ptr")		\
> +	int no_rewrite_##name##_kfunc_fixed(void *ctx)		\
> +	{								\
> +		char *p =3D ctx;						\
> +									\
> +		p +=3D off;						\
> +		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
> +		return 0;						\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject kfunc ctx with variable offset")	\
> +	__failure __msg("variable ctx access var_off=3D")			\
> +	int no_rewrite_##name##_kfunc_var(void *ctx)			\
> +	{								\
> +		__u64 off_var =3D bpf_get_prandom_u32();			\
> +		char *p =3D ctx;						\
> +									\
> +		off_var &=3D 4;						\
> +		p +=3D off_var;						\
> +		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
> +		return 0;						\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject kfunc zero-sized ctx access")	\
> +	__failure __msg("R1 type=3Dctx expected=3Dfp")			\
> +	int no_rewrite_##name##_kfunc_zero(void *ctx)			\
> +	{								\
> +		bpf_kfunc_call_test_mem_len_pass1(ctx, 0);		\
> +		return 0;						\
>  	}
> =20
> -no_rewrite_ctx_access("syscall", syscall, 4, u32);
> -no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
> -no_rewrite_ctx_access("tracepoint", tp, 8, u64);
> -no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
> -no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
> -no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64);
> -no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
> -no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx=
, skb), u64);
> +no_rewrite_ctx_access("kprobe", kprobe, 8, __u64);
> +no_rewrite_ctx_access("tracepoint", tp, 8, __u64);
> +no_rewrite_ctx_access("raw_tp", raw_tp, 8, __u64);
> +no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, __u64);
> +no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, __u64)=
;
> +no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, __u32);
> +no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx=
, skb), __u64);
> =20
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 94edbd2afa67..f91b484d80f2 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -716,6 +716,7 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER=
_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
>  BTF_ID_FLAGS(func, bpf_kfunc_common_test)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQU=
IRE)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE=
)
> @@ -1280,7 +1281,6 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
> -BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL=
)

