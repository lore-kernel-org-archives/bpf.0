Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11333C33CB1
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 09:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16D32087E
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 09:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgAPJFD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:05:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36440 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgAPJFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 04:05:03 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 56DEB15B1BF94;
        Thu, 16 Jan 2020 01:05:01 -0800 (PST)
Date:   Thu, 16 Jan 2020 01:04:59 -0800 (PST)
Message-Id: <20200116.010459.56011403549196185.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2020-01-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200115230437.25033-1-daniel@iogearbox.net>
References: <20200115230437.25033-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Jan 2020 01:05:02 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 16 Jan 2020 00:04:37 +0100

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Daniel.
