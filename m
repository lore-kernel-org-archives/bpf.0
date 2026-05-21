Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF293191D0
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406379; cv=none; b=lm8RkIjEN0T8xH7MObognauX9BSyMyoJPuU49iqpGM682dxgDiFH7YKSfrmb3xEVF8dAEs3jQrI9BoU2q2FqfsQswjLCfh/LJ8bDV6pzJ9zP2AZR6gpFuxUk7Wk+iuZtNoVrUQRGSHANWc9M4wOZiDKg7ie1ddkH8GNPCef0wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406379; c=relaxed/simple;
	bh=lkdIZ6Q2zn4KMxbxd/hBExwnE3+zpIGPnfJYONLY5a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnFhOpglVa446/Nj4Pae9emRAwUSxNRBg/QZuOjAEmipAKtSYNQnxGNyG5gtowID/T/ClUEK+/iOQGlqXz76D68+gTKjMayKJLItlJ2dpWyoS2x8J453gvS80wn7aGC1p4tBBGpWT3FehyFaaj9haSL0OUUKryb4ZO/CxDNi7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kv/GsNkH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kv/GsNkH"
Message-ID: <8818c106-1e8e-488e-8da4-98c6b079f8b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779406374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngtm8Y87kSwySV9lKNY009muS7W62DD4gztCyNolY2w=;
	b=kv/GsNkHamZjMdz5RPwADtwM/gAcsgRTa12n6XN0EAJXux0OUZSRNwC1dxD3pKLCHgawv9
	uQDHnHkD5K/5/AKt53Oq4vNgdUqbAQrFdHzYon+Vy29LtneETxlldn6XU/s7od1xcgq0bb
	lXTQ5PZZbA2KRoSs8pUS2YwWpYRIbHI=
Date: Thu, 21 May 2026 16:32:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID
 helpers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260521225022.2695755-2-ihor.solodrai@linux.dev>
 <20260521231600.E14FD1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260521231600.E14FD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-05-21 4:16 p.m., sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Data race and incorrect ordering in stack_map_build_id_set_valid causing stale reads
> --
> 
> commit 4eb2cc8713ca7f31dcbc75f5166e94dd60761e7c
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Factor out stack_map build ID helpers
> 
> This commit factors out helpers from stack_map_get_build_id_offset() to
> prepare for adding a sleepable build ID resolution path. The commit
> message states there are no functional changes.
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index da3d328f5c15a..4c753e02c4159 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
> [ ... ]
>> @@ -152,6 +152,28 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
> [ ... ]
>> +static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
>> +						u64 offset,
>> +						const unsigned char *build_id)
>> +{
>> +	id->status = BPF_STACK_BUILD_ID_VALID;
> 
> [Severity: Medium]
> In bpf_get_stack(), the destination buffer can be a BPF map value that is
> concurrently readable locklessly by user-space. Since the buffer initially
> contains the raw instruction pointer (ip), does setting status to VALID
> before writing the offset create a data race?

This is a good point. Will fix in the next version.

> 
> A concurrent lockless reader polling the status field might observe the
> VALID status while the union still holds the raw ip instead of the correct
> file offset, and before the build_id string is fully copied.
> 
> Prior to this patch, the offset was written before the status. Could this
> reordering of assignments cause concurrent readers to observe stale data?
> 
>> +	id->offset = offset;
>> +	if (id->build_id != build_id)
>> +		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
>> +}
> 

