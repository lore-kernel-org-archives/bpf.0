Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B6280CC1
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781325492; cv=none; b=a1L43o9bjf9vE8aYIIEpiaAZDNThNIRkCgk3f5KLXKbIVv2ZVF9QUYDIu97Ry0UUsNPIhr49FwuPfRAo4qjpTjEK8d7dGI0h8OWO9IvPY+tKhtg6gIsRSjdPxsymDnz5V+jmOaR6wVkjIm6TLmK8aNsQtD1up4yMwLbaqgfCGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781325492; c=relaxed/simple;
	bh=qw1yCtGVJNoZ4FZtlqnhgAAuumsaE2J02J95Kz8HvKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a77Tikb7aud9fi4dd0vMUS/+egOwLOKL+sGi+n1oWFpdsBtqGG17UNdCYG+MFyXG4DATpZTNyy0UwyKaz3o0ZjvVODbEh8PeziaT0OihZ4zOQk81xEsrpTyEvk99zmoGSeQPSM6h+G2TmO/KL6mS5Crv95Y4L6GL4joOYG3bNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p28OSjU5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p28OSjU5"
Message-ID: <6d5db6af-1dc7-49de-aec1-8f06dc5f3416@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781325488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uI/YMp90vibxjW5VS3XQL4NGBeWMgv1bhI48f8fDBxU=;
	b=p28OSjU5iXZvtuJxJuNXsKaYsRNrEZ+1OABVzxzd4xJF1TP69MNyiPcxItHEntooFo2u+8
	fsURoUWi3uThfnyoCj1FggrRKYlrC9g58aNOj5gXXtxI4EqFPk9mYWpfPZ6+b5uQ2f1zIZ
	YvVC07ZNU1dkTxo+9n1gKqQdVOlz/y4=
Date: Fri, 12 Jun 2026 21:38:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
References: <20260612220651.2507843-1-ihor.solodrai@linux.dev>
 <DJ7JIJEZ333Z.28J0XFPQ1RAFC@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DJ7JIJEZ333Z.28J0XFPQ1RAFC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/12/26 6:45 PM, Alexei Starovoitov wrote:
> On Fri Jun 12, 2026 at 3:06 PM PDT, Ihor Solodrai wrote:
>> +static void stack_map_build_id_cache_set_resolved(struct stack_map_build_id_cache *cache,
>> +						  struct file *file,
>> +						  const unsigned char *build_id,
>> +						  unsigned long vm_start,
>> +						  unsigned long vm_end,
>> +						  unsigned long vm_pgoff)
>> +{
>> +	if (cache->resolved.file)
>> +		fput(cache->resolved.file);
>> +	cache->resolved.file = file;
>> +	cache->resolved.build_id = build_id;
>> +	cache->resolved.vm_start = vm_start;
>> +	cache->resolved.vm_end = vm_end;
>> +	cache->resolved.vm_pgoff = vm_pgoff;
>> +}
> 
> sorry for broken record.
> claude's copy paste doesn't bother you?

tbh, this particular block is fine with me, it's certainly
not as bad as big expressions in the conditions that I rewrote
in the other helper. I guess I'm just used to lengthy qualified
expressions from my java days, so it doesn't bother me much
(maybe it should).

I briefly chatted with Eduard off-list about this, and I agree
with him that what makes this patch awkward is anonymous structs
as cache fields. I'll try something else in v3.

> It could have been:
> 
> struct resolved *res = &cache->resolved;
> if (res->file)
> 	fput(res->file);
> res->file = file;
> res->build_id = build_id;
> res->vm_start = vm_start;
> res->vm_end = vm_end;
> res->vm_pgoff = vm_pgoff;
> 
> or
> 
> cache->resolved = (struct resolved) { file, build_iud, vm_start, emnv_end, vm_pgoff };
> 
> and probably other options to make a code easier for humans to read.
> 
> You have to explictly tell claude to deduplicate otherwise it keeps
> copy pasting left and right.

I am painfully aware of claude's quirks, yes :)

