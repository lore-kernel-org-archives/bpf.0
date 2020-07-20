Return-Path: <SRS0=N7Fo=A7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475BC433DF
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 01:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684092250E
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 01:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGTB2y (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTB2x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jul 2020 21:28:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482DC0619D2;
        Sun, 19 Jul 2020 18:28:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CF0012850BF6;
        Sun, 19 Jul 2020 18:28:53 -0700 (PDT)
Date:   Sun, 19 Jul 2020 18:28:52 -0700 (PDT)
Message-Id: <20200719.182852.1896874078289347945.davem@davemloft.net>
To:     lorenzo@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        ilias.apalodimas@linaro.org, lorenzo.bianconi@redhat.com,
        brouer@redhat.com, echaudro@redhat.com, sameehj@amazon.com
Subject: Re: [PATCH v2 net-next 0/6] rework mvneta napi_poll loop for XDP
 multi-buffers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1594936660.git.lorenzo@kernel.org>
References: <cover.1594936660.git.lorenzo@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Jul 2020 18:28:53 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Jul 2020 00:16:28 +0200

> Rework mvneta_rx_swbm routine in order to process all rx descriptors before
> building the skb or run the xdp program attached to the interface.
> Introduce xdp_get_shared_info_from_{buff,frame} utility routines to get the
> skb_shared_info pointer from xdp_buff or xdp_frame.
> This is a preliminary series to enable multi-buffers and jumbo frames for XDP
> according to [1]
> 
> [1] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp-multi-buffer01-design.org
> 
> Changes since v1:
> - rely on skb_frag_* utility routines to access page/offset/len of the xdp multi-buffer

Series applied, thank you.
