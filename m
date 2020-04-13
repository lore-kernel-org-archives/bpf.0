Return-Path: <SRS0=fN53=55=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1312CC2BA19
	for <bpf@archiver.kernel.org>; Mon, 13 Apr 2020 03:59:30 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E62206A1
	for <bpf@archiver.kernel.org>; Mon, 13 Apr 2020 03:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E62206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=bpf-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDMD72 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgDMD72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Apr 2020 23:59:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A5C0A3BE0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2020 20:59:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8152B127AE1F3;
        Sun, 12 Apr 2020 20:59:28 -0700 (PDT)
Date:   Sun, 12 Apr 2020 20:59:27 -0700 (PDT)
Message-Id: <20200412.205927.1627306630338317701.davem@davemloft.net>
To:     me@jibi.io
Cc:     bpf@vger.kernel.org, jasowang@redhat.com
Subject: Re: [PATCH 1/1] net: tun: record RX queue in skb before
 do_xdp_generic()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200410162059.15438-2-me@jibi.io>
References: <20200410162059.15438-1-me@jibi.io>
        <20200410162059.15438-2-me@jibi.io>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 12 Apr 2020 20:59:28 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Gilberto Bertin <me@jibi.io>
Date: Fri, 10 Apr 2020 18:20:59 +0200

> This allows netif_receive_generic_xdp() to correctly determine the RX
> queue from which the skb is coming, so that the context passed to the
> XDP program will contain the correct RX queue index.
> 
> Signed-off-by: Gilberto Bertin <me@jibi.io>

Applied and queued up for -stable, thanks.
