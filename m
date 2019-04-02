Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E9C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 14:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCD32070B
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 14:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfDBOOG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:14:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:46160 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfDBOOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 10:14:06 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBKAo-0001pa-W7; Tue, 02 Apr 2019 16:13:59 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBKAo-000JU0-PC; Tue, 02 Apr 2019 16:13:58 +0200
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: add few verifier scale tests
To:     Alexei Starovoitov <ast@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "jannh@google.com" <jannh@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20190330001612.2354959-1-ast@kernel.org>
 <20190330001612.2354959-8-ast@kernel.org>
 <319e168a-6571-9a70-336a-6ecf8b61f040@iogearbox.net>
 <5753e047-163b-2a89-fb57-bdb1c01f1732@iogearbox.net>
 <b42e4d7f-a049-7487-98f7-4db901169ca3@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <35a0246d-006f-8e18-8da7-49f8ca440846@iogearbox.net>
Date:   Tue, 2 Apr 2019 16:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b42e4d7f-a049-7487-98f7-4db901169ca3@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25407/Tue Apr  2 09:54:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/02/2019 04:08 AM, Alexei Starovoitov wrote:
> On 4/1/19 9:35 AM, Daniel Borkmann wrote:
>> On 04/01/2019 04:17 PM, Daniel Borkmann wrote:
>>> On 03/30/2019 01:16 AM, Alexei Starovoitov wrote:
>>>> Add 3 basic tests that stress verifier scalability.
>>>>
>>>> test_verif_scale1.c calls non-inlined jhash() function 90 times on
>>>> different position in the packet.
>>>> This test simulates network packet parsing.
>>>> jhash function is ~140 instructions and main program is ~1200 insns.
>>>>
>>>> test_verif_scale2.c force inlines jhash() function 90 times.
>>>> This program is ~15k instructions long.
>>>>
>>>> test_verif_scale3.c calls non-inlined jhash() function 90 times on
>>>> But this time jhash has to process 32-bytes from the packet
>>>> instead of 14-bytes in tests 1 and 2.
>>>> jhash function is ~230 insns and main program is ~1200 insns.
>>>>
>>>> $ test_progs -s
>>>> can be used to see verifier stats.
>>>>
>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Do you also have some test cases with actual 1M insns resp. such that hit
>>> the new complexity limit to check timing / resources it consumes? I think
>>> these would be good to have as well as part of selftests.
>>
>> (Another thought on why it would be good to have such tests would be to
>> see if we would otherwise break long jumps again due to offset truncation
>> which we had in the core as well as in JITs in the past.)
> 
> llvm truncates jump offsets for large programs.
> Unfortunately we need to introduce JA instruction
> with 32-bit offset on kernel side before we can fix llvm.
> There are plenty of other scalability issues on the kernel side.
> This patch set is the first step.

Right.

> Only non-jumpy program of 1m insn loads and works.
> Realistically we're still far away from accepting large programs,
> but to get there we need to bump the limit and experience these issues.

I think my main worry is that if we're realistically still far away from
accepting 1M insns programs and have potential unknown blockers in the
road wrt verifying safety, then why lifting the limit for root to 1M
today already?

I think the complexity limit itself is fine, but why not being more
conservative on the number of instructions to something we believe
verifier can realistically handle /today/ wrt worst case consumptions in
case of complexity attacks, and go further from there? Once it's on 1M in
UAPI it's effectively frozen and then we'll be re-adding slightly similar
upper limits again which caps the 1M to something much lower (though I
doubt we'll see such large programs any time soon).

Thanks,
Daniel
