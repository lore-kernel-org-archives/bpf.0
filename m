Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0EC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED0C20851
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 13:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCHN0I (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:26:08 -0500
Received: from www62.your-server.de ([213.133.104.62]:56448 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHN0H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 08:26:07 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2FVm-0002un-68; Fri, 08 Mar 2019 14:26:06 +0100
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2FVl-0004HV-PJ; Fri, 08 Mar 2019 14:26:05 +0100
Subject: Re: [PATCH bpf 1/2] xsk: fix to reject invalid flags in xsk_bind
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <20190308075727.19358-1-bjorn.topel@gmail.com>
 <20190308075727.19358-2-bjorn.topel@gmail.com>
 <20190308105907.00000518@gmail.com>
 <CAJ+HfNjtiT7v87OEF5kWikVdHro_hKXuC=Cm+gKYKS-3isyS7A@mail.gmail.com>
 <20190308114620.000067e7@gmail.com>
 <CAJ+HfNjGzjkf-LGOvprJrUd+LVu7BN5FV2CRmwGXTRxDBD1JBg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <91b16f06-9a3d-603c-37f1-9f617fac5793@iogearbox.net>
Date:   Fri, 8 Mar 2019 14:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAJ+HfNjGzjkf-LGOvprJrUd+LVu7BN5FV2CRmwGXTRxDBD1JBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25382/Fri Mar  8 09:55:42 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/08/2019 12:06 PM, Björn Töpel wrote:
> On Fri, 8 Mar 2019 at 11:46, Maciej Fijalkowski
> <maciejromanfijalkowski@gmail.com> wrote:
[...]
>>>> So maybe check here also that only one particular flag is set by doing:
>>>>
>>>> if (hweight32(flags & (XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY)) > 1)
>>>>         return -EINVAL;
>>>>
>>>> just like we do it for IFLA_XDP_FLAGS in net/core/rtnetlink.c?
>>>
>>> We have flag semantic checks further down, and my rational was to
>>> *only* check unknown flags first. IMO the current patch is easier to
>>> understand, than your suggested one.
>>
>> Hmm thought that bailing out earlier would be better and we could drop the
>> actual copy flags checks for shared umem. For xdp_umem_assign_dev() instead of
>> passing flags you could just pass a boolean whether you're doing zero copy or
>> not. And that brings up the question whether we really need a XDP_COPY flag?
> 
> I'd prefer doing that as a follow-up patch.

Ok, follow-up for Maciej's suggestion is fine, imho, it would definitely make
it more obvious resp. future proof such that rejecting some invalid combination
doesn't get missed under some branch. Given it's currently not the case aside
from the fix, rolling this into your next patches for bpf-next might be best.
In any case, fixes look good, so applied, thanks!

> XDP_COPY is needed to explicitly enable copy-mode. No flags is "select
> the best option", and COPY/ZEROCOPY is to explicitly select a mode.
