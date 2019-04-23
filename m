Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ECEC10F14
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 08:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96A20674
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 08:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDWI7B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:59:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:46496 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfDWI7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 04:59:01 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIqps-0000NP-7Q; Tue, 23 Apr 2019 10:31:28 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIqpr-0004ZE-T1; Tue, 23 Apr 2019 10:31:27 +0200
Subject: Re: [PATCH bpf-next v6 11/16] bpf, libbpf: support global
 data/bss/rodata sections
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Joe Stringer <joe@wand.net.nz>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, Jann Horn <jannh@google.com>,
        Andrey Ignatov <rdna@fb.com>
References: <20190409212018.32423-1-daniel@iogearbox.net>
 <20190409212018.32423-12-daniel@iogearbox.net>
 <CAEf4BzZkkA2DouqZXH=oG9NJ7Gq7YXK5+OL=RAYbVthxgt-zcQ@mail.gmail.com>
 <82026bc1-066d-9779-ec3a-83e086fc1780@iogearbox.net>
 <CAEf4BzbYZAsNkVkYddws7inyFkFGmwkQ9Yb0G2hUdw_5Kufgaw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <10337819-96ae-f6e2-8dae-355fb430c734@iogearbox.net>
Date:   Tue, 23 Apr 2019 10:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbYZAsNkVkYddws7inyFkFGmwkQ9Yb0G2hUdw_5Kufgaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25427/Mon Apr 22 09:56:03 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/23/2019 06:06 AM, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2019 at 5:58 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 04/19/2019 03:18 AM, Andrii Nakryiko wrote:
>>> On Tue, Apr 9, 2019 at 2:20 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>
>> [...]
>>>> +       def->type = BPF_MAP_TYPE_ARRAY;
>>>> +       def->key_size = sizeof(int);
>>>> +       def->value_size = data->d_size;
>>>> +       def->max_entries = 1;
>>>> +       def->map_flags = type == LIBBPF_MAP_RODATA ?
>>>> +                        BPF_F_RDONLY_PROG : 0;
>>>
>>> This is breaking BPF programs (even those that don't use global data,
>>> as they still have .rodata section, though I haven't investigated its
>>> contents) on kernels that don't yet support BPF_F_RDONLY_PROG flag
>>> yet. We probably need to probe support for that flag first, before
>>> using it. Just giving heads up, as I just discovered it trying to sync
>>> libbpf on github.
>>
>> Thanks for reporting! On a quick look test_progs (modulo global data test)
>> seems to pass with an slightly older kernel. I'll retry with a latest LLVM git
>> tree tomorrow with our test suite. Did you see a specific one failing or do you
>> have a reproducer in case it's something not covered where I could look into?
> 
> You need to add something like this to trigger .rodata section
> generation (BPF code doesn't have to use that struct, it just needs to
> be present):
> 
> const struct { int x, y; } bla = {};
> 
> This will cause libbpf to create a map for .rodata and specify
> BPF_F_RDONLY_PROG flag, which on older kernels will be rejected.

Fair enough, working on a fix in that case. Thanks!
