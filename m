Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6980391E60
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931290; cv=none; b=O4mKblVK2fPdgdxCT2UUzOLX9sR232qru1/yFivWDRT3OGM7UEct3X8ioQvaAINeId82IWCrfQlyf8nEKmSv53Mi5swUogek9RCGCixReaQFbLmQ/f4RUG2xjeho8wwI6FEIYMiKjD8VsEwisM9QTEN3hYhSDMpk7843V6qO/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931290; c=relaxed/simple;
	bh=zsVAQYohKLsk3CpzCDHomDfvo2cGUL3Pm93kc9liwFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QBMaTTwEteq95drqsDuOwkwzzeKwT+4MHKRbTgqSFp1t9FCE89BUSWnk/qbyrcwB7nnucmpYuaO1J0smSPo1DJlwoTCf62HKaVBo/xQy/mGUQ8KPcLu/GJR73QRlx3veDvSoExouBpj0uGnY3inVWiBvF/DLd6hXgYokxpGnidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSJaG81U; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSJaG81U"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a149bfb2a8so556054eaf.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931288; x=1783536088; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apSMst9DB14zD5+2ABKg/MeqMrLAEvfuLdfp3VOuDI4=;
        b=oSJaG81UiFt58Nj7hz2ShvE6Muet7Ej0FkGHNTNxqIv7xTazTR+34spIm1rR6f3FgQ
         7aMaCWR/dt6hHNpXSf8pelsz9m87kZUc9a9Hl0zI5lzTH7dLvbbkfI+SeKn7PZAcdMs3
         ZXC4sGbkyhZZhb4pJR5W864OyPP9k8viSL3VHuJ07wiEYGXFhdJOOsSQHvbxI/BVQind
         NOt5GKCfZwQwEuNzF0LBzEwqb4eECfbrIOtzFZH+IVhOStAJLlgPpk6uBwk0BM92X2yj
         nPCBEyxttdjKLQ+pSQPzJHH5lz4pDv/EnQMPgmMjnz5tvcDUGnXtPedVlSmmh3kugUMl
         bKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931288; x=1783536088;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apSMst9DB14zD5+2ABKg/MeqMrLAEvfuLdfp3VOuDI4=;
        b=jocyQYJQ7jBB4fPWhRaGaJi7grFeCAJIfwfn97iWU0Tqxrdsa+tKGJDYW9yNSwpvcy
         EeV4O2pXq0JTRJKu6G3/ywSqH/Pz65TBKqvJJDpOYVTCmRMak5y0QQ8h8w+lPl6IdTPK
         uqbNwNhDdDDcMtQklPEXdywHah8EB5WTX/P3TK3ajWXl9KxowdCyLGF+r2vbBCk17RQl
         tISQ59jSA4rylDma0CfNjFvqP8VtWJ9aySZS/H86iMtoKI/itgHZM9ocfcwndgIiVcmB
         ZxWXVk36XlJal6nNx/gesMNVuYrMVt5wtJ6Nk4aEdACG9xHjZtlvoY0cywvct+o+hVLJ
         qwJw==
X-Forwarded-Encrypted: i=1; AFNElJ/YLLqYYi+BJAhEvVn3ZStbY39MZVr3vIM0mNNnTD965Zf7f6DtyV/6SgAVQ14ANFgW490=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeh7c9xFjEfshnt5UcUs6sQ6zYbvlKmYaAcBU1O40YtSZZJanH
	IfuJhWK6WExRd9VNsjJFalYlEy4ZmyQ5+1gT1IdHI164BDvwYoW5R2eO
X-Gm-Gg: AfdE7cleeCMWFT3og3/A9iKhH3L3nzIffpH2XXezOBqs6WdtzYIbaEkl4AxziEG5y6k
	EnKUVlS8Zdj02fragmCWIosj3eJPX0ivYDRRogdbC6Je1HsGP3G+CYEYn6k069QqBPB0rtJBcto
	mWMVQA65zqjJy8ADr/IId8KCYv+r3Xynr5WHFJUHKVaSQnZnvNUVkNMcgPqF8UaiS3o+ydYtes0
	S7Mqg2pf0HmmscaHq0o8kj07/HveOnJB1OBEA3Hw//VjJ6nYOFVXF32fm8oChicXGcoQaavmrES
	UyzUuan30B/hereat34esrSax0Gs99v7xEg89jdylSzMzNTIpZjq6AX0cJCAUI1qRHNlG32zuUk
	TMk5Vca2gwlhtAdtNDryxALwcSQ+DgYtdS9Hp3nJOfSccoo7ylNwt8/HnkSms+kzzpwGa4thxBO
	8KKsjHigSlXYaZJmf9xESzATR9C40t8OI0SG+a0kYwj8kOJ2iBL0RKsN1YtFcQUvYfLfVl/NRGC
	ddngI4=
X-Received: by 2002:a05:6820:1f07:b0:6a0:f0a1:568a with SMTP id 006d021491bc7-6a309ae6e59mr1595301eaf.43.1782931287563;
        Wed, 01 Jul 2026 11:41:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe8d9a7asm483692fac.6.2026.07.01.11.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 11:41:26 -0700
Message-Id: <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
In-Reply-To: <178291354144.1566898.14374948740441958770.stgit@devnote2>

On Wed Jul 1, 2026 at 6:45 AM PDT, Masami Hiramatsu (Google) wrote:
> +static bool trace_probe_can_compile_bpf(struct trace_probe *tp)
> +{
> +	int i;
> +
> +	if (tp->nr_args =3D=3D 0)
> +		return false;
> +
> +	for (i =3D 0; i < tp->nr_args; i++) {
> +		struct probe_arg *parg =3D &tp->args[i];
> +		struct fetch_insn *code =3D parg->code;
> +
> +		while (code->op !=3D FETCH_OP_END) {
> +			switch (code->op) {
> +			case FETCH_OP_REG:
> +			case FETCH_OP_IMM:
> +			case FETCH_OP_DEREF:
> +			case FETCH_OP_ST_RAW:
> +			case FETCH_OP_ST_MEM:
> +				break;
> +			case FETCH_OP_ARG:
> +				if (regs_get_kernel_argument_offset(code->param) < 0)
> +					return false;
> +				break;
> +			default:
> +				return false;
> +			}
> +			code++;
> +		}
> +	}
> +	return true;
> +}
> +
> +static void trace_probe_compile_bpf(struct trace_probe *tp)
> +{
> +	struct bpf_insn *insns;
> +	int i =3D 0;
> +	struct bpf_prog *prog;
> +	int err, idx;
> +
> +	if (!trace_probe_can_compile_bpf(tp))
> +		return;
> +
> +	insns =3D kmalloc_array(512, sizeof(struct bpf_insn), GFP_KERNEL);
> +	if (!insns)
> +		return;
> +
> +	/* Prologue: R6 =3D ctx */
> +	insns[i++] =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +	/* R7 =3D ctx->rec */
> +	insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6,
> +				 offsetof(struct fetch_bpf_ctx, rec));
> +	/* R8 =3D ctx->data */
> +	insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_6,
> +				 offsetof(struct fetch_bpf_ctx, data));
> +	/* R9 =3D total size (0) */
> +	insns[i++] =3D BPF_MOV64_IMM(BPF_REG_9, 0);
> +
> +	for (idx =3D 0; idx < tp->nr_args; idx++) {
> +		struct probe_arg *parg =3D &tp->args[idx];
> +		struct fetch_insn *code =3D parg->code;
> +
> +		while (code->op !=3D FETCH_OP_END && i < 500) {
> +			switch (code->op) {
> +			case FETCH_OP_REG:
> +				/* R0 =3D *(unsigned long *)(R7 + code->param) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, code->param=
);
> +				break;
> +			case FETCH_OP_ARG: {
> +				int offset =3D regs_get_kernel_argument_offset(code->param);
> +				/* R0 =3D *(unsigned long *)(R7 + offset) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, offset);
> +				break;
> +			}
> +			case FETCH_OP_IMM:
> +				insns[i++] =3D BPF_LD_IMM64(BPF_REG_0, code->immediate);
> +				break;
> +			case FETCH_OP_DEREF:
> +				/* Add offset: R3 =3D R0 + code->offset (src) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
> +				if (code->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
> +								   code->offset);
> +				/* R1 =3D dst (R10 - 8 on stack) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
> +				insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8);
> +				/* R3 =3D size */
> +				insns[i++] =3D BPF_MOV64_IMM(BPF_REG_3, sizeof(unsigned long));
> +				/* Call copy_from_kernel_nofault(dst, src, size) */
> +				insns[i++] =3D BPF_EMIT_CALL(copy_from_kernel_nofault);
> +				/* if (R0 < 0) return R0; */
> +				insns[i++] =3D BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
> +				insns[i++] =3D BPF_EXIT_INSN();
> +				/* R0 =3D *(unsigned long *)(R10 - 8) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8);
> +				break;
> +			case FETCH_OP_ST_RAW:
> +				/* Store R0 into R8 (data) + parg->offset based on size */
> +				switch (code->size) {
> +				case 1:
> +					insns[i++] =3D BPF_STX_MEM(BPF_B, BPF_REG_8, BPF_REG_0,
> +								 parg->offset);
> +					break;
> +				case 2:
> +					insns[i++] =3D BPF_STX_MEM(BPF_H, BPF_REG_8, BPF_REG_0,
> +								 parg->offset);
> +					break;
> +				case 4:
> +					insns[i++] =3D BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_0,
> +								 parg->offset);
> +					break;
> +				case 8:
> +					insns[i++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_8, BPF_REG_0,
> +								  parg->offset);
> +					break;
> +				}
> +				break;
> +			case FETCH_OP_ST_MEM:
> +				/* Add offset: R2 =3D R0 + code->offset (src) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
> +				if (code->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
> +								   code->offset);
> +				/* R1 =3D dst (R8 + parg->offset) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
> +				if (parg->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_1,
> +								   parg->offset);
> +				/* R3 =3D size */
> +				insns[i++] =3D BPF_MOV64_IMM(BPF_REG_3, code->size);
> +				/* Call copy_from_kernel_nofault(dst, src, size) */
> +				insns[i++] =3D BPF_EMIT_CALL(copy_from_kernel_nofault);
> +				/* if (R0 < 0) return R0; */
> +				insns[i++] =3D BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
> +				insns[i++] =3D BPF_EXIT_INSN();
> +				break;
> +			default:
> +				goto out;
> +			}
> +			code++;
> +		}
> +	}

Nack.
I really don't like it.
There were days in the past when the kernel generating bpf directly was app=
ealing.
These days are gone. Performance improvements for fetchargs is not a good r=
eason
to add all this complexity and bypass verifier checks.
bpf insns should come from user space.
