Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8DC10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1220652
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 10:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfDPKPZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:15:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfDPKPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 06:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A534C05242C;
        Tue, 16 Apr 2019 10:15:24 +0000 (UTC)
Received: from [10.72.12.102] (ovpn-12-102.pek2.redhat.com [10.72.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C8F1001E8C;
        Tue, 16 Apr 2019 10:15:13 +0000 (UTC)
Subject: Re: Per-queue XDP programs, thoughts
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ilias.apalodimas@linaro.org, toke@redhat.com,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
 <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
 <20190415183258.36dcee9a@carbon>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6040c4ce-88e1-d8ed-30e6-c89bafaab294@redhat.com>
Date:   Tue, 16 Apr 2019 18:15:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183258.36dcee9a@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Apr 2019 10:15:24 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2019/4/16 上午12:32, Jesper Dangaard Brouer wrote:
>> If we'd like to slice a netdevice into multiple queues. Isn't macvlan
>> or similar*virtual*  netdevices a better path, instead of introducing
>> yet another abstraction?
> XDP redirect a more generic abstraction that allow us to implement
> macvlan.  Except macvlan driver is missing ndo_xdp_xmit. Again first I
> write this as global-netdev XDP-prog, that does a lookup in a BPF-map.
> Next I configure HW filters that match the MAC-addr into a queue# and
> attach simpler XDP-prog to queue#, that redirect into macvlan device.


I'm afraid what we want is a full XDP support for macvlan (RX) not only 
a XDP TX support? This could not be done through XDP_REDIRECT. If we 
want to use  XDP_REDIRECT, we should implement XDP support for ifb then 
redirect packet there.

Thanks

