Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727371B86C7
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102513; cv=none; b=SVLGjxANI8RuPH+CMFyPiV5wjnhb34cLc3lBs0TsfEYOWyqApl4dlouBTj3/e1IhCcXHiwSyXe9vPYIevJhzpG4lHGAA1fWXmp/mqTPsbeIuISEqsvOrSoqPN6cEsaIa5IogDWkd/VDgvXMp5k4r9t0dOFooAJOZYW457mD7sZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102513; c=relaxed/simple;
	bh=FrbjrbGwOQmdQBLUL7zSL29RQqYpVQw9+noBboSs8Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgR1PS0g26v5mU8vKKfHdQBFLSQS+7sSzUhvjarXVcSlx/dADaAf1kWrBLlFc0gRf69/IqIC3mmXlvF0aRmoZQswTiAvg58V4kqb7FS27Vfb14oA5T9iHhbT9hyxQDT35S5fNWND5MFmdsaPWX17qOuZpaockddVk0fT9gocXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKUdKeTu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKUdKeTu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so12929195e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102511; x=1773707311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X64+rmK85z+uuIciWva23EMgmt7oaw1E9I/TW4/mS6M=;
        b=AKUdKeTuJqzDD1HhtyZoJxQC6dIQ7dq9kPWvpuw/v4oNNxF2Z6J5o5RCSbV4piO4QO
         6dUxrK0pjRFeJathFOkWn8zuR9021yxw4c0YsG3mnI5xTu+J9xIYZgjeHNdXffu5qCrS
         gUgRB93BuJDUzKIAhlggpPAMpA/dtUCBAGrFNFv8tWGUvIrCIcpaC2VQ2ex00QUSykBs
         lj39YgREuFWNZq79y4wdFItQIb0o+mjCooeeHRc5DsLQnMxWDKQRmesmkUuys/9WR3z+
         MZb8KWvBtiD0P/8fZZ4bPRZepAZGNBPBbfk/ojn47x1uBy1P7VrRJ6O6k+6Dn0ilujLf
         OMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102511; x=1773707311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X64+rmK85z+uuIciWva23EMgmt7oaw1E9I/TW4/mS6M=;
        b=rEyzMYYG+e6OFrU1SH9e1HsSpWo5BIxGELs3sOIjrf/FPgETOyxpHcJeChB12aKyu9
         g/X7t5So0yVpD33AoNuJNQpAG0JlSQKqtyhdlmCSG/7tQnLyx6+dkht1LK00EtgOTN9q
         HiQfQ9ImITpdNs+HlFRQMHPJb76UGcFeFzYNrHPv4qmH9PZhgqtkxrdh9EzeSzm5sDgp
         PDShw0T3QfpMSi4ZiWJKq/tuVj9FdL8KxNM5X4ry+DQ9NOfDPQiYXWowCNrjFO629b4x
         gvqaLiVNQpnkZ0Fgk4af0RSKVwoK6bbubiQuefJMUac0bAKVnITg8//lpPHsPhA761QO
         4fmw==
X-Forwarded-Encrypted: i=1; AJvYcCUMjX0P2/FMT9Qk+hisp9KDKpQ0gU9DCyjGGi5XN83CBiET6yVFwDKkjzwvCC8sKGCSL88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGTgRFgfGYH1meh6kcM3bDTEWp5fHDcbYCJggy+RdCYhY7x32
	7TS7Jll59QIFNzgCSh+BZNt4L+jKaTemVEw1Fu5fWiyeIEbSAQtNHLYO
X-Gm-Gg: ATEYQzypllneVSb7/iMxdD81BO4RUV9MWSlwVuxcWS4ibUceH6Ttkjkchu2iWEN5HuK
	BFAr/e/Cbe85YNkyrZJI22fiKL1EGygrRyN80H1QZ/BTRPIz6PLoRN+6dkqA9VKWts5I9ISG+Dm
	54zckrcSso1jKeYzbUqKoFx2VN1zDbaPBVr3KhVwp74Af3mieI/25SfCrqvFapFKg+LGdfjkdr0
	Og8Qd2TZdB0vRihbFNs4wflfA7chfU/SWTiL6RYmGnC0dgGFQA/flc3RSos5EjNTutC7lS57UKT
	5bCTnhaFNAfoDbyEH0h9mHD4fStsJPTceYSjC9ETgc+JtjQocru2r6IXEoorkjlx+xBggI6MuXb
	rwdoqlHCIIqQM9f05+klxzjUhIH6ESZOr9Hfn18zTizyH/bqw9xExgmNBHYfcNxzaPFUGWn0sWL
	hig02uXtWzHBKIJr9R2LThKyVSn3YR9niZp6XRKBfHsseOPlGkV/9BBI/Nq1L3ra3fpS+SZoGlK
	Q8tHQMfp0eDTLw=
X-Received: by 2002:a05:600c:4446:b0:485:34b3:8589 with SMTP id 5b1f17b1804b1-48534b3882emr128741695e9.31.1773102510810;
        Mon, 09 Mar 2026 17:28:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485245dbe50sm102000415e9.17.2026.03.09.17.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:28:30 -0700 (PDT)
Message-ID: <86335845-ee95-4d7c-8208-f2bdd9cde90d@gmail.com>
Date: Tue, 10 Mar 2026 00:28:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] bpf: Fix undefined behavior in interpreter
 sdiv/smod for INT_MIN
To: Jenny Guanni Qu <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 yonghong.song@linux.dev, lkp@intel.com
References: <20260309215910.4131143-1-qguanni@gmail.com>
 <20260309215910.4131143-2-qguanni@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260309215910.4131143-2-qguanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 9:59 PM, Jenny Guanni Qu wrote:
> The BPF interpreter's signed 32-bit division and modulo handlers use
> the kernel abs() macro on s32 operands. The abs() macro documentation
> (include/linux/math.h) explicitly states the result is undefined when
> the input is the type minimum. When DST contains S32_MIN (0x80000000),
> abs((s32)DST) triggers undefined behavior and returns S32_MIN unchanged
> on arm64/x86. This value is then sign-extended to u64 as
> 0xFFFFFFFF80000000, causing do_div() to compute the wrong result.
> 
> The verifier's abstract interpretation (scalar32_min_max_sdiv) computes
> the mathematically correct result for range tracking, creating a
> verifier/interpreter mismatch that can be exploited for out-of-bounds
> map value access.
> 
> Introduce __safe_abs32() which handles S32_MIN correctly by casting
> to u32 before negating, avoiding signed overflow entirely. Replace
> all 8 abs((s32)...) call sites in the interpreter's sdiv32/smod32
> handlers.
> 
> Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>   kernel/bpf/core.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55625..a620d4d6f567 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1736,6 +1736,12 @@ bool bpf_opcode_in_insntable(u8 code)
>   }
>   
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> +/* Safe absolute value for s32 to prevent undefined behavior for abs(S32_MIN) */
> +static inline u32 __safe_abs32(s32 x)
> +{
> +	return x >= 0 ? (u32)x : -(u32)x;
> +}
> +
>   /**
>    *	___bpf_prog_run - run eBPF program on a given context
>    *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -1900,8 +1906,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   			DST = do_div(AX, (u32) SRC);
>   			break;
>   		case 1:
> -			AX = abs((s32)DST);
> -			AX = do_div(AX, abs((s32)SRC));
> +			AX = __safe_abs32((s32)DST);
> +			AX = do_div(AX, __safe_abs32((s32)SRC));
>   			if ((s32)DST < 0)
>   				DST = (u32)-AX;
>   			else
> @@ -1928,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   			DST = do_div(AX, (u32) IMM);
>   			break;
>   		case 1:
> -			AX = abs((s32)DST);
> -			AX = do_div(AX, abs((s32)IMM));
> +			AX = __safe_abs32((s32)DST);
> +			AX = do_div(AX, __safe_abs32((s32)IMM));
>   			if ((s32)DST < 0)
>   				DST = (u32)-AX;
>   			else
> @@ -1955,8 +1961,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   			DST = (u32) AX;
>   			break;
>   		case 1:
> -			AX = abs((s32)DST);
> -			do_div(AX, abs((s32)SRC));
> +			AX = __safe_abs32((s32)DST);
> +			do_div(AX, __safe_abs32((s32)SRC));
>   			if (((s32)DST < 0) == ((s32)SRC < 0))
>   				DST = (u32)AX;
>   			else
> @@ -1982,8 +1988,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   			DST = (u32) AX;
>   			break;
>   		case 1:
> -			AX = abs((s32)DST);
> -			do_div(AX, abs((s32)IMM));
> +			AX = __safe_abs32((s32)DST);
> +			do_div(AX, __safe_abs32((s32)IMM));
>   			if (((s32)DST < 0) == ((s32)IMM < 0))
>   				DST = (u32)AX;
>   			else

