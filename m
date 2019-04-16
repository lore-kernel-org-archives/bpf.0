Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5DAC10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DED32054F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfDPMIB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:08:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:21527 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfDPMIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 08:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="316405879"
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.255.41.83])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2019 05:07:53 -0700
Subject: Re: Per-queue XDP programs, thoughts
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        maciej.fijalkowski@intel.com, Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>,
        Jonathan Lemon <bsd@fb.com>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
 <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
 <20190415183258.36dcee9a@carbon>
 <CAJ+HfNj63QcLY8=y1fF93PZd3XcfiGSrbbWdiGByjTzZQydSSg@mail.gmail.com>
 <87bm16uw9t.fsf@toke.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <9e32ce72-f677-51b3-9f54-f262f66793fc@intel.com>
Date:   Tue, 16 Apr 2019 14:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm16uw9t.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-04-16 11:36, Toke Høiland-Jørgensen wrote:
> Björn Töpel <bjorn.topel@gmail.com> writes:
> 
>> On Mon, 15 Apr 2019 at 18:33, Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>>>
>>>
>>> On Mon, 15 Apr 2019 13:59:03 +0200 Björn Töpel <bjorn.topel@intel.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> As you probably can derive from the amount of time this is taking, I'm
>>>> not really satisfied with the design of per-queue XDP program. (That,
>>>> plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinking
>>>> in this mail!
>>>>
>>>> Beware, it's kind of a long post, and it's all over the place.
>>>
>>> Cc'ing all the XDP-maintainers (and netdev).
>>>
>>>> There are a number of ways of setting up flows in the kernel, e.g.
>>>>
>>>> * Connecting/accepting a TCP socket (in-band)
>>>> * Using tc-flower (out-of-band)
>>>> * ethtool (out-of-band)
>>>> * ...
>>>>
>>>> The first acts on sockets, the second on netdevs. Then there's ethtool
>>>> to configure RSS, and the RSS-on-steriods rxhash/ntuple that can steer
>>>> to queues. Most users care about sockets and netdevices. Queues is
>>>> more of an implementation detail of Rx or for QoS on the Tx side.
>>>
>>> Let me first acknowledge that the current Linux tools to administrator
>>> HW filters is lacking (well sucks).  We know the hardware is capable,
>>> as DPDK have an full API for this called rte_flow[1]. If nothing else
>>> you/we can use the DPDK API to create a program to configure the
>>> hardware, examples here[2]
>>>
>>>   [1] https://doc.dpdk.org/guides/prog_guide/rte_flow.html
>>>   [2] https://doc.dpdk.org/guides/howto/rte_flow.html
>>>
>>>> XDP is something that we can attach to a netdevice. Again, very
>>>> natural from a user perspective. As for XDP sockets, the current
>>>> mechanism is that we attach to an existing netdevice queue. Ideally
>>>> what we'd like is to *remove* the queue concept. A better approach
>>>> would be creating the socket and set it up -- but not binding it to a
>>>> queue. Instead just binding it to a netdevice (or crazier just
>>>> creating a socket without a netdevice).
>>>
>>> Let me just remind everybody that the AF_XDP performance gains comes
>>> from binding the resource, which allow for lock-free semantics, as
>>> explained here[3].
>>>
>>> [3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF_XDP#where-does-af_xdp-performance-come-from
>>>
>>
>> Yes, but leaving the "binding to queue" to the kernel wouldn't really
>> change much. It would mostly be that the *user* doesn't need to care
>> about hardware details. My concern is about "what is a good
>> abstraction".
> 
> Can we really guarantee that we will make the right decision from inside
> the kernel, though?
>

Uhm, what do you mean here?


>>>
>>>> The socket is an endpoint, where I'd like data to end up (or get sent
>>>> from). If the kernel can attach the socket to a hardware queue,
>>>> there's zerocopy if not, copy-mode. Dito for Tx.
>>>
>>> Well XDP programs per RXQ is just a building block to achieve this.
>>>
>>> As Van Jacobson explain[4], sockets or applications "register" a
>>> "transport signature", and gets back a "channel".   In our case, the
>>> netdev-global XDP program is our way to register/program these transport
>>> signatures and redirect (e.g. into the AF_XDP socket).
>>> This requires some work in software to parse and match transport
>>> signatures to sockets.  The XDP programs per RXQ is a way to get
>>> hardware to perform this filtering for us.
>>>
>>>   [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf
>>>
>>
>> There are a lot of things that are missing to build what you're
>> describing above. Yes, we need a better way to program the HW from
>> Linux userland (old topic); What I fail to see is how per-queue XDP is
>> a way to get hardware to perform filtering. Could you give a
>> longer/complete example (obviously with non-existing features :-)), so
>> I get a better view what you're aiming for?
>>
>>
>>>
>>>> Does a user (control plane) want/need to care about queues? Just
>>>> create a flow to a socket (out-of-band or inband) or to a netdevice
>>>> (out-of-band).
>>>
>>> A userspace "control-plane" program, could hide the setup and use what
>>> the system/hardware can provide of optimizations.  VJ[4] e.g. suggest
>>> that the "listen" socket first register the transport signature (with
>>> the driver) on "accept()".   If the HW supports DPDK-rte_flow API we
>>> can register a 5-tuple (or create TC-HW rules) and load our
>>> "transport-signature" XDP prog on the queue number we choose.  If not,
>>> when our netdev-global XDP prog need a hash-table with 5-tuple and do
>>> 5-tuple parsing.
>>>
>>> Creating netdevices via HW filter into queues is an interesting idea.
>>> DPDK have an example here[5], on how to per flow (via ethtool filter
>>> setup even!) send packets to queues, that endup in SRIOV devices.
>>>
>>>   [5] https://doc.dpdk.org/guides/howto/flow_bifurcation.html
>>>
>>>
>>>> Do we envison any other uses for per-queue XDP other than AF_XDP? If
>>>> not, it would make *more* sense to attach the XDP program to the
>>>> socket (e.g. if the endpoint would like to use kernel data structures
>>>> via XDP).
>>>
>>> As demonstrated in [5] you can use (ethtool) hardware filters to
>>> redirect packets into VFs (Virtual Functions).
>>>
>>> I also want us to extend XDP to allow for redirect from a PF (Physical
>>> Function) into a VF (Virtual Function).  First the netdev-global
>>> XDP-prog need to support this (maybe extend xdp_rxq_info with PF + VF
>>> info).  Next configure HW filter to queue# and load XDP prog on that
>>> queue# that only "redirect" to a single VF.  Now if driver+HW supports
>>> it, it can "eliminate" the per-queue XDP-prog and do everything in HW.
>>>
>>
>> Again, let's try to be more concrete! So, one (non-existing) mechanism
>> to program filtering to HW queues, and then attaching a per-queue
>> program to that HW queue, which can in some cases be elided? I'm not
>> opposing the idea of per-queue, I'm just trying to figure out
>> *exactly* what we're aiming for.
>>
>> My concern is, again, mainly that is a queue abstraction something
>> we'd like to introduce to userland. It's not there (well, no really
>> :-)) today. And from an AF_XDP userland perspective that's painful.
>> "Oh, you need to fix your RSS hashing/flow." E.g. if I read what
>> Jonathan is looking for, it's more of something like what Jiri Pirko
>> suggested in [1] (slide 9, 10).
>>
>> Hey, maybe I just need to see the fuller picture. :-) AF_XDP is too
>> tricky to use from XDP IMO. Per-queue XDP program would *optimize*
>> AF_XDP, but not solving the filtering. Maybe starting in the
>> filtering/metadata offload path end of things, and then see what we're
>> missing.
>>
>>>
>>>> If we'd like to slice a netdevice into multiple queues. Isn't macvlan
>>>> or similar *virtual* netdevices a better path, instead of introducing
>>>> yet another abstraction?
>>>
>>> XDP redirect a more generic abstraction that allow us to implement
>>> macvlan.  Except macvlan driver is missing ndo_xdp_xmit. Again first I
>>> write this as global-netdev XDP-prog, that does a lookup in a BPF-map.
>>> Next I configure HW filters that match the MAC-addr into a queue# and
>>> attach simpler XDP-prog to queue#, that redirect into macvlan device.
>>>
>>
>> Just for context; I was thinking something like macvlan with
>> ndo_dfwd_add/del_station functionality. "A virtual interface that is
>> simply is a view of a physical". A per-queue program would then mean
>> "create a netdev for that queue".
> 
> My immediate reaction is that I kinda like this model from an API PoV;
> not sure what it would take to get there, though? When you say
> 'something like macvlan', you do mean we'd have to add something
> completely new, right?
>

Macvlan with that can be hw-offloaded is there today. XDP support is not 
in place.

The Mellanox subdev-work [1] (I just started to dig into the details)
looks like this (i.e. slicing a physical device). Personally I really
like this approach, but I need to dig into the details more.


Björn

[1] 
https://lore.kernel.org/netdev/1551418672-12822-1-git-send-email-parav@mellanox.com/

> -Toke
> 
