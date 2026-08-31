Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED940BCA1
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180877; cv=none; b=hOMe3E5w1chwxcPPNDN2TIL8xaTuk0lwm7Hl02hejxQylCfvC7fJVUCpz4qjqY0vc5aImXt/k47JplIUEDWcXPUlpkIkaSMyqguq1Qn3apxz/LN+iKoeDklLkFK2Z0IJ+jZgN9TETwlLTWullSNKUPXbK7anlslBiQM/aEbHw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180877; c=relaxed/simple;
	bh=JoprDb0tnMj52N30RNJEE/9zTzW0hsVbZ8zi3Ca6XWE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NkMap02etugIh16DPUS9mSOytBkCMl1kID858Vv4EPkq/NDM/tYcj54YIhQy+qIJQo98QO9sBR49UtH2GJ91DCHpVNzuJ4jYdccSexQstQrlBw2J5MHhXqd0Io9C18OobwS44K5qMMpiBOQCpOapotZXQSksJvdX//69R7k05m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTqJNwhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTqJNwhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A589E1F00A3E;
	Mon, 31 Aug 2026 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788180876;
	bh=PqzcyW81jpAJjyb2cSg3GPpcJ01WloykZaeE4QWGdmY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MTqJNwhgdHZIqEiVNeJDHvUPVdOMiY9Wk37FLGdn/Szs7ax4iVTWRi/vVFjdubs3H
	 vJHJjo0FXZyH+Tyj6StJjj+1lDd9N77YN+KF+1q1qHqXRUQ/pFar4LFAeoZ4598NI0
	 mCW6JKbt3tay/7oTzI9V1WBNG+EC/wBhwAGYsO/jWqJ3fZcFhqyDj8l8ewLao1Ebqn
	 PTtPOb8lt+Q2spBcwWATNNh1vNqBjKEB6gwWmZQNdMEv+CRTNzn+6bN1j80T8pwmp3
	 nLPMBKIQmPldvNHjXEM11q6SkQaXvUAAfnmELO5YbdjxEh6dELZGXlNcFgSwgufmMT
	 0XG0y3vZw+xJA==
Content-Type: multipart/mixed; boundary="===============1107563372083640497=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d3b30565c015a75c09b1b79b4684bf3399f8db42f0aad1d5faaf3267ba817f0d@mail.kernel.org>
In-Reply-To: <20260831114614.157277-3-jolsa@kernel.org>
References: <20260831114614.157277-3-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Introduce JIT emission context
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,rppt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 12:54:35 +0000 (UTC)

--===============1107563372083640497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5922bb4728aad..eff0523161c3e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -947,10 +898,9 @@ static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
>  	}
>  }
>
> -static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
> +static void emit_mov_imm32(struct jit_emit_context *jit, bool sign_propagate,
>  			   u32 dst_reg, const u32 imm32)
>  {
> -	u8 *prog = *pprog;
>  	u8 b1, b2, b3;
>
>  	/*
> @@ -984,14 +934,12 @@ static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
>  		EMIT1(add_1mod(0x40, dst_reg));
>  	EMIT1_off32(add_1reg(0xB8, dst_reg), imm32);
>  done:
> -	*pprog = prog;
>  }

Does this break the build? Removing the trailing '*pprog = prog;' leaves
the 'done:' label as the last thing in the function body, with no statement
after it. C11 and C17 require a labeled-statement to be 'identifier ':'
statement', where a closing brace is not a statement. Labels at the end of
a compound statement were only legalized in C23 (N2508). The kernel builds
with '-std=gnu11' (per the top-level Makefile), so GCC will reject this with
'error: label at end of compound statement' and Clang with 'error: expected
statement' when using any currently supported minimum toolchain. Only GCC
>= 11 silently accepts it (downgrading to a pedwarn that's off without
-Wpedantic), which is why the breakage can hide on a modern build host.

The function has two 'goto done;' statements earlier (the sign-propagate
path and the imm32 == 0 path), so the label cannot simply be dropped. Could
the label be given a statement, such as 'done:\n\treturn;' or 'done:\n\t;',
or could the two gotos be replaced with 'return;' and the label removed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33389883230
--===============1107563372083640497==--
