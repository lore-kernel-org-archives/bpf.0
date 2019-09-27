Return-Path: <SRS0=uMm3=XW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46300C388F3
	for <bpf@archiver.kernel.org>; Fri, 27 Sep 2019 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286C2217D9
	for <bpf@archiver.kernel.org>; Fri, 27 Sep 2019 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfI0O02 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:26:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfI0O00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Sep 2019 10:26:26 -0400
Received: from localhost (unknown [172.58.30.169])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE523153899DC;
        Fri, 27 Sep 2019 07:26:24 -0700 (PDT)
Date:   Fri, 27 Sep 2019 16:26:15 +0200 (CEST)
Message-Id: <20190927.162615.2129424873572545364.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-09-27
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190927131508.24576-1-daniel@iogearbox.net>
References: <20190927131508.24576-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Sep 2019 07:26:26 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 27 Sep 2019 15:15:08 +0200

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Daniel.
