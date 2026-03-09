Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21B36E493
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092550; cv=none; b=E6pFiuid27TrFR+e+SPF6eY4K8ltj8iyc7NTUHsQNkR0S0B+3nYp6Entk2OT+64HjY39kvfut2LjM9qi5Nlh49XygMb7mxnfvu1vuLha78jM0IkxHK8kn8rlyWjPkfZ85c90sf/HaXBbdEsVhTAZmUEi7/PRpl0dQAAPNfA47YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092550; c=relaxed/simple;
	bh=NH7j5X8yTssTZKnWQcD0d+z+AvdmFJ5BNZPni+Fl44Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3XpvoGitcjErdaUM7R/CY9mSqNp7xkc31FtcvacS3t5bkTfmYc8mJLfLvLZVQ+yqQorb42nM/CynenTOZVjkgY4gUUws/qVWiZJbAJPLpKmPZxqbyp5icYfOxtlQPnavZse/fjUtDhT0qKqPZGiLHIzgZAhAL2UtINEzPUQ/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W5SvX0uw; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W5SvX0uw"
Message-ID: <35a5e0fa-1d55-4df6-8a8d-c79264f57b91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773092546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE09geYYoKnEhEHHSgA54I379Ighqrd7OMPFbUK0UVo=;
	b=W5SvX0uwZm9YG39BOZE07H1swBGwbD3367UC5XNrFvYJ7aPuANAYEOMK4JQsJALS/Y9MA5
	qWeklWL1goErlN+GVSWOjgAkwTDLdyMwPsq2Xn7uTIp+L58+JJQ7ILOy8OYgFK0RRLF4kJ
	5q6l/f/deTvJpxwmKdev1EuuRv1x24A=
Date: Mon, 9 Mar 2026 14:42:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add tests for sdiv32/smod32 with
 INT_MIN dividend
Content-Language: en-GB
To: Jenny Guanni Qu <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 mykyta.yatsenko5@gmail.com, lkp@intel.com
References: <20260309185716.717894-1-qguanni@gmail.com>
 <20260309185716.717894-3-qguanni@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260309185716.717894-3-qguanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/9/26 11:57 AM, Jenny Guanni Qu wrote:
> Add tests to verify that signed 32-bit division and modulo operations
> produce correct results when the dividend is INT_MIN (0x80000000).
>
> These test the fix in the previous commit which replaced abs() with a
> safe helper to avoid undefined behavior for S32_MIN.
>
> Test cases:
>    - SDIV32 INT_MIN / 2 = -1073741824 (imm and reg divisor)
>    - SMOD32 INT_MIN % 2 = 0 (positive and negative divisor)

The tests you added below will always succeed with CI without your
previous patch. The reason is the default config is to enable jit
where the verifier already handles potential overflow properly.

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

If you have sysctl bpf_jit_enable=0, the above two tests
will show failure without your previous patch. With your
previous patch, two tests will pass.

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

These two patches will succeed regardless of your
previous patch.

I suggest you to have more detailed explanation in
commit message for the above tests, e.g., how
bpf_jit_enable = 0 can tigger the failure without
kernel change, etc.

> +
> +
>   #else
>   
>   SEC("socket")

