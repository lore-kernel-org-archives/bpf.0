Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBF35CB6F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687896; cv=none; b=tC4OjuQ8CCVV2ppnjDEpFHSTMUHn0IXOSsS6kSqJRvWIQgNQgbATkORyhaNHoSQyKm9Sm5AtmsJMo+tvwNyQ6qpDGv/fFgfHTO/IdnvHE7JVKFDsuDyGi9UuVo0ArjwZvDiUjPjVX0codzEjHjnfQVVpUfqbBiTzIRLMzY/Yvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687896; c=relaxed/simple;
	bh=RII08E4OChShk1f6g9svv7r6KNxxrcFvD8vpWNknJuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvAHpzTa4EZ6ZNB/K7g1GKKP7z0MOKXymlF0vTs+8ISwsYxqjyq7ygW/ew8aSDoRiWUQOPB6gjRgimpRBVAGSB1tSpQ6onJeDBDiLGSIJL5kAnq09I7zdZK9KvvZnuJ/X1E9AiAspJJ8d0/igfmI1qylJ4d12aFG8iawhxUF+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y8+FbEvc; arc=none smtp.client-ip=95.215.58.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8+FbEvc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RII08E4OChShk1f6g9svv7r6KNxxrcFvD8vpWNknJuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786687892; v=1; x=1787292692;
 b=Y8+FbEvccVoxXRqNlG6edC22f1Ks930NbnTO3V9dnbhVRNxoanILJCbqR3YzFo7D1Poi+9zH
 O3KdqUs9dbQiAEoWiaYS8Z+h7op5XXPtPf4+QDn+jnZYCa2PYiYAiSM0VERzfj1DlleQyx1nkG+
 BsOKt6xvXJwxBsUmNYDn+uNc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id e2fe0e194bef90a0;
	Fri, 14 Aug 2026 06:11:32 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <9835140c-1a55-4b96-9bbd-a36882f2ac5e@linux.dev>
Date: Fri, 14 Aug 2026 14:11:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 04/10] libbpf: Probe percpu data feature
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-5-leon.hwang@linux.dev>
 <20260813153811.6C69D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260813153811.6C69D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/8/26 23:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The feature probe `probe_kern_percpu_data` incorrectly returns a negative error code and logs a warning when the kernel lacks support for `BPF_MAP_TYPE_PERCPU_ARRAY`. Feature probes in libbpf should silently return 0 when a feature is missing to gracefully indicate its absence without polluting stderr.
> --
> 
> --- Patch [4]: [PATCH bpf-next v12 04/10] libbpf: Probe percpu data feature ---
> commit 783c3759ac5b8bbe1c5368930abe9953ff13c465
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
>     libbpf: Probe percpu data feature
>     
>     This commit adds a feature probe for global percpu data support. It allows
>     libbpf to detect if the kernel supports percpu data early and make capability
>     decisions accordingly.
> 
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index b7e388f99d0bb..ef9581c113035 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
> [ ... ]
>> +static int probe_kern_percpu_data(int token_fd)
>> +{
>> +	struct bpf_insn insns[] = {
>> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
>> +		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
>> +		.token_fd = token_fd,
>> +		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
>> +	);
>> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
>> +		.token_fd = token_fd,
>> +		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
>> +	);
>> +	int ret, map, insn_cnt = ARRAY_SIZE(insns);
>> +
>> +	map = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", sizeof(int), 8, 1,
>> +			     &map_opts);
>> +	if (map < 0) {
>> +		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n",
>> +			__func__, errstr(map));
>> +		return map;
>> +	}
> 
> [Severity: Medium]
> Will this cause spurious warnings when probing environments that don't support
> BPF_MAP_TYPE_PERCPU_ARRAY?
> 
> Since feat_supported() expects feature probes to return 0 when a feature is
> missing, returning a negative error code here causes feat_supported() to log
> an additional failure warning.
> 
> Should this return 0 instead of map (and perhaps omit the pr_warn) to
> gracefully indicate the feature's absence without polluting stderr?
> 

No.

Since percpu_array map is a basic map in bpf, this map creation should
likely succeed. If it fails, the kernels are too old to use such new libbpf.

Thanks,
Leon


