Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD393A8741
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901180; cv=none; b=Pe8BMidcHgm5KKA3C0wuZSWr+DXPwdDAjqEKpDpo9+HV4WxPduMT+w/glJ5Ucvs+fstUdnwEeHqen+5RcLlFkjuBj8G/jPp07nWF+n09Iyg3XNDU+3HfdH3sYIqzAAqlsDE50LeSdutpwa1h4rLzrSdRNgDwkbLO4DNwEYLwGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901180; c=relaxed/simple;
	bh=LU9L02kowGpNnB5MXU5rmt8ZMZk5riYW8QfW6X+Q904=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amrTO70JsFes80JA125EEqkfWgzGYU/AiDSAXuokEWmMHPHtk2DYDmeYEz8XXhMvZTMYZW8nir9642TUZHD1nsQkA6sR0ikL0cVMf6fqcTMMhbsQsOvm6mqFlTyn6QeVpBnD0X5we1ZbWTUR47GBqGTLs/Is9k3AvIS7GIh5Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fa2/Vd3g; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fa2/Vd3g"
Message-ID: <549d58c6-05f0-4176-98ec-c88e96ee4375@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779901166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5Uv03Ujj428n5sCQ9PwAg+yJsQrd1cz70XxOo1jmLc=;
	b=Fa2/Vd3gbi6YG8N2SewLk8TSArhbXjjruuc5wEBR7DpmJZi/2w0Wd3DgAYf7YoWnGYG7ER
	Bb6lIk3acqxivK4o7CBx7lzZ8OjtAG9hiDxI+ywSURuSjaLa/y6T9gKRsq39l2ytutu+nP
	V0mcUDp0Tiv/YG4XN1BWZ7oAPYYwqaM=
Date: Wed, 27 May 2026 09:59:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/1] bpf: reject overlarge global subprog argument
 sizes
Content-Language: en-GB
To: Taegu Ha <hataegu0826@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260527052539.3388700-1-hataegu0826@gmail.com>
 <20260527052539.3388700-2-hataegu0826@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260527052539.3388700-2-hataegu0826@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/26/26 10:25 PM, Taegu Ha wrote:
> Global subprogram argument checking derives generic pointer sizes from BTF
> and passes the resolved size to check_mem_reg() as a u32. The access-size
> validation path then uses a signed int, and stack pointers negate the value
> before calling check_helper_mem_access().
>
> A BTF type such as int[0x3fffffff] resolves to 0xfffffffc bytes. On a stack
> pointer, (int)mem_size becomes -4 and the negation validates only four
> bytes. A caller can therefore pass a four-byte stack slot while the callee
> is verified with a nearly 4GiB memory argument, allowing accesses outside
> the caller object.
>
> This was confirmed with a non-executing raw-BTF reproducer. On a
> vulnerable kernel, the verifier accepted a program where the caller passed
> a four-byte stack slot, while the callee argument was described by BTF as
> int[0x3fffffff]. The verifier log showed:
>
>    R1=mem_or_null(id=1,sz=0xfffffffc)
>    r0 = *(u32 *)(r1 +4)
>
> The program was only loaded to prove verifier acceptance and was not
> attached or executed.
>
> Reject sizes that cannot be represented by the signed verifier access-size
> API before any conversion. Cast the non-stack case after the bound check to
> make the conversion explicit, and add a verifier regression test for the
> oversized BTF argument.
>
> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
> ---
>   kernel/bpf/verifier.c                           |  7 ++++++-
>   .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..1007f204a1f5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7107,6 +7107,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>   	struct bpf_reg_state saved_reg;
>   	int err;
>   
> +	if (mem_size > S32_MAX) {
> +		verbose(env, "R%d memory size %u is too large\n", regno, mem_size);
> +		return -EACCES;
> +	}
> +
>   	if (bpf_register_is_null(reg))
>   		return 0;
>   
> @@ -7119,7 +7124,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>   		mark_ptr_not_null_reg(reg);
>   	}
>   
> -	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
> +	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : (int)mem_size;
>   
>   	err = check_helper_mem_access(env, regno, size, BPF_READ, true, NULL);
>   	err = err ?: check_helper_mem_access(env, regno, size, BPF_WRITE, true, NULL);
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 1e08aff7532e..0ff8f85b4d46 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -151,6 +151,23 @@ int anon_user_mem_valid(void *ctx)
>   	return subprog_user_anon_mem(&t);
>   }
>   
> +__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
> +{
> +	return p ? (*p)[1] : 0;
> +}
> +
> +SEC("?tracepoint")
> +__failure __log_level(2)
> +__msg("R1 memory size 4294967292 is too large")
> +int anon_user_mem_huge_size_invalid(void *ctx)
> +{
> +	int (*p)[0x3fffffff];
> +	int tiny = 42;
> +
> +	p = (void *)&tiny;
> +	return subprog_user_anon_mem_huge(p) + tiny;
> +}

Without verifier.c change, verification is successful.

The objdump:

0000000000000160 <subprog_user_anon_mem_huge>:
; {
       44:       b4 00 00 00 00 00 00 00 w0 = 0x0
;       return p ? (*p)[1] : 0;
       45:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <L0>
       46:       61 10 04 00 00 00 00 00 w0 = *(u32 *)(r1 + 0x4)
<L0>:
       47:       95 00 00 00 00 00 00 00 exit

0000000000000040 <anon_user_mem_huge_size_invalid>:
;       int tiny = 42;
        8:       b4 01 00 00 2a 00 00 00 w1 = 0x2a
        9:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = w1
       10:       bf a1 00 00 00 00 00 00 r1 = r10
       11:       07 01 00 00 fc ff ff ff r1 += -0x4
;       return subprog_user_anon_mem_huge(p) + tiny;
       12:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000060:  R_BPF_64_32  subprog_user_anon_mem_huge
       13:       61 a1 fc ff 00 00 00 00 w1 = *(u32 *)(r10 - 0x4)
       14:       0c 01 00 00 00 00 00 00 w1 += w0
       15:       bc 10 00 00 00 00 00 00 w0 = w1
       16:       95 00 00 00 00 00 00 00 exit

The big 0x3fffffff does not really matter.

> +
>   __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
>   {
>   	return (*p1) * (*p2); /* good, no need for NULL checks */

