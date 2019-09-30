Return-Path: <SRS0=vQPo=XZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAFCC32792
	for <bpf@archiver.kernel.org>; Mon, 30 Sep 2019 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9867222500
	for <bpf@archiver.kernel.org>; Mon, 30 Sep 2019 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfI3Uvw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:51:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:35760 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfI3Uvw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 16:51:52 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iF2e6-000356-Fc; Mon, 30 Sep 2019 22:51:50 +0200
Received: from [178.197.248.15] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iF2e6-000CNw-AN; Mon, 30 Sep 2019 22:51:50 +0200
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@fb.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf-next is OPEN
Message-ID: <dada9a02-13e8-2f24-539d-9b48917e71f5@iogearbox.net>
Date:   Mon, 30 Sep 2019 22:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25588/Mon Sep 30 10:25:56 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v5.4-rc1 tag is just out and merge window over, therefore bpf-next back in business.

Thanks,
Daniel
