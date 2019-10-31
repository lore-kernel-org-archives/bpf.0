Return-Path: <SRS0=z7FJ=YY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC4FCA9ECB
	for <bpf@archiver.kernel.org>; Thu, 31 Oct 2019 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECE32087F
	for <bpf@archiver.kernel.org>; Thu, 31 Oct 2019 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJaWin (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:38:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:41483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJaWin (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 18:38:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 15:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400"; 
   d="scan'208";a="194483061"
Received: from unknown (HELO [10.241.228.161]) ([10.241.228.161])
  by orsmga008.jf.intel.com with ESMTP; 31 Oct 2019 15:38:42 -0700
To:     bjorn.topel@gmail.com
Cc:     alexei.starovoitov@gmail.com, bjorn.topel@intel.com,
        bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        jakub.kicinski@netronome.com, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        sridhar.samudrala@intel.com, toke@redhat.com, tom.herbert@intel.com
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
From:   "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
Date:   Thu, 31 Oct 2019 15:38:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


[...]
> >
> > With mitigations ON
> > -------------------
> > Samples: 6K of event 'cycles', 4000 Hz, Event count (approx.): 5646512726
> > bpf_prog_3c8251c7e0fef8db  bpf_prog_3c8251c7e0fef8db [Percent: local period]
> >   45.05      push   %rbp
> >    0.02      mov    %rsp,%rbp
> >    0.03      sub    $0x8,%rsp
> >   22.09      push   %rbx

> [...]
> >
> > Do you see any issues with this data? With mitigations ON push %rbp and push %rbx overhead seems to
> > be pretty high.

> That's sample skid from the retpoline thunk when entring the XDP
> program. Pretty expensive push otherwise! :-)

> Another thought; Disclaimer: I'm no spectrev2 expert, and probably not
> getting the mitigations well enough. So this is me trying to swim at
> the deep end! Would it be possible to avoid the retpoline when
> entering the XDP program. At least for some XDP program that can be
> proved "safe"? If so, PeterZ's upcoming static_call could be used from
> the driver side.

Alexei, Jakub

Do you think it will be possible to avoid this overhead when mitigations are turned ON?
The other part of the overhead is going through the redirect path.

Can i assume that your silence as an indication that you are now okay with optional bypass
flag as long as it doesn't effect the normal XDP datapath. If so, i will respin and submit
the patches against the latest bpf-next

-Sridhar
