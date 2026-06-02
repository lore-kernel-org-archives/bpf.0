Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D77288C2C
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424955; cv=none; b=tFStiAg1WL2aR1wsEJdFXpfI22IF4UrbcHpiO41k3UPlYXUYgGI2i4C4vikNA7iGryzWTIjboNydsZ8ZY1C7/JSDKbnRd2llj4ewQU5xhxaQvs/yst6Ij4mM46Du8TDptY0VvwWGxWbAIo1q+GoN6gIjGXtcSOmNUSCxWhR4578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424955; c=relaxed/simple;
	bh=QDdAzWAblk0fwqPkNiE9X2RrQFQQX+OoiIAgHgJNIVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVo7JpCzN/Gnw+pjfZ6TgbyflXMrcIKzfqUX30U+Rtq9LZUzkqq3P+lg3pJ+iCMyaRMO1rj9Gmdz/0pk/e2TOBPRiMDC73jxzKcu7+Ji7QITjPSIyYMErTJafqS6EaNGFjm9FPDQynvwp7LCJ7N6AQEjqoPKkxPKhE8clCGthWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWdAglnd; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWdAglnd"
Message-ID: <aea15513-c5db-4d67-9f28-5dc7f6063fe4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780424951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJBWV+Fz436w1gfOM6RtvoOneeQlsp7Iqp9yrBhmPSw=;
	b=cWdAglndsn5/Lwl+GkMJ3kXH/OrIBOjiLbc01AE7BrVXlAqIdd/Ej7+31uA2E37e7j5JeK
	OQ6HtA9xNwDGP46x21wgCaP8N/iabRSCuL4UlNW7cyZ8HQcn77UpsBvv05rxzVkIvUJDeB
	THRjRKmn7I4Ebifx9BDbsPtCy6ppT7M=
Date: Tue, 2 Jun 2026 11:28:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 05/14] resolve_btfids: Index BTF ID symbols by
 address
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-6-ihor.solodrai@linux.dev> <ah7UQv87CmJ-LNMt@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <ah7UQv87CmJ-LNMt@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 6:01 AM, Jiri Olsa wrote:
> On Mon, Jun 01, 2026 at 03:17:56PM -0700, Ihor Solodrai wrote:
> 
> SNIP
> 
>> +static int push_addr_sym(struct object *obj, Elf64_Addr addr, const char *name)
>> +{
>> +	struct addr_sym *arr = obj->addr_syms;
>> +	int cap = obj->max_addr_syms;
>> +
>> +	if (obj->nr_addr_syms + 1 > cap) {
>> +		cap = max(cap + 256, cap * 2);
>> +		arr = realloc(arr, sizeof(*arr) * cap);
>> +		if (!arr)
>> +			return -ENOMEM;
>> +		obj->max_addr_syms = cap;
>> +		obj->addr_syms = arr;
> 
> could you use libbpf_ensure_mem instead?

Hi Jiri. Thank you for prompt review.

Yeah.. a third copy-pasted push_* function is one too many.
I'll try adopting libbpf helpers in the next revision.

> 
>> +	}
>> +
>> +	obj->addr_syms[obj->nr_addr_syms].addr = addr;
>> +	obj->addr_syms[obj->nr_addr_syms].name = name;
>> +	obj->nr_addr_syms++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cmp_addr_sym(const void *a, const void *b)
>> +{
>> +	Elf64_Addr aa = ((const struct addr_sym *)a)->addr;
>> +	Elf64_Addr ab = ((const struct addr_sym *)b)->addr;
>> +
>> +	if (aa < ab)
>> +		return -1;
>> +	if (aa > ab)
>> +		return 1;
>> +	return 0;
> 
> nit, I recently spot following pattern:
> 
>         return (aa > ab) - (aa < ab);
> 
> jirka
> 
>> +}
>> +
>> +static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
>> +{
>> +	struct addr_sym key = { .addr = addr };
>> +	struct addr_sym *res;
>> +
>> +	res = bsearch(&key, obj->addr_syms, obj->nr_addr_syms,
>> +		      sizeof(*obj->addr_syms), cmp_addr_sym);
>> +	return res ? res->name : NULL;
>> +}
> 
> SNIP

