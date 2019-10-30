Return-Path: <SRS0=c9tz=YX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C032CA9EC5
	for <bpf@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0753F208C0
	for <bpf@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJ3TJ1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:09:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44590 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfJ3TJ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 15:09:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C4AF149D9F8E;
        Wed, 30 Oct 2019 12:09:26 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:09:25 -0700 (PDT)
Message-Id: <20191030.120925.1888086426485143779.davem@davemloft.net>
To:     brouer@redhat.com
Cc:     borkmann@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, eric@sage.org, andrii.nakryiko@gmail.com,
        acme@redhat.com, bjorn.topel@intel.com, jolsa@redhat.com,
        toke@redhat.com, ivan.khoronzhuk@linaro.org,
        ilias.apalodimas@linaro.org
Subject: Re: Compile build issues with samples/bpf/ again
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191030114313.75b3a886@carbon>
References: <20191030114313.75b3a886@carbon>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Oct 2019 12:09:26 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 30 Oct 2019 11:43:13 +0100

> Also I discovered, the command to build have also recently changed:
> - Before : make samples/bpf/   or  simply make in subdir samples/bpf/
> - new cmd: make M=samples/bpf  and in subdir is broken

Those build system changes were extremely annoying and have severely
hampered my workflow to no end.

Not only have subdir builds been broken off and on by this, but when
they do work they take forever so my usual shortcut of justing building
a specific object file to build test something now doesn't save me
much time at all.
