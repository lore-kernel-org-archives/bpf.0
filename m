Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60436C43334
	for <bpf@archiver.kernel.org>; Mon, 11 Jul 2022 07:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiGKHVf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Jul 2022 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGKHVd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 03:21:33 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7561055F;
        Mon, 11 Jul 2022 00:21:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0VIxofy0_1657524082;
Received: from 30.227.65.231(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VIxofy0_1657524082)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 15:21:24 +0800
Message-ID: <0408b739-3506-608a-4284-1086443a154d@linux.alibaba.com>
Date:   Mon, 11 Jul 2022 15:21:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] smc: fix refcount bug in sk_psock_get (2)
To:     Hawkins Jiawei <yin31149@gmail.com>,
        syzbot+5f26f85569bd179c18ce@syzkaller.appspotmail.com
Cc:     andrii@kernel.org, ast@kernel.org, borisp@nvidia.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kgraul@linux.ibm.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        skhan@linuxfoundation.org, 18801353760@163.com,
        paskripkin@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <00000000000026328205e08cdbeb@google.com>
 <20220709024659.6671-1-yin31149@gmail.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20220709024659.6671-1-yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/7/9 10:46 am, Hawkins Jiawei wrote:

> 
> syzbot is try to setup TLS on a SMC socket.
> 
> During SMC fallback process in connect syscall, kernel will sets the
> smc->sk.sk_socket->file->private_data to smc->clcsock
> in smc_switch_to_fallback(), and set smc->clcsock->sk_user_data
> to origin smc in smc_fback_replace_callbacks().

> 
> Later, sk_psock_get() will treat the smc->clcsock->sk_user_data
> as sk_psock type, which triggers the refcnt warning.
> 


Thanks for your analysis.

Although syzbot found this issue in SMC, seems that it is a generic
issue about sk_user_data usage? Fixing it from SK_USER_DATA_PTRMASK
as you plan should be a right way.
