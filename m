Return-Path: <SRS0=EAyC=ZA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89AFC6196
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 21:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BE221848
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfKHVlR convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 8 Nov 2019 16:41:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbfKHVlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:41:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2B6D6153B3140;
        Fri,  8 Nov 2019 13:41:16 -0800 (PST)
Date:   Fri, 08 Nov 2019 13:41:15 -0800 (PST)
Message-Id: <20191108.134115.1724914298667172120.davem@davemloft.net>
To:     toke@redhat.com
Cc:     daniel@iogearbox.net, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, brouer@redhat.com,
        andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Unpin auto-pinned maps if
 loading fails
From:   David Miller <davem@davemloft.net>
In-Reply-To: <157324878624.910124.5124587166846797199.stgit@toke.dk>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk>
        <157324878624.910124.5124587166846797199.stgit@toke.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Nov 2019 13:41:16 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 08 Nov 2019 22:33:06 +0100

> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Since the automatic map-pinning happens during load, it will leave pinned
> maps around if the load fails at a later stage. Fix this by unpinning any
> pinned maps on cleanup. To avoid unpinning pinned maps that were reused
> rather than newly pinned, add a new boolean property on struct bpf_map to
> keep track of whether that map was reused or not; and only unpin those maps
> that were not reused.
> 
> Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
