Return-Path: <SRS0=6fLz=5U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24409C2BA16
	for <bpf@archiver.kernel.org>; Sat,  4 Apr 2020 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A43206CC
	for <bpf@archiver.kernel.org>; Sat,  4 Apr 2020 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ahXGCGsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDDJbM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 4 Apr 2020 05:31:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDJbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Apr 2020 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/sDN8Ke+Cehsh/uN1t2+mll/fQTwL9ufE0PBzrXJbro=; b=ahXGCGsMXZQzecuCtzf8J2uad5
        sfhM9qNpndi3bI74K9jw4SfNQHuqEUqm76nFD/bMqYr6yApbaGuyXi/P4EMozK0GsrsWakKZjc3rg
        Ma5MgwE2gZ+QAEVMn23iXAN6yt1lmAo3Sy9lgdy16bBoYCi4XzKOmxEdz7BbDZ7Xewbh80xlCzw8E
        WjwFdX0zwGhXzL8YDl2fGli5ZwANa5/0R1MYO4yhRUe1z8fsguag0+JsyqFCw2dEdzMkm4YjOjHtA
        BxPfUN8Puo93lnOv7uiuz6s1f4O0PtPaJvuqoUHzaE26mqy266MqwT9lNkKT6VS/4lE2BkECjrOVg
        Towf/Tqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKf8r-0005GZ-EB; Sat, 04 Apr 2020 09:31:05 +0000
Date:   Sat, 4 Apr 2020 02:31:05 -0700
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
Message-ID: <20200404093105.GA445@infradead.org>
References: <20200403133533.GA3424@infradead.org>
 <5ddc8c04-279d-9a14-eaa7-755467902ead@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ddc8c04-279d-9a14-eaa7-755467902ead@iogearbox.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 03, 2020 at 04:20:24PM +0200, Daniel Borkmann wrote:
> With crazy old functions I presume you mean the old bpf_probe_read()
> which is mapped to BPF_FUNC_probe_read helper or something else entirely?

I couldn't care less about bpf, this is about the kernel API.

What I mean is that your new probe_kernel_read_strict and
strncpy_from_unsafe_strict helpers are good and useful.  But for this
to actually make sense we need to get rid of the non-strict versions,
and we also need to get rid of some of the weak alias magic.
