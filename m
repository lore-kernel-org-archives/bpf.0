Return-Path: <SRS0=hqV4=U2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24228C4321A
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05202208CB
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 21:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0VQ7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:16:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:34270 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 17:16:59 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hgblI-0007MF-8y; Thu, 27 Jun 2019 23:16:56 +0200
Received: from [178.193.45.231] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hgblI-0006dg-35; Thu, 27 Jun 2019 23:16:56 +0200
Subject: Re: [PATCH v2 bpf-next 3/7] libbpf: add kprobe/uprobe attach API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20190621045555.4152743-1-andriin@fb.com>
 <20190621045555.4152743-4-andriin@fb.com>
 <a7780057-1d70-9ace-960b-ff65867dc277@iogearbox.net>
 <CAEf4BzYy4Eorj0VxzArZg+V4muJCvDTX_VVfoouzZUcrBwTa1w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44d3b02d-b0fb-b0cb-a0d3-e7dd4bde0b92@iogearbox.net>
Date:   Thu, 27 Jun 2019 23:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYy4Eorj0VxzArZg+V4muJCvDTX_VVfoouzZUcrBwTa1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25493/Thu Jun 27 10:06:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/27/2019 12:15 AM, Andrii Nakryiko wrote:
> On Wed, Jun 26, 2019 at 7:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>> What this boils down to is that this should get a proper abstraction, e.g. as
>> in struct libbpf_event which holds the event object. There should be helper
>> functions like libbpf_event_create_{kprobe,uprobe,tracepoint,raw_tracepoint} returning
>> such an struct libbpf_event object on success, and a single libbpf_event_destroy()
>> that does the event specific teardown. bpf_program__attach_event() can then take
>> care of only attaching the program to it. Having an object for this is also more
>> extensible than just a fd number. Nice thing is that this can also be completely
>> internal to libbpf.c as with struct bpf_program and other abstractions where we
>> don't expose the internals in the public header.
> 
> Yeah, I totally agree, I think this is a great idea! I don't
> particularly like "event" name, that seems very overloaded term. Do
> you mind if I call this "bpf_hook" instead of "libbpf_event"? I've
> always thought about these different points in the system to which one
> can attach BPF program as hooks exposed from kernel :)
> 
> Would it also make sense to do attaching to non-tracing hooks using
> the same mechanism (e.g., all the per-cgroup stuff, sysctl, etc)? Not
> sure how people do that today, will check to see how it's done, but I
> think nothing should conceptually prevent doing that using the same
> abstract bpf_hook way, right?

I think if we abstract it this way, then absolutely. If I grok the naming conventions
from the README right, then this would be under 'bpf_hook__' prefix. :)

Thanks,
Daniel
