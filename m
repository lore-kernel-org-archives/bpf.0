Return-Path: <SRS0=3qi6=AF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B551C433DF
	for <bpf@archiver.kernel.org>; Wed, 24 Jun 2020 12:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F96B2088E
	for <bpf@archiver.kernel.org>; Wed, 24 Jun 2020 12:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbgFXMRt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:17:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41092 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbgFXMRs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 08:17:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jo4LY-00030v-LA; Wed, 24 Jun 2020 06:17:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jo4LX-0000Hb-QF; Wed, 24 Jun 2020 06:17:44 -0600
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
References: <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        <87bllngirv.fsf@x220.int.ebiederm.org>
        <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
        <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
        <87ftaxd7ky.fsf@x220.int.ebiederm.org>
        <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
        <87h7v1pskt.fsf@x220.int.ebiederm.org>
        <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
        <87h7v1mx4z.fsf@x220.int.ebiederm.org>
        <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 24 Jun 2020 07:13:19 -0500
In-Reply-To: <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Tue, 23 Jun 2020 12:40:23 -0700")
Message-ID: <878sgck6g0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jo4LX-0000Hb-QF;;;mid=<878sgck6g0.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18AWL6e2YVEkkYGAkiCdIEi6OTnVRVCYkY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 23, 2020 at 01:53:48PM -0500, Eric W. Biederman wrote:

> There is no refcnt bug. It was a user error on tomoyo side.
> fork_blob() works as expected.

Nope.  I have independently confirmed it myself.

fork_usermode_blob holds a reference and puts that reference.  An
additional reference is needed for execve to hold and put.

Now can you write some patches to make that obvious please?

Eric
