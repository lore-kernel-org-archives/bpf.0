Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26743B42EB;
	Mon, 17 Aug 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954121; cv=none; b=hF7F1vhxxTvz4/Rq9xexJr6cOgNeeZASCa+pSkcD3uC3WpuETPL3SqSIAXFYlnfFtY32GzUiVYlyJTx8uhKiNPRY2PCgjZa5d/n7hcFWxz5T9Oud6Djy8jqScIJss8Ic8C7smZJMe/3Q+21dzm1GzHZziSf5otShtyZwxEuO3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954121; c=relaxed/simple;
	bh=zj74Hr/XAT02FIqAuwwDqdOTj+m6BqblU8nBPT8xOMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBCt0oil/9dnAHH641Ub3Ec1R07++XEi5tIRrUjzf+f8AjyaozwLkOtxmC6WxuCVMViUippq9CWpdIBNquLe2Lm6pR15UVB3EBcwUQp9HcHgUh5zhQHwSWV2E4xbAA+Y5JYO8Gefw6NCWuK6JunavZ4LgNre7bNCbqHGPP95Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6EFAz/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6EFAz/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D087B1F000E9;
	Mon, 17 Aug 2026 08:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954120;
	bh=sJsJN+5YLKTnW81Xicb7tL7wpJX2GIsGaBclQLeGSDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L6EFAz/N8frtjTYMhC41YcgafQj+gBjJh6rY/daU7FJO1YzFpJVnp9i4SKeoeNtqm
	 UXnYJvec4PnoNFP5LGZRO8AGBo8w+/MX5AU/KUNd+Vr9d0M6FDRicHMXnIpui5G8ED
	 QRD1EZbe8d15CmW20LwIZ7UHzIFTPLtK8CH34er6bIryDtyIu8yXH7a1ty8lIKlKP3
	 UF5rA1P+w9CJXKZdrY+9RWw/oAhSSceXva0IlqgCq6LYRjsLwktpzXoIo10++8NJ+y
	 FrXvWoVckNUjHs21Mi8UX8GQU+7QO9UikyZhngjnuehX+OCwbgN4TRU75XOugXl73L
	 s4yspLaJop6GA==
Message-ID: <985a5b95-e2af-4603-b2af-973cd634cb59@kernel.org>
Date: Mon, 17 Aug 2026 10:08:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 57/57] MAINTAINERS: add an entry for collapse
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, nico.pache@linux.dev,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 hughd@google.com, lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com,
 rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com,
 usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com,
 usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kas@kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de,
 rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-58-kirill@shutemov.name> <aoLASuFkQ3rUrWa0@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aoLASuFkQ3rUrWa0@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 10:04, Lorenzo Stoakes (ARM) wrote:
> On Sun, Aug 16, 2026 at 11:46:09PM +0100, Kiryl Shutsemau wrote:
>> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>>
>> Collapse is now its own body of code: mm/collapse.c, a header stating what
>> it offers a caller, and its own tracepoint family.  It has two callers,
>> the khugepaged daemon and MADV_COLLAPSE, rather than living inside one of
>> them.
>>
>> Add a section for it, and move what belongs to it out of the THP entry:
>> khugepaged.c and its header, the trace header, the selftests, and
>> mm_slot.h.
>>
>> The selftests are matched as khugepaged*.c, which also covers the race and
>> sync-check harnesses the THP entry did not list.  mm_slot.h stays listed
>> under KSM as well, which is the other user of it.
>>
>> Assisted-by: Claude-Code:claude-opus-5
>> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> ---
>>  MAINTAINERS | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7c179b333e4e..4e4e5030b979 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16955,6 +16955,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>  F:	include/linux/balloon.h
>>  F:	mm/balloon.c
>>
>> +MEMORY MANAGEMENT - COLLAPSE
>> +M:	Kiryl Shutsemau <kas@kernel.org>
>> +L:	linux-mm@kvack.org
>> +S:	Maintained
>> +W:	http://www.linux-mm.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> +F:	include/linux/khugepaged.h
>> +F:	include/trace/events/collapse.h
>> +F:	mm/collapse.c
>> +F:	mm/collapse.h
>> +F:	mm/khugepaged.c
>> +F:	mm/mm_slot.h
>> +F:	tools/testing/selftests/mm/khugepaged*.c
>> +
> 
> I'll look through the series properly, but presumably this is a separation of
> the THP collapse logic, and therefore should have the same maintainers/reviewers
> as the rest of THP.

Jup.

-- 
Cheers,

David
