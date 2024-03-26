Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC541757E
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471817; cv=none; b=EvGgeNPTUHW9lTUGekX9R49GHhMt+yVb74df+NSri+XEtawmGn6TeFzzuLaosaL0HL4erdjCGEgFGKDkDNopvBGe0kZbk7K5Wdi9b3GVVaXA2rqt2d2TZmRIq3NTyN1RKkIYzh16VbLI4bfwos0+eqvwYKJKAhavvA/BBExGZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471817; c=relaxed/simple;
	bh=oz91KLR3InY2otPSc4fugsk5S6zIzzjBvH4W4UYoJ+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aW2D+ygz7g/lsdlk0SfJo5L680uMhmCZ6bsYL8Y3MaB+i51Oa58xygDoUdoQ+d8ye0dGFCdEebfxqd3INddS4Uwu8HJvI2iy/3DlcuGiesyfVSZr1getSuI7Tb0V7AGZEN9eWBbxxQZ3HKRGf2XHDmpN///dgsBxYtlFmTQuHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6cU8xVa; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6cU8xVa"
Message-ID: <8caa200a-f8a4-4381-9269-da706a22f990@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711471813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/C+TzMhOkTBoEAO1fpdy1XhD3mMH6NQM4Ny/kWaduw=;
	b=O6cU8xVa5n4qDivbt95Wed8HaDFss5oT1AZ7nbu+hAEPxq2HhM38NTujHifr+vVUPWHDAr
	cvhsVnf1RP7rdzaCmFON6uiG3bNuu4E8DhjJTtDWqyEcrPcCQ3E4RGuUYARCISm5RpcYtK
	Ocj2UXxy0WjSk1rVUaW8x5ocE6DfqCo=
Date: Tue, 26 Mar 2024 09:50:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Mitigate latency spikes associated with
 freeing non-preallocated htab
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20240326081207.73375-1-laoar.shao@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240326081207.73375-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/26/24 1:12 AM, Yafang Shao wrote:
> Following the recent upgrade of one of our BPF programs, we encountered
> significant latency spikes affecting other applications running on the same
> host. After thorough investigation, we identified that these spikes were
> primarily caused by the prolonged duration required to free a
> non-preallocated htab with approximately 2 million keys.
>
> Notably, our kernel configuration lacks the presence of CONFIG_PREEMPT. In
> scenarios where kernel execution extends excessively, other threads might
> be starved of CPU time, resulting in latency issues across the system. To
> mitigate this, we've adopted a proactive approach by incorporating
> cond_resched() calls within the kernel code. This ensures that during
> lengthy kernel operations, the scheduler is invoked periodically to provide
> opportunities for other threads to execute.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   kernel/bpf/hashtab.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3a088a5349bc..d3d5aad045cc 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1489,6 +1489,7 @@ static void delete_all_elements(struct bpf_htab *htab)
>   		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>   			hlist_nulls_del_rcu(&l->hash_node);
>   			htab_elem_free(htab, l);
> +			cond_resched();
>   		}

should we put cond_resched() here inside the top 'for' loop, but outside
the bucket loop? Do you really have a long link list for a particular bucket?
Otherwise, the patch looks good to me. In hashtab.c, we have cond_resched()
in some other places to mitigate similar issues.

>   	}
>   	migrate_enable();
