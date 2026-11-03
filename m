Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711683;
	b=0cVz3+R3TwppfUUpYf+slb1qBxzxTQ2P5ysesb8Sl/wtENuq4mJ9GhKkfzU4Kb+2tEhb
	 uh9jGopP4FL2qxXP6fUoIQo/QCR4Zhp3RjSHgKJvG92/ShSaqTPJ7o6FTsCJKCUI64hp+
	 WNTv6CWBPbOvE5yTTR3u/1IHznUtIoKgAwAVgM7cC7wqTXBp3pssSfWNwoCNZ/Oq3cTwg
	 TvN+zPCARifyPfyq++8I1HILfGxSbyPaH1mM2LlRSRXf7CdLEU6yYKHM5EOTuOggcKeZR
	 NMzI/fay/fQOjVP3fUHGXuenwcPg8fa3v4Mm6PKh8DGEVxz8lG+4hFcknk+qdbCYfsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711683;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rVMu4rtivE+4uT+wryolWoG5P/tne9KaZkuGtzcKWPs=;
	b=vVGMMpOyXISGDxAvRd+6weDSZXA5XXSvWbXgWcnOw1qumAlp2/oVyZacdsw0O1EUPKX3
	 GLk07KAcIc2ySTpG0v2kPBjQoDz57LAdt7c/cThAEEPNKyZR76SeOU/9vIL7WXTHy4xXI
	 QZdvzK4iLe3ZU4UTXZmVMgAq8JL9p4bErWO9tt+LqkKIPeZLZWuTSQJKz14NBVFtihUB3
	 IRvD1LHWQ8y0d2KqcI3falIfVx63tXFbeHbjFo3kiIxQsEsO/xE+9pyBOsA7z7aUCdLJv
	 AYwyi4N46ZBritUslWLC+GFpGAbD3dw8JuWbgVvNsdd6rr8Gwqkk3NzwxuI8T7aAm/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aerYH+HI;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1481606A324;
	Tue,  3 Nov 2026 13:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1481606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aerYH+HI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=rVMu4rtivE+4uT+wryolWoG5P/tne9KaZkuGtzcKWPs=; t=1793711681; x=2109071681; 
	b=aerYH+HIKE6hoEYy253iqS7vKie5T5ZZBBTXtHO+JGU/H7IVAimBuCnVNtTbkgf/Nej6OLhEVOk
	Yaz42wAC2TkkC2mLw0XMhJS7C7y0mhxmt2AK/S6sc/XipKjS70tVk+ciGHdq5ufxaEFr66s39FR0o
	SKZUVS7Adm7Dkqik9PSAzCHrzU9GHUt3/0ZXKDleGjl7C5coX4h7gozjzhrUz/2bJYLF+Zq1EL6Qv
	NeJxOhXDgOUhfbV5aI++wtGn9aw3oEE7bGRHhpV6r6FmuB1hWjhVE6QTZmlVtQF+Axx5NjLsLzdI/
	FRlv6Fmsyejf0xvXX0WiT0ozV3JWhWanNzbg==;
Received: from [58.29.145.179] (helo=[192.168.8.237])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOELH-001F30-R0; Tue, 03 Nov 2026 14:14:24 +0100
Message-ID: <bcf2e1c2-bc97-4d8e-a690-a1836a371033@igalia.com>
Date: Tue, 3 Nov 2026 22:14:15 +0900
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
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: libarena: Cache the rbtree's
 leftmost node and count
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, david.dai@linux.dev,
 Gavin Guo <gavinguo@igalia.com>, bpf@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20261028060046.549097-1-changwoo@igalia.com>
 <20261028060046.549097-3-changwoo@igalia.com>
 <DMJGWV96Y5SV.33OTYFHFZQ1WT@gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <DMJGWV96Y5SV.33OTYFHFZQ1WT@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexei,

Thanks for the review.

On 11/1/26 10:03 AM, Alexei Starovoitov wrote:
> On Tue, Oct 27, 2026 at 11:00 PM Changwoo Min <changwoo@igalia.com> wrote:
>>   struct rbtree {
>> +	/* Writer fields, on a cache line of their own. */
>>   	struct rbnode __arena *root;
>>   	enum rbtree_alloc alloc;
>>   	enum rbtree_insert_mode insert;
>> +
>> +	/*
>> +	 * The leftmost node and the node count on their own cache line.
>> +	 * The writer keeps them current, and readers may read them without
>> +	 * the writer's lock (see rb_first() and friends).
>> +	 */
>> +	struct {
>> +		struct rbnode __arena *first;
>> +		uint64_t nr;
>> +	} __attribute__((aligned(RB_CACHELINE_SIZE)));
>>   };
> 
> That's 16 -> 128 bytes.
> Without perf numbers it's a premature optimization.

You are right. I ran a scheduler-side task queue built on this rbtree
(based on scx_lavd replacing its DSQs) on a 2-socket, 192-CPU EPYC
machine (no hyperthreading) to compare the aligned vs. unaligned
versions. The following are the results of the 10 runs.

                                     aligned        unaligned
   perf bench sched messaging (s)    0.51 +- 0.01   0.50 +- 0.01
   perf bench sched pipe (us/op)     3.18 +- 0.04   3.19 +- 0.04
   schbench full, wakeup p99 (us)    78.3 +- 5.7    79.5 +- 3.6
   schbench full, RPS                44941 +- 124   44954 +- 86
   schbench 2x over, RPS             45146 +- 101   45133 +- 141

There are no statistically meaningful differences so I will drop the
alignment in v2.

> 
>> +	ret = rbnode_remove(rbtree, node);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (was_first)
>> +		rb_set_first(rbtree, next);
> 
> In an RB_ALLOC tree rbnode_remove() frees the node and then rebalances
> the tree. first points to the freed node all that time:
> 
>    CPU 0, holds the lock            CPU 1, no lock
>    rb_pop()
>      rb_node_remove()
>        rbnode_remove()
>          rb_node_free(node)
>                                     rb_first_key()
>                                       first = rbtree->first
>                                       first->key    <- use after free
>          rebalance
>        rb_set_first(next)
> 
> buddy_free() poisons the node. A prog built with ASAN gets a report from
> rb_first_key().
> 
> rb_erase_cached() moves rb_leftmost before rb_erase().
> Should it be the same here?
> Move rb_next() from patch 3 in front of this patch. Then at the top of
> rb_node_remove():
> 
>    if (rbtree->first == node)
>            rb_set_first(rbtree, rb_next(node));
>    WRITE_ONCE(rbtree->nr, rbtree->nr - 1);
> 
> and no need for the wrapper, was_first and the rename to rbnode_remove().
> 

Sure, I will move rb_next() before this patch and update first and
nr at the top of rb_node_remove() in v2, as you suggested.

Regards,
Changwoo Min

> Patch 1 looks good.
> 
> pw-bot: cr

