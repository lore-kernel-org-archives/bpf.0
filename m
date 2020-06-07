Return-Path: <SRS0=eCQr=7U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE3BC433DF
	for <bpf@archiver.kernel.org>; Sun,  7 Jun 2020 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A42E20723
	for <bpf@archiver.kernel.org>; Sun,  7 Jun 2020 12:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFGMAt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 7 Jun 2020 08:00:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37250 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFGMAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Jun 2020 08:00:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhtyl-0001dw-Km; Sun, 07 Jun 2020 06:00:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhtyk-0006iC-Gc; Sun, 07 Jun 2020 06:00:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606201956.rvfanoqkevjcptfl@ast-mbp>
        <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
        <20200607014935.vhd3scr4qmawq7no@ast-mbp>
        <87mu5f8ljf.fsf@x220.int.ebiederm.org>
Date:   Sun, 07 Jun 2020 06:56:38 -0500
In-Reply-To: <87mu5f8ljf.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sun, 07 Jun 2020 00:58:12 -0500")
Message-ID: <87pnab6qdl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jhtyk-0006iC-Gc;;;mid=<87pnab6qdl.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vo+QpO0AQ5tbbwAnnCvshI6m6PQdNB1U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I have sympathy with your efforts but since the code is currently dead,
> and in need of work.  I will write a good version of removing
> CONFIG_BPFILTER_UMH on top of -rc1, leaving CONFIG_BPFILTER.

Of course when I just limit my code removal to code that depends upon
the user mode helper all that is left is a Kconfig entry and
include/uapi/linux/bpfilter.h.

I don't get it.

I also noticed that the type of do_exeve_file is wrong. envp and argv
are not "void *", they should be "const char __user *const __user *__argv".

Eric
