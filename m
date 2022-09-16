Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C25C32771
	for <bpf@archiver.kernel.org>; Fri, 16 Sep 2022 03:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIPDYB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Sep 2022 23:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIPDX7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 23:23:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD8844CB;
        Thu, 15 Sep 2022 20:23:58 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTK9r3LjHzBsNY;
        Fri, 16 Sep 2022 11:21:52 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:23:56 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 11:23:55 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <haoluo@google.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <jolsa@kernel.org>, <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <yanan@huawei.com>, <yhs@fb.com>, <zhudi2@huawei.com>
Subject: Re: [PATCH] libbpf: adjust OPTS_VALID logic, so that it can be used correctly
Date:   Fri, 16 Sep 2022 11:22:47 +0800
Message-ID: <20220916032247.27207-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CA+khW7hS=c4PSo4coBmw+6VReWNhj+4Bnsr+r+mGsG4tCZ8KnQ@mail.gmail.com>
References: <CA+khW7hS=c4PSo4coBmw+6VReWNhj+4Bnsr+r+mGsG4tCZ8KnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 14 Sep 2022 at 6:15:39 PM Hao Luo <haoluo@google.com> wrote:
> Hi Xin,
>
> On Wed, Sep 14, 2022 at 5:35 AM Xin Liu <liuxin350@huawei.com> wrote:
> >
> > We found that function btf_dump__dump_type_data can be called by the user
> > as an api, but in this function, the `opts` parameter may be used as a
> > null pointer, because OPTS_VALID can't properly prevent opts used as null
> > pointers during verification. Therefore, we fix this problem through this
> > modification.
> >
> > This modification has no impact on other places where OPTS_VALID has been
> > used.
>
> I think this is a bug of btf_dump__dump_type_data(), not OPTS_VALID.
> It seems allowing OPTS_VALID to accept NULL is the intended behavior.
>
> >
> [...]
> >

Thank you for your review.
You are right, OPTS_GET should be used to get data from opts and determine if
opts is NULL. Here I'll use OPTS_GET to fix the bug in the v2 version.
