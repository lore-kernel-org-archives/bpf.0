Return-Path: <SRS0=8xVa=6M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DE2C83000
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 20:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72BA208E0
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 20:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD1ULs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1ULs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 16:11:48 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F9C03C1AB;
        Tue, 28 Apr 2020 13:11:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1A5C3120ED563;
        Tue, 28 Apr 2020 13:11:45 -0700 (PDT)
Date:   Tue, 28 Apr 2020 13:11:43 -0700 (PDT)
Message-Id: <20200428.131143.378850463944291442.davem@davemloft.net>
To:     mchehab+huawei@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, netdev@vger.kernel.org, linux-hams@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        linux-decnet-user@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, bpf@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, lvs-devel@vger.kernel.org
Subject: Re: [PATCH 00/38] net: manually convert files to ReST format -
 part 1
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1588024424.git.mchehab+huawei@kernel.org>
References: <cover.1588024424.git.mchehab+huawei@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 Apr 2020 13:11:45 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 28 Apr 2020 00:01:15 +0200

> There are very few documents upstream that aren't converted upstream.
> 
> This series convert part of the networking text files into ReST.
> It is part of a bigger set of patches, which were split on parts,
> in order to make reviewing task easier.
> 
> The full series (including those ones) are at:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=net-docs
> 
> And the documents, converted to HTML via the building system
> are at:
> 
> 	https://www.infradead.org/~mchehab/kernel_docs/networking/

These look good as far as I can tell.

Jon, do you mind if I merge this via the networking tree?

Thanks.
