Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839E23535E
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474259; cv=none; b=uMpCAPfpCDqC5SQdswhlSySHPQO1A4AkPH5MdPP+W82x/dNyhJ2/b4Rw/Gjh5kPJ3ECioGUtBeRJZ/qOuDzeNBLJ1rXtYGmknRkamF32BXKg8cBL47WeufXg7dK3pzaV5srganvnGWA8NGOmODpUsdtlVx1mhXy9eNxi4mwl0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474259; c=relaxed/simple;
	bh=eMmStST6ZjNOuDwCy6qt4QcKe0Dmoc6TwjIRjKBidl0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HUnAPq2eZvGBDAOud3CeST1jyA/hVnwTa/+jxA9e7uIi+XxL6HbE9ulH9+YanaN1N2xUvDNNcpADQ7oPzNcPhoTVgx85A8l3zRc3KYvaSpDs8err2K7yyoBnuj347Vd4VfgMwyzofuD5gclg69GikIMzKci+4APnO1WyR0+MuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeUj5aey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeUj5aey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C746AC19425;
	Sat, 18 Apr 2026 01:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776474259;
	bh=eMmStST6ZjNOuDwCy6qt4QcKe0Dmoc6TwjIRjKBidl0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QeUj5aeyLOCqWfbySBMlixf3D18uJL8fntdtE+RfTk24rDNgr78eEgfG6hUDK3iva
	 essXZUD5sn5f1V20asQujr6cCCMu5mUzoFxHJGPGvhSNUp4n+gWIBb65zU+TqpLZZh
	 F98IoetkzgevphMvZ0ZfoXLN/eW5wD7qMsN0TEXN+pUquRdlOUGB85lHefRnLduhgi
	 BAftfERm8CE1a2GwMqmNVVPRLqTzHXuHogJ439JohuZaRTGfwXaYH+Gt6AubKcTG4s
	 +2HAuLoA6XMdHLlFCtNAIhRViqdE0jPitW1cqwlgXg3zwYtDz0xd9+e94LPtyWABxW
	 jd51rYiwnK3vw==
Content-Type: multipart/mixed; boundary="===============1073355516222241865=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b97fcc95b016888fcf916004ca9f8ea628e2d16811509b16b0a5e76eb41cb79d@mail.kernel.org>
In-Reply-To: <20260417034800.2631277-1-yonghong.song@linux.dev>
References: <20260417034800.2631277-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 12/16] bpf: Enable stack argument support for x86_64
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 01:04:18 +0000 (UTC)

--===============1073355516222241865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e9b78040d703..32864dbc2c4e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3937,6 +3937,11 @@ bool bpf_jit_supports_kfunc_call(void)
>  	return true;
>  }
>
> +bool bpf_jit_supports_stack_args(void)
> +{
> +	return true;
> +}
> +

Does enabling this without the actual JIT implementation break bisection?

If bpf_jit_supports_stack_args() returns true, the verifier will allow
instructions using BPF_REG_PARAMS (register 11) to handle stack arguments.
However, since the JIT support isn't implemented in this commit, BPF_REG_PARAMS
is not yet defined in the JIT's reg2hex array.

Could this cause reg2hex[11] to implicitly default to 0, which maps to RAX
(BPF_REG_0)? If the verifier emits instructions using BPF_REG_PARAMS, the x86
JIT might miscompile them using RAX as the base register, potentially allowing
an arbitrary kernel memory write since R0 is controllable by the BPF program.

Additionally, it appears kfunc calls with >5 arguments won't have their
arguments correctly marshaled to the System V ABI (like moving the 6th argument
to R9), which could lead to reading uninitialized garbage from registers and
the stack.

The JIT implementation appears in a later commit in the series. Should the JIT
implementation be merged before or in the same patch as this feature enablement
to maintain bisection?

This concern was raised by sashiko-bot@kernel.org in v5 review:
https://lore.kernel.org/bpf/20260417050346.F2E3FC19425@smtp.kernel.org

>  void *bpf_arch_text_copy(void *dst, void *src, size_t len)
>  {
>  	if (text_poke_copy(dst, src, len) == NULL)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============1073355516222241865==--
