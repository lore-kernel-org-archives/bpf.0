Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82565C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D81C222DB
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 20:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbfBOUsf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:48:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:58446 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBOUse (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 15:48:34 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gujzA-0001AK-21; Fri, 15 Feb 2019 21:21:24 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gujz9-000LuD-S0; Fri, 15 Feb 2019 21:21:23 +0100
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
To:     Alexei Starovoitov <ast@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <b156837f-ed18-caf6-7120-5ecfabd4c5ed@fb.com>
 <20190215172515.GC31177@kernel.org>
 <0b1583e1-5e19-0685-7206-ab3e4bb20b70@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ebb687e2-4a68-5c7f-0f92-6d03e34c5bd0@iogearbox.net>
Date:   Fri, 15 Feb 2019 21:21:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0b1583e1-5e19-0685-7206-ab3e4bb20b70@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25361/Fri Feb 15 12:07:11 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/15/2019 07:47 PM, Alexei Starovoitov wrote:
> On 2/15/19 9:25 AM, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Feb 15, 2019 at 05:17:27PM +0000, Alexei Starovoitov escreveu:
>>> On 2/14/19 4:47 AM, Arnaldo Carvalho de Melo wrote:
>>>> I wonder if we should have a libbtf, with the same licensing as libbpf,
>>>> as, for instance, pahole would be interested only in the btf parts, be
>>>> it encoding, loading and pretty printing.
>>>
>>> I don't think it's possible to do such split.
>>> .btf.ext section only makes sense together with bpf prog.
>>
>> Well, that part, that is not about types and only makes sense together
>> with the BPF parts could stay in libbpf, no?
> 
> I don't see how.
> .btf.ext is using string section of .btf
> It's all connected.
> 
> Even if it was possible to somehow split them
> I think one big library is better than a bunch of smaller ones.
> It's written in C so .text size concern doesn't apply.

+1, I also think one single library is much better. Keeps dependency
management simple and only after ~3.5 years now mainstream distros
have finally started to ship libbpf as a package. Splitting would just
create more hassle for users and slow down wider adoption.

Thanks,
Daniel
