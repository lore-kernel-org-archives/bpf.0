Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D13AAF47;
	Wed, 29 Jul 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345023; cv=none; b=E2F0hThYLcBUp49Ffg+WCUA2m+/HjL9wJHVJkzLUaSwZ5fWcb/ukfeZtRlZ6A2EJtisl1Z5V7WUvbjc8j1u2tRtU68QR601zSuu0MMed500qAUJqxUMXYAKPN6koXV1HYXa7mTzVmaPDgIM4HsmFxaW/wD/tqxvtf9L1EUe67sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345023; c=relaxed/simple;
	bh=wD6vE6xcugVn1u6Gi38kC7BJZOVI44GILYrxZDwrZ1k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Byg4NSLHevd8CMXUoqiVDMjRCEm9eY5pc2zoW/YKT9pjFF8aoMg3kMh6L7AI7qbfTpfeMFQlnkpRm2meF0+somRfRhyDZIzMrAbiMPzSWYFTTyEKJbt3zFZw5LshNAYUxyQWY5it8xR+1FLydt05Kk/Ha3FbRsfTVBH6nUFS8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jte4XxoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jte4XxoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5181F000E9;
	Wed, 29 Jul 2026 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345022;
	bh=laBt4UKoxa8sWypzZoXW43obiA/jl9TjW1hdr3Bxyek=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jte4XxoU8R582kTfcrT7uAp5w2ITb03jfmEacaE+3JlokS46XhGkSEwor1Odp3omq
	 Fb6Fe/TA2nmP2Tm1U0XBfAaCw4RY5nRIR6mE41BoKnhEgGeMMAy650gJu0JY+8h5O0
	 hwwc0GwQoXcwq/jrL9UxHCZTqOkI5NVN44X4gOlHRpop1nrNTSt7dBzA9ydgVofuha
	 traNpQCeE9mXoySFiG92SK0fpetLi7rlYRHyJ/vtzeUCokMm3+De0SHVZvacTgSqPq
	 +loORddtDXFDeE31yZpvA2gKO0p4HZj2RRXKb5SH1DBkAL9nH8m/Ec8oDRzaOmmdT5
	 /nXu6Q7kdY10A==
Content-Type: multipart/mixed; boundary="===============0867181835217338259=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c517c61555d5ac0e7dda77c6f9a4e3624ef8ed742d6372ab3d5af4879291ec4f@mail.kernel.org>
In-Reply-To: <20260729162931.2369353-2-main.kalliope@gmail.com>
References: <20260729162931.2369353-2-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, mips: Factor out div/mod emission helpers
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,tsbogend@alpha.franken.de,johan.almbladh@anyfinetworks.com,paulburton@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,philmd@oss.qualcomm.com,visitorckw@gmail.com,bpf@vger.kernel.org,linux-mips@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 17:10:20 +0000 (UTC)

--===============0867181835217338259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index 6ee4abe6a1f7..f99bb5705d00 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -338,6 +338,26 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
>  	clobber_reg(ctx, dst);
>  }
>
> +static void emit_div(struct jit_context *ctx, u8 dst, u8 src)
> +{
> +	if (cpu_has_mips32r6) {
> +		emit(ctx, divu_r6, dst, dst, src);
> +	} else {
> +		emit(ctx, divu, dst, src);
> +		emit(ctx, mflo, dst);
> +	}
> +}
> +
> +static void emit_mod(struct jit_context *ctx, u8 dst, u8 src)
> +{
> +	if (cpu_has_mips32r6) {
> +		emit(ctx, modu, dst, dst, src);
> +	} else {
> +		emit(ctx, divu, dst, src);
> +		emit(ctx, mfhi, dst);
> +	}
> +}

This isn't a bug, but would a short header comment on emit_div() and
emit_mod(), in the style of the neighbouring '/* ALU register operation
(32-bit) */', keep these consistent with the rest of the file? Every
other emitter here carries one.

[ ... ]

> diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
> index fa7e9aa37f49..befeb63ae447 100644
> --- a/arch/mips/net/bpf_jit_comp64.c
> +++ b/arch/mips/net/bpf_jit_comp64.c
> @@ -197,6 +197,26 @@ static void emit_alu_i64(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
>  	clobber_reg(ctx, dst);
>  }
>
> +static void emit_div64(struct jit_context *ctx, u8 dst, u8 src)
> +{
> +	if (cpu_has_mips64r6) {
> +		emit(ctx, ddivu_r6, dst, dst, src);
> +	} else {
> +		emit(ctx, ddivu, dst, src);
> +		emit(ctx, mflo, dst);
> +	}
> +}
> +
> +static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src)
> +{
> +	if (cpu_has_mips64r6) {
> +		emit(ctx, dmodu, dst, dst, src);
> +	} else {
> +		emit(ctx, ddivu, dst, src);
> +		emit(ctx, mfhi, dst);
> +	}
> +}

Same for emit_div64() and emit_mod64() here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30472129214
--===============0867181835217338259==--
