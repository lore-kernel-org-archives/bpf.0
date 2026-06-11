Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B530DEB8
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154514; cv=none; b=YAR6WRDnEyrsGhKY+YxxUmYCfwk5N0CjSLOdqxDagQ0y+/a8dYYv52En2RmiicCtnHwl+Ka+Q7tzGnLRzZ6Z5qd4LL89SwiPIfvESmfREhPaxSSZoul2TQc5BKyex5nu8GISHvslxcUvDmmdIiplbkBNw3MHVpYVOjSS5Ml/wAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154514; c=relaxed/simple;
	bh=5sDmEJqyFTiT2f3zMgVH5Cj9Yf030IUzPRA8B5rGdaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQZ5y9CZ3yzqGmgkkIwgDuv1UXXJP4KyBX88zBexs9qcPKr20N/Kjl4Ddg+0S0YJEqtYBdXm7hSeEdpFyIbtgF6TIsAQtmNTGoqgUdpkOwf6DPXAuWH40tHsYJODWiNj2EQciLW/KJCYD68BVefZW8lC3lWJk8s7Dej8+Yldk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VSxIg/Au; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VSxIg/Au"
Message-ID: <66d40066-94a7-4710-8e0f-d18f8c1bf21f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXMN5wFGs7L43zU11I1CN+my4H6XWB6YkQg7qQpqlcY=;
	b=VSxIg/AuLksTvmi+4J7366M9hPMbdE4V29gwicAT1LSU93uaPY/SJAoitx3o5WRCPEWVbe
	2/fW9az5kRT/hDChIFPy/SaURT5N5NsdBZdd7/nct17G0WBjcVpSyfu/vffn3qZWx409KT
	lz8wMqB48xaC6mCQjmlz9LFK9FTji4I=
Date: Thu, 11 Jun 2026 13:08:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/9] libbpf: Probe percpu data feature
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260608145113.65857-4-leon.hwang@linux.dev>
 <20260608150554.0B02E1F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608150554.0B02E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:05, sashiko-bot@kernel.org wrote:
[...]
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
> [Severity: Low]
> Does this unconditional warning and negative return value cause log spam on
> older kernels or for unprivileged users?
> 
> When bpf_map_create() fails, returning the negative error code causes
> feat_supported() to log a second "Detection of kernel ... support failed"
> warning. Returning 0 instead would correctly signal that the feature is
> missing without the additional log output, similar to how other probes
> handle expected failures.
> 
Nope, I don't think so.

Since percpu_array map is a basic map in bpf, this map creation should
likely succeed. If it fails, the kernels are too old to use such new libbpf.

Thanks,
Leon

