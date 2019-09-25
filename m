Return-Path: <SRS0=z77e=XU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F48C432C2
	for <bpf@archiver.kernel.org>; Wed, 25 Sep 2019 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BA221D7B
	for <bpf@archiver.kernel.org>; Wed, 25 Sep 2019 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393261AbfIYUdE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:33:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:35544 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393204AbfIYUdE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Sep 2019 16:33:04 -0400
Received: from [178.197.248.15] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iDDy9-0002G0-Lz; Wed, 25 Sep 2019 22:33:01 +0200
Date:   Wed, 25 Sep 2019 22:33:01 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf] selftests/bpf: adjust strobemeta loop to satisfy
 latest clang
Message-ID: <20190925203301.GE9500@pc-63.home>
References: <20190925185205.2857838-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925185205.2857838-1-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25583/Wed Sep 25 10:27:51 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 25, 2019 at 11:52:05AM -0700, Andrii Nakryiko wrote:
> Some recent changes in latest Clang started causing the following
> warning when unrolling strobemeta test case main loop:
> 
>   progs/strobemeta.h:416:2: warning: loop not unrolled: the optimizer was
>   unable to perform the requested transformation; the transformation might
>   be disabled or specified as part of an unsupported transformation
>   ordering [-Wpass-failed=transform-warning]
> 
> This patch simplifies loop's exit condition to depend only on constant
> max iteration number (STROBE_MAX_MAP_ENTRIES), while moving early
> termination logic inside the loop body. The changes are equivalent from
> program logic standpoint, but fixes the warning. It also appears to
> improve generated BPF code, as it fixes previously failing non-unrolled
> strobemeta test cases.
> 
> Cc: Alexei Starovoitov <ast@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Sounds like a clang regression? Was that from an official release?

Applied.
