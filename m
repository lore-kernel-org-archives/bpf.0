Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419988;
	b=5scT6gEK80hfhHFUL17HtRkK+y1oPS/RJpVbFWw2/IsAhucuOyWZXPZlQ9hHa0IQ304f
	 I81mIQSXY0t/uErwM+f4kEsM+ih95z+6peXJYboiGE7smT0MxRofZXXkeWMFu+HNehIAf
	 p83BlFGHZEPgCtv9BjviGtDmAcDXi+62hLQRv8MVlRfBz39AVmbztuOzVrsuqFEXEbq8L
	 6BMbQ/cgb72xOwBIYZIevXBjVCdeK/+n2gqXNyseuJRzLtvhDP4jfewNRMp4f/giYed9l
	 BWayS17FO/wBvyOjX0ew38X1sVZIrYt5JjWs+fc58I7JCbKKlQmgDmsiID99vve2xUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419988;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=G46SljVUhLkLQuSEWLMybJUgwMzH8Uht7tF4gSH3iGw=;
	b=xGSBVXVGI/YzjB4ISfp4aDnjLy8y1romxkt34oZg0IEedBYauHu45Xdt6z82JSlYRk8C
	 fivDtqGB3F2nMA1eJGKo/L0GmXvva3UqACc1XMxy+0lYzNfu/E1VyDlwg/ipiYkauGHhy
	 U0rcA9ywgnUhCJjqITdg1KwFHxto9Dk0xFRqdwtd6u4fP7knB/29G+zq0AJtP3HCm/ttf
	 64FmnhOTebqcCuhI58RHhDieACVjGpty3xzKaZNpZCU55qndHTgjC9Fjpp1o5/b0iPTdF
	 qNIT/xeNDLBciFSQkt7OYmXuffGKe8Apmwii86fc0KN539CSKTye7tk0pYwoJzczbKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZI8yb8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B624606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZI8yb8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537931F000C6;
	Mon, 23 Nov 2026 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419987;
	bh=G46SljVUhLkLQuSEWLMybJUgwMzH8Uht7tF4gSH3iGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CZI8yb8LlP1wNIcTPsNhNtIafBqdis8cmGzSD8bbOyq5NryPPJRiFpSYDhm7HlezF
	 jFdoNE0yZOfQ+4yPYh4egDAGtja+adFIXdGDVpA/Qga1cl9xlILz8f6cdcYS/zaPqO
	 97IUnfFeiLpiEtOJ5/6vHTotgTUFauvGubf9E1wsAZUQDS6c1NSbcIfSF8mmAByKxD
	 Wx4AhoDphVv7EEPSXqTSZW7CgYarxLnpt4CAY7FM54i5XOL+4B7hBQrdM36irPQebK
	 UQPXOi114FJ1AdPOrlT9nKB9Lm65dzwqE0cpklFbVrgF2LDUJO1CHJUkvPWDG5C2hU
	 MdhTtje12St7Q==
Message-ID: <91f869ee-8a2f-4016-8b91-893d26692b0f@kernel.org>
Date: Mon, 23 Nov 2026 08:46:22 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] powerpc32/bpf: fix argument passing for subprograms
To: Lukas Stockner <lukas@lukasstockner.de>,
 Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20261122194205.218543-1-lukas@lukasstockner.de>
 <20261122194205.218543-2-lukas@lukasstockner.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261122194205.218543-2-lukas@lukasstockner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/11/2026 à 20:42, Lukas Stockner a écrit :
> [Vous ne recevez pas souvent de courriers de lukas@lukasstockner.de. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Main programs receive a single 32-bit pointer as the first argument,
> so the current prologue converts it to the 64-bit BPF_REG_1 by moving
> R3 to R4 and zeroing R3.
> 
> However, subprograms are called like helper functions, so there the first
> argument already is 64-bit - but the prologue still does its conversion,
> so the argument ends up with its halves swapped and the upper one zeroed.
> The same problem applies to the return value.
> 
> In particular, in the common case where the first argument is a context
> pointer, the callee ends up with the upper (zeroed) 32 bits, which then
> triggers a kernel panic as soon as it's used.
> 
> Therefore, make JIT emit the appropriate 64-bit prologue/epilogue for
> subprograms.
> 
> Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")

Take care ctx->is_subprog only exists since commit 2ed2d8f6fb38 
("powerpc64/bpf: Support tailcalls with subprogs") which means automatic 
backport won't work.

> Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index f5b9441cf46a..261ac0646b96 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -179,9 +179,11 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>          if (ctx->seen & SEEN_TAILCALL)
>                  EMIT(PPC_RAW_STW(_R4, _R1, bpf_jit_stack_offsetof(ctx, BPF_PPC_TC)));
> 
> -       /* First arg comes in as a 32 bits pointer. */
> -       EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
> -       EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
> +       /* Programs receive the first arg as a 32 bits pointer, subprograms don't. */
> +       if (!ctx->is_subprog) {
> +               EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
> +               EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
> +       }
> 
>          /*
>           * We need a stack frame, but we don't necessarily need to
> @@ -231,7 +233,13 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
> 
>   void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
> -       EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
> +       /* Programs return a 32-bit value, while subprograms return 64 bit. */
> +       if (ctx->is_subprog) {
> +               EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0) - 1));
> +               EMIT(PPC_RAW_MR(_R4, bpf_to_ppc(BPF_REG_0)));
> +       } else {
> +               EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
> +       }
> 
>          bpf_jit_emit_common_epilogue(image, ctx);
> 
> --
> 2.56.0
> 

