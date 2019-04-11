Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50716C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242802084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKVZH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:25:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:32840 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDKVZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 17:25:07 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEhBp-0003nM-4L; Thu, 11 Apr 2019 23:24:57 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEhBo-0003KE-SQ; Thu, 11 Apr 2019 23:24:56 +0200
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: add layer 2 encap support to
 bpf_skb_adjust_room
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        John Fastabend <john.fastabend@gmail.com>, rdna@fb.com,
        linux-kselftest@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
 <1554818803-4070-3-git-send-email-alan.maguire@oracle.com>
 <12f9cef4-f5ff-78a4-ec0f-42f737696735@iogearbox.net>
 <CAF=yD-LMZF2gU+AmKSgtzN3YDDiO=XF19kf7RNg5_8zNp2m93w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a71ff9c0-c7d6-005d-2776-6633273f0183@iogearbox.net>
Date:   Thu, 11 Apr 2019 23:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LMZF2gU+AmKSgtzN3YDDiO=XF19kf7RNg5_8zNp2m93w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/11/2019 11:18 PM, Willem de Bruijn wrote:
[...]
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 22eb2ed..a1654ef62 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -2969,11 +2969,14 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>>>  #define BPF_F_ADJ_ROOM_MASK          (BPF_F_ADJ_ROOM_FIXED_GSO | \
>>>                                        BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>>>                                        BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>>> -                                      BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
>>> +                                      BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>>> +                                      BPF_F_ADJ_ROOM_ENCAP_L2( \
>>> +                                       BPF_ADJ_ROOM_ENCAP_L2_MASK))
>>>
>>>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>>>                           u64 flags)
>>>  {
>>
>> One thing that it seems missing in this but also in Willem's earlier set
>> is that we reject these flags in bpf_skb_net_shrink(). Both are called from
>> bpf_skb_adjust_room(), so if we don't support decap yet we should reject
>> such flags so we can extend in future. Could you or Willem send a follow-up?
> 
> Indeed. Thanks for bringing that up, Daniel. I only thought of that
> after submitting the original patchset, too. Will send a patch.

Great, thanks, appreciated! :)
