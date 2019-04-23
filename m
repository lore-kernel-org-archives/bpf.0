Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC2C10F03
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AEE21850
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDWQ6j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:58:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:45220 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfDWQ6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 12:58:39 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIyRM-0007oZ-6z; Tue, 23 Apr 2019 18:38:40 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIyRL-0007cM-Ui; Tue, 23 Apr 2019 18:38:40 +0200
Subject: Re: [PATCH bpf-next v6 0/9] net: flow_dissector: trigger BPF hook
 when called from eth_get_headlen
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
References: <20190422155552.222910-1-sdf@google.com>
 <20190423041503.np4dlso7c6qw3wfv@ast-mbp>
 <CANn89i+WFCQYxi-efjEBaAHY3rorornJ5dhGgQegBTkgwm1ZOQ@mail.gmail.com>
 <CANn89iJY3jYqanGGLgbR43ucTNYYu7bhgF=uaJCHgLg8_KEHsw@mail.gmail.com>
 <CAF=yD-K244NQghPTCLMhMJTrX3Kq73BUBK5d-dph1fYA3ONHMA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c814dc42-b71c-adc1-3c73-2e64967f83af@iogearbox.net>
Date:   Tue, 23 Apr 2019 18:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-K244NQghPTCLMhMJTrX3Kq73BUBK5d-dph1fYA3ONHMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25428/Tue Apr 23 10:00:55 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/23/2019 06:24 PM, Willem de Bruijn wrote:
> On Tue, Apr 23, 2019 at 12:21 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Apr 23, 2019 at 9:00 AM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Mon, Apr 22, 2019 at 9:15 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>>> Eric and Willem, could you please take a look as well
>>>> and hopefully ack it ?
>>>
>>> Sure, I am taking a look.
>>
>> For the series :
>>
>> Acked-by: Eric Dumazet <edumazet@google.com>
>>
>> Thanks
> 
> Just finished going over it as well.
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
> Very nice solution wrt testing.

Applied, thanks everyone!
