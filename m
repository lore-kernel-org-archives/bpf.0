Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3220CC4338F
	for <bpf@archiver.kernel.org>; Fri,  6 Aug 2021 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BE86101C
	for <bpf@archiver.kernel.org>; Fri,  6 Aug 2021 10:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbhHFKOi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Aug 2021 06:14:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43984 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbhHFKOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 06:14:34 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 20E4F5021FF3D;
        Fri,  6 Aug 2021 03:14:13 -0700 (PDT)
Date:   Fri, 06 Aug 2021 11:14:12 +0100 (BST)
Message-Id: <20210806.111412.1329682129695306949.davem@davemloft.net>
To:     vvs@virtuozzo.com
Cc:     yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        eric.dumazet@gmail.com, netdev@vger.kernel.org, jreuter@yaina.de,
        ralf@linux-mips.org, linux-hams@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@openvz.org, jwi@linux.ibm.com
Subject: Re: [PATCH NET v4 0/7] skbuff: introduce skb_expand_head()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0d3366bb-e19c-dbd4-0ba5-a3e6aff55b4e@virtuozzo.com>
References: <ccce7edb-54dd-e6bf-1e84-0ec320d8886c@linux.ibm.com>
        <0d3366bb-e19c-dbd4-0ba5-a3e6aff55b4e@virtuozzo.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 06 Aug 2021 03:14:18 -0700 (PDT)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



I already applied v3 to net-next, please send a relative fixup if you want to incorpoate the v4 changes too.

Thank you.
