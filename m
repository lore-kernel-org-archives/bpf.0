Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DCC433F5
	for <bpf@archiver.kernel.org>; Fri,  4 Mar 2022 06:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiCDGwK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Mar 2022 01:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCDGwI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 01:52:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3318DA8E;
        Thu,  3 Mar 2022 22:51:22 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8z4T4nkZzdZpx;
        Fri,  4 Mar 2022 14:50:01 +0800 (CST)
Received: from [10.174.177.215] (10.174.177.215) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 14:51:19 +0800
Subject: Re: [PATCH bpf-next v2 2/4] bpf, sockmap: Fix memleak in
 tcp_bpf_sendmsg while sk msg is full
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     <john.fastabend@gmail.com>, <daniel@iogearbox.net>,
        <jakub@cloudflare.com>, <lmb@cloudflare.com>,
        <davem@davemloft.net>, <edumazet@google.com>,
        <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <ast@kernel.org>, <andrii@kernel.org>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <kpsingh@kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20220302022755.3876705-1-wangyufen@huawei.com>
 <20220302022755.3876705-3-wangyufen@huawei.com>
 <YiAQWaVPEmfpiale@pop-os.localdomain>
From:   wangyufen <wangyufen@huawei.com>
Message-ID: <a7788a20-3be8-b3e3-2c19-ca2d7d18e238@huawei.com>
Date:   Fri, 4 Mar 2022 14:51:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YiAQWaVPEmfpiale@pop-os.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


ÔÚ 2022/3/3 8:48, Cong Wang Ð´µÀ:
> On Wed, Mar 02, 2022 at 10:27:53AM +0800, Wang Yufen wrote:
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index 9b9b02052fd3..ac9f491cc139 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -421,8 +421,10 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>>   		osize = msg_tx->sg.size;
>>   		err = sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
>>   		if (err) {
>> -			if (err != -ENOSPC)
>> +			if (err != -ENOSPC) {
>> +				sk_msg_trim(sk, msg_tx, osize);
>>   				goto wait_for_memory;
> Is it a good idea to handle this logic inside sk_msg_alloc()?

Yes, I think you're right.

Other call paths of sk_msg_alloc() have the similar problem, such as 
tls_sw_sendmsg(),

will do in v3.


Thanks.

> .
