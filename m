Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4187AC433EF
	for <bpf@archiver.kernel.org>; Thu, 17 Mar 2022 19:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiCQTiL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCQTiK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 15:38:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C89622B6D4;
        Thu, 17 Mar 2022 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zya69H4T73q6+dj6a2oty/2yQG0Z1p5MEjn65dgAoAo=; b=nR5h0znrFXAEivgsTPEPKLrACx
        +lDItqrslGaapsjlNjLsfewEkLWlBp+nl+C7ItjmaTzKhbEqzodg+aFrv3qf1JpNSTwm9cydLfLX8
        VVvIT1WJXtI4TS3LeuM06LZ90y6l+nl+K4BgoEHuu9ntVBwPuMYsKCYcYqqekMvjn7pMokzgdeILY
        g2ZkwCvm5R8W66pcJemJrhylC1nEPwregLgnNxUxL6ecIWMmQoX71dpJXnDIPsuOeE76XLMxiH/3y
        S8OxR2rxvyZW9Jpe968bvh5rQxLNoZlPVhRtSebaI+wkzT2szqM0rDwsxw60wTNPTQjDt58CErB5Y
        nfEucpbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUvv4-007GDz-7R; Thu, 17 Mar 2022 19:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B9163001EA;
        Thu, 17 Mar 2022 20:36:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4E4E30C650C4; Thu, 17 Mar 2022 20:36:18 +0100 (CET)
Date:   Thu, 17 Mar 2022 20:36:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YjONspga4Ahoqxx4@hirez.programming.kicks-ass.net>
References: <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
 <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
 <CAK7LNASOjsSRixifxxUBKiFdR_Q_pSoBu98zYU_u_z1rtUD=zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASOjsSRixifxxUBKiFdR_Q_pSoBu98zYU_u_z1rtUD=zA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 01:26:25AM +0900, Masahiro Yamada wrote:
> Help?
> 
> I had never noticed this thread before because
> you did not CC me or kbuild ML.

I thought I did.. the copy in my sent folder has you on Cc. Sorry if it
went MIA. I'll go look at the patch.
