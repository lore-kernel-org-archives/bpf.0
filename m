Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC4C433EF
	for <bpf@archiver.kernel.org>; Thu,  3 Mar 2022 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiCCPw1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCCPw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 10:52:26 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5E1959D7
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 07:51:41 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPnju-0001iQ-Qd; Thu, 03 Mar 2022 16:51:38 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPnju-0005xW-K8; Thu, 03 Mar 2022 16:51:38 +0100
Subject: Re: [PATCH v5 bpf-next] Small BPF verifier log improvements
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220301222745.1667206-1-mykolal@fb.com>
 <20220302212302.y7ct3xgkpwu4dto3@ast-mbp.dhcp.thefacebook.com>
 <d4e589ac-db4d-b721-580c-120ee524084d@iogearbox.net>
 <CAADnVQLEbDrKt-ehyR=FqMfxcWLL0Tg6i7cKY+jjybBJLn+E0w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9449f4fa-4361-f550-5954-a855280611ce@iogearbox.net>
Date:   Thu, 3 Mar 2022 16:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQLEbDrKt-ehyR=FqMfxcWLL0Tg6i7cKY+jjybBJLn+E0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26470/Thu Mar  3 10:49:16 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/22 11:13 PM, Alexei Starovoitov wrote:
> On Wed, Mar 2, 2022 at 1:46 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 3/2/22 10:23 PM, Alexei Starovoitov wrote:
>>> On Tue, Mar 01, 2022 at 02:27:45PM -0800, Mykola Lysenko wrote:
>>>>               .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>>>>               .matches = {
>>>> -                    {6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>>>> -                    {7, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>>>> -                    {8, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>>>> -                    {9, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>>>> -                    {10, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
>>>> -                    {11, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>>>> -                    {12, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
>>>> -                    {13, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>>>> -                    {14, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
>>>> -                    {15, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
>>>> +                    {6, "R3_w=scalar(umax=255,var_off=(0x0; 0xff))"},
>>>> +                    {7, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>>>> +                    {8, "R4_w=scalar(umax=255,var_off=(0x0; 0xff))"},
>>>> +                    {9, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>>>> +                    {10, "R4_w=scalar(umax=510,var_off=(0x0; 0x1fe))"},
>>>> +                    {11, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>>>> +                    {12, "R4_w=scalar(umax=1020,var_off=(0x0; 0x3fc))"},
>>>> +                    {13, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>>>> +                    {14, "R4_w=scalar(umax=2040,var_off=(0x0; 0x7f8))"},
>>>> +                    {15, "R4_w=scalar(umax=4080,var_off=(0x0; 0xff0))"},
>>>
>>> Sorry for the later review.
>>> Would "int" be more precise and less verbose than "scalar"?
>>
>> Could work as well, although in many places today we make use of the term "scalar",
>> so developers might be more familiar with it (and more consistent towards the
>> verifier type internals).
> 
> I was focusing more on users who will see these logs and
> would have to interpret them.
> I suspect the ratio is 1 developer to 1000 users.
> The users have to fight the verifier quite a bit to make the program pass.
> I was thinking about "i64" too. That's what llvm is using,
> but it's less clear than "int", which should be obvious
> for users since they write progs in C.
> It's also shorter.
> 
> I can live with "scalar" though.

Imho, 'scalar' fits best. 'i64' would still be better then 'int' as it could imply
different width. Anyway, can push it out in a bit.
