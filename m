Return-Path: <SRS0=otRl=75=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D1CC433DF
	for <bpf@archiver.kernel.org>; Tue, 16 Jun 2020 06:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFFF207E8
	for <bpf@archiver.kernel.org>; Tue, 16 Jun 2020 06:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPGyv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:54:51 -0400
Received: from verein.lst.de ([213.95.11.211]:36604 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPGyv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 02:54:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 454BE68AEF; Tue, 16 Jun 2020 08:54:49 +0200 (CEST)
Date:   Tue, 16 Jun 2020 08:54:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf 1/2] bpf: bpf_probe_read_kernel_str() has to return
 amount of data read on success
Message-ID: <20200616065449.GA17288@lst.de>
References: <20200616050432.1902042-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616050432.1902042-1-andriin@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 15, 2020 at 10:04:30PM -0700, Andrii Nakryiko wrote:
> During recent refactorings, bpf_probe_read_kernel_str() started returning 0 on
> success, instead of amount of data successfully read. This majorly breaks
> applications relying on bpf_probe_read_kernel_str() and bpf_probe_read_str()
> and their results. Fix this by returning actual number of bytes read.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 8d92db5c04d1 ("bpf: rework the compat kernel probe handling")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Looks good, thanks for fixing this up:

Reviewed-by: Christoph Hellwig <hch@lst.de>
