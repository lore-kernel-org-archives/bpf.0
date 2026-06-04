Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05B3F4DDA;
	Thu,  4 Jun 2026 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607601; cv=none; b=cehrsNP2BwpDvPRJvKcXX/apjZlo/GNTev0ddcaXuT5qUXRzBl/GR2+nQd1fTaV5af07yf1r09klVVoEScV38UUHyycRGycdFEpu/8b5cruq5tXaO+mM5t7vNOONPe4g97dO8+vh1Tf5aT2AgkyFImcTHP5B4qTVxZISSwf+M0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607601; c=relaxed/simple;
	bh=swZyldizaZLn8db2uIyOEym5OG0jWZG5d1pQjTRLVxg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VURpQdSB9/oec+HGcqjRE8aACvqTSyQ1ZWhdQ2fwBbl1GRQEghmrk49Dy5h0wTkxMAgS+GNrhJGDzYw9vYXOnUesb0O2Y31UwnAcLhuJGkCIVRuy+3AYuo7vm0IrPVFMFK+qVKRAriY7C1zEQ1uUDNIz8VlsL3el9EQCnJ00ceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxxgafho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxxgafho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D89F1F00893;
	Thu,  4 Jun 2026 21:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607600;
	bh=R+m7Si3D+ole/8K+71lLy8KRgWcJ869l99QxME4GzlE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XxxgafhoyrZUNrj9DMod/PAUvkNiUv2GCWyfl/7nELyGmpgFUfbbgs4IABIUR8bSV
	 iXqujyVPXhwDHm8wMNNuOC2fijPOzLM3GyTDqJ55GKlEwaU5OCgzT0eyL3IYo/5Uh9
	 Fm9ly5QIfRWXCk886bHqoT0brJZSCl3aVgQ0H2u0oVnpScy3cLraxS7bYazcgugO/N
	 W8vBcMi9ncHagU7ElqUYs3PsjcufcD6rkf84Lyxsnp28IZrbxqbcFTzernOXS7dMMc
	 5Rbze6TGAQlswv0ANClo3hsMXoJ0ku8h9UCibajVifNobVlFPYQxYkDcn8d9GNur29
	 BggA9CObmDEjQ==
Content-Type: multipart/mixed; boundary="===============5773208707414677654=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8485a4391b9a9b744bf0f740b60ba73dec5e894a725157f9c336c0225e00a4dd@mail.kernel.org>
In-Reply-To: <20260604-kasan-v2-4-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-4-c066e627fda8@bootlin.com>
Subject: Re: [PATCH bpf-next v2 4/8] bpf, x86: refactor BPF_ST management in do_jit
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mcoquelin.stm32@gmail.com,alexandre.torgue@foss.st.com,ihor.solodrai@linux.dev
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-stm32@st-md-mailman.stormreply.com,linux-arm-kernel@lists.infradead.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 21:13:20 +0000 (UTC)

--===============5773208707414677654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 0981791014eb..943a0f315cf2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2300,41 +2300,50 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			EMIT_LFENCE();
>  			break;
>
> -			/* ST: *(u8*)(dst_reg + off) = imm */
>  		case BPF_ST | BPF_MEM | BPF_B:

[ ... ]

>  		case BPF_ST | BPF_MEM | BPF_DW:
> -			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
> -				/* Arg 6: store immediate in r9 register */
> -				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
> +			switch (BPF_SIZE(insn->code)) {

[ ... ]

> +			case BPF_DW:
> +				if (dst_reg == BPF_REG_PARAMS &&
> +				    insn->off == -8) {
> +					/* Arg 6: store immediate in r9 register */
> +					emit_mov_imm64(&prog, X86_REG_R9,
> +						       imm32 >> 31, (u32)imm32);
> +					break;
> +				}
> +				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>  				break;
>  			}
> -			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>
> -st:			insn_off = insn->off;
> +			insn_off = insn->off;

Has the scope of the Arg 6 break changed here?

In the original code the BPF_DW handling lived directly under the case
label, and its break left the whole outer instruction switch:

	case BPF_ST | BPF_MEM | BPF_DW:
		if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
			/* Arg 6: store immediate in r9 register */
			emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
			break;
		}
		EMIT2(add_1mod(0x48, dst_reg), 0xC7);
	st:	insn_off = insn->off;
		...

So for the Arg 6 case it emitted exactly the movabs into r9 and stopped,
never reaching the st: addressing and immediate emission.

After the refactor, the Arg 6 branch lives inside the inner switch on
BPF_SIZE(), so its break only exits that inner switch:

	case BPF_DW:
		if (dst_reg == BPF_REG_PARAMS &&
		    insn->off == -8) {
			emit_mov_imm64(&prog, X86_REG_R9,
				       imm32 >> 31, (u32)imm32);
			break;
		}
		EMIT2(add_1mod(0x48, dst_reg), 0xC7);
		break;
	}

	insn_off = insn->off;
	if (dst_reg == BPF_REG_PARAMS) {
		insn_off = outgoing_arg_base - outgoing_rsp -
			   insn_off - 16;
		dst_reg = BPF_REG_FP;
	}
	if (is_imm8(insn_off))
		EMIT2(add_1reg(0x40, dst_reg), insn_off);
	else
		EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
	EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));

After emitting the movabs into r9, does control now fall through into
the common insn_off block and emit an additional ModRM/displacement byte
sequence plus a 4-byte immediate that do not belong to any instruction?

Would those extra bytes corrupt the emitted machine code stream for the
Arg 6 path, since dst_reg == BPF_REG_PARAMS with insn->off == -8 is a
reachable case used to pass the 6th outgoing call argument in r9?

Could the original break be preserved here, for example by breaking out
of the outer switch (or skipping the insn_off block) once the Arg 6
movabs has been emitted?

The commit message describes this as grouping the BPF_ST instructions
"in a single block of fall-through cases", implying no behavioral change,
but the Arg 6 path appears to gain extra emitted bytes.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26978380520
--===============5773208707414677654==--
