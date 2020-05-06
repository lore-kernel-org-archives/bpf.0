Return-Path: <SRS0=COpY=6U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F6CC4724C
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 06:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CD520714
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 06:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CIUsCHj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEFGW2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 May 2020 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEFGW2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 02:22:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA4C061A0F;
        Tue,  5 May 2020 23:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+QeiLvlGEJMuVoqXNKh/LxTQ/T3qKj7iVtFa2X0kLrA=; b=CIUsCHj7W0F+STX4nCisy4hqyJ
        5ORj2O7Kb2H3ACRqskaeUjkJFG0KwGbK95D1NYObW2E9bXD0FFifkGd4jbkspYorh5RZ9UsOcqtPp
        dTAGbeJaHf8PGyXQUQK+EEyCBb6VqYX0GVfWnlkdM8LgZlWGMn8eBW04MRhUpVB3nCAdGwMu2Vd04
        EL+x2SDiK5TR4QOTj5pzQQpNFUmDxlEqLBMLGC5u8o/umlXcNjM1mjQramTZDXAcyjieoXaNOiDl+
        k6wp7FpQb0foCoyR+2O+QiBPzR7x7UYN46lggaWOofrYFe4JjvCUp9U7Cr8sNQ3MWsnwOAarTLEsL
        pJyWOQ0w==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWDRp-0006JV-Nj; Wed, 06 May 2020 06:22:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: clean up and streamline probe_kernel_* and friends
Date:   Wed,  6 May 2020 08:22:08 +0200
Message-Id: <20200506062223.30032-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

this series start cleaning up the safe kernel and user memory probing
helpers in mm/maccess.c, and then allows architectures to implement
the kernel probing without overriding the address space limit and
temporarily allowing access to user memory.  It then switches x86
over to this new mechanism by reusing the unsafe_* uaccess logic.
