Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E05C433E0
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CAF64EAF
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 12:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZMFA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Feb 2021 07:05:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:14641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZMFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 07:05:00 -0500
IronPort-SDR: Nzo+EM0mbrdKW3SAOwlTtsjr9cxyhTMRi6yTKaQaibAfjSXswTWmO8SlHOorvYA0/Rr4BiP6Jc
 9VNYNQKpqjnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="249913932"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="249913932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 04:04:15 -0800
IronPort-SDR: Lq0gBVk650mlokzZ75LQqv+nsiNOJz9qhpFV1C07EYhvC4kOnuEY7axMSBeX6zjrCQsCBqqqZD
 5elRdckWBc5Q==
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="404875251"
Received: from hkarray-mobl2.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.252.60.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 04:04:07 -0800
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: make bpf_redirect_map() a map
 operation
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     maciej.fijalkowski@intel.com, hawk@kernel.org,
        magnus.karlsson@intel.com, john.fastabend@gmail.com,
        kuba@kernel.org, davem@davemloft.net
References: <20210226112322.144927-1-bjorn.topel@gmail.com>
 <20210226112322.144927-2-bjorn.topel@gmail.com> <87sg5jys8r.fsf@toke.dk>
 <694101a1-c8e2-538c-fdd5-c23f8e2605bb@intel.com>
Message-ID: <d4910425-82ae-b1ce-68c3-fb5542f598a5@intel.com>
Date:   Fri, 26 Feb 2021 13:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <694101a1-c8e2-538c-fdd5-c23f8e2605bb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2021-02-26 12:40, Björn Töpel wrote:
> On 2021-02-26 12:37, Toke Høiland-Jørgensen wrote:

[...]

>>
>> (That last paragraph above is why I asked if you updated the performance
>> numbers in the cover letter; removing an additional function call should
>> affect those, right?)
>>
> 
> Yeah, it should. Let me spend some more time benchmarking on the DEVMAP
> scenario.
>

I did a re-measure using samples/xdp_redirect_map.

The setup is 64B packets blasted to an i40e. As a baseline,

   # xdp_rxq_info --dev ens801f1 --action XDP_DROP

gives 24.8 Mpps.


Now, xdp_redirect_map. Same NIC, two ports, receive from port A,
redirect to port B:

baseline:    14.3 Mpps
this series: 15.4 Mpps

which is almost 8%!


Björn
