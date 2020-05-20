Return-Path: <SRS0=8CIW=7C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E758C433E0
	for <bpf@archiver.kernel.org>; Wed, 20 May 2020 11:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8086E20823
	for <bpf@archiver.kernel.org>; Wed, 20 May 2020 11:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETLNb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 May 2020 07:13:31 -0400
Received: from verein.lst.de ([213.95.11.211]:49183 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETLNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 07:13:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7017168BEB; Wed, 20 May 2020 13:13:25 +0200 (CEST)
Date:   Wed, 20 May 2020 13:13:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/20] maccess: always use strict semantics for
 probe_kernel_read
Message-ID: <20200520111324.GA16488@lst.de>
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-14-hch@lst.de> <20200520201126.f37d3b1e46355199216404e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520201126.f37d3b1e46355199216404e2@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 08:11:26PM +0900, Masami Hiramatsu wrote:
> > -		ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
> > +		if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> > +		    (unsigned long)addr < TASK_SIZE) {
> > +			ret = probe_user_read(&c,
> > +				(__force u8 __user *)addr + len, 1);
> > +		} else {
> > +			ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
> > +		}
> >  		len++;
> >  	} while (c && ret == 0 && len < MAX_STRING_SIZE);
> 
> To avoid redundant check in the loop, we can use strnlen_user_nofault() out of
> the loop. Something like below.

Yes, I've done something very similar in response to Linus' comment (just
using an ifdef instead).
