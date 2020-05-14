Return-Path: <SRS0=rqwV=64=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB6C433DF
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1237120671
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 16:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgENQ6F (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 May 2020 12:58:05 -0400
Received: from verein.lst.de ([213.95.11.211]:52780 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgENQ6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 12:58:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C0B668BEB; Thu, 14 May 2020 18:58:02 +0200 (CEST)
Date:   Thu, 14 May 2020 18:58:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        torvalds@linux-foundation.org, mhiramat@kernel.org,
        brendan.d.gregg@gmail.com, hch@lst.de, john.fastabend@gmail.com,
        yhs@fb.com
Subject: Re: [PATCH bpf 0/3] Restrict bpf_probe_read{,str}() and
 bpf_trace_printk()'s %s
Message-ID: <20200514165802.GA3059@lst.de>
References: <20200514161607.9212-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514161607.9212-1-daniel@iogearbox.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 14, 2020 at 06:16:04PM +0200, Daniel Borkmann wrote:
> Small set of fixes in order to restrict BPF helpers for tracing which are
> broken on archs with overlapping address ranges as per discussion in [0].
> I've targetted this for -bpf tree so they can be routed as fixes. Thanks!

Does that mean you are targeting them for 5.7?
