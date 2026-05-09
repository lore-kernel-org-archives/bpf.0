Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848B37BE65
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295580; cv=none; b=Yl60sYAHHl+2y+GR5xm7u7BWy1Yt0u4rdt/advg12jvdsQRv6IkodXpHiHgVi0zlsExUXz7JIkyyX7Ws26N64DAgpQiGLQ+Y9vCarzSVZVn1ozYhDZf+c0H+FR2IUNDIhv3EQLJ3wiBRYJ/L5VjYEmgFUy0DBRxdxo4sr4nmrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295580; c=relaxed/simple;
	bh=iJ8opPNnJr639stuL8qkVKXgQmJy31jR1Vum8mfaJbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHQqIIgnyhDmmeJIX2WvSp1GFQuCtJ3z2II/9lMpZUFYp46bE3Fdbs6+9HzwZs/jkvIBmQKwHROjjWrmbbtbR3x8MtZbx/Kaam+4XIK41Ti9F+KD0r14wd+NNELZXbxTWRHIqXiX8RgWx32FNKCo/Hq2wSt5Vv1toRrU144DQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ4tj13u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ4tj13u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86223C2BCB0;
	Sat,  9 May 2026 02:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778295579;
	bh=iJ8opPNnJr639stuL8qkVKXgQmJy31jR1Vum8mfaJbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nZ4tj13uxrMkCCAnbSwtri/wb8+E/gw9quNmibG2p9EQu0A+L8JQI7NBiTgE7sDQT
	 RqzR8b1SCT8e+pmP1blDxEh+GcAV3MRhBcBG5ADUP8U2vCnnOUpwJwHLooxIopdItX
	 z0v1tXppRj5KJjyXCfdRIq4qxkiOF3nI+2nNJNKCm2Ti9Jb1GWgShzKjhWRPaZO64v
	 hdg1FwmO1otNn5pUSOnaEOaiMNGuGr9GEbb0c3pyddvGLd80S5Ql4aYDuu/kwGNt/X
	 gw25jehmC8Vi51GmgMoNv9fhRX+eM4tthk/BUhMmNTtt8UKAZ6fDB66QajTBflgbHK
	 seIpV0lyw1UfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 12/23] bpf: Enable r11 based insns
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213044.1130883-1-yonghong.song@linux.dev>
References: <20260507213044.1130883-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:59:38 +0000
Message-Id: <20260509025939.86223C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch enables the use of `BPF_REG_PARAMS` (`r11`) in BPF i=
nstructions but fails to include the corresponding JIT compiler and interpr=
eter support, allowing an attacker to achieve arbitrary kernel memory reads=
 and writes.
--

commit ae81414063b0b3f7e1da69b7583407d2bc29cb7c
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Enable r11 based insns

This patch enables the use of BPF_REG_PARAMS (r11) for stack argument
accesses in the BPF verifier. It updates check_and_resolve_insns() to
accept ldx, st, and stx instructions that use r11 if they match the
stack argument formats.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4827df9f817c2..e208807e79959 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18004,11 +18004,12 @@ static int check_and_resolve_insns(struct bpf_v=
erifier_env *env)
>  		return err;
> =20
>  	for (i =3D 0; i < insn_cnt; i++, insn++) {
> -		if (insn->dst_reg >=3D MAX_BPF_REG) {
> +		if (insn->dst_reg >=3D MAX_BPF_REG &&
> +		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn)) {

Does enabling r11 here without corresponding JIT and interpreter updates
introduce a regression?

If a program uses r11, but the JIT backends lack a mapping for it, could
it map to an unexpected hardware register? For example, on x86-64, if
reg2hex[11] defaults to 0, it maps to %rax (BPF_REG_0).

Since a BPF program can control the value of BPF_REG_0, an instruction
like BPF_STX [r11 - 8], r1 might be compiled to mov %rdi, -8(%rax). Could
this allow an arbitrary memory write bypassing the verifier sandbox?

In non-JIT environments, could regs[11] in the interpreter be
uninitialized, leading to uninitialized pointer dereferences?

It appears this regression is addressed later in the series by commit
ee1dd512e669a ("bpf,x86: Implement JIT support for stack arguments")
and commit 6ccf042549a39 ("bpf, arm64: Add JIT support for stack
arguments"), but could applying this patch on its own break bisection?

>  			verbose(env, "R%d is invalid\n", insn->dst_reg);
>  			return -EINVAL;
>  		}
> -		if (insn->src_reg >=3D MAX_BPF_REG) {
> +		if (insn->src_reg >=3D MAX_BPF_REG && !is_stack_arg_ldx(insn)) {
>  			verbose(env, "R%d is invalid\n", insn->src_reg);
>  			return -EINVAL;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D12
