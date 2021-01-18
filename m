Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC32C433DB
	for <bpf@archiver.kernel.org>; Mon, 18 Jan 2021 11:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42DC229C6
	for <bpf@archiver.kernel.org>; Mon, 18 Jan 2021 11:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbhARLBd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Jan 2021 06:01:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:16159 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389878AbhARLBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 06:01:04 -0500
IronPort-SDR: B0piDeVjz2hTctdGASIau79cll5GJL7RisBxBnmdUF6HzH2glQgv91hfjbjmFUv4Qo1LHwtW6W
 c3iQNRFZrXWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="176216315"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="176216315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 03:00:21 -0800
IronPort-SDR: SI6gr806GXxCKMq/rUxDic/nHEU2ShXDQOzPfk/q5XaQITz0ThlumdIW7FGz+yJyaL4DcUYuTx
 UpVvwoynYRkQ==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="355148105"
Received: from fbackhou-mobl.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.249.41.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 03:00:19 -0800
Subject: Re: [PATCH bpf-next] samples/bpf: add BPF_ATOMIC_OP macro for BPF
 samples
To:     Brendan Jackman <jackmanb@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, magnus.karlsson@intel.com
References: <20210118091753.107572-1-bjorn.topel@gmail.com>
 <CA+i-1C1A6wdv3vh4=qLsc6GoOSiD=Wc_oe=PhWKE6tHZ_NQnsg@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <0d7d272f-5b7f-0e0b-8429-bb368ce57d1e@intel.com>
Date:   Mon, 18 Jan 2021 12:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+i-1C1A6wdv3vh4=qLsc6GoOSiD=Wc_oe=PhWKE6tHZ_NQnsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-01-18 11:57, Brendan Jackman wrote:
> I actually deliberately skipped this file, thinking that people were
> unlikely to want to add assembly-based atomics code under samples/
> 
> I guess it's nice for people to be able to e.g. move/copy code from
> the selftests.
>

Yes, that, and the fact that one sample broke w/o the BPF_ATOMIC_OP.


> On Mon, 18 Jan 2021 at 10:18, Björn Töpel <bjorn.topel@gmail.com> wrote:
>>
>> From: Björn Töpel <bjorn.topel@intel.com>
>>
>> Brendan Jackman added extend atomic operations to the BPF instruction
>> set in commit 7064a7341a0d ("Merge branch 'Atomics for eBPF'"), which
>> introduces the BPF_ATOMIC_OP macro. However, that macro was missing
>> for the BPF samples. Fix that by adding it into bpf_insn.h.
>>
>> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
> 
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
>

Thanks!
Björn

