Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B38A724;
	Fri, 13 Mar 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395742; cv=none; b=g3PjIErx+uRhlV8ib8kpQx54KvSebwvtO6+zY3+7UrREug5IlAT08Ckk479AUmaErJ6H13uCbR2im646kPrspsBrS9fjl5BtoF78+r/rQt0sdKlsaC4rzz7BXu7URkI7PtJYw998AyoSqJsIEwfkvwwVjorRTREq8ctSn55X0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395742; c=relaxed/simple;
	bh=5c2W3df8hujD+lsryMlfZVWTEtgYqljLNQ17LpwZ8OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GRssLa0mNpJXsd5rJ3E2Y2Zg4Ldfmf7Hlx1PTY1r2ydVEg6Uj+bjzSMIGr1tWHDh29AGhYMTHG9KyDfHMDyNeIwk7lbxx5x7YhDPZAfKkVzWblQPUZra2+eIzLsZl5X0IyrHCAJC6MG5i6x/O+2ecxhMR4E7OrRpepeCPO22/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SAp8ABQ0; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SAp8ABQ0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6HFrbM723sqpe+y7ai9Wss8seUmJrJRPOhgyOLXW9fA=;
	b=SAp8ABQ0kr+FddtPCS+WkRyk4XQguR5O1iUQDkQFDf+FbPfr5uRjNYc3YKAAWgO4zNkAIQIaa
	4AkO5FV2lwqDK9mv/pU6mg3/2C21oGWRs0xrBzuK70Y8KYe8bKmrY4eLwxQGJnhd/0JPrmueNNi
	UjP3DBr3wI1MHHb4TkpNfZg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fXKVT123FzLlTZ;
	Fri, 13 Mar 2026 17:50:41 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DD694056D;
	Fri, 13 Mar 2026 17:55:37 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 13 Mar
 2026 17:55:36 +0800
Message-ID: <75690ddf-5acb-40c1-b6f2-9b9a4397e473@huawei.com>
Date: Fri, 13 Mar 2026 17:55:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of
 arch-specific JITs
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
	<yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, Anton
 Protopopov <a.s.protopopov@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
	<alexis.lothore@bootlin.com>, Shahab Vahedi <list+bpf@vahedi.org>, Russell
 King <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi
 Chen <hengqi.chen@gmail.com>, Johan Almbladh
	<johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, Hari
 Bathini <hbathini@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi
 Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "David S . Miller"
	<davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260312170255.3427799-1-xukuohai@huaweicloud.com>
 <20260312170255.3427799-2-xukuohai@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/3/13 1:02, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> During the JIT stage, constants blinding rewrites instructions but only
> rewrites the private instruction copy of the JITed subprog, leaving the
> global instructions and insn_aux_data unchanged. This causes a mismatch
> between subprog instructions and the global state, making it difficult
> to look up the global insn_aux_data in the JIT.
> 
> To avoid this mismatch, and given that all arch-specific JITs already
> support constants blinding, move it to the generic verifier code, and
> switch to rewrite the global env->insnsi with the global states
> adjusted, as other rewrites in the verifier do.
> 
> This removes the constants blinding calls in each JIT, which are largely
> duplicated code across architectures.
> 
> Since constants blinding is only required for JIT, and there are two
> entry functions for JIT, jit_subprogs() and bpf_prog_select_runtime(),
> move the constants blinding invocation into the two functions.
> 
> If constants blinding fails, or if it succeeds but the subsequent JIT
> compilation fails, kernel falls back to running the BPF program with
> interpreter. To ensure a correct rollback, the program cloning before
> instruction rewriting in the constants blinding is preserved. During
> the blinding process, only the cloned instructions are patched, leaving
> the original program untouched.
> 
> Since bpf_patch_insn_data() is chosen for the constants blinding in the
> verifier path, and it adjusts the global auxiliary data in the verifier
> state, a key question is whether this auxiliary data should be restored
> when JIT fails?
> 
> Besides instructions, bpf_patch_insn_data() adjusts env->insn_aux_data,
> env->subprog_info, prog->aux->poke_tab and env->insn_array_maps. env->
> insn_aux_data and env->subprog_info are no longer used after JIT failure
> and are freed at the end of bpf_check(). prog->aux->poke_tab is only
> used by JIT. And when the JIT fails, programs using insn_array would be
> rejected by bpf_insn_array_ready() function since no JITed addresses
> available. This means env->insn_array_maps is only useful for JIT.
> Therefore, all the auxiliary data adjusted does not need to be restored.
> 
> For classic BPF programs, constants blinding works as before since it
> is still invoked from bpf_prog_select_runtime().
> 
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   arch/arc/net/bpf_jit_core.c      | 39 ++++++-----------
>   arch/arm/net/bpf_jit_32.c        | 41 +++---------------
>   arch/arm64/net/bpf_jit_comp.c    | 72 +++++++++----------------------
>   arch/loongarch/net/bpf_jit.c     | 59 ++++++++------------------
>   arch/mips/net/bpf_jit_comp.c     | 20 +--------
>   arch/parisc/net/bpf_jit_core.c   | 73 +++++++++++++-------------------
>   arch/powerpc/net/bpf_jit_comp.c  | 68 +++++++++++------------------
>   arch/riscv/net/bpf_jit_core.c    | 61 ++++++++++----------------
>   arch/s390/net/bpf_jit_comp.c     | 59 +++++++++-----------------
>   arch/sparc/net/bpf_jit_comp_64.c | 61 +++++++++-----------------
>   arch/x86/net/bpf_jit_comp.c      | 43 +++----------------
>   arch/x86/net/bpf_jit_comp32.c    | 33 ++-------------
>   include/linux/filter.h           | 11 ++++-
>   kernel/bpf/core.c                | 66 +++++++++++++++++++++++++----
>   kernel/bpf/verifier.c            | 40 +++++++++++------
>   15 files changed, 281 insertions(+), 465 deletions(-)

[...]

>   /*
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index b3581e926436..527baa50dc68 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -44,29 +44,19 @@ bool bpf_jit_needs_zext(void)
>   struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   {
>   	unsigned int prog_size = 0, extable_size = 0;
> -	bool tmp_blinded = false, extra_pass = false;
> -	struct bpf_prog *tmp, *orig_prog = prog;
> +	bool extra_pass = false;
>   	int pass = 0, prev_ninsns = 0, i;
>   	struct rv_jit_data *jit_data;
>   	struct rv_jit_context *ctx;
>   
>   	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>   
>   	jit_data = prog->aux->jit_data;
>   	if (!jit_data) {
>   		jit_data = kzalloc_obj(*jit_data);
>   		if (!jit_data) {
> -			prog = orig_prog;
> -			goto out;
> +			return prog;
>   		}
>   		prog->aux->jit_data = jit_data;
>   	}
> @@ -83,15 +73,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>   	ctx->prog = prog;
>   	ctx->offset = kzalloc_objs(int, prog->len);
> -	if (!ctx->offset) {
> -		prog = orig_prog;
> +	if (!ctx->offset)
>   		goto out_offset;
> -	}
>   
> -	if (build_body(ctx, extra_pass, NULL)) {
> -		prog = orig_prog;
> +	if (build_body(ctx, extra_pass, NULL))
>   		goto out_offset;
> -	}
>   
>   	for (i = 0; i < prog->len; i++) {
>   		prev_ninsns += 32;
> @@ -105,10 +91,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   		bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
>   		ctx->prologue_len = ctx->ninsns;
>   
> -		if (build_body(ctx, extra_pass, ctx->offset)) {
> -			prog = orig_prog;
> +		if (build_body(ctx, extra_pass, ctx->offset))
>   			goto out_offset;
> -		}
>   
>   		ctx->epilogue_offset = ctx->ninsns;
>   		bpf_jit_build_epilogue(ctx);
> @@ -126,10 +110,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   							  &jit_data->ro_image, sizeof(u32),
>   							  &jit_data->header, &jit_data->image,
>   							  bpf_fill_ill_insns);
> -			if (!jit_data->ro_header) {
> -				prog = orig_prog;
> +			if (!jit_data->ro_header)
>   				goto out_offset;
> -			}
>   
>   			/*
>   			 * Use the image(RW) for writing the JITed instructions. But also save
> @@ -150,7 +132,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   
>   	if (i == NR_JIT_ITERATIONS) {
>   		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
> -		prog = orig_prog;
>   		goto out_free_hdr;
>   	}
>   
> @@ -163,26 +144,27 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	ctx->nexentries = 0;
>   
>   	bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
> -	if (build_body(ctx, extra_pass, NULL)) {
> -		prog = orig_prog;
> +	if (build_body(ctx, extra_pass, NULL))
>   		goto out_free_hdr;
> -	}
>   	bpf_jit_build_epilogue(ctx);
>   
>   	if (bpf_jit_enable > 1)
>   		bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
>   
> -	prog->bpf_func = (void *)ctx->ro_insns + cfi_get_offset();
> -	prog->jited = 1;
> -	prog->jited_len = prog_size - cfi_get_offset();
> -
>   	if (!prog->is_func || extra_pass) {
>   		if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
>   			/* ro_header has been freed */
>   			jit_data->ro_header = NULL;
> -			prog = orig_prog;
> -			goto out_offset;
> +			jit_data->header = NULL;
> +			goto out_free_hdr;

Thank you for fixing this issue, and the riscv port looks good to me.

Reviewed-by: Pu Lehui <pulehui@huawei.com> # riscv

>   		}
> +	}
> +
> +	prog->bpf_func = (void *)ctx->ro_insns + cfi_get_offset();
> +	prog->jited = 1;
> +	prog->jited_len = prog_size - cfi_get_offset();
> +
> +	if (!prog->is_func || extra_pass) {
>   		/*
>   		 * The instructions have now been copied to the ROX region from
>   		 * where they will execute.
> @@ -198,14 +180,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   		kfree(jit_data);
>   		prog->aux->jit_data = NULL;
>   	}
> -out:
>   
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
>   	return prog;
>   
>   out_free_hdr:
> +	if (extra_pass) {
> +		prog->bpf_func = NULL;
> +		prog->jited = 0;
> +		prog->jited_len = 0;
> +	}
>   	if (jit_data->header) {
>   		bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
>   				   sizeof(jit_data->header->size));

