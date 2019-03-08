Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1694C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 20:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B3320857
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 20:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnVgGXu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCHUBh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:01:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52939 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbfCHUBg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Mar 2019 15:01:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C987216CA;
        Fri,  8 Mar 2019 15:01:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Mar 2019 15:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=wkWqKZ4BDvo65SUW0fcuRlsWXDHXdPpmIOYOty7jq
        NI=; b=MnVgGXu1+TYcB+w/voZBhUq/swGAgoyPv2Ha+W3jpEGgPP8373Sn1F8A3
        miKcdyvw4ddvtNJ8Bmbo6vBtXvfKj/9OblAY3co902vgAXhG4dQsuBF9guq8ecse
        kV+AyJ59rapbc5z4IGQUchz5gOPlaHEtzZ+a6Fb9K9wGjiN2H6daB0ixy07oU83a
        QtLvsLZ9cBh3et5ipV4EJ6Lq3g7xKNvynUZIVORwmx08ntC8pHxACuYcSJUyOw+n
        i9456bHPNkZx4aAEhqUt7kub94ePbfi4KmM82VMP/SqQB8BkGMNJhvIq4FgBOp0E
        FV5ktraHKbEF2ltgyZuu6HZEBbZOA==
X-ME-Sender: <xms:HsqCXOU1ZzCpWkLm7J1ye7S7iCvOwBYR7aacjGd0Q4ps3J8odZ9khA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgedtgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepofgrrhht
    hihnrghsucfruhhmphhuthhishcuoehmsehlrghmsggurgdrlhhtqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecukfhppeefuddrudeigedruddvfedrvdefleenucfrrghr
    rghmpehmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlthenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:HsqCXJDB6u1MNfkISdCW_x07uyMS48hjJ1PgGaTvl5BF2emNbZDpaQ>
    <xmx:HsqCXJhRCIcKj2-DxHXBaZyCwy3W2CwmYZ44dxjxYEMgCt-nzDep4A>
    <xmx:HsqCXI4CNLLJaN1BcoWBfGg_OGl28SwtWhib5piaQ7ra9dVhqDA24Q>
    <xmx:H8qCXAQmCY0FTv3D8GLxhmsLWA5Un_5zkjG3AZDdYWOZlD4FlnWXfQ>
Received: from [192.168.1.21] (xdsl-31-164-123-239.adslplus.ch [31.164.123.239])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF86F10312;
        Fri,  8 Mar 2019 15:01:33 -0500 (EST)
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
To:     Michal Hocko <mhocko@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
 <69fdfb33-057b-b7fe-033e-d82006a779b9@lambda.lt>
 <20190308112000.GG5232@dhcp22.suse.cz>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <2cbb3fe7-39a9-1b1e-e22f-4dffa20b9414@lambda.lt>
Date:   Fri, 8 Mar 2019 21:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308112000.GG5232@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/8/19 12:20 PM, Michal Hocko wrote:
> On Fri 08-03-19 12:14:16, Martynas Pumputis wrote:
>>
>>
>> On 3/8/19 9:44 AM, Michal Hocko wrote:
>>> On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
>>>> It has been observed that sometimes memory allocation for BPF maps
>>>> fails when there is no obvious memory pressure in a system.
>>>>
>>>> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
>>>> could not be created due to due to vmalloc unable to allocate 75497472B,
>>>> when the system's memory consumption (in MB) was the following:
>>>>
>>>>       Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
>>>
>>> Hmm 75MB is quite large and much larger than the slab/page allocator
>>> cann provide so this is not really a fragmentation issue. Vmalloc does
>>> respect noretry but considering that there shouldn't be a large memory
>>> pressure I wonder how NORETRY managed to fail the allocation. Do you
>>> happen to have the allocation failure report?
>>
>> I got /proc/{meminfo,vmstat,vmallocinfo} just after the allocation has
>> failed:
>> https://gist.github.com/brb/62092c1d83daa6527271b88f0352e32d
> 
> dmesg with the allocation failure report would be more helpful

https://gist.github.com/brb/2d7ac323d2e14cb7a38bacba301fe3af

> 
> Thanks!
> 
