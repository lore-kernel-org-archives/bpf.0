Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04356C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF522083D
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCAX1T (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:27:19 -0500
Received: from www62.your-server.de ([213.133.104.62]:34834 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAX1T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:27:19 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrYj-0006HO-57; Sat, 02 Mar 2019 00:27:17 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrYi-000RXx-U7; Sat, 02 Mar 2019 00:27:16 +0100
Subject: Re: [PATCH bpf-next] bpf: add test cases for non-pointer sanitiation
 logic
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
References: <20190301210821.8330-1-daniel@iogearbox.net>
 <CAPhsuW7KwUns7WeAqx3s1Po0Vif0fvp8mZRYvpVm-nFtYzTYTg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aa825653-85f1-63c0-0dce-5963ab0aaeb1@iogearbox.net>
Date:   Sat, 2 Mar 2019 00:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7KwUns7WeAqx3s1Po0Vif0fvp8mZRYvpVm-nFtYzTYTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/02/2019 12:22 AM, Song Liu wrote:
> On Fri, Mar 1, 2019 at 1:10 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Add two additional tests for further asserting the
>> BPF_ALU_NON_POINTER logic with cases that were missed
>> previously.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Marek Majkowski <marek@cloudflare.com>
>> Cc: Arthur Fabre <afabre@cloudflare.com>
>> ---
>>  .../selftests/bpf/verifier/value_ptr_arith.c  | 44 ++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
>> index 4b721a77bebb..c3de1a2c9dc5 100644
>> --- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
>> +++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
>> @@ -173,7 +173,7 @@
>>         .retval = 0,
>>  },
>>  {
>> -       "sanitation: alu with different scalars",
>> +       "sanitation: alu with different scalars 1",
>>         .insns = {
>>         BPF_MOV64_IMM(BPF_REG_0, 1),
>>         BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
>> @@ -198,6 +198,48 @@
>>         .result = ACCEPT,
>>         .retval = 0x100000,
>>  },
>> +{
>> +       "sanitation: alu with different scalars 2",
>> +       .insns = {
>> +       BPF_MOV64_IMM(BPF_REG_0, 1),
>> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
>> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
>> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
>> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
>> +       BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
>> +       BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
>> +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
>> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
>> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
>> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
>> +       BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
>> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
>> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
>> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
>> +       BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
>> +       BPF_EXIT_INSN(),
>> +       },
>> +       .fixup_map_array_48b = { 1 },
>> +       .result = ACCEPT,
>> +       .retval = -EINVAL * 2,
> 
> Why "-EINVAL * 2" here?

This is array map so deletion will return -EINVAL, basically I
wanted to get a test case under socket filters where helper
returns a stable value which is then unknown scalar to do some
alu64 op with where sanitation logic triggers. So map_delete_elem()
came in handy for that test.

Thanks,
Daniel
