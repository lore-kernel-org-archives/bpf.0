Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406940FDA0
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889229; cv=none; b=P8+cpy7OhqTB2EilqmeInqF1jSNjc6piRtd0rmiiKjoN9AQinnnrwt9LXXGdu45QKJsBgHRFu1+/vgTCHpzqa7qfkTtXlT+L9Ar6AWZyltHUXjwOWqqkVLb0wd+lYw/AnOjLy+UXHqHYkA82mta/uAz5xhMR6h7ox6sgZHGnsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889229; c=relaxed/simple;
	bh=4y4QgCoRHl/XbNNHFWoUG6Jk1c4SrRJELRY6yMuoQto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7FRm77yh/8O6U1iswp32zKRADTS4muoClkcaZihfBNYFP6VAdh6TxOqjzxtWt75wltu28Zt1FGXYbH1SJdLV0/4xkl/wHe9qCRLeKrCIO+sV6LvjgitOyPTD1jydSqiMFRnNGpiYDg3u7peVQAOnjOB2NCpJzgIcqqVc4bRyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xIDiVKTp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xIDiVKTp"
Message-ID: <f28e47a3-11fd-4fc1-b248-4c1c8d0902e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779889210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o26FiG9LwWkhm40vFk2d8rsPg/9WBqQi2cx+mYZDvPw=;
	b=xIDiVKTp/rs9VQy1u1zr5si/Adfcqb6XWxPzxizUP1kBjVP58zEISiLS1bxsOA/+b5mxyC
	NbDxBSyaPHjVh0yFRhj9G+oTHQ7U7tdjwvPnV4Z0kRZdqdUp5F2pPsiXqJ8QTNlgWxnSH1
	P6FxGLHgKs95u07VHbu/KJUc6Y3t29w=
Date: Wed, 27 May 2026 21:40:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Update transport_header when encapsulating
 UDP tunnel in lwt
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260525142650.2569-2-leon.hwang@linux.dev>
 <20260525150010.CDEBA1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260525150010.CDEBA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/25 23:00, sashiko-bot@kernel.org wrote:
[...]
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index f71ef82a5f3d3..cbb2803367c6d 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -637,6 +637,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>>  	if (ingress)
>>  		skb_postpush_rcsum(skb, iph, len);
>>  	skb_reset_network_header(skb);
>> +	if (ipv4 && iph->protocol == IPPROTO_UDP /* UDP tunnel */)
>> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
> 
> [Severity: High]
> Can a concurrent modification to the BPF-provided header cause an
> out-of-bounds transport header offset?
> 
> The hdr pointer passed to bpf_lwt_push_ip_encap() can point to concurrently
> mutable memory such as a BPF map value. Reading iph->protocol and iph->ihl
> directly from hdr here, after length validation has already occurred,
> appears to introduce a Time-of-Check to Time-of-Use race condition.
> 
> If a concurrent modification changes iph->ihl, the calculated transport
> header could point well past the end of the pushed IP header. For small
> SKBs, this could cause skb_transport_header to point out-of-bounds into
> skb_shared_info.
> 
> Would it be safer to perform these reads after copying the header into the
> SKB, using the copied, stable values instead?
> 

Agreed.

Will move skb_set_transport_header() after memcpy().

> [Severity: Critical]
> This is a pre-existing issue and was not introduced by the patch under
> review, but is there a missing validation for the minimum IPv4 header
> length before ip_fast_csum() is called?
> 
> Earlier in the function, the length validation checks:
> 
>     if (unlikely(len < iph->ihl * 4))
>         return -EINVAL;
> 
> If a BPF program provides an IP header with ihl = 0, the check len < 0
> evaluates to false because len is at least 20.
> 
> Later, ip_fast_csum() is called with ihl = 0. On architectures like MIPS,
> the ip_fast_csum() implementation reads 16 bytes and then uses a loop:
> 
>     do { ... word++ } while (word != stop);
> 
> where stop = iph + ihl. If ihl = 0, stop is physically behind word,
> causing the loop to endlessly increment through the address space until
> it page faults.
> 
> Does this code need a check to ensure iph->ihl >= 5?
> 

I'm not sure about this case.

But, can update "len < iph->ihl * 4" to
"iph->ihl < 5 || len < iph->ihl * 4".

> [Severity: Medium]
> Does this code verify that the packet length actually contains the full UDP
> header?
> 
> This updates the transport header for UDP tunnels based solely on the IP
> protocol, but it doesn't seem to validate that len actually encompasses
> the full struct udphdr.
> 
> If an IP header is pushed with IPPROTO_UDP but a truncated length (like
> len = 20), the transport header is set to the end of the IP header. A NIC
> driver might then attempt to parse the subsequent memory as a UDP header,
> which could lead to broken offloads or out-of-bounds reads.
> 

Agreed.

Will check len must include UDP header.

Thanks,
Leon

>> +	else if (!ipv4 && ((struct ipv6hdr *)hdr)->nexthdr == NEXTHDR_UDP /* UDP tunnel */)
>> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr));
>>  	memcpy(skb_network_header(skb), hdr, len);
>>  	bpf_compute_data_pointers(skb);
>>  	skb_clear_hash(skb);
> 

