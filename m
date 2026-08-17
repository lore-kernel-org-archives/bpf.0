Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42E3EF64A;
	Mon, 17 Aug 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990233; cv=none; b=nK9GdZHQKpKVPhD3m4IA5v8pxiOTIUW0wJ4Hj35uIlsBEXwMJgsH/hD1Caa1nByMSRtLZLpeELXkmbGp3kWoVeGiMiEXPs+il05sNDIhW8wxUukdfCHVBKgSn5FgQXN4bBHZ6Q+T/INvYBhr5ndh4UC2wHjTzSdPtN7pEoqg5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990233; c=relaxed/simple;
	bh=6QgeDgzn9BEo49hI+J7da/FfwJvAG7Qe0G1CZQN5rQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR2r+OJQC4nzJa4rJYaqVJucshQFAlkss7qm+iwawDXSq3P+E37+LCphUz1ZpUdVtCqyDbnIDp/x+4XZpL6KL+CqXiwVCXH5iT+t073q0eXpb63cxe6VkawBxaJz1gHJJ7Hyk20WI3vIkvAatyCyrbl84b4Ec9yI8a6/3jrVTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6u3cyJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6u3cyJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7283B1F000E9;
	Mon, 17 Aug 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786990232;
	bh=IWschY6PJIJj78TPAK68wuF6XfNqvRhD4s+H+yde0ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P6u3cyJOWqTGgmW2GpD2BfOMO+B6rcLUTroOW0CnhXHdzCA9hhbVgBoQyJnIMYQln
	 ixmfd+ipl+0hMRrTCQiawq5EZ4qv193Fdt/sAatEejaoei9OExsjZVIXOVxID4VkuY
	 KquJ+6JlpsFLMatZHvmkhsSVsjCPOWirDHXQ31UPChw/MI7AzicEq10JTfjGVF04Xc
	 eqVWKErNMzostAW2c98rp/7g0HtznoiY7HfuAfJBD9Z7XFVhpzJCd4CdOApzkFxM95
	 KhB1y5lCFli53BwAp9WLWlIcxVmmW4Lg5cFVsqHGeuIDQo0/SqGXb7C4eCfabHvMS5
	 r/7/IUcLjvNjw==
Message-ID: <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org>
Date: Mon, 17 Aug 2026 20:10:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bpf: account ring buffer backing pages separately from Lost
 RAM
To: Xiang Gao <gxxa03070307@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrew Morton <akpm@linux-foundation.org>, yinchuang1@xiaomi.com,
 bpf@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>,
 "Lorenzo Stoakes (Arm)" <ljs@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/26 11:18, Xiang Gao wrote:
> Hi,

Hi,

> 
> I would like to discuss accounting BPF ring buffer backing pages in
> system-wide memory reports.
> 
> BPF ring buffers allocate their data and metadata as order-0 pages directly
> from the buddy allocator, and then map those pages with vmap().

I assume there is a reason the slab isn't used, right? Are these pages mapped
into user space such that page->mapcount would get used?

Can you point me at relevant code?

> 
> Because vmap() maps caller-owned pages, these backing pages are not counted
> by VmallocUsed. They are also not slab pages. As a result, most BPF ring
> buffer memory is not represented by an existing named /proc/meminfo category
> and appears as Lost RAM in Android memory reports.
> 
> We measured this on an Android 6.18 kernel.
> 
> Test case:
> 
>   32 BPF ring buffer maps
>   16 MiB data area per map
>   512 MiB total data area
> 
> Observed changes:
> 
>   Lost RAM:       approximately +529 MiB
>   VmallocUsed:      approximately +2 MiB
>   Slab:        approximately unchanged
> 
> After destroying all maps, the values returned close to baseline.
> 
> The question is whether the kernel should expose the unique physical backing
> pages of live BPF ring buffers through a dedicated global counter and a
> /proc/meminfo entry, for example:
> 
>   BpfRingbuf: <value in kB>

This looks a bit too specific for my taste. And I think we should try to no
inflate these statistics here too much.

> 
> The proposed counter would include:
> 
>   * ring buffer data pages;
>   * metadata pages;
>   * consumer and producer position pages.
> 
> It would exclude:
> 
>   * the second virtual mapping of data pages;
>   * the pages[] pointer array;
>   * map metadata allocations;
>   * vmap page tables.
> 
> The goal is to account for the currently unclassified direct backing pages.
> Slab- and vmalloc-backed auxiliary allocations are already represented by
> existing memory categories and should not be counted again.
> 
> A possible implementation is an NR_BPF_RINGBUF vmstat counter maintained by
> the ring buffer allocation and free paths, with the aggregate exposed through
> /proc/meminfo.
> 
> Questions:
> 
> 1. Is a dedicated BPF ring buffer counter appropriate?

I don't think so.

See [1] where we just had the same discussion for tracing buffers. For them,
Steve [2] had an idea on how to expose them more fine-grained and tracing specific.

[1] https://lore.kernel.org/r/20260810094025.136705-1-gaoxiang17@xiaomi.com
[2] https://lore.kernel.org/r/20260810105710.6ee5e493@gandalf.local.home

> 2. Should this be represented as an NR_* vmstat counter?

I don't think so.

> 3. Is /proc/meminfo an acceptable interface for this information?

Again, I don't think so. "Lost RAM" really is just "excessive memory allocated
by some other subsystem".

I agree that some users might want to figure out what is consuming that much
memory, but I don't think growing /proc/meminfo in that way is really what we want.

> 4. Is counting only unique physical backing pages the correct accounting unit?

I'd assume the "It would exclude" part above should not be accounted there, if
that's what you mean.

-- 
Cheers,

David
