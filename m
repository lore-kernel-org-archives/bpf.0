Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CB1F30A4
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227036; cv=none; b=JF6VX2Hn32lJifwfPwfETzPNQLesHD8F6XFhG9GwUhF3B2F7d2ZpCHr5Vi6k0AgCmS4JcGw4XwXfUrkCm6cAwqE0D2F0b8Hc2ZWgO8ygcX2+0WVnYvLOYoPZmyFy38rV6cJCtqfuln3mDkTuTCVj0gZCn6Cr+4NxIxcwRsWNlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227036; c=relaxed/simple;
	bh=13Mqke7gIK4lAxiakC91RfJyqVunfetraO5/cIOFkcQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ih6eBgu38BkVrAtahsMdZZ1QoHbAKNeRmCZmUFO1ARpj5V2q/3aKK3HCDolqTm7mQZU6h+1DlWFCjoHoNJGKh2usMJXdo05SKuyZqBwVk2xG4HXk3C1wX2Gqc7b4anpTfqCPBT48yBxg4afUsLi+sAE6YO8BbcErWxmYjeg6h84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWIZpJH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWIZpJH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE94C116C6;
	Mon, 16 Feb 2026 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771227035;
	bh=13Mqke7gIK4lAxiakC91RfJyqVunfetraO5/cIOFkcQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NWIZpJH4lATV01d4Uxh3yaYFbwui2ZKa7AJKr5L3g1RyF5ipO+va18T47sJOdIeXJ
	 FZq/Zbn6dZvlSssZX+aOhq8pRjUuTbrpwDPugQTCbL883IMjxN/jcModmulu6RSEI7
	 ZTS3n/b71GcDobqQMRdpUoLU3Cn0Vc4ONExieHcqAcJehlOBjlJm8pS6LGxBdoQE7E
	 hKiVljmYsErWULoK++4odeFRnCEC0J7zU2I9jgarA0iQzaYQ9NfwI4t7g7dQTxRHmi
	 1jGBTv3p+s8r6zBpVDWfFyt+5910mrqthOAb79bH+M4Kakmmm//cOT90fTx/tgGcVa
	 RRqQJENNFfZ1g==
Content-Type: multipart/mixed; boundary="===============2651187141770340201=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <36f23ae77c2dd15ad313d3103b53daa229750e06b32aaf09f2a965dfb034313c@mail.kernel.org>
In-Reply-To: <20260216065639.1750181-4-hbathini@linux.ibm.com>
References: <20260216065639.1750181-4-hbathini@linux.ibm.com>
Subject: Re: [PATCH 3/5] powerpc64/bpf: use consistent tailcall offset in trampoline
From: bot+bpf-ci@kernel.org
To: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,skb99@linux.ibm.com,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Feb 2026 07:30:35 +0000 (UTC)

--===============2651187141770340201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> powerpc64/bpf: use consistent tailcall offset in trampoline
>
> Ideally, the offset used to load the tail call info field and to find
> the pass by reference address for tail call field should be the same.
> But while setting up the tail call info in the trampoline, this was
> not followed. This can be misleading and can lead to unpredicable

This isn't a bug, but "unpredicable" should be "unpredictable".

> results if and when bpf_has_stack_frame() ends up returning true
> for trampoline frame.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -658,7 +656,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
>  		 */
>  		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
>  		PPC_BCC_CONST_SHORT(COND_GT, 8);
> -		EMIT(PPC_RAW_ADDI(_R3, _R4, bpf_jit_stack_tailcallinfo_offset(ctx)));
> +		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
>  		/*
>  		 * From ...(1) above:
>  		 * trampoline_frame_bottom =                            ...(2)
>  		 *      func_frame_offset - bpf_dummy_frame_size
>  		 *
>  		 * Using ...(2) derived above:
>  		 * trampoline_tail_call_info_offset =                  ...(3)
>  		 *      trampoline_frame_bottom - tailcallinfo_offset

The comment still references "tailcallinfo_offset" but the local
variable by that name was removed in this patch. Should this say
"BPF_PPC_TAILCALL" instead?

>  		 *
>  		 * From ...(3):
>  		 * Use trampoline_tail_call_info_offset to write reference of main's
>  		 * tail_call_info in trampoline frame.
>  		 */
>  		EMIT(PPC_RAW_STL(_R3, _R1, (func_frame_offset - bpf_dummy_frame_size)
> -								- tailcallinfo_offset));
> +								- BPF_PPC_TAILCALL));


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22053464899

AI-authorship-score: low
AI-authorship-explanation: The patch follows standard kernel conventions with a human-like typo in the commit message, and addresses a specific powerpc BPF JIT implementation detail consistent with the author's domain expertise.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Two minor issues found: a stale comment referencing a removed local variable, and a spelling error in the commit message. Neither affects code correctness or runtime behavior.

--===============2651187141770340201==--
