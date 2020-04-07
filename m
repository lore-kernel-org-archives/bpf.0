Return-Path: <SRS0=2TgV=5X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77815C2BABC
	for <bpf@archiver.kernel.org>; Tue,  7 Apr 2020 09:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F29820719
	for <bpf@archiver.kernel.org>; Tue,  7 Apr 2020 09:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cXqt2Apb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDGJd7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:33:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgDGJd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 05:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ALLpFhoRwFcaZVxVwmpORwXzqCLllgkOW88XxNP1czw=; b=cXqt2Apb0IYUWCtEG/qZtDMcnU
        GDRnm2aNxxGoLxkuAR2tr8mHb6Rbt51JplL2wsHcw0XXes/p9vuKk2dRBjziu0pj+AMLXBIVXd5MB
        gvV51G/O02Ml2mfOfroshmH9vvT7b25V5u29s96NWMaLGhnQ3eRcS49vwwXdNV7XAE1sQ6TTUm338
        r+cGgmsDwefFnOAQBzqSeJN/mQh9Y7/rvYUJ2/a5zxNSS+8KqyAQ55Tz9rvkDZQAS6eOCTxFKzMz0
        EHTPlUb/iGsSM621kD101DfYjXLrGVEVLN5aOlUfGqxkJf7cU2Lpm3CWVfvPvyK+JQrjpvISps5WE
        4y29vzZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLkcH-0006yf-F2; Tue, 07 Apr 2020 09:33:57 +0000
Date:   Tue, 7 Apr 2020 02:33:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        bgregg@netflix.com
Subject: Re: Question on "uaccess: Add strict non-pagefault kernel-space read
 function"
Message-ID: <20200407093357.GA24309@infradead.org>
References: <20200403133533.GA3424@infradead.org>
 <5ddc8c04-279d-9a14-eaa7-755467902ead@iogearbox.net>
 <20200404093105.GA445@infradead.org>
 <2adc77e1-e84d-f303-fd88-133ec950c33f@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2adc77e1-e84d-f303-fd88-133ec950c33f@iogearbox.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 07, 2020 at 11:03:23AM +0200, Daniel Borkmann wrote:
> 
> ... where archs with non-overlapping user and kernel address range would
> only end up having to implementing kernel_range_ok() check. Or, instead of
> a generic kernel_range_ok() this could perhaps be more probing-specific as
> in probe_kernel_range_ok() where this would then also cover the special
> cases we seem to have in parisc and um. Then, this would allow to get rid
> of all the __weak aliasing as well which may just be confusing. I could look
> into coming up with something along these lines. Thoughts?

FYI, this is what I cooked up a few days ago:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/maccess-fixups

Still misses the final work to switch probe_kernel_read to be the
strict version.  Any good naming suggestion for the non-strict one?
