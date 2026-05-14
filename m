Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FDF383C82
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768788; cv=none; b=hZj2GNgIVUtGh2D4tqBak7xIe6tY/5JPV3xGkqsRliTda/o0tBQ/iMoB8515Y4dnf6At2Lg/WkBiKr1XCX8zQ4JfL7AkbkFwOaBufVW/8YskbnLiZVI/rgyb7Pd5q6zyFKEC27N2pVMJc3KVRIL3UwCRiFmyY2yipLTkPT7eoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768788; c=relaxed/simple;
	bh=5YO04BGNJ5Foa6mMJCVFbz2JiPs/zaXhw7uwUj/LaKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSvrR36ubWb5GCnTVyVuL1my8M+B0wnROdaRWIp2md3nWhZxTYtvj+xv2e04DaAuszvJYEfByqAFLDDDWBdSRtr4TAk70dVqtac4ABKJ0INajAszckYx3rLR8wXhFDtcHPMIy3zSY0kWTkFAdEHRclfZXD8WTDQkTvjtYlb7/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=If5PPhXn; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="If5PPhXn"
Message-ID: <57b7430f-babc-49d2-9434-98d0fa6b45e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778768785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyqG4DzidudMPHjQ9M8AXpwhVpgRwtfP8/SX3HjiPGw=;
	b=If5PPhXnZg3uAl8RNCy6dCe9YrbyIp3ZdBPykvUrBOC0LmtAfc/WvcW95IO0cboNanGmBA
	UkNuTn+5nxVWPM2cx+zEonudD2d0S8YF/hTcSoyyCCL7yvjNqaHSR2hrybIru0K3iZEkgI
	AQpVk/v726DB1+jJOv0jtViWJcGgDXk=
Date: Thu, 14 May 2026 22:26:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v14 8/8] selftests/bpf: Add tests to verify map
 create failure log
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260512153157.28382-9-leon.hwang@linux.dev>
 <20260514012532.E0375C2BCB3@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260514012532.E0375C2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/14 09:25, sashiko-bot@kernel.org wrote:
[...]
>> +static void test_invalid_numa_node(void)
>> +{
>> +	const char *msg = "Invalid numa_node.\n";
>> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
>> +		    .map_flags = BPF_F_NUMA_NODE,
>> +		    .numa_node = 0xFF,
> 
> Would this test be flaky on a massive system? Using 0xFF (255) for the
> NUMA node could accidentally match an online node on systems with large NUMA
> topologies (e.g., up to 1024 nodes).
> 
> Would it be safer to use ~0U or -1 to represent a guaranteed invalid node?
> 
>> +	);
>> +
>> +	test_map_create_array(&opts, msg);
>> +}
> [ ... ]
>> +static void test_invalid_token_fd(void)
>> +{
>> +	const char *msg = "Invalid map_token_fd.\n";
>> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
>> +		    .map_flags = BPF_F_TOKEN_FD,
>> +		    .token_fd = 0xFF,
> 
> Could the use of 0xFF (255) as a file descriptor lead to spurious test failures?
> 
> While an open FD 255 is unlikely to be a BPF token, using -1 or ~0U is the
> standard way to provide an invalid FD, which completely eliminates the risk of
> accidentally hitting an open file descriptor.
> 
>> +	);
>> +
>> +	test_map_create_array(&opts, msg);
>> +}
> 

Replied in v13
https://lore.kernel.org/bpf/b22790b4-1e33-4cab-bc2f-92cf7fd60bfd@linux.dev/.

Thanks,
Leon

[...]

