Return-Path: <SRS0=GL4p=6L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5ADC54FD0
	for <bpf@archiver.kernel.org>; Mon, 27 Apr 2020 05:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A0F206B6
	for <bpf@archiver.kernel.org>; Mon, 27 Apr 2020 05:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgD0Ffs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:35:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45443 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgD0Ffs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 01:35:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 009A668CEE; Mon, 27 Apr 2020 07:35:45 +0200 (CEST)
Date:   Mon, 27 Apr 2020 07:35:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pass kernel pointers to the sysctl ->proc_handler method v3
Message-ID: <20200427053545.GB15905@lst.de>
References: <20200424064338.538313-1-hch@lst.de> <20200426155100.bcbqnrilk45ugzva@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426155100.bcbqnrilk45ugzva@ast-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 26, 2020 at 08:51:00AM -0700, Alexei Starovoitov wrote:
> The set looks good to me.
> Should I take it via bpf-next tree ?

The first patch is a little unrelated and I think taking it via the
bpf tree sounds fine.   Al volunteered the vfs tree for the actual
sysctl changes, which looks more suitable.
