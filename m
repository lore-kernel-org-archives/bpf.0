Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36C6C433E0
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC75C2070A
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 17:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbhATReu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:34:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:44636 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbhATR2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 12:28:00 -0500
IronPort-SDR: c4Y1yAfWaSfzy6xi4dnXtv0RmxZpKivZrT6DtHF/YkKQsG3A9mz35RLx2I+u8uCSmYTd/MCpbF
 w8CN4qtvlzYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158920042"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="158920042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 09:26:36 -0800
IronPort-SDR: c0DiXwi0jxEJ3f1JM/E3RBGOAU42389H6sGWM//ZuedOqs5nN4SOZPtWNNV0vh36DD8uZWSM00
 hE+B6Ibb5d5A==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="384942904"
Received: from myegin-mobl1.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.249.42.133])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 09:26:29 -0800
Subject: Re: [PATCH bpf-next v2 1/8] xdp: restructure redirect actions
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-2-bjorn.topel@gmail.com> <87bldjeq1j.fsf@toke.dk>
 <996f1ff7-5891-fd4a-ee3e-fefd7e93879d@intel.com> <87mtx34q48.fsf@toke.dk>
 <0a7d1a0b-de2e-b973-a807-b9377bb89737@intel.com> <87bldj4lm6.fsf@toke.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <559c6eb8-38b3-4719-2368-397f07daf5a5@intel.com>
Date:   Wed, 20 Jan 2021 18:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87bldj4lm6.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-01-20 17:30, Toke Høiland-Jørgensen wrote:
> Björn Töpel <bjorn.topel@intel.com> writes:
> 
[...]
>>
>> It can't be free'd but, ri->map can be cleared via
>> bpf_clear_redirect_map(). So, between the helper (setting) and the
>> tracepoint in xdp_do_redirect() it can be cleared (say if the XDP
>> program is swapped out, prior running xdp_do_redirect()).
> 
> But xdp_do_redirect() should be called on driver flush before exiting
> the NAPI cycle, so how can the XDP program be swapped out?
> 

To clarify; xdp_do_redirect() is called for each packet in the NAPI poll 
loop.

Yeah, you're right. The xdp_do_redirect() is within the RCU scope, so
the program wont be destroyed (but can be swapped though!).

Hmm, so IOW the bpf_clear_redirect_map() is not needed anymore...


Björn

[...]
