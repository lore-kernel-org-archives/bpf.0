Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA7C10F14
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 04:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D620811
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 04:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfDWEg2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:36:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfDWEg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 00:36:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C4AA14E8529F;
        Mon, 22 Apr 2019 21:36:28 -0700 (PDT)
Date:   Mon, 22 Apr 2019 21:36:27 -0700 (PDT)
Message-Id: <20190422.213627.1315491052699043956.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf-next 2019-04-22
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190423031335.2153113-1-ast@kernel.org>
References: <20190423031335.2153113-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Apr 2019 21:36:28 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Mon, 22 Apr 2019 20:13:35 -0700

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> The main changes are:
 ...
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Alexei.
