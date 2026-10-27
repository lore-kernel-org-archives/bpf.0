Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121022;
	b=3iSCdekYqB1MnCnPnYN2l4xKkBsb10n5GS3dJXva2eDFBvVyag6cSIOZ/Uzp39BN9rKR
	 FBvTxxhqdX9RBkOGJeEa23SMQQm8+MlAa5r42HTAzlYpVoJxL8OrysKMDFIgmDGFXtpGR
	 qh6/TV1CFYKhvnrKPJgSqG1VVnqcVVph1qTPCXrNETOYMDdS+sjoncR71aQhVFmlxUDoY
	 kva7sW4+29666TPTjNAlWK+pYo2rvIcrcLqm7lq6pOS/W2ri6XW5ngTgEdox0auTxKzCb
	 9hbXrq7/loXDUr+zos6X1RQLn06fA/rjgUwqm+1aGOzzVNz1RhFAd0FjNggZ6dRe3Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121022;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ai5o1zvaMD0UvDk564zCePF6UrKlEd4BE1CnI2LjNnQ=;
	b=HFTQEiL/R4EBwTEXbw170IoXAFGIHCVG0MVT8qL/ABj3TLP4e3nazVaZuc9ewJ7ii3rO
	 JWCLkyNnsvEMR1f+m6mswqhIQIZG8+Xx9YYhBoCmQ53VcuMvfrykqhhOQ5IBU2zYSBKai
	 6elCk4ICEs6/VViDgGa4ZrtbUh34kaffQxGY2m8OWRBI4eICmS0HRwPmG9GMlLW8qnn4O
	 Eu7tyIuU+OYauIr4I6p7cpcfg7LmoeybIrhY1/mvU6TVeUQ85aIwBl98DLKsusTp/sfak
	 5qPSGfcYoDhIIQ9Ry2I+MQHRFj6gS7g+ZhuIh90wd5Yftk15coo7ZEtP2112nCRDD3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGFgw+yo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788E606A336
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGFgw+yo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8DE1F01828;
	Tue, 27 Oct 2026 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121021;
	bh=ai5o1zvaMD0UvDk564zCePF6UrKlEd4BE1CnI2LjNnQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QGFgw+yocqP1S+aqScwddBnPG06hI+GQmk+gYKO6BGwfMYC/vJqWdVnfX1hHonZ6+
	 X1hho82lBXAQyC5vd7kdnXkQFHZfl5Uu6qnlQJ6ewl8ltjQW/h54K2bHjLy25qb5Gw
	 UEcpdZAV9GG9g7/c4FrwGlI5+VthaSOauMB84rl3rJwmbl2GkOAJGqRMkUvK0tFfem
	 CaFWKi+2Ct90rI/PKWXiLMoSaEZG+Bj/7TRO8J13FnKYe/cZM50dJwBTD5hpQ0Eva8
	 SmwgYWqPTrGWCraYVKTLx+vx4wYws80D0U+cFX54DXCbnRb6IqfaK5MTeZBC2RaTpk
	 5jqBF2i3tkMfQ==
Content-Type: multipart/mixed; boundary="===============6362013547960379767=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <eb5e66a2401d102f2c4b85c636f066e1277fb026f05aca196dc4297b4933b1e3@mail.kernel.org>
In-Reply-To: <20261027162820.10887-4-emil@etsalapatis.com>
References: <20261027162820.10887-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 3/7] arm64, bpf: JIT internal IRQ save and restore instructions
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 17:10:21 +0000 (UTC)

--===============6362013547960379767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> arm64, bpf: JIT internal IRQ save and restore instructions

TL;DR: Nit only, no bug found: in the arm64 IRQ save/restore JIT, the raw
sys_reg(3, 3, 4, 2, 1) and pstate_field(3, 6) tuples could get names like
SYS_DAIF or PSTATE_DAIFSET, or a comment.

> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index b2fe6e6dcf44..23cbc38510a0 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h

[ ... ]

> @@ -338,6 +339,13 @@
>  #define A64_MRS_SP_EL0(Rt) \
>  	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_SP_EL0)
>  
> +#define A64_MRS_SYSREG(Rt, SysReg) \
> +	(aarch64_insn_get_mrs_value() | (SysReg) | (Rt))
> +#define A64_MSR_SYSREG(Rt, SysReg) \
> +	(aarch64_insn_get_msr_reg_value() | (SysReg) | (Rt))
> +#define A64_MSR_DAIFSET(Imm) \
> +	(aarch64_insn_get_msr_imm_value() | pstate_field(3, 6) | ((Imm) << PSTATE_Imm_shift))

[ ... ]

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index aaa34c739004..aed84f0d8728 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -2026,6 +2027,33 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>  		}
>  		break;
>  
> +	case BPF_ST | BPF_IRQ:
> +	{
> +		bool pmr = system_uses_irq_prio_masking();
> +		u32 sysreg = pmr ? SYS_ICC_PMR_EL1 : sys_reg(3, 3, 4, 2, 1);

this isn't a bug, but could sys_reg(3, 3, 4, 2, 1) and pstate_field(3, 6)
get names, such as a SYS_DAIF or PSTATE_DAIFSET style define (or at least
a comment)?

SYS_ICC_PMR_EL1 is named on the same line, but a reader has to decode both
tuples by hand to see that they mean DAIF and DAIFSet.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40544258296
--===============6362013547960379767==--
