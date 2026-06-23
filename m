Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CDE3546CB
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218533; cv=none; b=Zuc4ilmCgZNEwF5fdP8ogUgRAVGgrJ+XaFFcdcrGbv6vo/Ll/nS5advOkN6f8EOf3SAMgynHIHPRgoS+dzCwwbqIC6KLPQwyOK7xPP6QTbNAivMRrj/K0bSU7Ip+8IltTtYMqG4qk5O4j7eOgaU7b7AmrUK3+knQ27YrBQQonho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218533; c=relaxed/simple;
	bh=HUGjLOkoyx5mZ/SdqhJZR9mcyfVyt+e9XGrGCAqgt7M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RugJAcU+XVlKDW5RriT8q4nksYpY8A2CqKncojC1fIbKNWvObXJTsKfPqT6RHLJ2yIFWd4TReHPRxX1YO1nTbv4/PszhUBQdqW3z4P+iHg7NPQw6tkZ3dVCYtcJdZbcOV5AXiSA27hZoLzaN6xI2afi51DNohr+io3bYVjyHn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQFZ/Obi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQFZ/Obi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9701F000E9;
	Tue, 23 Jun 2026 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218532;
	bh=n5rUIKL9G+7DiqWqB6vOhxRJghWV7QEF2sYsSjS8bFI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QQFZ/ObieyFI8PXIRVmAQ7HT2QO193TM/vR+GzYG5fOKt9cnKXDiLtvVSthFx+VfU
	 XnkD6yvLUktNyJVhlSNJ4dKKeLAeF9DHrV/SoTzUYRCvj0QFN/vihEqUk4EPVdlDQO
	 6/wH998TBgAbZcKyUx6IbfocwQWw1ucmSykv25T2wverTaTC6dk2UN2IPEo5ueeyvp
	 9RInf3pLZMrfiXSInDfyPBCnVZm6PlxX661Obtn2vlojY4Nk4hNE8hiPx62jRCu9oC
	 g6vRKPy8ZjtE2e7OSRPfm/POCLuyErC7a+cWmWY661JbZabtnQISfr4/3sgfAJC3mq
	 +Bwm823D11pgw==
Content-Type: multipart/mixed; boundary="===============5434858247865941527=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e290f581e78208441b8c3069a7ec3bdc7f1fa76c189d566ca924488b418d9950@mail.kernel.org>
In-Reply-To: <20260623120218.25869-2-ziye@zju.edu.cn>
References: <20260623120218.25869-2-ziye@zju.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with non-const src operand
From: bot+bpf-ci@kernel.org
To: ziye@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 12:42:12 +0000 (UTC)

--===============5434858247865941527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..bf247c219cab 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14516,14 +14565,14 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>  	case BPF_MOD:
>  		return src_is_const;
>
> -	/* Shift operators range is only computable if shift dimension operand
> -	 * is a constant. Shifts greater than 31 or 63 are undefined. This
> -	 * includes shifts by a negative number.
> +	/*
> +	 * Shifts greater than 31 or 63 are implementation-defined behaviour.
> +	 * This includes shifts by a negative number.
>  	 */
>  	case BPF_LSH:
>  	case BPF_RSH:
>  	case BPF_ARSH:
> -		return (src_is_const && reg_umax(src_reg) < insn_bitness);
> +		return reg_umax(src_reg) < insn_bitness;

This drops the src_is_const requirement so that non-constant but bounded
shift amounts are now range-tracked.

Is there a real use case driving this?

Earlier review on this series asked whether compilers actually generate
non-const bounded shifts, and whether any real programs are rejected today
because of the conservative handling.  It was also noted that the current
behaviour does not reject such programs, it just falls back to an unbounded
dst register.  The range tracking added for BPF_DIV/BPF_MOD deliberately
keeps requiring a constant operand for similar reasons.

Without a motivating program that is rejected today, is it worth adding this
complexity to the verifier?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28025372706
--===============5434858247865941527==--
