Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3875C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7941F2085A
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCRPwK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:52:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:52332 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRPwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:09 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h5uYW-00025I-VO; Mon, 18 Mar 2019 16:52:05 +0100
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h5uYW-0004wf-HQ; Mon, 18 Mar 2019 16:52:04 +0100
Subject: Re: [PATCH v3 bpf] bpf: Try harder when allocating memory for large
 maps
To:     Michal Hocko <mhocko@kernel.org>, Martynas Pumputis <m@lambda.lt>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        Yonghong Song <yhs@fb.com>
References: <20190318151026.21539-1-m@lambda.lt>
 <20190318153940.GL8924@dhcp22.suse.cz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <efeee51e-bb64-333d-7091-5c768c13e5e9@iogearbox.net>
Date:   Mon, 18 Mar 2019 16:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190318153940.GL8924@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25392/Mon Mar 18 08:51:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/18/2019 04:39 PM, Michal Hocko wrote:
> On Mon 18-03-19 16:10:26, Martynas Pumputis wrote:
>> It has been observed that sometimes a higher order memory allocation
>> for BPF maps fails when there is no obvious memory pressure in a system.
>>
>> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
>> could not be created due to vmalloc unable to allocate 75497472B,
>> when the system's memory consumption (in MB) was the following:
>>
>>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
>>
>> Later analysis [1] by Michal Hocko showed that the vmalloc was not trying
>> to reclaim memory from the page cache and was failing prematurely due to
>> __GFP_NORETRY.
>>
>> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
>> __GFP_RETRY_MAYFAIL with more useful semantic") and [1], we can replace
>> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
>> and will try harder to fulfil allocation requests.
>>
>> Unfortunately, replacing the body of the BPF map memory allocation
>> function with the kvmalloc_node helper function is not an option at this
>> point in time, given 1) kmalloc is non-optional for higher order
>> allocations, and 2) passing __GFP_RETRY_MAYFAIL to the kmalloc would stress
>> the slab allocator too much for large requests.
> 
> Thanks for extending the changelog!
> 
>> The change has been tested with the workloads mentioned above and by
>> observing oom_kill value from /proc/vmstat.
>>
>> [1]: https://lore.kernel.org/bpf/20190310071318.GW5232@dhcp22.suse.cz/
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> 
> The patch looks good to me from the allocator usage POV. I wish there
> was a good way to give you a util function to use rather than opencoding
> but this is the only place with this semantic I have seen and I am not
> sure it is generic enough. Let's see what the future has to tell us.

+1, and thanks for your review. Applied to bpf, thanks everyone!
