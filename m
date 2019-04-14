Return-Path: <SRS0=hTM0=SQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B69C10F13
	for <bpf@archiver.kernel.org>; Sun, 14 Apr 2019 23:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2530720675
	for <bpf@archiver.kernel.org>; Sun, 14 Apr 2019 23:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfDNX3n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:29:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfDNX3n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Apr 2019 19:29:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44FECAEEA;
        Sun, 14 Apr 2019 23:29:42 +0000 (UTC)
Date:   Mon, 15 Apr 2019 08:29:35 +0900
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpftool: Use print_entry_error() in case
 of ENOENT when dumping
Message-ID: <20190414232935.GA8390@f1>
References: <20190411082700.26888-1-bpoirier@suse.com>
 <20190412030322.15494-1-bpoirier@suse.com>
 <44958814-3145-717f-366e-ecc52f2145b9@netronome.com>
 <20190412224924.GA21826@f1>
 <20190412165301.1c4b7390@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412165301.1c4b7390@cakuba.netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019/04/12 16:53, Jakub Kicinski wrote:
> On Sat, 13 Apr 2019 07:49:24 +0900, Benjamin Poirier wrote:
> > To be honest, I don't think the formatting in those print_entry_*
> > functions should change according to the length in any case. I think the
> > key and value for each entry should always be on the same line for ease
> > of grepping. A followup patch maybe...
> 
> No, no, please never grep bpftool output.  We have JSON output,
> please use JQ: http://manpages.ubuntu.com/manpages/bionic/man1/jq.1.html
> 

Fair enough. I didn't know about jq, thanks.
