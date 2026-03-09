Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC173E8C6B
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073771; cv=none; b=B5UdppDXzERLaShB4sERGQOyevgdzMDWKbaR+xBgq6xQPPUM0aC7ofJVw19RLBMQrmPxyv2+NSVHpOatYYXOVUgLLTZcKPyieo9K95lTlPmOCr7sPlvsdyLB0dOnMCH9olTCDiDn1LBk2ZNtNmzdRFDSoYEa76b7ab9TyoWsR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073771; c=relaxed/simple;
	bh=sy/csZ9qYJvyx0Yth+q0jvxJ72s/YhvX4d14B5XLrYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/L6cZ2lATmG2hk5YJUiP9K1Deepm9H+wYcM/X48G9HU540eQRUmvsyB+7ibxrkYF6Al6ggBpmBU1RdBCRCWCPyDWIwDTbHvGRz6KZE/PdCPzeqd4jgGv+jeiPiD++nPAa9oTYc3GfxrBJihDs/bArzPMOUCtejgjnGxriuAeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bohEd6BN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bohEd6BN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48529c325f0so21422915e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073768; x=1773678568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqJYl3zPZN2KFVigj33M+KDn8csTHg3syExrZwynl6M=;
        b=bohEd6BNxnBG9Y/cr/ap/F4X/QSyeJ/XFTVkDlEKqJ7bJHnXrepXjK+z0y/Pcn0WeJ
         ZA9ZLm7F41A4FiHoCcfbgz7hBGvjKBpaNwI5QMUwK+skmseDC6VzZmumk3f5dkCQMdcc
         mu5wIuAMjYdPoURkVUkc01Z+o8REbOz0XXMH4c4sL+2xHHVCtD+7SYcw5ZfG7OwFg0Z2
         f0DTQx9wrIrTlXxshbqdJH+GL2F6b4HaSNOgc3XYntIuS/GGYRJdTg4NgDD8chnu7ChM
         hb8BhsCh+CgFcEFNZlyhHFDHVQ51n9V6U/KCenVDcKJ/VLOm1E1Q89O7kBXgJBqqSDV0
         kE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073768; x=1773678568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqJYl3zPZN2KFVigj33M+KDn8csTHg3syExrZwynl6M=;
        b=giCptvlHBl+d8WY/+wyMUh+ch0X0fKSBa0GMJXc19V0lwjXTo1zBaznXKtizAhcIhm
         Tjs28fUsnuivzBIuVd4sSMdjSKdm/nGYvC3YGCf2W0+LsDWt1Q4yLjQ3NyqtjkkfEu4Z
         FOYUDkqeDqoJHuugllXgDErTGcbK4mfwpsxwuJ/FDz+vfK40n1Wcfg+XhXLLmsLvfpt1
         JI8XuxD91QGsb/GRex3cbUm6sBoSBGQ0LTt0QKaPQ6xq/rSQpCr31Leg4kKiKHQpDwGl
         wH0qUT1cETj2/4mJmOOo11jF9yWt/6jVZGfqfnHzjr54yeXZp/kuVNsFtaMGhbX/Dyn6
         K63A==
X-Gm-Message-State: AOJu0YyXQuRFJFeRyeODcvIdQhKsPFCna2ZC3F4FcF8re6b1eJaGWF2T
	ELp9LTTWanxgum40h26RNV0+02k8ie7MyfucBjo3Ic46MCendJrk35MD
X-Gm-Gg: ATEYQzz3BP6n1e4Ihz/zGjohweZz2Q0cnixUy/DfFpZMUcPa6AhZuFNCrRT2+hYwb07
	FvrcxErX0c7RGhiw6ziAaBOFH1m2a6o01Wllj8GU92SeYocGUt8iWdNmslTPm1IJ82FpDmq2A7H
	lYl5H1OqXT5ijgk1pxf/X6dDIrdUIo/CnHwPPh4u7Yq9co7NGxDpyaj4Eg3jOQVaEflFZrUdFXP
	dT188+Q3jQEjJ/QzoZF3gOatjKD6rBS9zVAomaZ4DlihpX9RFRQH5BdXslvLqAb6ptXekXa6bK8
	EhDCZWxUY6yzLiiHFkSfLNjmUV+Fg29U6whtHYE2QoAgqBl9C3Scg4JdOToN8TeFs4O4efVWEO0
	/s36HanMFNjzBaJ1RXOxAEGy1BkQX25EJyWhtc+UKpkbsocv/N2DKvhvp/xf+lMR7BQ==
X-Received: by 2002:a05:600c:6217:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-4853f580f32mr34856035e9.30.1773073766062;
        Mon, 09 Mar 2026 09:29:26 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ac17f2sm2008225e9.6.2026.03.09.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:29:25 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:37:58 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v8 4/5] bpf, x86: Emit ENDBR for indirect jump targets
Message-ID: <aa73Zu0TC7jUEDju@mail.gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-5-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309140044.2652538-5-xukuohai@huaweicloud.com>

On 26/03/09 10:00PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> On CPUs that support CET/IBT, the indirect jump selftest triggers
> a kernel panic because the indirect jump targets lack ENDBR
> instructions.
> 
> To fix it, emit an ENDBR instruction to each indirect jump target. Since
> the ENDBR instruction shifts the position of original jited instructions,
> fix the instruction address calculation wherever the addresses are used.
> 
> For reference, below is a sample panic log.
> 
>  Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>  ------------[ cut here ]------------
>  kernel BUG at arch/x86/kernel/cet.c:133!
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
> 
>  ...
> 
>   ? 0xffffffffc00fb258
>   ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>   bpf_prog_test_run_syscall+0x110/0x2f0
>   ? fdget+0xba/0xe0
>   __sys_bpf+0xe4b/0x2590
>   ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
>   ? bpf_prog_test_run_syscall+0x215/0x2f0
>   __x64_sys_bpf+0x21/0x30
>   do_syscall_64+0x85/0x620
>   ? bpf_prog_test_run_syscall+0x1e2/0x2f0
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b95f23ad1093..251dff1cd8e4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1649,8 +1649,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>  	return 0;
>  }
>  
> -static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> -		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
> +		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
>  {
>  	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
>  	struct bpf_insn *insn = bpf_prog->insnsi;
> @@ -1663,7 +1663,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>  	void __percpu *priv_stack_ptr;
>  	int i, excnt = 0;
>  	int ilen, proglen = 0;
> -	u8 *prog = temp;
> +	u8 *ip, *prog = temp;
>  	u32 stack_depth;
>  	int err;
>  
> @@ -1734,6 +1734,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>  				dst_reg = X86_REG_R9;
>  		}
>  
> +#ifdef CONFIG_X86_KERNEL_IBT
> +		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
> +			EMIT_ENDBR();
> +#endif
> +
> +		ip = image + addrs[i - 1] + (prog - temp);
> +
>  		switch (insn->code) {
>  			/* ALU */
>  		case BPF_ALU | BPF_ADD | BPF_X:
> @@ -2440,8 +2447,6 @@ st:			if (is_imm8(insn->off))
>  
>  			/* call */
>  		case BPF_JMP | BPF_CALL: {
> -			u8 *ip = image + addrs[i - 1];
> -
>  			func = (u8 *) __bpf_call_base + imm32;
>  			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
>  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -2465,7 +2470,8 @@ st:			if (is_imm8(insn->off))
>  			if (imm32)
>  				emit_bpf_tail_call_direct(bpf_prog,
>  							  &bpf_prog->aux->poke_tab[imm32 - 1],
> -							  &prog, image + addrs[i - 1],
> +							  &prog,
> +							  ip,
>  							  callee_regs_used,
>  							  stack_depth,
>  							  ctx);
> @@ -2474,7 +2480,7 @@ st:			if (is_imm8(insn->off))
>  							    &prog,
>  							    callee_regs_used,
>  							    stack_depth,
> -							    image + addrs[i - 1],
> +							    ip,
>  							    ctx);
>  			break;
>  
> @@ -2639,7 +2645,7 @@ st:			if (is_imm8(insn->off))
>  			break;
>  
>  		case BPF_JMP | BPF_JA | BPF_X:
> -			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
> +			emit_indirect_jump(&prog, insn->dst_reg, ip);
>  			break;
>  		case BPF_JMP | BPF_JA:
>  		case BPF_JMP32 | BPF_JA:
> @@ -2729,8 +2735,6 @@ st:			if (is_imm8(insn->off))
>  			ctx->cleanup_addr = proglen;
>  			if (bpf_prog_was_classic(bpf_prog) &&
>  			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
> -				u8 *ip = image + addrs[i - 1];
> -
>  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
>  					return -EINVAL;
>  			}
> @@ -3791,7 +3795,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	for (pass = 0; pass < MAX_PASSES || image; pass++) {
>  		if (!padding && pass >= PADDING_PASSES)
>  			padding = true;
> -		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, padding);
> +		proglen = do_jit(env, prog, addrs, image, rw_image, oldproglen, &ctx, padding);
>  		if (proglen <= 0) {
>  out_image:
>  			image = NULL;
> -- 
> 2.47.3

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
