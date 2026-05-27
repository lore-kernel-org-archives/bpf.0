Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346036897F
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872570; cv=none; b=gyIr/Bm5TEojOWVjOpxwXB6DugXy1tHZoKuLIWu8cypbNFnqJCsuFpCEPO0G83bL5hb49x+TjKqOUfpic5kiPQ8h9VhVNMtZiaGgnylMkzB/upt09wHbKbrbuoXwqK1JXrNth5M0ITw+8o5eQsMEOsLKWWMg6ZD1PdIpU/jpASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872570; c=relaxed/simple;
	bh=xYR8xUC4ltsK0Hbb7ylY58KBSpG5vgwr6CYvDlM0aEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anugf53vxWn9JhEE8vM4PZod64RgTDtL7k9DAmOfwppAjQm6PZJq3Tun/CF73t21gP/4npdp7kCKOiKMoX7zfSFgCPHep+Nl8kidDKFd7l9EBJPXWJsj11cGi5ImgFZc76IbH4+6pTariFVG8FB9O2Xhchpp1d6AGaD5oo2zPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rj08pxqc; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rj08pxqc"
Message-ID: <68d25e1a-8c04-4344-afbd-8578e539a35c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779872556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+z9Je0o/BScThsTMbGA8H22c+5TSX4Tol/7A2GUp2s=;
	b=rj08pxqc6zYUZumNtB4CDNkq1Skz2YqEdcnZ6qOrjLRzqT5svoxtF5jDZOhz+TumyZxayF
	hiQTZTGbYN5RQAo5ZkoBo7U51q5iIocKLopqHmWmt8XVbbrkf5goD4bjNcAki7TVHnlVdZ
	kFfEBfvkHtgavzOwBjKOuIQ7c/fXTzM=
Date: Wed, 27 May 2026 17:01:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] bpf: Use hlist_nulls_replace_rcu() when
 updating htab elements
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 luoxuanqiang@kylinos.cn, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260527070139.223386-1-xuanqiang.luo@linux.dev>
 <de6652ce9d1367daf217fcb5793419db9d967757b7b7857b00ae1c0c008f46ec@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <de6652ce9d1367daf217fcb5793419db9d967757b7b7857b00ae1c0c008f46ec@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/5/27 16:06, bot+bpf-ci@kernel.org 写道:
>>      bpf: Use hlist_nulls_replace_rcu() when updating htab elements
>>
>>      When updating an existing element, the current code does
>>      hlist_nulls_add_head_rcu() followed by hlist_nulls_del_rcu(), exposing
>>      a transient state where both old and new elements are visible to
>>      concurrent RCU traversals.
>>
>>      Use hlist_nulls_replace_rcu() to atomically replace the old element in
>>      place, so RCU readers always see a consistent hash chain.
>>
>>      Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> This looks like a bug fix that should include:
>
>    Fixes: 4fe8435909fd ("bpf: convert htab map to hlist_nulls")
>
> The bug was introduced by commit 4fe8435909fd which added the
> hlist_nulls_add_head_rcu() followed by hlist_nulls_del_rcu() pattern,
> exposing a transient state where both old and new elements are visible
> to concurrent RCU traversals.
>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 3dd9b4924ae4..b20e82bd253d 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1246,18 +1246,16 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>   		goto err;
>>   	}
>>
>> -	/* add new element to the head of the list, so that
>> -	 * concurrent search will find it before old elem
>> -	 */
>> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>   	if (l_old) {
>> -		hlist_nulls_del_rcu(&l_old->hash_node);
>> +		hlist_nulls_replace_rcu(&l_old->hash_node, &l_new->hash_node);
>>
>>   		/* l_old has already been stashed in htab->extra_elems, free
>>   		 * its special fields before it is available for reuse.
>>   		 */
>>   		if (htab_is_prealloc(htab))
>>   			check_and_free_fields(htab, l_old);
>> +	} else {
>> +		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>>   	}
> Does this atomic replacement approach actually solve the lookup problem?
>
> During review of Hou Tao's earlier v1 patch that used the same approach,
> Alexei Starovoitov raised a fundamental concern:
>
>    "This atomic replacement doesn't really solve anything. lookup will see
>     one element. That element could be deleted by another thread. bucket
>     lock and either two step update or single step don't change anything
>     from the pov of bpf prog doing lookup."
>
> Reference: https://lore.kernel.org/bpf/CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com/
>
> Hou Tao acknowledged this limitation and abandoned this approach in v2,
> instead implementing atomic updates only for htab of maps. This patch
> appears to be a re-implementation of the abandoned v1 approach without
> addressing the fundamental concerns raised during that review.
>
> Can you clarify how this approach addresses the concerns that led to
> abandonment of the similar change in Hou Tao's earlier patch series?
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26496972451
I read the earlier discussion and realized I missed it, and I also missed
Hou Tao's updated patch 2c304172e0319 ("bpf: Support atomic update for htab
of maps") which already addressed this.

Sorry, My patch is outdated, please ignore it.

Thanks.
