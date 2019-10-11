Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B0EECE58D
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 21:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325612089F
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 21:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfJKVZw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:25:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:49326 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKVZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 17:25:51 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iJ2Q2-00074C-Bv; Fri, 11 Oct 2019 23:25:50 +0200
Date:   Fri, 11 Oct 2019 23:25:50 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com, yhs@fb.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH] xdp: Trivial, fix spelling in function description
Message-ID: <20191011212550.GD21131@pc-63.home>
References: <20191011084303.28418-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011084303.28418-1-anton.ivanov@cambridgegreys.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25599/Fri Oct 11 10:48:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 09:43:03AM +0100, Anton Ivanov wrote:
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!
