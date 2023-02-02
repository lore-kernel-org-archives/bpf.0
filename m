Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79063C05027
	for <bpf@archiver.kernel.org>; Thu,  2 Feb 2023 10:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjBBKYQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBBKYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 05:24:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5ECAD3E
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 02:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1YUctRz72Bs3xNA+ritkx2pToRVhMy0rGQHPhYi2hCI=; b=NvGjlkyGm9vCDqBmMut9QyJwrk
        5xoCLaQ8ABu1Lqqru09b+TDV08mSbX88yY8ZbFf+jM2kpLzL/GN/J01CnFprGaggq1JL2bwOPBUOD
        gU9DdUeujkhjNS3dSv6Cxf4f63XnY/S947UIqvLKolliVWqh0H4KhXf21cyA1WYF2Vzqslo8VlLe9
        xZ4DNgH46En152VXJE50BlP8NqBd/g3j3neuD6K0PjpccQ13ra3hanGJ+gGlfHtg1khATuvKsvYlR
        l5F3qpEJyljohL4Bd2aFa7iMkISp61KB6VhtCMxVYQhGame7W1QMfsg+wJgal/1wp5RxWapVLL1rC
        eNh0SUpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNWkz-00FMSd-Bs; Thu, 02 Feb 2023 10:23:53 +0000
Date:   Thu, 2 Feb 2023 02:23:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH bpf-next 3/7] mm: vmalloc: introduce vsize()
Message-ID: <Y9uPORBkVlMZFzk3@infradead.org>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
 <20230202014158.19616-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202014158.19616-4-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 01:41:54AM +0000, Yafang Shao wrote:
> Introduce a helper to report full size of underlying allocation of a
> vmalloc'ed address.

What is the use case for it?
