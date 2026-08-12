Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7172E7179
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507456; cv=none; b=EPWeLGe/PuMft334NJnVOgOL/CXvYqvilDa1wOjEOW6wCYXK36t0XSAT/Verd9j7gkLbgfPK3N9JsDVbacOrccIyKSsJRBVPbkFq57AY+MEtL4JshHMdo2f7qRFgqnTekza04xlKw16KGfwnzdmHaOE3mFZOrUctz99il1osOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507456; c=relaxed/simple;
	bh=5kkxNM5qypE6HfzkfDb1+Qmkm9+SsPscNYpGek1qcI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6lgzcds0XO/0SXO8f1OMWNnGNqpv3WAyRGek5pg/9NPH6Hh9D0OYACneAbnoUB8csMNUpl5ThI/xpMoei8dGl76oNtdkKkckpkCGzu56zL0IH/Yud/zmDmRr2mg4pYbz1h+n2fm+Wt3JjbKh0WVLnM7QfowzD+WjXbm2XK1qNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ek5GdMI7; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ek5GdMI7"
Message-ID: <3401f1de-e3ea-4d38-b6b0-2cab7d3daea1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6uqTdv+OKmenvrKcgaPryDc9yWvGZhXZDyoGutReQA=;
	b=ek5GdMI7ACfSGdzZnlnuAdxsVpQ2alNhKMl2tD1SM4OUdolSn0NYEI2Ye7aqptLXHDe+GZ
	vTQWwZE7NNGz5+kVR1U8/dBicJkxzM2wjNs9I7dtiY8q3rBa2mZiXILgcd/yxIRlkjvwJc
	9ybuiAwluxhYp4sz1CzK/ult3Eg70T4=
Date: Wed, 12 Aug 2026 12:03:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 05/13] libbpf: Add tracing_multi link support for
 bpf progs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-6-leon.hwang@linux.dev>
 <20260809152138.45FA81F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260809152138.45FA81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/8/26 23:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing input validation in `bpf_program__attach_tracing_multi` leads to a potential segmentation fault when a user-provided array element is NULL.
> --
> 
> --- Patch [5]: [PATCH bpf-next 05/13] libbpf: Add tracing_multi link support for bpf progs ---
> commit bef5c103ea1916738efc32c272265795c04de90a
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Add tracing_multi link support for bpf progs
> 
> This commit introduces tracing_multi link support for bpf programs in libbpf.
> It adds fds and funcs fields to bpf_tracing_multi_opts to specify target
> programs, translating the function names to BTF IDs before passing them to
> the kernel.
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa825..d698a64ff8002 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> [ ... ]
>> @@ -12720,11 +12732,28 @@ bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pa
>>  		if (cnt == 0)
>>  			return libbpf_err_ptr(-EINVAL);
>>  		ids = (const __u32 *) free_ids;
>> +	} else if (fds) {
>> +		size_t cap = 0;
>> +		int i;
>> +
>> +		err = libbpf_ensure_mem((void **) &free_ids, &cap, sizeof(*free_ids), cnt);
>> +		if (err)
>> +			return libbpf_err_ptr(err);
>> +
>> +		for (i = 0; i < cnt; i++) {
>> +			err = libbpf_find_prog_btf_id(funcs[i], fds[i], prog->obj->token_fd);
> 
> [Severity: Medium]
> Could funcs[i] be NULL here if the user-space application provided an invalid
> string pointer in the array?
> 
> If it is NULL, this pointer gets passed down through libbpf_find_prog_btf_id()
> and eventually reaches btf_find_by_name_kind(), which performs this check:
> 
> tools/lib/bpf/btf.c:btf_find_by_name_kind() {
>     ...
>     if (kind == BTF_KIND_UNKN || strcmp(type_name, "void") == 0)
>     ...
> }
> 
> Calling strcmp() with a NULL type_name will cause a segmentation fault in
> the application. Is it worth validating that funcs[i] is not NULL to safely
> return an error code instead of crashing?
> 

Will check '!funcs[i]' before libbpf_find_prog_btf_id().

Thanks,
Leon

>> +			if (err < 0)
>> +				goto error;
>> +
>> +			free_ids[i] = err;
>> +		}
>> +		ids = (const __u32 *) free_ids;
>>  	}
> 

