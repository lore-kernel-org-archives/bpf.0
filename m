Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C332DC772
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847391; cv=none; b=prG5DAEsqkPjHjJgCFqS4Bop8721lBYqA8n2Le3h06DqG3x/4/cjTazelQkNDej0Ql7xbX9YkRq47CLmePKsdWNANWlcF+OuJ4dOsCIoU+M+K1+v3TDd6/b8tQsiHOjo47MdLjMrWRrFyMtA2kq5RuLQTPA+DoHLBFb+rbAR2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847391; c=relaxed/simple;
	bh=XpsCzMeM2sz6RelZjkDqe5dQBH05ZDxp/n1NiNQIUN4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miz4wfzDjYN9AkTL+Zq+AlNJ2XO6XpglbuyAaJO939r8t7Yln8jh3vieHChdQnLnVmgQx9fwHMgza+CtdCwihAVeDUboqZ4sWY2x/9Rcp9jClxnJnIR1z5hpExpwJZV8qcWt/mDcAYV068ZCmtbzNp72LFLBtZKNy0edjaJkxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOpavggs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOpavggs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae41544dcfso76022535ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 17:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847389; x=1773452189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtY9eIv1n6grxyELFx6qGVbBb/3PRRrubL9WWOp8eJ4=;
        b=MOpavggsM0CI3AFlV+NYVTdmwlpswPcTIg1wfuYJHbR7c1cByYBwt6bFnR7sxlBsYr
         5QzE/Uu8PGJ3XQSAzrpYrqtUrwXHmUHLrv2mFgRVVYQQmwt7GGv31j3dsTyVFa28oyOS
         PnosE3Rt2wLTgZFVHSKOdHNv2HJqvn8XI86xh/vgCYRtY0LGWA1T03LI1EYqBTxtmvyt
         aueqi5zVSQNX7q6ryeXS1UQn8ky99oXJFXSogSYh+duSxbJoKTZxZRO9zTS9qFFJg8nY
         bKv5/sWSM9xyd80VYnjWta2KsZ5xI8BVGhA2/Y6axxLJTBBD4XO/e7FxJxz3ZHsTV4R9
         uTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847389; x=1773452189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtY9eIv1n6grxyELFx6qGVbBb/3PRRrubL9WWOp8eJ4=;
        b=VqFxOAmx6ZpOrax5PeP4WZtG2rVp80EyDU+6X2oFAfLXCCrcZqwjC1S5Yrdcdh1fY3
         vyHBXfnEQe3bE7XMugem8/8Lrn92kqwtGaD3OemcPgzOlds6wV0ZvHug/CrONbItn35v
         5ntan4RjwIFyOgjIGKb/QMiV8D7fnAomAouiudsrnp0PN/mdJk4Sg3MkE6O+YCb38g2W
         6+CIg2yvO2ohqr6VmA3avMtfI9IkSzHrsmj2vz1ZcbpTArnUfTu9I/VGHIC/DzH4vBVT
         INgCK18en31pAgsJErP28rhQXdFF+w89MWp3zsdgoEaFe+vWtyLgt0f13X4tvgKLRUow
         NVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ucCt200s2l7OUm1T3OlXhqAYw2GWRQtbbCNLLd6sYbxioTqMS4KfyVj17sDcZuDfk1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx386U4uOTsAffKpHaFfazNXkxyH/EaokMv7HLgE9T8WTIp7NQ0
	jokCyYtba9g6ey2df9XkPEkJbDTgdRisEyvNTlTpSEye0vvu+Saf8ZM9
X-Gm-Gg: ATEYQzzgRWyrLncQLkQD1ual9x/C1IlOpZSVas1JKB3TqxjjPjmslO0g9TnbgK+mF1s
	2GubJ+P2kkBfZp7l7mYZ1i22bPy+j59xmdsNK00jiMBhaTLuFDwuP33lvgTbeliZPXn4CrHgEWy
	MHk6+c6sNTtC3IwmeA2Fdsr5rzgm1zvstfzSoyiM+7cgteF1+ISPX6wLUgfs5F5Z8sE1EQ+0gkM
	4SFyN4rdgPd8H0QLmVsDAY0osR98kUwWRxWezkjO4FdYmCS/rzQNOVqsWzowMof/xUdDwKZqZ0X
	/DrJjh/tNUvEl42euD3QrORukw68TiMvacoxJ/YR/FeQYKuPOqYTuruWlJjeSqNbomPp9FUwUlF
	y13ECBDDUvJ8NiWviwckP27JGqR1b5PEVcYaAk19RAlZY5kHScp/yl8HtidFb7M6RXF7dJeGSBP
	1hfSaDMPIc5ZuW/J889EgAzzRjFWtX5hcXLClTP7oJQlScf+B1J5E6p+a08968okSoMMDGhf9Ck
	5zMe10pT9NaG2WpXhHDLRbW1md0n0M=
X-Received: by 2002:a17:903:388f:b0:2ae:50a3:3aa5 with SMTP id d9443c01a7336-2ae824879a7mr43068715ad.52.1772847389159;
        Fri, 06 Mar 2026 17:36:29 -0800 (PST)
Received: from ?IPv6:2605:8d80:58a0:ac1f:d4e0:c92d:83b9:f4f5? ([2605:8d80:58a0:ac1f:d4e0:c92d:83b9:f4f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eada11sm33195185ad.38.2026.03.06.17.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:36:28 -0800 (PST)
Message-ID: <c79adbee77ba5ce11d3df1ffa922c48937c8b536.camel@gmail.com>
Subject: Re: [bpf-next v6 4/5] bpf, x86: Emit ENDBR for indirect jump targets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>, Shahab Vahedi <list+bpf@vahedi.org>, Russell
 King	 <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi
 Chen	 <hengqi.chen@gmail.com>, Johan Almbladh
 <johan.almbladh@anyfinetworks.com>,  Paul Burton <paulburton@kernel.org>,
 Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy	
 <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>, Luke Nelson	
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=	 <bjorn@kernel.org>, Pu Lehui
 <pulehui@huawei.com>, Ilya Leoshkevich	 <iii@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Wang YanQing	 <udknight@gmail.com>
Date: Fri, 06 Mar 2026 17:36:21 -0800
In-Reply-To: <20260306102329.2056216-5-xukuohai@huaweicloud.com>
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
	 <20260306102329.2056216-5-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 18:23 +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> On CPUs that support CET/IBT, the indirect jump selftest triggers
> a kernel panic because the indirect jump targets lack ENDBR
> instructions.
>=20
> To fix it, emit an ENDBR instruction to each indirect jump target. Since
> the ENDBR instruction shifts the position of original jited instructions,
> fix the instruction address calculation wherever the addresses are used.
>=20
> For reference, below is a sample panic log.
>=20
>  Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>  ------------[ cut here ]------------
>  kernel BUG at arch/x86/kernel/cet.c:133!
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
>=20
>  ...
>=20
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
>=20
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2c57ee446fc9..752331a64fc0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1658,8 +1658,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 =
*ip,
>  	return 0;
>  }
> =20
> -static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
> -		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_pro=
g, int *addrs, u8 *image,
> +		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padd=
ing)
>  {
>  	bool tail_call_reachable =3D bpf_prog->aux->tail_call_reachable;
>  	struct bpf_insn *insn =3D bpf_prog->insnsi;
> @@ -1743,6 +1743,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>  				dst_reg =3D X86_REG_R9;
>  		}
> =20
> +#ifdef CONFIG_X86_KERNEL_IBT
> +		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
> +			EMIT_ENDBR();
> +#endif
> +
>  		switch (insn->code) {
>  			/* ALU */
>  		case BPF_ALU | BPF_ADD | BPF_X:
> @@ -2449,7 +2454,7 @@ st:			if (is_imm8(insn->off))
> =20
>  			/* call */
>  		case BPF_JMP | BPF_CALL: {
> -			u8 *ip =3D image + addrs[i - 1];
> +			u8 *ip =3D image + addrs[i - 1] + (prog - temp);

Sorry, meant to reply to v5 but got distracted.
It seems tedious/error prone to have this addend at each location,
would it be possible to move the 'ip' variable calculation outside
of the switch? It appears that at each point there would be no
EMIT invocations between 'ip' computation and usage.

> =20
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
> @@ -2474,7 +2479,8 @@ st:			if (is_imm8(insn->off))
>  			if (imm32)
>  				emit_bpf_tail_call_direct(bpf_prog,
>  							  &bpf_prog->aux->poke_tab[imm32 - 1],
> -							  &prog, image + addrs[i - 1],
> +							  &prog,
> +							  image + addrs[i - 1] + (prog - temp),
>  							  callee_regs_used,
>  							  stack_depth,
>  							  ctx);
> @@ -2483,7 +2489,7 @@ st:			if (is_imm8(insn->off))
>  							    &prog,
>  							    callee_regs_used,
>  							    stack_depth,
> -							    image + addrs[i - 1],
> +							    image + addrs[i - 1] + (prog - temp),
>  							    ctx);
>  			break;
> =20
> @@ -2648,7 +2654,8 @@ st:			if (is_imm8(insn->off))
>  			break;
> =20
>  		case BPF_JMP | BPF_JA | BPF_X:
> -			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
> +			emit_indirect_jump(&prog, insn->dst_reg,
> +					   image + addrs[i - 1] + (prog - temp));
>  			break;
>  		case BPF_JMP | BPF_JA:
>  		case BPF_JMP32 | BPF_JA:
> @@ -2738,7 +2745,7 @@ st:			if (is_imm8(insn->off))
>  			ctx->cleanup_addr =3D proglen;
>  			if (bpf_prog_was_classic(bpf_prog) &&
>  			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
> -				u8 *ip =3D image + addrs[i - 1];
> +				u8 *ip =3D image + addrs[i - 1] + (prog - temp);
> =20
>  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
>  					return -EINVAL;
> @@ -3800,7 +3807,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  	for (pass =3D 0; pass < MAX_PASSES || image; pass++) {
>  		if (!padding && pass >=3D PADDING_PASSES)
>  			padding =3D true;
> -		proglen =3D do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, pad=
ding);
> +		proglen =3D do_jit(env, prog, addrs, image, rw_image, oldproglen, &ctx=
, padding);
>  		if (proglen <=3D 0) {
>  out_image:
>  			image =3D NULL;
