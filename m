Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D0C433F5
	for <bpf@archiver.kernel.org>; Fri, 25 Mar 2022 10:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiCYKOB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359225AbiCYKNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 06:13:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6B90CFA;
        Fri, 25 Mar 2022 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zEPz4EG32WZWr1D4Hxy43ErgP+Uz8rs1AK6YHY3hNpI=; b=RYx+Boe0DzH6PKCl4K0ryueg2e
        G5iapHg1llSxGJUj8HEA1SFIZLlbi6sIi8TWTZfnpglYbccB0UsBolJVL9PHYoQDOS76UjVjb1dRt
        Lys7q6FXefkSMFcL7VlPbK+NfzQ0sSsknald1g0FIM1oGcdBAX/X8w2Cg/hZnlvy1OsX0ph9viP8K
        009fbTW3QQU+glCbwkcf96hF4paPeBvOZuVFD//aOdOAup2K/24BgfTlBNQ0I5TkxlyH+rWn+1H8i
        Y6f1iZHSPLfxkJIwBPUyXqSgESorN3I4pgF7h/fShydNVxgEXvo2Gx5AS2irfmpOBOOupJjMOxej7
        McEeJAYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXguW-00EG2y-I2; Fri, 25 Mar 2022 10:11:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B34E99862A6; Fri, 25 Mar 2022 11:11:10 +0100 (CET)
Date:   Fri, 25 Mar 2022 11:11:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] rethook: kprobes: x86: Replace kretprobe
 with rethook on x86
Message-ID: <20220325101110.GN8939@worktop.programming.kicks-ass.net>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
 <164818254148.2252200.5054811796192907193.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164818254148.2252200.5054811796192907193.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 25, 2022 at 01:29:01PM +0900, Masami Hiramatsu wrote:
> +	/* Push a fake return address to tell the unwinder it's a kretprobe. */
> +	/* Push a fake return address to tell the unwinder it's a kretprobe. */

s/kretprobe/rethook/ went missing
