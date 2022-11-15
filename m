Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F38DC4332F
	for <bpf@archiver.kernel.org>; Tue, 15 Nov 2022 21:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKOVcR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Nov 2022 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiKOVcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:32:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABFA25CD
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0RI2aDwBGFXzyYFD37lQvHbgfDlFcEMvq/C+gvNBZ+Y=; b=b+QCzEuxfwyj7Ur02yoiOHgktd
        ItbRD+pMohulgy9v9asePMjI1zzKGs67I4n4482lgwtH/saBZuqP8CthY0V8CZuwatnipdYAuQRZD
        6eJNOO4OLzGQGShNE2ObfS5yL3FmMk1s8eYVkRaI1rlSC1wdrzLmbS3Xe6oxNP4nMj0xgacKCneoB
        ryIJLYzOqu+HiVU2nzsqNoOZzX8guX1/cDTnqO25YInIZMR/zsqyAPDfpV80E/KdkwmsFQeaFfizH
        zIX7izTyuhyGg33xVhUA5wp/5yhoCUq4yG/eb/Ddcg/8f71E/6u1yapWc5zguplzBg8zc7Ew1iwdw
        FyO5yT1w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov3XS-00F416-Bn; Tue, 15 Nov 2022 21:32:14 +0000
Date:   Tue, 15 Nov 2022 13:32:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3QFXsV9qBkM+910@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 01:09:08PM -0800, Luis Chamberlain wrote:
> - I am really exausted of asking again for real performance tests,
>   you keep saying you can't and I keep saying you can, you are not
>   trying hard enough. Stop thinking about your internal benchmark which
>   you cannot publish. There should be enough crap out which you can use.

and if results defy expectations, please don't be coy about it, just
be direct and mention it.

  Luis
