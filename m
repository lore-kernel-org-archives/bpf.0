Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C3645
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102790; cv=none; b=TkzhnceCPhHsCZEOoyjMWIRePIZS8qigG6VP7eo/VAtguNXWKK+a8HVoiNE5QsUtOJGgQJzGeFTfqiFEWYgRIFXJxWMp6mMZJMrKnXkUHAJ4PFCO7pVa8FDvtt+7GKT08F0YcOGjtvZw9H6DAkXz7ag46pzwRXuPHSzO3bUx2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102790; c=relaxed/simple;
	bh=064aKD17nDHYc+3StPMn8f/xLKSQh+T4+JV/Jod9SCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmm1lJg5SBo9e/2/efKAUgR8DLiZxAUmrvbb1DtxFjbsxE2zKd6seYCK5k7rO0+wBU5zRNgcrTuXW4+mgSodpudmBpqWNMyBCEQvIyKX10YzHoiiWwOh9c63kYw9DlCxTQIwaCjFFkKnLBETGu6/f22FSfHCMdsknMQNmi2gL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nn/XN6Dt; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nn/XN6Dt"
Message-ID: <194066ca-4c5f-40d2-9f95-f32588fbe110@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712102785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsGMgMQ8TpMRucWvjVYHpFLkCE6I3PenF6EXQy367Ss=;
	b=Nn/XN6Dtyh61I7b+tghzpkbT1NwH3u7g+eXK4CqgCUZziXpOxS1yxEGcTHrgGnD1mvkPZq
	0Sdf8UB0L3vjiSPo/AJXcALuQ+VZSt9ZIyAFbSdq4fpu4dZHOTkbvMXQrAec0SSXR5LZE1
	EIjPVAEdD3cb/3Q7tlzWHA701D+Pxl0=
Date: Tue, 2 Apr 2024 17:06:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <2147f20b0375cb8c45ef4d55f108817409aa19fc.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2147f20b0375cb8c45ef4d55f108817409aa19fc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/2/24 10:39 AM, Eduard Zingerman wrote:
> On Mon, 2024-03-25 at 19:21 -0700, Yonghong Song wrote:
> [...]
>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 27d733c0f65e..dafc9aa6e192 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
> [...]
>
>> @@ -1488,21 +1492,90 @@ static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
>>   	return 0;
>>   }
>>   
>> +static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***plink,
>> +				struct bpf_link *link, bool skip_check, u32 which)
>> +{
>> +	struct sk_psock_progs *progs = sock_map_progs(map);
>> +
>> +	switch (which) {
>> +	case BPF_SK_MSG_VERDICT:
>> +		if (!skip_check &&
>> +		    ((!link && progs->msg_parser_link) ||
>> +		     (link && link != progs->msg_parser_link)))
>> +			return -EBUSY;
> These checks seem a bit repetitive, maybe factor it out as a single
> check at the end of the function? E.g.:
>
> 	if (!skip_check &&
> 	    ((!link && **plink) || (link && link != **plink)))
> 		return -EBUSY;
>
> Or inline these checks at call sites for sock_map_link_lookup()?
> I tried this on top of this in [1] and all tests seem to pass.

Andrii has a suggestion to do
	plink = progs->msg_parser_link;

and later plink can be used for checking. This indeed makes things easier.

>
> [1] https://gist.github.com/eddyz87/38d832b3f1fc74120598d3480bc16ae1
>
>> +		*plink = &progs->msg_parser_link;
>> +		break;
>> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> +	case BPF_SK_SKB_STREAM_PARSER:
>> +		if (!skip_check &&
>> +		    ((!link && progs->stream_parser_link) ||
>> +		     (link && link != progs->stream_parser_link)))
>> +			return -EBUSY;
>> +		*plink = &progs->stream_parser_link;
>> +		break;
>> +#endif
>> +	case BPF_SK_SKB_STREAM_VERDICT:
>> +		if (!skip_check &&
>> +		    ((!link && progs->stream_verdict_link) ||
>> +		     (link && link != progs->stream_verdict_link)))
>> +			return -EBUSY;
>> +		*plink = &progs->stream_verdict_link;
>> +		break;
>> +	case BPF_SK_SKB_VERDICT:
>> +		if (!skip_check &&
>> +		    ((!link && progs->skb_verdict_link) ||
>> +		     (link && link != progs->skb_verdict_link)))
>> +			return -EBUSY;
>> +		*plink = &progs->skb_verdict_link;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
> [...]
>
>> +/* Handle the following two cases:
>> + * case 1: link != NULL, prog != NULL, old != NULL
>> + * case 2: link != NULL, prog != NULL, old == NULL
>> + */
>> +static int sock_map_link_update_prog(struct bpf_link *link,
>> +				     struct bpf_prog *prog,
>> +				     struct bpf_prog *old)
>> +{
>> +	const struct sockmap_link *sockmap_link = get_sockmap_link(link);
>> +	struct bpf_prog **pprog;
>> +	struct bpf_link **plink;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&sockmap_prog_update_mutex);
>> +
>> +	/* If old prog not NULL, ensure old prog the same as link->prog. */
>> +	if (old && link->prog != old) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
>> +	if (link->prog->type != prog->type ||
>> +	    link->prog->expected_attach_type != prog->expected_attach_type) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = sock_map_prog_lookup(sockmap_link->map, &pprog,
>> +				   sockmap_link->attach_type);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* Ensure the same link between the one in map and the passed-in. */
>> +	ret = sock_map_link_lookup(sockmap_link->map, &plink, link, false,
>> +				   sockmap_link->attach_type);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (old)
>> +		return psock_replace_prog(pprog, prog, old);
> should this be 'goto out' in order to unlock the mutex?

Good point. I missed a test case with non-NULL old. Will add in the next revision.

>
>> +
>> +	psock_set_prog(pprog, prog);
>> +
>> +out:
>> +	if (!ret)
>> +		bpf_prog_inc(prog);
>> +	mutex_unlock(&sockmap_prog_update_mutex);
>> +	return ret;
>> +}
> [...]
