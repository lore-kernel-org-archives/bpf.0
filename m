Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E40C433E0
	for <bpf@archiver.kernel.org>; Sun, 14 Mar 2021 02:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B0B64EDA
	for <bpf@archiver.kernel.org>; Sun, 14 Mar 2021 02:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhCNCKV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 13 Mar 2021 21:10:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47782 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhCNCKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Mar 2021 21:10:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id EA2A74CEA1135;
        Sat, 13 Mar 2021 18:10:00 -0800 (PST)
Date:   Sat, 13 Mar 2021 18:10:00 -0800 (PST)
Message-Id: <20210313.181000.1671061556553245861.davem@davemloft.net>
To:     alobakin@pm.me
Cc:     kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        jonathan.lemon@gmail.com, edumazet@google.com, willemb@google.com,
        haokexin@gmail.com, pablo@netfilter.org, jakub@cloudflare.com,
        elver@google.com, decui@microsoft.com, vladimir.oltean@nxp.com,
        lariel@mellanox.com, wangqing@vivo.com, dcaratti@redhat.com,
        gnault@redhat.com, eranbe@nvidia.com, mchehab+huawei@kernel.org,
        ktkhai@virtuozzo.com, bgolaszewski@baylibre.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/6] skbuff: micro-optimize flow dissection
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210313113645.5949-1-alobakin@pm.me>
References: <20210313113645.5949-1-alobakin@pm.me>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Sat, 13 Mar 2021 18:10:01 -0800 (PST)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


None of these apply to net-next as per the patchwork automated checks.  Any idea why?

Thanks.

