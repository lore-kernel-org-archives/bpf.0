Return-Path: <SRS0=saG7=5Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8358FC2D0F4
	for <bpf@archiver.kernel.org>; Wed,  8 Apr 2020 21:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AADD2074F
	for <bpf@archiver.kernel.org>; Wed,  8 Apr 2020 21:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDHVtR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:49:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53170 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgDHVtR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Apr 2020 17:49:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E796127D6211;
        Wed,  8 Apr 2020 14:49:15 -0700 (PDT)
Date:   Wed, 08 Apr 2020 14:49:14 -0700 (PDT)
Message-Id: <20200408.144914.956216445223066424.davem@davemloft.net>
To:     brouer@redhat.com
Cc:     sameehj@amazon.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        zorik@amazon.com, akiyano@amazon.com, gtzalik@amazon.com,
        toke@redhat.com, borkmann@iogearbox.net,
        alexei.starovoitov@gmail.com, john.fastabend@gmail.com,
        alexander.duyck@gmail.com, jeffrey.t.kirsher@intel.com,
        dsahern@gmail.com, willemdebruijn.kernel@gmail.com,
        ilias.apalodimas@linaro.org, lorenzo@kernel.org,
        saeedm@mellanox.com
Subject: Re: [PATCH RFC v2 30/33] xdp: clear grow memory in
 bpf_xdp_adjust_tail()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <158634678679.707275.5039642404868230051.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
        <158634678679.707275.5039642404868230051.stgit@firesoul>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Apr 2020 14:49:16 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 08 Apr 2020 13:53:06 +0200

> @@ -3445,6 +3445,11 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>  	if (unlikely(data_end < xdp->data + ETH_HLEN))
>  		return -EINVAL;
>  
> +	/* Clear memory area on grow, can contain uninit kernel memory */
> +	if (offset > 0) {
> +		memset(xdp->data_end, 0, offset);
> +	}

Single statement basic blocks should elide curly braces.
