Return-Path: <SRS0=sz96=2B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EAAC43603
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 13:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5CC214D8
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 13:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfLKN5G (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:57:06 -0500
Received: from www62.your-server.de ([213.133.104.62]:38694 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKN5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 08:57:06 -0500
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1if2UB-0007t5-SH; Wed, 11 Dec 2019 14:57:03 +0100
Date:   Wed, 11 Dec 2019 14:57:03 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf] libbpf: Bump libpf current version to v0.0.7
Message-ID: <20191211135703.GB25011@linux.fritz.box>
References: <20191209224022.3544519-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209224022.3544519-1-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25660/Wed Dec 11 10:47:07 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 09, 2019 at 02:40:22PM -0800, Andrii Nakryiko wrote:
> New development cycles starts, bump to v0.0.7 proactively.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Subject says 'bpf', but I applied this to bpf-next, thanks!
