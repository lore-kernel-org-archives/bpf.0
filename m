Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A51F03D7
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091825; cv=none; b=qY2mCrw66ZGsV+ouuatyXZS0iUGSg+DiL80dsMPVjswwJakB4GVYArQSyRNcaX9NYr2g+W34hCmeFGF2HwALnzE4UooLHXURTZQrVVXsZLBK/su+tQW6BcIk4jmYZwludHvt8iUBfHC87/q0McL52syN78dWD5EU0U7TbvQp5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091825; c=relaxed/simple;
	bh=6s0tY+Fgj1gsBq5K+90g9GbCiojVKS8+hwBf/wArtng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHD4TspKb9pdg+MPqF2pA57QNVD5um1M+NhrXj9gENRawr5Wg45t1Kuc2oBb4xQdHL49VcYgvhBzoKADNhgXwzFNx6aHmUw18NXd74grheiaaKcSsTXVBsG+KlKV/c/MHW3laMEPuZ7hTcT3EEj6cvUHm2Ii5vv9KrNUPjQnaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aaUKnYmm; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aaUKnYmm"
Message-ID: <ae8f2bcc-5ea2-4c3b-b250-7e562e5ebcdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773091821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd2kYaag2LGcF4sziW87KxnblCiC0T18UTjqH/Gn6vs=;
	b=aaUKnYmmqjJ0HAysoWCXLKFyGZZIal9qobI9EAcN/PAMeDIj6t/K7YBky9mjNYaxjNcIx7
	JTbwivqqvWCAZwd+LxO1IeRdyl0tycta4BtNQKZenVqto8SLVKUQa6PqW0GWs4bSanAhJF
	+5JlV2SDOUKF9LbrwTBKuVwH5Jkcz/g=
Date: Mon, 9 Mar 2026 14:30:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] bpf: Fix undefined behavior in interpreter
 sdiv/smod for INT_MIN
Content-Language: en-GB
To: Jenny Guanni Qu <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 mykyta.yatsenko5@gmail.com, lkp@intel.com
References: <20260309185716.717894-1-qguanni@gmail.com>
 <20260309185716.717894-2-qguanni@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260309185716.717894-2-qguanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/9/26 11:57 AM, Jenny Guanni Qu wrote:
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
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/core.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55625..0bee54db03c1 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -16,7 +16,6 @@
>    * Andi Kleen - Fix a few bad bugs and races.
>    * Kris Katterjohn - Added many additional checks in bpf_check_classic()
>    */
> -

You should not change the above line.

>   #include <uapi/linux/btf.h>
>   #include <crypto/sha1.h>
>   #include <linux/filter.h>
> @@ -1736,6 +1735,12 @@ bool bpf_opcode_in_insntable(u8 code)
>   }
>   
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> +/* Safe absolute value for s32 - abs() is undefined for S32_MIN */

Maybe
    /* Safe absolute value for s32 to prevent undefined behavior for abs(S32_MIN) */
?

> +static inline u32 __safe_abs32(s32 x)
> +{
> +	return x >= 0 ? (u32)x : -(u32)x;
> +}
> +
>   /**
>    *	___bpf_prog_run - run eBPF program on a given context
>    *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -1900,8 +1905,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
> @@ -1928,8 +1933,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
> @@ -1955,8 +1960,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
> @@ -1982,8 +1987,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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

