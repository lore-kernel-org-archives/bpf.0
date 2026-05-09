Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D927603A
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290214; cv=none; b=LYF/fkngg5Ydm4TFUXnGFFg7SRNJyXgxiKMjz89Wshqc7OSfhcoLNnkr1G/g5IgpEghRAlo7AfAOqxuQX1urMgcj6S+BwUCVJaivAQftbv89rT+u/PQJgEkomZkUL8ZSg/d/dGZLWBNA8IDSAJbYPTCBh1u1kNDHauwyf+1Gql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290214; c=relaxed/simple;
	bh=UjVxRpkTFPRgPXK8KXqw51sAzF2E7fPjZgs229VPeLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHI/iXcqjSG9nYYl6ATODN5jw0jVMGJsbe9fpCplyvaSF8ob5FDVRqZnPzp8xsoBa7Lk2EMuwdU8S4llBU9Lh9Xfd+PRkKuATuyrIXlEp9mWNW9ZxG9EfxzBXmRVzICy9rkewiqrSpcJ+O5h9tnABd6OP6w5oK0HG3vRGx5pho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsook51Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsook51Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DF6C2BCB0;
	Sat,  9 May 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290214;
	bh=UjVxRpkTFPRgPXK8KXqw51sAzF2E7fPjZgs229VPeLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Bsook51Ypd9esLMQGcGrZbHti5k3k1aT/mVDyraloRI2ws0jGvHt+NqY+aKHRxx14
	 tWi0Jnl9B+ptRDIbD11wMfMXXJ3aBmYf8w+Zx/JPn+O4nh9d4RLlmNqXHn89OFVUmf
	 7yk+BwhCBuMbZt/rKhRYf7TLQ3eEW589MV9xDWthvmfaPLbkpBi1ZAhIPw/AAXzkBD
	 lJEJTEKKUL26CIvkb9aUSkcwj6oEvdvl6twvtxlFYQ+Upje/JKY/l4DbASxXr4IB54
	 WPhuBWEJN5CiuPS3Y/AkGhMU2cJpIGVMYZkvtrG/PlIxTDXGiNh3yktnC8JTlhDT3L
	 HQkdoOR4Qw53A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 17/23] selftests/bpf: Add tests for stack
 argument validation
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213135.1138457-1-yonghong.song@linux.dev>
References: <20260507213135.1138457-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 01:30:13 +0000
Message-Id: <20260509013014.A4DF6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional use of the 'r11' register in inline assembly will cau=
se selftest build failures on older Clang compilers.
--

commit 6f66b8fd81d82b7d1f5f683d16976b8d486d440b
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add tests for stack argument validation

This commit adds negative tests to verify that kfuncs properly reject large
structs passed as stack arguments. It also adds tests to ensure the verifier
rejects invalid uses of the r11 register for stack arguments.

> diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/t=
esting/selftests/bpf/progs/stack_arg_fail.c
> new file mode 100644
> index 0000000000000..c6db302549cbd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c

[ ... ]

> +#else
> +
> +SEC("tc")
> +__description("stack_arg_fail: not supported, dummy test")
> +__success
> +int test_stack_arg_big(struct __sk_buff *skb)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
> +SEC("socket")
> +__description("r11 in ALU instruction")
> +__failure __msg("R11 is invalid")
> +__naked void r11_alu_reject(void)
> +{
> +	asm volatile (
> +	"r11 +=3D 1;"

Could these inline assembly blocks using r11 cause build failures on older
Clang compilers?

The r11 register is a relatively new addition to the BPF ISA and LLVM backe=
nd.
Because these naked assembly functions are placed outside of the
__BPF_FEATURE_STACK_ARGUMENT guard, compiling this file with an older
toolchain might result in fatal assembler errors regarding an invalid opera=
nd.

Would it be safer to move these r11 tests inside the feature guard to
maintain selftest compatibility across toolchains?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D17
