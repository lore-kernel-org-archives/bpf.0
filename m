Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BD425CEE
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518056; cv=none; b=lyaKMMN8AaO6xTzW66IUrabGU/Psb2ZPPROuCGuVDa8BFdYmc40bxp3tDFUs0gWRsfGQQqKvH6mSgqQ3nxIwDwf35ojtMQsZyaEcsrc6+i03nPWO9HT6tXVTg/2vrpH3rUlnS5I24pBPB6MhDnmyVQLtheucG82xYGYRRc8thR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518056; c=relaxed/simple;
	bh=K7cyc+1Yuw0mPv/moSoVI4awhDF+OasA8R5z3xBXTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S84GmLLXKBH9Ci2V1hSAFul5M7GjH5nMiLxsMuS8tD7Ev5q1eNMr92jVDlgh7C1ZjyWZk4//p3Q3qLCVCnvow/nsDA1vOi2SZTjWVu8Os/lYFX8sIEYwLJb8kSgEvqkzB4iErptAbS/H9pKI01cDbiP5N2Kkwo5WRjVtbDlbm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJGSSJZc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJGSSJZc"
Message-ID: <cf03e4af-b81e-4c50-84a2-462b0a57edce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778518052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMYwl3L9f62eord2gMpVwsKjmtSbTOlHPHTh+gRwfY0=;
	b=HJGSSJZcbEruZVH/3b+eIm7RHbLwxNAWr/WE3LXe9VUgW/5FpeqW7qbUANswuyvlVbgdMm
	JLtFV4rvBFH2nelQ5DhMhQSJmA12ToF8ycAwsXPCRsZG8rxxa+NpC2L5E/GoUzdsCAuyIx
	ADpmtEZrg5KwlLU8txMRByuSDRxkwDc=
Date: Mon, 11 May 2026 09:47:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 15/24] bpf: Pass bpf_subprog_info to
 bpf_int_jit_compile()
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053418.1888759-1-yonghong.song@linux.dev>
 <DIFZU9BF7H2L.2C6L1A58XG5B3@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIFZU9BF7H2L.2C6L1A58XG5B3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:38 PM, Alexei Starovoitov wrote:
> On Sun May 10, 2026 at 10:34 PM PDT, Yonghong Song wrote:
>> -		func[i] = bpf_int_jit_compile(env, func[i]);
>> +		func[i] = bpf_int_jit_compile(env, func[i], &env->subprog_info[i]);
> Touching all JITs is too much churn. env already holds subprog_info.
> Figure out how JITs should see which subprog they're processing.
> See bpf_is_subprog(), for example.

Good point.

func[i]->aux->func_idx = i; We can get func_idx from prog->aux->func_idx 
and use func_idx to index env->subprog_info[prog->aux->func_idx]. 
Indeed, this is much simpler.


