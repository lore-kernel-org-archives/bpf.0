Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087236894B
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742121; cv=none; b=M47D8s0HMPlm/p1FiMXJ9MiQRaKK+k4Renp0spY+kFncw3P94IkFAqS+w8+P654B6wMVDFH9rdr8BNW6eJD+r7BrOfV6aGv4U7o8Jj2KgPDn/wixUAXVIkKXlTsim/1kB5x/sEfAniMOSYxcq3Bb4dAIzIIN66H2A8klMGirlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742121; c=relaxed/simple;
	bh=eChulkwN3fBQz0JrBePH7FhGY2/hCzCeXKDFzVhiwAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mUjfKedDlRePE+hIES/nEaisIW9VW4bAaSXiEBXlN6him8uhufn305NNnSG0NCuxscUYoK1QfamWNeYmjuHNnBn6f/nhU8fNhSm4QNdHRrxOJ6ios4MBUeuNSG1QLnKEZYt5r7Y2vf7YDS0hAjt9/yJx4MV4sDuEVwWwzHkCoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqtloQhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqtloQhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DE71F00A3A;
	Mon, 29 Jun 2026 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742120;
	bh=e4hxOxf/YcpAJvukBnqtEz8zFiQt9EMvJPFluTmM+xI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VqtloQhxg8wTGH5f+BtCZcof8BvN+EH9iaF1B62QNSupMCx7gniiWgpSmEfDh0PK9
	 XxZdcyHfz/SFVxGBlf9BMrOpn4G50X4Pi3enTf8BHS/EZJQZiSxGr2WpCsDDar3hXH
	 7C9/5xAimsOo+Oh+rlwWn4lJclgEn0PiR8hJKi2QAszd92QUsNW+llN/QEFW6AmTLm
	 ap8461EyLvG13hFeGAF89GchkjuHG9DnFgd4MkcvgG3TNxHbb4xO/i0Rj2TIU9DvU5
	 XlbEcaVtrymW96Ed10IR7qq5eXvngD70YnwZo8HfPr1QdLI2X7ii8q7B3IxKhLXVmj
	 YpuMSRYOgrsDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/6] riscv, bpf: Remove redundant
 ctx->offset initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629140048.733346-3-pulehui@huaweicloud.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <20260629140048.733346-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:08:39 +0000
Message-Id: <20260629140839.D2DE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Buffer Overflow / JIT Convergence Failure due to violated mono=
tonic shrinking guarantee
--

commit 1c7e15d4942628f7431314e8bb5d6ca1fb3134f1
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Remove redundant ctx->offset initialization

This commit removes the loop initializing ctx->offset and prev_ninsns in
bpf_int_jit_compile, operating under the assumption that the implicit
zero-initialization is sufficient and the manual setup is redundant.

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -79,11 +79,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifi=
er_env *env, struct bpf_pr
>  	if (build_body(ctx, extra_pass, NULL))
>  		goto out_offset;
> =20
> -	for (i =3D 0; i < prog->len; i++) {
> -		prev_ninsns +=3D 32;
> -		ctx->offset[i] =3D prev_ninsns;
> -	}
> -

[Severity: Critical]
Could removing this worst-case initialization loop cause a regression by
breaking the monotonic shrinking guarantee of the JIT convergence algorithm?

When ctx->offset is simply zero-initialized, forward branches will initially
evaluate to a zero or negative distance in the first pass. This causes the
JIT to emit short branch instructions. As targets resolve to their actual
positive offsets in subsequent passes, these branch distances increase,
which forces the JIT to expand the branch instructions.

Can this lead to a situation where a branch expands while another shrinks
by the same amount, resulting in a net zero size change for that pass?

If the JIT falsely detects convergence because ctx->ninsns equals
prev_ninsns, it allocates a fixed-size executable buffer based on that
length. In the final emission pass, if internal offsets shift again and
cause a branch to expand unexpectedly, would this result in an out-of-bounds
write past the allocated buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629140048.7333=
46-1-pulehui@huaweicloud.com?part=3D2
