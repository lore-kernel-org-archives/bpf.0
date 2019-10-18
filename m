Return-Path: <SRS0=UnAx=YL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F09CA9EA9
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 19:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9661D2070B
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 19:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502792AbfJRTLa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:11:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:60194 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502779AbfJRTLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 15:11:30 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iLXeq-0005vL-9v; Fri, 18 Oct 2019 21:11:28 +0200
Date:   Fri, 18 Oct 2019 21:11:27 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf-next PATCH] bpf: libbpf, add kernel version section parsing
 back
Message-ID: <20191018191127.GH26267@pc-63.home>
References: <157140968634.9073.6407090804163937103.stgit@john-XPS-13-9370>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157140968634.9073.6407090804163937103.stgit@john-XPS-13-9370>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25606/Fri Oct 18 10:58:40 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 07:41:26AM -0700, John Fastabend wrote:
> With commit "libbpf: stop enforcing kern_version,..." we removed the
> kernel version section parsing in favor of querying for the kernel
> using uname() and populating the version using the result of the
> query. After this any version sections were simply ignored.
> 
> Unfortunately, the world of kernels is not so friendly. I've found some
> customized kernels where uname() does not match the in kernel version.
> To fix this so programs can load in this environment this patch adds
> back parsing the section and if it exists uses the user specified
> kernel version to override the uname() result. However, keep most the
> kernel uname() discovery bits so users are not required to insert the
> version except in these odd cases.
> 
> Fixes: 5e61f27070292 ("libbpf: stop enforcing kern_version, populate it for users")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Applied, thanks!
