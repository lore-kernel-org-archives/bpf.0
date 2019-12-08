Return-Path: <SRS0=6yca=Z6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C108CC43603
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 00:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7A924673
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 00:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLHAEB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:04:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLHAEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Dec 2019 19:04:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 121D315449D78;
        Sat,  7 Dec 2019 16:04:00 -0800 (PST)
Date:   Sat, 07 Dec 2019 16:03:57 -0800 (PST)
Message-Id: <20191207.160357.828344895192682546.davem@davemloft.net>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
CC:     ast@kernel.org, daniel@iogearbox.net, tglx@linutronix.de
Subject: [RFC v1 PATCH 0/7] bpf: Make RT friendly.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Dec 2019 16:04:00 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


The goal of this patch set is to make the BPF code friendly in RT
configurations.

The first step is eliminating preemption disable/enable and replacing
it with local lock usage when full RT is enabled.

Likewise we also need to elide usage of up_read_non_owner() in the
stackmap code when full RT is turned on.

Signed-off-by: David S. Miller <davem@davemloft.net>
