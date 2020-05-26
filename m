Return-Path: <SRS0=LuT0=7I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC97C433DF
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 21:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDC820888
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 21:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbgEZVO6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 May 2020 17:14:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:44858 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390435AbgEZVO6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 17:14:58 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdguW-0007iV-Ej; Tue, 26 May 2020 23:14:56 +0200
Date:   Tue, 26 May 2020 23:14:56 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     ast@kernel.org, andriin@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH] libbpf: Install headers as part of make install
Message-ID: <20200526211456.GA3853@pc-9.home>
References: <20200526174612.5447-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526174612.5447-1-nborisov@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25824/Tue May 26 14:27:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 08:46:12PM +0300, Nikolay Borisov wrote:
> Current 'make install' results in only pkg-config and library binaries
> being installed. For consistency also install headers as part of
> "make install"
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks!
