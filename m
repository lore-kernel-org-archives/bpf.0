Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EFEC433DF
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53E32072E
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgFWSIc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:08:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41350 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 14:08:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnnLP-0004f4-6l; Tue, 23 Jun 2020 12:08:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnnLO-0004Sd-82; Tue, 23 Jun 2020 12:08:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
        <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
        <87r1uo2ejt.fsf@x220.int.ebiederm.org>
        <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
        <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        <87bllngirv.fsf@x220.int.ebiederm.org>
        <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
        <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
        <87ftaxd7ky.fsf@x220.int.ebiederm.org>
        <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
Date:   Tue, 23 Jun 2020 13:04:02 -0500
In-Reply-To: <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Mon, 15 Jun 2020 18:55:52 -0700")
Message-ID: <87h7v1pskt.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnnLO-0004Sd-82;;;mid=<87h7v1pskt.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/D9R08/Ve1p34FW4iCYwH1q+46Ss+IpyY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Sigh.  I was busy last week so I left reading this until now in the
hopes I would see something reasonable.

What I see is rejecting of everything that is said to you.

What I do not see are patches fixing issues.  I will await patches.

Eric


