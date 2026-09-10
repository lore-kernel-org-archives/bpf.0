Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE566379C38;
	Thu, 10 Sep 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061527; cv=none; b=rTqV/9dgfhjURtLTA1kX+cduo8mreIzzn1Cd/hdIFREiOI2hNfGFQHlSQDZuI/w2uluFdr+JvlakFy2+w6d1X5AYlTV61e2qsVIg2gejRl2Or24MTK1MXf4gJjh3/ECBjT92EFh5Dmfd2plwWQdbEjjUs7U1dcR0Kr4ZYPIY3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061527; c=relaxed/simple;
	bh=wn98Rf+xIKl7CgU1Pd6n6Du5LiKaOFE79M+/INol3o0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ARxqjoZIm/zPEfPcSxzkJV6jzvcqVg0abJIhXpvs8OuqpYlGZUPAGbPreS9O+5sw48FapvkzwrZAPIkTf4FjpQlYtt8viDk4EXk5f/5KU2/OQjERiJtZDhnj6xjAlGXCpnuq7824h6uC1gfZur2ViNkC9ttFuIxQnikCLgfhRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNuq3zJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNuq3zJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD41B1F000FF;
	Thu, 10 Sep 2026 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061518;
	bh=XBWd5a1baKVVGjc60vmyk8euEKGz7sNc7E8iI0dCnJI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HNuq3zJ0Xkvl5/cbrAXQQk/hP1lfgvRbzIelo6gaggo/mkcI8ib52p2TkY2i7WYze
	 eRwPmiLpxtfWCGuJ1lSiJ/RWwr29E/J+uu6PwBPCEOgwPn4kXLBApojX9gyGtvIlUx
	 zOzcpYkibtYIM+3+riJDtU3E8Z1V0wmnL003BuofERhZCixY0bbdWgFAOlhjDDCsJq
	 2uxACXsrN4jd20IOW4Ec8hLVYD7a7tIvkFyZcixGUVbfILSszHHiAE1jiy2Plc6+Pa
	 aTZTAGTyp7RQrenYmv5vO9fV7vVKxriQ/Qo96GXdrV73VdeA7zWJ50IZVnDKyhQPZi
	 VRdSUF1UzJ7qg==
Content-Type: multipart/mixed; boundary="===============0318246652260204799=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f5c0c236ba1f062cb0ab363bf6672e7aef2c278ba7193bef5891ab18d86c9b38@mail.kernel.org>
In-Reply-To: <20260910164635.459558-11-vineet.gupta@linux.dev>
References: <20260910164635.459558-11-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: cover the low-32 link for narrowing stack fills
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 17:31:57 +0000 (UTC)

--===============0318246652260204799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index 9d060d8b0c1f..e8a44e7579c8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> @@ -966,6 +966,88 @@ __naked void zext_mov_breaks_add_const_src(void)
>  	: __clobber_all);
>  }
>
> +/*
> + * A narrowing fill keeps only the slot's low 32 bits, so a later narrowing of
> + * the spilled value must still reach the filled register. Same relation as a
> + * 32-bit mov from a wide source, with the stack slot as the base.
> + */
> +SEC("socket")
> +__success
> +__naked void zext_fill_narrow_from_wide_spill(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
> +	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
> +	r2 = *(u32 *)(r10 - 8);	/* narrowing fill, forms the link */ \
> +	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
> +	if r2 == 0 goto 1f;					\
> +	r0 /= 0;						\
> +1:								\
> +	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/*
> + * A full-width fill of a wide slot is a plain 64-bit equality, not a low-32
> + * link, so it must keep propagating exactly as before.
> + */
> +SEC("socket")
> +__success
> +__naked void zext_fill_full_width_keeps_full_link(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r6 |= r0;						\
> +	*(u64 *)(r10 - 8) = r6;					\
> +	r2 = *(u64 *)(r10 - 8);	/* no narrowing */		\
> +	if r6 != 0 goto 1f;					\
> +	if r2 == 0 goto 1f;					\
> +	r0 /= 0;						\
> +1:								\
> +	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/*
> + * A sub-word fill is below the low-32 model, so no link is formed and the
> + * relation is dropped as before.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__naked void zext_fill_byte_forms_no_link(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r6 |= r0;						\
> +	*(u64 *)(r10 - 8) = r6;					\
> +	r2 = *(u8 *)(r10 - 8);	/* 1-byte fill: no link */	\
> +	if w6 != 0 goto 1f;					\
> +	if r2 == 0 goto 1f;	/* not deduced */		\
> +	r0 /= 0;						\
> +1:								\
> +	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  #ifdef CAN_USE_MOVSX

Should the guard here be checking for LDSX support instead? The two
programs added below (sext_fill_narrow_from_wide_spill and
fill_kinds_reach_different_values) both use BPF_LDX | BPF_MEMSX
instructions (`r2 = *(s32 *)(r10 - 8)`), not MOVSX.

Other LDSX users in the suite gate on the LDSX feature - for instance,
verifier_ldsx.c checks:

    (__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))

The two macros happen to align for clang >= 18 and gcc-bpf -mcpu=v4, but
a compiler advertising MOVSX without LDSX would fail to build these
programs rather than skipping them.

[ ... ]

> @@ -1129,6 +1211,68 @@ __naked void sext_kinds_reach_different_values(void)
>  	: __clobber_all);
>  }
>
> +/*
> + * The sign-extending counterpart: the filled register is the sign extension of
> + * the slot's low 32 bits, so a narrowing of those bits arrives sign-extended.
> + */
> +SEC("socket")
> +__success
> +__naked void sext_fill_narrow_from_wide_spill(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
> +	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
> +	r2 = *(s32 *)(r10 - 8);	/* narrowing sx fill */		\
> +	if w6 != -1 goto 1f;	/* narrows r6, propagates to r2 */ \
> +	if r2 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
> +	r0 /= 0;						\
> +1:								\
> +	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/*
> + * The same, for the two fill kinds off one slot.
> + */
> +SEC("socket")
> +__failure __msg("div by zero")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void fill_kinds_reach_different_values(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 = r0;						\
> +	r6 &= 1;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r8 = r0;						\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<= 32;						\
> +	r8 |= r0;						\
> +	*(u64 *)(r10 - 8) = r8;					\
> +	if r6 >= 1 goto 2f;					\
> +	r2 = *(s32 *)(r10 - 8);	/* sign-extending fill */	\
> +	goto 1f;						\
> +2:								\
> +	r2 = *(u32 *)(r10 - 8);	/* zero-extending fill */	\
> +1:								\
> +	if w8 != -1 goto 3f;					\
> +	if r2 == -1 goto 3f;	/* only the sign-extending path */ \
> +	r0 /= 0;						\
> +3:								\
> +	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  #endif /* CAN_USE_MOVSX */
>
>  char _license[] SEC("license") = "GPL";

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282
--===============0318246652260204799==--
