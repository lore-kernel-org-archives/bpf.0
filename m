Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087A3C3428;
	Mon, 13 Apr 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088038; cv=none; b=NTpniNKpf3i/GGZg9v1PuiAxdTMAFgn1+Cg5PZn159tkw+nxoQabsdU5zwaVNJGGBDj+KjxJ88yJdWHkdM+b717rmjosJ2ihfbJXVehycXlnzzA0/7PXLuqLQmVkXTigx6WnxNGTbTqvPqrySwPw2yUvsB12y1/AEy5HDwth+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088038; c=relaxed/simple;
	bh=rMXI7MynRACmo7J3TU7p5YzDSfDDr/BAcnGwaBTJV94=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aEFgLJTPOJGdjCnB/208wBGWa+tW/VDR0AikDzXpiSvDSBgIDN6VQdawqiqZDYPQvIEnHdws5xXNlplauMKun+EwamdEf7eUBNf/fK9ZCA/iKTJjio12YpSBR5QPVQTPR/RhSSmsu17/lvjDbnG1SUQPPPJeN+FtoMWUoCcnnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuPKkqBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuPKkqBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9C8C2BCB1;
	Mon, 13 Apr 2026 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776088038;
	bh=rMXI7MynRACmo7J3TU7p5YzDSfDDr/BAcnGwaBTJV94=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IuPKkqBFLus3ZZihucCPXZBt0/wyjJXVs9cLIPDnUMaU+SFwTxw+o32qNML+J7nvB
	 +T0ctEKppjqTZOIM6Rh3j17lGUYIeAzFiWyBqRwf76+oabI4Mp8eXQv5ninX1ukEvr
	 LnH8NYY5a631BQ60QJwGDVOVITtEloDxi398HYkfXCKB41n08uH4BssEdBkDJqnx0n
	 QA7qYUc5xYwPpefkCXn0fvXa6DXoHuOaoFBvwYltyVxogbHvcfPje+NZHdmnKlmxV5
	 F0XlRCtoF/jpz8glOacO4i4jrAjxxjQc8VMGEp2086vfWXRZXeAHBUBqvSG3B/UETz
	 cg2zi5atDi8Nw==
Content-Type: multipart/mixed; boundary="===============0318703698084331295=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa46a9034904c7622f935d3e3a60264a37afda290705f40c816c9846c9d3f3f8@mail.kernel.org>
In-Reply-To: <7d88904b4028cbe124bbaba5739c525663bedc64.1776062885.git.xukuohai@hotmail.com>
References: <7d88904b4028cbe124bbaba5739c525663bedc64.1776062885.git.xukuohai@hotmail.com>
Subject: Re: [PATCH bpf-next v14 1/5] bpf: Move constants blinding out of arch-specific JITs
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 13 Apr 2026 13:47:17 +0000 (UTC)

--===============0318703698084331295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 066b86e7233c..fc9fb3c07866 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

>  /**
>   *	bpf_prog_select_runtime - select exec runtime for BPF program
>   *	@fp: bpf_prog populated with BPF program

[ ... ]

> -	/* eBPF JITs can rewrite the program in case constant
> -	 * blinding is active. However, in case of error during
> -	 * blinding, bpf_int_jit_compile() must always return a
> -	 * valid program, which in this case would simply not
> -	 * be JITed, but falls back to the interpreter.
> -	 */
> +	/* eBPF JITs can rewrite the program in case constant
> +	 * blinding is active. However, in case of error during
> +	 * blinding, bpf_int_jit_compile() must always return a
> +	 * valid program, which in this case would simply not
> +	 * be JITed, but falls back to the interpreter.
> +	 */

This isn't a bug, but this comment still references bpf_int_jit_compile()
even though the code now calls bpf_prog_jit_compile(). Should this be
updated to match?

> -		fp = bpf_int_jit_compile(fp);
> +		fp = bpf_prog_jit_compile(fp);

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 67c9b28767e1..ec8afd6a9369 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> +out_jit_err:
> +	if (blinded) {
> +		bpf_jit_prog_release_other(orig_prog, prog);
> +		/* roll back to the clean original prog */
> +		prog = env->prog = orig_prog;
> +		goto out_restore;
> +	} else {
> +		if (err != -EFAULT) {
> +			/*
> +			 * We will fall back to interpreter mode when err is not -EFAULT, before
> +			 * that, insn->off and insn->imm should be restored to their original
> +			 * values since they were modified by __jit_subprogs.
> +			 */

The comment references __jit_subprogs, but the function is named
jit_subprogs (no double underscore prefix). Should this be updated?

> +			for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> +				if (!bpf_pseudo_call(insn))
> +					continue;
> +				insn->off = 0;
> +				insn->imm = env->insn_aux_data[i].call_imm;
> +			}
> +		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24345549165
--===============0318703698084331295==--
