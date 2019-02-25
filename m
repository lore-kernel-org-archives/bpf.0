Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7BC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F992087C
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 10:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfBYKgJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:36:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:60978 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfBYKgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 05:36:09 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyDcA-00060J-PD; Mon, 25 Feb 2019 11:36:02 +0100
Received: from [83.78.160.158] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyDcA-000WYy-Ed; Mon, 25 Feb 2019 11:36:02 +0100
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <20190223003434.GA17559@tower.DHCP.thefacebook.com>
 <8de20612-c32a-9370-254d-9ebf1df78efa@iogearbox.net>
 <20190223023810.5s7zyj4zqe6poigg@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <439aa0d4-3f31-1385-076a-bb8dab515bef@iogearbox.net>
Date:   Mon, 25 Feb 2019 11:36:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190223023810.5s7zyj4zqe6poigg@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25370/Sun Feb 24 14:23:00 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/23/2019 03:38 AM, Alexei Starovoitov wrote:
> On Sat, Feb 23, 2019 at 02:06:56AM +0100, Daniel Borkmann wrote:
>>
>> In general, having some stats and timing info would be useful, but I
>> guess people might want to customize it in future even more specifically
>> beyond number of runs + time it takes. One thing that would be super
>> useful is to have some notion of __attribute__((constructor)) and
>> __attribute__((destructor)) support in BPF which gets then inlined into
>> prologue / epilogue of program. E.g. such infrastructure would allow to
>> mark an skb and measure time it takes through the BPF prog till it hits
>> an exit point somewhere (without having to explicitly code this into the
>> program everywhere). Other examples may be histograms or p99 latencies
>> that might probably be useful. Feels like for monitoring more ways to
>> program would be nice and to move it into the BPF insns sequence (e.g.
>> enforced globally or by choice of prog as another option)? Thoughts?
> 
> the constructor/destructor you mean to capture the full sequence of tail_calls?
> Or full path of skb through the stack with all hook points?
> That is likely very useful without any bpf, but I think hw timestamping
> already serves that purpose.

Not through the stack, but was more thinking something like low-overhead
kprobes-style extension for a BPF prog where such sequence would be added
'inline' at beginning / exit of BPF prog invocation with normal ctx access
and helpers as the native program (e.g. time-stamping plus read/write into
mark as one example which kprobes couldn't do). But might go much beyond
context of this stats collection.

> I've been thinking about doing this stats per program
> (instead of static_key for all).
> Like replacing a bpf_prog->bpf_func with a wrapper function
> that does stats, but that is more costly in retpoline world
> due to extra indirect call.

That's actually an interesting thought, given the original prog->bpf_func
is a known address at that time, this could be templated where an inner
dummy bpf_func call to the normal BPF prog gets later replaced with the
actual prog->bpf_func address to have no indirect call. This would also
allow to keep the actual prog->bpf_func entry call-sites small and simple.

> Another alternative is to patch the stats in via JITs, but
> it's much more complex and error prone.
> So went with the simplest approach.

Pure BPF insns rewrite via JIT would indeed be unclear wrt per-cpu data
structures.

> With all stats ideas we need to be careful not to reintroduce what
> perf is already great at.

Yeah agree.

> These stats are _not_ for performance analysis. That's what perf does.
> These stats are for 24/7 monitoring to catch things that not suppose to happen.
Thanks,
Daniel
