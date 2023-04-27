Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E72DC7618E
	for <bpf@archiver.kernel.org>; Thu, 27 Apr 2023 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbjD0A6D (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Apr 2023 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjD0A6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 20:58:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F93A92;
        Wed, 26 Apr 2023 17:58:00 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6HP0262szsR8d;
        Thu, 27 Apr 2023 08:56:20 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 27 Apr
 2023 08:57:58 +0800
Subject: Re: [PATCH RFC net-next/mm V1 1/3] page_pool: Remove workqueue in new
 shutdown scheme
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
        <linux-mm@kvack.org>, Mel Gorman <mgorman@techsingularity.net>
CC:     <lorenzo@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <willy@infradead.org>
References: <168244288038.1741095.1092368365531131826.stgit@firesoul>
 <168244293875.1741095.10502498932946558516.stgit@firesoul>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <48661b51-1cbb-e3e0-a909-6d0a1532733a@huawei.com>
Date:   Thu, 27 Apr 2023 08:57:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <168244293875.1741095.10502498932946558516.stgit@firesoul>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2023/4/26 1:15, Jesper Dangaard Brouer wrote:
> @@ -609,6 +609,8 @@ void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
>  		recycle_stat_inc(pool, ring_full);
>  		page_pool_return_page(pool, page);
>  	}
> +	if (pool->p.flags & PP_FLAG_SHUTDOWN)
> +		page_pool_shutdown_attempt(pool);

It seems we have allowed page_pool_shutdown_attempt() to be called
concurrently here, isn't there a time window between atomic_inc_return_relaxed()
and page_pool_inflight() for pool->pages_state_release_cnt, which may cause
double calling of page_pool_free()?
