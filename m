Return-Path: <SRS0=X79y=YB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB24C4360C
	for <bpf@archiver.kernel.org>; Tue,  8 Oct 2019 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2EB21721
	for <bpf@archiver.kernel.org>; Tue,  8 Oct 2019 22:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfJHWDF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:03:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:58380 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Oct 2019 18:03:05 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iHxZP-0004h4-Kf; Wed, 09 Oct 2019 00:03:03 +0200
Date:   Wed, 9 Oct 2019 00:03:03 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Jiri Benc <jbenc@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 0/2] selftests/bpf: fix false failures
Message-ID: <20191008220303.GA1428@pc-63.home>
References: <cover.1570539863.git.jbenc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570539863.git.jbenc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25596/Tue Oct  8 10:33:54 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 08, 2019 at 03:10:43PM +0200, Jiri Benc wrote:
> The test_flow_dissector and test_lwt_ip_encap selftests were failing for me.
> It was caused by the tests not being enough system/distro independent.
> 
> Jiri Benc (2):
>   selftests/bpf: set rp_filter in test_flow_dissector
>   selftests/bpf: more compatible nc options in test_lwt_ip_encap
> 
>  tools/testing/selftests/bpf/test_flow_dissector.sh | 3 +++
>  tools/testing/selftests/bpf/test_lwt_ip_encap.sh   | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

Applied, thanks!
