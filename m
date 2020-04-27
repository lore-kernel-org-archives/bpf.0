Return-Path: <SRS0=GL4p=6L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E034C55199
	for <bpf@archiver.kernel.org>; Mon, 27 Apr 2020 05:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5316D206B6
	for <bpf@archiver.kernel.org>; Mon, 27 Apr 2020 05:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgD0Feu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:34:50 -0400
Received: from verein.lst.de ([213.95.11.211]:45434 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgD0Feu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 01:34:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20B2C68CEE; Mon, 27 Apr 2020 07:34:47 +0200 (CEST)
Date:   Mon, 27 Apr 2020 07:34:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 5/5] sysctl: pass kernel pointers to ->proc_handler
Message-ID: <20200427053446.GA15905@lst.de>
References: <20200424064338.538313-1-hch@lst.de> <20200424064338.538313-6-hch@lst.de> <20200424190650.GA72647@rdna-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424190650.GA72647@rdna-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 24, 2020 at 12:06:50PM -0700, Andrey Ignatov wrote:
> > -
> > -#ifdef CONFIG_UCLAMP_TASK
> 
> Decided to skim through the patch one last time to double-check the fix
> from previous iteration and found that this ifdef got lost below.
> 
> > -extern int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> > -				       void __user *buffer, size_t *lenp,
> > -				       loff_t *ppos);
> > -#endif

There is no need for ifdefs around prototypes that aren't used.
