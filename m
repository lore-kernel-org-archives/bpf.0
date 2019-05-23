Return-Path: <SRS0=Im41=TX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDDFC282DD
	for <bpf@archiver.kernel.org>; Thu, 23 May 2019 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CF02133D
	for <bpf@archiver.kernel.org>; Thu, 23 May 2019 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfEWOCq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 May 2019 10:02:46 -0400
Received: from www62.your-server.de ([213.133.104.62]:54344 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWOCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 10:02:46 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hToIt-0004YC-Qj; Thu, 23 May 2019 16:02:44 +0200
Received: from [178.197.249.12] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hToIt-000Lvm-JO; Thu, 23 May 2019 16:02:43 +0200
Subject: Re: [PATCH bpf] selftests: bpf: add zero extend checks for ALU32
 and/or/xor
To:     Y Song <ys114321@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20190522092323.17435-1-bjorn.topel@gmail.com>
 <CAH3MdRWGeYZDCEPrw2HFpnq+8j+ehMj2uhNJS9HnFDw=LmK6PQ@mail.gmail.com>
 <CAJ+HfNhR2UozhqTrhDTmZNntmjRCWFyPyU2AaRdo-E6sJUZCKg@mail.gmail.com>
 <CAH3MdRX6gocSFJCkuMuhko+0eheWqKq4Y4X-Tb3q=hzMW5buyw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c1f90672-d2ce-0ac9-10d1-08208575f193@iogearbox.net>
Date:   Thu, 23 May 2019 16:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH3MdRX6gocSFJCkuMuhko+0eheWqKq4Y4X-Tb3q=hzMW5buyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25458/Thu May 23 09:58:32 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/23/2019 08:38 AM, Y Song wrote:
> On Wed, May 22, 2019 at 1:46 PM Björn Töpel <bjorn.topel@gmail.com> wrote:
>> On Wed, 22 May 2019 at 20:13, Y Song <ys114321@gmail.com> wrote:
>>> On Wed, May 22, 2019 at 2:25 AM Björn Töpel <bjorn.topel@gmail.com> wrote:
>>>>
>>>> Add three tests to test_verifier/basic_instr that make sure that the
>>>> high 32-bits of the destination register is cleared after an ALU32
>>>> and/or/xor.
>>>>
>>>> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
>>>
>>> I think the patch intends for bpf-next, right? The patch itself looks
>>> good to me.
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>> Thank you. Actually, it was intended for the bpf tree, as a test
>> follow up for this [1] fix.
> Then maybe you want to add a Fixes tag and resubmit?

Why would the test case need a fixes tag? It's common practice that we have
BPF fixes that we queue to bpf tree along with kselftest test cases related
to them. Therefore, applied as well, thanks for following up!

Björn, in my email from the fix, I mentioned we should have test snippets
ideally for all of the alu32 insns to not miss something falling through the
cracks when JITs get added or changed. If you have some cycles to add the
remaining missing ones, that would be much appreciated.

Thanks,
Daniel
