Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88EC433C1
	for <bpf@archiver.kernel.org>; Tue, 23 Mar 2021 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6BC619A8
	for <bpf@archiver.kernel.org>; Tue, 23 Mar 2021 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCWBZ2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Mar 2021 21:25:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCWBZE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 21:25:04 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F4DC31PgWzYN8w;
        Tue, 23 Mar 2021 09:23:11 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 23 Mar 2021 09:24:59 +0800
Received: from [127.0.0.1] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 09:24:59 +0800
Subject: Re: [Patch bpf-next v6 02/12] skmsg: introduce a spinlock to protect
 ingress_msg
To:     Cong Wang <xiyou.wangcong@gmail.com>, <netdev@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <duanxiongchun@bytedance.com>,
        <wangdongdong.6@bytedance.com>, <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "Jakub Sitnicki" <jakub@cloudflare.com>
References: <20210323003808.16074-1-xiyou.wangcong@gmail.com>
 <20210323003808.16074-3-xiyou.wangcong@gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <93f9be88-2803-93cd-df6b-43f494c0f67d@huawei.com>
Date:   Tue, 23 Mar 2021 09:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20210323003808.16074-3-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021/3/23 8:37, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Currently we rely on lock_sock to protect ingress_msg,
> it is too big for this, we can actually just use a spinlock
> to protect this list like protecting other skb queues.
> 
> __tcp_bpf_recvmsg() is still special because of peeking,
> it still has to use lock_sock.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/linux/skmsg.h | 46 +++++++++++++++++++++++++++++++++++++++++++
>  net/core/skmsg.c      |  3 +++
>  net/ipv4/tcp_bpf.c    | 18 ++++++-----------
>  3 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 6c09d94be2e9..f2d45a73b2b2 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -89,6 +89,7 @@ struct sk_psock {
>  #endif
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
> +	spinlock_t			ingress_lock;
>  	unsigned long			state;
>  	struct list_head		link;
>  	spinlock_t			link_lock;
> @@ -284,7 +285,45 @@ static inline struct sk_psock *sk_psock(const struct sock *sk)
>  static inline void sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> +	spin_lock_bh(&psock->ingress_lock);
>  	list_add_tail(&msg->list, &psock->ingress_msg);
> +	spin_unlock_bh(&psock->ingress_lock);
> +}
> +
> +static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
> +{
> +	struct sk_msg *msg;
> +
> +	spin_lock_bh(&psock->ingress_lock);
> +	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> +	if (msg)
> +		list_del(&msg->list);
> +	spin_unlock_bh(&psock->ingress_lock);
> +	return msg;
> +}
> +
> +static inline struct sk_msg *sk_psock_peek_msg(struct sk_psock *psock)
> +{
> +	struct sk_msg *msg;
> +
> +	spin_lock_bh(&psock->ingress_lock);
> +	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> +	spin_unlock_bh(&psock->ingress_lock);
> +	return msg;
> +}
> +
> +static inline struct sk_msg *sk_psock_next_msg(struct sk_psock *psock,
> +					       struct sk_msg *msg)
> +{
> +	struct sk_msg *ret;

Nit:
Use msg instead of ret to be consistently with sk_psock_dequeue_msg()
and sk_psock_next_msg().

> +
> +	spin_lock_bh(&psock->ingress_lock);
> +	if (list_is_last(&msg->list, &psock->ingress_msg))
> +		ret = NULL;
> +	else
> +		ret = list_next_entry(msg, list);
> +	spin_unlock_bh(&psock->ingress_lock);
> +	return ret;
>  }


