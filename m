Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DFC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A4A205F4
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfCAXXC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:23:02 -0500
Received: from www62.your-server.de ([213.133.104.62]:34198 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXXC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:23:02 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrUZ-0005zh-Oy; Sat, 02 Mar 2019 00:22:59 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrUZ-000ALw-J5; Sat, 02 Mar 2019 00:22:59 +0100
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
References: <20190301210529.8218-1-daniel@iogearbox.net>
 <CAPhsuW4J52-hiYTb5X=-qYH-rRChiao26DFTjghf8x6N1xuNeg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e1250fdc-96f7-e020-eaff-7e0b67be9ead@iogearbox.net>
Date:   Sat, 2 Mar 2019 00:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4J52-hiYTb5X=-qYH-rRChiao26DFTjghf8x6N1xuNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/02/2019 12:18 AM, Song Liu wrote:
> On Fri, Mar 1, 2019 at 1:06 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Marek reported that he saw an issue with the below snippet in that
>> timing measurements where off when loaded as unpriv while results
>> were reasonable when loaded as privileged:
>>
>>     [...]
>>     uint64_t a = bpf_ktime_get_ns();
>>     uint64_t b = bpf_ktime_get_ns();
>>     uint64_t delta = b - a;
>>     if ((int64_t)delta > 0) {
>>     [...]
>>
>> Turns out there is a bug where a corner case is missing in the fix
>> d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
>> type from different paths"), namely fixup_bpf_calls() only checks
>> whether aux has a non-zero alu_state, but it also needs to test for
>> the case of BPF_ALU_NON_POINTER since in both occasions we need to
>> skip the masking rewrite (as there is nothing to mask).
>>
>> Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
>> Reported-by: Marek Majkowski <marek@cloudflare.com>
>> Reported-by: Arthur Fabre <afabre@cloudflare.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
>> ---
>>  [ Test case will be routed via bpf-next to avoid useless merge churn
>>    due to test_verifier rework in bpf-next. ]
>>
>>  kernel/bpf/verifier.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8f295b790297..5fcce2f4209d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6920,7 +6920,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>>                         u32 off_reg;
>>
>>                         aux = &env->insn_aux_data[i + delta];
>> -                       if (!aux->alu_state)
>> +                       if (!aux->alu_state ||
>> +                           aux->alu_state == BPF_ALU_NON_POINTER)
> 
> alu_state is a bitmap. Shall we check "aux->alu_state &
> BPF_ALU_NON_POINTER" here?

The state in this case can only ever be BPF_ALU_NON_POINTER, any other
setting from sanitize_val_alu() would be a violation.
