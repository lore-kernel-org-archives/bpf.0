Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E917301465;
	Wed, 10 Jun 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056435; cv=none; b=B0DktUxysI681OgUEGZdMY41THC/4SWgAYFHgZl1xR4quCfyU2Yg1DuV0uacduYPLqNioXWSjQ702je6zxbLgQgVa9rUZxFdnVEAAvOnRl1aXpqYIU6qXiwc9uCq+VIIpm/R4A+46TOtkIRpt/TF21sslV68jWiCFauug9XEJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056435; c=relaxed/simple;
	bh=/Cej49nkRYnPIh/1e8cMQohr7oye8s2LEamEQrtkaWg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=a06new/50YfBL4GFAhyarEJ8W8SbtjJC0SN8sltWj9jL90YVRpH6KpS4krLr+aTUPGXxhAb8aCUKkEWPN1vBEc10fHa9OB0v7c+hc5YcW2OcMRxG+f9qG6l95nbCH61Pj5H2hNd2FYf8qbGyHmj7soe2Ap7J9xMI0nSu9tZxu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZphQ5K7hzKHMVg;
	Wed, 10 Jun 2026 09:53:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 21CF04058D;
	Wed, 10 Jun 2026 09:53:47 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
	by APP1 (Coremail) with SMTP id cCh0CgDn6D2nwyhqQv_9BA--.30185S2;
	Wed, 10 Jun 2026 09:53:46 +0800 (CST)
Subject: Re: [PATCH bpf v2 2/2] bpf, lpm_trie: Allow sleepable programs to use
 LPM trie maps directly
To: Vlad Poenaru <vlad.wing@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?=
 <toke@redhat.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
 <20260609135558.193287-3-vlad.wing@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ca38cbe4-dbc0-dc28-d7c5-07c0566348fc@huaweicloud.com>
Date: Wed, 10 Jun 2026 09:53:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609135558.193287-3-vlad.wing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDn6D2nwyhqQv_9BA--.30185S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4rZFykXFy8WFW8Jw1kKrg_yoW5GFWfpF
	y0gFWDtF1kZryIgr9Fvayxua4rtrZ7Kr47WFZ5t3yUAr1a9r9xWryfG3W7ZF9I9rWkJw4j
	vr4Y93s2qw48ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/9/2026 9:55 PM, Vlad Poenaru wrote:
> The previous change relaxed the rcu_dereference annotations in
> lpm_trie.c so the trie walks no longer trip lockdep when reached from a
> sleepable BPF program holding only rcu_read_lock_trace().  By itself
> that only helps tries reached as the inner map of a map-of-maps, or
> from the classic-RCU syscall path: a sleepable program that references
> an LPM trie directly is still rejected at load time by
> check_map_prog_compatibility(), whose sleepable whitelist omits
> BPF_MAP_TYPE_LPM_TRIE:
>
>   Sleepable programs can only use array, hash, ringbuf and local storage maps
>
> LPM trie nodes are allocated from a bpf_mem_alloc (trie->ma) and freed
> with bpf_mem_cache_free_rcu(), which chains a regular RCU grace period
> into a Tasks Trace grace period before the node -- and the value
> embedded in it that trie_lookup_elem() returns to the program -- is
> released.  That is the same reclaim discipline BPF_MAP_TYPE_HASH relies
> on for sleepable access, so a value handed to a sleepable reader cannot
> be freed while the program is still running under rcu_read_lock_trace().
> The writer paths take trie->lock across the walk and never relied on the
> RCU read-side lock to keep nodes alive.

For trie_lookup_elem(), I think it is not safe to enable the usage in
the sleep-able program as the patch does and it may return unexpected
value. The main reason is that rcu_read_lock_trace() can not guarantee
the current node which is being lookup-ed up will not reused by other
update procedure concurrently. However rcu_read_lock() has such
guarantee, because bpf_mem_cache_free_rcu() makes it be reusable only
after one RCU grace. For the hash-table case, I think it has the similar
problem through it has already used some trickle (hlist_nulls_node
variants) to mitigate it.
>
> Add BPF_MAP_TYPE_LPM_TRIE to the sleepable map whitelist so these
> programs can use LPM tries directly.
>
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..71c1e59e4df4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18122,6 +18122,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		case BPF_MAP_TYPE_PERCPU_HASH:
>  		case BPF_MAP_TYPE_PERCPU_ARRAY:
>  		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +		case BPF_MAP_TYPE_LPM_TRIE:
>  		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>  		case BPF_MAP_TYPE_HASH_OF_MAPS:
>  		case BPF_MAP_TYPE_RINGBUF:

