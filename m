Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A2C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7733720823
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfCBAKA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:10:00 -0500
Received: from www62.your-server.de ([213.133.104.62]:40708 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCBAKA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 19:10:00 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzsE1-0001Rl-HX; Sat, 02 Mar 2019 01:09:57 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzsE1-000JKw-Bf; Sat, 02 Mar 2019 01:09:57 +0100
Subject: Re: [PATCH bpf-next] bpf: add test cases for non-pointer sanitiation
 logic
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
References: <20190301210821.8330-1-daniel@iogearbox.net>
 <CAPhsuW7KwUns7WeAqx3s1Po0Vif0fvp8mZRYvpVm-nFtYzTYTg@mail.gmail.com>
 <aa825653-85f1-63c0-0dce-5963ab0aaeb1@iogearbox.net>
 <CAPhsuW7dmvG-Uz2WJujerw3b7on6j8CJt9zfuojU9m2AAsiK_A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e7465593-866d-1479-e7dc-4891774563ee@iogearbox.net>
Date:   Sat, 2 Mar 2019 01:09:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7dmvG-Uz2WJujerw3b7on6j8CJt9zfuojU9m2AAsiK_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/02/2019 01:04 AM, Song Liu wrote:
> On Fri, Mar 1, 2019 at 3:27 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 03/02/2019 12:22 AM, Song Liu wrote:
>>> On Fri, Mar 1, 2019 at 1:10 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
> 
> I see, so the *2 comes from
> 
> BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7)

Yes, exactly the place we need to test for here.

> Thanks for the explanation.

np

Thanks,
Daniel
