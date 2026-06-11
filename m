Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B13C2790
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163442; cv=none; b=Xbw9laE5p+Q7WyUuaROoMQpJvWkEl6lfqUAMpW6vtslaxQ8HUPm7ElqlUcctC2aFET7ZNfW8UwF43uPq01sa3C9RfoZSYzcgVlgKA1b4grgzv1cb9R70feGwpEM3ogKNfNUTOPqnJWV0yrJW5l41U3fEm3B/ZyAJOvAInOYtfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163442; c=relaxed/simple;
	bh=MgHFCXy6A3xWgQUTSSoFnW6vGwdkNBuc4SoTY6BtnAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI8WhFX2xssVrWzLRQHQeKB+zukkd6fSwJ/1OL1nal49GS8MPugqVt+B7O5HqgVns9icKqOPK3P+3a+WNmgUsKOvCeUdUJatr/MkJxNDKTM6ZmO3XDyoyGz2RxhjUMUDOhdq8FzMpUjVAdFWc9NuVYfQRONv42jp/m4t1G0x+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=auxILY3F; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="auxILY3F"
Message-ID: <aaca5c93-3b03-4fa2-9653-87c396e5ec7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781163438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNP8JXKA8AkKhIZtglVrzRnHIcLo0UCoLJIZQ5p/uvk=;
	b=auxILY3FCsDS2qS8t3iYur1lab/11/0JiCpAiGPDvean3uxzE8Q0oRIyslgnXWCUitFdre
	arvBHf+9tV2p4ZSgV1O8AH+hZsu7e/F9KIU3IO+yKJONgBb/tiW1GXj/pTWKjCJ0xDjCBi
	ih5u6slsFBTf1+tcW62b2V0ySfKSy2c=
Date: Thu, 11 Jun 2026 15:37:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] bpf: Fix unaligned interpreter panic on JIT
 fallback path
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611070009.26257-1-yangtiezhu@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260611070009.26257-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/6/26 15:00, Tiezhu Yang wrote:
[...]
>  
> +/*
> + * Rewrite the helper call offset for inlined helpers when fallback to
> + * the interpreter happens due to JIT compilation failure or JIT disabled.
> + */
> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
> +{
> +	struct bpf_insn *insn = fp->insnsi;
> +	const struct bpf_func_proto *fn;
> +	int i;
> +
> +	if (!env || !env->ops->get_func_proto)
> +		return;
> +
> +	for (i = 0; i < fp->len; i++, insn++) {
> +		if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0) {
> +			if (bpf_jit_inlines_helper_call(insn->imm)) {
> +				fn = env->ops->get_func_proto(insn->imm, fp);
> +				if (fn && fn->func)
> +					insn->imm = fn->func - __bpf_call_base;

Might have pointer-to-integer warning?

> +			}
> +		}
> +	}
> +}
> +
>  struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
>  					   int *err)
>  {
> @@ -2639,6 +2663,15 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>  
>  		fp = bpf_prog_jit_compile(env, fp);
>  		bpf_prog_jit_attempt_done(fp);
> +
> +		/*
> +		 * If JIT compilation failed or is disabled (!fp->jited), we are
> +		 * about to fall back to the interpreter path. Fix up the call
> +		 * offsets to prevent unaligned memory access panic.
> +		 */
> +		if (!fp->jited)
> +			bpf_fixup_fallback_inline_helpers(env, fp);
> +

Better to move it after (!fp->jited && jit_needed)?

Thanks,
Leon

>  		if (!fp->jited && jit_needed) {
>  			*err = -ENOTSUPP;
>  			return fp;

