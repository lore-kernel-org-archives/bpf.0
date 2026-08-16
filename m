Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A5282F17
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786857073; cv=none; b=GbwRV90gF2l0iqk4Xc+VTbt7eRmUba9vY1HRVIYG0wJ7sqtRGUrWpK9Li+zOMLVV0RrFpdIWpGQIGHXQpE1lRyWBYewJd2J9/4D8MIVdzF2iX4p6qNCZJ4hx5OfipUm2s6D9t8ILR0mjueKCOOJqyJEp7GlSDBB8sGpmTe3FSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786857073; c=relaxed/simple;
	bh=SEFoQbjK0tdz7j/adJ5Fjr7AVZ1n9GP8SfnoIvS6IYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPAsfmsDTZq/c4OV6F4zPrn2oSbTbAHUY4WvQ7+dWnds+tSRh7qS4mDTy64EFB+4mCiuX0ilvk2x+FqJ7d8zzKv8XQn1plKnHeA9pGokczdG0aHWPY2Z/zp/FjM1UCGoDIHZn1dEts7+IqO5L29kB21WpD3HARugbIEEB0EBKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hMKcSzry; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hMKcSzry"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SEFoQbjK0tdz7j/adJ5Fjr7AVZ1n9GP8SfnoIvS6IYM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786857069; v=1; x=1787461869;
 b=hMKcSzryCMeTCzL+V/C3rbFGsL1gkaSILTCw24W0fjb/gVlY78g4yhpZyFjbCHFaBtfi82db
 ixmG4p23aMM4aAo59knJmOyusWHvlHoFSD4ZG008Gqnt4UZnEH4WuLQ9LpmmOoPixg72FuoqsGB
 4kIr/62J+Yze0XGPpTBlQxe0=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.26.41] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id b4d34709e7724279;
	Sun, 16 Aug 2026 05:10:59 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <8cbc09e6-bc32-46d7-bdb6-890a3ba59568@linux.dev>
Date: Sun, 16 Aug 2026 13:10:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: free page_pool frags via the page_pool path in
 bpf_xdp_shrink_data
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260816031245.268898-1-jiayuan.chen@linux.dev>
 <20260816033752.794AE1F000E9@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260816033752.794AE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/16/26 11:37 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The netmem_is_pp() check fails on compound tail pages, leading to page_pool leaks and 'Bad page state' kernel panics.
> - [Low] The multi-line comment introduced in bpf_xdp_shrink_data() does not follow the required BPF subsystem comment style.
> --
>
> --- Patch [1]: [PATCH bpf] bpf: free page_pool frags via the page_pool path in bpf_xdp_shrink_data ---
> commit 28e0b86b119236ed1263628b895946efb16e99cf
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf: free page_pool frags via the page_pool path in bpf_xdp_shrink_data
>
> This commit fixes a page_pool leak reported by syzbot when generic XDP
> programs shrink skbs into fragments. It inspects the page itself using
> netmem_is_pp() rather than relying on the rxq memory model.
>
> Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 3423734124a5b..4536bd147c253 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
> [ ... ]
>
>> @@ -4293,6 +4294,14 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
>>   	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
>>   		netmem = 0;
>>   		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
>> +	} else if (netmem_is_pp(netmem)) {
> [Severity: High]
> Does this check handle compound tail pages correctly?

I think we should process it like napi_pp_put_page

...

   } else if (netmem_is_pp(netmem_compound_head(netmem))) {
       mem_type = MEM_TYPE_PAGE_POOL;
   }



