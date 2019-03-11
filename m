Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC25C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80602087C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 23:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfCKXek (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:34:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:54114 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKXek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 19:34:40 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3URI-0003oO-3F; Tue, 12 Mar 2019 00:34:36 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3URH-0005CS-OF; Tue, 12 Mar 2019 00:34:35 +0100
Subject: Re: [PATCH rfc v3 bpf-next 2/9] bpf: add program side {rd,wr}only
 support for maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        joe@wand.net.nz, john.fastabend@gmail.com, yhs@fb.com,
        andrii.nakryiko@gmail.com, jakub.kicinski@netronome.com,
        tgraf@suug.ch, lmb@cloudflare.com
References: <20190311215125.17793-1-daniel@iogearbox.net>
 <20190311215125.17793-3-daniel@iogearbox.net>
 <20190311230643.hpbcxczrq46hnn7r@ast-mbp>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f2f8e86e-9cae-7ec3-3753-baed4a317efc@iogearbox.net>
Date:   Tue, 12 Mar 2019 00:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190311230643.hpbcxczrq46hnn7r@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/12/2019 12:06 AM, Alexei Starovoitov wrote:
> On Mon, Mar 11, 2019 at 10:51:18PM +0100, Daniel Borkmann wrote:
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
>> write-only map is detected. For read-only map case also some
>> helpers are forbidden for programs that would alter the map
>> state such as map deletion, update, etc.
>>
>> We've enabled this generic map extension to various non-special
>> maps holding normal user data: array, hash, lru, lpm, local
>> storage, queue and stack. Further map types could be followed
>> up in future depending on use-case. Main use case here is to
>> forbid writes into .rodata map values from verifier side.
> 
> I think WRONLY | WRONLY_PROG should be invalid combination?
> Since these attributes are set at creation time and cannot be changed,
> nothing can ever read from it, so why write into it?
> Similarly RDONLY | RDONLY_PROG is invalid too?

Yeah, I can add this. Note that 'these attributes are set at creation
time and cannot be changed' does not fully hold for WRONLY/RDONLY,
e.g. you can create a map as RDONLY, but later on retrieve fd by id
or from bpf fs but without RDONLY, so this fd will be able to write
into it from syscall side (we're checking struct file flags, not the
attributes' map flags at runtime). Given that I thought it made more
sense to keep these two logically separated since one is only revelant
for lifetime of fd and the other one for map. (I also think keeping
RDONLY/WRONLY stored in map_flags attr and exposing it is pretty
confusing since it doesn't say anything, this should probably be
masked out as a fix, thoughts?)

> Also looking at the next patch and 'lock' command...
> May be it would be cleaner to do add WRONCE (from syscall) flag?
> Then for .rodata the attrs will be RDONLY_PROG | WRONCE
> and no 'lock' necessary.
> WRONCE_PROG probably doesn't make sense.

Agree, from prog side not and would probably also just make fast-path
slower. Hm, for the WRONCE at creation flags, we'd need some form of
locking on syscall side to avoid racing I'd think. The lock cmd,
simply just does the write_once() and rcu sync to wait for everything
to complete, so this is pretty trivial w/o slowing down anything on
syscall side. I can take a look, but feels worse to me right now.
The other thing is, given RDONLY/WRONLY semantics are _only_ for fd
and _not_ map, mixing these might be confusing as well, since WRONCE
would then be a map property whereas RDONLY/WRONLY not.

> Storing dangling task_struct pointer in the next patch doesn't look great.

Hm, it's actually not dangling, on close we exchange it with NULL
(which current can never be) such that either root or only original
map creator may lock it as read-only.

> The whole 'lock' concept feels useful, but in the context of implementing
> .rodata it feels that WRONCE would be a better fit,
> since libbpf won't be able to make a mistake and forget to 'lock'.
> 'lock' syscall cmd can be confused with BPF_F_LOCK too.

That's a naming detail, but sure it can be changed. :)

Thanks,
Daniel
