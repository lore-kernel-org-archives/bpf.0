Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C827C4332F
	for <bpf@archiver.kernel.org>; Fri,  2 Dec 2022 02:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLBCN0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Dec 2022 21:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLBCNZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 21:13:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD68B390;
        Thu,  1 Dec 2022 18:13:24 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NNc0R4YFlzmWPt;
        Fri,  2 Dec 2022 10:12:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 10:13:21 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <yanan@huawei.com>, <yhs@fb.com>, <zhangmingyi5@huawei.com>
Subject: Re: [PATCH] Improved usability of the Makefile in libbpf
Date:   Fri, 2 Dec 2022 10:13:23 +0800
Message-ID: <20221202021323.121416-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAEf4BzZ8z9yKwkbQthaNPR9HJDqq77EJwHaEqqwQ3qYjKWTRAQ@mail.gmail.com>
References: <CAEf4BzZ8z9yKwkbQthaNPR9HJDqq77EJwHaEqqwQ3qYjKWTRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 30 Nov 2022 at 00:42:09 AM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> On Mon, Nov 28, 2022 at 11:42 PM Xin Liu <liuxin350@huawei.com> wrote:
> >
> > Current libbpf Makefile does not contain the help command, which
> > is inconvenient to use. A help command is provided to list the
> > commands supported by libbpf make and the functions of the commands.
> ...
> > +       @echo '  make prefix=/path      [install targets] use prefix for installing'
> > +       @echo '                                           into a user defined prefix path'
> 
> 
> I'm a bit hesitant about adding all this. Most of those targets are
> not intended to be used directly, only "all", "clean", and "install"
> are supposed to be used by end-users (maybe also "install_headers").
> And those seems to be pretty typical and straightforward targets.
> 
> I actually didn't even know about `make help`, but I checked perf's
> `make help` and it's way more succinct, let's try modeling it here?
> 
> Also, please use [PATCH bpf-next] (with v2 in between them) for next
> submission to point that this is meant for bpf-next tree.

Thanks to andrii's reply, I'll try to simplify the help command.

The original purpose of adding this is that when I use libbpf, libbpf installs
the file in /usr/local by default, and I didn't read the makefile carefully
before, so I need to open the makefile to read the code. Determine which
parameter is used to define the path that I want to customize. The makefile
of the kernel provides a make help instruction, which is much more convenient
to use.
