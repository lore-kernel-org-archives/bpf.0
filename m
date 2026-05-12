Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED213635E
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551548; cv=none; b=O0OQzjKSkIXRGM4WEG0m6WWMW8SkRtDV9zwFak5zJMHzTJzMLkv6Okp2o7Pb/5cvJGmMsIFxc6wtYctRLT92e8kEnyW+wigsbasXv0tFeAU4spXiHvqX4ZYjXJ+mdgWJqL5Gosyz5WUHb5ewchgGwsKbxjPMYQpCkXGeyIz6UAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551548; c=relaxed/simple;
	bh=+cTI2NiIAP41IKA/xg3zJwWYiljzUgcxObRtbpU3/BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NKn1YXfnQ/EhTeL/xKtE2rrvNI28/Cp6TVkO6ZsChB2soEnFY2j/D0eiUkl0nzZwk9G9YQQ904WOXgtrFnUxr2YzIpjqqIVn7G76Vvfy1nz0hDhf2MbIoBS+zBXMAf8cyyhkcHO3v5s0YznUzQaKHK5gWslXwpdeooLzEVeFsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KcDjdiHf; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KcDjdiHf"
Message-ID: <e6c1463a-c2de-4cf6-8036-d38a945f9363@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778551542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkdR7BqOfxJn+iAX51miDaH2v7BbkS20p86edp+Lfg8=;
	b=KcDjdiHflbFFNQj9XNUyk6fRXoVz77EOcOHhxziceBg5/R46h9O2mmj4VM8YgEPcx7NQJO
	COg0oHcimRl6hEz0ynlf8iWQSt2yI7AvUBjf9pSmrmQQRbZ3gJAKLqql+exmwYuCYFAErq
	IIqPJM/ixFAvwxieWXSVEzks6M2MDhU=
Date: Tue, 12 May 2026 10:05:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [QUESTION] BPF_SK_SKB_STREAM_PARSER cannot observe strparser
 orig_offset?
To: "Cristian Morales Vega (cmorve)" <cmorve@cisco.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <SA1PR11MB68483E0B4C78DA91FF8DCE7AC0382@SA1PR11MB6848.namprd11.prod.outlook.com>
 <ec18cff8-a760-4bcb-b5bc-604924ff81ec@linux.dev>
 <SA1PR11MB6848CE0D74476DA27BCA6091C0382@SA1PR11MB6848.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <SA1PR11MB6848CE0D74476DA27BCA6091C0382@SA1PR11MB6848.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/12/26 12:18 AM, Cristian Morales Vega (cmorve) wrote:
>>> On 5/11/26 10:49 PM, Cristian Morales Vega (cmorve) wrote:
>>> I am trying to use BPF_SK_SKB_STREAM_VERDICT in an old kernel (I don't have control over the version), so I need to also use BPF_SK_SKB_STREAM_PARSER. I though to just do "return skb->len;" in it, as a no-op, since I don't really have an use for the parser.
>> Since v5.18 BPF_SK_SKB_STREAM_VERDICT can be used without
>> BPF_SK_SKB_STREAM_PARSER.
>>
>> Which kernel version you use now?
> I think it's since 5.10? But I have to make it run on a big range of kernel versions, right now I'm looking at a 5.4.213 system.
>
>
>>> So far so good. But I can see that, from time to time, __strp_recv() receives a non-zero orig_offset as "first skb" (i.e. strp->skb_head is null). In such a case, I should not be returning skb->len but "skb->len - orig_offset" (i.e. orig_len), right? Otherwise I would enter
>>>
>>>                  extra = (ssize_t)(stm->accum_len + cand_len) -
>>>                          stm->strp.full_len;
>>>
>>>                  if (extra < 0) {
>>>                          /* Message not complete yet. */
>>>
>>> But AFAICT BPF_SK_SKB_STREAM_PARSER doesn't have access to that offset. It seems it had it until e0dc3b93bd7bcff8c3813d1df43e0908499c7cf0 (which was backported), but not any more?
>>>
>> Is my understanding correct? If not, what am I missing? And, if yes, there is any solution?
>>
>>
>> If you just return skb->len only in your parser , the 'issue' should not
>> happen.
> But if the parser returns skb->len, even in a modern system (in theory, I'm struggling to reproduce getting orig_offset != 0 in any system I can properly debug). Let's say orig_skb->len is 1500, orig_offset 1000 and orig_len 500.


   I think non-zero orig_offset only happens when __tcp_read_sock
   is mid-skb and recv_actor returns an error after consuming part
   of the data -- next call comes back with orig_offset != 0.


> - cand_len will be set to 500 here ->https://github.com/torvalds/linux/blob/master/net/strparser/strparser.c#L186
> - len will be set to 1500 here -> https://github.com/torvalds/linux/blob/master/net/strparser/strparser.c#L221
> - stm->strp.full_len will be set to 1500 here -> https://github.com/torvalds/linux/blob/master/net/strparser/strparser.c#L258
> - extra will be set to 0 + 500 - 1500 = -1000 here -> https://github.com/torvalds/linux/blob/master/net/strparser/strparser.c#L261
>
> So it will enter "/* Message not complete yet. */" inside "if (extra < 0)", no?
To your earlier point: yes, what you really want is the skb
offset, especially for protocol framing. That scenario is real
and can be worked around using a map to carry state across

parser invocations.


But none of this fires as long as your parser keeps returning
skb->len.

