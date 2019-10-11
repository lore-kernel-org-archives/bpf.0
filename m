Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C812CECE58D
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9605B214E0
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 21:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfJKV0g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:26:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:49500 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfJKV0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 17:26:36 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iJ2Qh-00078r-Oh; Fri, 11 Oct 2019 23:26:31 +0200
Date:   Fri, 11 Oct 2019 23:26:31 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: generate more efficient BPF_CORE_READ
 code
Message-ID: <20191011212631.GE21131@pc-63.home>
References: <20191011023847.275936-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011023847.275936-1-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25599/Fri Oct 11 10:48:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 10, 2019 at 07:38:47PM -0700, Andrii Nakryiko wrote:
> Existing BPF_CORE_READ() macro generates slightly suboptimal code. If
> there are intermediate pointers to be read, initial source pointer is
> going to be assigned into a temporary variable and then temporary
> variable is going to be uniformly used as a "source" pointer for all
> intermediate pointer reads. Schematically (ignoring all the type casts),
> BPF_CORE_READ(s, a, b, c) is expanded into:
> ({
> 	const void *__t = src;
> 	bpf_probe_read(&__t, sizeof(*__t), &__t->a);
> 	bpf_probe_read(&__t, sizeof(*__t), &__t->b);
> 
> 	typeof(s->a->b->c) __r;
> 	bpf_probe_read(&__r, sizeof(*__r), &__t->c);
> })
> 
> This initial `__t = src` makes calls more uniform, but causes slightly
> less optimal register usage sometimes when compiled with Clang. This can
> cascase into, e.g., more register spills.
> 
> This patch fixes this issue by generating more optimal sequence:
> ({
> 	const void *__t;
> 	bpf_probe_read(&__t, sizeof(*__t), &src->a); /* <-- src here */
> 	bpf_probe_read(&__t, sizeof(*__t), &__t->b);
> 
> 	typeof(s->a->b->c) __r;
> 	bpf_probe_read(&__r, sizeof(*__r), &__t->c);
> })
> 
> Fixes: 7db3822ab991 ("libbpf: Add BPF_CORE_READ/BPF_CORE_READ_INTO helpers")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
