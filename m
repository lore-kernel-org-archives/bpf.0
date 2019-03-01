Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D7C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A313206DD
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 09:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfCAJB0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:01:26 -0500
Received: from www62.your-server.de ([213.133.104.62]:39898 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCAJB0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 04:01:26 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gze2k-0004GC-9u; Fri, 01 Mar 2019 10:01:22 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gze2k-000GNI-2B; Fri, 01 Mar 2019 10:01:22 +0100
Subject: Re: [PATCH bpf-next v2 2/7] bpf: add program side {rd,wr}only support
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     ast@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        joe@wand.net.nz, john.fastabend@gmail.com, tgraf@suug.ch,
        yhs@fb.com, andriin@fb.com, lmb@cloudflare.com
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-3-daniel@iogearbox.net>
 <20190228195135.2a5f3277@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5f8bf633-6432-4521-8bfb-104897bece55@iogearbox.net>
Date:   Fri, 1 Mar 2019 10:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190228195135.2a5f3277@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 04:51 AM, Jakub Kicinski wrote:
> On Fri,  1 Mar 2019 00:18:24 +0100, Daniel Borkmann wrote:
>> This work adds two new map creation flags BPF_F_RDONLY_PROG
>> and BPF_F_WRONLY_PROG in order to allow for read-only or
>> write-only BPF maps from a BPF program side.
>>
>> Today we have BPF_F_RDONLY and BPF_F_WRONLY, but this only
>> applies to system call side, meaning the BPF program has full
>> read/write access to the map as usual while bpf(2) calls with
>> map fd can either only read or write into the map depending
>> on the flags. BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG allows
>> for the exact opposite such that verifier is going to reject
>> program loads if write into a read-only map or a read into a
>> write-only map is detected.
>>
>> We've enabled this generic map extension to various non-special
>> maps holding normal user data: array, hash, lru, lpm, local
>> storage, queue and stack. Further map types could be followed
>> up in future depending on use-case. Main use case here is to
>> forbid writes into .rodata map values from verifier side.
> 
> This will also enable optimizing the accesses on system with rich
> memory architecture :)

Nice! :)

>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>  include/linux/bpf.h           | 18 ++++++++++++++++++
>>  include/uapi/linux/bpf.h      | 10 +++++++++-
>>  kernel/bpf/arraymap.c         |  2 +-
>>  kernel/bpf/hashtab.c          |  2 +-
>>  kernel/bpf/local_storage.c    |  2 +-
>>  kernel/bpf/lpm_trie.c         |  2 +-
>>  kernel/bpf/queue_stack_maps.c |  3 +--
>>  kernel/bpf/verifier.c         | 30 +++++++++++++++++++++++++++++-
>>  8 files changed, 61 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index bdcc6e2a9977..3f74194dd4f6 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -427,6 +427,24 @@ struct bpf_array {
>>  	};
>>  };
>>  
>> +#define BPF_MAP_CAN_READ	BIT(0)
>> +#define BPF_MAP_CAN_WRITE	BIT(1)
>> +
>> +static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
>> +{
>> +	u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
>> +
>> +	/* Combination of BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG is
>> +	 * not possible.
>> +	 */
> 
> minor nit: we do check that old RDONLY and WRONLY are not set at the
>            same time, but here it's not done?

Good point indeed, I'll fix it in a v3 such that an invalid combination of
both, BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG, is rejected upon map creation.

>> +	if (access_flags & BPF_F_RDONLY_PROG)
>> +		return BPF_MAP_CAN_READ;
>> +	else if (access_flags & BPF_F_WRONLY_PROG)
>> +		return BPF_MAP_CAN_WRITE;
>> +	else
>> +		return BPF_MAP_CAN_READ | BPF_MAP_CAN_WRITE;
>> +}

Thanks,
Daniel
