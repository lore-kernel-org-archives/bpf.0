Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2D3E9298
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083674; cv=none; b=Vb6JoHFzX2SVW8E5cqaLNxi0jiagiZqoSdWvqgNoMwxXd8A6Euhrjn4W/nZiSKvk1IZX0WbwMq1MucE5XnapFTPuAvP02svDWcKlHLdzVn2bIG/hPsQMvCO9LAP3sGHY1p/zNQNXen3e4ChjjmTwc9eE9j+HiZ6MtXWyOQhtb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083674; c=relaxed/simple;
	bh=DVDMDPjdqyX3oELaDLt5SJkowhZBzxqLNUOf1US1u6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uT3J/GyysIuwN6KecqGAMKXSmpYfJ6CDhDlD1pnmqu6iL0ZMTt3eeQBpXlRnmvr+g8r6UKkZn/1fgXgHhupuKutcKG/i+5NyHZXXY8u/XgG3sr2lQkpP8IXVnGBHc4Ri2y3ze2KmZFs5e32rVooAIbCEmr6/7Lh3AmVQfw6dudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHyWEW4a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHyWEW4a"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so2450965e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083667; x=1775688467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6J9/1kd1+qCRGXP35oAvQNykSoHLsvfNVlWdG5t92JE=;
        b=hHyWEW4ayg2fLRMMCHcZfS1Yy98jmcH3PC6fKWfYGcvOrcSZEUmLx30CroVyZ13ZZS
         nMz4J30ebMw/qHnLux0PThzKN4T7sxwIszwqOMSl0jtVJb6FwKYdIyk6MpRHPWCT6t/k
         Gd/ZF9SlDTUYRyJnHfEdXFfOVr38Z+i2T4FEybk2wiccOfKvq+bzjiImutZ1KR34L77t
         AunHE/Vo8462/hbp/DiUS1MFtHnKzdpxZqsqb1qaUzE46W4Uq9CIOb3sJyu9+wbMv2aJ
         iIG/q/nPztID1xT2vB9xEXDqpikFdIbzXeQ+3mS3KZ9NOHKOau9zbO4MuzUjEoaq5c6S
         vg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083667; x=1775688467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6J9/1kd1+qCRGXP35oAvQNykSoHLsvfNVlWdG5t92JE=;
        b=JG1Nm7VtDqDbpmiwBFvga3vUwFKhSSix3cmNUAuPAXtEU57IpB2LuuBrpZXvWvuwVJ
         vlx2jSlGnBzVHp/SlWxcWBEA8z7lIu2j25ybJJCSdO/lincKnuLN10Vcky38zOY9Ej3Q
         j4XrwnlKzxrNoHyogPf7q9TOHuYIxr3MbUvYWL8EJqcE5fWMNn2wMr4GAmHWnntZr8Hx
         mzqeEO/UQTjJ3bdPcnGPyqSOQXwDw2ORi61GerPpN9FK67OZJjJL8rwytKEv98dClMSN
         1PMrKPT5HO+aIxs5EX7fD2XObdAfqfbe4nqrOKTNATeqNKC7RsdJRoebuOVrIWtS4KEr
         7F5g==
X-Forwarded-Encrypted: i=1; AJvYcCWlI+0kUqav8vaBz0CSV7dDRMbZdCrO2/ylp0ixbc5pGgE9hBKNoNplFTuZfkdXwrK/oro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+ccRHikgdaCeLeEY45j2t9UBTaGO0bJfGe85/i+tLihsmdSa
	9HJhzlR36kNoOV3fgzWjAqn/6imVW0R/2k/tQsmRyiZOaqQ4EMLBvPyM
X-Gm-Gg: ATEYQzyQZ24QHlB3Fpdqu0NE5c5Vy86IS5fuWR+4aDNCKWr0bxsoiw5ohGH0Q6F6IjH
	AlZMtSWXELfnoaiF/P6FCHlncxsJe5plgvfGlBjotUuGmsWBYbjDZCxOnBcXaRbkBiF54haHnbi
	bIjC8S3U9rZTAdILKJlE4tW03FezQlz/cZcUn13gjEAJjy1UmMlHC0DEicl4oGQsb2iBIpGFiWn
	3+Nv4EvVwx3Wz5KYh56Rnd7OBHfU4Xn3VZxk2khzvO7EfT0CjuvGQ0PEwEqCr2w1KNwOv458hy1
	14Nixt4N+hxSg+oRbpWxGf6XbQvwll6H4jc9WKyafkmq4WtO+BP1CeUxojU9Zf0HxgrZ7EItdz/
	prkinI1aQkPA+YSlWZUcrsUBpyVUnbQ8/AQBJjmMBnrGkOoqCXAIC29p5zmwbklEr/D0UqDTpiP
	Id92pi1OJDWbRQV37Tw5pZsbMOklecLA4R5V5XGVqbuFUuHIY3S/wkUqKxCxv/qILnr4+sxoALx
	pyq4E73qmxtFSo9n+nSkQ==
X-Received: by 2002:a05:600c:1603:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-4888b6eab11mr11508665e9.6.1775083666447;
        Wed, 01 Apr 2026 15:47:46 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a705ebdsm31048275e9.10.2026.04.01.15.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 15:47:46 -0700 (PDT)
Message-ID: <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>
Date: Wed, 1 Apr 2026 23:47:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not ignore offsets for loads from
 insn_arrays
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-2-a.s.protopopov@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260401161529.681755-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/26 5:15 PM, Anton Protopopov wrote:
> When a pointer to PTR_TO_INSN is dereferenced it is possible to
> specify an offset inside the load instruction. This is a bug,
> because while the verifier ignores the field, JITs are not.
> So, patch the verifier to not ignore this field.
> 
> Reported-by: Jiyong Yang <ksur673@gmail.com>
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>   kernel/bpf/verifier.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..f1b1c8e9dc26 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -212,6 +212,8 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
>   static bool is_trusted_reg(const struct bpf_reg_state *reg);
>   static inline bool in_sleepable_context(struct bpf_verifier_env *env);
>   static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
> +static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
> +static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
>   
>   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>   {
> @@ -7735,6 +7737,20 @@ static bool get_func_retval_range(struct bpf_prog *prog,
>   	return false;
>   }
>   
> +static inline void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)

Why does it need to be manually inlined?
Other than that the change looks good, the implementation of the 
add_scalar_to_reg() is similar to a piece of code in sync_linked_regs().

> +{
> +	struct bpf_reg_state fake_reg;
> +
> +	fake_reg.type = SCALAR_VALUE;
> +	__mark_reg_known(&fake_reg, val);
> +
> +	scalar32_min_max_add(dst_reg, &fake_reg);
> +	scalar_min_max_add(dst_reg, &fake_reg);
> +	dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
> +
> +	reg_bounds_sync(dst_reg);
> +}
> +
>   /* check whether memory at (regno + off) is accessible for t = (read | write)
>    * if t==write, value_regno is a register which value is stored into memory
>    * if t==read, value_regno is a register which will receive the value from memory
> @@ -7816,6 +7832,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>   					return -EACCES;
>   				}
>   				copy_register_state(&regs[value_regno], reg);
> +				add_scalar_to_reg(&regs[value_regno], off);
>   				regs[value_regno].type = PTR_TO_INSN;
>   			} else {
>   				mark_reg_unknown(env, regs, value_regno);

