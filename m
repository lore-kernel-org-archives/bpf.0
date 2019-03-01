Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B4AC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A133E20848
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfCAUGj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:06:39 -0500
Received: from www62.your-server.de ([213.133.104.62]:36628 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAUGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 15:06:39 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoQX-0005zG-0S; Fri, 01 Mar 2019 21:06:37 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoQW-0003H0-JY; Fri, 01 Mar 2019 21:06:36 +0100
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
 <CAEf4BzYx=05UXSkOpRdKzhXenXJpRYrukgnG7fGjTSR30wLz-Q@mail.gmail.com>
 <e8678d06-20e0-5501-7cff-62de57a2cdf2@fb.com>
 <CAEf4BzZWZmTFj0Xqf+_1QoT5E6tt7ijmzk39khgZ2zYfe0QFUw@mail.gmail.com>
 <e6157f2f-80e4-6a99-2053-498e0581a0db@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <93e20522-cafd-ee1f-1dc1-3cebab122588@iogearbox.net>
Date:   Fri, 1 Mar 2019 21:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <e6157f2f-80e4-6a99-2053-498e0581a0db@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 08:19 PM, Yonghong Song wrote:
> On 3/1/19 11:10 AM, Andrii Nakryiko wrote:
>> On Fri, Mar 1, 2019 at 10:58 AM Yonghong Song <yhs@fb.com> wrote:
>>> On 3/1/19 10:48 AM, Andrii Nakryiko wrote:
>>>> On Fri, Mar 1, 2019 at 10:31 AM Yonghong Song <yhs@fb.com> wrote:
>>>>> On 2/28/19 3:18 PM, Daniel Borkmann wrote:
[...]
>>>> Would it be reasonable to just plain disable usage of uninitialized
>>>> global variables, as it kind of goes against BPF's philosophy that
>>>> everything should be written to, before can be read? So while we can
>>>> just implicitly zero-out everything beforehand, it might be a good
>>>> idea to remind and enforce that explictly?
>>>
>>> There will be a verifier error, so the program with "int g" will not
>>> run, the same as today.
>>
>> Yeah, I understand, but with pretty obscure error about not supporting
>> relocations and stuff, right?
>>
>>>
>>> We could improve by flagging the error at compiler error or libbpf time.
>>
>> So that's my point, that having compiler emit nicer error for
>> target=bpf would be nice touch to user experience :)
> 
> I just removed a compiler error for static variables...
> 
> I will wait for this patch lands, hear people complains (either need to
> support "int g;" or need better error messages, etc.) and then decide
> what next to do ...

By the way, from LLVM side, do you think it makes sense for local vars
where you encode the offset into insn->imm to already encode it into
(insn+1)->imm of the ldimm64, so that loaders can just pass this offset
through instead of fixing it up like I did? I'm fine either way though,
just thought might be worth pointing out while we're at it. :)

Thanks,
Daniel
