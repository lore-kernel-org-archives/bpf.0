Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E0C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DD720693
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDPKlX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:41:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfDPKlX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 06:41:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CDC3308339E;
        Tue, 16 Apr 2019 10:41:23 +0000 (UTC)
Received: from [10.72.12.102] (ovpn-12-102.pek2.redhat.com [10.72.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 773885D71A;
        Tue, 16 Apr 2019 10:41:10 +0000 (UTC)
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
        Thomas Monjalon <thomas@monjalon.net>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
 <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
 <20190415183258.36dcee9a@carbon>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7994d3c1-2e8f-6fa3-928d-31c24e91ebe0@redhat.com>
Date:   Tue, 16 Apr 2019 18:41:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183258.36dcee9a@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 16 Apr 2019 10:41:23 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2019/4/16 上午12:32, Jesper Dangaard Brouer wrote:
>> XDP is something that we can attach to a netdevice. Again, very
>> natural from a user perspective. As for XDP sockets, the current
>> mechanism is that we attach to an existing netdevice queue. Ideally
>> what we'd like is to*remove*  the queue concept. A better approach
>> would be creating the socket and set it up -- but not binding it to a
>> queue. Instead just binding it to a netdevice (or crazier just
>> creating a socket without a netdevice).


Isn't XDP support for TUN/TAP just a good example of this. It hides the 
all details and depends on XDP_REDIRECT to work. This allows the eBPF 
program or other steering tool to do anything it want on host. You can 
implement AF_XDP ring layout mmap for TUN/TAP or just use 
vhost_net(virtio ring layout) instead.

Thanks

