Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D0C54EE9
	for <bpf@archiver.kernel.org>; Thu,  8 Sep 2022 10:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIHKIe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Sep 2022 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIHKI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 06:08:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A15D99E1;
        Thu,  8 Sep 2022 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UOhmWhfh6ez2R/EXW1Q3Fuye0q5XANxmTIodoT9VFbo=; b=qFk19ChumB/kekbuPKhI78lIGm
        3G5Y0dtk1WBtw9ftlUVMXmvv2kGtiSgXc6fgCLOd3a4LeV4nOEzBTwjV70C7LauC9XAifTDhqO3IT
        rJqy7gAeZFK34IoGRjic3aBAJ4RVZS/2I/1T/vGLvAD3ridV6UkxgBHEJ+yIXuFbRBCXYsW2B7hHj
        Qwuh8dN0SmPHMN9IKixHInZOTgwYlv4sBGXS83OkSeKrf0i14zB2T/6RnySLP8BtRq4b+Fbtd8nrI
        B1yvFjZSN0msFTs6CpGVTvhZ7DoH0zut9+HX0ec5PigCcvZcC0q1zyDXu8VcG2rDKUC+fgpD8dtIc
        DQPmiCnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWESM-00CFhk-8k; Thu, 08 Sep 2022 10:08:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E2AA3006A4;
        Thu,  8 Sep 2022 12:08:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 461AF207ABF68; Thu,  8 Sep 2022 12:08:19 +0200 (CEST)
Date:   Thu, 8 Sep 2022 12:08:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/kprobes: Fix kprobes instruction boudary
 check with CONFIG_RETHUNK
Message-ID: <Yxm/EyW1upzPUZuH@hirez.programming.kicks-ass.net>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
 <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 11:30:41AM +0200, Peter Zijlstra wrote:
> Once that lands the rules are:
> 
>  0-5 INT3 after RET, !CONFIG_RETHUNK && !CONFIG_SLS: 0
>                      CONFIG_SLS: 1
> 		     CONFIG_RETHUNK: 4-5 depending on compiler version
> 
>  0-1 INT3 after RET: !CONFIG_SLS: 0
> 		     CONFIG_SLS: 0-1 depending on compiler version
> 
> Now, given we know the compiler version at build time, this could be
> determined and used in kprobes, but meh.

Oh also, for giggles, we have a number of sites that have ret;int3
independent of CONFIG_SLS because that was easier than figuring out what
all should be done.
