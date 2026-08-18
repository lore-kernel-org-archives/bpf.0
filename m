Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB846A5F2;
	Tue, 18 Aug 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076840; cv=none; b=kJ1QQiJpfErUuGObMiRz6U/opkw5Z4WrIZYhftsma04xUBFwGrhCJ8e4ccruWhXMQAQvEq74aW+/IDkcNeC07hEqiof4M1NX79RjI9dU2EONzkc70XNmm3QMxy7ryecVqPaeiSbvB5AEkfdJ0ITGiSezEK0xHZ+bS4vdzdN5ZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076840; c=relaxed/simple;
	bh=yMLrmdwXeHUgaFH2K6lvC5bUq9/5Cuaow9mOoprwegQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqNd6CHFzNDi4JQ004N/vub12/1XMj9WRYIMrA6nLuq+lJKhSf/fXELUMU0MqGNSXI/DxqjBzW6ssOrW/dxKqG25GniaS798QUBSxwvj/iwVoVN3+kpK43QKbIILmpkkhYEceAX1bU/G8NOkoPkHJmYmGc0a/MwTj+QCa47xTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKWBXLyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKWBXLyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC0F1F00A3A;
	Tue, 18 Aug 2026 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787076839;
	bh=6urx/Pmc2TVqY78ox2ByVeVGQ7i5RyjHUlIMni2Wy24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TKWBXLyNCdFchULyM4e6Qnn0+fNTSqbcC4mqTMW//aMh/p21/6Ly0aql6Fda4s4xp
	 HvZz3Gzt32dxhVEwYxwARMuSBHQHXGfzMRvaYlrh0cywJg+pNkv5sf26/QFhSlvm7q
	 b8jc6mMNUjb+i7C2/tLepIXyrFk9Srb2fc/GD7slcCnwcg7qs8BwJr0PQ/KcCGxqiA
	 vEq6mMT4B1eKUpL2jd0W6OaqwR6imJDEeYlDD8t1ipMLgZAeuTxmJeVsuBM6sE3BBx
	 aAXBUDXf4L5c5VXyAvVxm58UULRPAohQ/RD4KHZV8vG3WNoS7w2rhe3HryL6C4AKtn
	 z4aMShcnqUZGQ==
Message-ID: <c05f7bfb-c84b-4c36-8091-5ec7721a658b@kernel.org>
Date: Tue, 18 Aug 2026 20:13:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/57] mm: add pte_folio()
To: Rik van Riel <riel@surriel.com>, Kiryl Shutsemau <kirill@shutemov.name>,
 akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev
Cc: baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 hughd@google.com, lance.yang@linux.dev, liam@infradead.org, mhocko@suse.com,
 rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com,
 usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com,
 usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kas@kernel.org, jannh@google.com, willy@infradead.org, pfalcato@suse.de,
 rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-2-kirill@shutemov.name>
 <905d08d102e56a026a5ad69573c507d2d9becc37.camel@surriel.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <905d08d102e56a026a5ad69573c507d2d9becc37.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 18:38, Rik van Riel wrote:
> On Sun, 2026-08-16 at 23:45 +0100, Kiryl Shutsemau wrote:
>> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>>
>> Callers that want the folio behind a present PTE spell it out as
>> page_folio(pte_page(pte)).
>>
>> Add pte_folio() as the folio companion to pte_page(), and convert the
>> callers in fs/proc/task_mmu.c and mm/hugetlb.c.
>>
>> Preparation for the anonymous collapse engine, which reads the folio
>> behind a PTE in several places.
>>
>> Assisted-by: Claude-Code:claude-opus-5
>> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> 
> Oh nice, this could clean up some things in the
> get_user_pages code too, when we get around to
> tech debt there.

We really need the page in GUP code ...

-- 
Cheers,

David
