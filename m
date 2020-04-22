Return-Path: <SRS0=w90l=6G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A66C5518C
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827542082E
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDVRW6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:22:58 -0400
Received: from verein.lst.de ([213.95.11.211]:53789 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDVRW6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Apr 2020 13:22:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7BAAA68C4E; Wed, 22 Apr 2020 19:22:54 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:22:54 +0200
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
Message-ID: <20200422172254.GA30102@lst.de>
References: <20200421171539.288622-1-hch@lst.de> <20200421171539.288622-6-hch@lst.de> <20200421192330.GA60879@rdna-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421192330.GA60879@rdna-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 21, 2020 at 12:23:30PM -0700, Andrey Ignatov wrote:
> >  	if (ret == 1 && ctx.new_updated) {
> > -		*new_buf = ctx.new_val;
> > +		*buf = ctx.new_val;
> 
> Original value of *buf should be freed before overriding it here
> otherwise it's lost/leaked unless I missed something.
> 
> Other than this BPF part of this patch looks good to me. Feel free to
> add my Ack on the next iteration with this fix.

Thanks, fixed.

Can you also comment on "bpf-cgroup: remove unused exports" ?
