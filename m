Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B3175A74
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547662; cv=none; b=aVf94s8b/jWGx6RHAgPyxuWQZhwCVhuOAXP2020LOfLEd6lADVBtsS4PBQmv7244IijEVnZtshlCGZim0bwyHsuOEmPHTty074nEb5EuOpBgT3b79y7s+LqcmbicPfzDbd7F9khcdVlqG0SO3leDnRBRvUfz7cWZqyqywiGGbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547662; c=relaxed/simple;
	bh=pWTQ7nn3cpndcudPS/VgOfUj6Pr80h6G09MufYQwdsg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ijTvD+PVDpMEarDFRR3Kf1Cn61ztYKzvyDxt8QpNe+Btgc2nnaNgFJ6h//5YDofyFmBa5xYeVp3HGE4C96CkRXSNk61De5z8iP8Ou2i9H8FoMNeJeUJACcdTJvmOIyvl7d3bkAxoaWPPztS/r0mytXzhzAbXDJQmA78qxb7bLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ACAkG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ACAkG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433E91F00893;
	Fri,  9 Oct 2026 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547658;
	bh=fvPsbpCZu+JPqGGn1WP47IrrmsCyvb6/MW+hXn1qLxA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P4ACAkG4nRcm4+I+79EB8o5hKO4tsqmDN23nNdVHd1td0iOgNPiunzoWeO0qWZUz1
	 zAyuMzHWDOwffcbgRVhULYKABXuS7nzcNPenhlUeKHR4p9anB1dWBxg6Wuy4D3Skfq
	 XLS4MoQlOcC0SHi60kvx7dDzGN2E5qpUO8+shYsTTrJ22pMMoq92yLe4HoN/+tysPm
	 mNW8roIzPxLQSRJtVJTlgefJTwWuDg/DkAo8BoQ+b8sW23BTQUU03PDxPC2oBSFV48
	 /mjW50EHZbpTGxEhj0hE/alZDNWqaUVkRgrqhrYt9s+aVLhGBikmsU3VKb3WVx4Kqp
	 CbXBnx6SJPiEA==
Content-Type: multipart/mixed; boundary="===============8136878846837868456=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4529fd5f4041ff049e3af1d58a1d94a229fb4a63c0ccf6e9295c470ec2ec4148@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-48-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-48-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 48/51] selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:37 +0000 (UTC)

--===============8136878846837868456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID

TL;DR: Test issue: byte_array_size_spanning may fail with a misaligned-access
message instead of the expected one on strict-alignment architectures
(riscv64, mips, loongarch); it may need __flag(BPF_F_ANY_ALIGNMENT).

> diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
> new file mode 100644
> index 000000000000..be001cc77f81
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c

[ ... ]

> +/*
> + * bytes[i], i in [0, 31], read as 4 bytes: min_off is valid within the array,
> + * but the 4-byte read at max_off runs past the array end. Exercises the
> + * size-aware bound in btf_struct_access().
> + */
> +SEC("syscall")
> +__failure
> +__msg("invalid variable offset access into struct outer")
> +int byte_array_size_spanning(void *ctx)
> +{
> +	unsigned long i = bpf_get_prandom_u32();
> +	struct outer *o;
> +	int val = 0;
> +
> +	o = bpf_obj_new(typeof(*o));
> +	if (!o)
> +		return 0;
> +	asm volatile ("						\
> +	r1 = %[o];						\
> +	r2 = %[i];						\
> +	r2 &= 31;						\
> +	r1 += r2;						\
> +	%[val] = *(u32 *)(r1 + 64);				\
> +"	: [val] "=r"(val)
> +	: [o] "r"(o), [i] "r"(i)
> +	: "r1", "r2");
> +	bpf_obj_drop(o);

byte_array_size_spanning() does a 4-byte load at a variable offset,
var_off (0x0; 0x1f) + 64, and expects btf_struct_access() to reject it with
"invalid variable offset access into struct outer".

check_mem_access() calls check_ptr_alignment() before it reaches
check_ptr_to_btf_access(), and bpf_check() turns on strict alignment when
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set:

    env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
    if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
        env->strict_alignment = true;
    if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
        env->strict_alignment = false;

On such configurations (riscv64 with the default
RISCV_PROBE_UNALIGNED_ACCESS, mips, loongarch with ARCH_STRICT_ALIGN) the
load would be rejected first with:

    misaligned access off (0x0; 0x1f)+64 size 4

__failure would still hold, but __msg("invalid variable offset access into
struct outer") would not match.

Should this test add __flag(BPF_F_ANY_ALIGNMENT), as the negative tests in
verifier_array_access.c do when their expected message isn't about
alignment, so the size-aware bound is what gets checked on every
architecture?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============8136878846837868456==--
