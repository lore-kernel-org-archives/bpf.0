Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.83.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767131;
	b=yZdD6lVsZSbCyBDZlbNwgn+ejumqQxryBE/Wj/q8cEjng4j37xX07WiAtWKnEY0jVmxZ
	 rwLo2D4w263IE+9C83RHQE6HInrLMAuSWQWyG6oj6lpI0JMPFqpmOXjLSGjvIzsmWOK9k
	 F4y0E2sLICqEKcPgNWJorQm35KcASW7ZqR6C9KnFq6CGDneZSKo7Lnbe2DCSZGroAmGwF
	 eROdzTE0g1Dbw39cXnVXjVSKJwB/hXr8cM2aurho3Z++lKSHyr2BWNb6Mc8xrel/MnFfr
	 nvJAiFW0hI6KGwqEursPCmlLkl0qCrPG3BglHBxYfgO8ppMVUTwWhdt5py02J5NV3lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767131;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=XSYsF9HWbYppz9Cbcbdfh68sAbHvBzwUOKcY1+7QiNw=;
	b=cIk3ncuSrRtJsFwt8Ym7ugY8H2mRNmb1xQHUenvybHCH0d1zkCXaRCGvGQZoS+bSNP5k
	 +fZzDATnO0AWABrj/Jrgav0tVcq+wUPvShVjgMds1cEd9KzjKivgZ67etdrALyt9cYCzt
	 4futyBumD+o3pndB1V3vZFfPnL8I44QnziSeF43BvPgRnnsN1PUxKALzNeCxk2qmsJFbQ
	 F8qlnMrRgpWWGtM4L+Hw0bUiE297ejm/xqHgAOyvYu+PpT9ou22ga5K40zkURpnOO3V3B
	 KgGPF/kvQ231CQBXFvCt1L8iN3CKWUk5BfIDpakcHqOYoiQFFR4T2S4hfxurytMZ5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=156.224.83.43
Received: from mail-m8343.xmail.ntesmail.com (mail-m8343.xmail.ntesmail.com [156.224.83.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A01606A31B;
	Fri, 23 Oct 2026 14:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A01606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [IPV6:2409:8a20:e23:2ae4:8810:8f74:8c26:2] (unknown [IPV6:2409:8a20:e23:2ae4:8810:8f74:8c26:2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 206722931;
	Fri, 23 Oct 2026 22:51:56 +0800 (GMT+08:00)
Message-ID: <d39db4fb-e511-440e-9065-72c34a1a295a@easystack.cn>
Date: Fri, 23 Oct 2026 22:51:56 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 ziy@nvidia.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
 <DMAURQCKK6CG.10CZ7MFXGJO3V@gmail.com>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <DMAURQCKK6CG.10CZ7MFXGJO3V@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1693f463b0229kunmd586c24b3116c6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx8fVh0ZS0gYGB8dSUgeHlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaSUtBHklIQUkaHk9BQ0NKS0FDHUxPQUMYSU
	1BSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSkJLS1kG


在 2026/10/22 06:00, Alexei Starovoitov 写道:
> On Wed, Oct 21, 2026 at 04:24 AM Zhen Ni <zhen.ni@easystack.cn> wrote:
>> Exposing the same walk to eBPF lets a program filter and aggregate in
>> the kernel and surface only the records it cares about. This series
>> adds that access as a seq_file bpf_iter target and an open-coded
>> iterator.
> 
> This is overkill. Two iterators, two kfuncs that print strings,
> a rewrite of read_page_owner(), a new file and a new header.
> 

Thanks for the detailed review and the sketch. I agree with the
principle that a thin data kfunc would be ideal if it were sufficient,
but I’d like to explain why the current design ended up this way.

On the two iterator surfaces:
They aren’t duplicate implementations. Both are thin shells over the
single page_owner_next_eligible() extracted from read_page_owner(), so
the eligibility rules exist exactly once. There’s no code redundancy;
the two iters only differ in access patterns while sharing the same
underlying iteration logic. This shape is also what Documentation/bpf/
bpf_iterators.rst prescribes:

When adding a new BPF iterator program, it is expected that similar
functionality will be added as open-coded iterator for maximum
flexibility.
It's also expected that iteration logic and code will be maximally 
shared and reused between two iterator API surfaces.

On the two “print strings” kfuncs:
These are things a prog genuinely cannot do on its own. The record only
carries an opaque stack-depot handle, and resolving it is not reachable
from BPF. Likewise, the cgroup path is built by cgroup_path() walking
the kernfs parent chain — a prog has no way to format it. Given the 512-
byte BPF stack limit, the caller-provides-buffer pattern (as in
bpf_d_path() and bpf_snprintf_btf()) is the standard shape for this kind
of kfunc. I agree they could have been mentioned earlier rather than
left to the diff.

On “a rewrite of read_page_owner()”:
This is really an extraction of common functions, not a rewrite. Aside
from the fix for mem-hotplug locking (which addresses a pre-existing bug
in the debugfs interface), there are no substantial logic changes. It’s
not a large-scale refactoring.

On the new file and header:
This is for code clarity — to distinguish the traditional interface from
the BPF interface and make maintenance easier.

> All that the prog needs from the kernel is the page_owner record
> of a pfn. That's one kfunc. The walk, the eligibility rules and
> the filters belong in the bpf prog:
> 
>    bpf_for(i, 0, ctx->nr) {
>            pfn = ctx->start + i;
>            if (bpf_page_owner_read(pfn, &po) ||
>                pfn & ((1ul << po.order) - 1))
>                    continue;
>            if (po.pid != pid || bpf_page_cgroup_ino(pfn) != cgrp)
>                    continue;
>            /* add 1 << po.order to a hash map keyed by po.handle */
>    }
> 

On why the prog can't actually execute it:

1. What range to scan. Where do ctx->start and ctx->nr come from? No
in-tree iterator context provides them, and a prog cannot derive them:
min_low_pfn..max_pfn, memblock holes, and offline sections are all
kernel state. The loop bounds alone require either another kfunc or a
kernel-side walk — which is exactly what the iter target already is.

2. What makes a page eligible. The alignment test in the sketch is the
only part the kernel agrees is expressible in a prog. Everything before
it reads state a prog doesn’t have a handle to: pfn_valid() over
MAX_ORDER_NR_PAGES areas, pfn_to_online_page() under get_online_mems(),
skip_buddy_pages(), the PAGE_EXT_OWNER / PAGE_EXT_OWNER_ALLOCATED flags
in page_ext, and taking the record snapshot inside the RCU window so the
checked value and the reported value are the same copy.

3. The walk is deliberately lockless, so exposing struct page to the
prog is not safe. The pfn validity check and the page_ext dereference
must happen under the same kernel-controlled RCU window. Otherwise the
prog could observe offlined pages or stale page_ext data, breaking
consistency between the check and the snapshot. Keeping the walk in the
kernel guarantees that the page_owner record is read atomically with
respect to mem-hotplug and RCU protection.

4. One record doesn’t give the prog the useful data. The record holds
only opaque handle/free_handle tokens; stack-depot resolution exists
solely in the kernel. The memcg is neither in the record nor trivially
reachable — the path is built by cgroup_path() walking the kernfs parent
chain. The NUMA node comes from page_owner_get_nid(), which bypasses
page_to_nid()’s poison check. And so on.


Thanks again for pushing on this. I’m still concerned that the sketch
may not be workable in practice, and that it would also lose some useful
capabilities. I hope the above clarifies the reasoning. Happy to discuss
further.



Thanks,
Zhen

