Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E0C433EF
	for <bpf@archiver.kernel.org>; Mon,  4 Jul 2022 05:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiGDFx7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Jul 2022 01:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGDFx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 01:53:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA96390;
        Sun,  3 Jul 2022 22:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yrvtS4/CetUunA8Ng+oU0i0AGmFFjOviHSWGXS5/frg=; b=ulMYdXnkyrnIHS8wa55jT80W8W
        GTjxvHPZ9zXmfJPTboZ88bkqyEedL9hA216B6IrWZtlpYCmBz7tRe6RgeLG13QQCm3Y9VYvkKE4QD
        /lqnSHkCo2Qz9/XofJ6apVv6eOIqV9H0tJJJBFyDX7NJbyNuHOil7g1hSf2GgWYprbrNbzzqeSFwS
        008olUcPnpCNpTa1FrTCTESJAPx1osPc+RdqJ0YsB5bAMwXBu4cg3zw6x4marFNn6EfqDPEB5M5be
        tWgb96tCQSI4J4Dz4AHRJEuoHMcrKm4US4wJVudKq1A0x0HqNKdnwJDLsfrL90ZjZCt2OYmjOf30F
        qVrKxFEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8F1h-005Bve-Ib; Mon, 04 Jul 2022 05:53:41 +0000
Date:   Sun, 3 Jul 2022 22:53:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yixun Lan <dlan@gentoo.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] RISC-V/bpf: Enable bpf_probe_read{, str}()
Message-ID: <YsKAZUJRo5cjtZ3n@infradead.org>
References: <20220703130924.57240-1-dlan@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703130924.57240-1-dlan@gentoo.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 03, 2022 at 09:09:24PM +0800, Yixun Lan wrote:
> Enable this option to fix a bcc error in RISC-V platform
> 
> And, the error shows as follows:

These should not be enabled on new platforms.  Use the proper helpers
to probe kernel vs user pointers instead.
