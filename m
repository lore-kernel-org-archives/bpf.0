Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43824C433F5
	for <bpf@archiver.kernel.org>; Thu, 14 Apr 2022 21:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiDNVOH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiDNVOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 17:14:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4A4D4CB5;
        Thu, 14 Apr 2022 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t0kR90lwAnP+kfHrPPmywzlT1a0RSvToeleriKjsR2s=; b=2UbJ48VYL4vK73QTj2OMgNcry0
        68NtsJ94tbzdSmiegtINzjW/PatF+HTZZTsOxUm6Inrt2jCYsiGG1eyIgMccz4Z3rpROWRqs4Lc2D
        5e8Fwo+N6z/f1Ts4aNtsnUHq5P9h2O1a7lQfnen0bnKP7CcdX2AS5UvW1UmpgRqhyPIE3uJed2rky
        8U2nhVdXVBkhMqzn+12WL1P0NTC43y/BVYmsggjMEDcdNv8peim+2fGaQgkYJ+DIy2jWbOeTAbQyJ
        MceLsfqKzoQD3tfWzm7JMzcRkpdF6Seu7npTg/ieIIbEKwiu/uopcb6yfSjQCq6HmHMOkKHIjmwCh
        VKiO7L4g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf6kd-007Jom-NH; Thu, 14 Apr 2022 21:11:39 +0000
Date:   Thu, 14 Apr 2022 14:11:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>, imbrenda@linux.ibm.com
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
Message-ID: <YliOC455r6XmE24Q@bombadil.infradead.org>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-4-song@kernel.org>
 <YliFO2sDv31j5vLb@bombadil.infradead.org>
 <CAPhsuW42Dn2y9skhdJAK1fp9CFA06tpzG=6gMxeTobBj6xifPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW42Dn2y9skhdJAK1fp9CFA06tpzG=6gMxeTobBj6xifPg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 02:03:17PM -0700, Song Liu wrote:
> Hi Luis,
> 
> On Thu, Apr 14, 2022 at 1:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
> > > Introduce module_alloc_huge, which allocates huge page backed memory in
> > > module memory space. The primary user of this memory is bpf_prog_pack
> > > (multiple BPF programs sharing a huge page).
> > >
> > > Signed-off-by: Song Liu <song@kernel.org>
> >
> > See modules-next [0], as modules.c has been chopped up as of late.
> > So if you want this to go throug modules this will need to rebased
> > on that tree. fortunately the amount of code in question does not
> > seem like much.
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> 
> We are hoping to ship this with to 5.18, as the set addresses some issue with
> huge page backed vmalloc. I guess we cannot ship it via modules-next branch.
> 

Huh, you intend this to go in as a fix for v5.18 (already released) once
properly reviewed?  This seems quite large... for a fix.

> How about we ship module_alloc_huge() to 5.18 in module.c for now, and once
> we update modules-next branch, I will send another patch to clean it up?

I rather set the expectations right about getting such a large fix in
for v5.18. I haven't even sat down to review all the changes in light of
this, but a cursorary glance seems to me it's rather "large" for a fix.

  Luis
