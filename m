Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78B443AB1
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695195; cv=none; b=afm09v0GHAaMNbeefIU5F6jFzWxnBuFxF0FtoBbqtzNHPgBKiwKqoirX3/wS+CWsTIujXUd/2f9ZIPdX1qTLUAcnhctRL8vspH2mAgiLlVT+VJbpT/ljJAAZA2BR6JAHuETm8EXhSMD1aXyjKEhBV16kG/28OMf4tGiJ7ycnLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695195; c=relaxed/simple;
	bh=RChafyxXqSEhFI4oxVwkH82GBLQ2VxhBs0QktHN7qVE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jDi4mcQIHyX3GUoZPZKW1v66N0JU5x2BKg2maX3flKrdu6crFpwi8OSb5YUtkFlYqds5DnxacIaqltlv4OroDv6UFBcFSiDr9hqWXvN1aeyiO8hcf+naRsJA8JlMAux+QgIRIeN9TjUmevKdEcqWLq6LzGkjk/B5tKWC+XUEjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh0hfl+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh0hfl+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C494E1F00A3A;
	Tue, 25 Aug 2026 21:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695194;
	bh=Y6FO2x/tiyZlLs74rIn74PIIMbvPrYDsmnXQEP0jb/g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Zh0hfl+dKVXElVsZPKkuiZJWYB+jJX/ZCNGvWXKSkQpV/KY/DFADqBgqGzcdhCzNp
	 GpDlz4e7evB/7y/jsQxDJP/01Y/vzjXORZUT/knSBxuikKfhnknORRal9loEXUZsER
	 NR4DYHwjKcBxhYSN/k3EP2rMN6a3+PbxvOqcmhxW653co1myiayNUj98beUfXamPe5
	 J3gqGsC0IjEEPwPBc7XhbHMht4HYS8FzMbiMDtkso0SCgD75v96cTrUNPSfqufMjHD
	 FXQfV8zvvk7Xm/qbJO96FNyqtRefIZjylzr2tvDuhQnyHUP++rS0uVrcAzGT+KImQ3
	 bwsbRxhs0ba0Q==
Content-Type: multipart/mixed; boundary="===============4412564882919218880=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6211bca923f58d1bbb9404cec8a518c0c2b508799853fd4879403d1edc1641c6@mail.kernel.org>
In-Reply-To: <20260825205458.1325916-1-yonghong.song@linux.dev>
References: <20260825205458.1325916-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 09/10] selftests/bpf: Test global functions returning arena pointers by value
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 21:59:53 +0000 (UTC)

--===============4412564882919218880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> index 6f66fc822cede..237adb8e5ee1e 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf_arena_common.h>
>  #include "bpf_misc.h"

[ ... ]

> @@ -234,4 +235,121 @@ __naked int aggregate_ret_global_union_ptr_fail(void)
>
>  #endif
>
> +/*
> + * gcc returns a by-value struct through a hidden pointer, and emits the
> + * 'r0 = r1' returning it after the __naked body's exit, leaving the
> + * subprogram falling through. Build these with clang only.
> + */
> +#if defined(__clang__)

Should this use the same clang version check as the structurally identical
block at line 178? That block checks '#if defined(__clang_major__) &&
__clang_major__ >= 23' for __naked functions returning by-value structs:

aggregate_ret_func.c:178
#if defined(__clang_major__) && __clang_major__ >= 23
...
__naked struct with_ptr global_ret_struct_ptr(void)
{
	asm volatile (
	"r0 = 0;"
	"r2 = 0;"
	"exit;"
	);
}

SEC("tc")
__load_if_JITed()
__failure __msg("has unsupported return type")
__naked int aggregate_ret_global_struct_ptr_fail(void)
{
	asm volatile (
	"call %[global_ret_struct_ptr];"
	"r0 = 0;"
	"exit;"
	:
	: __imm(global_ret_struct_ptr)
	: __clobber_all);
}

The verifier_arena.c hunk added in this same commit also uses the '>= 23'
guard:

verifier_arena.c:737
#if defined(__clang_major__) && __clang_major__ >= 23

struct arena_page_pair {
	u32 __arena *first;
	u32 __arena *second;
};

__weak struct arena_page_pair split_arena_page(u32 __arena *page)
{
	...
}

By-value struct returns in registers are an LLVM 23 BPF-ABI feature. With
an older clang, the return is lowered through a hidden pointer (sret), which
is the gcc behavior described in your new comment.

With clang < 23, the four new '__success __retval(0)' tests would be
compiled against a different signature than intended. The callers never
initialize r1, so they would be checked against a prototype that no longer
matches 'returns struct arena_pair' in the BTF.

Can the two adjacent blocks be consistent about which toolchains can build
the same construct?

> +
> +struct arena_pair {
> +	void __arena *lo;
> +	void __arena *hi;
> +};
> +
> +struct arena_and_scalar {
> +	void __arena *p;
> +	__u64 x;
> +};
> +
> +struct arena_array {
> +	void __arena *p[2];
> +};
> +
> +struct arena_single {
> +	void __arena *p;
> +};
> +
> +__naked struct arena_pair global_ret_arena_pair(void)
> +{
> +	asm volatile (
> +	"r0 = 0;"
> +	"r2 = 0;"
> +	"exit;"
> +	);
> +}
> +
> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +__naked int aggregate_ret_global_arena_pair(void)
> +{
> +	asm volatile (
> +	"call %[global_ret_arena_pair];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(global_ret_arena_pair)
> +	: __clobber_all);
> +}
> +
> +__naked struct arena_and_scalar global_ret_arena_and_scalar(void)
> +{
> +	asm volatile (
> +	"r0 = 0;"
> +	"r2 = 0;"
> +	"exit;"
> +	);
> +}
> +
> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +__naked int aggregate_ret_global_arena_and_scalar(void)
> +{
> +	asm volatile (
> +	"call %[global_ret_arena_and_scalar];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(global_ret_arena_and_scalar)
> +	: __clobber_all);
> +}
> +
> +__naked struct arena_array global_ret_arena_array(void)
> +{
> +	asm volatile (
> +	"r0 = 0;"
> +	"r2 = 0;"
> +	"exit;"
> +	);
> +}
> +
> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +__naked int aggregate_ret_global_arena_array(void)
> +{
> +	asm volatile (
> +	"call %[global_ret_arena_array];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(global_ret_arena_array)
> +	: __clobber_all);
> +}
> +
> +__naked struct arena_single global_ret_arena_single(void)
> +{
> +	asm volatile (
> +	"r0 = 0;"
> +	"exit;"
> +	);
> +}
> +
> +SEC("tc")
> +__success __retval(0)
> +__naked int aggregate_ret_global_arena_single(void)
> +{
> +	asm volatile (
> +	"call %[global_ret_arena_single];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(global_ret_arena_single)
> +	: __clobber_all);
> +}
> +
> +#endif
> +
>  char _license[] SEC("license") = "GPL";

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============4412564882919218880==--
