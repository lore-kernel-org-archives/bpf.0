Return-Path: <SRS0=5rgj=45=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D5C10DCE
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 06:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D520663
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 06:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgCLGUK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:20:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbgCLGUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 02:20:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 46B4014DA84A3;
        Wed, 11 Mar 2020 23:20:09 -0700 (PDT)
Date:   Wed, 11 Mar 2020 23:20:08 -0700 (PDT)
Message-Id: <20200311.232008.336536129448429278.davem@davemloft.net>
To:     jbi.octave@gmail.com
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org
Subject: Re: [PATCH 2/8] raw: Add missing annotations to raw_seq_start()
 and raw_seq_stop()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200311010908.42366-3-jbi.octave@gmail.com>
References: <0/8>
        <20200311010908.42366-1-jbi.octave@gmail.com>
        <20200311010908.42366-3-jbi.octave@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Mar 2020 23:20:09 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>
Date: Wed, 11 Mar 2020 01:09:02 +0000

> Sparse reports warnings at raw_seq_start() and raw_seq_stop()
> 
> warning: context imbalance in raw_seq_start() - wrong count at exit
> warning: context imbalance in raw_seq_stop() - unexpected unlock
> 
> The root cause is the missing annotations at raw_seq_start()
> 	and raw_seq_stop()
> Add the missing __acquires(&h->lock) annotation
> Add the missing __releases(&h->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Applied.
