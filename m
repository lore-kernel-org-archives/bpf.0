Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894629;
	b=A41nWKX3tlfyPiQnb4F7YNm6FAgyPSqMKaG2WF4xGket1L7kwhkfXCkXDopprTdgjxG5
	 fKZqUD4PPAHEM6dioWPLyRUnMy7VWZisaWUY1NWYEgcm4eyf96MfB/k0Vornh/qUrv8NI
	 Wy1Kq4V+vO03enbV5L0XmQtvLh0W3VYRt272d1pSWsMrkCKtq/DsJ0dlk7pYNiwkBoWyX
	 Fsx0ynBBrTptOJwO/6lpMS//Rp2ZDPwVfopM4jct9imZ65RPmeHF1gVHZYL0YOh7exKJ2
	 pmDJlCBHGQCT6lUwiIoogK46jtK/y9bJe3/9WeK9BK+qEao9elJbGY7XZlD591dmYaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894629;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=FnEFDsNw6/OpFTmHzBgKlLwdZuANPYxCz09uyvQgX8A=;
	b=qW2RsqjrRgXIONo5y1nWBO53L6XLyYMCf1tQr5ClS7fUH3ItR3ZP0qOduIYCmMjB1B1u
	 KTR7/vDUa9QI4uWVauS72jwp5g78BxXPvhF7qucznX1cl6GYbQef0FCVdiOtMwlfJJtqI
	 s1pFvkk6y0bAk+syxc4zPOKdcF2+j2+oBKUDbAPLtN4vo5nyic+i1aXRU4aHz0oI8OWXq
	 Hr3Tp1H2eH11jt1uNgadvUqBBdUgMEXvZBsmDN2KTvOIhbKVFSTbCHJjAq0dmrVz30la3
	 noh/lCXDKqFRyLjztaKpxOC93uijV+MurYJac4wEKjk4pirZE007quee4I4yVuBIzqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=154.81.10.254
Received: from mail-m10254.netease.com (mail-m10254.netease.com [154.81.10.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26C606A31A;
	Sun, 25 Oct 2026 02:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC26C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [IPV6:2409:8a20:e23:2ae4:8810:8f74:8c26:2] (unknown [IPV6:2409:8a20:e23:2ae4:8810:8f74:8c26:2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 206d49bda;
	Sun, 25 Oct 2026 10:16:54 +0800 (GMT+08:00)
Message-ID: <7f9a9da5-1250-4be3-bfa2-70e4b6051197@easystack.cn>
Date: Sun, 25 Oct 2026 10:16:54 +0800
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
 <d39db4fb-e511-440e-9065-72c34a1a295a@easystack.cn>
 <DMCCBEPCIWH0.2JEDKE64WPJRQ@gmail.com>
 <06925440-8df8-4f2e-aea0-ede1a98435fa@easystack.cn>
 <DMDAZW82I9LT.3FNX2WI80GNE2@gmail.com>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <DMDAZW82I9LT.3FNX2WI80GNE2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa170d8bcd60229kunm6cc80f93366ac1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE0fVkNMQh0aGRlCTUgaHlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaSUtBHklIQUkaHk9BQ0NKS0FDHUxPQUMYSU
	1BSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSkJLS1kG



在 2026/10/25 03:08, Alexei Starovoitov 写道:
> On Sat, Oct 24, 2026 at 10:19 AM zhen.ni <zhen.ni@easystack.cn> wrote:
>> For this one node alone, about 97% of spanned is holes. With
>> bpf_for(pfn, start, end) plus a bpf_page_owner_read() per iteration,
>> that is at least 16,712,944 kfunc calls, and bpf_for has no scheduling
>> point inside, and all of them are wasted work. The gap grows with memory
> 
> Right. spanned includes the holes. So don't pass them.
> /sys/devices/system/memory/ has memoryN only for present blocks.
> /sys/devices/system/node/nodeN/ links to the blocks of that node.
> /proc/iomem has "System RAM" ranges.

Thanks for taking the time to review this.

 From /sys/devices/system/memory/ you get a discrete list of memory
blocks. The prog (or userspace) still has to walk those blocks, handle
boundaries, and track progress. That is traversal logic that an iterator
already absorbs into a single next() call. Pushing it out just moves the
complexity; it doesn't eliminate it.

Therefore, this only demonstrates feasibility, not superiority.

> 523024 pages in a 32G node looks like 64K pages.
> Then the whole 256G box is 4M pfns.
> When a hole is passed anyway the call ends at !online_section() in
> pfn_to_online_page(). /proc/kpageflags does that plus put_user()
> for every pfn, holes included.

True, the kernel safely returns an error for offline PFNs. But paying a
kfunc call just to learn that a PFN is ineligible is exactly the waste
the iterator eliminates — the kernel-side cursor skips holes and
ineligible pages before the prog ever sees them.

> Syscall progs run under migrate_disable() only.

Agreed, migrate_disable() pins the task to one CPU without disabling
preemption on PREEMPT_RT. But being preemptible doesn't mean the loop is
free — an 8M-iteration tight loop still consumes CPU, delays RCU grace
periods, and piles up softirq work. Skipping ineligible pages up front
reduces that pressure.

> 
>> front. The spanned of this node is already 17.23M, so a single bpf_for
>> cannot cover it; you have to split it into N chunks and poll, with the
>> chunking state kept in a prog map, i.e. a loop nested in a loop.
> 
> The loop over chunks is in user space. One bpf_prog_test_run_opts()
> per range with start and nr in ctx_in. No map, no nested loop.
> 

The outer loop being in userspace doesn't remove the chunking burden —
it just relocates it. Userspace still has to parse sysfs, construct
ranges, issue one syscall per chunk, read the map, accumulate results
into a global aggregate, clear the map, and handle partial failures. And
in the snippet, i is an offset within the chunk while start and pfn are
64-bit — the chunking arithmetic itself is non-trivial. An iterator
absorbs all of this into next().

>> for 52-bit PA. A 32-bit PFN range will overflow here.
> 
> The snippet was:
>    bpf_for(i, 0, ctx->nr) {
>            pfn = ctx->start + i;
> i is an offset within the chunk. start and pfn are 64-bit.
> 
>> Solving all of this requires yet another, more complex kfunc—and it
>> looks increasingly like bpf iter. So why not just use the iter?
> 
> Nothing of the above needs kernel code.

Feasibility isn't in question. The question is whether we want every
prog writer to reinvent this traversal plumbing, or let the kernel do
what iterators are designed for.

> v3 is +474 -83 lines on the kernel side. The diff I sent is +55 -1
> and it doesn't touch the debugfs path.
> 

That diff includes my improvements to the page_owner infrastructure, so
the line count doesn't really establish that bpf_for is better than
iter. The iter approach only adds an exit on the debugfs path — thin
shells over the single page_owner_next_eligible() extracted from
read_page_owner(). It changes no logic on the debugfs path (aside from
the mem-hotplug locking fix, which addresses a pre-existing bug in the
debugfs interface).

And the fact that the bpf_for approach doesn't touch the debugfs path
is, if anything, a disadvantage: it means two sets of eligibility rules
would have to be maintained going forward.

With the iter approach, any future change only needs to be made in
page_owner_next_eligible().



Thanks,
Zhen

