Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301BFC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 21:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090B520850
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 21:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCSVL5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:11:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:41320 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSVL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 17:11:57 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6M1b-00079z-SG; Tue, 19 Mar 2019 22:11:55 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6M1b-000307-NA; Tue, 19 Mar 2019 22:11:55 +0100
Subject: Re: bpf-next is OPEN
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        alexei.starovoitov@gmail.com
References: <31947a71-0ff8-df60-ce80-2e6a3fcbffcb@iogearbox.net>
 <CAMXgnP7oy2vQSrzgzSgNmikgVZYN7CL=1-q8qN62oystngdDEg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1ef1da61-1c92-1247-f243-4888f8266ba4@iogearbox.net>
Date:   Tue, 19 Mar 2019 22:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAMXgnP7oy2vQSrzgzSgNmikgVZYN7CL=1-q8qN62oystngdDEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25393/Tue Mar 19 08:54:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/19/2019 06:01 PM, Alban Crequy wrote:
> On Tue, 19 Mar 2019 at 09:56, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Merge window is closed, so new round begins.
>>
>> Thanks everyone,
>> Daniel
> 
> Thanks! I see that the bpf tree is more recent than the bpf-next tree:
> https://git.kernel.org/?q=BPF+Group
> 
> Does it need to be updated, or do I miss something?

Nope, done now, thanks!
