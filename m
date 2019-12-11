Return-Path: <SRS0=sz96=2B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F53C43603
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02B214D8
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 13:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfLKN5n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:57:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:38972 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKN5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 08:57:43 -0500
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1if2Ue-0007uT-GN; Wed, 11 Dec 2019 14:57:32 +0100
Date:   Wed, 11 Dec 2019 14:57:32 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] bpf: switch to offsetofend in BPF_PROG_TEST_RUN
Message-ID: <20191211135732.GC25011@linux.fritz.box>
References: <20191210191933.105321-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210191933.105321-1-sdf@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25660/Wed Dec 11 10:47:07 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 10, 2019 at 11:19:33AM -0800, Stanislav Fomichev wrote:
> Switch existing pattern of "offsetof(..., member) + FIELD_SIZEOF(...,
> member)' to "offsetofend(..., member)" which does exactly what
> we need without all the copy-paste.
> 
> Suggested-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
