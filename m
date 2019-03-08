Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DDAC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E72D20684
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NhzBRJLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCHLNO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:13:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37361 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfCHLNN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Mar 2019 06:13:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D9C22207E;
        Fri,  8 Mar 2019 06:13:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Mar 2019 06:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=avA4FoeO6xNQkjlbiKeIRU2G/wq42n4zc+0robbos
        /k=; b=NhzBRJLnt5eBE/IpOS+ld9DPxTxEWdYN4j56efJf+fFXyUiMgu8blENWE
        +2HfS578ByExO/jZXlw5Ibn/UcF3UkgrThGNinpL5DGn7eTEiS7cj7pM1M9/qAH1
        RyOSN3cOeKO+2KJXK8Uvq8/V+Ls6AqyzGQ44gpt69u495loeiGDAG6HCvV2Whx5E
        kLryRLZEmft5cGixbFAgepSp71FJyRAZ4XmOEK+pOS4YMbcDkVQWtRGmrCp+2GdD
        a1trZYJM4IIhuso62AJaVNiOx/CdrDYLFnazXgEpsWg5XVDxSmVpOZROWcvbv0S/
        SHW2TkKJrExIrEs2zKRgtW1w/xkiA==
X-ME-Sender: <xms:R06CXMaLUhteg6w4JijoPDhLJ5WdzmktKlmHfYiwq0lIjmDBtEu4Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgedtgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucfkphepudekkedrieefrddvtdejrddvfeehnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhhtnecuvehluhhsthgvrhfuihiivg
    eptd
X-ME-Proxy: <xmx:R06CXGLMJK4PBCZGV1TWieaz2z0RR3P9Su4x4yWsDgT3XN2izcro3g>
    <xmx:R06CXLgII_JxiqkEKcoitr87nf6pEe3dSeUKRBpK9mTeMbf44bEaBA>
    <xmx:R06CXCv7QQHRbjDChTyP4J4h8yCEMdujizIOPRcV3q_1V-adTJMY8A>
    <xmx:SE6CXBdyt-2HA7NXFad2sH0gi8xWGYusd7GrUmf5sTYQBLBP857tFA>
Received: from [192.168.1.116] (235.207.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.207.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6439710319;
        Fri,  8 Mar 2019 06:13:10 -0500 (EST)
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
To:     Michal Hocko <mhocko@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <69fdfb33-057b-b7fe-033e-d82006a779b9@lambda.lt>
Date:   Fri, 8 Mar 2019 12:14:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308084413.GB5232@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/8/19 9:44 AM, Michal Hocko wrote:
> On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
>> It has been observed that sometimes memory allocation for BPF maps
>> fails when there is no obvious memory pressure in a system.
>>
>> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
>> could not be created due to due to vmalloc unable to allocate 75497472B,
>> when the system's memory consumption (in MB) was the following:
>>
>>      Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
> 
> Hmm 75MB is quite large and much larger than the slab/page allocator
> cann provide so this is not really a fragmentation issue. Vmalloc does
> respect noretry but considering that there shouldn't be a large memory
> pressure I wonder how NORETRY managed to fail the allocation. Do you
> happen to have the allocation failure report?

I got /proc/{meminfo,vmstat,vmallocinfo} just after the allocation has 
failed:
https://gist.github.com/brb/62092c1d83daa6527271b88f0352e32d

Let me know if more info is required, I can reproduce the failure. Thanks.

> 
> Btw. is there any real reason to opencode and duplicate kvmalloc logic
> here? In other words why not simply make bpf_map_area_alloc use
> kvmalloc_node with GFP_KERNEL?
> 
>> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
>> __GFP_RETRY_MAYFAIL with more useful semantic") we can replace
>> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
>> and will try harder to fulfil allocation requests.
>>
>> The change has been tested with the workloads mentioned above and by
>> observing oom_kill value from /proc/vmstat.
>>
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>> ---
>>   kernel/bpf/syscall.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 62f6bced3a3c..eb5cefe44af3 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -136,11 +136,11 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
>>   
>>   void *bpf_map_area_alloc(size_t size, int numa_node)
>>   {
>> -	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
>> -	 * trigger under memory pressure as we really just want to
>> -	 * fail instead.
>> +	/* We definitely need __GFP_NORETRY or __GFP_RETRY_MAYFAIL, so
>> +	 * OOM killer doesn't trigger under memory pressure as we really
>> +	 * just want to fail instead.
>>   	 */
>> -	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
>> +	const gfp_t flags = __GFP_NOWARN | __GFP_RETRY_MAYFAIL | __GFP_ZERO;
>>   	void *area;
>>   
>>   	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
>> -- 
>> 2.21.0
>>
> 
