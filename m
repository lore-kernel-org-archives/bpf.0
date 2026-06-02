Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49469223DC6
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425036; cv=none; b=LM5/RVVPS/FPu6ALb8dXsrsYocCf5lUD5BNWWdKXstBWW8u6z9UG4huq55MVtlDDEQB4SQ46HHUl6Aeg4ye9IlAIk9LQSMOk4xeHZk8/ezPLInEAWdEeanh5nmAWeiE58Zd8zVYM0laAdQolTsITvIVUSsuYH7TsQIP4MpK+KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425036; c=relaxed/simple;
	bh=t2Vy1eH2AXireiIjYSHr/B6Xt78hGehzQS23aX0vSTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEYgUcY3ltjwuEDMS9z1gUVdc/ms2YHS6jlbgB2G8KsvqtqIr5CMj1P9GIWRw3FNoHoKlB97AxNxt92Jfa60Z9NxdQ/ycZD5pY4yedySPtytopH/UnhTDHaI0WFEpUAM1LNmpR26p/vtWVfp/KZ6YDXVFbvd7oYGp+AyigouxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LtOmS7d5; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LtOmS7d5"
Message-ID: <7d1a75e4-a2f8-40a2-bd03-405b85b0a846@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780425023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95UKYabNJOEIeppEfTxbhbxJbizXLVR+134W7NVUtjc=;
	b=LtOmS7d55QLTvO6NoSwt90RlEUbEmB0L+A1PADSpmiKSI+/zGNvtmodDs3OXpcuJ4dWKuJ
	IXPDAeYHAa0Qt01ManfpTP+lW9LXOmCcCT7uPx2HtLb5tMoXJHZtw6zx3ouRTkH52euXWE
	Gec1TvL33YYMFmK6w6qQiegi8Xh15PI=
Date: Tue, 2 Jun 2026 11:30:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 02/14] selftests/bpf: Modernize resolve_btfids
 test scaffolding
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-3-ihor.solodrai@linux.dev> <ah7UVZLgsBcLDnkJ@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <ah7UVZLgsBcLDnkJ@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 6:02 AM, Jiri Olsa wrote:
> On Mon, Jun 01, 2026 at 03:17:53PM -0700, Ihor Solodrai wrote:
> 
> SNIP
> 
>> -static int resolve_symbols(void)
>> +static int resolve_symbols(struct btf *btf)
>>  {
>> -	struct btf *btf;
>> +	__u32 nr = btf__type_cnt(btf);
>>  	int type_id;
>> -	__u32 nr;
>> -
>> -	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
>> -	if (CHECK(libbpf_get_error(btf), "resolve",
>> -		  "Failed to load BTF from resolve_btfids.test.o.BTF\n"))
>> -		return -1;
>> -
>> -	nr = btf__type_cnt(btf);
>>  
>>  	for (type_id = 1; type_id < nr; type_id++) {
>>  		if (__resolve_symbol(btf, type_id))
> 
> I think __resolve_symbol uses PRINT_FAIL instead of ASSERT

You're right, I missed that. Thanks.

> 
>> [...]

