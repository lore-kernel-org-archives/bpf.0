Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDB5540A1
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089556; cv=none; b=mSM+FZoUdLeuAZrx1eqEZFko7GoxyAqaBzZIJHUYzn3Hrz67vMvEp1rflMWGFuGB2CCJWKPkgDWJ9z+RduAiI8W2FxDA/2cpGqpPR1bwHFVgTvAdvD+JGzRBEasq+7a4q/c/9oChjggjBW2JHYkRUhDLDgHhVn/OF7VYsjO4w2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089556; c=relaxed/simple;
	bh=M8jcLLWUZYc4P1AYeE2H+xxodCei2sJ9Wj/zV/RNO74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JN/FRMkd6DT/Am5Nl5/z65wXBJTQrR6nIyWdJGXZFXT06mkPjhhTpifse1TVF3blSnkgjO0HN+RFl/GfFEPD0+qV4ES83vlkMIzmJtFDt3OafA1KiAYQriyEt+4giy7Ozpg308g3OAV/2AV7uTs4aKX9cedgngv9WETrjquIdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIbAfnkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIbAfnkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC11F000FF;
	Tue, 22 Sep 2026 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089555;
	bh=a8UzrQLSLO5oX2/5to9XMtvtsuP08nXDSA7XIwNN2O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kIbAfnkIeqiWeyJx+qaaNl/C68WptJ+/EVv4mB6/GNsEWk5xan5o/EnJ360zAqqN9
	 Dxl7nQHBCRqOAVTmgj8ZY9muAPUJfHVrE02T19BnN76UY2fy75hU73iglFuD+bYUaH
	 LiXN8fH2D2X2+it5tTondvYBxV3zSEaG5Bysp7UDSgO+XvzcIc39UZge43HwcM3qFh
	 pff2DtBP5ollIU53NklpHUk9bAlYoVYGQSIlRJwwpKR3GyqTUFY4noMTim8aJaAYU5
	 v03dvUBSwAmmxwOG7XI+9rwOJo/9QPYu32xAUuVaSA2M8LJ5c9oUpXOxAFnuFv13TO
	 gb12B/fOoHnNA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, a.s.protopopov@gmail.com, Puranjay Mohan
 <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 08/17] bpf, arm64: Add JIT support for callx
In-Reply-To: <20260922011323.1298619-9-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
 <20260922011323.1298619-9-alexei.starovoitov@gmail.com>
Date: Tue, 22 Sep 2026 16:05:41 +0100
Message-ID: <m2fqz1498a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> From: Alexei Starovoitov <ast@kernel.org>
>
> Emit callx as BLR to the register with the address of the subprog and
> move x0 into BPF_REG_0 like after a direct call.
>
> That's what a direct call of a subprog out of BL range is JITed into
> already. bpf functions start with BTI JC. The arguments are in x0-x7 and
> on the stack. Tail call counter ptr and private stack ptr are in callee
> saved x26 and x27.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 6c04fee46876..9544b2f483e5 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1789,6 +1789,17 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>  			emit(A64_MOV(1, r0, A64_R(0)), ctx);
>  		break;
>  	}
> +	/* indirect call of a bpf subprog, dst holds its address */
> +	case BPF_JMP | BPF_CALL | BPF_X:
> +		/*
> +		 * It's the same as a direct call of a subprog that is out of
> +		 * range of BL: the subprog starts with BTI JC, the arguments
> +		 * are in place, and the registers that hold the tail call
> +		 * counter and the private stack are callee saved.
> +		 */
> +		emit(A64_BLR(dst), ctx);
> +		emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
> +		break;
>  	/* tail call */
>  	case BPF_JMP | BPF_TAIL_CALL:
>  		if (emit_bpf_tail_call(ctx))
> @@ -2485,6 +2496,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  	return true;
>  }
>  
> +bool bpf_jit_supports_callx(void)
> +{
> +	return true;
> +}
> +

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
