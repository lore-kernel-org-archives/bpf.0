Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B852DCBFC
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622505; cv=none; b=dPMLCuiIM1W+MkCd/OIHCsZAsR8MaOaH5KQhmKz6fJkJOMyGZJisQRxysdIYdL0a1QjTyvqBedbohLJI+vxfMFq9A9EK/ZEQORExBo1L6Xe2QxqqLDTfGRI/ssjA9zLmEMLOpKct1NOlxuFaN0PMdu8pDhn8ivMrMiFj77mhGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622505; c=relaxed/simple;
	bh=Gzsg/ZZeyeU1xJwheV9X7bfRRVPWWoY2AsqnR9I2BQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M72KPXJeFbizlNU7aKmSJVYcvVsVYl21+7fhXeun/50x6CJc4jZh0L992rnIQ64irPzt/++uHuDG3235ePM3uUh+l6GpU6GkFUcTCtPVeBIiBXA3P2QtKM2gHHVOIngtpRc2ECQCBBTGE17/VsfW7Z2tVGj7J2n+lNMSmm1wxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVdeKL+j; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVdeKL+j"
Message-ID: <f6c12a4b-8ffb-4f13-933a-7fa550e94d49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776622500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPb6itQ56oRth8qF6szy1TEpddGT80+8w2xj5zu0Yeo=;
	b=NVdeKL+j6LcGKFGzZS/t9RQfxiLwkFvuuKoKWstVsjf1sgvSjKd1r4EtSwmJb4cVV790/j
	nGatl61/yU8c2wkx/N2b3EYCxHm55/JqetIQ4I/0EhnGywDlfn1x4VzmWxBpBpS/oaopeU
	2vPIf/tR4+GLuGSrFNZ2vm+VXhmCEKc=
Date: Sun, 19 Apr 2026 11:14:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 05/17] bpf: Introduce bpf register
 BPF_REG_PARAMS
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163342.733840-1-yonghong.song@linux.dev>
 <20260419170630.D877EC2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419170630.D877EC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 10:06 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Critical] Unvalidated BPF_REG_PARAMS instructions cause silent register aliasing and arbitrary kernel memory corruption on architectures lacking stack argument support.
> --
>
> commit 9b78142c31c81cff58a84123ee2833f9b935c211
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Introduce bpf register BPF_REG_PARAMS
>
> This commit introduces BPF_REG_PARAMS as a dedicated BPF register for stack
> argument accesses, occupying BPF register number 11 (R11). It shifts the
> kernel-internal hidden register BPF_REG_AX to slot 12.
>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 1ec6d5ba64cc4..b77d0b06db6eb 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -58,8 +58,9 @@ struct ctl_table_header;
>>   #define BPF_REG_H	BPF_REG_9	/* hlen, callee-saved */
>>   
>>   /* Kernel hidden auxiliary/helper register. */
>> -#define BPF_REG_AX		MAX_BPF_REG
>> -#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
>> +#define BPF_REG_PARAMS		MAX_BPF_REG
> Does the introduction of BPF_REG_PARAMS without JIT-support validation allow
> architectures lacking stack argument support (like ARM64, RISC-V, s390x) to
> inadvertently use uninitialized JIT register mappings?

See patch 'bpf: Enable r11 based insns'. r11 based insns will be
rejected earlier in check_and_resolve_insns(). And before this patch,
bpf function support is done, jit support is disabled,
so we are fine.

>
> If the verifier doesn't gate BPF_REG_PARAMS usage behind a check like
> bpf_jit_supports_stack_args(), could a crafted program trigger silent
> register aliasing?

This is not an issue. All potential r11 related issues are resolved
(as far as I know) before "bpf: Enable r11 based insns".

>
> For example, if a program sets BPF_REG_1 to an arbitrary kernel address and
> executes BPF_STX_MEM(BPF_DW, BPF_REG_PARAMS, BPF_REG_2, -8), the verifier may
> allow it as a safe outgoing stack argument write. When the ARM64 JIT compiles
> the instruction, it looks up index 11. If that index is uninitialized and
> defaults to 0, it would emit a store using x0 (which is BPF_REG_1) as the
> base pointer (e.g., STR x1, [x0, #-8]).
>
> Could this write an arbitrary value into a controlled kernel address and
> bypass verifier memory safety guarantees?
>
>> +#define BPF_REG_AX		(MAX_BPF_REG + 1)
>> +#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
>>   #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG

