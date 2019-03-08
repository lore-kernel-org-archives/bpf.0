Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895FBC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C7A20854
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCHLax (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:30:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:37382 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHLaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 06:30:52 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2DiC-0001C7-P3; Fri, 08 Mar 2019 12:30:48 +0100
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2DiC-0004xg-Dv; Fri, 08 Mar 2019 12:30:48 +0100
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        ast@kernel.org
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
 <295a56f7-6028-3c45-63d4-b6394cc787f1@iogearbox.net>
 <20190308105553.GD5232@dhcp22.suse.cz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <71565608-1478-cbb9-62b6-0292e01a3d09@iogearbox.net>
Date:   Fri, 8 Mar 2019 12:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190308105553.GD5232@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25382/Fri Mar  8 09:55:42 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/08/2019 11:55 AM, Michal Hocko wrote:
> On Fri 08-03-19 11:33:00, Daniel Borkmann wrote:
>> On 03/08/2019 09:44 AM, Michal Hocko wrote:
>>> On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
>>
>> Martynas, for the patch, please also Cc netdev in the submission so
>> that it lands properly in patchwork. Setup where patches only Cc'ed
>> to bpf@vger.kernel.org would land in our delegate is not yet completed
>> by ozlabs folks, just fyi.
>>
>>>> It has been observed that sometimes memory allocation for BPF maps
>>>> fails when there is no obvious memory pressure in a system.
>>>>
>>>> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
>>>> could not be created due to due to vmalloc unable to allocate 75497472B,
>>>> when the system's memory consumption (in MB) was the following:
>>>>
>>>>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
>>>
>>> Hmm 75MB is quite large and much larger than the slab/page allocator
>>> cann provide so this is not really a fragmentation issue. Vmalloc does
>>
>> Agree.
>>
>>> respect noretry but considering that there shouldn't be a large memory
>>> pressure I wonder how NORETRY managed to fail the allocation. Do you
>>> happen to have the allocation failure report?
>>
>> I'll defer to Martynas here.
>>
>>> Btw. is there any real reason to opencode and duplicate kvmalloc logic
>>> here? In other words why not simply make bpf_map_area_alloc use
>>> kvmalloc_node with GFP_KERNEL?
>>
>> Mostly historical reasons from d407bd25a204 ("bpf: don't trigger OOM killer
>> under pressure with map alloc"). I remember back then we had a discussion
>> that __GFP_NORETRY is not fully supported and should only be seen as a hint
>> in our case (since it's not propagated all the way through in vmalloc, if
>> I recall correctly).
> 
> Yes, that is still the case and there is no way to really have nooom
> semantic for vmalloc. Even with your opencoded version btw.

Okay, so similar situation applies to __GFP_RETRY_MAYFAIL reclaim modifier
then if I understand you correctly? In dcda9b0471, its mentioned "this
means that all the reclaim opportunities have been exhausted except the
most disruptive one (the OOM killer) and a user defined fallback behavior
is more sensible than keep retrying in the page allocator." In the api
comment in kvmalloc_node(), it says "__GFP_RETRY_MAYFAIL is supported,
and it should be used only if kmalloc is preferable to the vmalloc fallback,
due to visible performance drawbacks". But if you say above that for
vmalloc, there is no nooom semantic, then presumably __GFP_RETRY_MAYFAIL
should also be taken as a hint wrt OOM, not a guarantee for the given
allocation request (if kvmalloc_node selects the vmalloc based allocator),
is that correct?

>> And looking at kvmalloc_node(), __GFP_NORETRY is only
>> really set in case of kmalloc attempts. Given these alloc requests for maps
>> can often be large in size, what we really want is something that ideally under
>> *no* circumstances oom killer would trigger as that is way too disruptive.
> 
> That is not really possible. Even if you do not trigger the OOM killer
> directly, som concurrent allocation might do that because your
> particular one has eaten the remaining memory.

Yes, in that situation there's not much we can do with either modifier.

>> So
>> instead, allocation should just fail and bpf loader or whatnot can deal with
>> it. Looks like __GFP_RETRY_MAYFAIL would be better suited wrt OOM for both
>> allocators and would allow to reuse kvmalloc though it would try much harder
>> than __GFP_NORETRY.
> 
> Yes.
> 
>> Ideally something like GFP_KERNEL | __GFP_NOWARN |
>> __GFP_NOOOM | __GFP_ZERO would be nice to have, semantics of __GFP_RETRY_MAYFAIL
>> kind of gets closer to it from looking at dcda9b0471.
> 
> NOOOM semantic is simply impossible to make it sensible as explained
> above.
> 
>>>> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
>>>> __GFP_RETRY_MAYFAIL with more useful semantic") we can replace
>>>> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
>>>> and will try harder to fulfil allocation requests.
>>>>
>>>> The change has been tested with the workloads mentioned above and by
>>>> observing oom_kill value from /proc/vmstat.
>>>>
>>>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>>>> ---
>>>>  kernel/bpf/syscall.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index 62f6bced3a3c..eb5cefe44af3 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -136,11 +136,11 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
>>>>  
>>>>  void *bpf_map_area_alloc(size_t size, int numa_node)
>>>>  {
>>>> -	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
>>>> -	 * trigger under memory pressure as we really just want to
>>>> -	 * fail instead.
>>>> +	/* We definitely need __GFP_NORETRY or __GFP_RETRY_MAYFAIL, so
>>>> +	 * OOM killer doesn't trigger under memory pressure as we really
>>>> +	 * just want to fail instead.
>>>>  	 */
>>>> -	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
>>>> +	const gfp_t flags = __GFP_NOWARN | __GFP_RETRY_MAYFAIL | __GFP_ZERO;
>>>>  	void *area;
>>>>  
>>>>  	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
>>>> -- 
>>>> 2.21.0
>>>>
>>>
> 

