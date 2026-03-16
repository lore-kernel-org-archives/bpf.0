Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C3139D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694227; cv=none; b=oUSjF+LlYLGcp0OGUO35rFjluxxbSb7OxCXsPJnVVt/cKDVyt981BFxmiR3x9JzRWQBLYclh6PyDqKKcwpZi0dbnW58UJhLupI6sdUrsY2P9m0RHrbW7eezUjZbewSgHG7QEmtORHOG3ekzdRQdYGwwlKJxtdDAOWc1SaRQM/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694227; c=relaxed/simple;
	bh=zYVFEFg9tRM4q5S10P2V1xrJq4tgElTDaCOdwOkk87s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZfr1RSKtvTh+fUFzv3MzmWFEB8n7f2WaHXmPQt3DJx12OEcGsLR1hO024Ij8m1gN5qXA2a+gPGDfMFeaJJuph5bg+GU9eqTR0kp29T3OYVeOamUTpzbbcOpP5cIk9VfsMqS2kt2L0MCc6HDBU1xyL4CAg8MnmbSVRa/L6CYoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JHvL56Zr; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JHvL56Zr"
Message-ID: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773694223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wgi0fxrDZ7QH87/rg2YOgz25DTDAqEq1Sx1ntVpkOCo=;
	b=JHvL56Zrb5stliaQAfJnHd4W/Qisxlwnqv6VfX378Qsr7GI5abPo/zXQrYpqbxDV4/qi2K
	gP3gKOUQRHMTbBUJ0F15H1+huqWfNkJykGa92iQsdww/uQaFNuoQUVBhIX3PGSGCCFqARs
	BPXiQEWwyY3PtBGg5Im6gUeHTSy97lE=
Date: Mon, 16 Mar 2026 13:50:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
To: xulang <xulang@uniontech.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, dzm91@hust.edu.cn, eddyz87@gmail.com,
 haoluo@google.com, huyinhao@hust.edu.cn, john.fastabend@gmail.com,
 jolsa@kernel.org, kaiyanm@hust.edu.cn, kernel@uniontech.com,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, paul.chaignon@gmail.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev,
 ihor.solodrai@linux.dev
References: <db2e04a2-3cf4-40f3-85ef-14197148d027@linux.dev>
 <D3B60D7890B13875+reply-to-v1-review@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <D3B60D7890B13875+reply-to-v1-review@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/16/26 6:51 AM, xulang wrote:
> From: Lang Xu <xulang@uniontech.com>
> 
>> Please create a selftest for this.
> 
> Going to do that. To stably reproduce this bug, I need the KASAN
> config enabled, how do I ensure it's enabled during a selftest cycle,
> by adding the line below to the 'config'? not quite sure.
> 
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -46,6 +46,7 @@ CONFIG_IPV6_GRE=y
>   CONFIG_IPV6_SEG6_BPF=y
>   CONFIG_IPV6_SIT=y
>   CONFIG_IPV6_TUNNEL=y
> +CONFIG_KASAN=y

I would leave out this config change from this fix for now. cc: Ihor to 
consider enabling it for bpf-next.

It is still useful to have a selftest for this case. I always have KASAN 
turned on when running selftests.


>> This is fixing the src side of the "copy_map_value_long(map, dst, src)".
>> The src could also be from a skb? What is the value_size that the
>> verifier is checking for bpf_map_update_elem?
> 
> The value_size checked by verifier is exactly the size with which
> the map is defined, i.e., not the size rounded up to 8-byte by kernel

If the verifier ensures only 4-bytes, I am not sure if the helper should 
read 8-bytes.

> 
> As for bpf_map_update_elem->..->copy_map_value_long, 'src' couldn't be from
> 'skb' which mismatches the expected ptr-type of 'bpf_map_update_elem',
> I've tried codes like these:
> 
> 1. bpf_map_update_elem(&lru_map, &key, skb, BPF_ANY);
> 2. bpf_map_update_elem(&lru_map, &key, skb->sk, BPF_ANY);  // null checked
> 3. bpf_map_update_elem(&lru_map, &key, skb->flow_keys, BPF_ANY);
> 
> All these ptrs mismatch the expected ptr-type, which can be detected by the verifier.
> The verifier complains with msg like 'R3 type=ctx expected=fp, pkt, pkt_meta, map_key,
> map_value, mem, ringbuf_mem, buf, trusted_ptr'

I meant the __sk_buff->data. Take a look at how skb->data can be used in 
the selftests. __sk_buff->data may not have readable bytes rounded up to 
8. Just one example that the src cannot always be fixed by allocating more.

 From looking at git history on pcpu_init_value, the issue should be 
introduced in commit d3bec0138bfb.

