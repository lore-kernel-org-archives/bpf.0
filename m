Return-Path: <SRS0=9mof=BI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDEAC433DF
	for <bpf@archiver.kernel.org>; Wed, 29 Jul 2020 20:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AF02074B
	for <bpf@archiver.kernel.org>; Wed, 29 Jul 2020 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2URs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG2URs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 16:17:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A043C061794;
        Wed, 29 Jul 2020 13:17:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0sWC-005Bbe-4V; Wed, 29 Jul 2020 20:17:40 +0000
Date:   Wed, 29 Jul 2020 21:17:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH v8 bpf-next 09/13] bpf: Add d_path helper
Message-ID: <20200729201740.GB1233513@ZenIV.linux.org.uk>
References: <20200722211223.1055107-1-jolsa@kernel.org>
 <20200722211223.1055107-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722211223.1055107-10-jolsa@kernel.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 22, 2020 at 11:12:19PM +0200, Jiri Olsa wrote:

> +BTF_SET_START(btf_whitelist_d_path)
> +BTF_ID(func, vfs_truncate)
> +BTF_ID(func, vfs_fallocate)
> +BTF_ID(func, dentry_open)
> +BTF_ID(func, vfs_getattr)
> +BTF_ID(func, filp_close)
> +BTF_SET_END(btf_whitelist_d_path)

While we are at it, I hope you realize that the names of kernel function
are subject to change at zero notice.  If some script breaks since
we give e.g. filp_close a something less revolting name, it's Not My
Problem(tm)...
