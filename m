Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72E6C4332F
	for <bpf@archiver.kernel.org>; Tue,  8 Nov 2022 02:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKHCpl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Nov 2022 21:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKHCpi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 21:45:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798252E68E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dOHfGdrZMbxR+Nk/csTyhXGLGf94kIVhOpE5v9WuUFQ=; b=W2xDTN8MSkz5dph/gDsCuyG7Za
        RK1VEIAABMQlwqa1rRDWsGE0VdTpTr9hY0cBt3kzvIBbNF333VmwgG7c1nl6o9F9NIn93W8cLuCQE
        Wdhp3x24uKoDxQsitaUH4RkqmlF+AhQcelh7Ho5pXpj7o+02Bb8gXAb1SoGUe9xE2cLczsRh4AkIG
        VyEVjWUB6PidPZBqC50pQvyG8qCqEkliX7VJGuA5Wc/RxxH2qWSbajLIUTGdVDH2lCth9yS46KmQ7
        hNQdrrJtxfIagdEY9x/vtAgKlRLmkmNpNwZeyX9CWTEOqCnfw+w7jO/Z8FwSjHbcqzbcUJSQ21HyD
        FgUWec2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osEcC-002AQC-Tl; Tue, 08 Nov 2022 02:45:28 +0000
Date:   Mon, 7 Nov 2022 18:45:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "song@kernel.org" <song@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2nCyB0FdXqUYWe0@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2mM3eElIBmAyLko@bombadil.infradead.org>
 <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
 <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org>
 <dc47953aa9296d1955e41f02d4ddef06036d855c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc47953aa9296d1955e41f02d4ddef06036d855c.camel@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 12:13:09AM +0000, Edgecombe, Rick P wrote:
> On Mon, 2022-11-07 at 15:39 -0800, Luis Chamberlain wrote:
> > And none of your patches mentions the gains of this effort helping
> > with the long term advantage of centralizing the semantics for
> > permissions on memory.
> 
> Another good point. Although this brings up that this interface
> "execmem" does just handle one type of permission.

Yes but the huge benefit of at least sharing this for eBPF + kprobes +
ftrace + modules long term under all execmem would be huge.

  Luis
