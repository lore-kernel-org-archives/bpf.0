Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D4C433FE
	for <bpf@archiver.kernel.org>; Tue, 22 Nov 2022 06:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiKVGN2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Nov 2022 01:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKVGN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 01:13:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB12CC97
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 22:13:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5535968D06; Tue, 22 Nov 2022 07:13:23 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:13:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
Message-ID: <20221122061323.GA14204@lst.de>
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org> <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net> <20221121155542.GA27879@lst.de> <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com> <Y3vXorejgjSCXtt3@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vXorejgjSCXtt3@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 11:55:14AM -0800, Luis Chamberlain wrote:
> > I added these exports for test_vmalloc.ko. Is there a way to only export
> > them to test_vmalloc.ko but nothing else?
> 
> See EXPORT_SYMBOL_NS_GPL()

No, that is in no way limiting who uses it, it just makes them go
through extra hoops.

The funtionality to allocate exectuable memory is highly dangerous
and absolutely must be limited to built-in code.

So the tests should just be forced to be built-in here as well.
