Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8316FF4C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332402; cv=none; b=ZJr7HCGGq2uNgTBCljjt1kn1hhfe4WM+z0IYmh3NJh00tEy1YuiRwGspYAwgEJ6rS0/y9huOSVMjivNf0INFUGOz5llBNVy3C/pRWqpHtbUOFuraQKj13i4uJlYHgFqKLaQyv+yQq6XAGiPVu96fu0zD82Q6MzDxNgEZTCfg4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332402; c=relaxed/simple;
	bh=cgFgLDvXzVVBZx90EIohepeVJaMj4xdg03IMlJj/h5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qA+SKGAo8A2LZM6gPz7WqUpicIVwSLgsaNvZkcG7UQ3MDWFtoTiwadjoyhjj2NSo1M3Esto5K+nTUUAaMj8FjpU34d/SkeAmnxEkrEkd/bDmH0Fv45y3yRpFOh9TgK71d6+pHR+Nbb7cU0RoNZw5Vt7KFG7gM4xbiD0pmP78CJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bccwq6DA; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bccwq6DA"
Message-ID: <c9db2abb-2391-415b-ba71-db80dc42cc54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712332394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeFplG003BsPVqzbc/lEZ6wk0FP/62I+Mj9G6/iBL+g=;
	b=Bccwq6DAcFUssYepWmbFEL9Tyr5Svrw6ofGcRtNpGv340Tf0CxLQClZkrkC3URL8qp/oKW
	iZzynqToox34w2PIuN/NeVz/3HEzhRV7w62jbDuoGn8vEVnNH9p4h3vdA0FKfnDg4pOlpO
	+Np5lOv45Ugn51cea9mNlgmhmhWdI9o=
Date: Fri, 5 Apr 2024 08:53:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025310.2211688-1-yonghong.song@linux.dev>
 <66101695d69a7_5803020833@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <66101695d69a7_5803020833@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/5/24 8:19 AM, John Fastabend wrote:
> Yonghong Song wrote:
>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>> internal request to support bpf_link for sk_msg programs so user
>> space can have a uniform handling with bpf_link based libbpf
>> APIs. Using bpf_link based libbpf API also has a benefit which
>> makes system robust by decoupling prog life cycle and
>> attachment life cycle.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h            |   6 +
>>   include/linux/skmsg.h          |   4 +
>>   include/uapi/linux/bpf.h       |   5 +
>>   kernel/bpf/syscall.c           |   4 +
>>   net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
>>   tools/include/uapi/linux/bpf.h |   5 +
>>   6 files changed, 284 insertions(+), 8 deletions(-)
>>
> LGTM one question below.
>
>> +/* Handle the following two cases:
>> + * case 1: link != NULL, prog != NULL, old != NULL
>> + * case 2: link != NULL, prog != NULL, old == NULL
>> + */
>> +static int sock_map_link_update_prog(struct bpf_link *link,
>> +				     struct bpf_prog *prog,
>> +				     struct bpf_prog *old)
>> +{
>> +	const struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
>> +	struct bpf_prog **pprog;
>> +	struct bpf_link **plink;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&sockmap_mutex);
>> +
>> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. */
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
>> +	if (old) {
>> +		ret = psock_replace_prog(pprog, prog, old);
>> +		goto out;
>> +	}
>> +
>> +	psock_set_prog(pprog, prog);
>> +
>> +out:
>> +	if (!ret) {
>> +		bpf_prog_inc(prog);
>> +		old = xchg(&link->prog, prog);
>> +		bpf_prog_put(old);
> Need to check old? I don't think we can clal bpf_prog_put on null?
>
>    if (old)
>       bpf_prog_put(old)

The 'old' here represents the *old* link->prog program and
link->prog should not be NULL at this point.

If sock_map_link_update_prog() is called here, that means,
the kernel already holds a reference for the bpf link.
See kernel/bpf/syscall.c, link_update().

So the bpf_link is valid and not in released stage, and
link->prog should not be NULL.

>
>> +	}
>> +	mutex_unlock(&sockmap_mutex);
>> +	return ret;
>> +}
>> +
