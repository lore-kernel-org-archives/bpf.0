Return-Path: <SRS0=UnAx=YL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1DCA9EAB
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1692082C
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443294AbfJRTK1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:10:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:59894 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443280AbfJRTK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 15:10:26 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iLXdl-0005qc-FQ; Fri, 18 Oct 2019 21:10:21 +0200
Date:   Fri, 18 Oct 2019 21:10:21 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: fix bpf_attr.attach_btf_id check
Message-ID: <20191018191021.GF26267@pc-63.home>
References: <20191018060933.2950231-1-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018060933.2950231-1-ast@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25606/Fri Oct 18 10:58:40 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 17, 2019 at 11:09:33PM -0700, Alexei Starovoitov wrote:
> Only raw_tracepoint program type can have bpf_attr.attach_btf_id >= 0.
> Make sure to reject other program types that accidentally set it to non-zero.
> 
> Fixes: ccfe29eb29c2 ("bpf: Add attach_btf_id attribute to program load")
> Reported-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks!
