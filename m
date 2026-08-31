Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D183D667F;
	Mon, 31 Aug 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166813; cv=none; b=sLuVLJ8iiZI0OgHmPhK43V6KTTSJbxLre/6Qoix5+ERuEuofwMjCRjbuLttAmqCGJP9Z9aaCbjTc6+oOmqpmzfAbUrCTxx7iTX9v3TGagLv6zyD2yCw9adhqmgiOBY/mHl66NIXID2w6LL3HItgp9CxwblBK8Ry86ieFa9OrYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166813; c=relaxed/simple;
	bh=bO4QqOOkYtcqxtmXnzXLiG88iM1bk1BhGu3NaERD5H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCWq/wwhXMEldrrz+Z30oE1e7gQKBkzhb+5paIGBNRYu3IjXS3xXGlngZFjjMJdMVacbknQS34PqKbPfhYuOeHxNmiSfWDGSGkfPpId2A9tpTdzIFYIonWT/d1LIND6cX5sqAt3D4epaKYCKVH9tVD3aqCdj9+LvFRPQTDFuQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkZDhChP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkZDhChP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DFB1F000E9;
	Mon, 31 Aug 2026 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788166810;
	bh=LXOCjeN/czsMupSRW8p+erDIOXzY4m9iU1fz8tbYeI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YkZDhChPm6So6Rc3TWcjOsLI51gc3n9liJ8g7iVVhapP7IQsoV9QsW9r8RN0kCQ/y
	 m+ZK+N8kedI7ezw6LepHoGh9S53O928OYbM4hVS4mVgO30eTCn6w3aeJlI+nPWQpBD
	 Hd283Hy7YUBkxKrX7fuFlvNginf47ciY3GXZLm/Zz5gKCW6l5RVvSSQSD4GAXpnfHR
	 JS5m3CZ6hrMRRp4/eCYlFqyJcUOnJtU51Mm/yc65Lc7wkHQIpbtBJYPde/jbvXKl+m
	 YZBNE0obQ4+r2pVVQD0kaiLCcqbX+F5pBBH1Jw0tMgf6MCcNyMef8sbk3+wR3G6zrA
	 FRDdiMo+4vi6w==
Message-ID: <8c7f834e-5701-4748-9a9a-fed78aa50198@kernel.org>
Date: Mon, 31 Aug 2026 11:00:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized
 requests
To: Florian Schauer <florian@schauer.to>, ilias.apalodimas@linaro.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 linyunsheng@huawei.com, Mina Almasry <almasrymina@google.com>
References: <20260828060822.2628276-1-florian@schauer.to>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260828060822.2628276-1-florian@schauer.to>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/08/2026 08.08, Florian Schauer wrote:
> page_pool_alloc_frag_netmem() rounds the requested fragment size with
> 
> 	size = ALIGN(size, dma_get_cache_alignment());
> 
> dma_get_cache_alignment() returns 1 unless the architecture defines
> ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
> There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
> unrounded size.
> 
> A single caller asking for an odd size then leaves frag_offset misaligned
> for every fragment carved out of that page afterwards.  The pool is shared,
> so the damage is not confined to the caller that caused it.
> 
> The per-cpu system_page_pool used by generic XDP hits this.
> skb_pp_cow_data() allocates its fragments with the raw packet length:
> 
> 	size = min_t(u32, len, PAGE_SIZE);
> 	truesize = size;
> 	page = page_pool_dev_alloc(pool, &page_off, &truesize);
> 
> leaving frag_offset odd for whatever is carved out of that page next.  Its
> own head allocation is already aligned -- SKB_HEAD_ALIGN(size) plus the
> XDP_PACKET_HEADROOM its callers pass -- so it is a later user of the shared
> pool that pays: page_pool_dev_alloc_va() returns a misaligned buffer,
> napi_build_skb() installs it as skb->head, and skb_shinfo(skb) ==
> skb->head + skb->end is misaligned with it.
> 
> skb_shinfo()->dataref is a 4-byte atomic_t at offset 0x20, so the
> atomic_inc() in __skb_clone() straddles a cache line.  On x86 with split
> lock detection -- fatal for kernel split locks by default -- this panics
> the machine:
> 
>    Oops: Split lock detected
>    RIP: 0010:skb_clone+0x154/0x1e0
>    Call Trace:
>     <IRQ>
>     raw_local_deliver+0x1ed/0x2c0
>     ip_protocol_deliver_rcu+0x54/0x1c0
>     ip_local_deliver_finish+0x85/0x100
>     ip_local_deliver+0x67/0x100
>     __netif_receive_skb_one_core+0x85/0xa0
>     process_backlog+0x87/0x130
> 
> Reproduced by attaching any generic-mode XDP program to loopback and
> opening a RAW IPPROTO_UDP socket, which makes raw_local_deliver() clone
> every locally delivered UDP packet; ordinary DNS traffic then triggers it,
> roughly once per 2500 clones.  Observed on 6.12.101 and 7.1.8.
> 
> Tracing page_pool_alloc_frag_netmem() over one such run shows the
> amplification -- two odd-sized requests, nine misaligned offsets:
> 
>    requested size & 7:   0: 17035    5: 1    7: 1
>    frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7: 5
> 
> and skb_pp_cow_data() returning heads that were aligned on entry:
> 
>    head 0xffff8f4c86aeac00 -> 0xffff8f4c53a9a9c4 (&7=4)
>    head 0xffff8f4d6a8a42c0 -> 0xffff8f4c4f7b7a45 (&7=5)
> 
> Round the fragment size up to at least the alignment struct skb_shared_info
> requires, so fragments are always suitably aligned for the objects callers
> build on them.  Architectures needing a larger DMA alignment keep it.
> 
> This also makes the remainder computed in page_pool_alloc_netmem(),
> 
> 	*size = max_size - *offset;
> 
> aligned, since max_size is a power of two -- which fixes the matching
> misalignment of skb->end.
> 
> Verified with a controlled A/B under QEMU/KVM: same tree, same config,
> same compiler, same rootfs and identical traffic, differing only by this
> patch.  A SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams
> larger than max_head_size drives skb_pp_cow_data()'s fragment loop, which
> passes raw packet lengths to the pool.  Measured at the return of
> skb_pp_cow_data():
> 
>                            unpatched   patched
>    skb_pp_cow_data calls       40800     40800
>    misaligned skb->head         1120         0
>    dataref at line offset >60     80         0
> 
> The last row counts the accesses that actually fault:
> skb_shinfo()->dataref sits at head+end+0x20 and is a 4-byte atomic, so
> `lock incl` splits a 64-byte cache line only when that address lands at
> offset 61..63.  All 80 occurrences were at offset 61; the panic reported
> above was at offset 62.  Eliminating the misalignment removes every one
> of them.
> 
> Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
> fragments that are not skb aligned"), which fixed the older
> netdev_alloc_frag()/napi_alloc_frag() allocators.
> 
> Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in page pool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Florian Schauer <florian@schauer.to>
> ---
> v2:
>    - express the minimum alignment as __alignof__(struct skb_shared_info)
>      instead of sizeof(long), and drop the explanatory comment the previous
>      version carried, since the expression now states the requirement
>      directly (Eric Dumazet)
>    - no functional change vs v1 on 64-bit: the emitted code is identical
>    - Cc the maintainers and the blamed author that v1 missed
>    - correct two statements in the commit message: dataref is at offset 0x20
>      in struct skb_shared_info, not its first member, and skb_pp_cow_data()
>      allocates its head before the fragment loop, so the misaligned head
>      comes from an earlier user of the shared pool
> v1: https://lore.kernel.org/netdev/20260826135252.3091193-1-florian@schauer.to/
> 
>   net/core/page_pool.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8f8956fb0..08d7f35cf 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1073,7 +1073,8 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>   	if (WARN_ON(size > max_size))
>   		return 0;
>   
> -	size = ALIGN(size, dma_get_cache_alignment());
> +	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
> +				 __alignof__(struct skb_shared_info)));
>   	*offset = pool->frag_offset;
>   
>   	if (netmem && *offset + size > max_size) {

On x86_64 __alignof__(struct skb_shared_info) returns 8. So, this should 
work, to avoid getting the lock in skb_shared_info split across cache-lines.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks for finding and fixing this bug!
--Jesper

