Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658F223707
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768769; cv=none; b=SbdpWDYyWxdHX/OKXaJygGqs3BRJHZZ1sGbvwAz+LuYUNxBBtHZr5rtWa9u+h2YBF+B//wb+bCUU6U4JCi5x46fet5eUGp/OquS9077NHYKtW0GaE4zIS/PsTh2mogSrabFrtafwfkCXH1z8eaOaKCkZIoT3GDl9//iYT/roE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768769; c=relaxed/simple;
	bh=aqUjq4sdfXmZFvOW0/pZHRVp3t1VN3UWBpFzPP3e2vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkoevVJDUh1kusdhZ6YKK6G8wOR0NYf2wpe0lzEedMD+Wsdpw+vp+rxxpDK8TMH84map62ZxA7tUJ/3zk+du3kALqdN6LPyeM2/wh8pT4Mc2mBwqrodsby829m8mg9keLuyjhJDpkvr6kkI+b10dyZnNu7O+m8KZLTyeHNKFI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YLpSdgJI; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YLpSdgJI"
Message-ID: <a4b844d8-cd37-4bb1-9e19-7b037ee91723@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778768756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzk+OsRFc/25MhxadfcCJk2P+tziSYp2bEBFg7gzPF4=;
	b=YLpSdgJI5bXRR2EguhmjlZUhmMdq3OC9nXVlgMvlOwIMQbmsHS7WjLbCnzrnL7DqHCuZkU
	xE8FnTDQhFAfEraBSF3kgq64AqLR05PBLqxN6swmgcEmz4E8rX2iXH9FkQZk4ZvYH0iUZ+
	gOiUlvYZz3RFxDIXuEs3JYQRpHDZNqc=
Date: Thu, 14 May 2026 22:25:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v14 7/8] libbpf: Add syscall common attributes
 support for map_create
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260512153157.28382-8-leon.hwang@linux.dev>
 <20260514010850.0F569C19425@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260514010850.0F569C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/14 09:08, sashiko-bot@kernel.org wrote:
[...]
> 
>> @@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
>>  	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
>>  	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
>>  
>> -	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> +	log_opts = OPTS_GET(opts, log_opts, NULL);
> 
> Does this code need to validate log_opts with OPTS_VALID(log_opts, bpf_log_opts)?
> 
> Libbpf relies on the OPTS_VALID() macro to enforce ABI forward compatibility
> by verifying that any unrecognized trailing fields in extended option structs
> are explicitly zeroed. While bpf_map_create() correctly validates the outer
> bpf_map_create_opts structure, it seems the nested log_opts structure is
> accessed without similar validation.
> 
> If a newer application populates unsupported fields in struct bpf_log_opts
> with non-zero values, could an older libbpf silently ignore them instead of
> safely rejecting the request with -EINVAL?
> 
Replied in v13
https://lore.kernel.org/bpf/624b092f-e1fe-4a24-9bf6-c505e202b3ef@linux.dev/.

Thanks,
Leon

[...]

