Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15249C433EF
	for <bpf@archiver.kernel.org>; Wed,  6 Jul 2022 18:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiGFSVs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFSVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:21:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E8127CF3
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GSSTlT3H81m4KqNdVOSGW8EIu6nu7lK1brf2OVKi6u8=; b=Gbl3nrDK2NCAfsOroqyup0d/9F
        d0Y1FU6xIGFI6UBkqncwMD0VimqAmcX61IrPfXla+Y2YGPMl4rmmHaOl44UZ7NrTkUrAshkv+0d1Y
        rpFJC6DckR88QAc6g4eJSYNIUzMMc/FMATzKp6PCUFSoVvSKfuZ+dpXpEpyi2r9es8OOEoHKOzxZa
        TAd1FNXkZtCEut4H6MGa2zKmQvYK2IDT8VhrDg/s+9T6g+NPCdDtraL2tXNL7ujxVYKifOR2Uyd7J
        lhhT4ppQu49ThSOmV3XNjTNMH4RgJzBk1LddMqwyWJqGbJ8beGK56PGgYRP9tr6ciNL2O/1hMBL5m
        P4F1TaRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o99eT-001rdx-GF; Wed, 06 Jul 2022 18:21:29 +0000
Date:   Wed, 6 Jul 2022 19:21:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YsXSqSMxsvq13dV4@casper.infradead.org>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 11:05:25AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > For example, I assume that a BPF program
> > has a fairly tight limit on how much memory it can cause to be allocated.
> > Right?
> 
> No. It's constrained by memcg limits only. It can allocate gigabytes.

I'm confused.  A BPF program is limited to executing 4096 insns and
using a maximum of 512 bytes of stack space, but it can allocate an
unlimited amount of heap?  That seems wrong.
