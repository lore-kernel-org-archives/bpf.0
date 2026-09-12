Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026F361675;
	Sat, 12 Sep 2026 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789189435; cv=none; b=d8EqqBMM/9JJEPWusRpqJMxmiGBDWDixFQeD/pRBrWNjP0VMmtHXQy7Ebehl5db4CzEBLiYXRXNCiN6fG8dMrewgLwS+iRj0lSu12QXqxrHqsTFwymhQZQ/FcxkkkL3AWWdoc7fmDKxkkBRlLQTT/GlaJ1cWdxZPXGXz3sLKGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789189435; c=relaxed/simple;
	bh=RwaSNqZDRhdH9mRXNvquCFfb0vxfosArKnuzX0wUFjg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mTfC97NBxkj4BN1ZVxbPQCuCj29BZFQ4CbBI1EzekF+dz967jdaldy9ecg3eeJoiHTlRP6+owrzEahLXkO9HlMW4jK6FReEcR2IjaFzmvy6uvW9G4EMBwE5kWl73LXLLUgY7VNePCb2GE/Eht3JglKVeMAutrPscUtkeLxN9sI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6Cl5z/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6Cl5z/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3754F1F000FF;
	Sat, 12 Sep 2026 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789189433;
	bh=bKj96gvwS9n+5i3myP6pHv58S2LsfA/3UdxX/yGtwp8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d6Cl5z/wytHinrCY3mC3ZkAbmBr8Mys74Z9biycZr83zbWDLwN5UYNhXTgGGHoC8I
	 CA9X0iojQyJPgt+LJIZG4ALc1DrI3ofmSshsHPEAsbLr1LkTsQKlq9Y0SkfB63pVgR
	 89cqxbxGGW6lrZd/kSOkSmRBWyMfmuG1fJItIX7J7V+KZySsfI6ZuAwmDTvkNsCmR3
	 40hOipHUyRCu3NwchBABXs2+u06wfoVxE8PpW+ghd3YSX/ATcDmMLAJD7T660a8ipM
	 476gb9/QyZgWiJ11UJncNBjF9I4M8uagoGpP0KsbZ3Yke49Od2elb3q/oWdeHmWDKU
	 Mf25GmNnle8Ng==
Content-Type: multipart/mixed; boundary="===============2542250527930730680=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b4cc37b0ee6e1aa473c372e07c89f8fd60ac5f89bad550275edd3f7dc8f8e24@mail.kernel.org>
In-Reply-To: <20260912041220.444715-3-main.kalliope@gmail.com>
References: <20260912041220.444715-3-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-mips@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 12 Sep 2026 05:03:52 +0000 (UTC)

--===============2542250527930730680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit f3f0abd62d699a78db3e8f185879a2fede98c6f7
> Author: Nicholas Dudar <main.kalliope@gmail.com>
> Date:   Sat Sep 12 00:12:20 2026 -0400
>
>     bpf, mips: Add support for BPF_MOVSX in the JITs
>
>     Both MIPS JITs ignore insn->off when lowering register MOV
>     instructions, so BPF_MOVSX is emitted as an ordinary move. Since
>     build_insn() accepts it, affected programs are silently miscompiled
>     instead of falling back to the interpreter.
>
>     Decode the MOVSX width from insn->off in the register-move helpers.
>     On MIPS32, propagate the sign into the high word for ALU64 while
>     preserving the existing ALU32 zero-extension handling.
>
>     Use seb/seh on MIPS32 R2-or-newer CPUs and shift pairs otherwise.
>     On MIPS64, seb/seh require a sign-extended 32-bit source. Normalizing
>     an arbitrary BPF register first would cost another instruction, so
>     retain the doubleword shift pairs.
>
>     Assisted-by: Codex:gpt-6
>     Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>

The changelog describes a silent miscompilation of already-loadable BPF
programs, which indicates this is a bug fix. Should this include a Fixes:
tag pointing to the commit that introduced BPF_MOVSX to the instruction
set?

    Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")

That commit added BPF_MOVSX by reusing BPF_ALU|BPF_MOV|BPF_X with insn->off
in {8,16,32}. Because the MIPS build_insn() cases match on insn->code only,
every MOVSX became a plain move from that point on.

> diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
> index bfe73b023983..11b080a99b9f 100644
> --- a/arch/mips/net/bpf_jit_comp32.c
> +++ b/arch/mips/net/bpf_jit_comp32.c
> @@ -190,20 +190,67 @@ static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
>  	}
>  }
>
> -/* Register move operation (32-bit) */
> +/* Sign-extend an 8- or 16-bit field into a native register. */
> +static void emit_movsx_r(struct jit_context *ctx, u8 dst, u8 src, s16 off)
> +{
> +	int shift;
> +
> +	if (cpu_has_mips32r2 || cpu_has_mips32r6) {
> +		if (off == 8)
> +			emit(ctx, seb, dst, src);
> +		else
> +			emit(ctx, seh, dst, src);

Does this compile? The MIPS uasm assembler appears to have no seb/seh
emitter. The emit() macro (arch/mips/net/bpf_jit_comp.h:88-96) expands to
uasm_i_##func(), so these lines become uasm_i_seb() and uasm_i_seh().

Looking at arch/mips/include/asm/uasm.h, the instruction list goes:

    Ip_u2s3u1(_sb);
    Ip_u2s3u1(_sc);
    Ip_u2s3u1(_scd);
    Ip_u2s3u1(_sd);
    Ip_u3u1u2(_seleqz);
    Ip_u3u1u2(_selnez);
    Ip_u2s3u1(_sh);
    Ip_u2u1u3(_sll);

There is no Ip_u2u1(_seb) or Ip_u2u1(_seh) declaration (compare
Ip_u2u1(_wsbh), which is the same 2-operand form needed here).

Also, arch/mips/mm/uasm-mips.c, uasm-micromips.c and uasm.c contain no
insn_seb or insn_seh table entries. The patch touches only the two JIT
files, so no uasm support is added.

With CONFIG_32BIT=y + CONFIG_BPF_JIT, the build of bpf_jit_comp32.o would
fail with:

    error: implicit function declaration of 'uasm_i_seb'
    error: implicit function declaration of 'uasm_i_seh'

The else arm below (shift = 32 - off; sll; sra) is correct for both
off==8 and off==16, so it could be used unconditionally. Or seb/seh could
be added to uasm in a preparatory patch (they are part of special3/bshfl
with opcode seb_op/seh_op, alongside the existing wsbh instruction).

> +	} else {
> +		shift = 32 - off;
> +		emit(ctx, sll, dst, src, shift);
> +		emit(ctx, sra, dst, dst, shift);
> +	}
> +}
> +
> +/* Register move operation (32-bit), optionally with sign extension */
>  static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
> -			 const u8 src[])
> +			 const u8 src[], s16 off)
>  {
> -	emit_mov_r(ctx, lo(dst), lo(src));
> +	switch (off) {
> +	case 8:
> +	case 16:
> +		emit_movsx_r(ctx, lo(dst), lo(src), off);
> +		break;
> +	default:
> +		/* off == 0 is MOV; the verifier rejects other offsets. */
> +		emit_mov_r(ctx, lo(dst), lo(src));
> +		break;
> +	}
> +	clobber_reg(ctx, lo(dst));
>  	emit_zext_ver(ctx, dst);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34672810925
--===============2542250527930730680==--
