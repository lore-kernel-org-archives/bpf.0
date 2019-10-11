Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F1C47404
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 21:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D22089F
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 21:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfJKVYq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:24:46 -0400
Received: from www62.your-server.de ([213.133.104.62]:48994 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKVYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 17:24:46 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iJ2Oy-00070c-Oh; Fri, 11 Oct 2019 23:24:44 +0200
Date:   Fri, 11 Oct 2019 23:24:44 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 0/2] Atomic flow dissector updates
Message-ID: <20191011212444.GB21131@pc-63.home>
References: <20191011082946.22695-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011082946.22695-1-jakub@cloudflare.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25599/Fri Oct 11 10:48:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 10:29:44AM +0200, Jakub Sitnicki wrote:
> This patch set changes how bpf(BPF_PROG_ATTACH) operates on flow dissector
> hook when there is already a program attached. After this change the user
> is allowed to update the program in a single syscall. Please see the first
> patch for rationale.

Applied, thanks!
