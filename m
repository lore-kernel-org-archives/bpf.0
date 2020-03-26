Return-Path: <SRS0=2zQm=5L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C99C43331
	for <bpf@archiver.kernel.org>; Thu, 26 Mar 2020 02:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB12073E
	for <bpf@archiver.kernel.org>; Thu, 26 Mar 2020 02:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCZCaV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:30:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZCaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 22:30:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D98C815B2D569;
        Wed, 25 Mar 2020 19:30:19 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:30:16 -0700 (PDT)
Message-Id: <20200325.193016.1654692564933635575.davem@davemloft.net>
To:     andrea.mayer@uniroma2.it
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, leon@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, bpf@vger.kernel.org,
        paolo.lungaroni@cnit.it, ahmed.abdelsalam@gssi.it
Subject: Re: [net-next] seg6: add support for optional attributes during
 behavior construction
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200319183641.29608-1-andrea.mayer@uniroma2.it>
References: <20200319183641.29608-1-andrea.mayer@uniroma2.it>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Mar 2020 19:30:20 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Thu, 19 Mar 2020 19:36:41 +0100

> Messy code and complicated tricks may arise from this approach.

People taking advantage of this new flexibility will write
applications that DO NOT WORK on older kernels.

I think we are therefore stuck with the current optional attribute
semantics, sorry.
