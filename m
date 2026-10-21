Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626145;
	b=0IFWeDgXEp3IE+y/sRt92bTlY6KFcBn36CGnQBZiO4G9cKEJF+FRJoPeP6b6fdI813mG
	 wy/wiMnvuXIeRwKLWiLjr1k/BMmPsqQzuqSYinenpxXvnF0ZT+r5gQgGjzCHKCMX0fyrx
	 GmQMxXmK3xTRBOA76fh7jjw0o60h8/u1gG+aa7YjNp9HqmXnUIOvCIQFN6mf/gnzut9aE
	 0wyMFdsUQoYJIGzvGPKXij9Wdq8pp4D6fglD80Oovc4wGtelC1KkbclNlz5ie/SFAxM2U
	 VM3oGky/kuAPy6kez5czAb25PMDcjZ/tWmgsNQ73+fkMxUZA0JpN1sL9h9ve/kdunZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626145;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ykAI4Co8n3ICvspjSq0hVXe2Mvm8PsAqL8+ybPbd7cI=;
	b=0y8bBsFlWVrjlW/cZjqkCdxDr/tduh6w9LFwcnJl2+LcUCqbrrBGTrPgK3pv8xFns/TQ
	 cmky3vED2mBvuBA+uOxvlsGpWV337A6/8pUkEpbYas6/dPUkJiKNn1NjbRf8tn4EfYJVQ
	 /HuGwgtD4aBkZLk91azaASu3oy0sFImz/ltZBArxjtGppHtAWOJLKTN7v/vs+57gjUK0r
	 kFvSoX88s6qut/z5U9aW9ZvP3bCFf59IxM/MC5t3MVIb+hdQgPOAeyBx1qkAcSM1cgbpd
	 Bf4XRXoW5gLeezLSptIl2nd5O1Sof5REV65p9lPAx8ujcDwCWX+fD+30iCwIdyIIR+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRA1kmYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259E606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRA1kmYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A268E1F000C1;
	Wed, 21 Oct 2026 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792626145;
	bh=ykAI4Co8n3ICvspjSq0hVXe2Mvm8PsAqL8+ybPbd7cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRA1kmYd3RDyRfnHssaMBHVZrj22rugeGUcreypvoR2nwgER0Wc1Z1km9lSnwMIO8
	 Ijlf8i8gMMJ3522f24+zlySpdUv/Pth7eDPChUVz6HU9WlR4hqXZuMtTn/5WQACx/M
	 ++cLd5zNGQywSn6dmCHYtieZUhaOCeN1zodNXJdMuk+SxvhF2fYl47rhGL6pQos/vB
	 jtfv5DXDED+f4GJDeSbUge74git5chkoMRuCwEk4Pg9Wn52SUdQlsK5uahk1g01SWv
	 JXcXWOR3aXwtkoYm1/aXOCYMHLfKmfKjTiGikM0IXrggrqQh+xW6s9D247o3MLZCEB
	 RFEG3CuLnW7rg==
Date: Wed, 21 Oct 2026 16:42:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, x86: Use emit_rsb_call() to call
 bpf_unwind_target()
Message-ID: <20261021234220.GA3640178@ax162>
References: <20261021220844.239400-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021220844.239400-1-alexei.starovoitov@gmail.com>

On Wed, Oct 21, 2026 at 10:08:44PM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> clang inlines emit_unwind_ret_addr() and emit_patch() into do_jit() and
> folds 'bpf_unwind_target - X86_PATCH_SIZE' into one relocation. It points
> to a nop in the padding in front of the function, and objtool complains:
> 
>   vmlinux.o: warning: objtool: do_jit+0x1330: relocation to !ENDBR: .text+0xc7fab
> 
> It's only used to compute rel32 of a direct call, so nothing is wrong at
> run time.
> 
> emit_rsb_call() does call depth accounting too and hides func from
> the optimizer. Use it instead of open coding.
> 
> Fixes: cff94a3d78d8 ("bpf, x86: Support unwind_goto and unwind_exit")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/bpf/20261021201456.GA3197963@ax162/
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
>  arch/x86/net/bpf_jit_comp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 6a2fe3d0039d..71f7200dba00 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2564,9 +2564,7 @@ static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
>  
>  	EMIT2(0x50, 0x56);			/* push rax; push rsi */
>  	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */
> -	ip += prog - start;
> -	ip += x86_call_depth_emit_accounting(&prog, bpf_unwind_target, ip);
> -	if (emit_call(&prog, bpf_unwind_target, ip))
> +	if (emit_rsb_call(&prog, bpf_unwind_target, ip + (prog - start)))
>  		return -EINVAL;
>  	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
>  	EMIT2(0x5E, 0x58);			/* pop rsi; pop rax */
> 
> base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
> -- 
> 2.55.0
> 

-- 
Cheers,
Nathan
