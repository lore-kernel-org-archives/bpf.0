Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77436CE02
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424625; cv=none; b=cDJfskByVE5vcF/6W3mdGbt+WKonVV2aAj9od0bkPC/tEzSAJ53GXsDJPLeYdxuO2CdVlYIdNwQkthvoYob39hjZ6nyq7PvPcb0phobO/pBdQJlihT4gHpJFjfIw2dEj9x8hnxsWMoL/SbyIwpz/qaaTqjEZoia2SZI46K6y8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424625; c=relaxed/simple;
	bh=IAawn5Tg1TJtA56WVcosOWEQScybLi85ivY7YGIFzdQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mlMVVuuGMHOgmwCyoesPpucCuZwyajDw03Xh8g4BRQiyG8pMRxS/AEbzD8O24EzdaCSYqwe1581UHkEIdHrz46JLOhEQXML473T5EV9czHj2+BRTwqnC8RNYC39vAFX23czx8R30fUYng/NoP8RC2yKy0BMcW/0VUXq/h8pC7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um9mJYRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um9mJYRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F9C19425;
	Fri, 17 Apr 2026 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776424625;
	bh=IAawn5Tg1TJtA56WVcosOWEQScybLi85ivY7YGIFzdQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=um9mJYRz4ILdNXVwrlO/9nPAQrChZSN22NxSIGfzrxPeZzQTA0vZKJNldqb3TfcMK
	 I1QlNb3SPtnrVWLIp1l5YLnzHlH3fP8zSXaj+eJaSn3/wLAn3Hcc650/6BxZol2oxi
	 JVdf6I6PjyPtJ1UNn9B10mM0sUUJ0iqJFu4q5kzoA6zTO8ilm9yOjkkz7TFgvgY3e4
	 Eh5+2ZDwUnyurERtYFCS9cS0GxhIY2eSyHY9mJP7P3F3uaTWb7YWulajACfb0oegYN
	 44uCbQKM34b+++AmxL59n62OgJypeGcCG6iagTfHSY0B4N05gF1N5BYYHwJU5UsKMz
	 sbtxlhGbYyA/w==
Content-Type: multipart/mixed; boundary="===============7691660976422228201=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e7bf7fc588d9c45349a7b5b7b7a86504bf39069d9b7a043b53138604547f267@mail.kernel.org>
In-Reply-To: <20260417103004.3552500-1-puranjay@kernel.org>
References: <20260417103004.3552500-1-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: puranjay@kernel.org,jre@pengutronix.de,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,linux@armlinux.org.uk,kernel@pengutronix.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 11:17:04 +0000 (UTC)

--===============7691660976422228201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")

Is this the correct Fixes tag? That commit only modified x64 JIT code
and BPF core infrastructure for BPF-to-BPF calls - it never touched
arch/arm/net/bpf_jit_32.c.

The actual bug was introduced by commit 39c13c204bb1 ("arm: eBPF JIT
compiler") from August 2017, which added the ARM32 eBPF JIT with
BPF_CALL handling but failed to reject BPF_PSEUDO_CALL. The code has
been incorrectly computing function addresses as 'func = __bpf_call_base
+ imm' for BPF_PSEUDO_CALL since the ARM32 JIT was first introduced.

Suggested: Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")

> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index deeb8f292454..91fef10e88bc 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	/* function call */
>  	case BPF_JMP | BPF_CALL:
>  	{
> +		if (insn->src_reg == BPF_PSEUDO_CALL)
> +			goto notyet;
>  		const s8 *r0 = bpf2a32[BPF_REG_0];
>  		const s8 *r1 = bpf2a32[BPF_REG_1];
>  		const s8 *r2 = bpf2a32[BPF_REG_2];


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24561211195
--===============7691660976422228201==--
