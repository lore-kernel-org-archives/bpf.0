Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60243D561
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241998; cv=none; b=jerY2WssZUaVnQWjbu4lYq1TriS933BUDTRDDHEwEf1D6uRFa/dTw+40QOdNyKQt2NiTviKlsG6CWgyfa3LS+q9mdwHf+Bb4u2+oqSDFfitieFJTPOFuPqwxYm3Ae74WkMTH5ONCvJj4AHhqhC52DmZGHgKAdNNzc4jXo9w0WnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241998; c=relaxed/simple;
	bh=xA+7SVMmIPabn/QvTxvzRezQnD8gjuFtZnI91du1eOE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rdRipyUQKza01idD/ala/4cy7l22anq3RlR9gtwSOsPMXG2OxHRWuPYVucAzMqQB0wb7loXcOqxkV57ClQn56Xsfk7ZRo/8nkVMPXnsa5WXzWKnGEzw9/847PY6/bIe4ttJcgNAZwGTT3/Iqd3/OsRZPRorFujtuD1aKUZSowPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=N/jbgJpg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="N/jbgJpg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82cf636dac8so995575b3a.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775241996; x=1775846796; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQA9l6pJtIusAEoQ3XC6hB3PnHCxdxk5R6lGy4Viwvg=;
        b=N/jbgJpgkdTHWHteyFkV5QCkAtqhIEfxfb2vjibfa2nfGNHEmgTYA7yD4YEmxLBVqL
         4Gou2YJAVLG8epqPoPr4slhiGibl/2VJgIMcNjuccqArWr2RJ6bcmuF4ooBQaNrgtP8Y
         dCNVRevgYUxVyO4LqHIrO7drDMDk3wq4p9RUe1oL/yeRqXS8b/aJBQmcDY8DSWeUI1VF
         /rfhrHd6pxmi8sKlSXm9bjPRtDZfQnQG3rteK+wLytnEP6L+TLUjLS8pDf7dXBgwPV1q
         8+uzV/yoG9EJeXPfh70Ipj7Z0GAQoQGC/fkBtWeXq6yGKeTl9BUKz3WWRpysA26pCxmD
         RXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241996; x=1775846796;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQA9l6pJtIusAEoQ3XC6hB3PnHCxdxk5R6lGy4Viwvg=;
        b=JYRYfe2S05kt6OqpKuvGZdKARXAxxoJ2pL+67hiFODWq54esbTtPRWqJG6OCICI1Is
         q6I7bOM1p58Kdg3ZeTm+SqS/OVgqoLFcdIE7TntQF4m+UMvXfjnbt77RjkXnrXLU0fT1
         2RziVOsvNPTFJay0Hku5cBAI4BWtVwaGlU5h8Tcnk18jJnGt8kNnp2mAsHAcK66GCJWT
         dPNYFbbDg6T46zBcKi5OfrI46kyQFXWpxZUquiUJGaMg9FfSOTD2G/X3Kes8n2HRgwrf
         gCSzBemOkXVXz58L8+f0QnyNzv3yj3Ui3NyukZT0X6cIY+JkdOq9wGn4BKGn7lOzjgyl
         E6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxffQn2888UtbeeWEKSwVMIzrfCn9PLV1uxbeNZXP3j92RQosXU8xtbgANZZzoiDoME90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EXVC2PjjqSP1CRbbBFVTse9rTq11Z1+v6vBawGm0KpC75oMx
	h1lVlIcHCMIWusOtvuB2BIAo1eRXWtJ/0TsBznKLWMwbSw8Md/Xgnyttr6vP0P7KgQw=
X-Gm-Gg: AeBDievYug1cdLQObp6V5KgC90fS8u5u0Kh3BN2hEOBVVTSMBQOKF4Y92D5ZDUIQTbN
	fTkONTBdnwNuZ3HdS/+Zz7SydvwprEYNl6tlT0xKxw+56Ghjh2k6D1I6KWSNfr52ml7ION9Fgpn
	65XjFGECYnYp87cUHLUIKM6FtrlU/SGU6CwbnfEVnhL5/5kkl8BRWxNJc2DVqgQWUuHEbRBdBJY
	5z+Q1zPkjU5L/E91wC9LNzWU5VklKIC74nghbCn/G0+omq7vS+iyMUAZR+Pb38tIZ7JXwQnrU8+
	c/1ylT/DkM18+tQ7q61CWpgUIChMcnLXmSkyue0BUsjdqKhF5rj1TGyemA0lQnajDd9L4muCImx
	IFeYC7cGTagafGQMJ0Pftc4z8CId7DdbUxQYpluIN+PKiKq0duKXX+atyJNVHOpBd5YfnZ06qtm
	H6LEAtaUA=
X-Received: by 2002:a05:6a00:1881:b0:7e8:4471:ae6d with SMTP id d2e1a72fcca58-82d0dd0011dmr3764746b3a.57.1775241996038;
        Fri, 03 Apr 2026 11:46:36 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6fdd7sm6488813b3a.48.2026.04.03.11.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 11:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 14:46:34 -0400
Message-Id: <DHJQRLPOK7EA.1SSXDLAB9TWJZ@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Anton Protopopov" <a.s.protopopov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Shahab
 Vahedi" <list+bpf@vahedi.org>, "Russell King" <linux@armlinux.org.uk>,
 "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi Chen"
 <hengqi.chen@gmail.com>, "Johan Almbladh"
 <johan.almbladh@anyfinetworks.com>, "Paul Burton" <paulburton@kernel.org>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>, "Luke Nelson"
 <luke.r.nels@gmail.com>, "Xi Wang" <xi.wang@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "David
 S . Miller" <davem@davemloft.net>, "Wang YanQing" <udknight@gmail.com>
Subject: Re: [PATCH bpf-next v12 4/5] bpf, x86: Emit ENDBR for indirect jump
 targets
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403132811.753894-1-xukuohai@huaweicloud.com>
 <20260403132811.753894-5-xukuohai@huaweicloud.com>
In-Reply-To: <20260403132811.753894-5-xukuohai@huaweicloud.com>

On Fri Apr 3, 2026 at 9:28 AM EDT, Xu Kuohai wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

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
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 72d9a5faa230..ea9e707e8abf 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -58,8 +58,8 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int l=
en)
>  #define EMIT_ENDBR()		EMIT(gen_endbr(), 4)
>  #define EMIT_ENDBR_POISON()	EMIT(gen_endbr_poison(), 4)
>  #else
> -#define EMIT_ENDBR()
> -#define EMIT_ENDBR_POISON()
> +#define EMIT_ENDBR()		do { } while (0)
> +#define EMIT_ENDBR_POISON()	do { } while (0)
>  #endif
> =20
>  static bool is_imm8(int value)
> @@ -1649,8 +1649,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 =
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
> @@ -1663,7 +1663,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
>  	void __percpu *priv_stack_ptr;
>  	int i, excnt =3D 0;
>  	int ilen, proglen =3D 0;
> -	u8 *prog =3D temp;
> +	u8 *ip, *prog =3D temp;
>  	u32 stack_depth;
>  	int err;
> =20
> @@ -1734,6 +1734,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>  				dst_reg =3D X86_REG_R9;
>  		}
> =20
> +		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
> +			EMIT_ENDBR();
> +
> +		ip =3D image + addrs[i - 1] + (prog - temp);
> +
>  		switch (insn->code) {
>  			/* ALU */
>  		case BPF_ALU | BPF_ADD | BPF_X:
> @@ -2440,8 +2445,6 @@ st:			if (is_imm8(insn->off))
> =20
>  			/* call */
>  		case BPF_JMP | BPF_CALL: {
> -			u8 *ip =3D image + addrs[i - 1];
> -
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
>  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -2465,7 +2468,8 @@ st:			if (is_imm8(insn->off))
>  			if (imm32)
>  				emit_bpf_tail_call_direct(bpf_prog,
>  							  &bpf_prog->aux->poke_tab[imm32 - 1],
> -							  &prog, image + addrs[i - 1],
> +							  &prog,
> +							  ip,
>  							  callee_regs_used,
>  							  stack_depth,
>  							  ctx);
> @@ -2474,7 +2478,7 @@ st:			if (is_imm8(insn->off))
>  							    &prog,
>  							    callee_regs_used,
>  							    stack_depth,
> -							    image + addrs[i - 1],
> +							    ip,
>  							    ctx);
>  			break;
> =20
> @@ -2639,7 +2643,7 @@ st:			if (is_imm8(insn->off))
>  			break;
> =20
>  		case BPF_JMP | BPF_JA | BPF_X:
> -			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
> +			emit_indirect_jump(&prog, insn->dst_reg, ip);
>  			break;
>  		case BPF_JMP | BPF_JA:
>  		case BPF_JMP32 | BPF_JA:
> @@ -2729,8 +2733,6 @@ st:			if (is_imm8(insn->off))
>  			ctx->cleanup_addr =3D proglen;
>  			if (bpf_prog_was_classic(bpf_prog) &&
>  			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
> -				u8 *ip =3D image + addrs[i - 1];
> -
>  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
>  					return -EINVAL;
>  			}
> @@ -3791,7 +3793,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
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

