Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3740683F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698478; cv=none; b=Ik7RIs4G4STSaeM4rDAjd+cUYtAZhmyBr1HLkPE9dlE8ayNllLlt0zgLIEi3FgijnF80+i1cPo1TH5uZx8LTna3GZmiLypKblWNEl4JpCbAkUyJ5XXZ9SW6Q9yKKlpahrNWAXppODQMIPRgY5ciF1K/3N0MF4k9boY9aLM+mOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698478; c=relaxed/simple;
	bh=nNux1bMSPp6XIkRPtWvISRfL96ZEfzXBqh+qf0tckHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/sOWFw7hr+00wEDsVkidJQWEdpBQrtiyDny0VcuvXqXX9L1Y+6VBQMBnb+s1lBsTSal3C9aXSbAH7MpS5kGVXwB3IFIVCldp24YN9g+K612jV7SMJ+nQCliAtc8hT4YEtTirfgxtKc/pnJkYFTnM+aGI991iuU4VVMDN6dlaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oe58Px2c; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oe58Px2c"
Message-ID: <a08eb4ac-30de-4ddb-a65a-6d2d09883b58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783698474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFwEH1honMHuy7pdIFXk9whXlgSikldypq56wIU51w0=;
	b=oe58Px2cakJBLltvkSEAyL1f//lhjD9nIJ2vMSu880AlFuGy6+AOcnIuMmXkfXRIRO6vjg
	H4eyIqqul+ODruG5QOFwPeXEFvPdI06jAXF/XAgVA5u23jIgscDxo2Zp7rFQDvENpYTVYv
	Mo3cloWmz+3E0O7l0Vu2CXymOK7G2X0=
Date: Fri, 10 Jul 2026 08:47:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, leon.hwang@linux.dev,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
 <a45c78cf3167aa868b8a50fae2a4979c09f21890212e2013e05303b1fff30add@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a45c78cf3167aa868b8a50fae2a4979c09f21890212e2013e05303b1fff30add@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 8:45 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 51b16e5f5534..bbb44ef8f87a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -445,6 +445,18 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>   		goto errout;
>>   	}
>>
>> +	/*
>> +	 * A >8 byte return value is passed back in the R0:R2 register
>                                                                    ^^^^
>
> Does this comment have the correct register pair? Looking at the commit
> message, it states the second half of the return value is "RDX / R3", and
> in arch/x86/net/bpf_jit_comp.c reg2hex[] shows BPF_REG_0 = RAX and
> BPF_REG_3 = RDX, while BPF_REG_2 = RSI (an argument register).
>
> Should this be R0:R3 instead of R0:R2 to match the x86-64 ABI return pair?

It should be R0:R3. My commit message is correct, but I forgot to update
the comments. Will fix the comment.

>
>> +	 * pair, which the struct_ops trampoline does not preserve (only
>> +	 * 8 bytes of the return value are saved and restored).
>> +	 */
>> +	if (st_ops->func_models[i].ret_size > 8) {
>> +		pr_warn("func ptr %s in struct %s has a >8 byte return value, which is not supported\n",
>> +			mname, st_ops->name);
>> +		err = -EOPNOTSUPP;
>> +		goto errout;
>> +	}
>> +
>>   	stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
>>   	err = prepare_arg_info(btf, st_ops->name, mname,
>>   			       func_proto, stub_func_addr,
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29101893933

