Return-Path: <SRS0=UnAx=YL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410BCA9EA9
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1462054F
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 20:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfJRUfo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:35:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:47738 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJRUfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 16:35:44 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iLYyM-00045j-Oq; Fri, 18 Oct 2019 22:35:42 +0200
Date:   Fri, 18 Oct 2019 22:35:42 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Jiri Benc <jbenc@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Peter Oskolkov <posk@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: More compatible nc options in
 test_tc_edt
Message-ID: <20191018203542.GJ26267@pc-63.home>
References: <f5bf07dccd8b552a76c84d49e80b86c5aa071122.1571400024.git.jbenc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5bf07dccd8b552a76c84d49e80b86c5aa071122.1571400024.git.jbenc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25606/Fri Oct 18 10:58:40 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 02:00:42PM +0200, Jiri Benc wrote:
> Out of the three nc implementations widely in use, at least two (BSD netcat
> and nmap-ncat) do not support -l combined with -s. Modify the nc invocation
> to be accepted by all of them.
> 
> Fixes: 7df5e3db8f63 ("selftests: bpf: tc-bpf flow shaping with EDT")
> Cc: Peter Oskolkov <posk@google.com>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>

Applied, thanks!
