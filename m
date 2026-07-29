Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDF42C4EC;
	Wed, 29 Jul 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343549; cv=none; b=dZmQFkwWOSKYDsQw9xB7CpPnZQ/SYVwc1gi8T12hdEU2VoMwptFp1AcRPrytalFVNtyJZd8ZBYzQu8N2sWWtloiVQRaDMjc0BfUZUFq2u/aDmhI/EPQqKnowDGLNW4XXCNPVy8cjNYkWpeohh+Lj1aV0SDnnqfwTzIZmKqcqbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343549; c=relaxed/simple;
	bh=l/HFXEkXNDMzRC8zgEw7j5oXyuSZHBXzBmpihxAjz1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGC3bByif5CJb7qTIyoxEWNSOzwk3tqZCLYgulPvpzMCbTu12aH6GZJW1u//0qJI+IJ0GwmgD/p0kLK5ysN31C1bSX3xKE0xX7g+COkWWOtNxb37RZaQRamPWXWZVr9Z1p5nUjwerCz227Ca6o2bq7D4vIfd6+MngcLKyCod8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7PU4flV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7PU4flV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A1F1F000E9;
	Wed, 29 Jul 2026 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343545;
	bh=fEVM9LDTkdkjBT40f5k0k+tzstOGdIlVX66IjRAKwZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k7PU4flVTv1a+BZ+UGI62Zo0muBhnbZtKgpBR4FEUS6Ko82gyoQvI78qWfVpadCfB
	 GHVsbUgobc8ocxb6NczKX26WeknZYlcSefgtfuS4lEDaPvEtjReUuFnWSWjR5sXQSb
	 tAEvwr9Sfcyo12hct7QM1Wm0bbbhD29N6wg1xm1DXVAJJzogdHcBSK/8MtqSg530Gf
	 SI8ihtFa2OgU61XMSRyCye1X2DufaxJAPMpNEdjNypBvmT22cmbfHj3Dx+Nvc9CPb7
	 1m1Npmk+h0H7gCNsZErspNJw7OeE9AVZlDxo/lItewa4U0QvwyLlojoJg8S5v2c8Qg
	 QEN0sG7ZS/KUQ==
Message-ID: <8e3aa8f3-c264-4568-a973-0595914f89df@kernel.org>
Date: Wed, 29 Jul 2026 18:45:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc64/bpf: Fix build break in
 bpf_jit_emit_func_call_rel()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, hbathini@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785339155.git.skb99@linux.ibm.com>
 <aafc721911eefc4ee376e27a0f4cebb82e3ee336.1785339155.git.skb99@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <aafc721911eefc4ee376e27a0f4cebb82e3ee336.1785339155.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 18:03, Saket Kumar Bhaskar a écrit :
> From: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
> 
>    CC      mm/dmapool.o
>    CC      fs/readdir.o
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
>    475 |         int ret;
>        |             ^~~
> 
> commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> introduced "ret" variable to bpf_jit_emit_func_call_rel() and it is used only in
> else block of CONFIG_PPC_KERNEL_PCREL, fix by adding a "__maybe_unused"

__maybe_unused doesn't fix the problem, it just hides it under the carpet.

ret is used at only one place, move it's declaration their:

#else
	if (core_kernel_text(func_addr)) {
		int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
		if (ret)
			return ret;
	} else {

> 
> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index dab106cae22b..63952ef19256 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -472,7 +472,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
>   	long __maybe_unused reladdr;
> -	int ret;
> +	int __maybe_unused ret;
>   
>   	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
>   	if (!func) {

