Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEDFC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 15:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE7E21850
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 15:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfBZP3z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:29:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:45218 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfBZP3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 10:29:55 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyefz-0004Ij-LW; Tue, 26 Feb 2019 16:29:47 +0100
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyefz-0007Yv-DV; Tue, 26 Feb 2019 16:29:47 +0100
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
To:     Alexei Starovoitov <ast@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <439aa0d4-3f31-1385-076a-bb8dab515bef@iogearbox.net>
 <24d2c526-3f9c-3101-ef60-d92777ebdcb7@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ae7a96a3-d70e-1885-db59-f9d0a55fb636@iogearbox.net>
Date:   Tue, 26 Feb 2019 16:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <24d2c526-3f9c-3101-ef60-d92777ebdcb7@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25372/Tue Feb 26 11:34:09 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/26/2019 05:27 AM, Alexei Starovoitov wrote:
> On 2/25/19 2:36 AM, Daniel Borkmann wrote:
>>
>> Not through the stack, but was more thinking something like low-overhead
>> kprobes-style extension for a BPF prog where such sequence would be added
>> 'inline' at beginning / exit of BPF prog invocation with normal ctx access
>> and helpers as the native program (e.g. time-stamping plus read/write into
>> mark as one example which kprobes couldn't do). But might go much beyond
>> context of this stats collection.
> 
> see below.
> 
>> That's actually an interesting thought, given the original prog->bpf_func
>> is a known address at that time, this could be templated where an inner
>> dummy bpf_func call to the normal BPF prog gets later replaced with the
>> actual prog->bpf_func address to have no indirect call. This would also
>> allow to keep the actual prog->bpf_func entry call-sites small and simple.
> 
> My first thought was that we indeed can have a template of stats
> collecting wrapper in .text,
> then at 'switch stats on' event vmalloc exec region, copy wrapper code
> into it and manually patch 'call foo' x86 insn with direct jump.
> That is still quite involved from coding side.
> It's similar to what kprobe/ftrace is doing, but probably
> an overkill for stats due to potential security
> concerns with new executable code.
> But it won't work due to tail_calls.

You mean for the scenario to measure the _individual_ progs that
are part of the given tail call processing such that each have
their individual inc in count and time-spent attribution. If so,
yeah, agree. Or for the case you have right now where everything
gets attributed to the "entry" program that triggers the tail
call processing? Latter would be similar as we have now in this
patch, imho.

> I've looked into single wrapper approach with indirect call
> (because it's much easer than patching x86) and realized it
> won't work for the same reason.
> Inline kprobe+kretprobe insertion won't work either.
> All because we have tail_calls.
> we cannot have executable epilogue in progs.
> tail_call will jmp into next prog and second part of stats collection
> won't run. Essentially no epilogue allowed unless we disable tail_call.
> Or we somehow reimplement tail_calls so that prog returns,
> an epilogue is executed and then jumps into the next prog.
> tail_call turned out be the worst corner case feature to deal with.

Agree, it's a pain as in most cases. Was more thinking that
'special' epilogue would inc the count, start first ktime/cycle
snapshot and then do a direct function call to the normally
JITed BPF prog (where it can do tail calls, etc, so nothing
changes there), and upon return from this call take the second
measurement, and update the per CPU buffer, similar as we have
now just with static keys approach. So, was thinking similar as
we JIT BPF-to-BPF calls on an individual prog basis.

> With static_key approach the main prog accounts the time
> of all progs called via tail_call.
> We can argue whether it's ideal semantics, but looks like
> it's the only thing we can do.

Yeah true, it's more about measuring how long the prog 'chain'
in the whole hook is taking to complete, which may be interesting
in itself, just perhaps a bit confusing when looking at individual
progs' share.

> I don't see a way how tail_called progs can count their own time.

Me neither, if so I guess it would be of similar fashion as you
have right now where it's accounted to the first prog.

> Stats would somehow need to be computed right before jumping
> into next prog. Which means heavy changes in all JITs
> plus extra performance cost at runtime, since such if (stats_on)
> check in tail_call handling would have to be done at runtime,
> since JITed code is read-only and regenerating progs due to stats
> is non-starter.
> Or tail-called next prog would need to update stats for previous
> prog, but there is no pointer to 'aux->stats' there.
> So imo that is dead end.
> static_key approach is the simplest by far.

It's simplest, yep. I guess if we get to the point of removing
indirect call for BPF_PROG_RUN itself, we might need to revisit
then and move it into bpf_func at that point. Kind of implementation
detail given we only expose count and time spent data to uapi,
though the direct switch at runtime may be a bit problematic in
future. Anyway, lets see how it goes when we get there.

Thanks,
Daniel
