Return-Path: <SRS0=eCQr=7U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E35CC433E0
	for <bpf@archiver.kernel.org>; Sun,  7 Jun 2020 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5886B206F6
	for <bpf@archiver.kernel.org>; Sun,  7 Jun 2020 15:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFGPzw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:55:52 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47446 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgFGPzw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Jun 2020 11:55:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhxeF-00011L-FU; Sun, 07 Jun 2020 09:55:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhxeA-00082p-MQ; Sun, 07 Jun 2020 09:55:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        akpm@linux-foundation.org, ast@kernel.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk, bpf <bpf@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606204326.GQ19604@bombadil.infradead.org>
Date:   Sun, 07 Jun 2020 10:51:39 -0500
In-Reply-To: <20200606204326.GQ19604@bombadil.infradead.org> (Matthew Wilcox's
        message of "Sat, 6 Jun 2020 13:43:26 -0700")
Message-ID: <87k10i7u2c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jhxeA-00082p-MQ;;;mid=<87k10i7u2c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AFHWWMP4Agup0r0xRemu29zCl6v/Lm6Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] net/bpfilter:  Remove this broken and apparently unmantained
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Jun 06, 2020 at 02:20:36PM -0500, Eric W. Biederman wrote:
>> @@ -39,7 +37,6 @@ static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
>>  static DEFINE_SPINLOCK(umh_sysctl_lock);
>>  static DECLARE_RWSEM(umhelper_sem);
>>  static LIST_HEAD(umh_list);
>> -static DEFINE_MUTEX(umh_list_lock);
>
> You can delete the umh_list too; you've deleted all its users.

Good catch, thank you.

Eric

