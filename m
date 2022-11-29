Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E5FC4332F
	for <bpf@archiver.kernel.org>; Tue, 29 Nov 2022 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiK2UWU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiK2UWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 15:22:19 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1CB2662
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 12:22:18 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61C056732D; Tue, 29 Nov 2022 21:22:14 +0100 (CET)
Date:   Tue, 29 Nov 2022 21:22:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v5 3/6] selftests/vm: extend test_vmalloc to
 test execmem_* APIs
Message-ID: <20221129202214.GA3548@lst.de>
References: <20221128190245.2337461-1-song@kernel.org> <20221128190245.2337461-4-song@kernel.org> <20221129083518.GA25167@lst.de> <CAPhsuW6zOVjK5bvS_A=RNUAExeepSPrpE7xWOOAq6W5qJ3m=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6zOVjK5bvS_A=RNUAExeepSPrpE7xWOOAq6W5qJ3m=vA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 09:31:24AM -0800, Song Liu wrote:
> I guess we can just drop 3/6 of the set, and everything else would just work.

Yes.
