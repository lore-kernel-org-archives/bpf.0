Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B12EC0B2
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108318; cv=none; b=o/7bo7LVLiPHlHndSjz4WsIRx2ZEF/xAzufkN3VY/590E4dgFkXqu4nsrJIjZUODADTgD7C9g5LHPy58/OtgAjZ/FoCxIaVZeZH7mjl1YOTYk/QxqqWG/rVS/I8YwHFxaJN6oy3MPJk7Qd3UlwkJzJ4Q7zyg0x/25Cl1kWNBtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108318; c=relaxed/simple;
	bh=F4N2nQ0Pb6QyL/SX20jNAYWQcUWv6ZIscg4pl4ar17Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfPMdHhQ0jLg1ZjKnt1DJJ5NJHn8Tk2rOSLk6dGMNyvSYWZOSjBAgy+Pgnde6aXlpH6AADM+f0b5eD2RNWN3xg+Co8poKeptMP7lbEIkeIFSTOk17cDYEV8NmUmE4G+jiTPOkwY+F7ffr2iuZUrEiELn0w59np/A1l0KCDv0JQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oK/EC6+y; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oK/EC6+y"
Message-ID: <9a212cc9-46cf-4c0a-a5a6-98544f46465b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773108315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRlh5RjJuYVGai9f3GjW8BpNiqmsxx4jaE6EdUTZpWM=;
	b=oK/EC6+yXXipqFpYwFdPARfLXG7OkH2671RH0/JpiZhQLaRS4nZiPf81WkWxqXkMzJQDea
	nhPKyI8AZuk1qpqfxm6GoAGrQSvMa60SGyqzHCIVuXPW/d1HQxnpzwehlAu/+tZVs0CzmO
	CfVLqK0Y8+xx484poCIj9NFJmXPeezg=
Date: Tue, 10 Mar 2026 10:05:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add tests for sdiv32/smod32 with
 INT_MIN dividend
To: Jenny Guanni Qu <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 mykyta.yatsenko5@gmail.com, yonghong.song@linux.dev, lkp@intel.com
References: <20260309215910.4131143-1-qguanni@gmail.com>
 <20260309215910.4131143-3-qguanni@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260309215910.4131143-3-qguanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/10/26 5:59 AM, Jenny Guanni Qu wrote:
> Add tests to verify that signed 32-bit division and modulo operations
> produce correct results when the dividend is INT_MIN (0x80000000).
>
> The bug fixed in the previous commit only affects the BPF interpreter
> path. When JIT is enabled (the default on most architectures), the
> native CPU division instruction produces the correct result and these
> tests pass regardless. With bpf_jit_enable=0, the interpreter is used
> and without the previous fix, INT_MIN / 2 incorrectly returns
> 0x40000000 instead of 0xC0000000 due to abs(S32_MIN) undefined
> behavior, causing these tests to fail.
>
> Test cases:
>    - SDIV32 INT_MIN / 2 = -1073741824 (imm and reg divisor)
>    - SMOD32 INT_MIN % 2 = 0 (positive and negative divisor)
>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>   .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
>   1 file changed, 58 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> index 148d2299e5b4..fd59d57e8e37 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> @@ -1209,6 +1209,64 @@ __naked void smod32_ri_divisor_neg_1(void)
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("SDIV32, INT_MIN divided by 2, imm")
> +__success __success_unpriv __retval(-1073741824)
> +__naked void sdiv32_int_min_div_2_imm(void)
> +{
> +	asm volatile ("					\
> +	w0 = %[int_min];				\
> +	w0 s/= 2;					\
> +	exit;						\
> +"	:
> +	: __imm_const(int_min, INT_MIN)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SDIV32, INT_MIN divided by 2, reg")
> +__success __success_unpriv __retval(-1073741824)
> +__naked void sdiv32_int_min_div_2_reg(void)
> +{
> +	asm volatile ("					\
> +	w0 = %[int_min];				\
> +	w1 = 2;						\
> +	w0 s/= w1;					\
> +	exit;						\
> +"	:
> +	: __imm_const(int_min, INT_MIN)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, INT_MIN modulo 2, imm")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_int_min_mod_2_imm(void)
> +{
> +	asm volatile ("					\
> +	w0 = %[int_min];				\
> +	w0 s%%= 2;					\
> +	exit;						\
> +"	:
> +	: __imm_const(int_min, INT_MIN)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("SMOD32, INT_MIN modulo -2, imm")
> +__success __success_unpriv __retval(0)
> +__naked void smod32_int_min_mod_neg2_imm(void)
> +{
> +	asm volatile ("					\
> +	w0 = %[int_min];				\
> +	w0 s%%= -2;					\
> +	exit;						\
> +"	:
> +	: __imm_const(int_min, INT_MIN)
> +	: __clobber_all);
> +}
> +
> +
>   #else
>   


Minor nits: extra blank line before #else, and smod32 tests only cover 
the imm
form — a reg variant (w0 s%%= w1) would make coverage symmetric with sdiv32.

Neither worth a respin.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

>   SEC("socket")
