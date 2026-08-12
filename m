Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31071387364
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507554; cv=none; b=htPgMXAV0rwh8eIxjPLdRaW/M/3Hv4lAwdR0kpFwBcDMnsw/Odn6N3l919Od869YmGqtxx/JYzbz4SCIG2g+NBC9YuYeIYd7q6lx10XE8V3x/UXj0YTv4UZM442dmxtdvnbYN+i54+p8akX7wPjPe2IbW81dRhnqXzbumxAEufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507554; c=relaxed/simple;
	bh=MbTno0rjUBnAKDun7c0wJsP2yV2Zbrh1Zi32IOycOk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqgGUHyxVs/jNdSux+Y/9CBdq5BbLJAkrkpb2I0zua2FwflMbVvui5uo8H7w8ee/iYWrD7KZKXo/f1m59oTH4LYFgO3DWXTyFLTJ6YGAul0QEK7jskKOkvyevHYzcj8yj3YZOEwUC7QM0ae6szp1HvJJHZPqmDT0wsMm7WwaQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U9/xjNmq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U9/xjNmq"
Message-ID: <85f244d7-32d0-4d0a-bd44-a7972a09575d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cpa6GCJ3MHdYq7+owe5oXYxXlvZIq17J2FQtppIDN/8=;
	b=U9/xjNmq7LwD9T/Dp5IoAxSgQK/U9JFnt7q5rwNo2Mt2o0fUODqcjitio83VrlaPn58UO0
	p+Qqj0OTCvwWzAiRKxVKArfz7I3yn/YoEYwGl7MrAdNHaK+CV9r3pr/P0EZ+sVU4uPd6nO
	BHWGSJY5vHqC90V/CcL3iIG9VmZmOek=
Date: Wed, 12 Aug 2026 12:05:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/13] bpf: Add tracing_multi link info support
 for bpf progs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-8-leon.hwang@linux.dev>
 <20260809151726.269221F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260809151726.269221F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/8/26 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Out-of-bounds Read / Uninitialized Memory Leak in sym_name_trim_prefix()
> - [Medium] UAPI Anti-Pattern: Usage of C bitfields in UAPI headers
> --
> 
> --- Patch [7]: [PATCH bpf-next 07/13] bpf: Add tracing_multi link info support for bpf progs ---
> commit 65386c192a0d673092c95f3f31578ae7c4d19498
> Author: Leon Hwang <leon.hwang@linux.dev>
> Subject: bpf: Add tracing_multi link info support for bpf progs
> 
> This commit adds tracing_multi link info support for BPF programs. It
> updates the bpf_link_info structure and extends bpftool to show function
> BTF IDs and program IDs.
> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 6fa93a6ff54f2..e0c8ea5ed2c8f 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6890,10 +6890,12 @@ struct bpf_link_info {
>>  			__u32 attach_type;
>>  			__u32 count; /* in/out: tracing_multi target count */
>>  			__u32 btf_obj_id;
>> -			__u32 :32;
>> +			__u32 tgt_progs:1;
>> +			__u32 :31;
> 
> [Severity: Medium]
> Could this cause endianness issues since C bitfield layout is
> implementation-defined?
> 
> The established Linux UAPI standard is to use a __u32 flags field with
> bitmask macros instead of C bitfields to ensure portability across
> architectures and cross-platform tools. (This also applies to the mirrored
> header in tools/include/uapi/linux/bpf.h).
> 

Correct.

Will use the bit mask style by changing '__u32 :32' to '__u32 flags' and
adding BPF_F_TRACING_MULTI_TGT_PROGS.

> [ ... ]
> 
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index 088d1d206065f..d5c5ec433350b 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
> [ ... ]
>> +#define BPF_PROG_PREFIX		"bpf_prog_"
>> +#define BPF_PROG_PREFIX_LEN	(sizeof(BPF_PROG_PREFIX) - 1)
>> +
>> +static const char *
>> +sym_name_trim_prefix(struct kernel_sym *sym, bool is_prog)
>> +{
>> +	int prefix_len;
>> +
>> +	if (!is_prog)
>> +		return sym->name;
>> +
>> +	/* Ref kernel/bpf/core.c::bpf_prog_ksym_set_name() */
>> +	prefix_len  = BPF_PROG_PREFIX_LEN;
>> +	prefix_len += BPF_TAG_SIZE * 2;
>> +	prefix_len += 1;			/* skip the '_' */
>> +	return sym->name + prefix_len;
> 
> [Severity: Medium]
> Does this code read past the null terminator for unnamed BPF programs?
> 
> When processing an unnamed BPF program (e.g., exported in kallsyms as
> bpf_prog_9a7f9e3ab6f138ab), the sym->name buffer contains exactly 25
> characters. Here, prefix_len is calculated as 26 (9 + 16 + 1).
> 
> This offset advances the pointer past the null terminator into
> uninitialized heap memory, which is then passed to the JSON string writer
> when calling jsonw_string_field() later in show_tracing_multi_json().
> 

Correct.

According to bpf_prog_ksym_set_name(), will check "sym->name[prefix_len]
!= '\0'" before "+= 1".

Thanks,
Leon

