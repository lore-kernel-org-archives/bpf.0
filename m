Return-Path: <SRS0=5gB9=RP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB0C43381
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 02:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B0D214AE
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 02:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCLCBy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:01:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfCLCBx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 22:01:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D84BC606F09717E3F239;
        Tue, 12 Mar 2019 10:01:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 10:01:42 +0800
Subject: Re: 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 bpf: prevent out of
 bounds speculation on pointer arithmetic
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>, <ast@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        <bpf@vger.kernel.org>
References: <5d71646c-f897-2178-9d4a-fababe999f36@huawei.com>
 <494a84f2-1a29-1521-e819-6e4fbed17641@iogearbox.net>
 <c9a89285-23bd-0e4d-3bdc-ea5d5c61e7ff@huawei.com>
 <20190311185458.GA4986@kroah.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1b893f28-d663-ff57-11b1-1e4b76781437@huawei.com>
Date:   Tue, 12 Mar 2019 10:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190311185458.GA4986@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2019/3/12 2:54, Greg KH wrote:
> On Mon, Mar 11, 2019 at 07:13:14PM +0800, Jason Yan wrote:
>>
>>
>> On 2019/3/11 17:41, Daniel Borkmann wrote:
>>> Hi Jason,
>>>
>>> On 03/11/2019 10:18 AM, Jason Yan wrote:
>>>> Hi, Daniel & Greg
>>>>
>>>> This patch (979d63d50c0c bpf: prevent out of bounds speculation on pointer arithmetic) was assigned a CVE (CVE-2019-7308) with a high score:
>>>>
>>>> CVSS v3.0 Severity and Metrics:
>>>> Base Score: 9.8 CRITICAL
>>>>
>>>> And this patch is not in stable-4.4, would you please backport this patch to 4.4?
>>>
>>> We don't handle kernels as old as 4.4, so someone else would need to
>>> do the backporting e.g. from your side. The series has been backported
>>> to the last two most-recent stable kernels at that time (we usually
>>> follow netdev practice here), and there have been asks about 4.14 as
>>> well; I've been looking into backporting for the latter last two weeks
>>> on and off, but there are conflicts all over the place in fragile core
>>> areas where I didn't have enough free cycles to complete it yet. For
>>> old kernels, you're probably better off doing something like this in
>>> your tree instead of the huge complexity with a backport:
>>>
>>
>> Thanks for you kindly reply.
>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index bc34cf9..2cea2de 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -47,7 +47,7 @@ static DEFINE_SPINLOCK(prog_idr_lock);
>>>    static DEFINE_IDR(map_idr);
>>>    static DEFINE_SPINLOCK(map_idr_lock);
>>>
>>> -int sysctl_unprivileged_bpf_disabled __read_mostly;
>>> +int sysctl_unprivileged_bpf_disabled __read_mostly = 1;
>>>
>>
>> Greg, is it possible to get this kind of mitigation into 4.4?
> 
> Why are you using a 4.4 kernel with untrusted userspace?  The only
> reason to use 4.4.y at this point in time is if you have a huge SoC tree
> patchset that is not upstream.  If you are using x86, you should be
> using 4.14.y or newer right now.
> 
> That being said, no, I am not going to change the default here, that
> could break people's working setups.  I would recommend you just setting
> this value in your initrd/setup scripts if you want it, that's why it is
> a sysctl :)
> 

Got it, thanks.

Jason

> thanks,
> 
> greg k-h
> 
> .
> 

