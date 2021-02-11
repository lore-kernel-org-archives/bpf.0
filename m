Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A584C433E0
	for <bpf@archiver.kernel.org>; Thu, 11 Feb 2021 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E274C64DE2
	for <bpf@archiver.kernel.org>; Thu, 11 Feb 2021 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhBKPb5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Feb 2021 10:31:57 -0500
Received: from www62.your-server.de ([213.133.104.62]:35602 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhBKP1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 10:27:52 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lADrf-0005Ul-Ur; Thu, 11 Feb 2021 16:26:43 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lADrf-000J5I-NF; Thu, 11 Feb 2021 16:26:43 +0100
Subject: Re: [PATCH/v2] bpf: add bpf_skb_adjust_room flag
 BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        huangxuesen <hxseverything@gmail.com>
Cc:     David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        huangxuesen <huangxuesen@kuaishou.com>,
        Willem de Bruijn <willemb@google.com>,
        chengzhiyong <chengzhiyong@kuaishou.com>,
        wangli <wangli09@kuaishou.com>,
        Alan Maguire <alan.maguire@oracle.com>
References: <20210210065925.22614-1-hxseverything@gmail.com>
 <CAF=yD-LLzAheej1upLdBOeJc9d0RUXMrL9f9+QVC-4thj1EG5Q@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <29b5395f-daff-99f2-4a4b-6d462623a9fe@iogearbox.net>
Date:   Thu, 11 Feb 2021 16:26:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LLzAheej1upLdBOeJc9d0RUXMrL9f9+QVC-4thj1EG5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26077/Thu Feb 11 13:18:43 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/10/21 3:50 PM, Willem de Bruijn wrote:
> On Wed, Feb 10, 2021 at 1:59 AM huangxuesen <hxseverything@gmail.com> wrote:
>>
>> From: huangxuesen <huangxuesen@kuaishou.com>
>>
>> bpf_skb_adjust_room sets the inner_protocol as skb->protocol for packets
>> encapsulation. But that is not appropriate when pushing Ethernet header.
>>
>> Add an option to further specify encap L2 type and set the inner_protocol
>> as ETH_P_TEB.
>>
>> Suggested-by: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
>> Signed-off-by: chengzhiyong <chengzhiyong@kuaishou.com>
>> Signed-off-by: wangli <wangli09@kuaishou.com>
> 
> Thanks, this is exactly what I meant.
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
> One small point regarding Signed-off-by: It is customary to capitalize
> family and given names.

+1, huangxuesen, would be great if you could resubmit with capitalized names in
your SoB as well as From (both seem affected).

Thanks,
Daniel
