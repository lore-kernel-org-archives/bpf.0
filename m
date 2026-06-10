Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC591198A17
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065474; cv=none; b=CCmEdSkAdsh0jl+FxB1NUsQqa22zPWAxQ2eSsA8eik/EepkM7wAK1wuWu990tcdvwORSlsnMWIt8qhWOzziZelkKWLMknbc95o46oPUYK0fHdzDWVv0n189WZanJaybd/aLYaSJc0+kHeYDcNV1EsZp2D3LAiaTKUSJb4qa70y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065474; c=relaxed/simple;
	bh=2CqF8p5dw/XxEAz11Zh8DDYuf1c9GnMd4+BGC6W4CqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufmzzwB5AuTp+ixZI6UbUYk7Z+EuS4smLfQLIjfAwuePrcxFPZ2ej/o5+DnzEVJ3O85Rqwk9v/Yc6Z2lEGy7mM66JocVF8kF8qrlcABrSMyDDG8flqfjvFGCfvsi19ST+vnxeztBW+X+kOH6AEkk2QVo+RRY8Cvpl/BF3rW5lCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAJAbjEK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAJAbjEK"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-842319576d5so3564290b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 21:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065472; x=1781670272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwS2XQIcEgtV0x4G9OnLh7cNs9kyFtmykvsZ/mlbH4Q=;
        b=GAJAbjEKwZRWJca4CMHPq6sxRpT53RlAq5rj2t4pWA68AIwsuxuaKw21WRcvLLE3PW
         Wgr1kBHJYiSQUqNVGjKJqrhMKulGo+4TDx1/xpBZWUD3TLLP2l3o5MwtsBHaLlY60JQh
         bqQd5fyzso1Xlr4wzVSH38RceAgQciD8r3nCYtM3lMCUBRmb93lmhoDH1Jbj5QMH83sL
         +d2T3V73YjNiVLP9zoxzlTiRjVV/M7FgJnTgezJSG5ofaywfAwVMO2pRl+dGA8SS+SYB
         YPB0Q7NvpdLM0nxm+doaaRDZC6MrnwrRD1ri++BxZDKT40doCnOFHYygBzAS1bi0xDCX
         QvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065472; x=1781670272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwS2XQIcEgtV0x4G9OnLh7cNs9kyFtmykvsZ/mlbH4Q=;
        b=MFRsY0GnEo8pm6Xg7AafJ0ANv6hzgbtImLbsZqiol/MH/pxhdMOyBNHc9XqnSQsNSF
         jnw/l4E3YU4r/Rr2ZUIprOr8k/wgy9ajOnKYST0ysObYvFQA8ayeQ08OTorSQ1HnYx3p
         zRNd8FhPSG3MUBU7WImWA8i8obndlUeklkbaikbU2PNk0804hdeBdwLFAH1/dmuw7H9O
         mTCUI9Eml266a1hkTzK3I5xZHzlGQJ6hTuBDCYKal1fp+jVu1F8duI2OB1fhi/cV5+hm
         sN/fXaWOUiYfphgrpCox2KL5ylm57EudlKxoky41NI7U8vFIFzcxa0tI3wglHIiJXZmb
         vk7g==
X-Forwarded-Encrypted: i=1; AFNElJ9UpekdkS+iPEds7pFpqD4SAP2DtNtIjb7J7LTa4WktgKs1xjlISWAVVs0L0VmQuQVr13c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMrDodYfUGEf6jF99TsRoorrcdHAdc3kQ9GX6WtzMlCy/u2BD
	Y0KzEvzf7UkkHO4hifjnpINaAbBEG0X8WlRnsK9fuSYCZZyY4k1aM3i8
X-Gm-Gg: Acq92OGuQoGXAzC+ZQn7uWNxLaNduujGWz4Efh3O6FA9LnfAsClsZq/FhDHhD1BZU/9
	vR+1/5EU8aQAQSD/SgQDRWxaXs4G34ApKEPrU0hSOLeS5XgJGqXetJXPVLHLBxp4OcVWrdxIwJT
	tg4AZulZ3Ul3kz3uRSmv8bDPuelRoIxpifmM1Hq4G4/xJA00zxtRSQP0oXXMcARmaRaKd9RVcxh
	YcutPDQ8tqTXLTgWQ/tR4LEuNF5JCGJ+WqfzGSNbazxmz82mJTg9EnaP9jSm18sX8mV4S2/sER9
	U10oWTkiTVEcag8TdhkotgUlCowYlvc9SFZ7dMo9JnYmV/PTanTOF+pM3cQf+LcC4KRHameu26B
	m4qqvYipmyJkDny2i9kBBdG0fMjuHRXYiOQqOrjHvVmDDlqbX9y7w6Ja/GJIvX9u6n+Kh16chPh
	Ha28e4UtHavsyog90GvViv4VtyfvBAZ+Owit/kvsGFdflEiNvvMeKJUWb/QXVcj6XVGUBiG3PF3
	fhpi/9m
X-Received: by 2002:a05:6a20:729b:b0:3b5:28d1:8bb5 with SMTP id adf61e73a8af0-3b53bc5c1f4mr7697024637.11.1781065472043;
        Tue, 09 Jun 2026 21:24:32 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bdbe4sm20002858a12.32.2026.06.09.21.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:24:31 -0700 (PDT)
Date: Wed, 10 Jun 2026 04:24:13 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
Message-ID: <ffogb2v2lpkznolxyxqzpa2semo74gytqgznuqs3zzjirjmjul@eezstkfy65d2>
References: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
 <20260609185257.A09111F00893@smtp.kernel.org>
 <DJ4UMEV0NQE2.14XTJKL239Z4Y@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DJ4UMEV0NQE2.14XTJKL239Z4Y@etsalapatis.com>

On Tue, Jun 09, 2026 at 05:49:49PM -0400, Emil Tsalapatis wrote:
>On Tue Jun 9, 2026 at 2:52 PM EDT, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] Unbounded `len` parameter in `bpf_msg_push_data` causes a 32-bit integer overflow when calculating the page allocation size (`copy + len`), resulting in an out-of-bounds heap write.
>> - [High] Incorrect scatterlist element offset calculation when splitting an element in `bpf_msg_push_data` inflates the page offset, leading to out-of-bounds memory accesses.
>> --
>>
>> commit 619f5b1d1aebdbd6457c3ac6e3a92bc45be7278c
>> Author: Sechang Lim <rhkrqnwk98@gmail.com>
>
>The change seems solid, the error is apparent from code inspection
>alone (though a repro wouldn't hurt). Can you also turn pop from an int
>to a u32? It should never be negative AFAICT, and we assign to it from
>a u32 so since we're fixing int types...
>

Will do in v2.

>>
>> bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
>>
>> start and len are u32, so start + len evaluates in 32-bit and wraps before
>> storing it in last. The bounds check can then be passed with an out-of-range
>> start/len.
>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 9590877b0714f..31467c0b4279e 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -2974,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>>>  	   u32, len, u64, flags)
>>>  {
>>>  	u32 i = 0, l = 0, space, offset = 0;
>>> -	u64 last = start + len;
>>> +	u64 last = (u64)start + len;
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but while fixing the integer
>> overflow in bpf_msg_pop_data(), could a similar overflow occur in
>> bpf_msg_push_data()?
>>
>> Looking at net/core/filter.c:bpf_msg_push_data(), both copy and len are u32:
>>
>> 	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>> 			   get_order(copy + len));
>>
>
>This seems like a valid concern. Can you add it to the patch? Making
>copy a u64 should do it.
>

Already handled by Weiming Shi:
https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/

>> If the split element is not the first one in the message, wouldn't rsge.offset
>> be inflated by the cumulative length of all previous elements instead of the
>> relative offset (start - offset)?
>
>It does, this seems like a real bug. AFAICT the offset of rsge should be
>
>rsge.offset = start + len.
>
>Can you confirm and add to the next version?
>

Already fixed upstream:
https://lore.kernel.org/bpf/8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com/

So I'll keep v2 to the bpf_msg_pop_data() fix plus the pop type change.

Thanks,
Sechang
