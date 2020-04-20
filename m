Return-Path: <SRS0=PZfo=6E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5417C3815B
	for <bpf@archiver.kernel.org>; Mon, 20 Apr 2020 08:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E7F21927
	for <bpf@archiver.kernel.org>; Mon, 20 Apr 2020 08:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSYwjiYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTIar (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgDTIar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Apr 2020 04:30:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C08C061A0C;
        Mon, 20 Apr 2020 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vx87uFUhI244IGSEOCBnVCbVqtfJrxwHz9Z7pfAy8pA=; b=tSYwjiYljia6BZ8n2flrsC+dZp
        OqUWt2TlmlJrOuqnKXGyK0NjEf4smAJgvQ6iWLLVL1Ic5PWXnsoOM0cusqqcfuG3coil9DjNBfIZi
        iRs2FiWiq6BaHw9f6xuiEiZR7uOivaJydzfuvwhPI5HyCOnG7akzKUlSL8sWNyFBEynJSZL7srhNt
        ErAcVXvVdVC/VzLqZtCH60Md9A2ct4oMyatTbZacGTIkCIwhdp2pjNJMsp5Wyf5zE6ipsN+ADRIiW
        vjb3wug6Fo0vSw+k8OTDCTwovs+hjpShIoRAz36pgkVU0aJbz6IyNA9BNv/T+Tvufuwz5WigWzKOB
        e2BhxTKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQRpG-00054e-G9; Mon, 20 Apr 2020 08:30:46 +0000
Date:   Mon, 20 Apr 2020 01:30:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, brendan.d.gregg@gmail.com,
        andrii.nakryiko@gmail.com, ast@kernel.org
Subject: Re: [RFC] uapi: Convert stat.h #define flags to enums
Message-ID: <20200420083046.GB28749@infradead.org>
References: <20200417022315.1931959-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417022315.1931959-1-dxu@dxuuu.xyz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

And that breaks every userspace program using ifdef to check if a
symbolic name has been defined.
