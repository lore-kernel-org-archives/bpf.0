Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163455;
	b=O0vl7JFeiWJ6E6Y4/1eUUD/JuZmVa9r+dqbs9At+cA44SGQpoF0MMA8q63ySGBiGgMls
	 NZE5T2aAtRl2Az8oHYao55UQ1CiFE6nD9d3sbIGqJCAkuKl033ht1/Hd6Fe1BIfDYj0zY
	 odzHRfVf39Dp/K4YXthHo645fySD3Vyk7tzykmCEKhw8JEK7tJ0Q0d+PWEHehnWfPdapU
	 jY1fSdIAwyG0J/nNkG8YC1/GroVfwqjhdiAajqKMXp1+qvR4GtVuyrDfOdguyejyUICkl
	 jyvBfg5tAQjvewynHbgAe9lIhTj/LtVIjQwUDYG/2Rfgr0QhLTaWRaRS0vgEsyYaTxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163455;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eh8R7+dC6/ftlA8tf2l7I7+fTaeyoIYGng1ePMe/hRg=;
	b=h2P6cLeum/RtcuGKWawBI9aBQJzkBJb9at3Tmj2vQwn1moKoEbtEfF0e36/I/SZ1zIL5
	 0VlR5GE6NTOooQe6H2LCT8ZuZxyA0/ka7ZD7rsG78+nWhudbe5P8FUsNFsPLwMR9b5wPf
	 CNcvzw/aMUM3NDL7qz8yS4K6M5WbP2JTbeDlq1swTAYnXW8B6JPoanSS6p1Dplit2D1nS
	 j9PIyZyfwMs35KNFOCUXnm0l8j5Srn7xuV7x54zvaNLjVzEwpivI7x1N5B3sl6gAVmMoD
	 2sTeH1WVELZtgayuCMSHzHKM4xkhWZW6E6b/+OyolItF5CzQZy/YS3WKzYegVbxaIsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mb1cslqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C8606A330
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mb1cslqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56A81F000C6;
	Fri, 20 Nov 2026 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163454;
	bh=eh8R7+dC6/ftlA8tf2l7I7+fTaeyoIYGng1ePMe/hRg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mb1cslqqqHrVpnkgzjtoVJeTINlVosWqvKTvyC/NgA3lPBSHy9iVwO5V9aI/Sv/6M
	 RsxXGuRKtu9GMCt08NU85qqkHjmo71Zr2m95B0ZuOvpdW2GXeQCH5VfYsd5y902+Yg
	 JN9NlU6/QxqffkodYdkMb/Qfz05JOptsJKgap9KfaXKxedj+96oShzhKRW/3IOiYlT
	 JFyCGEKWVylECbK0C9KJbUHupGWakeLcYHJx26TXVkfZqJfnyWDqA39VwvbObd8lFE
	 Xv4H8vwwPuK1phlwok846Hr7QOTKhKooVfeFZRzdGG6q9kKzmHDyRjuL532G+DEqua
	 qc/nqZPNZvmIw==
Message-ID: <sashiko-outbox-224738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 47/49] selftests/bpf: Test passes, instances,
 precision and the failing path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-48-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-48-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:30:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: premature #endif around loads_6th() in
  verifier_passes.c
--

commit ef0b2c0eaafb6e699dfff5dd0c5556a322cf2fa1
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test passes, instances, precision and the failing path

This commit adds BPF verifier selftests covering verification passes,
partitions, loop peeling, call instances, precision tracking, and
failing-path diagnostics.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_passes.c b/tools/=
testing/selftests/bpf/progs/verifier_passes.c
> new file mode 100644
> index 0000000000000..a6edb33d0014b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_passes.c
> @@ -0,0 +1,3636 @@

[ ... ]

> +/* clang ignores the arguments of a naked function */
> +#if defined(__clang__) || defined(__BPF_FEATURE_STACK_ARGUMENT)
> +static __naked __noinline __used long loads_6th(long a, long b, long c, =
long d, long e, long f)
> +{
> +	/* r0 =3D *(u64 *)(r11 + 8) */
> +	asm volatile (".8byte 0x8b079; exit;" ::: __clobber_all);
> +}
> +
> +SEC("tc")
> +__description("log: one report for a stack argument that is not there")
> +__failure __msg("callee expects 6 args")
> +__msg("Verification failed") __not_msg("Verification failed")
> +__load_if_JITed()
> +__arch_x86_64 __arch_arm64
> +__naked void log_of_missing_stack_arg(void)
> +{
> +	asm volatile ("r1 =3D 1; r2 =3D 2; r3 =3D 3; r4 =3D 4; r5 =3D 5; call l=
oads_6th; exit;"
> +		      ::: __clobber_all);
> +}
> +#endif
> +
> +/* *(u64 *)(r11 - 8) =3D imm */
> +#define STORE_6TH(imm)	".byte 0x7a; .byte 0xb; .short -8; .long " #imm "=
;"
> +#define ARGS_1_TO_5	"r1 =3D 1; r2 =3D 2; r3 =3D 3; r4 =3D 4; r5 =3D 5;"
> +
> +/* r7 is 0..15 with the argument, and add..add + 15 without it */
> +#define STORE_ON_ONE_PATH(add)						\
> +	"call %[bpf_get_prandom_u32];"					\
> +	"r7 =3D r0;"							\
> +	"r7 &=3D 15;"							\
> +	"call %[bpf_get_prandom_u32];"					\
> +	"if r0 =3D=3D 0 goto 1f;"						\
> +	STORE_6TH(1)							\
> +	"goto 2f;"							\
> +"1:	r7 +=3D " #add ";"						\
> +"2:	if r7 > 7 goto 9f;"						\
> +	ARGS_1_TO_5							\
> +	"call loads_6th;"						\
> +	EXIT_AT_9
> +
> +SEC("tc")
> +__description("deps: only one state has the stack argument")
> +__success
> +__load_if_JITed()
> +__arch_x86_64 __arch_arm64
> +__naked void stack_arg_on_one_path(void)
> +{
> +	ASM(STORE_ON_ONE_PATH(8));
> +}
> +
> +SEC("tc")
> +__description("deps: the state without the stack argument gets to the ca=
ll")
> +__failure __msg("callee expects 6 args")
> +__load_if_JITed()
> +__arch_x86_64 __arch_arm64
> +__naked void stack_arg_on_one_path_bad(void)
> +{
> +	ASM(STORE_ON_ONE_PATH(7));
> +}
> +
> +/* x * x - 21 * x + 110 is 0 for 10 and for 11 */
> +static __naked __noinline __used long roots_of_6th(long a, long b, long =
c, long d, long e, long f)
> +{
> +	/* r6 =3D *(u64 *)(r11 + 8) */
> +	ASM(".8byte 0x8b679;"
> +	VALUE_IN_R9
> +	"r1 =3D r6;"
> +	"r1 *=3D r6;"
> +	"r6 *=3D 21;"
> +	"r1 -=3D r6;"
> +	"r1 +=3D 110;"
> +	"r9 +=3D r1;"
> +	"r0 =3D *(u8 *)(r9 + 63);"
> +	EXIT_AT_9);
> +}
> +
> +#define ROOTS_ON_STACK(second)						\
> +	"call %[bpf_get_prandom_u32];"					\
> +	STORE_6TH(10)							\
> +	"if r0 =3D=3D 0 goto 1f;"						\
> +	STORE_6TH(second)						\
> +"1:"	ARGS_1_TO_5							\
> +	"call roots_of_6th;"						\
> +	"exit;"
> +
> +SEC("tc")
> +__description("keep_disjoint_apart: a stack argument")
> +__success
> +__load_if_JITed()
> +__arch_x86_64 __arch_arm64
> +__naked void disjoint_stack_arg(void)
> +{
> +	ASM(ROOTS_ON_STACK(11));
> +}
> +
> +SEC("tc")
> +__description("keep_disjoint_apart: a stack argument is no root")
> +__failure __msg("invalid access to map value, value_size=3D64 off=3D65 s=
ize=3D1")
> +__load_if_JITed()
> +__arch_x86_64 __arch_arm64
> +__naked void disjoint_stack_arg_bad(void)
> +{
> +	ASM(ROOTS_ON_STACK(9));
> +}

[Severity: Medium]
Should the #endif after log_of_missing_stack_arg() be moved below
disjoint_stack_arg_bad()?  When building with bpf-gcc without
__BPF_FEATURE_STACK_ARGUMENT, loads_6th() is not defined for
STORE_ON_ONE_PATH, and roots_of_6th() declares six parameters outside the
guard, breaking compilation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D47
