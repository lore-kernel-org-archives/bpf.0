Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA86C2B9F4
	for <bpf@archiver.kernel.org>; Tue, 22 Jun 2021 07:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB8E6128E
	for <bpf@archiver.kernel.org>; Tue, 22 Jun 2021 07:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFVHdw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:33:52 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46337 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVHdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 03:33:51 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 37827240009;
        Tue, 22 Jun 2021 07:31:33 +0000 (UTC)
Subject: Re: BPF calls to modules?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
 <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
 <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr>
 <CAADnVQ+vcdO2SLnEeo5R4=8bTrkQiv-x2Ejcg08OsoZJJ4RXhw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <56086fb4-3fdb-9e81-227c-721934fe2cb4@ghiti.fr>
Date:   Tue, 22 Jun 2021 09:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+vcdO2SLnEeo5R4=8bTrkQiv-x2Ejcg08OsoZJJ4RXhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

Le 22/06/2021 à 02:28, Alexei Starovoitov a écrit :
> On Sun, Jun 20, 2021 at 11:43 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi,
>>
>> Le 18/06/2021 à 19:32, Andrii Nakryiko a écrit :
>>> On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Hi guys,
>>>>
>>>> First, pardon my ignorance regarding BPF, the following might be silly.
>>>>
>>>> We were wondering here
>>>> https://patchwork.kernel.org/project/linux-riscv/patch/20210615004928.2d27d2ac@xhacker/
>>>> if BPF programs that now have the capability to call kernel functions
>>>> (https://lwn.net/Articles/856005/) can also call modules function or
>>>> vice-versa?
>>>
>>> Not yet, but it was an explicit design consideration and there was
>>> public interest just recently. So I'd say this is going to happen
>>> sooner rather than later.
>>>
>>>>
>>>> The underlying important fact is that in riscv, we are limited to 2GB
>>>> offset to call functions and that restricts where we can place modules
>>>> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
>>>> the current possibly wrong layout).
>>>>
>>>> So should we make sure that modules and BPF lie in the same 2GB region?
>>>
>>> Based on the above and what you are explaining about 2GB limits, I'd
>>> say yes?.. Or alternatively those 2GB restrictions might perhaps be
>>> lifted somehow?
>>
>>
>> Actually we have this limit when we have PC-relative branch which is our
>> current code model. To better understand what happened, I took a look at
>> our JIT implementation and noticed that BPF_CALL are implemented using
>> absolute addressing so for this pseudo-instruction, the limit I evoked
>> does not apply. How are the kernel (and modules) symbol addresses
>> resolved? Is it relative or absolute? Is there then any guarantee that a
>> kernel or module call will always emit a BPF_CALL?
> 
> Are those questions for riscv bpf JIT experts?

Yes more or less, sorry about that, I added Bjorn in cc in case he wants 
to intervene. But I think my last question is relevant: Is there then 
any guarantee that a kernel or module call will always emit a BPF_CALL? 
Because that would mean that we don't need to place BPF close to modules 
since BPF_CALL are JITed into an absolute branch in riscv.

Sorry to bother,

Thanks you for your time,

Alex

> Like 'relative or absolute' depends on arch.
> On x86-64 BPF_CALL is JITed into single x86 call instruction that
> has 32-bit immediate which is PC relative.
> Every JIT picks what's the best for that particular arch.
> 
