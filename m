Return-Path: <SRS0=MJ0i=RT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985BDC43381
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDAB218D0
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCPTkV convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 16 Mar 2019 15:40:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCPTkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Mar 2019 15:40:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 06BEE12E4E2D5;
        Sat, 16 Mar 2019 12:40:19 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:40:19 -0700 (PDT)
Message-Id: <20190316.124019.1201385244935596871.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-03-16
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190316004356.9472-1-daniel@iogearbox.net>
References: <20190316004356.9472-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Mar 2019 12:40:20 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 16 Mar 2019 01:43:56 +0100

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) Fix a umem memory leak on cleanup in AF_XDP, from Björn.
> 
> 2) Fix BTF to properly resolve forward-declared enums into their corresponding
>    full enum definition types during deduplication, from Andrii.
> 
> 3) Fix libbpf to reject invalid flags in xsk_socket__create(), from Magnus.
> 
> 4) Fix accessing invalid pointer returned from bpf_tcp_sock() and
>    bpf_sk_fullsock() after bpf_sk_release() was called, from Martin.
> 
> 5) Fix generation of load/store DW instructions in PPC JIT, from Naveen.
> 
> 6) Various fixes in BPF helper function documentation in bpf.h UAPI header
>    used to bpf-helpers(7) man page, from Quentin.
> 
> 7) Fix segfault in BPF test_progs when prog loading failed, from Yonghong.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
