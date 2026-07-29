Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F423DA5B8;
	Wed, 29 Jul 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343667; cv=none; b=JihDWgLnNkSaE0kk2BazNu+e2l9EEsYu/gABfP2sPF2C9gFC91+ELO2kM6cudabFVNnI+TTUOZlr8HVlwGg/5uJ08F1VZFgMFKcfStinwX/zCeDPI2VJmiydY8ysJwaZaim71lQ/RGGQYEoSCMV6BsBGk2di8/rDIuwtaskdBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343667; c=relaxed/simple;
	bh=ykJ2/AVXtARcJQIJyzGV5lAIIZwxal7SnYtt0v8zgNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pf02rgWhlzwWYD4cYM8YcRGY9aT8p7fMTcFVDK1Pby4/bRtGuDx3csYJ0watiD5vlnmMj+6K7EK3AXoYvEfHGPG7HuDi1QJ0kH5lolei0EtdCHdVs9dCysfLe5VKAlO4SzmJ6L4+0eIRNEaxzNmImjln1+epR7fZG0kevu+4a1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my5WJAlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my5WJAlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C301F00A3A;
	Wed, 29 Jul 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343665;
	bh=1x52n613VKbmdCa3l3+9JQ1D1GSvg5VYUOg4eS7nzXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=my5WJAlQYMu6y+17P7dwYF+UM5lwUryOvSPeWS2C59IcxPuiwF+ZpmJnaC0rbJ2Um
	 tAHYUTgBMp1FBzB2usTCDnBN7wZSELiPyIfGirE5IRKfARf62SSTq+EI+FatX7TOvU
	 /x9Zbml7UoQPpW2EJQs4z1WR1tv3tkusKt7fnzsz6wG99utpRI9uhBIAouv616c9Z2
	 GIhUUERl3E0j/lcaRSl4/ZrshaPOVU2sEXFHEDDQOyFcpzbMZCxadjs6X7WogMmytJ
	 KqYpQxDO5miT5vko4MlPF2E035EvGTh4wsU1r2aRWUskSHAwv+N0MDman0qwN1Rhwu
	 cz7VHvrg3FpUQ==
Message-ID: <2960c10e-17da-41c9-8a36-fabf6b2e56f5@kernel.org>
Date: Wed, 29 Jul 2026 18:47:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powerpc64/bpf: Fix build break for
 arch_bpf_timed_may_goto
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, hbathini@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785339155.git.skb99@linux.ibm.com>
 <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 18:03, Saket Kumar Bhaskar a écrit :
> With CONFIG_PPC_KERNEL_PCREL enabled, calling bpf_check_timed_may_goto()
> using a bl instruction results in a link-time failure:
> 
> arch/powerpc/net/bpf_timed_may_goto.o: in function `arch_bpf_timed_may_goto':
> (.text+0x28): call to `bpf_check_timed_may_goto' lacks nop, can't restore toc
> 
> Use CFUNC() macro instead of direct 'bl' to properly annotate the call
> to bpf_check_timed_may_goto(). On PCREL builds, CFUNC() expands to
> 'bl name@notoc', informing the linker that TOC restoration is not
> needed, avoiding the "lacks nop, can't restore toc" linker error.
> 
> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
> index 6fd8b1c9f4ac..84ecf6fa7f5d 100644
> --- a/arch/powerpc/net/bpf_timed_may_goto.S
> +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> @@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>   	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
>   	 */
>   	add     r3, r31, r12
> -	bl      bpf_check_timed_may_goto
> +	bl      CFUNC(bpf_check_timed_may_goto)
>   
>   	/* Put return value back into AX */
>   	mr      r12, r3

